unit W042UDatiConiugeDM;

interface

uses
  System.SysUtils, System.Classes, Oracle, OracleData, A000UInterfaccia, Data.DB,
  Variants, StrUtils, C180FunzioniGenerali, W000UMessaggi;

type
  TW042FDatiConiugeDM = class(TDataModule)
    selaSG101: TOracleDataSet;
    selT480: TOracleDataSet;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    dsrQ480: TDataSource;
    selT040: TOracleDataSet;
    insSG120: TOracleQuery;
    insSG122: TOracleQuery;
    selcSG101: TOracleDataSet;
    scrSG101: TOracleQuery;
    selbSG101: TOracleDataSet;
    selSG101: TOracleDataSet;
    selSG101COGNOME: TStringField;
    selSG101NOME: TStringField;
    selSG101SESSO: TStringField;
    selSG101DATANAS: TDateTimeField;
    selSG101COMNAS: TStringField;
    selSG101D_COMUNE: TStringField;
    selSG101D_PROVINCIA: TStringField;
    selSG101CODFISCALE: TStringField;
    selSG101DATAMAT: TDateTimeField;
    selSG101DATASEP: TDateTimeField;
    selSG101MOTIVO_ESCLUSIONE: TStringField;
    selSG101DATA_REG: TDateTimeField;
    selSG101MESSAGGI: TStringField;
    selSG101MIN_INI: TDateTimeField;
    selSG101MAX_FIN: TDateTimeField;
    selSG101GRADOPAR: TStringField;
    selSG101PROGRESSIVO: TFloatField;
    selSG101INSERIMENTO_CU: TStringField;
    selSG101NUMORD: TFloatField;
    selSG101ACARICO_OGGI: TStringField;
    selSG101ACARICO_STORIA: TStringField;
    selSG101GIUSTIFICATIVI: TStringField;
    selSG101MATRICOLA: TStringField;
    selSG101ANOMALIE: TStringField;
    selSG101INFOW: TStringField;
    selSG101INFOI: TStringField;
    selSG101SITUAZIONE: TStringField;
    selSG101INFOANOMALIE: TStringField;
    delSG101: TOracleQuery;
    selSG101NUCLEO_STORIA: TStringField;
    selSG101COMPONENTE_ANF: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selSG101CalcFields(DataSet: TDataSet);
    procedure selSG101NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    function Controlli:String;
    function PeriodiIntersecanti:Boolean;
    function ControlloCampiObbligatori:String;
    function GetDisplayLabel(NomeCampo:String):String;
  public
    { Public declarations }
    selAnagrafeW: TOracleDataSet;
    procedure Registrazione(Operazione:String);
  end;

var
  W042FDatiConiugeDM: TW042FDatiConiugeDM;

const sObbl = ' (*)';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TW042FDatiConiugeDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  selT480.SetVariable('ORDERBY','ORDER BY CITTA');
  selT480.Open;
end;

