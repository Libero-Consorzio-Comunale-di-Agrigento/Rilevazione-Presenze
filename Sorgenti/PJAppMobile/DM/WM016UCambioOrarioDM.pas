unit WM016UCambioOrarioDM;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, A000USessione,
  Data.DB, OracleData, C180FunzioniGenerali, StrUtils, Variants, Rp502Pro, C018UIterAutDM,
  Oracle, Generics.Collections, Generics.Defaults, WM000UTypes, WR002UIterDM;

type
  TModalitaRichiesta = (mrCambioOrario, mrInversioneGiorno);

  TRichiestaCambioOrario = class(TObject)
  public
    Progressivo: Integer;
    Data: TDateTime;
    DataInver: TDateTime;
    TipoGiorno: String;
    TipoGiornoInver: String;
    CodOrario: String;
    CodOrarioInver: String;
    SoloNote: Boolean;
    Note: String;
  end;

type
  TWM016FCambioOrarioDM = class(TWR002FIterDM)
    selaT020: TOracleDataSet;
    selT080: TOracleDataSet;
    selV010: TOracleDataSet;
    selT012: TOracleDataSet;
    selOrario: TOracleQuery;
    selOrario2: TOracleDataSet;
    selT020: TOracleDataSet;
    selaT085: TOracleQuery;
    selT085: TOracleDataSet;
    selT085ID: TFloatField;
    selT085ID_REVOCA: TFloatField;
    selT085ID_REVOCATO: TFloatField;
    selT085PROGRESSIVO: TIntegerField;
    selT085NOMINATIVO: TStringField;
    selT085MATRICOLA: TStringField;
    selT085SESSO: TStringField;
    selT085COD_ITER: TStringField;
    selT085TIPO_RICHIESTA: TStringField;
    selT085AUTORIZZ_AUTOMATICA: TStringField;
    selT085REVOCABILE: TStringField;
    selT085DATA_RICHIESTA: TDateTimeField;
    selT085LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT085DATA_AUTORIZZAZIONE: TDateTimeField;
    selT085AUTORIZZAZIONE: TStringField;
    selT085NOMINATIVO_RESP: TStringField;
    selT085AUTORIZZ_AUTOM_PREV: TStringField;
    selT085AUTORIZZ_PREV: TStringField;
    selT085RESPONSABILE_PREV: TStringField;
    selT085AUTORIZZ_UTILE: TStringField;
    selT085AUTORIZZ_REVOCA: TStringField;
    selT085D_TIPO_RICHIESTA: TStringField;
    selT085D_RESPONSABILE: TStringField;
    selT085D_AUTORIZZAZIONE: TStringField;
    selT085DATA: TDateTimeField;
    selT085TIPOGIORNO: TStringField;
    selT085ORARIO: TStringField;
    selT085DATA_INVER: TDateTimeField;
    selT085TIPOGIORNO_INVER: TStringField;
    selT085ORARIO_INVER: TStringField;
    selT085SOLO_NOTE: TStringField;
    selT085MESSAGGI: TStringField;
    selT085D_ORARIO: TStringField;
    selT085D_ORARIO_INVER: TStringField;
    selT085MSGAUT_SI: TStringField;
    selT085MSGAUT_NO: TStringField;
    procedure selT085CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetDescrizioneOrario(Orario: String; Data: TDateTime): String;
    function RicavaColoreGiorno(Prog: Integer; Data: TDateTime; Stile: String): String;
  public
    function EsisteRichiesta(PRowId: String): Boolean; overload;
    function EsisteRichiesta(PProgressivo: Integer; PData: TDateTime): Boolean; overload;

    procedure AddOrariCambioOrario(POrario: String; PData: TDateTime; var PListaOrari: TList<TPair<String, String>>);
    procedure AddOrariProfilo(PProgressivo: Integer; PData: TDateTime; var PListaOrari: TList<TPair<String, String>>);
    procedure AddOrariAbilitati(POrario: String; PData: TDateTime; var PListaOrari: TList<TPair<String, String>>);

    function GetOrarioValido(PProgressivo:Integer; PData: TDateTime): TPair<String, String>;
    function GetOrarioPianificato(PProgressivo: Integer; PData: TDateTime): TPair<String, String>;
    function GetTipoGiorno(PProgressivo:Integer; PData: TDateTime): String;
    function GetGiornoLavorativo(PProgressivo: Integer; PData: TDateTime): String;

    procedure InserisciRichiesta(PRichiesta: TRichiestaCambioOrario; PModalitaRichiesta: TModalitaRichiesta);

    procedure AggiornamentoPianificazioneOrari(PProgressivo: Integer; PGiornoOriginale, PGiornoRichiesto: TDateTime; PCodOrarioOriginale, PCodOrarioRichiesto: String);
    procedure AggiornamentoCalendarioIndividuale(PProgressivo: Integer; PGiornoOriginale, PGiornoRichiesto: TDateTime);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWM016FCambioOrarioDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selIter:=selT085;
