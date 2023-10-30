unit W047UIscrizioneOrdineDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  FunzioniGenerali,
  C180FunzioniGenerali,
  C017UEMailDtM,
  IWApplication,
  QueryStorico,
  W000UMessaggi,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.StrUtils,
  System.Variants,
  Data.DB,
  Oracle,
  OracleData;

type

  TW047FIscrizioneOrdineDM = class(TDataModule)
    selSG220: TOracleDataSet;
    selSG221_all: TOracleDataSet;
    selSG221_fil: TOracleDataSet;
    selT481: TOracleDataSet;
    selV430a: TOracleDataSet;
    selSG220PROGRESSIVO: TFloatField;
    selSG220COD_ORDINE: TStringField;
    selSG220d_ORDINE: TStringField;
    selSG220COD_PROVINCIA: TStringField;
    selSG220d_PROVINCIA: TStringField;
    selSG220COD_ISCRIZIONE: TStringField;
    selSG220DATA_ISCRIZIONE: TDateTimeField;
    selSG220NOTE: TStringField;
    selSG221_allCOD_ORDINE: TStringField;
    selSG221_allDESCRIZIONE: TStringField;
    selSG221_allQUALIFICHE_COLLEGATE: TStringField;
    selT481COD_PROVINCIA: TStringField;
    selT481DESCRIZIONE: TStringField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    selSG220EMAIL_PEC: TStringField;
    selSG221_GetCodOrdine: TOracleDataSet;
    selT481_GetCodProv: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG220AfterPost(DataSet: TDataSet);
    procedure selSG220BeforeEdit(DataSet: TDataSet);
    procedure selSG220BeforePost(DataSet: TDataSet);
    procedure selSG220NewRecord(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selSG220AfterDelete(DataSet: TDataSet);
    procedure selSG220BeforeDelete(DataSet: TDataSet);
  private
    FDataIns: TDateTime;
    FOperazioneSG220: String;
    Codice,Codice_Old,
    Iscrizione,Iscrizione_Old,
    Provincia,Provincia_Old:String;
    CodiceVariato, ProvinciaVariata, IscrizioneVariato:Boolean;
    procedure CaricaListaValori(NomeLogico: String);
    procedure CaricaListaOrdini;
    procedure CaricaListaPrv;
    procedure ImpostaLabelMaxCar(DataSet:TOracleDataSet);
  public
    slOrdini,slPrv: TStringList;
    selAnagrafeW: TOracleDataSet;
    function ControlloCampiObbligatori(DataSetCampi,DataSetValori:TDataSet):String;
    property DataIns: TDateTime read FDataIns write FDataIns;
    function CercaOrdineProf(ValoreV430a:String):String;
    function RecuperaLista(NomeLogico:String):TStringList;
    procedure InviaEMailVariazione(Operazione:String);
  end;

const sObbl = '(*)';
const sMaxCod = ' (max 10 caratteri)';
const sMaxCar = ' (max 4000 caratteri)';

implementation

uses
  W047UIscrizioneOrdine;

{$R *.dfm}

{ TW047FIscrizioneOrdineDM }

function TW047FIscrizioneOrdineDM.ControlloCampiObbligatori(DataSetCampi, DataSetValori: TDataSet): String;
var i:Integer;
begin
  //I campi obbligatori di DataSetCampi che non devono essere controllati su DataSetValori devono essere impostati a ReadOnly su DataSetValori (es. DECORRENZA_FINE)
  Result:='';
  for i:=0 to DataSetCampi.FieldCount - 1 do
    if (Pos(sObbl,DataSetCampi.Fields[i].DisplayLabel) > 0)
    and not DataSetValori.Fields[i].ReadOnly
    and (Trim(DataSetValori.Fields[i].AsString) = '') then
    begin
      Result:=StringReplace(DataSetCampi.Fields[i].DisplayLabel,sObbl,'',[rfReplaceAll]);
      Result:=StringReplace(Result,sMaxCar,'',[rfReplaceAll]);
      Exit;
    end;
end;

procedure TW047FIscrizioneOrdineDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  //ImpostaLabelMaxCar(selSG220);
  selSG221_all.Open;
  selT481.Open;

  slOrdini:=TStringList.Create;
  CaricaListaValori('COD_ORDINE');
  slPrv:=TStringList.Create;
  CaricaListaValori('COD_PROVINCIA');
end;

procedure TW047FIscrizioneOrdineDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(slOrdini);
  FreeAndNil(slPrv);
end;

procedure TW047FIscrizioneOrdineDM.ImpostaLabelMaxCar(DataSet: TOracleDataSet);
var i:Integer;
begin
  with DataSet do
    for i:=0 to FieldCount - 1 do
    begin
      Fields[i].DisplayLabel:=Fields[i].DisplayLabel + IfThen(Fields[i].FieldName = 'COD_ISCRIZIONE',sMaxCod);
      Fields[i].DisplayLabel:=Fields[i].DisplayLabel + IfThen(Fields[i].FieldName = 'NOTE',sMaxCar);
    end;
end;

procedure TW047FIscrizioneOrdineDM.CaricaListaValori(NomeLogico: String);
var Lista:TStringList;
begin
  Lista:=RecuperaLista(NomeLogico);
  if Lista = nil then
    exit;

  if NomeLogico = 'COD_ORDINE' then
    CaricaListaOrdini
  else if NomeLogico = 'COD_PROVINCIA' then
    CaricaListaPrv;
end;

function TW047FIscrizioneOrdineDM.CercaOrdineProf(ValoreV430a:String):String;
begin
  Result:='';
  if selSG221_fil.Active then
    selSG221_fil.Close;

  if not ValoreV430a.IsEmpty then
  begin
    R180SetVariable(selSG221_fil,'VALORE',ValoreV430a);
    try
      selSG221_fil.Open;
      selSG221_fil.First;
      while not selSG221_fil.Eof do
      begin
        if R180CercaParolaIntera(ValoreV430a,selSG221_fil.FieldByName('QUALIFICHE_COLLEGATE').AsString,',') > 0 then
        begin
          Result:=selSG221_fil.FieldByName('COD_ORDINE').AsString;
          break;
        end;
        selSG221_fil.Next;
      end;
    except
    end;
  end;
end;

procedure TW047FIscrizioneOrdineDM.CaricaListaOrdini;
begin
  slOrdini.Clear;
  slOrdini.StrictDelimiter:=True;
  try
    selSG221_all.First;
    while not selSG221_all.Eof do
    begin
      slOrdini.Add(selSG221_all.FieldByName('COD_ORDINE').AsString);
      selSG221_all.Next;
    end;
  except
  end;
end;

procedure TW047FIscrizioneOrdineDM.CaricaListaPrv;
begin
  slPrv.Clear;
  slPrv.StrictDelimiter:=True;
  try
    selT481.First;
    while not selT481.Eof do
    begin
      slPrv.Add(selT481.FieldByName('COD_PROVINCIA').AsString);
      selT481.Next;
    end;
  except
  end;
end;

function TW047FIscrizioneOrdineDM.RecuperaLista(NomeLogico: String): TStringList;
begin
  Result:=nil;
  if NomeLogico = 'COD_ORDINE' then
    Result:=slOrdini
  else if NomeLogico = 'COD_PROVINCIA' then
    Result:=slPrv;
end;

procedure TW047FIscrizioneOrdineDM.selSG220NewRecord(DataSet: TDataSet);
begin
  // valorizza dati di default
  selSG220.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  // note
  selSG220.FieldByName('NOTE').AsString:=Format(A000MSG_W047_MSG_FMT_NOTE,[Date.ToString('dd/mm/yyyy')]);
end;

procedure TW047FIscrizioneOrdineDM.selSG220BeforeEdit(DataSet: TDataSet);
begin
  // note solo se non significative
  if selSG220.FieldByName('NOTE').AsString.IsEmpty then
    selSG220.FieldByName('NOTE').AsString:=Format(A000MSG_W047_MSG_FMT_NOTE,[Date.ToString('dd/mm/yyyy')]);
end;

procedure TW047FIscrizioneOrdineDM.selSG220BeforePost(DataSet: TDataSet);
var CampoObbl: String;
begin
  with DataSet do
  begin
    CodiceVariato:=False;
    Codice_Old:='';
    Codice:=FieldByName('COD_ORDINE').AsString;
    CodiceVariato:=FieldByName('COD_ORDINE').AsString <> FieldByName('COD_ORDINE').OldValue;
    if CodiceVariato then
      Codice_Old:=VarToStr(FieldByName('COD_ORDINE').OldValue);

    ProvinciaVariata:=False;
    Provincia_Old:='';
    Provincia:=FieldByName('COD_PROVINCIA').AsString;
    ProvinciaVariata:=FieldByName('COD_PROVINCIA').AsString <> FieldByName('COD_PROVINCIA').OldValue;
    if ProvinciaVariata then
      Provincia_Old:=VarToStr(FieldByName('COD_PROVINCIA').OldValue);

    IscrizioneVariato:=False;
    Iscrizione_Old:='';
    Iscrizione:=FieldByName('COD_ISCRIZIONE').AsString;
    IscrizioneVariato:=FieldByName('COD_ISCRIZIONE').AsString <> FieldByName('COD_ISCRIZIONE').OldValue;
    if IscrizioneVariato then
      Iscrizione_Old:=VarToStr(FieldByName('COD_ISCRIZIONE').OldValue);
  end;

  // controllo su obbligatorietà dei campi
  CampoObbl:=ControlloCampiObbligatori(DataSet,DataSet);
  if CampoObbl <> '' then
    raise exception.Create('Il campo "' + CampoObbl + '" è obbligatorio.');

  // controllo univocità di chiave
  FOperazioneSG220:=IfThen(DataSet.State = dsInsert,'I','M');
  if FOperazioneSG220 = 'I' then
  begin
    if QueryPK1.EsisteChiave('SG220_ORDPROFSAN_ISCRIZ','',dsInsert,['PROGRESSIVO','COD_ORDINE'],[IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger),Codice]) then
      raise exception.Create(Format(A000MSG_W047_MSG_FMT_PK,[Codice]));
  end
  else
  begin
    if QueryPK1.EsisteChiave('SG220_ORDPROFSAN_ISCRIZ',selSG220.RowID,dsEdit,['PROGRESSIVO','COD_ORDINE'],[IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger),Codice]) then
      raise exception.Create(Format(A000MSG_W047_MSG_FMT_PK,[Codice]));
  end;

  // imposta proprietà log
  RegistraLog.SettaProprieta(IfThen(DataSet.State = dsInsert,'I','M'),'SG220_ORDPROFSAN_ISCRIZ','W047',DataSet,True);
