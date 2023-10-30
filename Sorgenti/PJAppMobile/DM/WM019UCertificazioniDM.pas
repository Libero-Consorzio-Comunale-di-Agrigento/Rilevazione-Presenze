unit WM019UCertificazioniDM;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, Generics.Collections, WM000UDataModuleBaseDM, Data.DB, OracleData, A000USessione,
  Oracle, C180FunzioniGenerali, System.Math, WR002UIterDM, C018UIterAutDM;

type
  TRichiestaCertificazione = class(TObject)
  public
    Progressivo: Integer;
    Id: Integer;
    IdModello: Integer;
    CodModello: String;
    Data: TDateTime;
    Definitiva: Boolean;
    Dal: TDateTime;
    Al: TDateTime;
    Note: String;
  end;

  TModelloCertificazione = class(TObject)
  public
    Id: Integer;
    Codice: String;
    Descrizione: String;
    Autocertificazione: String;
    UM: String;
    Periodo: String;
    Quantita: Integer;
    PeriodoModificabile: String;
    Ordine: Variant;
  end;

type
  TWM019FCertificazioniDM = class(TWR002FIterDM)
    selSG230: TOracleDataSet;
    selSG230ID: TFloatField;
    selSG230ID_REVOCA: TFloatField;
    selSG230ID_REVOCATO: TFloatField;
    selSG230PROGRESSIVO: TFloatField;
    selSG230NOMINATIVO: TStringField;
    selSG230MATRICOLA: TStringField;
    selSG230SESSO: TStringField;
    selSG230COD_ITER: TStringField;
    selSG230TIPO_RICHIESTA: TStringField;
    selSG230D_TIPO_RICHIESTA: TStringField;
    selSG230D_RESPONSABILE: TStringField;
    selSG230D_AUTORIZZAZIONE: TStringField;
    selSG230D_STATO: TStringField;
    selSG230AUTORIZZ_AUTOMATICA: TStringField;
    selSG230REVOCABILE: TStringField;
    selSG230DATA_RICHIESTA: TDateTimeField;
    selSG230LIVELLO_AUTORIZZAZIONE: TFloatField;
    selSG230DATA_AUTORIZZAZIONE: TDateTimeField;
    selSG230AUTORIZZAZIONE: TStringField;
    selSG230NOMINATIVO_RESP: TStringField;
    selSG230AUTORIZZ_AUTOM_PREV: TStringField;
    selSG230AUTORIZZ_PREV: TStringField;
    selSG230RESPONSABILE_PREV: TStringField;
    selSG230AUTORIZZ_UTILE: TStringField;
    selSG230AUTORIZZ_REVOCA: TStringField;
    selSG230MSGAUT_SI: TStringField;
    selSG230MSGAUT_NO: TStringField;
    selSG230COD_MODELLO: TStringField;
    selSG230DESC_MODELLO: TStringField;
    selSG230DAL: TDateTimeField;
    selSG230AL: TDateTimeField;
    selSG230DESCRIZIONE: TStringField;
    selSG230ID_CERTIFICAZIONE: TFloatField;
    selSG235: TOracleDataSet;
    selSG237CampiInput: TOracleQuery;
    selSG235c: TOracleDataSet;
    selSG235b: TOracleDataSet;
    selQueryPeriodo: TOracleQuery;
    selQueryVSG230: TOracleQuery;
    procedure selSG230CalcFields(DataSet: TDataSet);
    procedure selSG230FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    function GetListaModelli: TObjectList<TModelloCertificazione>;
    function GetListaModelliDisponibili(PProgressivo: Integer): TObjectList<TModelloCertificazione>;
    function GetPeriodoDefault(PPeriodo: String): TPair<TDateTime, TDateTime>;
    function VerificaCertificazioneValida(PProgressivo: Integer; PCodModello: String): Boolean;
    function VerificaInputPresenti(PId: Integer; PCodModello: String): Boolean;
    function ControlliPeriodo(PRichiesta: TRichiestaCertificazione; PRowId: String; pQ: Integer; pUM: Char; var Messaggio: String): Boolean;
    procedure InserisciRichiesta(PRichiesta: TRichiestaCertificazione);
    procedure ModificaRichiesta(PRichiesta: TRichiestaCertificazione);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWM019FCertificazioniDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selIter:=selSG230;
end;

procedure TWM019FCertificazioniDM.selSG230CalcFields(DataSet: TDataSet);
var S: String;
begin
  with selSG230 do
  begin
    if FieldByName('TIPO_RICHIESTA').AsString = '' then
      FieldByName('D_TIPO_RICHIESTA').AsString:='Da confermare'
    else if FieldByName('TIPO_RICHIESTA').AsString = 'D' then
      FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';
    // D_AUTORIZZAZIONE: descr. autorizzazione
    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_AUTORIZZAZIONE').AsString:=S;

    // D_RESPONSABILE: nominativo responsabile
    FieldByName('D_RESPONSABILE').AsString:=Trim(FieldByName('NOMINATIVO_RESP').AsString);

    // D_STATO: descr. stato
    if FieldByName('AUTORIZZAZIONE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZAZIONE').AsString = 'N' then
      S:='No'
    else
      S:='Si';
    FieldByName('D_STATO').AsString:=S;
  end;