end;

procedure TWM016FCambioOrarioDM.selT085CalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
  begin
    FieldByName('D_ORARIO').AsString:=GetDescrizioneOrario(FieldByName('ORARIO').AsString, FieldByName('DATA').AsDateTime);
    FieldByName('D_ORARIO_INVER').AsString:=GetDescrizioneOrario(FieldByName('ORARIO_INVER').AsString, FieldByName('DATA_INVER').AsDateTime);
  end;
end;

function TWM016FCambioOrarioDM.EsisteRichiesta(PProgressivo: Integer; PData: TDateTime): Boolean;
begin
  Result:=False;
  with selaT085 do
  begin
    SetVariable('PROGRESSIVO', PProgressivo);
    SetVariable('DATA', PData);
    Execute;
    if Field(0) > 0 then //count(*) > 0
      Result:=True;
  end;
end;

function TWM016FCambioOrarioDM.EsisteRichiesta(PRowId: String): Boolean;
begin
  if selT085.Active then
  begin
    selT085.Refresh;
    Result:=selT085.SearchRecord('ROWID',PRowId,[srFromBeginning]);
  end
  else
    Result:=False;
end;

//TEO=2
procedure TWM016FCambioOrarioDM.AddOrariCambioOrario(POrario: String; PData: TDateTime; var PListaOrari: TList<TPair<String, String>>);
var LOrariScambio: String;
    LCodOrario: String;
    LTempOrario: TPair<String, String>;
begin
  if not Assigned(PListaOrari) then
    raise Exception.Create('Lista orari da popolare non inizializzata');

  LOrariScambio:='';

  //ricavo la lista con gli orari disponibili per lo scambio
  with selaT020 do
  begin
    Close;
    SetVariable('ORARIO', POrario);
    SetVariable('DATA', PData);
    Open;
    if not Eof then
      LOrariScambio:=Trim(FieldByName('ORARI_SCAMBIO').AsString);
    Close;
  end;

  if LOrariScambio <> '' then
  begin
    LOrariScambio:=LOrariScambio + ',';
    //inserisco nella lista gli orari trovati
    with selT020 do
    begin
      Close;
      Open;

      while Pos(',',LOrariScambio) > 0 do
      begin
        LCodOrario:=Copy(LOrariScambio, 1, Pos(',', LOrariScambio) - 1);

        if Locate('CODICE',LCodOrario,[]) then
        begin
          LTempOrario:=TPair<String, String>.Create(FieldByName('CODICE').AsString, FieldByName('DESCRIZIONE').AsString);

          if not PListaOrari.Contains(LTempOrario) then
            PListaOrari.Add(LTempOrario);
        end;

        LOrariScambio:=Copy(LOrariScambio, Pos(',', LOrariScambio) + 1);
      end;
      Close;
    end;
  end
end;

