unit W021UStampaCUD;

interface

uses
  R012UWebAnagrafico, R010UPaginaWeb,
  A000UInterfaccia, A000UCostanti, A000USessione, RegistrazioneLog,
  C180FunzioniGenerali, WC012UVisualizzaFileFM,
  DBClient, Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompButton, DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  IWVCLBaseContainer, IWContainer, Forms, IWVCLComponent, ActiveX, MConnect,
  StrUtils, meIWLink, meIWButton, meIWLabel,
  meIWComboBox, meIWImageFile, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  Data.DBXJSON{$IF CompilerVersion >= 31},System.JSON{$ENDIF};

type
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TW021FStampaCUD = class(TR012FWebAnagrafico)
    DCOMConnection1: TDCOMConnection;
    cmbCUD: TmeIWComboBox;
    lblAnnoCUD: TmeIWLabel;
    btnStampa: TmeIWButton;
    lnkIstrCUD: TmeIWLink;
    procedure btnAggiornamentoClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkIstrCUDClick(Sender: TObject);
    procedure cmbCUDChange(Sender: TObject);
  private
    DataFirma:String;
    procedure CallDCOMPrinter;
    function CreateJSonString:String;
    procedure VerificaRicezionePdf;
    procedure ImpostaDataConsegna;
  protected
    procedure OnCambiaProgressivo; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, SyncObjs;

function TW021FStampaCUD.InizializzaAccesso:Boolean;
begin
  Result:=True;
  lnkDipendente.Caption:='';
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
  with WR000DM.selP504 do
  begin
    Close;
    SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('Progressivo').AsInteger);
    Open;
    cmbCUD.Items.Clear;
    while not Eof do
    begin
      cmbCUD.Items.Add(FieldByName('ANNO').AsString);
      Next;
    end;
  end;
  cmbCUD.RequireSelection:=cmbCUD.Items.Count > 0;
  if cmbCUD.Items.Count > 0 then
    cmbCUD.ItemIndex:=0;
  cmbCUDChange(cmbCUD);
end;

procedure TW021FStampaCUD.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR000DM.selP500.Tag:=WR000DM.selP500.Tag + 1;
  GetDipendentiDisponibili(Date);
  cmbDipendentiDisponibili.ItemIndex:=0;
end;

procedure TW021FStampaCUD.RefreshPage;
begin
  with WR000DM do
  begin
    selP500.Close;
    if StrToIntDef(cmbCUD.Text,0) < 2016 then
      selP500.SetVariable('Anno',StrToIntDef(cmbCUD.Text,0)-1)
    else
      selP500.SetVariable('Anno',StrToIntDef(cmbCUD.Text,0));
    selP500.Open;
  end;
end;

procedure TW021FStampaCUD.lnkIstrCUDClick(Sender: TObject);
var URLDoc:String;
begin
  WR000DM.selP500.SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]);
  URLDoc:=ExtractFileName(WR000DM.selP500.FieldByName('WEB_PATH_ISTRUZIONI').AsString);
  VisualizzaFile(URLDoc,'Istruzioni CUD/CU',nil,nil,fdGlobal);
end;

procedure TW021FStampaCUD.cmbCUDChange(Sender: TObject);
begin
  inherited;
  lnkIstrCUD.Visible:=False;
  DataFirma:='01/01/1900';
  with WR000DM.selP500 do
  try
    Close;
    if StrToIntDef(cmbCUD.Text,0) < 2016 then
      SetVariable('Anno',StrToIntDef(cmbCUD.Text,0)-1)
    else
      SetVariable('Anno',StrToIntDef(cmbCUD.Text,0));
    Open;
    if SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]) then
    begin
      if FieldByName('WEB_PATH_ISTRUZIONI').AsString <> '' then
        lnkIstrCUD.Visible:=True;
      if not FieldByName('WEB_DATA_STAMPA').IsNull then
        DataFirma:=FieldByName('WEB_DATA_STAMPA').AsString;
    end;
  except
  end;
end;

procedure TW021FStampaCUD.OnCambiaProgressivo;
var M:String;
begin
  M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]) then
  begin
    ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    OpenPage;
  end;
end;

procedure TW021FStampaCUD.btnAggiornamentoClick(Sender: TObject);
begin
  lblCommentoCorrente.Caption:='';
  if WR000DM.selP504.RecordCount = 0 then
  begin
    MsgBox.MessageBox('Nessun CUD/CU disponibile',INFORMA,'Attenzione');
    exit;
  end;
  CallDCOMPrinter;
end;

procedure TW021FStampaCUD.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente,SQLSelAna: String;
    Mat: String;
    Progressivo,Azione: Integer;
