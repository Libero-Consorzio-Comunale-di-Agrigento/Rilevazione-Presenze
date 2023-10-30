unit WA097UPianifLibProf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, OracleData,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompEdit, meIWEdit,
  WA097UProfiloFM, WA097UImportazioneFileFM, medpIWC700NavigatorBar,
  IWApplication, meIWImageFile, medpIWImageButton, System.Actions,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, StrUtils,
  Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, Winapi.ActiveX, WC700USelezioneAnagrafeFM,
  C190FunzioniGeneraliWeb, DBXJSON{$IF CompilerVersion >= 31},System.JSON{$ENDIF};

type
  TWA097FPianifLibProf = class(TWR102FGestTabella)
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    btnCambioData: TmeIWButton;
    grdTabDetail: TmedpIWTabControl;
    btnAnomalie: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    WA097Prof:TWA097FProfiloFM;
    WA097Import:TWA097FImportazioneFileFM;
    OldProg:Integer;
    IdAnomalia,MsgNoImp:String;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure AbilitaAzioni(Abilita: Boolean);
    procedure AbilitaComponenti(Abilita: Boolean);
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
  public
    { Public declarations }
    ProceduraChiamante: Integer;
  protected
    procedure ImpostazioniWC700; override;
    //gestione profilo
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
    //importazione excel
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
  end;

implementation

uses WA097UPianifLibProfDM, WA097UPianifLibProfBrowseFM;

{$R *.dfm}

procedure TWA097FPianifLibProf.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA097FPianifLibProfDM.Create(Self);
  WBrowseFM:=TWA097FPianifLibProfBrowseFM.Create(Self);
  WA097Prof:=TWA097FProfiloFM.Create(Self);
  WA097Import:=TWA097FImportazioneFileFM.Create(Self);
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  (WR302DM as TWA097FPianifLibProfDM).A097MW.selAnagrafe:=grdC700.selAnagrafe;

  grdTabDetail.AggiungiTab('Individuale',WBrowseFM);
  grdTabDetail.AggiungiTab('Profilo',WA097Prof);
  grdTabDetail.AggiungiTab('Importazione file',WA097Import);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WBrowseFM;
  grdTabDetail.TabByIndex(1).Enabled:=not SolaLettura;

  with (WR302DM as TWA097FPianifLibProfDM).A097MW do
  begin
    Dal:=R180InizioMese(Parametri.DataLavoro);
    Al:=R180FineMese(Parametri.DataLavoro);
    edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',Dal);
    edtDataA.Text:=FormatDateTime('dd/mm/yyyy',Al);
    WA097Prof.cmbProfilo.Text:=Q310.FieldByName('Codice').AsString;
    WA097Prof.cmbProfiloChange(nil,0);
    grdC700.WC700FM.C700DataLavoro:=Al;
  end;

  btnCambioDataClick(nil);
end;

procedure TWA097FPianifLibProf.IWAppFormRender(Sender: TObject);
begin
  inherited;
  WA097Import.lblFileSceltoDescr.Caption:=ExtractFileName((WR302DM as TWA097FPianifLibProfDM).A097MW.NomeFile);
end;

procedure TWA097FPianifLibProf.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',upper(T030.CODFISCALE) CODFISCALE';
end;

procedure TWA097FPianifLibProf.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
    with (WR302DM as TWA097FPianifLibProfDM).A097MW do
    begin
      RefreshSelT320;
      WBrowseFM.grdTabella.medpAggiornaCDS(True);
    end;
end;

procedure TWA097FPianifLibProf.edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA097FPianifLibProf.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(True);
end;

procedure TWA097FPianifLibProf.actConfermaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(True);
end;

procedure TWA097FPianifLibProf.actModificaExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(False);
end;

procedure TWA097FPianifLibProf.actNuovoExecute(Sender: TObject);
begin
  inherited;
  AbilitaComponenti(False);
end;

procedure TWA097FPianifLibProf.AbilitaComponenti(Abilita:Boolean);
begin
  lblDataDa.Enabled:=Abilita;
  edtDataDa.Enabled:=Abilita;
  lblDataA.Enabled:=Abilita;
  edtDataA.Enabled:=Abilita;
  grdTabDetail.TabByIndex(1).Enabled:=Abilita;
  grdTabDetail.TabByIndex(2).Enabled:=Abilita;
end;

