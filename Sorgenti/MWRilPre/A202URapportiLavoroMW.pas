unit A202URapportiLavoroMW;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.DateUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, OracleData, System.StrUtils, Math,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, C018UIterAutDM, C180FunzioniGenerali, FunzioniGenerali,
  C006UStoriaDati, A000USessione,
  Data.DB, Oracle, RegistrazioneLog, Datasnap.DBClient;

const
  A202GG_3ANNI = 1095;   // dato da 365*3
  A202_Corrente = 'Corrente';

type
  TA202Modalita = (PASSENZE  = 0,  VALIDAZIONE = 1); //, COM = 3);

type

  TA202FRapportiLavoroMW = class(TR005FDataModuleMW)
    selT450: TOracleDataSet;
    selT450CODICE: TStringField;
    selT450DESCRIZIONE: TStringField;
    selT450TIPO: TStringField;
    selT430: TOracleDataSet;
    selT430INIZIO: TDateTimeField;
    selT430FINE: TDateTimeField;
    selT430TIPO_RAPPORTO: TStringField;
    selT430TIPO: TStringField;
    selT430D_TIPO: TStringField;
    dsrT430: TDataSource;
    selT430PROGRESSIVO: TFloatField;
    selT425T430_InizioFine: TOracleDataSet;
    selT430_InizioFine: TOracleDataSet;
    selT261: TOracleDataSet;
    dsrT261: TDataSource;
    scrT430PAssenze: TOracleQuery;
    selT261CODICE: TStringField;
    selT261DESCRIZIONE: TStringField;
    selT450COD_DESC: TStringField;
    cdsProfili: TClientDataSet;
    dsrProfili: TDataSource;
    cdsProfiliDecorrenza: TStringField;
    cdsProfiliTermine: TStringField;
    cdsProfiliValore: TStringField;
    cdsProfiliDescrizione: TStringField;
    cdsProfiliNomeCampo: TStringField;
    cdsProfiliColore: TBooleanField;
    cdsProfiliValorizza: TBooleanField;
    selT460: TOracleDataSet;
    selT460CODICE: TStringField;
    selT460DESCRIZIONE: TStringField;
    selT460TIPO: TStringField;
    selEnte: TOracleDataSet;
    selQualifica: TOracleDataSet;
    selDisciplina: TOracleDataSet;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    selT460PIANTA: TFloatField;
    selT430PARTTIME: TStringField;
    selT430d_ENTE: TStringField;
    selT430QUALIFICA: TStringField;
    selT430d_QUALIFICA: TStringField;
    selT430DISCIPLINA: TStringField;
    selT430d_TIPOPT: TStringField;
    selT430d_DISCIPLINA: TStringField;
    selT430ENTE: TStringField;
    selT430INIZIO_RAPGIUR: TDateTimeField;
    selT430FINE_RAPGIUR: TDateTimeField;
    selRiepilogo: TOracleDataSet;
    selT055: TOracleDataSet;
    selT055PROGRESSIVO: TFloatField;
    selT055VALIDAZIONE: TStringField;
    selT055DAL: TDateTimeField;
    selT055AL: TDateTimeField;
    selT055CAUSALE: TStringField;
    selT055d_CAUSALE: TStringField;
    selT055NOTE: TStringField;
    selT055IDRIGA: TStringField;
    scrT430DatiGiuridici: TOracleQuery;
    dsrT055: TDataSource;
    selRiepilogoG_ALL: TStringField;
    selRiepilogoG_TI: TStringField;
    selRiepilogoG_ALL_NA: TStringField;
    selRiepilogoG_TI_NA: TStringField;
    selRiepilogoDT_ANZ_15: TStringField;
    selRiepilogoDT_ANZ_5: TStringField;
    selRiepilogoG_FTE_ALL: TStringField;
    selRiepilogoG_FTE_NA: TStringField;
    selT430DAL: TDateTimeField;
    selT430AL: TDateTimeField;
    selT430DAL_AP: TDateTimeField;
    selT430AL_AP: TDateTimeField;
    selT425_T050_NA: TOracleDataSet;
    selT425_T050_NAMATRICOLA: TStringField;
    selT425_T050_NACOGNOME: TStringField;
    selT425_T050_NANOME: TStringField;
    drsT425_T050_NA: TDataSource;
    selT425_T050_NAPER_ASP_NA: TFloatField;
    selT425_T050_NARAPP_GIUR_NA: TFloatField;
    selT040: TOracleDataSet;
    selT040DAL: TDateTimeField;
    selT040AL: TDateTimeField;
    selT040CAUSALE: TStringField;
    selT040d_CAUSALE: TStringField;
    dsrT040: TDataSource;
    selT430D_TIPORAPPORTO: TStringField;
    selT430D_PARTTIME: TStringField;
    selT430PERC_PT: TFloatField;
    selT430TIPO_PT: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT430CalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);
    procedure selT055BeforeInsert(DataSet: TDataSet);
    procedure selT055BeforeDelete(DataSet: TDataSet);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    Tabella:String;
    function DecodeTipologiaRapporto(Tipo:String):String;
    function DecodeTipologiaPartTime(Tipo:String):String;
    function ReperisciT430DatIni(DataScadenza:TDateTime; var DataInizio:TDateTime):Boolean;
    procedure ReperisciDatiStoricizzazione;
    procedure SetVariabiliSelT425T430_InizioFine;
  public
    { Public declarations }
    ModalitaA202: TA202Modalita;
    MsgA202: String;
    Progressivo, GGServizio: Integer;
    DataInizioUtile, DataDecorrenzaUtile, DataScadenza: TDateTime;
    DataIReport, DataFReport: TDateTime;
    T430Utile:Boolean;
    selT425:TOracledataset;
    dsrT425:TDataSource;
    ValorizzaCampiStoricizzazione: TprocNone;
    procedure CambiaProgressivo(Prog:Integer);
    procedure EseguiStoricizzazione(Dal,Al:TDateTime; PAssenze:String);
    procedure PreparaValidazione;
    procedure LeggiDatiStorici;
    procedure ImpostaCampiLookup(pSel: TOracleDataSet);
    procedure ImpostaCampiLookupT425(pSel: TOracleDataSet);
    procedure selT425CalcFields(DataSet: TDataSet);
    procedure selT425NewRecord(DataSet: TDataSet);
    procedure selT425AfterEdit(DataSet: TDataSet);
    procedure selT425AfterPost(DataSet: TDataSet);
    procedure selT425AfterDelete(DataSet: TDataSet);
    function IntersezioneDate:TStringList;
    procedure SetVariabiliGiuridico;
  end;

