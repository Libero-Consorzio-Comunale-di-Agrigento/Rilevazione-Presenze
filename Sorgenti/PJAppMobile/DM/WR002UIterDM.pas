unit WR002UIterDM;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, OracleData, Data.DB, C018UIterAutDM, StrUtils, A000UCostanti;

type
  TWR002FIterDM = class(TWM000FDataModuleBaseDM)
  private
    procedure R013Open(C018: TC018FIterAutDM);
  protected
    selIter: TOracleDataset;
  public
    procedure AggiornaRichieste(PFiltroAnag: String; C018: TC018FIterAutDM); virtual;
    procedure AnnullaInserimentoRichiesta; virtual;
    procedure AnnullaModificaRichiesta; virtual;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWR002FIterDM }

procedure TWR002FIterDM.R013Open(C018: TC018FIterAutDM);
var LOrdinamento: String;
begin
  //Ottimizzazione query sostituendo T430 a V430
  {if selIter is TOracleDataSet then
    WR000DM.TransV430toT430((selIter as TOracleDataSet));}  //non presente su IrisAPP

  // TORINO_ITC.ini
  // chiamata 114864 - ordinamento delle richieste da autorizzare per data richiesta in base a parametro aziendale
  if selIter is TOracleDataSet then
  begin
    if C018.NotificaAttivita then
    begin
      LOrdinamento:='';
    end
    else
    begin
      if C018.Iter=ITER_BUDGET_STRAORD then
      begin
        if (SessioneIrisWin.Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta = 'S') and
           (trDaAutorizzare in C018.TipoRichiesteSel) and
           (not (trTutte in C018.TipoRichiesteSel)) then
          LOrdinamento:='T850.DATA DESC, %s'
        else
          LOrdinamento:='%s, T850.DATA DESC';
      end
      else
      begin
        if (SessioneIrisWin.Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta = 'S') and
           (trDaAutorizzare in C018.TipoRichiesteSel) and
           (not (trTutte in C018.TipoRichiesteSel)) then
          LOrdinamento:='T850.DATA DESC, NOMINATIVO, T030A.MATRICOLA, %s'
        else
          LOrdinamento:='NOMINATIVO, T030A.MATRICOLA, %s, T850.DATA DESC';
      end;
      LOrdinamento:=Format(LOrdinamento,[C018.OrderByIter]);
    end;

    // imposta l'ordinamento
    TOracleDataSet(selIter).SetVariable('ORDINAMENTO',IfThen(LOrdinamento <> '','order by ' + LOrdinamento));
  end;
  // TORINO_ITC.fine

  // apertura dataset
  selIter.Open;
end;

procedure TWR002FIterDM.AggiornaRichieste(PFiltroAnag: String; C018: TC018FIterAutDM);
begin
  with selIter do
  begin
    Close;
    SetVariable('DATALAVORO', Now);
    SetVariable('FILTRO_ANAG', PFiltroAnag);
    SetVariable('FILTRO_PERIODO', C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE', C018.FiltroRichieste);
    SetVariable('FILTRO_STRUTTURA', C018.FiltroStruttura);
    SetVariable('FILTRO_ALLEGATI', C018.FiltroAllegati);
    R013Open(C018);
    First;
  end;
end;

procedure TWR002FIterDM.AnnullaInserimentoRichiesta;
begin
  if selIter.State = dsInsert then
    selIter.Cancel;
end;

procedure TWR002FIterDM.AnnullaModificaRichiesta;
begin
  if selIter.State = dsEdit then
    selIter.Cancel;
end;

end.
