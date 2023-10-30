unit WA089URegIndPresenza;

interface

uses
  WA089URegIndPresenzaBrowseFM, WA089URegIndPresenzaDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase, WR102UGestTabella,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA089URegIndPresenzaDM, IWCompButton, WR103UGestMasterDetail, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  WA089URegIndPresenzaRegoleFM,WA089URegIndPresenzaRegMaturazioneFM, IWCompGrids,OracleData, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  System.Actions, meIWEdit;

type
  TWA089FRegIndPresenza = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA089FRegIndPresenza.IWAppFormRender(Sender: TObject);
begin
  inherited;
  //TWA089FRegIndPresenzaDM(WR302DM).selTabellaAfterScroll(nil);
end;


function TWA089FRegIndPresenza.InizializzaAccesso: Boolean;
var
  codice  : String;
begin
  Result:=False;
  codice:=GetParam('CODICE');
  if codice <> '' then
  begin
    TWA089FRegIndPresenzaDM(WR302DM).selTabella.SearchRecord('CODICE',codice,[srFromBeginning]);
    TWA089FRegIndPresenzaBrowseFM(WBrowseFM).grdTabella.medpAggiornaCDS;
  end;
  Result:=True;
end;

procedure TWA089FRegIndPresenza.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA089FRegIndPresenzaRegoleFM;
  Detail2:TWA089FRegIndPresenzaRegMaturazioneFM;
begin
  inherited;
  WR100LinkWC700:=False;
  WR302DM:=TWA089FRegIndPresenzaDM.Create(Self);
  WBrowseFM:=TWA089FRegIndPresenzaBrowseFM.Create(Self);
  WDettaglioFM:=TWA089FRegIndPresenzaDettFM.Create(Self);
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  Detail:=TWA089FRegIndPresenzaRegoleFM.Create(Self);
  AggiungiDetail(Detail,'Associazioni Indennità');
  Detail.CaricaDettaglio(TWA089FRegIndPresenzaDM(WR302DM).selT164,TWA089FRegIndPresenzaDM(WR302DM).dsrT164);

  Detail2:=TWA089FRegIndPresenzaRegMaturazioneFM.Create(Self);
  AggiungiDetail(Detail2,'Regole di Maturazione');
  Detail2.CaricaDettaglio(TWA089FRegIndPresenzaDM(WR302DM).selT171,TWA089FRegIndPresenzaDM(WR302DM).dsrT171);

  CreaTabDefault;
  AggiornaDetails;
end;

end.