end;

procedure TWM019FCertificazioniDM.selSG230FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('MODELLI DI CERTIFICAZIONE', DataSet.FieldByName('COD_MODELLO').AsString);
end;

procedure TWM019FCertificazioniDM.InserisciRichiesta(PRichiesta: TRichiestaCertificazione);
begin
  with selSG230 do
  begin
    if Active then
    begin
      Append;
      FieldByName('PROGRESSIVO').AsInteger:=PRichiesta.Progressivo;
      FieldByName('ID_CERTIFICAZIONE').AsInteger:=PRichiesta.IdModello;
      if PRichiesta.Dal > 0 then
        FieldByName('DAL').AsDateTime:=PRichiesta.Dal;
      if PRichiesta.Al > 0 then
        FieldByName('AL').AsDateTime:=PRichiesta.Al;
      FieldByName('DESCRIZIONE').AsString:=PRichiesta.Note;
    end;
  end;
end;

procedure TWM019FCertificazioniDM.ModificaRichiesta(PRichiesta: TRichiestaCertificazione);
begin
  with selSG230 do
  begin
    if Locate('ID', PRichiesta.Id, []) then
    begin
      Edit;
      FieldByName('ID_CERTIFICAZIONE').AsInteger:=PRichiesta.IdModello;

      if PRichiesta.Dal > 0 then
        FieldByName('DAL').AsDateTime:=PRichiesta.Dal
      else
        FieldByName('DAL').Clear;

      if PRichiesta.Al > 0 then
        FieldByName('AL').AsDateTime:=PRichiesta.Al
      else
        FieldByName('AL').Clear;

      FieldByName('DESCRIZIONE').AsString:=PRichiesta.Note;
    end
    else
      raise Exception.Create('Richiesta da modificare non trovata');
  end;
end;

function TWM019FCertificazioniDM.GetListaModelli: TObjectList<TModelloCertificazione>;
var temp: TModelloCertificazione;
begin
  Result:=TObjectList<TModelloCertificazione>.Create(True);
  try
    with selSG235c do
    begin
      Close;
      Open;
      First;
      while not Eof do
      begin
        temp:=TModelloCertificazione.Create;
        temp.Id:=FieldByName('ID').AsInteger;
        temp.Codice:=FieldByName('CODICE').AsString;
        temp.Descrizione:=FieldByName('DESCRIZIONE').AsString;
        temp.Autocertificazione:=FieldByName('AUTOCERTIFICAZIONE').AsString;
        temp.UM:=FieldByName('UM').AsString;
        temp.Periodo:=FieldByName('PERIODO').AsString;
        temp.Quantita:=FieldByName('QUANTITA').AsInteger;
        temp.PeriodoModificabile:=FieldByName('PERIODO_MODIFICABILE').AsString;
        temp.Ordine:=FieldByName('ORDINE').AsVariant;

        Result.Add(temp);
        Next;
      end;
      Close;
    end;
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TWM019FCertificazioniDM.GetListaModelliDisponibili(PProgressivo: Integer): TObjectList<TModelloCertificazione>;
var temp: TModelloCertificazione;
begin
  Result:=TObjectList<TModelloCertificazione>.Create(True);
  try
    with selSG235 do
    begin
      Close;
      SetVariable('PROGRESSIVO', PProgressivo);
      Open;
      First;
      while not Eof do
      begin
        temp:=TModelloCertificazione.Create;
        temp.Id:=FieldByName('ID').AsInteger;
        temp.Codice:=FieldByName('CODICE').AsString;
        temp.Descrizione:=FieldByName('DESCRIZIONE').AsString;
        temp.Autocertificazione:=FieldByName('AUTOCERTIFICAZIONE').AsString;
        temp.UM:=FieldByName('UM').AsString;
        temp.Periodo:=FieldByName('PERIODO').AsString;
        temp.Quantita:=FieldByName('QUANTITA').AsInteger;
        temp.PeriodoModificabile:=FieldByName('PERIODO_MODIFICABILE').AsString;
        temp.Ordine:=FieldByName('ORDINE').AsVariant;

        Result.Add(temp);
        Next;
      end;
      Close;
    end;
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TWM019FCertificazioniDM.GetPeriodoDefault(PPeriodo: String): TPair<TDateTime, TDateTime>;
var Dal, Al: TDateTime;
begin
  with selQueryPeriodo do
  begin
    SetVariable('PERIODO', PPeriodo);
    Execute;

    Dal:=FieldAsDate(0);
    if FieldCount = 1 then
      Al:=FieldAsDate(0)
    else
      Al:=FieldAsDate(1);

    Result:=TPair<TDateTime, TDateTime>.Create(Dal, Al);
  end;