begin
  try
    //Preparo condizione anagrafica filtrata sul dipendente selezionato
    Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
    Progressivo:=selAnagrafeW.Lookup('MATRICOLA',Mat,'PROGRESSIVO');
    SQLSelAna:=selAnagrafeW.SubstitutedSQL;
    SQLSelAna:=StringReplace(SQLSelAna,'T030.*','T030.*,T430INIZIO,T430FINE',[]);
    if Pos('ORDER BY',SQLSelAna) = 0 then
      SQLSelAna:=SQLSelAna + ' ORDER BY';
    SQLSelAna:=Copy(SQLSelAna,1,Pos('ORDER BY',SQLSelAna) - 1) + ' AND ((T030.PROGRESSIVO = ' + IntToStr(Progressivo) + '))';
    //Chiamo Servizio COM B028 per creare il pdf su server
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=CreateJSonString;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection1.Connected then
      DCOMConnection1.Connected:=True;
    try
      A000SessioneWEB.AnnullaTimeOut;
      DCOMConnection1.AppServer.PrintP715(SQLSelAna,
                                          DCOMNomeFile,
                                          Parametri.Operatore,
                                          //Al P714ComServer veniva passato anche Parametri.ProfiloWEB per richiamare RegistraInibizioniInfo(Profilo); ora non più.
                                          Parametri.Azienda,
                                          WR000DM.selAnagrafe.Session.LogonDataBase,
                                          DatiUtente,
                                          DettaglioLog);
    finally
      DCOMConnection1.Connected:=False;
      A000SessioneWEB.RipristinaTimeOut;
    end;
    //Cerco le altre matricole con stesso codice fiscale (non nullo) dell'utente che ha effettuato l'accesso
    WR000DM.selT030DipCF.Close;
    WR000DM.selT030DipCF.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    WR000DM.selT030DipCF.Open;
    Azione:=0;//Sola visualizzazione
    if (Progressivo = Parametri.ProgressivoOper)
    or (StrToIntDef(VarToStr(WR000DM.selT030DipCF.Lookup('PROGRESSIVO',Progressivo,'PROGRESSIVO')),-1) = Progressivo) then
      with WR000DM.selaP504 do
      begin
        Close;
        SetVariable('PROGRESSIVO',Progressivo);
        SetVariable('ANNO',StrToIntDef(cmbCUD.Text,0)-1);
        Open;
        if (RecordCount > 0) and (FieldByName('DATA_CONSEGNA').AsString = '') then
        begin
          Azione:=1;//Visualizzazione con impostazione obbligatoria della data consegna per il dipendente stesso
          if Parametri.WebRichiestaConsegnaCed = 'S' then
            Azione:=2;//Visualizzazione con impostazione della data consegna su conferma del dipendente stesso
        end;
      end;
    case Azione of
      0: VisualizzaFile(DCOMNomeFile,'Anteprima CUD/CU',nil,nil);
      1: VisualizzaFile(DCOMNomeFile,'Anteprima CUD/CU',ImpostaDataConsegna,nil);
      2: VisualizzaFile(DCOMNomeFile,'Anteprima CUD/CU',nil,VerificaRicezionePdf);
    end;
    // file inline.fine
  except
    on E:Exception do
    begin
      Log(ERRORE,'Errore durante la creazione della stampa',E);
      MsgBox.MessageBox('Errore in fase di elaborazione della stampa:' + CRLF +
                        E.Message + CRLF +
                        IfThen(E.ClassName <> 'Exception','Tipo: ' + E.ClassName),ESCLAMA);
      Exit;
    end;
  end;
end;

function TW021FStampaCUD.CreateJSonString:String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    json.AddPair('edtAnno',IntToStr(StrToIntDef(cmbCUD.Text,0)-1));
    json.AddPair('edtDataFirma',DataFirma);
    json.AddPair('rgpStatoCU','0'); //Solo chiuse
    json.AddPair('chkPagNominativo','N');
    json.AddPair('chkScheda','S');
    json.AddPair('chkRiepilogativo','N');
    json.AddPair('chkAnteprima','S'); //Per sicurezza, per non mandare su stampante
    json.AddPair('edtNumCopie','1');
    json.AddPair('chkStampaPDF','N');
    json.AddPair('edtNomeFileOutput','');
    json.AddPair('chkFilePDF','N');
    json.AddPair('chkArchiviazioneDoc','N');
    //memAnnotazione non va passato perché deve usare quello estratto in base ai dati setup

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TW021FStampaCUD.VerificaRicezionePdf;
begin
  Messaggio('Conferma','Si conferma l''avvenuta ricezione del modello CUD/CU per l''anno ' + cmbCUD.Text + '?', ImpostaDataConsegna, nil);
end;

procedure TW021FStampaCUD.ImpostaDataConsegna;
begin
  with WR000DM.selaP504 do
  begin
    Edit;
    FieldByName('DATA_CONSEGNA').AsDateTime:=Trunc(R180Sysdate(SessioneOracle));
    Post;
    SessioneOracle.Commit;
  end;
end;

procedure TW021FStampaCUD.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selP500);
  end;
end;

end.
