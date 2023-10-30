unit WA043UStampaRep;

interface

uses
  A000UCostanti,
  A000UMessaggi,
  A000UInterfaccia,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  WR100UBase,
  A043UStampaRepMW,
  WC022UMsgElaborazioneFM,
  DB,
  DBClient,
  DBXJSON,
  System.JSON,
  IWApplication,
  Datasnap.Win.MConnect,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IWBaseComponent, IWBaseHTMLComponent, StrUtils,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, meIWRadioGroup, IWCompCheckbox, meIWCheckBox, IWCompListbox,
  meIWComboBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWDBStdCtrls,
  meIWDBLookupComboBox, meIWImageFile, medpIWImageButton, medpIWC700NavigatorBar,
  ActiveX;

type
  TWA043FStampaRep = class(TWR100FBase)
    chkSalva: TmeIWCheckBox;
    chkIgnoraAnomalie: TmeIWCheckBox;
    chkSpezzoniMese: TmeIWCheckBox;
    chkCumula: TmeIWCheckBox;
    chkSoloAnomalie: TmeIWCheckBox;
    chkSaltoPagina: TmeIWCheckBox;
    rgpTipoStampa: TmeIWRadioGroup;
    lblTipoStampa: TmeIWLabel;
    lblCampo: TmeIWLabel;
    btnGeneraPDF: TmedpIWImageButton;
    btnSoloAggiornamento: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    btnCambioData: TmeIWButton;
    cmbCampo: TmeIWComboBox;
    DCOMConnection: TDCOMConnection;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
    procedure chkSalvaClick(Sender: TObject);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    A043MW:TA043FStampaRepMW;
//    FGiorniMeseOld:Integer;
    FTipoStampa: Integer;
//    DCOMNomeFile:String;
    FSoloAgg: string;
    FIdAnomalia:String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
    procedure OnPeriodoModificato;
    function IsMesiInteri(const PDataInizio, PDataFine: TDateTime): Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
  protected
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
    procedure AfterElaborazione; override;
  public
    DataI: TDateTime;
    DataF: TDateTime;
  protected
    procedure ImpostazioniWC700; override;
  end;

implementation

{$R *.dfm}

procedure TWA043FStampaRep.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  A043MW:=TA043FStampaRepMW.Create(Self);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;
  AttivaGestioneC700;
  btnAnomalie.Enabled:=False;

  // il periodo iniziale comprende il mese della data di lavoro
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));

//  FGiorniMeseOld:=R180GiorniMese(Parametri.DataLavoro);

  // campo anagrafico di raggruppamento
  while not A043MW.selI010.Eof do
  begin
    cmbCampo.Items.Add(A043MW.selI010.FieldByName('NOME_LOGICO').AsString + '=' + A043MW.selI010.FieldByName('NOME_CAMPO').AsString);
    A043MW.selI010.Next;
  end;

  GetParametriFunzione;

  btnCambioDataClick(nil);
end;

procedure TWA043FStampaRep.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA043FStampaRep.edtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  // gestione modifica periodo
  OnPeriodoModificato;
end;

procedure TWA043FStampaRep.edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  // gestione modifica periodo
  OnPeriodoModificato;
end;

procedure TWA043FStampaRep.OnPeriodoModificato;
begin
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]))
  else
    btnCambioDataClick(nil);
end;

procedure TWA043FStampaRep.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpTipoStampa.ItemIndex:=StrToInt(C004DM.GetParametro('TIPOSTAMPA','0'));
  chkIgnoraAnomalie.Checked:=C004DM.GetParametro('IGNORAANOMALIE','N') = 'S';
  chkSpezzoniMese.Checked:=C004DM.GetParametro('SOMMASPEZZONI','N') = 'S';
  chkCumula.Checked:=C004DM.GetParametro('CUMULA','N') = 'S';
  chkSoloAnomalie.Checked:=C004DM.GetParametro('SOLOANOMALIE','N') = 'S';
  cmbCampo.ItemIndex:=cmbCampo.Items.IndexOf(C004DM.GetParametro('RAGGRUPPAMENTO','')+'='+VarToStr(A043MW.selI010.Lookup('NOME_LOGICO',C004DM.GetParametro('RAGGRUPPAMENTO',''),'NOME_CAMPO')));
  chkSalvaClick(nil);
end;

procedure TWA043FStampaRep.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
    C700DataDal:=Parametri.DataLavoro;
    C700SelezionePeriodica:=True;
  end;
end;