implementation

{$R *.dfm}

procedure TA202FRapportiLavoroMW.SetVariabiliGiuridico;
var
  strDAL, strAL: string;
begin
  if Parametri.CampiRiferimento.C22_EnteGiuridico <> '' then
    R180SetVariable(selT430,'ENTE', 'T430.' + Parametri.CampiRiferimento.C22_EnteGiuridico)
  else
    R180SetVariable(selT430,'ENTE', '''Ente corrente''');

  if Parametri.CampiRiferimento.C22_QualificaGiuridico <> '' then
    R180SetVariable(selT430,'QUALIFICA', 'T430.' +Parametri.CampiRiferimento.C22_QualificaGiuridico)
  else
    R180SetVariable(selT430,'QUALIFICA', 'null');

  if Parametri.CampiRiferimento.C22_DisciplinaGiuridico <> '' then
    R180SetVariable(selT430,'DISCIPLINA', 'T430.' + Parametri.CampiRiferimento.C22_DisciplinaGiuridico)
  else
    R180SetVariable(selT430,'DISCIPLINA', 'null');

  if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    R180SetVariable(selT430,'INIZIO_RAPGIUR', 'T430.' + Parametri.CampiRiferimento.C22_InizioRapGiuridico)
  else
    R180SetVariable(selT430,'INIZIO_RAPGIUR', 'TO_DATE(null)');

  if Parametri.CampiRiferimento.C22_FineRapGiuridico <> '' then
    R180SetVariable(selT430,'FINE_RAPGIUR', 'T430.' + Parametri.CampiRiferimento.C22_FineRapGiuridico)
  else
    R180SetVariable(selT430,'FINE_RAPGIUR', 'TO_DATE(null)');

  strDAL:='T430F_DECORRENZA_DATI(T430.PROGRESSIVO, T430.DATADECORRENZA, ''TIPORAPPORTO,PARTTIME';
  if Parametri.CampiRiferimento.C22_EnteGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_EnteGiuridico;  //,ENTERAP_GIUR
  if Parametri.CampiRiferimento.C22_QualificaGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_QualificaGiuridico; //,QUALIFICA_CS
  if Parametri.CampiRiferimento.C22_DisciplinaGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_DisciplinaGiuridico; //,SPECIALITA
  if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    strDAL:=strDAL + ',to_char(' + Parametri.CampiRiferimento.C22_InizioRapGiuridico + ')'; //,to_char(INIZIORAP_GIUR)
  if Parametri.CampiRiferimento.C22_FineRapGiuridico <> '' then
    strDAL:=strDAL + ',to_char(' + Parametri.CampiRiferimento.C22_FineRapGiuridico + ')'; //,to_char(FINERAP_GIUR)

  strDAL:=strDAL + ''', ''N'', ';
  strAL:=strDAL;
  strDAL:=strDAL + '''N'')';
  strAL:=strAL + '''S'')';

  //TEST
  //strDAL:='T430F_DECORRENZA_DATI(T430.PROGRESSIVO, T430.DATADECORRENZA, ''TIPORAPPORTO,PARTTIME,ENTE_SERV,PROFILO,DISCIPLINA,to_char(INIZIORAP_GIUR),to_char(FINERAP_GIUR)'', ''N'', ''N'')';
  //strAL:='T430F_DECORRENZA_DATI(T430.PROGRESSIVO, T430.DATADECORRENZA, ''TIPORAPPORTO,PARTTIME,ENTE_SERV,PROFILO,DISCIPLINA,to_char(INIZIORAP_GIUR),to_char(FINERAP_GIUR)'', ''N'', ''S'')';

  R180SetVariable(selT430,'DAL_AP', strDAL);
  R180SetVariable(selT430,'AL_AP', strAL);

  {strDAL:='T430F_DECORRENZA_DATI_DAV(T430.PROGRESSIVO, T430.INIZIO, T430.DATADECORRENZA, ''TIPORAPPORTO,PARTTIME';
  if Parametri.CampiRiferimento.C22_EnteGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_EnteGiuridico;  //,ENTERAP_GIUR
  if Parametri.CampiRiferimento.C22_QualificaGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_QualificaGiuridico; //,QUALIFICA_CS
  if Parametri.CampiRiferimento.C22_DisciplinaGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_DisciplinaGiuridico; //,SPECIALITA
  if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    strDAL:=strDAL + ',to_char(' + Parametri.CampiRiferimento.C22_InizioRapGiuridico + ')'; //,to_char(INIZIORAP_GIUR)
  if Parametri.CampiRiferimento.C22_FineRapGiuridico <> '' then
    strDAL:=strDAL + ',to_char(' + Parametri.CampiRiferimento.C22_FineRapGiuridico + ')'; //,to_char(FINERAP_GIUR)

  strDAL:=strDAL + ''', ''N'', ';
  strAL:=strDAL;

  strAL:=StringReplace(strDAL, 'T430.INIZIO', 'T430.FINE',
                          [rfReplaceAll, rfIgnoreCase]);

  strDAL:=strDAL + '''N'')';
  strAL:=strAL + '''S'')';

  R180SetVariable(selT430,'DAL', strDAL);
  R180SetVariable(selT430,'AL', strAL);}
