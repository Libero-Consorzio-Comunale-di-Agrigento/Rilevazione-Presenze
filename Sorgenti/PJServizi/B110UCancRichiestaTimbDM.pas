unit B110UCancRichiestaTimbDM;

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
  W000UMessaggi,
  W018URichiestaTimbratureDM,
  System.SysUtils,
  System.Classes,
  Data.DB,
  OracleData,
  System.Variants,
  Oracle;

type
  TB110FCancRichiestaTimbDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdRichiesta: Integer;
    procedure SetIdRichiesta(Value: Integer);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property IdRichiesta: Integer write SetIdRichiesta;
  end;

implementation

{$R *.dfm}

{ TB110FCancRichiestaTimbDM }

procedure TB110FCancRichiestaTimbDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdRichiesta:=0;
end;

procedure TB110FCancRichiestaTimbDM.SetIdRichiesta(Value: Integer);
begin
  if Value <= 0 then
    raise EC200InvalidParameter.Create(Format('L''ID richiesta indicato non è valido: %d',[Value]));

  FIdRichiesta:=Value;
end;

function TB110FCancRichiestaTimbDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  if FIdRichiesta <= 0 then
  begin
    Result.Messaggio:=Format('L''ID della richiesta da eliminare non è valido: %d',[FIdRichiesta]);
    Exit;
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TB110FCancRichiestaTimbDM.Esegui(var RRisultato: TRisultato);
var
  W018DM: TW018FRichiestaTimbratureDM;
  C018: TC018FIterAutDM;
  LSQL: String;
  LFiltroAnag: String;
begin
  W018DM:=TW018FRichiestaTimbratureDM.Create(Owner);
  C018:=TC018FIterAutDM.Create(Owner);
  try
    W018DM.C018:=C018;
    C018.Iter:=ITER_TIMBR;
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
    C018.PreparaDataSetIter(W018DM.selT105,tiRichiesta);

    // estrae la richiesta da eliminare
    LFiltroAnag:=Parametri.Inibizioni.Text;
    if LFiltroAnag <> '' then
      LFiltroAnag:=Format('and (%s)',[LFiltroAnag]);
    W018DM.selT105.Close;
    W018DM.selT105.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W018DM.selT105.SetVariable('FILTRO_ANAG',LFiltroAnag);
    W018DM.selT105.SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    W018DM.selT105.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste + Format(' and (T850.ID = %d)',[FIdRichiesta]));
    W018DM.selT105.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W018DM.selT105.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    // rimuove l'ordinamento sql
    LSQL:=W018DM.selT105.SQL.Text;
    if LSQL.ToLower.Contains('order by') then
      LSQL:=LSQL.Remove(LSQL.ToLower.IndexOf('order by'));

    // imposta la query e la esegue
    W018DM.selT105.ReadBuffer:=2;
    W018DM.selT105.SQL.Text:=LSQL;
    W018DM.selT105.Open;

    if W018DM.selT105.SearchRecord('ID',FIdRichiesta,[srFromBeginning]) then
    begin
      try
        C018.CodIter:=W018DM.selT105.FieldByName('COD_ITER').AsString;
        C018.Id:=W018DM.selT105.FieldByName('ID').AsInteger;
        C018.EliminaIter;
        SessioneOracle.Commit;
        RRisultato.AddInfo(Format('Cancellazione della richiesta %d effettuata',[FIdRichiesta]));
      except
        on E: Exception do
        begin
          SessioneOracle.Rollback;
          RRisultato.AddError(Format('Cancellazione della richiesta %d fallita:'#13#10'%s',[FIdRichiesta,E.Message]));
        end;
      end;
    end
    else
    begin
      RRisultato.AddError(TErrorCode.DataNotFound,Format('La richiesta %d non è presente nel database',[FIdRichiesta]));
    end;
  finally
    FreeAndNil(C018);
    FreeAndNil(W018DM);
  end;
end;

end.
