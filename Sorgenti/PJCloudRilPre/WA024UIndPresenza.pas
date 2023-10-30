unit WA024UIndPresenza;

interface

uses
  WA024UIndPresenzaBrowseFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, OracleData,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase, WR102UGestTabella,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA024UIndPresenzaDM, IWCompButton, WR103UGestMasterDetail, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  WA024UIndPresenzaIndennitaFM, IWCompGrids, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions,
  meIWEdit;

type
  TWA024FIndPresenza = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA024FIndPresenza.InizializzaAccesso: Boolean;
var codice: String;
begin
  Result:=False;
  codice:=GetParam('CODICE');
  TWA024FIndPresenzaDM(WR302DM).selTabella.SearchRecord('CODICE',codice,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA024FIndPresenza.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA024FIndPresenzaIndennitaFM;
begin
  inherited;
  WR302DM:=TWA024FIndPresenzaDM.Create(Self);
  WBrowseFM:=TWA024FIndPresenzaBrowseFM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;

  Detail:=TWA024FIndPresenzaIndennitaFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA024FIndPresenzaDM(WR302DM).selT160,TWA024FIndPresenzaDM(WR302DM).dsrT160);

  CreaTabDefault;
//  Detail.AggiornaDettaglio;
end;

end.