procedure TW042FDatiConiugeDM.selSG101CalcFields(DataSet: TDataSet);
var sAnomalie,sInfoW,sInfoI,sSituazione:String;
begin
  selT480.Filtered:=False;
  DataSet.FieldByName('D_COMUNE').AsString:=VarToStr(selT480.Lookup('CODICE',DataSet.FieldByName('COMNAS').AsString,'CITTA'));
  DataSet.FieldByName('D_PROVINCIA').AsString:=VarToStr(selT480.Lookup('CODICE',DataSet.FieldByName('COMNAS').AsString,'PROVINCIA'));
  if DataSet.FieldByName('ACARICO_OGGI').AsString = 'S' then
    sSituazione:=A000MSG_W042_MSG_DETRAZIONI_IRPEF_OGGI
  else
  begin
    sAnomalie:=Controlli;
    if sAnomalie = '' then
    begin
      if DataSet.FieldByName('INSERIMENTO_CU').AsString = 'N' then
        sInfoW:=A000MSG_W042_MSG_CONFERMARE_DATI
      else if (DataSet.FieldByName('MIN_INI').AsDateTime <= Trunc(R180SysDate(SessioneOracle)))
          and (DataSet.FieldByName('MAX_FIN').AsDateTime >= Trunc(R180SysDate(SessioneOracle))) then
        sInfoI:=A000MSG_W042_MSG_EFFETTUARE_SOLO_VARIAZIONI;
    end;
    if DataSet.FieldByName('ACARICO_STORIA').AsString = 'S' then
      sSituazione:=A000MSG_W042_MSG_DETRAZIONI_IRPEF_STORIA + ' ' + A000MSG_W042_MSG_CONTATTARE_UFFICIO
    else if DataSet.FieldByName('NUCLEO_STORIA').AsString = 'S' then
      sSituazione:=Format(A000MSG_W042_MSG_FMT_NUCLEO_ANF_STORIA,
                          [IfThen((DataSet.FieldByName('COMPONENTE_ANF').AsString = 'S') and DataSet.FieldByName('DATASEP').IsNull,'Il','In passato, il'),
                           IfThen((DataSet.FieldByName('COMPONENTE_ANF').AsString = 'S') and DataSet.FieldByName('DATASEP').IsNull,'è','è stato')]) +
                   ' ' + A000MSG_W042_MSG_CONTATTARE_UFFICIO
    else if not DataSet.FieldByName('MATRICOLA').IsNull then
      sSituazione:=A000MSG_W042_MSG_CONIUGE_DIPENDENTE + ' ' + A000MSG_W042_MSG_CONTATTARE_UFFICIO
    else if DataSet.FieldByName('GIUSTIFICATIVI').AsString = 'S' then
      sSituazione:=A000MSG_W042_MSG_GIUSTIFICATIVI_DATANAS + ' ' + A000MSG_W042_MSG_CONTATTARE_UFFICIO;
  end;
  DataSet.FieldByName('ANOMALIE').AsString:=sAnomalie;
  DataSet.FieldByName('INFOW').AsString:=sInfoW;
  DataSet.FieldByName('INFOI').AsString:=sInfoI;
  DataSet.FieldByName('SITUAZIONE').AsString:=sSituazione;
  DataSet.FieldByName('INFOANOMALIE').AsString:=Trim(sAnomalie + CRLF + sInfoW + CRLF + sInfoI);
  DataSet.FieldByName('MESSAGGI').AsString:=Trim(DataSet.FieldByName('INFOANOMALIE').AsString + CRLF +
                                                 IfThen(DataSet.FieldByName('ACARICO_OGGI').AsString = 'S',sSituazione));
end;

procedure TW042FDatiConiugeDM.selSG101NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  DataSet.FieldByName('GRADOPAR').AsString:='CG';
  DataSet.FieldByName('SESSO').AsString:=IfThen(selAnagrafeW.FieldByName('SESSO').AsString = 'F','M','F');
end;

function TW042FDatiConiugeDM.Controlli:String;
var CampoObbl,sCodiceFiscale:String;
begin
  Result:='';
  with selSG101 do
  begin
    if (State <> dsInsert) and PeriodiIntersecanti then
    begin
      Result:=A000MSG_W042_ERR_PERIODI_INTERSECANTI;
      exit;
    end;
    CampoObbl:=ControlloCampiObbligatori;
    if CampoObbl <> '' then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_CAMPO_OBBLIGATORIO,[CampoObbl]);
      exit;
    end;
    if (FieldByName('DATANAS').AsDateTime >= Trunc(R180SysDate(SessioneOracle)))
    or (FieldByName('DATAMAT').AsDateTime >= Trunc(R180SysDate(SessioneOracle)))
    or (FieldByName('DATASEP').AsDateTime >= Trunc(R180SysDate(SessioneOracle))) then
    begin
      Result:=A000MSG_W042_ERR_FMT_DATE_PASSATE;
      exit;
    end;
    if FieldByName('DATAMAT').AsDateTime <= FieldByName('DATANAS').AsDateTime then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_DATE_ORDINATE,[GetDisplayLabel('DATAMAT'),GetDisplayLabel('DATANAS')]);
      exit;
    end;
    if not FieldByName('DATASEP').IsNull and (FieldByName('DATASEP').AsDateTime <= FieldByName('DATAMAT').AsDateTime) then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_DATE_ORDINATE,[GetDisplayLabel('DATASEP'),GetDisplayLabel('DATAMAT')]);
      exit;
    end;
    if (State = dsInsert) and PeriodiIntersecanti then
    begin
      Result:=A000MSG_W042_ERR_PERIODI_INTERSECANTI;
      exit;
    end;
    if (FieldByName('DATASEP').IsNull and not FieldByName('MOTIVO_ESCLUSIONE').IsNull)
    or (FieldByName('MOTIVO_ESCLUSIONE').IsNull and not FieldByName('DATASEP').IsNull) then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_ESCLUSIONE,[GetDisplayLabel('DATASEP'),GetDisplayLabel('MOTIVO_ESCLUSIONE')]);
      exit;
    end;
    if FieldByName('MOTIVO_ESCLUSIONE').AsString = '9' then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_CAMPO_ERRATO,[GetDisplayLabel('MOTIVO_ESCLUSIONE')]);
      exit;
    end;
    if not selT480.SearchRecord('CODICE',FieldByName('COMNAS').AsString,[srFromBeginning]) then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_CAMPO_ERRATO,[GetDisplayLabel('D_COMUNE')]);
      exit;
    end;
    sCodiceFiscale:=R180CalcoloCodiceFiscale(FieldByName('COGNOME').AsString,
                                             FieldByName('NOME').AsString,
                                             FieldByName('SESSO').AsString,
                                             selT480.FieldByName('CODCATASTALE').AsString,
                                             FieldByName('DATANAS').AsDateTime);
    if FieldByName('CODFISCALE').AsString <> sCodiceFiscale then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_CODFISCALE,[FieldByName('CODFISCALE').AsString,sCodiceFiscale]);
      exit;
    end;
    if FieldByName('CODFISCALE').AsString = selAnagrafeW.FieldByName('CODFISCALE').AsString then
    begin
      Result:=A000MSG_W042_ERR_CODFISCALE_DIP;
      exit;
    end;
    R180SetVariable(selbSG101,'Progressivo',FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selbSG101,'CodFiscale',FieldByName('CODFISCALE').AsString);
    R180SetVariable(selbSG101,'NumOrd',FieldByName('NUMORD').AsInteger);
    selbSG101.Open;
    selbSG101.First;
    if not selbSG101.Eof then
    begin
      Result:=Format(A000MSG_W042_ERR_FMT_CODFISCALE_DOPPIO,[selbSG101.FieldByName('GRADO').AsString]);
      exit;
    end;
  end;