procedure TWA043FStampaRep.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  C004DM.PutParametro('IGNORAANOMALIE',IfThen(chkIgnoraAnomalie.Checked,'S','N'));
  C004DM.PutParametro('SOMMASPEZZONI',IfThen(chkSpezzoniMese.Checked,'S','N'));
  C004DM.PutParametro('CUMULA',IfThen(chkCumula.Checked,'S','N'));
  C004DM.PutParametro('SOLOANOMALIE',IfThen(chkSoloAnomalie.Checked,'S','N'));
  C004DM.PutParametro('RAGGRUPPAMENTO',cmbCampo.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TWA043FStampaRep.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

function TWA043FStampaRep.IsMesiInteri(const PDataInizio, PDataFine: TDateTime): Boolean;
begin
  Result:=(PDataInizio = R180InizioMese(PDataInizio)) and
          (PDataFine = R180FineMese(PDataFine));
end;

procedure TWA043FStampaRep.btnCambioDataClick(Sender: TObject);
var
  LMesiInteri: Boolean;
  LPeriodoMese: Boolean;
begin
  // se le date sono valide verifica che il periodo di elaborazione comprenda mesi interi
  if TryStrToDate(edtDataDa.Text,DataI) and
     TryStrToDate(edtDataA.Text,DataF) then
  begin
    LMesiInteri:=IsMesiInteri(DataI,DataF);
    LPeriodoMese:=R180Between(DataF,R180InizioMese(DataI),R180FineMese(DataI));
  end
  else
  begin
    LMesiInteri:=False;
    LPeriodoMese:=False;
  end;

  // imposta le date di riferimento per C700
  grdC700.WC700FM.C700DataDal:=DataI;
  grdC700.WC700FM.C700DataLavoro:=DataF;

  // stampa PDF abilitata se il periodo è inferiore o uguale a un mese
  btnGeneraPDF.Enabled:=LPeriodoMese;

  // aggiornamento riepilogo abilitato se il periodo è di mesi interi
  chkSalva.Enabled:=(not SolaLettura) and (LMesiInteri);
  if not chkSalva.Enabled then
    chkSalva.Checked:=False;
  chkSalvaClick(nil);
end;

procedure TWA043FStampaRep.chkSalvaClick(Sender: TObject);
begin
  btnSoloAggiornamento.Enabled:=chkSalva.Enabled and chkSalva.Checked;
  chkIgnoraAnomalie.Enabled:=chkSalva.Checked;
end;

procedure TWA043FStampaRep.rgpTipoStampaClick(Sender: TObject);
begin
  FTipoStampa:=rgpTipoStampa.ItemIndex;
  chkSoloAnomalie.Enabled:=(FTipoStampa = 0);
  if not chkSoloAnomalie.Enabled then
    chkSoloAnomalie.Checked:=False;
end;

procedure TWA043FStampaRep.btnGeneraPDFClick(Sender: TObject);
begin
  // verifica selezione anagrafica
  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.MessageBox(A000MSG_ERR_NO_DIP, ERRORE);
    Exit;
  end;

  // verifica periodo
  if DataI > DataF then
  begin
    Msgbox.MessageBox(A000MSG_ERR_DATE_INVERTITE,INFORMA);
    exit;
  end;

  // imposta variabile per indicare il solo aggiornamento
  FSoloAgg:=IfThen(Sender = btnSoloAggiornamento,'S','N');

  btnAnomalie.Enabled:=False;
  StartElaborazioneServer(btnGeneraPDF.HTMLName,True);
end;

procedure TWA043FStampaRep.InizializzaMsgElaborazione;
begin
  inherited;

  // inizializza info elaborazione in corso
  if FSoloAgg = 'S' then
  begin
    WC022FMsgElaborazioneFM.Messaggio:='Aggiornamento riepilogo reperibilità in corso...';
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA043FStampaRep.ElaborazioneServer;
begin
  CallDCOMPrinter;

//  btnAnomalie.Enabled:=IdAnomalia <> '';
//  if btnAnomalie.Enabled then
//    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_ANOMALIE,INFORMA)
//  else if Sender = btnSoloAggiornamento then
//    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA)
//  else if not FileExists(DCOMNomeFile) then
//    raise Exception.Create(A000MSG_ERR_FILE_NON_CREATO);

//  if FileExists(DCOMNomeFile) then
//  begin
//    NomeFileGenerato:=DCOMNomeFile;
//    InviaFileGenerato;
//  end;
end;

procedure TWA043FStampaRep.AfterElaborazione;
begin
  inherited;
  btnAnomalie.Enabled:=FIdAnomalia <> '';
//  if btnAnomalie.Enabled then
//    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_ANOMALIE,INFORMA)
//  else if Sender = btnSoloAggiornamento then
//    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA)
//  else if not FileExists(DCOMNomeFile) then
//    raise Exception.Create(A000MSG_ERR_FILE_NON_CREATO);
end;

procedure TWA043FStampaRep.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + FIdAnomalia + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

procedure TWA043FStampaRep.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  // richiama servizio COM B028 per generare la cartolina reperibilità e/o creare il pdf su server
  FIdAnomalia:='';
  DCOMMsg:='';
  if FSoloAgg = 'N' then
  begin
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
  end
  else
  begin
    DCOMNomeFile:='';
  end;

  DatiUtente:=CreateJSonString;

  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    A000SessioneWEB.AnnullaTimeOut;
    DCOMConnection.AppServer.PrintA043(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
    FIdAnomalia:=DettaglioLog;

    // codice per segnalazione anomalia all'utente
    if (FIdAnomalia <> '') then
      DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
  finally
    DCOMConnection.Connected:=False;
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

function TWA043FStampaRep.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);

    C190Comp2JsonString(chkSalva,json);
    C190Comp2JsonString(chkIgnoraAnomalie,json);
    C190Comp2JsonString(chkSpezzoniMese,json);
    C190Comp2JsonString(chkCumula,json);
    C190Comp2JsonString(chkSoloAnomalie,json);
    C190Comp2JsonString(chkSaltoPagina,json);

    C190Comp2JsonString(rgpTipoStampa,json);
    C190Comp2JsonString(cmbCampo,json,'dcmbCampo');
    //json.AddPair('cmbCampo',TJSONString.Create(VarToStr(A043MW.selI010.Lookup('NOME_LOGICO',cmbCampo.Text,'NOME_CAMPO'))));

    json.AddPair('SoloAgg',TJSONString.Create(FSoloAgg));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.
