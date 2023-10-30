unit WA154UGestioneDocumentale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, StrUtils, Data.DB,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData, Oracle, IWCompEdit, meIWEdit,
  WR102UGestTabella, A000UInterfaccia, A000UCostanti, A000UMessaggi, C190FunzioniGeneraliWeb, medpIWMessageDlg;

type
  TWA154FGestioneDocumentale = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);override;
  private
    procedure PopolaCFFamiliari;
    procedure ResultActConfermaExecute(Sender: TObject; R: TmeIWModalResult; KI: String);
  protected
    procedure ImpostazioniWC700; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure AggiornaAccessoEScarica(const PFilePath: String);
  end;

implementation

uses WA154UGestioneDocumentaleDM, WA154UGestioneDocumentaleBrowseFM, WA154UGestioneDocumentaleDettFM;

{$R *.dfm}

procedure TWA154FGestioneDocumentale.ImpostazioniWC700;
begin
  inherited;
  //
end;

procedure TWA154FGestioneDocumentale.WC700CambioProgressivo(Sender: TObject);
begin
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.FiltraFamiliari(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  PopolaCFFamiliari;
  inherited;
  (WDettaglioFM as TWA154FGestioneDocumentaleDettFM).DecodeCFFamiliari(WR302DM.selTabella.FieldByName('CF_FAMILIARE').AsString);
end;

function TWA154FGestioneDocumentale.InizializzaAccesso: Boolean;
var
  LProg, LId: Integer;
begin
  // lettura parametri

  // progressivo di riferimento
  LProg:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if LProg > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=LProg;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  // id documento
  LId:=StrToIntDef(GetParam('ID'),0);
  if LId > 0 then
  begin
    WR302DM.selTabella.SearchRecord('ID',LId,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end;

  AggiornaRecord;
  Result:=True;
end;

procedure TWA154FGestioneDocumentale.IWAppFormCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;

  inherited;

  WR302DM:=TWA154FGestioneDocumentaleDM.Create(Self);
  WBrowseFM:=TWA154FGestioneDocumentaleBrowseFM.Create(Self);
  WDettaglioFM:=TWA154FGestioneDocumentaleDettFM.Create(Self);

  CreaTabDefault;

  AttivaGestioneC700;
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.SelAnagrafe:=grdC700.selAnagrafe;
end;

procedure TWA154FGestioneDocumentale.IWAppFormRender(Sender: TObject);
begin
  inherited;
  jqAutoComplete.Enabled:=WR302DM.selTabella.State in [dsInsert,dsEdit];
end;

procedure TWA154FGestioneDocumentale.PopolaCFFamiliari;
var
  CFFamiliari,Componente,Code: String;
  c: Integer;
begin
  CFFamiliari:='';
  with (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selSG101 do
  begin
    First;
    while not eof do
    begin
      CFFamiliari:=CFFamiliari + IfThen(CFFamiliari <> '',''',''') + C190EscapeJS(FieldByName('CODFISCALE').AsString);
      next;
    end;
  end;
  CFFamiliari:='''' + CFFamiliari + '''';

  // prepara autocomplete
  //jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  if CFFamiliari <> '' then
  begin
    Componente:=(WDettaglioFM as TWA154FGestioneDocumentaleDettFM).dedtFamiliare.HTMLName;

    Code:=Code + CRLF +
            'var elementi = [' + CFFamiliari + ']; ' + CRLF +
            '$("#' + Componente + '").autocomplete({ ' + CRLF +
            '  source: elementi, ' + CRLF +
            '  delay: 0,' + CRLF +
            '  minLength: 0' + CRLF +
            '}).focus(function(){ ' + CRLF +
            '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
            '}); ';
    Code:='try { ' +
          Code +
          '} ' +
          'catch(e) { ' +
          '  try { console.log("jqAutocomplete: " + e.message); } catch(err) {} ' +
          '}';
    jQAutocomplete.OnReady.Add(Code);
  end;

end;

procedure TWA154FGestioneDocumentale.actConfermaExecute(Sender: TObject);
begin
  //se sono in insert
  if (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT960_Funzioni.State = dsInsert then
    if (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.CheckVersionabile then    //se la tipologia selezionata è versionabile
      if (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.CheckVersioniPresenti then   //se sono già presenti delle altre versioni dello stesso documento
      begin
        MsgBox.WebMessageDlg(A000MSG_A154_DLG_NUOVA_VERSIONE, mtConfirmation, [mbYes, mbNo], ResultActConfermaExecute, '');
        Exit;
      end;

  //se sono in edit e cambio tipologia
  if ((WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT960_Funzioni.State = dsEdit) and (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.CambioTipologia then
    if (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.CheckVersionabile then    //se la tipologia selezionata è versionabile
      if (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.CheckVersioniPresenti then   //se sono già presenti delle altre versioni dello stesso documento
      begin
        MsgBox.WebMessageDlg(A000MSG_A154_DLG_NUOVA_VERSIONE, mtConfirmation, [mbYes, mbNo], ResultActConfermaExecute, '');
        Exit;
      end;

  inherited;
end;

procedure TWA154FGestioneDocumentale.ResultActConfermaExecute(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    inherited actConfermaExecute(Sender);
end;

procedure TWA154FGestioneDocumentale.AggiornaAccessoEScarica(const PFilePath: String);
var
  LId: Integer;
  LOldRowId: String;
begin
  // aggiorna dati accesso
  LId:=WR302DM.selTabella.FieldByName('ID').AsInteger;
  LOldRowId:=WR302DM.selTabella.RowId;
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.C021DM.AggiornaDatiAccesso(LId,Parametri.Operatore);

  // refresh dataset
  WR302DM.selTabella.Refresh;
  WR302DM.selTabella.SearchRecord('ID',LId,[srFromBeginning]);
  WBrowseFM.grdTabella.medpCaricaCDS(LOldRowId);

  // effettua il download del file
  NomeFileGenerato:=PFilePath;
  InviaFileGenerato;
end;

end.
