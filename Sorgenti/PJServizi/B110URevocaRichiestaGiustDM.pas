unit B110URevocaRichiestaGiustDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  R600,
  W000UMessaggi,
  W010URichiestaAssenzeDM,
  System.Variants,
  System.SysUtils,
  System.Classes,
  OracleData;

type
  TB110FRevocaRichiestaGiustDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdRichiesta: Integer;
    FTipoRichiesta: String;
    FDal: TDateTime;
    FAl: TDateTime;
    FDatiGiust: TDatiRichiestaGiust;
    procedure SetIdRichiesta(Value: Integer);
    procedure SetTipoRichiesta(Value: String);
    procedure SetDal(Value: TDateTime);
    procedure SetAl(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DatiGiust: TDatiRichiestaGiust read FDatiGiust write FDatiGiust;
    property IdRichiesta: Integer write SetIdRichiesta;
    property TipoRichiesta: String write SetTipoRichiesta;
    property Dal: TDateTime write SetDal;
    property Al: TDateTime write SetAl;
  end;

implementation

{$R *.dfm}

{ TR015FDatasnapRestDM1 }

procedure TB110FRevocaRichiestaGiustDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdRichiesta:=0;
  FTipoRichiesta:='';
end;

procedure TB110FRevocaRichiestaGiustDM.SetIdRichiesta(Value: Integer);
begin
  if Value <= 0 then
    raise EC200InvalidParameter.Create(Format('L''ID richiesta indicato non è valido: %d',[Value]));

  FIdRichiesta:=Value;
end;

procedure TB110FRevocaRichiestaGiustDM.SetTipoRichiesta(Value: String);
begin
  if (Value <> 'R') and (Value <> 'C') then
    raise EC200InvalidParameter.Create(Format('Il tipo di richiesta indicato per la revoca non è valido: %s',[Value]));

  FTipoRichiesta:=Value;
end;

procedure TB110FRevocaRichiestaGiustDM.SetDal(Value: TDateTime);
begin
  FDal:=Value;
end;

procedure TB110FRevocaRichiestaGiustDM.SetAl(Value: TDateTime);
begin
  FAl:=Value;
end;

function TB110FRevocaRichiestaGiustDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // id richiesta
  if FIdRichiesta <= 0 then
  begin
    Result.Messaggio:=Format('L''ID della richiesta da eliminare non è valido: %d',[FIdRichiesta]);
    Exit;
  end;

  // tipo richiesta
  if (FTipoRichiesta <> 'R') and (FTipoRichiesta <> 'C') then
  begin
    Result.Messaggio:=Format('Il tipo di richiesta indicato per la revoca non è valido: %s',[FTipoRichiesta]);
    Exit;
  end;

  // date di riferimento per cancellazione
  if FTipoRichiesta = 'C' then
  begin
    //...
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TB110FRevocaRichiestaGiustDM.Esegui(var RRisultato: TRisultato);
var
  W010DM: TW010FRichiestaAssenzeDM;
  C018: TC018FIterAutDM;
  LFiltroAnag: String;
  R600DtM: TR600DtM1;
  LRes: TOutputRevocaRichiestaGiust;
  LSQL: String;
begin
  if FDatiGiust.Progressivo = 0 then
    FDatiGiust.Progressivo:=Parametri.ProgressivoOper;

  R600DtM:=TR600Dtm1.Create(SIW.SessioneOracle);
  W010DM:=TW010FRichiestaAssenzeDM.Create(Owner);
  C018:=TC018FIterAutDM.Create(Owner);
  try
    W010DM.C018DM:=C018;
    C018.Iter:=ITER_GIUSTIF;
    C018.Responsabile:=False;
    C018.AccessoReadOnly:=False;

    // tipologia richieste
    C018.TipoRichiesteSel:=[trTutte];

    // periodo richieste
    C018.Periodo.SetVuoto;

    // filtro struttura: tutte
    C018.StrutturaSel:=C018STRUTTURA_TUTTE;

    // filtro allegati: tutti
    C018.RichiesteConAllegati:=raTutte;
    C018.CondizioneAllegati:=caTutte;

    // predispone query
    C018.PreparaDataSetIter(W010DM.selT050,tiRichiesta);

    // estrae la richiesta indicata
    LFiltroAnag:=Parametri.Inibizioni.Text;
    if LFiltroAnag <> '' then
      LFiltroAnag:=Format('and (%s)',[LFiltroAnag]);
    W010DM.selT050.Close;
    W010DM.selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W010DM.selT050.SetVariable('FILTRO_ANAG',LFiltroAnag);
    W010DM.selT050.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    W010DM.selT050.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste + Format(' and (T850.ID = %d)',[FIdRichiesta]));
    W010DM.selT050.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W010DM.selT050.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    // rimuove l'ordinamento sql
    LSQL:=W010DM.selT050.SQL.Text;
    if LSQL.ToLower.Contains('order by') then
      LSQL:=LSQL.Remove(LSQL.ToLower.IndexOf('order by'));

    // imposta la query e la esegue
    W010DM.selT050.ReadBuffer:=2;
    W010DM.selT050.SQL.Text:=LSQL;
    W010DM.selT050.Open;

    //R600DtM.ItemsRichiestaGiust.RichiestaDaDefInConteggi:=RichiestaDaDefInConteggi;
    //R600DtM.ItemsRichiestaGiust.CtrlRipristinoRich:=actCtrlRipristinoRich;
    //R600DtM.ItemsRichiestaGiust.DefRichiesta:=actDefRichiesta;
    //R600DtM.ItemsRichiestaGiust.SetDaoreAore:=SetDaoreAore;
    //R600DtM.ItemsRichiestaGiust.IncludiTipoRichieste:=IncludiTipoRichieste;
    //R600DtM.ItemsRichiestaGiust.PostAnnullaRichiesta:=PostAnnullaRichiesta;
    //R600DtM.ItemsRichiestaGiust.PostInsRichiesta:=PostInsRichiesta;
    R600DtM.IterAutorizzativo:=True;
    R600DtM.ItemsRichiestaGiust.selT050:=W010DM.selT050;
    R600DtM.ItemsRichiestaGiust.C018:=C018;

    R600DtM.RevocaRichiestaGiust(FDatiGiust,FTipoRichiesta,FDal,FAl);

    // prepara risultato servizio
    RRisultato.Output:=TOutputRevocaRichiestaGiust.Create;
    LRes:=TOutputRevocaRichiestaGiust(RRisultato.Output);
    LRes.RisposteMsg.Assign(FDatiGiust.RisposteMsg);
  finally
    FreeAndNil(C018);
    FreeAndNil(W010DM);
    FreeAndNil(R600DtM);
  end;
end;

end.
