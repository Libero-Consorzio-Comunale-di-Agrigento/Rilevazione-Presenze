unit WA051UTimbOrig;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompListbox, meIWComboBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, DB, DBClient, MConnect, meIWRadioGroup, IWCompCheckbox, meIWCheckBox, meIWImageFile, medpIWImageButton,
  A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, A051UTimbOrigMW, A000UCostanti, ActiveX;

type
  TWA051FTimbOrig = class(TWR100FBase)
    DCOMConnection: TDCOMConnection;
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    lblMese: TmeIWLabel;
    cmbMese: TmeIWComboBox;
    edtDa: TmeIWEdit;
    lblDa: TmeIWLabel;
    edtA: TmeIWEdit;
    lblA: TmeIWLabel;
    chkSaltoPagina: TmeIWCheckBox;
    cmbCampoRaggr: TmeIWComboBox;
    lblCampo: TmeIWLabel;
    rgpTimbrature: TmeIWRadioGroup;
    lblTimbrature: TmeIWLabel;
    btnGeneraPDF: TmedpIWImageButton;
    btnCambioData: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnCambioDataClick(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
  private
    A051MW: TA051FTimbOrigMW;
    DataI,DataF:TDateTime;
    GiorniMeseOld:Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaborazioneServer; override;
    function CreateJSonString: String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA051FTimbOrig.IWAppFormCreate(Sender: TObject);
var AA,MM,GG : Word;
begin
  inherited;
  AttivaGestioneC700;
  A051MW:=TA051FTimbOrigMW.Create(Self);
  DecodeDate(Parametri.DataLavoro,AA,MM,GG);
  CmBMese.ItemIndex:=MM-1;
  edtAnno.Text:=IntToStr(AA);
  edtDa.Text:='01';
  edtA.Text:=IntToStr(R180GiorniMese(Parametri.DataLavoro));
  GiorniMeseOld:=R180GiorniMese(Parametri.DataLavoro);
  with A051MW.selI010 do
    while not Eof do
    begin
      cmbCampoRaggr.Items.add(FieldByName('NOME_LOGICO').AsString +'=' +
                                  FieldByName('NOME_CAMPO').AsString);
      Next;
    end;
  GetParametriFunzione;
end;

procedure TWA051FTimbOrig.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA051FTimbOrig.btnCambioDataClick(Sender: TObject);
var DataApp:TDateTime;
    GgDa,GgA,GiorniMeseNew:Integer;
begin
  try
    StrToInt(edtAnno.Text);
  except
    edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro));
  end;
  try
    DataApp:=EncodeDate(StrToInt(edtAnno.Text),cmbMese.ItemIndex + 1,1);
  except
    exit;
  end;
  GiorniMeseNew:=R180GiorniMese(DataApp);
  GgDa:=StrToIntDef(edtDa.Text,1);
  if GgDa < 1 then
    GgDa:=1
  else if GgDa > GiorniMeseNew then
    GgDa:=GiorniMeseNew;
  GgA:=StrToIntDef(edtA.Text,1);
  if GgA < 1 then
    GgA:=1
  else if GgA > GiorniMeseNew then
    GgA:=GiorniMeseNew;
  if (GgDa = 1) and (GgA = GiorniMeseOld) then
    GgA:=GiorniMeseNew;
  edtDa.Text:=IntToStr(GgDa);
  edtA.Text:=IntToStr(GgA);
  DataI:=EncodeDate(StrToInt(edtAnno.Text),cmbMese.ItemIndex + 1,GgDa);
  DataF:=EncodeDate(StrToInt(edtAnno.Text),cmbMese.ItemIndex + 1,GgA);
  grdC700.WC700FM.C700DataDal:=DataI;
  grdC700.WC700FM.C700DataLavoro:=DataF;
  GiorniMeseOld:=GiorniMeseNew;
end;

procedure TWA051FTimbOrig.btnGeneraPDFClick(Sender: TObject);
begin
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA051FTimbOrig.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA051(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWA051FTimbOrig.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtAnno,json);
    C190Comp2JsonString(cmbMese,json);
    C190Comp2JsonString(edtDa,json);
    C190Comp2JsonString(edtA,json);
    C190Comp2JsonString(chkSaltoPagina,json);
    C190Comp2JsonString(rgpTimbrature,json);
    C190Comp2JsonString(cmbCampoRaggr,json,'dcmbCampoRaggr');
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA051FTimbOrig.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA051FTimbOrig.GetParametriFunzione;
{Leggo i parametri della form}
begin
  cmbCampoRaggr.ItemIndex:=cmbCampoRaggr.Items.IndexOf(C004DM.GetParametro('RAGGRUPPAMENTO','')+'='+VarToStr(A051MW.selI010.Lookup('NOME_LOGICO',C004DM.GetParametro('RAGGRUPPAMENTO',''),'NOME_CAMPO')));
  chkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
end;

procedure TWA051FTimbOrig.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('RAGGRUPPAMENTO',cmbCampoRaggr.Text);
  if chkSaltoPagina.Checked then
    C004DM.PutParametro('SALTOPAGINA','S')
  else
    C004DM.PutParametro('SALTOPAGINA','N');
  try SessioneOracle.Commit; except end;
end;

end.
