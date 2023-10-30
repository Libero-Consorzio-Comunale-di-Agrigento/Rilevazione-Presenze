unit WA180UOperatoriDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, DBClient,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi, L021Call, C180FunzioniGenerali, RegolePassword,
  WR302UGestTabellaDM, WR300UBaseDM;

type
  TWA180FOperatoriDM = class(TWR302FGestTabellaDM)
    selTabellaAZIENDA: TStringField;
    selTabellaUTENTE: TStringField;
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaOCCUPATO: TStringField;
    selTabellaPASSWD: TStringField;
    selTabellaINTEGRAZIONEANAGRAFE: TStringField;
    selTabellaSBLOCCO: TStringField;
    selTabellaPERMESSI: TStringField;
    selTabellaFILTRO_ANAGRAFE: TStringField;
    selTabellaFILTRO_FUNZIONI: TStringField;
    selTabellaFILTRO_DIZIONARIO: TStringField;
    selTabellaDATA_PW: TDateTimeField;
    selTabellaScadenzaPasswd: TDateField;
    selTabellaD_Azienda: TStringField;
    selTabellaNUOVA_PASSWORD: TStringField;
    selTabellaDATA_ACCESSO: TDateTimeField;
    selTabellaScadenzaUtente: TDateField;
    selTabellaACCESSO_NEGATO: TStringField;
    D090: TDataSource;
    QI090: TOracleDataSet;
    selTabellaVALIDITA_CESSATI: TIntegerField;
    dsrI071: TDataSource;
    selI071: TOracleDataSet;
    selI072Dist: TOracleDataSet;
    dsrI072Dist: TDataSource;
    selI073Dist: TOracleDataSet;
    dsrI073Dist: TDataSource;
    dsrI074Dist: TDataSource;
    selI074Dist: TOracleDataSet;
    T035: TOracleDataSet;
    selTabellaT030_PROGRESSIVO: TIntegerField;
    selT030: TOracleDataSet;
    selI091: TOracleDataSet;
    selParLinkOperatori: TOracleQuery;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selI072DistFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI073DistFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI071FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selI074DistFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QI090FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QI090AfterScroll(DataSet: TDataSet);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
    FEsistonoLinkOperatori: Boolean;
  public
    AziendaCorrente:String;
    procedure AggiornaFiltroProfili;
    function GetDatoEnte(const PAzienda, PTipo:String): String;
    property EsistonoLinkOperatori: Boolean read FEsistonoLinkOperatori;
  end;

implementation

uses
  WA180UOperatori,
  WA180UOperatoriDettFM;

{$R *.dfm}

procedure TWA180FOperatoriDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  //selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
  selTabella.Filtered:=Parametri.Azienda <> 'AZIN';
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,UTENTE');
  //QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
  QI090.Filtered:=Parametri.Azienda <> 'AZIN';
  NonAprireSelTabella:=True;
  inherited;
  QI090.Open;
  selTabella.Open;
  selTabella.SearchRecord('AZIENDA;UTENTE',VararrayOf([Parametri.Azienda,Parametri.Operatore]),[srfromBeginning]);
  selI071.Open;
  selI072Dist.Open;
  selI073Dist.Open;
  selI074Dist.Open;

  // se l'azienda è AZIN verifica se esistono aziende (diverse da AZIN)
  // per cui il parametro C33_LINK_I070_T030 è O / F
  FEsistonoLinkOperatori:=False;
  if Parametri.Azienda = 'AZIN' then
  begin
    selParLinkOperatori.Execute;
    FEsistonoLinkOperatori:=selParLinkOperatori.FieldAsInteger(0) > 0;
  end;
end;

procedure TWA180FOperatoriDM.OnNewRecord(DataSet: TDataSet);
begin
  // in inserimento propone l'azienda principale
  selTabella.FieldByName('AZIENDA').AsString:=Parametri.Azienda;

  inherited;
end;

function TWA180FOperatoriDM.GetDatoEnte(const PAzienda, PTipo:String): String;
// estrae il valore del parametro aziendale indicato per l'azienda specificata
begin
  selI091.Close;
  selI091.SetVariable('AZIENDA',PAzienda);
  selI091.SetVariable('TIPO',PTipo);
  selI091.Open;
  Result:=selI091.FieldByName('DATO').AsString;
end;

procedure TWA180FOperatoriDM.QI090AfterScroll(DataSet: TDataSet);
var
  LDettFM: TWA180FOperatoriDettFM;
begin
  inherited;

  // operazioni in caso di anagrafica collegata
  LDettFM:=((Self.Owner as TWA180FOperatori).WDettaglioFM as TWA180FOperatoriDettFM);
  if LDettFM <> nil then
    LDettFM.OnAziendaChange;
end;

procedure TWA180FOperatoriDM.QI090FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(Parametri.Azienda = 'AZIN') or (DataSet.FieldByName('AZIENDA').AsString = Parametri.Azienda);
end;

procedure TWA180FOperatoriDM.selI071FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;

procedure TWA180FOperatoriDM.selI072DistFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;

procedure TWA180FOperatoriDM.selI073DistFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;

procedure TWA180FOperatoriDM.selI074DistFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=DataSet.FieldByName('AZIENDA').AsString = AziendaCorrente;
end;