end;

function TWM019FCertificazioniDM.VerificaCertificazioneValida(PProgressivo: Integer; PCodModello: String): Boolean;
begin
  with selSG235 do
  begin
    Close;
    SetVariable('PROGRESSIVO', PProgressivo);
    Open;
    Result:=Locate('CODICE', PCodModello,[]);
    Close;
  end;
end;

function TWM019FCertificazioniDM.VerificaInputPresenti(PId: Integer; PCodModello: String): Boolean;
begin
  with selSG237CampiInput do
  begin
    if PId > 0 then
      selSG237CampiInput.SetVariable('ID', IntToStr(PId))
    else
      selSG237CampiInput.SetVariable('ID', '(select b.ID from sg235_modelli_certificazioni b where b.codice=''' + PCodModello + ''')');

    selSG237CampiInput.Execute;
    Result:=selSG237CampiInput.FieldAsInteger(0) <> 0;
  end;
end;

function TWM019FCertificazioniDM.ControlliPeriodo(PRichiesta: TRichiestaCertificazione; PRowId: String; pQ: Integer; pUM: Char; var Messaggio: String): Boolean;
var
  strErr, strInfo: string;
  Dal, Al: TDateTime;
  DataI, DataF : String;
  DATA_IMin, DATA_IMax: String;
  cntCert: integer;
begin
  strErr:='';
  strInfo:='(Scheda informativa non ripetibile entro ';
  //Controllo intersezione periodo
  Dal:=IfThen(PRichiesta.Dal>0,PRichiesta.Dal,PRichiesta.Data);
  Al:=IfThen(PRichiesta.Al>0,PRichiesta.Al,PRichiesta.Data);
  DataI:= 'to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy'')';
  DataF:= 'to_date(''' + DateToStr(Al) + ''', ''dd/mm/yyyy'')';

  //Controllo distanza da inizio period
  case pUM of
    'D': begin
    DATA_IMin:='to_date(''' + DateToStr(Dal-pQ) + ''', ''dd/mm/yyyy'')';
    DATA_IMax:='to_date(''' + DateToStr(Dal+pQ) + ''', ''dd/mm/yyyy'')';
    strInfo:=strInfo + IntToStr(pQ) + ' giorni)';
    end;

    'W': begin
    DATA_IMin:='to_date(''' + DateToStr(Dal-pQ*7) + ''', ''dd/mm/yyyy'')';
    DATA_IMax:='to_date(''' + DateToStr(Dal+pQ*7) + ''', ''dd/mm/yyyy'')';
    strInfo:=strInfo + IntToStr(pQ) + ' settimane)';
    end;

    'M': begin
    DATA_IMin:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''),- ' + IntToStr(pQ)+ ')';
    DATA_IMax:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''), ' + IntToStr(pQ)+ ')';
    strInfo:=strInfo + IntToStr(pQ) + ' mesi)';
    end;

    'Y': begin
    DATA_IMin:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''),- ' + IntToStr(pQ*12)+ ')';
    DATA_IMax:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''), ' + IntToStr(pQ*12)+ ')';
    strInfo:=strInfo + IntToStr(pQ) + ' anni)';
    end;

    else begin
    Result:=False;
    Exit;
    end;
  end;
  with selQueryVSG230 do
  begin
    SetVariable('DATA_I',DataI);
    SetVariable('DATA_F',DataF);
    SetVariable('DATA_IMin',DATA_IMin);
    SetVariable('DATA_IMax',DATA_IMax);

    if PRowId <> '' then
      SetVariable('ROWID_T', ' and T.ROWID_T <> ' + '''' + PRowId + '''')
    else
      SetVariable('ROWID_T', '');
    SetVariable('ID',PRichiesta.ID);
    SetVariable('PROGR', PRichiesta.Progressivo);
    Execute;
    if RowCount > 0 then
    begin
      cntCert:=0;
      while not (eof) and (cntCert < 100) do //Controllo di uscita su cntCert per sicurezza
      begin
        if cntCert < 3 then
        begin
          strErr:=strErr + CRLF + '- ' + FieldAsString(0);
          strErr:=strErr + ' del ' + FieldAsString(1);
          if (FieldAsString(2) <> '') and (FieldAsString(3) <> '') then
          strErr:=strErr + ' valida dal ' + FieldAsString(2) + ' al ' + FieldAsString(3);
        end
        else if cntCert = 3 then
          strErr:=strErr + CRLF + '-  .....';
        inc(cntCert);
        Next;
      end;
      strErr:=strErr + CRLF + strInfo;
      Messaggio:='Scheda informativa non ammessa perchè ripetuta nel periodo di ' + IntToStr(RowCount) + ' scheda informative:'  + strErr;

      Result:=False;
    end
    else
      Result:=True;
  end;
end;

end.