end;


procedure TA202FRapportiLavoroMW.CambiaProgressivo(Prog: Integer);
begin
  Progressivo:=Prog;
  R180SetVariable(selT425,'PROGRESSIVO',Progressivo);
  selT425.Open;

  R180SetVariable(selT430,'PROGRESSIVO',Progressivo);

  selT430.Open;
  selT430.First;

  R180SetVariable(selT055,'PROGRESSIVO',Progressivo);
  selT055.Open;
  selT055.First;

  if ModalitaA202 = VALIDAZIONE then
  begin
    R180SetVariable(selT040,'PROGRESSIVO',Progressivo);
    selT040.Open;
    selT040.First;
    if not selT425_T050_NA.Active then
      selT425_T050_NA.Open;
  end;

  LeggiDatiStorici;
end;

procedure TA202FRapportiLavoroMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT450.Open;
  selT460.Open;
  cdsProfili.CreateDataSet;
  selT265.SetVariable('DATA',Parametri.DataLavoro);
  dsrT425:=TDataSource.Create(self);
  dsrT425.DataSet:=selT425;
  selT055.FieldByName('d_CAUSALE').LookupDataSet:=selT265;
  DataIReport:=DATE_MIN; //01/01/1900;
  DataFReport:=DATE_MAX; //31/12/3999;
end;

function TA202FRapportiLavoroMW.DecodeTipologiaRapporto(Tipo: String): String;
begin
  Result:='';
  if Tipo = 'R' then Result:='Ruolo'
  else if Tipo = 'S' then Result:='Supplente'
  else if Tipo = 'I' then Result:='Incaricato'
  else if Tipo = 'P' then Result:='Prova'
  else if Tipo = 'A' then Result:='Altro';
end;

function TA202FRapportiLavoroMW.DecodeTipologiaPartTime(Tipo: String): String;
begin
  Result:='';
  Tipo:=UpperCase(Tipo);
  if Tipo = 'O' then Result:='Orizzontale'
  else if Tipo = 'V' then Result:='Verticale'
  else if Tipo = 'C' then Result:='Ciclico';
end;

procedure TA202FRapportiLavoroMW.PreparaValidazione;
begin
  with scrT430DatiGiuridici do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('INIZIO', selT425.FieldByName('INIZIO').AsDateTime);
    SetVariable('FINE', selT425.FieldByName('FINE').AsDateTime);

    //TIPO RAPPORTO
    SetVariable('TIPORAPPORTO', selT425.FieldByName('TIPORAPPORTO').AsString);

    //PARTTIME
    SetVariable('PARTTIME', selT425.FieldByName('PARTTIME').AsString);

    //QUALIFICA
    if Parametri.CampiRiferimento.C22_QualificaGiuridico <> '' then
      begin
        SetVariable('C22_QUALIFICA', Parametri.CampiRiferimento.C22_QualificaGiuridico);
        DeclareVariable('QUALIFICA', otString);
        SetVariable('QUALIFICA', selT425.FieldByName('QUALIFICA').AsString);
      end
    else
    begin
      SetVariable('C22_QUALIFICA', '--');
      DeclareVariable('QUALIFICA', otString);
      DeleteVariable('QUALIFICA');
    end;

    //ENTE
    if Parametri.CampiRiferimento.C22_EnteGiuridico <> '' then
      begin
        SetVariable('C22_ENTE', Parametri.CampiRiferimento.C22_EnteGiuridico);
        DeclareVariable('ENTE', otString);
        SetVariable('ENTE', selT425.FieldByName('ENTE').AsString);
      end
    else
    begin
      SetVariable('C22_ENTE', '--');
      DeleteVariable('ENTE');
    end;

    //DISCIPLINA
    if Parametri.CampiRiferimento.C22_DisciplinaGiuridico <> '' then
      begin
        SetVariable('C22_DISCIPLINA', Parametri.CampiRiferimento.C22_DisciplinaGiuridico);
        DeclareVariable('DISCIPLINA', otString);
        SetVariable('DISCIPLINA', selT425.FieldByName('DISCIPLINA').AsString);
      end
    else
    begin
      SetVariable('C22_DISCIPLINA', '--');
      DeleteVariable('DISCIPLINA');
    end;

    //INIZIO GIURIDICO
    if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
      SetVariable('C22_INIZIO', Parametri.CampiRiferimento.C22_InizioRapGiuridico)
    else
      SetVariable('C22_INIZIO', '--');

    //FINE GIURIDICO
    if Parametri.CampiRiferimento.C22_FineRapGiuridico <> '' then
      SetVariable('C22_FINE', Parametri.CampiRiferimento.C22_FineRapGiuridico)
    else
      SetVariable('C22_FINE', '--');
  end;
end;