procedure TWA180FOperatoriDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('SCADENZAPASSWD').AsDateTime:=R180AddMesi(selTabella.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword);
  (* Se l'operatore ha già effettuato il primo ingresso, e quidi è stata memorizzata la sysdate, comparirà
    la data di scadenza utente, altrimenti non comapare nulla (significa che l'operatore non ha ancora effettuato il
    primo ingresso ed il campo DATA_ACCESSO è vuoto) *)
  try
    if not selTabella.FieldByName('DATA_ACCESSO').IsNull then
      selTabella.FieldByName('ScadenzaUtente').AsDateTime:=R180AddMesi(selTabella.FieldByName('DATA_ACCESSO').AsDateTime,QI090.FieldByName('VALID_UTENTE').AsInteger);
  except
  end;
end;

procedure TWA180FOperatoriDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(Parametri.Azienda = 'AZIN') or (DataSet.FieldByName('AZIENDA').AsString = Parametri.Azienda);
end;

procedure TWA180FOperatoriDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  SessioneOracle.Commit;
  RegistraLog.RegistraOperazione;
end;

procedure TWA180FOperatoriDM.AfterScroll(DataSet: TDataSet);
var
  LDettFM: TWA180FOperatoriDettFM;
begin
  inherited;
  QI090.SearchRecord('AZIENDA',selTabella.FieldByName('AZIENDA').AsString,[srFromBeginning]);

  // operazioni in caso di anagrafica collegata
  LDettFM:=((Self.Owner as TWA180FOperatori).WDettaglioFM as TWA180FOperatoriDettFM);
  if (LDettFM <> nil) and (LDettFM.GestSelAnag) then
  begin
    // aggiorna anagrafica collegata
    LDettFM.AggiornaDatiAnagraficaCollegata;
  end;
end;

procedure TWA180FOperatoriDM.AggiornaFiltroProfili;
begin
  with selI071 do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI072Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI073Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
  with selI074Dist do
    if Active then
    begin
      DisableControls;
      Filtered:=False;
      Filtered:=True;
      EnableControls;
    end;
end;

procedure TWA180FOperatoriDM.BeforePostNoStorico(DataSet: TDataSet);
var RegolePassword:TRegolePassword;
    S:String;
    i:Integer;
begin
  inherited;
  if pos(' ', DataSet.FieldByName('UTENTE').AsString) > 0 then
    raise exception.Create('L''operatore non può contenere degli spazi');
  if DataSet.FieldByName('PERMESSI').IsNull then
    raise Exception.Create(A000MSG_A008_ERR_PROFILOPERMESSI_NULLO);
  if DataSet.FieldByName('FILTRO_FUNZIONI').IsNull then
    raise Exception.Create(A000MSG_A008_ERR_PROFILOFUNZIONI_NULLO);

  if (DataSet.State = dsInsert) or
     (DataSet.FieldByName('PASSWD').medpOldValue <> DataSet.FieldByName('PASSWD').Value) then
  begin
    QI090.SearchRecord('AZIENDA',selTabella.FieldByName('AZIENDA').AsString,[srFromBeginning]);
    with QI090 do
      if FieldByName('DOMINIO_DIP').IsNull or (Trim(Dataset.FieldByName('PASSWD').AsString) <> '') then
        try
          RegolePassword:=TRegolePassword.Create(nil);
          RegolePassword.PasswordI060:=False;
          RegolePassword.MesiValidita:=FieldByName('VALID_PASSWORD').AsInteger;
          RegolePassword.Lunghezza:=FieldByName('LUNG_PASSWORD').AsInteger;
          RegolePassword.Cifre:=FieldByName('PASSWORD_CIFRE').AsInteger;
          RegolePassword.Maiuscole:=FieldByName('PASSWORD_MAIUSCOLE').AsInteger;
          RegolePassword.CarSpeciali:=FieldByName('PASSWORD_CARSPECIALI').AsInteger;
          S:=RegolePassword.PasswordValida(Dataset.FieldByName('PASSWD').AsString);
          if S <> '' then
            raise Exception.Create(s);
        finally
          FreeAndNil(RegolePassword);
        end;
      Dataset.FieldByName('PASSWD').AsString:=R180CriptaI070(Dataset.FieldByName('PASSWD').AsString);
      DataSet.FieldByName('DATA_PW').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
  end;
  if DataSet.State = dsInsert then
    with T035 do
    begin
      Open;
      if FieldByName('I070PROGRESSIVO').IsNull then i:=0
      else i:=FieldByName('I070PROGRESSIVO').AsInteger;
      Inc(i);
      Edit;
      FieldByName('PROPERATORI').AsInteger:=i;
      Post;
      Close;
      DataSet.FieldByName('Progressivo').AsInteger:=i;
    end;
end;

procedure TWA180FOperatoriDM.dsrTabellaStateChange(Sender: TObject);
var
  LDettFM: TWA180FOperatoriDettFM;
begin
  inherited;

  // richiama l'evento corrispondente anche sul frame di dettaglio
  LDettFM:=((Self.Owner as TWA180FOperatori).WDettaglioFM as TWA180FOperatoriDettFM);
  if LDettFM <> nil then
    LDettFM.OnDataSourceTabellaStateChange;
end;

end.
