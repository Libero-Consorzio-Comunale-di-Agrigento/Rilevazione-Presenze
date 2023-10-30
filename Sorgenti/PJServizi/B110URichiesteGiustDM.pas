unit B110URichiesteGiustDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  B110USharedTypes,
  B110USharedUtils,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  R015UDatasnapRestDM,
  R016UDatasnapRestRichiesteDM,
  W010URichiestaAssenzeDM,
  System.StrUtils,
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  Data.FireDACJSONReflect;

type
  TB110FRichiesteGiustDM = class(TR016FDatasnapRestRichiesteDM)
  protected
    procedure Esegui(var RRisultato: TRisultato); override;
  end;

implementation

{$R *.dfm}

procedure TB110FRichiesteGiustDM.Esegui(var RRisultato: TRisultato);
var
  W010DM: TW010FRichiestaAssenzeDM;
  C018: TC018FIterAutDM;
  LFiltroAnag: String;
  LSQL: String;
  LTable: TFDMemTable;
  LRes: TOutputRichiesteGiust;
  LFeedback: String;
  LRichiesteTotali: Integer;
begin
  // verifica che il profilo iter sia impostato
  if Parametri.ProfiloWebIterAutorizzativi = '' then
  begin
    RRisultato.AddError('Il profilo in uso non dispone della possibilità di autorizzare richieste!');
    Exit;
  end;

  // iter giustificativi
  W010DM:=TW010FRichiestaAssenzeDM.Create(Owner);
  C018:=TC018FIterAutDM.Create(Owner);
  try
    W010DM.C018DM:=C018;
    C018.Iter:=ITER_GIUSTIF;
    C018.Responsabile:=True;
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
    C018.PreparaDataSetIter(W010DM.selT050,tiAutorizzazione);

    // estrae le richieste da autorizzare
    LFiltroAnag:=Parametri.Inibizioni.Text;
    if LFiltroAnag <> '' then
      LFiltroAnag:=Format('and (%s)',[LFiltroAnag]);
    W010DM.selT050.Close;
    W010DM.selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W010DM.selT050.SetVariable('FILTRO_ANAG',LFiltroAnag);
    W010DM.selT050.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    W010DM.selT050.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    W010DM.selT050.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W010DM.selT050.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    // rimuove l'ordinamento sql (è effettuato lato client)
    LSQL:=W010DM.selT050.SQL.Text;
    if LSQL.ToLower.Contains('order by') then
      LSQL:=LSQL.Remove(LSQL.ToLower.IndexOf('order by'));

    // imposta la query e la esegue
    W010DM.selT050.ReadBuffer:=500;
    W010DM.selT050.SQL.Text:=LSQL;
    W010DM.selT050.Open;

    // determina il numero di richieste totali
    LRichiesteTotali:=W010DM.selT050.RecordCount;
    LFeedback:=LFeedback + Format(': %d totali',[LRichiesteTotali]);

    // predispone il dataset delle richieste, eventualmente limitato
    LTable:=nil;
    if not SoloNumeroRichieste then
    begin
      // se richiesto limita il numero di record in base alla data
      if (FiltroRichieste.LimiteRecord > 0) and (LRichiesteTotali > FiltroRichieste.LimiteRecord) then
      begin
        // imposta ordinamento query per applicare il limite in modo corretto
        LSQL:=LSQL + Format('order by %s',[C018.OrderByIter]);

        // riesegue query limitando i record tramite evento dataset
        W010DM.selT050.Close;
        W010DM.selT050.ReadBuffer:=FiltroRichieste.LimiteRecord + 1;
        W010DM.selT050.AfterFetchRecord:=DataSetAfterFetchRecord;
        W010DM.selT050.SQL.Text:=LSQL;
        W010DM.selT050.Open;

        LFeedback:=LFeedback + Format(' (visualizzate %d)',[FiltroRichieste.LimiteRecord]);
      end;

      LTable:=W010DM.selT050.CloneDataset;
    end;

    // prepara risultato servizio
    RRisultato.Output:=TOutputRichiesteGiust.Create;
    LRes:=TOutputRichiesteGiust(RRisultato.Output);

    // configurazione C018
    LRes.C018Revocabile:=C018.Revocabile;

    // richieste totali
    LRes.RichiesteTotali:=LRichiesteTotali;

    // dataset richieste
    if not SoloNumeroRichieste then
    begin
      LRes.JSONDatasets:=TFDJSONDataSets.Create;
      TFDJSONDataSetsWriter.ListAdd(LRes.JSONDatasets,LTable);

      //--------------------------------------------------------
      RRisultato.JSONDatasets:=LRes.JSONDatasets;
      RRisultato.MemTable:=LTable;
      //--------------------------------------------------------
    end;

    LFeedback:=LFeedback + Format(' per l''utente %s',[Parametri.Operatore]);
    RRisultato.AddInfo(LFeedback);
  finally
    FreeAndNil(W010DM);
    FreeAndNil(C018);
  end;
end;

end.