end;

function TW042FDatiConiugeDM.PeriodiIntersecanti:Boolean;
var DataMat,DataSep: TDateTime;
begin
  Result:=False;
  if not selSG101.FieldByName('DATAMAT').IsNull then
    DataMat:=selSG101.FieldByName('DATAMAT').AsDateTime
  else if not selSG101.FieldByName('MIN_INI').IsNull then
    DataMat:=selSG101.FieldByName('MIN_INI').AsDateTime
  else
    DataMat:=EncodeDate(1900,1,1);
  if not selSG101.FieldByName('DATASEP').IsNull then
    DataSep:=selSG101.FieldByName('DATASEP').AsDateTime
  else
    DataSep:=EncodeDate(3999,12,31);
  R180SetVariable(selaSG101,'Progressivo',selSG101.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(selaSG101,'NumOrd',selSG101.FieldByName('NUMORD').AsInteger);
  with selaSG101 do
  begin
    Open;
    First;
    while not Eof do
    begin
      if (FieldByName('MIN_INI').AsDateTime <= DataSep)
      and (FieldByName('MAX_FIN').AsDateTime >= DataMat) then
      begin
        Result:=True;
        Break;
      end;
      selaSG101.Next;
    end;
  end;
end;

function TW042FDatiConiugeDM.ControlloCampiObbligatori:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to selSG101.FieldCount - 1 do
    if (Pos(sObbl,selSG101.Fields[i].DisplayLabel) > 0)
    and (Trim(selSG101.Fields[i].AsString) = '') then
    begin
      Result:=GetDisplayLabel(selSG101.Fields[i].FieldName);
      Exit;
    end;
end;

function TW042FDatiConiugeDM.GetDisplayLabel(NomeCampo:String):String;
begin
  Result:=StringReplace(selSG101.FieldByName(NomeCampo).DisplayLabel,sObbl,'',[rfReplaceAll]);
end;

procedure TW042FDatiConiugeDM.Registrazione(Operazione:String);
var sCognome,sNome,sSesso,sComuneNascita,sCodiceFiscale,sCapNas,sMotivoEsclusione: String;
    dDataNascita,dDataMatrimonio,dDataEsclusione,dDataAgg: TDateTime;
    iProg,iNumOrd: Integer;
begin
  with selSG101 do
  begin
    iProg:=FieldByName('PROGRESSIVO').AsInteger;
    sCognome:=FieldByName('COGNOME').AsString;
    sNome:=FieldByName('NOME').AsString;
    sComuneNascita:=FieldByName('COMNAS').AsString;
    dDataNascita:=FieldByName('DATANAS').AsDateTime;
    dDataMatrimonio:=FieldByName('DATAMAT').AsDateTime;
    if FieldByName('DATASEP').IsNull then
      dDataEsclusione:=0
    else
      dDataEsclusione:=FieldByName('DATASEP').AsDateTime;
    sSesso:=FieldByName('SESSO').AsString;
    sCodiceFiscale:=FieldByName('CODFISCALE').AsString;
    sCapNas:=selT480.FieldByName('CAP').AsString;
    sMotivoEsclusione:=FieldByName('MOTIVO_ESCLUSIONE').AsString;
    iNumOrd:=FieldByName('NUMORD').AsInteger;
    (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
    if Operazione <> 'D' then*)
      Cancel;
  end;
  //REGISTRAZIONI
  try
    (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
    if Operazione = 'D' then
    //Cancellazione (D)
    begin
      //Si cancellano tutti i periodi storici
      delSG101.ClearVariables;
      delSG101.SetVariable('Progressivo',iProg);
      delSG101.SetVariable('NumOrd',iNumOrd);
      delSG101.Execute;
    end
    else
    begin*)
      //Inserimento (I) o Modifica (U)
      if Operazione = 'I' then
      begin
        //Recupero il nuovo numord
        selcSG101.Close;
        selcSG101.SetVariable('Progressivo',iProg);
        selcSG101.Open;
        iNumOrd:=selcSG101.FieldByName('NUMORD_NEW').AsInteger;
      end;
      //Si memorizzano i dati su tutti i periodi storici e si imposta “Inserimento su CU”=S
      scrSG101.ClearVariables;
      scrSG101.SetVariable('Inserimento',IfThen(Operazione = 'I','S','N'));
      scrSG101.SetVariable('Progressivo',iProg);
      scrSG101.SetVariable('NumOrd',iNumOrd);
      scrSG101.SetVariable('Decorrenza',R180InizioMese(dDataMatrimonio));
      scrSG101.SetVariable('Cognome',sCognome);
      scrSG101.SetVariable('Nome',sNome);
      scrSG101.SetVariable('ComNas',sComuneNascita);
      scrSG101.SetVariable('DataNas',dDataNascita);
      scrSG101.SetVariable('DataMat',dDataMatrimonio);
      if dDataEsclusione <> 0 then
        scrSG101.SetVariable('DataSep',dDataEsclusione);
      scrSG101.SetVariable('Sesso',sSesso);
      scrSG101.SetVariable('CodFiscale',sCodiceFiscale);
      scrSG101.SetVariable('CapNas',sCapNas);
      scrSG101.SetVariable('Motivo_Esclusione',sMotivoEsclusione);
      scrSG101.Execute;
    (*end;*)
    //Registro l'avvenuta conferma dei dati da parte del dipendente
    dDataAgg:=Now;
    //Testata
    insSG120.SetVariable('Progressivo',iProg);
    insSG120.SetVariable('Data_Agg',dDataAgg);
    insSG120.Execute;
    //Dettaglio
    insSG122.ClearVariables;
    insSG122.SetVariable('Progressivo',iProg);
    insSG122.SetVariable('Data_Agg',dDataAgg);
    insSG122.SetVariable('NumOrd',iNumOrd);
    insSG122.SetVariable('Cognome',sCognome);
    insSG122.SetVariable('Nome',sNome);
    insSG122.SetVariable('DataNas',dDataNascita);
    (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
    insSG122.SetVariable('Manca_Coniuge',IfThen(Operazione = 'D','S',''));*)
    insSG122.SetVariable('CodFiscale',sCodiceFiscale);
    insSG122.SetVariable('Sesso',sSesso);
    insSG122.SetVariable('ComNas',sComuneNascita);
    insSG122.SetVariable('DataMat',dDataMatrimonio);
    if dDataEsclusione <> 0 then
      insSG122.SetVariable('DataSep',dDataEsclusione);
    insSG122.SetVariable('Motivo_Esclusione',sMotivoEsclusione);
    insSG122.Execute;
    SessioneOracle.Commit;
    (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
    R180MessageBox(IfThen(Operazione = 'D',A000MSG_W042_MSG_CANCELLAZIONE_OK,A000MSG_W042_MSG_REGISTRAZIONE_OK),'INFORMA');*)
    R180MessageBox(A000MSG_W042_MSG_REGISTRAZIONE_OK,'INFORMA');
  except
    (*DA 10/03/2016: Per ora non gestire la cancellazione del coniuge; valutare in futuro.
    R180MessageBox(IfThen(Operazione = 'D',A000MSG_W042_MSG_CANCELLAZIONE_KO,A000MSG_W042_MSG_REGISTRAZIONE_KO),'INFORMA');*)
    R180MessageBox(A000MSG_W042_MSG_REGISTRAZIONE_KO,'INFORMA');
  end;
end;

end.