procedure TA202FRapportiLavoroMW.EseguiStoricizzazione(Dal, Al: TDateTime; PAssenze: String);
begin
  try
    with scrT430PAssenze do
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DECORRENZA',Dal);
      SetVariable('SCADENZA',Al);
      SetVariable('PASSENZE',PAssenze);
      Execute;
    end;
  finally
    selT430.Refresh;
    LeggiDatiStorici;
  end;
end;

procedure TA202FRapportiLavoroMW.ReperisciDatiStoricizzazione;
var MaxDataCessazione:TDateTime;
    DataFineStr:String;
begin
  // Inizializzo parametri
  DataScadenza:=DATE_NULL;
  DataDecorrenzaUtile:=DATE_NULL;
  DataInizioUtile:=DATE_NULL;
  MaxDataCessazione:=DATE_NULL;
  Tabella:='';
  T430Utile:=False;

  GGServizio:=0;

  // Calcolo giorni di servizio su tabella rapporti altri Enti
  // NB.: Forzo chiusura per non perdere le eventuali modifiche appena intercorse
  SetVariabiliSelT425T430_InizioFine;

  // ciclo di lettura su dataset speculare per verifica intersezione di date
  while not selT425T430_InizioFine.Eof do
  begin
    Tabella:=selT425T430_InizioFine.FieldByName('TABELLA').AsString;
    MaxDataCessazione:=IfThen(selT425T430_InizioFine.FieldByName('FINE').IsNull,Date,selT425T430_InizioFine.FieldByName('FINE').AsDateTime);
    DataFineStr:=IfThen(selT425T430_InizioFine.FieldByName('FINE').IsNull,'IN CORSO',selT425T430_InizioFine.FieldByName('FINE').AsString);
    // incremento il risultato con la differenza di data inizio e fine di ogni rapporto indicato
    GGServizio:=GGServizio +
      Trunc(MaxDataCessazione - selT425T430_InizioFine.FieldByName('INIZIO').AsDateTime) + 1;

    if GGServizio >= A202GG_3ANNI then
    begin
      DataScadenza:=MaxDataCessazione + 1 + A202GG_3ANNI - GGServizio;
      DataDecorrenzaUtile:=DataScadenza;
      if (Tabella = 'T430') then
      begin
        if GGServizio > A202GG_3ANNI then
          DataInizioUtile:=selT425T430_InizioFine.FieldByName('INIZIO').AsDateTime
        else
          ReperisciT430DatIni(DataScadenza,DataInizioUtile);
        T430Utile:=True;
      end
      else
      begin
        T430Utile:=ReperisciT430DatIni(DataScadenza,DataInizioUtile);
        if T430Utile then
          Tabella:='T430';
      end;
      exit;
    end;

    selT425T430_InizioFine.Next;
  end;

  // Mai superato il limite in passato, calcolo il giorno di scadenza con la seguente formula)
  // 1° gg successivo alla cessazione (o alla data odierna) + DELTA gg alla scadenza
  if DataScadenza.IsNull then
  begin
    DataScadenza:=(MaxDataCessazione + 1) + A202GG_3ANNI - GGServizio;
    DataDecorrenzaUtile:=DataScadenza;
    GGServizio:=GGServizio + max(0,(A202GG_3ANNI - GGServizio));
    if DataFineStr = 'IN CORSO' then
    begin
      T430Utile:=ReperisciT430DatIni(DataScadenza,DataInizioUtile);
      if T430Utile then
        Tabella:='T430';
    end
    else
    begin
      Tabella:='';
    end;
  end;
end;

function TA202FRapportiLavoroMW.ReperisciT430DatIni(DataScadenza:TDateTime; var DataInizio: TDateTime): Boolean;
begin
  Result:=False;
  DataInizio:=DATE_NULL;
  //
  selT430_InizioFine.Close;
  selT430_InizioFine.SetVariable('PROGRESSIVO',Progressivo);
  selT430_InizioFine.SetVariable('DATASCADENZA',DataScadenza);
  selT430_InizioFine.Open;
  if selT430_InizioFine.RecordCount = 0 then
  begin
    DataInizio:=DataScadenza;
    exit;
  end;

  // leggo primo record su T430 per determinare la data di inizio rapporto utile.
  selT430_InizioFine.First;
  DataInizio:=selT430_InizioFine.FieldByName('INIZIO').AsDateTime;
  Result:=True;
end;

procedure TA202FRapportiLavoroMW.SetVariabiliSelT425T430_InizioFine;
var
  strDAL, strAL: string;
