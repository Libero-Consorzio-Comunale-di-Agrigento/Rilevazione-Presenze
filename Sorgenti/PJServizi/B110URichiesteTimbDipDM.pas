unit B110URichiesteTimbDipDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110USharedTypes,
  B110USharedUtils,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  R015UDatasnapRestDM,
  R016UDatasnapRestRichiesteDM,
  W018URichiestaTimbratureDM,
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  Data.FireDACJSONReflect,
  System.StrUtils,
  Data.DB,
  OracleData;

type
  TB110FRichiesteTimbDipDM = class(TR016FDatasnapRestRichiesteDM)
   protected
    procedure Esegui(var RRisultato: TRisultato); override;
  end;

implementation

{$R *.dfm}

{ TB110FRichiesteTimbDipDM }

procedure TB110FRichiesteTimbDipDM.Esegui(var RRisultato: TRisultato);
var
  W018DM: TW018FRichiestaTimbratureDM;
  C018: TC018FIterAutDM;
  LFiltroAnag: String;
  LSQL: String;
  LTableT105: TFDMemTable;
  LRes: TOutputRichiesteTimbDip;
  LFeedback: String;
  LRichiesteTotali: Integer;
begin
  // iter timbrature
  W018DM:=TW018FRichiestaTimbratureDM.Create(Owner);
  C018:=TC018FIterAutDM.Create(Owner);
  try
    W018DM.C018:=C018;
    C018.Iter:=ITER_TIMBR;
    C018.Responsabile:=False;
    C018.AccessoReadOnly:=False;

    // tipologia richieste
    LFeedback:=IfThen(SoloNumeroRichieste,'Numero ') + 'richieste';
    if FiltroRichieste.FiltroVis = 'trDaAutorizzare' then
    begin
      C018.TipoRichiesteSel:=[trDaAutorizzare];
      LFeedback:=LFeedback + ' da autorizzare';
    end
    else if FiltroRichieste.FiltroVis = 'trAutorizzate' then
    begin
      C018.TipoRichiesteSel:=[trAutorizzate];
      LFeedback:=LFeedback + ' autorizzate';
    end
    else if FiltroRichieste.FiltroVis = 'trNegate' then
    begin
      C018.TipoRichiesteSel:=[trNegate];
      LFeedback:=LFeedback + 'negate';
    end;

    // periodo richieste
    C018.Periodo.SetVuoto;
    C018.Periodo.Inizio:=FiltroRichieste.PeriodoDa;
    C018.Periodo.Fine:=FiltroRichieste.PeriodoA;
    if not C018.Periodo.Vuoto then
      LFeedback:=LFeedback + ' nel periodo ' + C018.Periodo.ToString;

    // filtro struttura: tutte
    C018.StrutturaSel:=C018STRUTTURA_TUTTE;

    // filtro allegati: tutti
    C018.RichiesteConAllegati:=raTutte;
    C018.CondizioneAllegati:=caTutte;

    // predispone query
    C018.PreparaDataSetIter(W018DM.selT105,tiRichiesta);

    // estrae le richieste da autorizzare
    LFiltroAnag:=Parametri.Inibizioni.Text;
    if LFiltroAnag <> '' then
      LFiltroAnag:=Format('and (%s)',[LFiltroAnag]);
    W018DM.selT105.Close;
    W018DM.selT105.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W018DM.selT105.SetVariable('FILTRO_ANAG',LFiltroAnag);
    W018DM.selT105.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    W018DM.selT105.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    W018DM.selT105.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W018DM.selT105.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    // rimuove l'ordinamento sql (è effettuato lato client)
    LSQL:=W018DM.selT105.SQL.Text;
    if LSQL.ToLower.Contains('order by') then
      LSQL:=LSQL.Remove(LSQL.ToLower.IndexOf('order by'));

    // imposta la query e la esegue
    W018DM.selT105.ReadBuffer:=500;
    W018DM.selT105.SQL.Text:=LSQL;
    W018DM.selT105.Open;

    // determina il numero di richieste totali
    LRichiesteTotali:=W018DM.selT105.RecordCount;
    LFeedback:=LFeedback + Format(': %d totali',[LRichiesteTotali]);

    // se richiesto limita il numero di record in base alla data
    if (FiltroRichieste.LimiteRecord > 0) and (LRichiesteTotali > FiltroRichieste.LimiteRecord) then
    begin
      // imposta ordinamento query per applicare il limite in modo corretto
      LSQL:=LSQL + Format('order by %s',[C018.OrderByIter]);

      // riesegue query limitando i record tramite evento dataset
      W018DM.selT105.Close;
      W018DM.selT105.ReadBuffer:=FiltroRichieste.LimiteRecord + 1;
      W018DM.selT105.AfterFetchRecord:=DataSetAfterFetchRecord;
      W018DM.selT105.SQL.Text:=LSQL;
      W018DM.selT105.Open;

      LFeedback:=LFeedback + Format(' (visualizzate %d)',[FiltroRichieste.LimiteRecord]);
    end;
    LFeedback:=LFeedback + Format(' per l''utente %s',[Parametri.Operatore]);

    // elenco richieste
    LTableT105:=W018DM.selT105.CloneDataset;

    // prepara risultato servizio
    RRisultato.Output:=TOutputRichiesteTimbDip.Create;
    LRes:=TOutputRichiesteTimbDip(RRisultato.Output);

    // configurazione C018
    LRes.C018Revocabile:=C018.Revocabile;

    // richieste totali
    LRes.RichiesteTotali:=LRichiesteTotali;

    // dataset richieste
    LRes.JSONDatasets:=TFDJSONDataSets.Create;
    TFDJSONDataSetsWriter.ListAdd(LRes.JSONDatasets,LTableT105);

    //--------------------------------------------------------
    RRisultato.JSONDatasets:=LRes.JSONDatasets;
    RRisultato.MemTable:=LTableT105;
    //--------------------------------------------------------

    RRisultato.AddInfo(LFeedback);
  finally
    FreeAndNil(W018DM);
    FreeAndNil(C018);
  end;
end;

end.