end;

procedure TW047FIscrizioneOrdineDM.selSG220AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  // refresh del dataset per rieffettuare l'ordinamento dei record
  selSG220.Refresh;
  // controllo per mandare la mail
  if CodiceVariato or IscrizioneVariato or ProvinciaVariata or (FOperazioneSG220 = 'I') then
    if not (Parametri.CampiRiferimento.C36_OrdProfSanEmailVar = '') then
    begin
      InviaEMailVariazione(FOperazioneSG220); // manda mail di comunicazione immissione/variazione
    end;
end;

procedure TW047FIscrizioneOrdineDM.selSG220BeforeDelete(DataSet: TDataSet);
begin
  Codice:=DataSet.FieldByName('COD_ORDINE').AsString;
  Provincia:=DataSet.FieldByName('COD_PROVINCIA').AsString;
  Iscrizione:=DataSet.FieldByName('COD_ISCRIZIONE').AsString;

  // imposta proprietà log
  RegistraLog.SettaProprieta('C','SG220_ORDPROFSAN_ISCRIZ','W047',DataSet,True);
end;

procedure TW047FIscrizioneOrdineDM.selSG220AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  if not (Parametri.CampiRiferimento.C36_OrdProfSanEmailVar = '') then
  begin
    InviaEMailVariazione('D'); // manda mail di comunicazione cancellazione
  end;