//TEO=3a
procedure TWM016FCambioOrarioDM.AddOrariProfilo(PProgressivo: Integer; PData: TDateTime; var PListaOrari: TList<TPair<String, String>>);
var LTempOrario: TPair<String, String>;
begin
  if not Assigned(PListaOrari) then
    raise Exception.Create('Lista orari da popolare non inizializzata');

  //Prelevo tutti gli orari del profilo
  with selOrario2 do
  begin
    Close;
    SetVariable('PROGRESSIVO',PProgressivo);
    SetVariable('DATA', PData);
    Open;

    while not Eof do
    begin
      LTempOrario:=TPair<String, String>.Create(FieldByName('CODICE').AsString, GetDescrizioneOrario(FieldByName('CODICE').AsString, PData));

      if not PListaOrari.Contains(LTempOrario) then
        PListaOrari.Add(LTempOrario);
      Next;
    end;
    Close;
  end;
end;

//TEO=3c
procedure TWM016FCambioOrarioDM.AddOrariAbilitati(POrario: String; PData: TDateTime; var PListaOrari: TList<TPair<String, String>>);
var LTempOrario: TPair<String, String>;
begin
  if not Assigned(PListaOrari) then
    raise Exception.Create('Lista orari da popolare non inizializzata');
  //Aggiungo tutti gli orari abilitati (filtro dizionario MODELLI ORARIO)
  with selT020 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      LTempOrario:=TPair<String, String>.Create(FieldByName('CODICE').AsString, FieldByName('DESCRIZIONE').AsString);

      if not PListaOrari.Contains(LTempOrario) then
        PListaOrari.Add(LTempOrario);
      Next;
    end;
    Close;
  end;
end;

function TWM016FCambioOrarioDM.GetDescrizioneOrario(Orario: String; Data: TDateTime): String;
begin
  Result:='';
  with selaT020 do
  begin
    Close;
    SetVariable('ORARIO',Orario);
    SetVariable('DATA',Data);
    Open;
    if not Eof then
      Result:=FieldByName('DESCRIZIONE').AsString;
    Close;
  end;
end;

//TEO=1
function TWM016FCambioOrarioDM.GetOrarioValido(PProgressivo: Integer; PData: TDateTime): TPair<String, String>;
var
  CodOrario, CodOrarioProfilo: String;
  R502ProDtM: TR502ProDtM1;
begin
  with selOrario do
  begin
    //Cerco l'orario pianificato, se non c'è prendo quello del profilo se non ci sono timbrature o se c'è una sola settimana
    SetVariable('PROGRESSIVO',PProgressivo);
    SetVariable('DATA',PData);
    SetVariable('TIPOGIORNO',GetTipoGiorno(PProgressivo,PData));
    SetVariable('NUMGIORNO',IntToStr(DayOfWeek(PData - 1)));
    Execute;
    CodOrario:=VarToStr(GetVariable('ORARIO'));
    CodOrarioProfilo:=VarToStr(GetVariable('ORARIO_PROFILO'));
    //Se non ho ricavato l'orario, lo cerco tramite conteggi
    if CodOrario = '' then
    begin
      R502ProDtM:=TR502ProDtM1.Create(nil);
      try
        R502ProDtM.PeriodoConteggi(PData,PData);
        R502ProDtM.Conteggi('Cartolina',PProgressivo,PData);
        if R502ProDtM.Blocca = 0 then
          CodOrario:=R502ProDtM.c_orario;
      finally
        FreeAndNil(R502ProDtM);
      end;
    end;
    //Se i conteggi non restituiscono un orario valido, prendo quello della prima settimana del profilo
    if CodOrario = '' then
      CodOrario:=CodOrarioProfilo;

    Result:=TPair<String, String>.Create(CodOrario, GetDescrizioneOrario(CodOrario,PData));
  end;
end;

//TEO=3b
function TWM016FCambioOrarioDM.GetOrarioPianificato(PProgressivo: Integer; PData: TDateTime): TPair<String, String>;
begin
  //Aggiungo l'orario pianificato nel giorno
  with selT080 do
  begin
    Close;
    SetVariable('PROGRESSIVO', PProgressivo);
    SetVariable('DATA', PData);
    Open;
    if not Eof then
    begin
      Result.Key:=FieldByName('ORARIO').AsString;
      Result.Value:=GetDescrizioneOrario(FieldByName('ORARIO').AsString, PData);
    end;
    Close;
  end;