procedure TWA097FPianifLibProf.btnCambioDataClick(Sender: TObject);
var Prog:Integer;
begin
  with (WR302DM as TWA097FPianifLibProfDM).A097MW do
  begin
    Dal:=StrToDate(edtDataDa.Text);
    Al:=StrToDate(edtDataA.Text);
    grdC700.WC700FM.C700DataLavoro:=Al;

    Prog:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(Al,Al) then
      SelAnagrafe.Close;
    SelAnagrafe.Open;
    RefreshSelT320;
    SelAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA097FPianifLibProf.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;
  if (grdTabDetail.ActiveTab = WA097Prof) or (grdTabDetail.ActiveTab = WA097Import) then
    AbilitaAzioni(False)
  else
  begin
    AbilitaAzioni(True);
    (WR302DM as TWA097FPianifLibProfDM).A097MW.RefreshSelT320;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA097FPianifLibProf.AbilitaAzioni(Abilita:Boolean);
begin
  actNuovo.Enabled:=Abilita;
  actModifica.Enabled:=Abilita;
  actElimina.Enabled:=Abilita;
  actAggiorna.Enabled:=Abilita;
  actRicerca.Enabled:=Abilita;
  actEstrai.Enabled:=Abilita;
  actPrimo.Enabled:=Abilita;
  actPrecedente.Enabled:=Abilita;
  actSuccessivo.Enabled:=Abilita;
  actUltimo.Enabled:=Abilita;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWA097FPianifLibProf.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IdAnomalia + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

//gestione profilo
procedure TWA097FPianifLibProf.InizioElaborazione;
begin
  inherited;
  with (WR302DM as TWA097FPianifLibProfDM).A097MW, WA097Prof do
  begin
    Q311.Close;
    Q311.SetVariable('Codice',cmbProfilo.Text);
    Q311.Open;
    btnAnomalie.Enabled:=False;
    IdAnomalia:='';
    PianifFestivi:=chkFestivi.Checked;
  end;
  OldProg:=grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger;
  grdC700.SelAnagrafe.First;
end;

function TWA097FPianifLibProf.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA097FPianifLibProf.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

procedure TWA097FPianifLibProf.ElaboraElemento;
begin
  with (WR302DM as TWA097FPianifLibProfDM).A097MW do
    GestionePianificazione(SelAnagrafe.FieldByName('Progressivo').AsInteger,ProceduraChiamante = 0);
end;

function TWA097FPianifLibProf.ElementoSuccessivo: Boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.EOF;
end;

procedure TWA097FPianifLibProf.FineCicloElaborazione;
begin
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  IdAnomalia:=IntToStr(RegistraMsg.ID);
  AggiornaAnagr;
  MsgBox.ClearKeys;
end;

function TWA097FPianifLibProf.ElaborazioneTerminata: String;
begin
  grdC700.SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

//importazione file
procedure TWA097FPianifLibProf.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    Titolo:=A000MSG_MSG_ELABORAZIONE;
    ImgFileName:=IMG_FILENAME_XLS;
  end;
end;

procedure TWA097FPianifLibProf.ElaborazioneServer;
begin
  btnAnomalie.Enabled:=False;
  IdAnomalia:='';
  MsgNoImp:='';
  CallDCOMPrinter;
  btnAnomalie.Enabled:=IdAnomalia <> '';
  if btnAnomalie.Enabled then
    DCOMMsg:=MsgNoImp + A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    DCOMMsg:=MsgNoImp + A000MSG_MSG_ELABORAZIONE_TERMINATA;
end;

procedure TWA097FPianifLibProf.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per importare il file excel
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    A000SessioneWEB.AnnullaTimeOut;
    DCOMConnection.AppServer.PrintA097(grdC700.selAnagrafe.SubstitutedSQL,
                                       (WR302DM as TWA097FPianifLibProfDM).A097MW.NomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
    if Pos('+',DettaglioLog) > 0 then
    begin
      MsgNoImp:=IfThen(StrToInt(Copy(DettaglioLog,1,Pos('+',DettaglioLog) - 1)) = 0,A000MSG_A097_ERR_NO_IMPORT + CRLF);
      IdAnomalia:=Copy(DettaglioLog,Pos('+',DettaglioLog) + 1);
    end;
  finally
    DCOMConnection.Connected:=False;
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

function TWA097FPianifLibProf.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);
    json.AddPair('rgpGestioneProfilo','2'); //Importazione file
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.
