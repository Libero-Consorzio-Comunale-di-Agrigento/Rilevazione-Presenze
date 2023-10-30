unit B110UAutorizzazioneRichiesteGiustDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  B110USharedTypes,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  R017UDatasnapRestAutRichiesteDM,
  W010URichiestaAssenzeDM,
  System.SysUtils,
  System.Classes,
  OracleData;

type
  TB110FAutorizzazioneRichiesteGiustDM = class(TR017FDatasnapRestAutRichiesteDM)
  protected
    procedure Esegui(var RRisultato: TRisultato); override;
  end;

implementation

{$R *.dfm}

{ TB110FAutorizzazioneRichiesteGiustDM }

procedure TB110FAutorizzazioneRichiesteGiustDM.Esegui(var RRisultato: TRisultato);
var
  W010DM: TW010FRichiestaAssenzeDM;
  C018: TC018FIterAutDM;
  LFiltroAnag: String;
  Resp: String;
  AbilAut: Boolean;
  LMotivo: String;
begin
  // iter giustificativi
  W010DM:=TW010FRichiestaAssenzeDM.Create(Owner);
  C018:=TC018FIterAutDM.Create(Owner);
  try
    W010DM.C018DM:=C018;
    C018.Iter:=ITER_GIUSTIF;
    C018.Responsabile:=True;
    C018.AccessoReadOnly:=False;
    C018.TipoRichiesteSel:=[trDaAutorizzare];
    C018.PreparaDataSetIter(W010DM.selT050,tiAutorizzazione);

    // estrae le richieste da autorizzare
    LFiltroAnag:=Parametri.Inibizioni.Text;
    if LFiltroAnag <> '' then
      LFiltroAnag:=Format('and (%s)',[LFiltroAnag]);
    W010DM.selT050.Close;
    W010DM.selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
    W010DM.selT050.SetVariable('FILTRO_ANAG',LFiltroAnag);
    W010DM.selT050.SetVariable('FILTRO_PERIODO',''{C018.Periodo.Filtro});
    W010DM.selT050.SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    W010DM.selT050.SetVariable('FILTRO_STRUTTURA',''{C018.FiltroStruttura});
    W010DM.selT050.SetVariable('FILTRO_ALLEGATI',''{C018.FiltroAllegati});
    W010DM.selT050.Open;

    // verifica presenza richiesta nel dataset
    if not W010DM.selT050.SearchRecord('ID',IdRichiesta,[srFromBeginning]) then
      raise Exception.CreateFmt('La richiesta da autorizzare non è stata trovata [ID %d]',[IdRichiesta]);

    // determina se la richiesta è autorizzabile
    AbilAut:=(W010DM.selT050.FieldByName('ELABORATO').AsString = 'N') and
             (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger = 0) and
             (W010DM.selT050.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
             (W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0);
    if not AbilAut then
    begin
      LMotivo:='';
      if W010DM.selT050.FieldByName('ELABORATO').AsString <> 'N' then
        LMotivo:=LMotivo + 'richiesta già elaborata'#13#10;
      if W010DM.selT050.FieldByName('ID_REVOCA').AsInteger <> 0 then
        LMotivo:=LMotivo + 'richiesta revocata'#13#10;
      if W010DM.selT050.FieldByName('AUTORIZZ_AUTOMATICA').AsString = 'S' then
        LMotivo:=LMotivo + 'richiesta autorizzata automaticamente'#13#10;
      if W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger <= 0 then
        LMotivo:=LMotivo + 'livello di autorizzazione non adeguato'#13#10;
      raise Exception.CreateFmt('Impossibile autorizzare la richiesta [ID %d]:'#13#10'%s',[IdRichiesta,LMotivo]);
    end;

    // autorizza la richiesta
    Resp:=Parametri.Operatore;
    try
      C018.CodIter:=W010DM.selT050.FieldByName('COD_ITER').AsString;
      C018.Id:=W010DM.selT050.FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(W010DM.selT050.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Autorizzazione,Resp,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione)
      else
        SessioneOracle.Commit;
    except
      on E: Exception do
        raise Exception.CreateFmt('Errore in fase di autorizzazione: %s [ID %d]',[E.Message,IdRichiesta]);
    end;
  finally
    FreeAndNil(W010DM);
    FreeAndNil(C018);
  end;
end;

end.
