unit B110UInsRichiestaTimbDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  A023UTimbratureMW,
  R015UDatasnapRestDM,
  FunzioniGenerali,
  C200UWebServicesTypes,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  W000UMessaggi,
  W018URichiestaTimbratureDM,
  System.SysUtils, System.Classes, Data.DB, OracleData, System.Variants, Oracle;

type
  TB110FInsRichiestaTimbDM = class(TR015FDatasnapRestDM)
    selT361: TOracleQuery;
  private
    FDatiTimb: TDatiRichiestaTimb;
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DatiTimb: TDatiRichiestaTimb read FDatiTimb write FDatiTimb;
  end;

implementation

uses
  B110UDizionarioDM;

{$R *.dfm}

{ TB110FInsRichiestaTimbDM }

function TB110FInsRichiestaTimbDM.ControlloParametri: TResCtrl;
var
  LDizionarioDM: TB110FDizionarioDM;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // progressivo
  if FDatiTimb.Progressivo = 0 then
    FDatiTimb.Progressivo:=Parametri.ProgressivoOper;

  // data
  if FDatiTimb.Data = DATE_NULL then
  begin
    Result.Messaggio:='Data timbratura non indicata';
    Exit;
  end;

  if FDatiTimb.Data > Date then
  begin
    Result.Messaggio:='La data della timbratura è successiva al giorno corrente!';
    Exit;
  end;

  if (Parametri.WEBIterTimbGGPrec >= 0) and ((Date - FDatiTimb.Data) > Parametri.WEBIterTimbGGPrec) then
  begin
    Result.Messaggio:=Format('La data non può essere antecedente più di %d giorni!',[Parametri.WEBIterTimbGGPrec]);
    Exit;
  end;

  // ora
  try
    TFunzioniGenerali.OraValidate(FDatiTimb.Ora);
  except
    on E:Exception do
    begin
      Result.Messaggio:=Format('L''ora indicata non è valida: %s',[E.Message]);
      Exit;
    end;
  end;

  // verso
  if not TFunzioniGenerali._In(FDatiTimb.Verso,['E','U']) then
  begin
    Result.Messaggio:=Format('Il verso indicato non è valido: %s (valori ammessi: E oppure U)',[FDatiTimb.Verso]);
    Exit;
  end;

  // crea dizionario per controlli successivi
  LDizionarioDM:=TB110FDizionarioDM.Create(nil);
  try
    LDizionarioDM.SetSessioneOracle(SIW.SessioneOracle);

    // causale
    if FDatiTimb.Causale <> '' then
    begin
      LDizionarioDM.selT275Abilitate.Close;
      LDizionarioDM.selT275Abilitate.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
      LDizionarioDM.selT275Abilitate.SetVariable('DATA',Parametri.DataLavoro);
      LDizionarioDM.selT275Abilitate.Open;
      if not LDizionarioDM.selT275Abilitate.SearchRecord('CODICE',FDatiTimb.Causale,[srFromBeginning]) then
      begin
        Result.Messaggio:=Format('La causale indicata è inesistente oppure non utilizzabile: %s',[FDatiTimb.Causale]);
        Exit;
      end;
    end;

    // rilevatore
    if FDatiTimb.Rilevatore <> '' then
    begin
      selT361.SetVariable('CODICE',FDatiTimb.Rilevatore);
      selT361.Execute;
      if selT361.RowCount = 0 then
      begin
        Result.Messaggio:=Format('Il rilevatore indicato è inesistente oppure non utilizzabile: %s',[FDatiTimb.Rilevatore]);
        Exit;
      end;
    end;

    // altri controlli in base al tipo di operazione
    if TFunzioniGenerali._In(FDatiTimb.Operazione,['I','M']) then
    begin
      // motivazione
      if FDatiTimb.Motivazione = '' then
      begin
        LDizionarioDM.selT106.Close;
        LDizionarioDM.selT106.SetVariable('TIPO','T');
        LDizionarioDM.selT106.Open;
        if LDizionarioDM.selT106.RecordCount > 0 then
        begin
          Result.Messaggio:='E'' necessario selezionare una motivazione per la richiesta!';
          Exit;
        end;
      end;
    end;

    // controllo modifiche
    if FDatiTimb.Operazione = 'M' then
    begin
      if not (FDatiTimb.IsVersoModificato or FDatiTimb.IsCausaleModificata) then
      begin
        Result.Messaggio:='E'' necessario modificare almeno il verso o la causale della timbratura per richiedere una modifica!';
        Exit;
      end;
    end;
  finally
    LDizionarioDM.Clear;
    FreeAndNil(LDizionarioDM);
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TB110FInsRichiestaTimbDM.Esegui(var RRisultato: TRisultato);
var
  A023MW: TA023FTimbratureMW;
  W018DM: TW018FRichiestaTimbratureDM;
  C018: TC018FIterAutDM;
  LRes: TOutputInsRichiestaTimb;
begin
  if FDatiTimb.Progressivo = 0 then
    FDatiTimb.Progressivo:=Parametri.ProgressivoOper;

  A023MW:=TA023FTimbratureMW.Create(Owner);
  W018DM:=TW018FRichiestaTimbratureDM.Create(Owner);
  C018:=TC018FIterAutDM.Create(Owner);
  try
    W018DM.C018:=C018;
    C018.Iter:=ITER_TIMBR;
    C018.Responsabile:=False;
    C018.AccessoReadOnly:=False;

    C018.TipoRichiesteSel:=[trTutte];

    // periodo richieste
    C018.Periodo.SetVuoto;

    // filtro struttura: tutte
    C018.StrutturaSel:=C018STRUTTURA_TUTTE;

    // filtro allegati: tutti
    C018.RichiesteConAllegati:=raTutte;
    C018.CondizioneAllegati:=caTutte;

    // predispone query
    C018.PreparaDataSetIter(W018DM.selT105,tiRichiesta);

    // estrae un dataset vuoto che sarà propedeutico all'inserimento effettuato dal datamodule A023MW
    W018DM.selT105.Close;
    W018DM.selT105.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W018DM.selT105.SetVariable('FILTRO_ANAG','and 1<>1');//Sempre false
    W018DM.selT105.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    W018DM.selT105.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    W018DM.selT105.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W018DM.selT105.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    // imposta la query e la esegue
    W018DM.selT105.ReadBuffer:=2;
    W018DM.selT105.Open;

    A023MW.ItemsRichiestaTimb.selT105:=W018DM.selT105;
    A023MW.ItemsRichiestaTimb.C018:=C018;

    A023MW.ControlliRichiestaTimb(FDatiTimb);

    // prepara risultato servizio
    RRisultato.Output:=TOutputInsRichiestaTimb.Create;
    LRes:=TOutputInsRichiestaTimb(RRisultato.Output);
    LRes.RisposteMsg.Assign(FDatiTimb.RisposteMsg);
  finally
    FreeAndNil(C018);
    FreeAndNil(W018DM);
    FreeAndNil(A023MW);
  end;
end;

end.
