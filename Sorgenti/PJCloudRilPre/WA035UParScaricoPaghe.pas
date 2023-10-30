unit WA035UParScaricoPaghe;

interface

uses
  WA035UParScaricoPagheBrowseFM, WA035UParScaricoPagheDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA035UParScaricoPagheDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, IWCompEdit, meIWEdit;

type
  TWA035FParScaricoPaghe = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
  private
    procedure LoadCompDettaglio;
    function InizializzaAccesso:Boolean; override;
  public
    VoceMenu: String;
  end;

const
  cParPaghe:string='PAGHE';
  cParContab:string='CONTAB';

implementation

{$R *.dfm}

function TWA035FParScaricoPaghe.InizializzaAccesso: Boolean;
begin
  Result:=False;
  VoceMenu:=GetParam('TIPOPAR');
  if VoceMenu = '' then
    VoceMenu:='PAGHE';
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  LoadCompDettaglio;
  Result:=True;
end;

procedure TWA035FParScaricoPaghe.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  VoceMenu:='PAGHE';
  WR302DM:=TWA035FParScaricoPagheDM.Create(Self);
  WBrowseFM:=TWA035FParScaricoPagheBrowseFM.Create(Self);
  WDettaglioFM:=TWA035FParScaricoPagheDettFM.Create(Self);
  CreaTabDefault;
  LoadCompDettaglio;
end;


procedure TWA035FParScaricoPaghe.LoadCompDettaglio;
begin
  if TWA035FParScaricoPagheDettFM(WDettaglioFM) <> nil then
    with TWA035FParScaricoPagheDettFM(WDettaglioFM) do
    begin
      if VoceMenu = cParPaghe then
      begin
        Self.Title:='(WA035) Regole scarico paghe';
        dchkSalvataggioAutomatico.Visible:=True;
        dchkRicreazioneAutomatica.Visible:=True;
        lblUtentePaghe.Caption:='Utente della procedura Paghe:';
        drgpDatiOrari.Visible:=True;
        drgpTipoData.Visible:=True;
      end
      else if VoceMenu = cParContab then
      begin
        Self.Title:='(WA035) Parametrizzazione scarico contabilità';
        dchkSalvataggioAutomatico.Visible:=False;
        dchkRicreazioneAutomatica.Visible:=False;
        lblUtentePaghe.Caption:='Utente della procedura Cont.:';
        drgpDatiOrari.Visible:=False;
        drgpTipoData.Visible:=False;
      end;
    end;
end;

procedure TWA035FParScaricoPaghe.actAnnullaExecute(Sender: TObject);
begin
  if TWA035FParScaricoPagheDM(WR302DM).Q192.CachedUpdates then
    TWA035FParScaricoPagheDM(WR302DM).Q192.CancelUpdates;
  inherited;
end;

end.
