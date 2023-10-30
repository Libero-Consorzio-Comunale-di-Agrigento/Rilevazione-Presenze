unit WA199UCheckRimborsi;

interface

uses
  medpIWC700NavigatorBar, A000UInterfaccia,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA199FCheckRimborsi = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA199UCheckRimborsiDM, WA199UCheckRimborsiBrowseFM,
     WA199URimborsiFM, WA199UIndKmFM, WA199UDatiLiberiFM, WA199UMezziFM;

{$R *.dfm}

{ TWA199FCheckRimborsi }

function TWA199FCheckRimborsi.InizializzaAccesso: Boolean;
begin
  //Inizializzazione
  Result:=True;
end;

procedure TWA199FCheckRimborsi.IWAppFormCreate(Sender: TObject);
var
  DetRimb: TWA199FRimborsiFM;
  DetIndKm: TWA199FIndKmFM;
  DetDatiLiberi: TWA199FDatiLiberiFM;
  DetMezzi: TWA199FMezziFM;
begin
  // la tabella master (elenco missioni) è in sola lettura,
  // per cui inibisce azioni di modifica
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actElimina.Visible:=False;
  actCopiaSu.Visible:=False;
  actAnnulla.Visible:=False;
  actConferma.Visible:=False;
  inherited;

  WR302DM:=TWA199FCheckRimborsiDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;

  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  grdC700.AttivaBrowse:=False;
  grdC700.AttivaLabel:=False;
  grdC700.ImpostaProgressivoCorrente:=False;
  AttivaGestioneC700;
  grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella);
  grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
  WR302DM.selTabella.Open;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  WBrowseFM:=TWA199FCheckRimborsiBrowseFM.Create(Self);
  GetParametriFunzione;
  (WBrowseFM as TWA199FCheckRimborsiBrowseFM).FiltraMissioni;

  // detail: tab rimborsi
  DetRimb:=TWA199FRimborsiFM.Create(Self);
  AggiungiDetail(DetRimb,'Rimborsi');
  DetRimb.CaricaDettaglio((WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.selM051,(WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.dsrM051);

  // detail: tab indennità km
  DetIndKm:=TWA199FIndKmFM.Create(Self);
  AggiungiDetail(DetIndKm,'Indennità km');
  DetIndKm.CaricaDettaglio((WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.selM052,(WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.dsrM052);

  // detail: tab dati liberi
  DetDatiLiberi:=TWA199FDatiLiberiFM.Create(Self);
  AggiungiDetail(DetDatiLiberi,'Dati liberi');
  DetDatiLiberi.CaricaDettaglio((WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.selM175,(WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.dsrM175);

  // detail: tab rimborsi
  DetMezzi:=TWA199FMezziFM.Create(Self);
  AggiungiDetail(DetMezzi,'Mezzi di trasporto');
  DetMezzi.CaricaDettaglio((WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.selM170,(WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.dsrM170);

  CreaTabDefault;
  AggiornaDetails;
end;

procedure TWA199FCheckRimborsi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA199FCheckRimborsi.GetParametriFunzione;
var
  IdxRimborsi, IdxStato: Integer;
begin
  IdxRimborsi:=StrToIntDef(C004DM.GetParametro('RGPRIMBORSI',''),0);
  IdxStato:=StrToIntDef(C004DM.GetParametro('RGPSTATO',''),2);

  with (WBrowseFM as TWA199FCheckRimborsiBrowseFM) do
  begin
    rgpRimborsi.OnClick:=nil;
    rgpRimborsi.ItemIndex:=IdxRimborsi;
    rgpRimborsi.OnClick:=rgpRimborsiClick;

    rgpStato.OnClick:=nil;
    rgpStato.ItemIndex:=IdxStato;
    rgpStato.OnClick:=rgpStatoClick;

    AbilitazioneFiltri;
  end;
end;

procedure TWA199FCheckRimborsi.PutParametriFunzione;
begin
  try
    with (WBrowseFM as TWA199FCheckRimborsiBrowseFM) do
    begin
      C004DM.Cancella001;
      C004DM.PutParametro('RGPRIMBORSI',rgpRimborsi.ItemIndex.ToString);
      C004DM.PutParametro('RGPSTATO',rgpStato.ItemIndex.ToString);
    end;
  finally
    SessioneOracle.Commit;
  end;
end;

procedure TWA199FCheckRimborsi.actAggiornaExecute(Sender: TObject);
begin
  (WBrowseFM as TWA199FCheckRimborsiBrowseFM).FiltraMissioni;
end;

procedure TWA199FCheckRimborsi.ResultWC700(Sender: TObject; Result: Boolean);
begin
  // se Result è True, significa che è stata modificata la selezione anagrafica
  if Result then
  begin
    // reimposta il filtro anagrafe
    WR302DM.selTabella.Close;
    grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella,False);
    grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
    WR302DM.selTabella.Open;

    // aggiorna tabella
    WBrowseFM.grdTabella.medpCaricaCDS;
  end;
end;

end.