end;

function TWM016FCambioOrarioDM.GetTipoGiorno(PProgressivo:Integer; PData: TDateTime): String;
begin
  Result:='';
  with selV010 do
  begin
    Close;
    SetVariable('PROGRESSIVO',PProgressivo);
    SetVariable('DAL',PData);
    SetVariable('AL',PData);
    Open;
    if SearchRecord('Data',PData,[srFromBeginning]) then
      if (FieldByName('FESTIVO').AsString = 'S') and (FieldByName('LAVORATIVO').AsString <> 'S') then
        Result:='T'
      else if FieldByName('FESTIVO').AsString = 'S' then
        Result:='F'
      else if FieldByName('LAVORATIVO').AsString <> 'S' then
        Result:='N'
      else
        Result:=IntToStr(DayOfWeek(PData - 1));
    Close;
  end;
end;

function TWM016FCambioOrarioDM.RicavaColoreGiorno(Prog: Integer; Data: TDateTime; Stile: String): String;
begin
  Result:='';
  with selV010 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DAL',Data);
    SetVariable('AL',Data);
    Open;
    if SearchRecord('Data',Data,[srFromBeginning]) then
      if (FieldByName('FESTIVO').AsString = 'S') and (FieldByName('LAVORATIVO').AsString <> 'S') then
        Result:='bg_aqua'
      else if FieldByName('FESTIVO').AsString = 'S' then
        Result:='bg_giallo'
      else if FieldByName('LAVORATIVO').AsString <> 'S' then
        Result:='bg_lime'
      else
        Result:='bg_white';
  end;
  Result:=Result + ' ' + Stile;
  Result:=Result + IfThen(R180NomeGiorno(Data) = 'Domenica',' ' + 'font_rosso','');
end;

function TWM016FCambioOrarioDM.GetGiornoLavorativo(PProgressivo: Integer; PData: TDateTime): String;
begin
  Result:='';
  with selV010 do
  begin
    Close;
    SetVariable('PROGRESSIVO', PProgressivo);
    SetVariable('DAL', PData);
    SetVariable('AL', PData);
    Open;
    if SearchRecord('DATA',PData,[srFromBeginning]) then
      Result:=FieldByName('LAVORATIVO').AsString;
    Close;
  end;
end;

procedure TWM016FCambioOrarioDM.InserisciRichiesta(PRichiesta: TRichiestaCambioOrario; PModalitaRichiesta: TModalitaRichiesta);
begin
  with selT085 do
  begin
    if Active then
    begin
      Append;
      FieldByName('PROGRESSIVO').AsInteger:=PRichiesta.Progressivo;
      FieldByName('DATA').AsDateTime:=PRichiesta.Data;
      FieldByName('TIPOGIORNO').AsString:=PRichiesta.TipoGiorno;
      FieldByName('SOLO_NOTE').AsString:=IfThen(PRichiesta.SoloNote, 'S', 'N');

      if not PRichiesta.SoloNote then
      begin
        FieldByName('ORARIO').AsString:=PRichiesta.CodOrario;
        FieldByName('DATA_INVER').AsDateTime:=PRichiesta.DataInver;
        FieldByName('ORARIO_INVER').AsString:=PRichiesta.CodOrarioInver;
        FieldByName('TIPOGIORNO_INVER').AsString:=PRichiesta.TipoGiornoInver;
      end;
    end;
  end;
end;