begin
  selT425T430_InizioFine.Close;
  R180SetVariable(selT425T430_InizioFine,'PROGRESSIVO',Progressivo);

  strDAL:='T430F_DECORRENZA_DATI(T430.PROGRESSIVO, T430.DATADECORRENZA, ''TIPORAPPORTO,PARTTIME';
  if Parametri.CampiRiferimento.C22_EnteGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_EnteGiuridico;  //,ENTERAP_GIUR
  if Parametri.CampiRiferimento.C22_QualificaGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_QualificaGiuridico; //,QUALIFICA_CS
  if Parametri.CampiRiferimento.C22_DisciplinaGiuridico <> '' then
    strDAL:=strDAL + ',' + Parametri.CampiRiferimento.C22_DisciplinaGiuridico; //,SPECIALITA
  if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    strDAL:=strDAL + ',to_char(' + Parametri.CampiRiferimento.C22_InizioRapGiuridico + ')'; //,to_char(INIZIORAP_GIUR)
  if Parametri.CampiRiferimento.C22_FineRapGiuridico <> '' then
    strDAL:=strDAL + ',to_char(' + Parametri.CampiRiferimento.C22_FineRapGiuridico + ')'; //,to_char(FINERAP_GIUR)

  strDAL:=strDAL + ''', ''N'', ';
  strAL:=strDAL;
  strDAL:=strDAL + '''N'')';
  strAL:=strAL + '''S'')';

  R180SetVariable(selT425T430_InizioFine,'DAL_AP',strDAL);
  R180SetVariable(selT425T430_InizioFine,'AL_AP',strAL);

  if Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '' then
    R180SetVariable(selT425T430_InizioFine,'INIZIO_RAPGIUR', 'T430.' + Parametri.CampiRiferimento.C22_InizioRapGiuridico)
  else
    R180SetVariable(selT425T430_InizioFine,'INIZIO_RAPGIUR', 'TO_DATE(null)');

  if Parametri.CampiRiferimento.C22_FineRapGiuridico <> '' then
    R180SetVariable(selT425T430_InizioFine,'FINE_RAPGIUR', 'T430.' + Parametri.CampiRiferimento.C22_FineRapGiuridico)
  else
    R180SetVariable(selT425T430_InizioFine,'FINE_RAPGIUR', 'TO_DATE(null)');

  selT425T430_InizioFine.Open;
  selT425T430_InizioFine.First;
end;

function TA202FRapportiLavoroMW.IntersezioneDate: TStringList;
var MaxDataCessazione:TDateTime;
    DataFineStr:String;
begin
  Result:=TStringList.Create;

  // Controllo intersezione date su tabella rapporti altri Enti
  // NB.: Forzo chiusura per non perdere le eventuali modifiche appena intercorse
  SetVariabiliSelT425T430_InizioFine;

  // ciclo di lettura su dataset speculare per verifica intersezione di date
  while not selT425T430_InizioFine.Eof do
  begin
    // escludo stesso record
    if (selT425.RowId <> selT425T430_InizioFine.FieldByName('IDRIGA').AsString) or (selT425.State in [dsInsert]) then
    begin
      MaxDataCessazione:=IfThen(selT425T430_InizioFine.FieldByName('FINE').IsNull,Date,selT425T430_InizioFine.FieldByName('FINE').AsDateTime);
      DataFineStr:=IfThen(selT425T430_InizioFine.FieldByName('FINE').IsNull,'IN CORSO',selT425T430_InizioFine.FieldByName('FINE').AsString);
      // controllo intersezione date
      if (selT425.FieldByName('FINE').AsDateTime >= selT425T430_InizioFine.FieldByName('INIZIO').AsDateTime) and
         (selT425.FieldByName('INIZIO').AsDateTime <= MaxDataCessazione) then
      begin
        if (selT425T430_InizioFine.FieldByName('TABELLA').AsString = 'T425') and (selT425T430_InizioFine.FieldByName('VALIDAZIONE').AsString = 'D') then
        begin //se c'è un'intersezione con un perido con validazione = 'D' lo metto in evidenza rispetto alle altre
          Result.Clear;
          Result.Add(selT425T430_InizioFine.FieldByName('VALIDAZIONE').AsString);
          Result.Add(Format(A000MSG_A202_MSG_INTERSEZIONE,[selT425T430_InizioFine.FieldByName('INIZIO').AsString,DataFineStr]));
          Break;
        end
        else if (selT425T430_InizioFine.FieldByName('TABELLA').AsString = 'T430') and (selT425T430_InizioFine.FieldByName('TIPO').AsString = 'A') then
        begin
          Result.Add('-' + selT425T430_InizioFine.FieldByName('TIPO').AsString);
          Result.Add(Format(A000MSG_A202_MSG_INTERSEZIONE,[selT425T430_InizioFine.FieldByName('INIZIO').AsString,DataFineStr]));
        end
        else
        begin
          Result.Add(selT425T430_InizioFine.FieldByName('VALIDAZIONE').AsString);
          Result.Add(Format(A000MSG_A202_MSG_INTERSEZIONE,[selT425T430_InizioFine.FieldByName('INIZIO').AsString,DataFineStr]));
        end;
      end;
    end;
    selT425T430_InizioFine.Next;
  end;
end;

procedure TA202FRapportiLavoroMW.LeggiDatiStorici;
{Carica tutti i dati storici del dipendente in cdsProfili}
var
  i:Integer;
  sOldTipoDato,MaxDataDec:String;
  blnOldColore:boolean;
  MaxDecorrenza:TDateTime;
  C006FStoriaDati: TC006FStoriaDati;
const DataFine = '31/12/3999';
begin
  cdsProfili.EmptyDataSet;
  blnOldColore:=False;
  ReperisciDatiStoricizzazione;
  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  try
    try
      C006FStoriaDati.GetStoriaDato(Progressivo,'PASSENZE');
    finally
    end;

    //Creo la form di visualizzazione dati storici e riempo la grid con i dati estratti
    if C006FStoriaDati.StoriaDipendente.Count > 0 then
      sOldTipoDato:=RecStoria(C006FStoriaDati.StoriaDipendente[0]).TipoDato;

    for i:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
    begin
      // determino max tra Data decorrenza e Data Inizio T430 utile da proporre a video
      MaxDecorrenza:=Max(RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza,Min(DataInizioUtile, DataDecorrenzaUtile));
      MaxDataDec:=FormatDateTime('dd/mm/yyyy',MaxDecorrenza);

      //Dalla visualizzazione escludo data decorrenza precedente a Data Inizio T430 utile
      if RecStoria(C006FStoriaDati.StoriaDipendente[i]).Fine < MaxDecorrenza then
        continue;
      if RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore = '' then
        continue;

      //str//Col. DECORRENZA (0) -> RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec;
      //str//Col. TERMINE    (1) -> RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine (se RecStoria.....DataFine <> DataFine altrimenti = 'Corrente')
      //str//Col. VALORE     (2) -> RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
      //str//Col. DESCRIZIONE(3) -> RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;
      //str//Col. NOMECAMPO  (-) -> RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;
      //bln//Col. COLORE     (-) -> True-False alternato (al cambiare di nome campo)

      with cdsProfili do
      begin
        Append;
        FieldByName('Decorrenza').AsString:=MaxDataDec;
        FieldByName('Termine').AsString:=IfThen(RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine <> DataFine, RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine, A202_Corrente);
        FieldByName('Valore').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
        FieldByName('Descrizione').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;
        FieldByName('NomeCampo').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;

        if T430Utile then
        begin
          // se Data Inizio T430 utile è compresa tra decorrenza e fine, carico dati per variazione automatica
          if R180Between(DataInizioUtile,
                         RecStoria(C006FStoriaDati.StoriaDipendente[i]).Decorrenza,
                         RecStoria(C006FStoriaDati.StoriaDipendente[i]).Fine) then
            begin
              R180SetVariable(selT261,'CODICE',RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore);
              selT261.Open;
              selT261.SearchRecord('CODICE',RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore,[srFromBeginning]);
              FieldByName('Valorizza').AsBoolean:=True;
            end;
        end
        else FieldByName('Valorizza').AsBoolean:=False;

        if sOldTipoDato <> RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato then
        begin
          sOldTipoDato:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;
          if blnOldColore then
            FieldByName('Colore').AsBoolean:=False
          else
            FieldByName('Colore').AsBoolean:=True;
          blnOldColore:=not blnOldColore;
        end
        else
          FieldByName('Colore').AsBoolean:=blnOldColore;

        Post;
      end;
    end;
  finally
    C006FStoriaDati.Free;
  end;

  //Aggiorna i dati di storicizzazione sull'interfaccia win/web
  if Assigned(ValorizzaCampiStoricizzazione) then
    ValorizzaCampiStoricizzazione;
end;

procedure TA202FRapportiLavoroMW.selT425AfterEdit(DataSet: TDataSet);
begin
  inherited;
  selT425.FieldByName('VALIDAZIONE').ReadOnly:=R180In(selT425.FieldByName('VALIDAZIONE').AsString, ['S','D','A']);
end;

procedure TA202FRapportiLavoroMW.selT425AfterPost(DataSet: TDataSet);
begin
  inherited;
  MsgA202:='';
  if scrT430DatiGiuridici.Tag = 1 then
  try
    scrT430DatiGiuridici.Tag:=0;
    scrT430DatiGiuridici.Execute;

    RegistraLog.SettaProprieta('M','T430_STORICO','A202',nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',VarToStr(scrT430DatiGiuridici.GetVariable('PROGRESSIVO')),'');
    RegistraLog.InserisciDato('DATADECORRENZA','',VarToStr(scrT430DatiGiuridici.GetVariable('INIZIO')));
    RegistraLog.InserisciDato('DATAFINE','',VarToStr(scrT430DatiGiuridici.GetVariable('FINE')));

    if scrT430DatiGiuridici.GetVariable('TIPORAPPORTO') <> null then
      RegistraLog.InserisciDato('TIPORAPPORTO','',VarToStr(scrT430DatiGiuridici.GetVariable('TIPORAPPORTO')));
    if scrT430DatiGiuridici.GetVariable('PARTTIME') <> null then
      RegistraLog.InserisciDato('PARTTIME','',VarToStr(scrT430DatiGiuridici.GetVariable('PARTTIME')));

    if (scrT430DatiGiuridici.GetVariable('C22_QUALIFICA') <> '--') then
      RegistraLog.InserisciDato(scrT430DatiGiuridici.GetVariable('C22_QUALIFICA'),'',VarToStr(scrT430DatiGiuridici.GetVariable('QUALIFICA')));
    if (scrT430DatiGiuridici.GetVariable('C22_DISCIPLINA') <> '--') then
      RegistraLog.InserisciDato(scrT430DatiGiuridici.GetVariable('C22_DISCIPLINA'),'',VarToStr(scrT430DatiGiuridici.GetVariable('DISCIPLINA')));
    if (scrT430DatiGiuridici.GetVariable('C22_ENTE') <> '--') then
      RegistraLog.InserisciDato(scrT430DatiGiuridici.GetVariable('C22_ENTE'),'',VarToStr(scrT430DatiGiuridici.GetVariable('ENTE')));

    if (scrT430DatiGiuridici.GetVariable('C22_INIZIO') <> '--') then
      RegistraLog.InserisciDato(scrT430DatiGiuridici.GetVariable('C22_INIZIO'),'',VarToStr(scrT430DatiGiuridici.GetVariable('INIZIO')));
    if (scrT430DatiGiuridici.GetVariable('C22_FINE') <> '--') then
      RegistraLog.InserisciDato(scrT430DatiGiuridici.GetVariable('C22_FINE'),'',VarToStr(scrT430DatiGiuridici.GetVariable('FINE')));


    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    selT430.Refresh;
    MsgA202:='Dati giuridici importati correttamente nello storico';
  except
   on E:Exception do
     MsgA202:='Importazione dei Dati giuridici fallita: ' + CRLF + E.Message;
  end;

  LeggiDatiStorici;
end;

procedure TA202FRapportiLavoroMW.selT055BeforeDelete(DataSet: TDataSet);
begin
  if ModalitaA202 = VALIDAZIONE then
    abort;
  inherited;
end;

procedure TA202FRapportiLavoroMW.selT055BeforeInsert(DataSet: TDataSet);
begin
  if ModalitaA202 = VALIDAZIONE then
    abort;
  inherited;
end;

procedure TA202FRapportiLavoroMW.selT425AfterDelete(DataSet: TDataSet);
begin
  inherited;
  LeggiDatiStorici;
end;

procedure TA202FRapportiLavoroMW.BeforePostNoStorico(DataSet: TDataSet);
var strLst:TStringList;
begin
  inherited;
  try
    // data inzio obbligatoria
    if selT425.FieldByName('INIZIO').IsNull then
      raise Exception.Create(A000MSG_A202_ERR_NO_DATA_INIZIO);
    // data fine obbligatoria
    if selT425.FieldByName('FINE').IsNull then
      raise Exception.Create(A000MSG_A202_ERR_NO_DATA_FINE);

    // data fine maggiore o uguale data inizio
    if (not selT425.FieldByName('FINE').IsNull) and (not selT425.FieldByName('INIZIO').IsNull) and
      (selT425.FieldByName('FINE').AsDateTime < selT425.FieldByName('INIZIO').AsDateTime) then
    begin
      selT425.FieldByName('FINE').FocusControl;
      raise Exception.Create(Format(A000MSG_A202_ERR_FMT_PERIODO,['rapporto','rapporto']));  //La data fine rapporto non può essere antecedente alla data inizio rapporto!
    end;

    strLst:=IntersezioneDate;
    if strLst.Count > 0 then
    begin
      selT425.FieldByName('INIZIO').FocusControl;
      raise Exception.Create(strLst.Strings[1]);
    end;

    if (selT425.FieldByName('VALIDAZIONE').AsString = 'S') and (selT425.FieldByName('VALIDAZIONE').OldValue = 'N') then
    begin
      PreparaValidazione;
      scrT430DatiGiuridici.Tag:=1;
    end;
  finally
    if Assigned(strLst) then
      FreeAndNil(strLst);
  end;
end;

procedure TA202FRapportiLavoroMW.selT425CalcFields(DataSet: TDataSet);
var LTipo: String;
begin
  if selT450.SearchRecord('CODICE',selT425.FieldByName('TIPORAPPORTO').AsString,[srFromBeginning]) then
  begin
    LTipo:=selT450.FieldByName('TIPO').AsString;
    selT425.FieldByName('d_TIPO').AsString:=DecodeTipologiaRapporto(LTipo);
  end;
  if (Assigned(selT425.FindField('PARTTIME'))) and (selT460.Active) then
    if selT460.SearchRecord('CODICE',selT425.FieldByName('PARTTIME').AsString,[srFromBeginning]) then
    begin
      LTipo:=selT460.FieldByName('TIPO').AsString;
      selT425.FieldByName('d_TIPOPT').AsString:=DecodeTipologiaPartTime(LTipo);
    end;
end;

procedure TA202FRapportiLavoroMW.selT425NewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
  if ModalitaA202 = PASSENZE then
    DataSet.FieldByName('VALIDAZIONE').AsString:='P';
end;

procedure TA202FRapportiLavoroMW.selT430CalcFields(DataSet: TDataSet);
var
    dataDal, dataAl: TDateTime;
    Decorrenza, Scadenza, Inizio, Fine: TDateTime;
begin
  DataSet.FieldByName('D_TIPO').AsString:=DecodeTipologiaRapporto(DataSet.FieldByName('TIPO').AsString);
  DataSet.FieldByName('d_TIPOPT').AsString:=DecodeTipologiaPartTime(DataSet.FieldByName('TIPO_PT').AsString);

  if (Assigned(DataSet.FindField('DAL_AP'))) then
    Decorrenza:=DataSet.FieldByName('DAL_AP').AsDateTime;
  if (Assigned(DataSet.FindField('AL_AP'))) then
    Scadenza:=DataSet.FieldByName('AL_AP').AsDateTime;
  if (Assigned(DataSet.FindField('INIZIO'))) then
    Inizio:=DataSet.FieldByName('INIZIO').AsDateTime;
  if (Assigned(DataSet.FindField('FINE'))) then
    Fine:=DataSet.FieldByName('FINE').AsDateTime;

  if (Assigned(DataSet.FindField('DAL'))) then
  begin
    if R180Between(Inizio, Decorrenza, Scadenza) then
      DataSet.FieldByName('DAL').AsDateTime:=Max(Inizio,Decorrenza)
    else
      DataSet.FieldByName('DAL').AsDateTime:=Decorrenza;
  end;

  if (Assigned(DataSet.FindField('AL'))) then
  begin
    if R180Between(Fine, Decorrenza, Scadenza) then
      DataSet.FieldByName('AL').AsDateTime:=Min(Fine,Scadenza)
    else
      DataSet.FieldByName('AL').AsDateTime:=Scadenza;
  end;
end;

procedure TA202FRapportiLavoroMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  if DataSet = selT450 then
    Accept:=A000FiltroDizionario('AUTOCERTIFICAZIONI: TIPI RAPPORTO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT460 then
    Accept:=A000FiltroDizionario('AUTOCERTIFICAZIONI: PART TIME',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selEnte then
    Accept:=A000FiltroDizionario('AUTOCERTIFICAZIONI: ENTI',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selQualifica then
    Accept:=A000FiltroDizionario('AUTOCERTIFICAZIONI: QUALIFICHE',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selDisciplina then
    Accept:=A000FiltroDizionario('AUTOCERTIFICAZIONI: DISCIPLINE',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA202FRapportiLavoroMW.ImpostaCampiLookup(pSel: TOracleDataSet);
var isOpen:Boolean;
begin
  isOpen:=pSel.Active;
  if isOpen then
    pSel.Close;

  if Parametri.CampiRiferimento.C22_EnteGiuridico <> '' then
  begin
    pSel.FieldByName('ENTE').Visible:=True;
    if A000LookupTabella(Parametri.CampiRiferimento.C22_EnteGiuridico, selEnte) then
    begin
      if selEnte.VariableIndex('DECORRENZA') >= 0 then
        selEnte.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
      selEnte.Open;
      pSel.FieldByName('d_ENTE').LookupDataSet:=selEnte;
      pSel.FieldByName('d_ENTE').Visible:=True;
      pSel.FieldByName('d_ENTE').FieldKind:=fkLookup;
    end;
  end
  else
  begin
    pSel.FieldByName('d_ENTE').Visible:=False;
    pSel.FieldByName('d_ENTE').FieldKind:=fkCalculated;
  end;
  if Parametri.CampiRiferimento.C22_QualificaGiuridico <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C22_QualificaGiuridico,selQualifica) then
    begin
      if selQualifica.VariableIndex('DECORRENZA') >= 0 then
        selQualifica.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
      selQualifica.Open;
      pSel.FieldByName('d_QUALIFICA').LookupDataSet:=selQualifica;
      pSel.FieldByName('QUALIFICA').Visible:=True;
      pSel.FieldByName('d_QUALIFICA').Visible:=True;
      pSel.FieldByName('d_QUALIFICA').FieldKind:=fkLookup;
    end;
  end
  else
  begin
    pSel.FieldByName('QUALIFICA').Visible:=False;
    pSel.FieldByName('d_QUALIFICA').Visible:=False;
    pSel.FieldByName('d_QUALIFICA').FieldKind:=fkCalculated;
  end;
  if Parametri.CampiRiferimento.C22_DisciplinaGiuridico <> '' then
  begin
    if A000LookupTabella(Parametri.CampiRiferimento.C22_DisciplinaGiuridico,selDisciplina) then
    begin
      if selDisciplina.VariableIndex('DECORRENZA') >= 0 then
        selDisciplina.SetVariable('DECORRENZA',R180FineMese(Parametri.DataLavoro));
      selDisciplina.Open;
      pSel.FieldByName('d_DISCIPLINA').LookupDataSet:=selDisciplina;
      pSel.FieldByName('DISCIPLINA').Visible:=True;
      pSel.FieldByName('d_DISCIPLINA').Visible:=True;
      pSel.FieldByName('d_DISCIPLINA').FieldKind:=fkLookup;
    end;
  end
  else
  begin
    pSel.FieldByName('DISCIPLINA').Visible:=False;
    pSel.FieldByName('d_DISCIPLINA').Visible:=False;
    pSel.FieldByName('d_DISCIPLINA').FieldKind:=fkCalculated;
  end;

  pSel.FieldByName('d_TIPORAPPORTO').Visible:=True;
  pSel.FieldByName('d_TIPO').Visible:=True;

  pSel.FieldByName('d_PARTTIME').Visible:=True;
  pSel.FieldByName('d_TIPOPT').Visible:=True;
  if assigned(pSel.FindField('PERC_PT')) then
    pSel.FieldByName('PERC_PT').Visible:=True;

  //CAMPI DATA PERIODO GIURIDICO
  if (Parametri.CampiRiferimento.C22_InizioRapGiuridico <> '')
  and (UpperCase(Parametri.CampiRiferimento.C22_InizioRapGiuridico) <> 'INIZIO') then
  begin
    if assigned(pSel.FindField('INIZIO_RAPGIUR')) then
      pSel.FieldByName('INIZIO_RAPGIUR').Visible:=True;
  end;

  if (Parametri.CampiRiferimento.C22_FineRapGiuridico <> '')
  and (UpperCase(Parametri.CampiRiferimento.C22_FineRapGiuridico) <> 'FINE') then
  begin
    if assigned(pSel.FindField('FINE_RAPGIUR')) then
      pSel.FieldByName('FINE_RAPGIUR').Visible:=True;
  end;

  if isOpen then
    pSel.Open;
end;

procedure TA202FRapportiLavoroMW.ImpostaCampiLookupT425(pSel: TOracleDataSet);
var isOpen:Boolean;
begin
  isOpen:=pSel.Active;
  if isOpen then
    pSel.Close;
  ImpostaCampiLookup(pSel);

  pSel.FieldByName('d_TIPORAPPORTO').LookupDataSet:=selT450;
  pSel.FieldByName('d_TIPORAPPORTO').FieldKind:=fkLookup;
  pSel.FieldByName('d_PARTTIME').LookupDataSet:=selT460;
  pSel.FieldByName('d_PARTTIME').FieldKind:=fkLookup;
  pSel.FieldByName('d_INDPRESPT').LookupDataSet:=selT460;
  pSel.FieldByName('d_INDPRESPT').FieldKind:=fkLookup;

  pSel.FieldByName('d_TIPORAPPORTO').Visible:=True;
  pSel.FieldByName('d_TIPO').Visible:=True;

  pSel.FieldByName('d_PARTTIME').Visible:=True;
  pSel.FieldByName('d_INDPRESPT').Visible:=True;
  pSel.FieldByName('d_TIPOPT').Visible:=True;

  if isOpen then
    pSel.Open;
end;

end.
