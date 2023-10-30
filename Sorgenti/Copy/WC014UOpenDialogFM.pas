unit WC014UOpenDialogFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, WR010UBase,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox, meIWComboBox, IWCompExtCtrls, meIWImageFile,
  medpIWImageButton, IWCompLabel, meIWLabel, meIWListbox, C190FunzioniGeneraliWeb, C180FunzioniGenerali, IOUtils, Types, IWCompEdit, meIWEdit;

type
  TMyProc = procedure(pCert: string) of object;  //Notifica di chiusura form

  TWC014FOpenDialogFM = class(TWR200FBaseFM)
    lstFile: TmeIWListbox;
    lblFolder: TmeIWLabel;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    lblFile: TmeIWLabel;
    lstFolder: TmeIWListbox;
    lblFileC: TmeIWLabel;
    edtFileC: TmeIWEdit;
    procedure btnConfermaClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure lstFolderDblClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lstFileDblClick(Sender: TObject);

  private
    { Private declarations }
    procedure lstFileAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure GetFiles(sSearchPath: string; slt: TStringList);
    procedure GetSubDirs(sSearchPath: string; slt: TStringList);
  public
    { Public declarations }
    NotificaChiusura: TMyProc;
    Modalita: Char; //C = Cartelle; F = Files
    FiltroFile: string;         //Estensione dei file visualizzati default: *
    PercorsoBase: string;       //Radice oltre cui non si può navigare
    PercorsoCorrente: string;
    Titolo: string;
    function AdeguaJavaScript(pJavaScriptText: string): string;
    procedure Apri;
    procedure Visualizza;
  end;

const
  CartellaSuperiore = '...';

implementation

{$R *.dfm}

procedure TWC014FOpenDialogFM.GetFiles(sSearchPath: string; slt: TStringList);
var
  i: integer;
  Files : TStringDynArray;
begin
  slt.Clear;
  Files:=TDirectory.GetFiles(sSearchPath,'*.' + FiltroFile);
  for i := 0 to Length(Files)-1 do
    slt.Add(ExtractFileName(ExcludeTrailingPathDelimiter(Files[i])) + '=' + Files[i])
end;

procedure TWC014FOpenDialogFM.GetSubDirs(sSearchPath: string; slt: TStringList);
var
  i: integer;
  Folders : TStringDynArray;
begin
  slt.Clear;
  if UpperCase(sSearchPath) <> UpperCase(PercorsoBase) then
    slt.Add(CartellaSuperiore + '=' + CartellaSuperiore);

  Folders:=TDirectory.GetDirectories(sSearchPath);
  for i := 0 to Length(Folders)-1 do
    slt.Add(ExtractFileName(ExcludeTrailingPathDelimiter(Folders[i])) + '=' + Folders[i]);
end;

procedure TWC014FOpenDialogFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  Modalita:='F';
  FiltroFile:='*';
end;

function TWC014FOpenDialogFM.AdeguaJavaScript(pJavaScriptText: string): string;
//Adegua il Javascript per visualizzare il frame nella modalità impostata
var strInsert, strC, strF: string;
    pos: integer;
    strControllo: string;
begin
  //Blocchi di codice da inserire
  strInsert:='$(''#LSTFOLDERWC014FOPENDIALOGFM'').attr("style", "height:8em;");'
           + '$(''#LSTFILEWC014FOPENDIALOGFM'').attr("style", "height:8em;");';

  strC:='$(''#C014Naviga'').attr("style", "height:29.5em;");'
      + '$(''#C014Conferma'').attr("style", "position:absolute;top: 27em; left: 18em; width: 8em;");'
      + '$(''#C014Annulla'').attr("style", "position:absolute;top: 27em; left: 27em; width: 8em;");';

  strF:='$(''#C014Naviga'').attr("style", "height:25.5em;");'
      + '$(''#C014Conferma'').attr("style", "position:absolute;top: 23em; left: 18em; width: 8em;");'
      + '$(''#C014Annulla'').attr("style", "position:absolute;top: 23em; left: 27em; width: 8em;");';

  //Pulizia eventuale codice inserito in precedenza
  pJavaScriptText:=StringReplace(pJavaScriptText, strInsert, '', [rfReplaceAll, rfIgnoreCase]);
  pJavaScriptText:=StringReplace(pJavaScriptText, strC, '', [rfReplaceAll, rfIgnoreCase]);
  pJavaScriptText:=StringReplace(pJavaScriptText, strF, '', [rfReplaceAll, rfIgnoreCase]);

  //Preparazione codice corretto
  if Modalita='C' then
    strInsert:=strInsert + strC
  else if Modalita='F' then
    strInsert:=strInsert + strF;

  strControllo:=UpperCase('$(document).ready(function(){');
  pos:=ansipos(strControllo, UpperCase(pJavaScriptText));
  if pos > 0 then
    insert(strInsert, pJavaScriptText, pos + strControllo.Length)
  else
    pJavaScriptText:='$(document).ready(function(){' + strInsert + '});';

  Result:=pJavaScriptText;
end;

procedure TWC014FOpenDialogFM.Apri;
begin

  if PercorsoCorrente = '' then
    PercorsoCorrente:=PercorsoBase
  else if PercorsoBase = '' then
    PercorsoBase:=PercorsoCorrente;

  edtFileC.Text:=R180GetFileName(PercorsoCorrente);
  PercorsoBase:=R180GetFilePath(PercorsoBase) + '\';
  PercorsoCorrente:=R180GetFilePath(PercorsoCorrente) + '\';

  GetSubDirs(PercorsoCorrente, lstFolder.Items);
  GetFiles(PercorsoCorrente, lstFile.Items);

  lblFileC.Visible:=Modalita = 'C';
  edtFileC.Visible:=Modalita = 'C';
  if Modalita='C' then
    lstFile.OnAsyncClick:=lstFileAsyncClick;
end;

procedure TWC014FOpenDialogFM.btnAnnullaClick(Sender: TObject);
begin
  Free;
end;

procedure TWC014FOpenDialogFM.btnConfermaClick(Sender: TObject);
begin
  if Assigned(NotificaChiusura) then
    if Modalita = 'F' then
      NotificaChiusura(lstFile.SelectedValue)
    else
      NotificaChiusura(PercorsoCorrente + edtFileC.Text);
  Free;
end;

procedure TWC014FOpenDialogFM.lstFileAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if Modalita = 'C' then
    edtFileC.Text:=lstFile.SelectedText
end;

procedure TWC014FOpenDialogFM.lstFileDblClick(Sender: TObject);
begin
  inherited;
  if lstFile.SelectedValue = '' then
    exit;
  if Modalita = 'C' then
    edtFileC.Text:=lstFile.SelectedText;
  btnConfermaClick(nil);
end;

procedure TWC014FOpenDialogFM.lstFolderDblClick(Sender: TObject);
begin
  inherited;
  if lstFolder.SelectedValue = '' then
    exit;
  if lstFolder.SelectedValue <> CartellaSuperiore then
    PercorsoCorrente:=lstFolder.SelectedValue
  else
    PercorsoCorrente:=ExtractFilePath(ExcludeTrailingPathDelimiter(PercorsoCorrente));

  GetSubDirs(PercorsoCorrente, lstFolder.Items);
  GetFiles(PercorsoCorrente, lstFile.Items);
end;

procedure TWC014FOpenDialogFM.Visualizza;
begin
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,440,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);
end;

end.