procedure TWM016FCambioOrarioDM.AggiornamentoPianificazioneOrari(PProgressivo: Integer; PGiornoOriginale, PGiornoRichiesto: TDateTime; PCodOrarioOriginale, PCodOrarioRichiesto: String);
begin
  with selT080 do
  begin
    //giorno originale con orario richiesto
    Close;
    SetVariable('PROGRESSIVO', PProgressivo);
    SetVariable('DATA', PGiornoOriginale);
    Open;
    if RecordCount > 0 then
      Edit
    else
      Append;
    FieldByName('PROGRESSIVO').AsInteger:=PProgressivo;
    FieldByName('DATA').AsDateTime:=PGiornoOriginale;
    FieldByName('ORARIO').AsString:=PCodOrarioRichiesto;
    FieldByName('TURNO1').AsString:='';
    FieldByName('TURNO2').AsString:='';
    FieldByName('TURNO1EU').AsString:='';
    FieldByName('TURNO2EU').AsString:='';
    Post;
    if PGiornoRichiesto <> PGiornoOriginale then
    begin
      //giorno richiesto con orario originale
      Close;
      SetVariable('PROGRESSIVO', PProgressivo);
      SetVariable('DATA', PGiornoRichiesto);
      Open;
      if RecordCount > 0 then
        Edit
      else
        Append;
      FieldByName('PROGRESSIVO').AsInteger:=PProgressivo;
      FieldByName('DATA').AsDateTime:=PGiornoRichiesto;
      FieldByName('ORARIO').AsString:=PCodOrarioOriginale;
      FieldByName('TURNO1').AsString:='';
      FieldByName('TURNO2').AsString:='';
      FieldByName('TURNO1EU').AsString:='';
      FieldByName('TURNO2EU').AsString:='';
      Post;
    end;
  end;
end;

procedure TWM016FCambioOrarioDM.AggiornamentoCalendarioIndividuale(PProgressivo: Integer; PGiornoOriginale, PGiornoRichiesto: TDateTime);
begin

  with selV010 do
  begin
    Close;
    SetVariable('PROGRESSIVO', PProgressivo);
    SetVariable('DAL', PGiornoOriginale);
    SetVariable('AL', PGiornoRichiesto);
    Open;
  end;

  if VarToStr(selV010.Lookup('DATA', PGiornoOriginale, 'LAVORATIVO')) <> VarToStr(selV010.Lookup('DATA',PGiornoRichiesto,'LAVORATIVO')) then
  begin
    //giorno originale
    with selT012 do
    begin
      Close;
      SetVariable('DATA',PGiornoOriginale);
      SetVariable('PROGRESSIVO',PProgressivo);
      Open;
      if RecordCount > 0 then
        Edit
      else
        Append;
      FieldByName('PROGRESSIVO').AsInteger:=PProgressivo;
      FieldByName('DATA').AsDateTime:=PGiornoOriginale;
      FieldByName('LAVORATIVO').AsString:=VarToStr(selV010.Lookup('DATA',PGiornoRichiesto,'LAVORATIVO'));
      FieldByName('FESTIVO').AsString:=VarToStr(selV010.Lookup('DATA',PGiornoOriginale,'FESTIVO'));
      FieldByName('NUMGIORNI').AsInteger:=StrToInt(VarToStr(selV010.Lookup('DATA',PGiornoOriginale,'NUMGIORNI')));
      Post;
      //giorno richiesto
      Close;
      SetVariable('DATA',PGiornoRichiesto);
      SetVariable('PROGRESSIVO',PProgressivo);
      Open;
      if RecordCount > 0 then
        Edit
      else
        Append;
      FieldByName('PROGRESSIVO').AsInteger:=PProgressivo;
      FieldByName('DATA').AsDateTime:=PGiornoRichiesto;
      FieldByName('LAVORATIVO').AsString:=VarToStr(selV010.Lookup('DATA',PGiornoOriginale,'LAVORATIVO'));
      FieldByName('FESTIVO').AsString:=VarToStr(selV010.Lookup('DATA',PGiornoRichiesto,'FESTIVO'));
      FieldByName('NUMGIORNI').AsInteger:=StrToInt(VarToStr(selV010.Lookup('DATA',PGiornoRichiesto,'NUMGIORNI')));
      Post;
    end;
  end;
end;

end.