end;

procedure TW047FIscrizioneOrdineDM.InviaEMailVariazione(Operazione:String);
var d_Operazione,sOggetto,sTesto: String;
    nTag: Integer;
    C017DtM:TC017FEMailDtM;
begin
  if Trim(Parametri.CampiRiferimento.C36_OrdProfSanEmailVar) = '' then
    exit;
  try

    if Operazione='I' then
      d_Operazione:='INSERIMENTO'
    else if Operazione='D' then
      d_Operazione:='CANCELLAZIONE'
    else if Operazione='M' then
      d_Operazione:='MODIFICA';

    sOggetto:='Variazione - Iscrizione ordine professionale';
    sTesto:=Format('In data %s risulta effettuata un''operazione di %s sul modulo WEB <W047> Iscrizione ordine Professionale ',[Date.ToString('dd/mm/yyyy'),d_Operazione]) + CRLF +
            Format('Soggetto: %s (%s)',[SelAnagrafeW.FieldByName('COGNOME').AsString + ' ' + SelAnagrafeW.FieldByName('NOME').AsString,SelAnagrafeW.FieldByName('MATRICOLA').AsString]);
    // dettaglio variazioni effettuate in corpo mail
    // Inserimento
    if Operazione= 'I' then
      sTesto:= Trim(sTesto) + CRLF +
            Format('Dati inseriti: Codice Ordine %s;',[Codice]) + CRLF +
            Format('Provincia %s;',[Provincia]) + CRLF +
            Format('Numero Iscrizione %s;',[Iscrizione])
    // Cancellazione
    else if Operazione= 'D' then
      sTesto:= Trim(sTesto) + CRLF +
            Format('Dati cancellati: Codice Ordine %s;',[Codice]) + CRLF +
            Format('Provincia %s;',[Provincia]) + CRLF +
            Format('Numero Iscrizione %s;',[Iscrizione])
    // Modifica
    else
    begin
      sTesto:= Trim(sTesto) + CRLF +
                 Format('Dati modificati: Codice Ordine %s;',[Codice]);
      if CodiceVariato then
        sTesto:= Trim(sTesto) + Format(' Valore precedente %s;',[Codice_Old]);

      sTesto:= Trim(sTesto) + CRLF +
                 Format('Provincia %s;',[Provincia]);
      if ProvinciaVariata then
        sTesto:= Trim(sTesto) + Format(' Valore precedente %s ;',[Provincia_Old]);

      sTesto:= Trim(sTesto) + CRLF +
                 Format('Numero Iscrizione %s;',[Iscrizione]);
      if IscrizioneVariato then
        sTesto:= Trim(sTesto) + Format(' Valore precedente %s ;',[Iscrizione_Old]);
    end;

    nTag:=467; //"Iscrizione ordine professionale"
    C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
    try
      C017DtM.SollevaEccezioni:=True;
      C017DtM.Sessione:=SessioneOracle;
      C017DtM.Destinatari:=Parametri.CampiRiferimento.C36_OrdProfSanEmailVar;
      C017DtM.CercaDestinatari:=False;
      C017DtM.Oggetto:=sOggetto;
      C017DtM.Testo:=sTesto;
      C017DtM.TagFunzione:=nTag;
      C017DtM.Iter:='';
      C017DtM.CodIter:='';
      C017DtM.LivelliDest:='';
      C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      C017DtM.InviaEMail;
    finally
      FreeAndNil(C017DtM);
    end;
  except
    on E:Exception do
      W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
  end;
end;

end.
