unit WA093UOperazioni;

interface

uses
  Classes, SysUtils, IWAppForm, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  Forms, IWVCLBaseContainer, IWContainer,WA093UOperazioniDM,
  meIWGrid, medpIWTabControl, medpIWStatusBar,Db,WA093UOperazioniFiltroFM, WA093UOperazioniRisultatiFM, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, meIWImageFile,
  IWCompEdit, meIWEdit;

type
  TWA093FOperazioni = class(TWR100FBase)
    grdTabControl: TmedpIWTabControl;
    procedure IWAppFormCreate(Sender: TObject);
  private
    ItemSort:Integer;
  public
    WRisultatiFM:TWA093FOperazioniRisultatiFM;
    WFiltroFM:TWA093FOperazioniFiltroFM;
    WR300DM:TWA093FOperazioniDM;
    FlagStatus: Boolean;
  end;

implementation

{$R *.dfm}

procedure TWA093FOperazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  FlagStatus:=False;
  ItemSort:=-1;

  WR300DM:=TWA093FOperazioniDM.Create(Self);
  AttivaGestioneC700;

  WFiltroFM:=TWA093FOperazioniFiltroFM.Create(Self);
  WRisultatiFM:=TWA093FOperazioniRisultatiFM.Create(Self);

  grdTabControl.AggiungiTab('Filtro ricerca',WFiltroFM);
  grdTabControl.AggiungiTab('Risultati',WRisultatiFM);
  grdTabControl.Tabs[WRisultatiFM].Visible:=False;
  grdTabControl.ActiveTab:=WFiltroFM;
end;

end.
