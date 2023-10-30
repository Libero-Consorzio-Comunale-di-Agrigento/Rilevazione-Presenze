unit B110UInsRichiestaGiustDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  R015UDatasnapRestDM,
  R600,
  W010URichiestaAssenzeDM,
  System.SysUtils,
  System.Classes;

type
  TB110FInsRichiestaGiustDM = class(TR015FDatasnapRestDM)
  private
    FDatiGiust: TDatiRichiestaGiust;
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DatiGiust: TDatiRichiestaGiust read FDatiGiust write FDatiGiust;
  end;

implementation

{$R *.dfm}

{ TB110FInsRichiestaGiustDM }

function TB110FInsRichiestaGiustDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FInsRichiestaGiustDM.Esegui(var RRisultato: TRisultato);
var
  W010DM: TW010FRichiestaAssenzeDM;
  C018: TC018FIterAutDM;
  R600DtM: TR600DtM1;
  LRes: TOutputInsRichiestaGiust;
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

    // estrae un dataset vuoto che sarà propedeutico all'inserimento effettuato dal datamodule C018
    W010DM.selT050.Close;
    W010DM.selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W010DM.selT050.SetVariable('FILTRO_ANAG','and 1<>1');//Sempre false
    W010DM.selT050.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    W010DM.selT050.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    W010DM.selT050.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W010DM.selT050.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    // imposta la query e la esegue
    W010DM.selT050.ReadBuffer:=2;
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

    R600DtM.ControlliRichiestaGiust(FDatiGiust);

    // prepara risultato servizio
    RRisultato.Output:=TOutputInsRichiestaGiust.Create;
    LRes:=TOutputInsRichiestaGiust(RRisultato.Output);
    LRes.RisposteMsg.Assign(FDatiGiust.RisposteMsg);
  finally
    FreeAndNil(C018);
    FreeAndNil(W010DM);
    FreeAndNil(R600DtM);
  end;
end;

end.
