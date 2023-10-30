unit WP050UCodArrotondamentoFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, System.Actions,
  Vcl.Menus, A000UInterfaccia, WR102UGestTabella, DB, WR100UBase;

type
  TWP050FCodArrotondamentoFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses WP050UArrotondamenti;

//QUESTA MASCHERA CHE NORMALMENTE E' IL DETAIL, IN QUESTO CASO DIVENTA LA TESTATA

procedure TWP050FCodArrotondamentoFM.actNuovoExecute(Sender: TObject);
begin
  //In insert della testata, forzo il posizionamento sulla pagina di browse del dettaglio
  (Self.Parent as TWP050FArrotondamenti).grdTabControl.ActiveTab:=(Self.Parent as TWP050FArrotondamenti).WBrowseFM;
  inherited;
  //In insert della testata, forzo il RowClick e l'abilitazioni delle toolbar a False di modo che non si possa agire sul dettaglio
  grdTabella.RowClick:=False;
  (Self.Parent as TWP050FArrotondamenti).AbilitaToolBar((Self.Parent as TWP050FArrotondamenti).grdNavigatorBar,False,(Self.Parent as TWP050FArrotondamenti).actlstNavigatorBar);
  (Self.Parent as TWP050FArrotondamenti).AbilitaToolBar((Self.Parent as TWP050FArrotondamenti).grdToolBarStorico,False,nil);
  (Self.Parent as TWP050FArrotondamenti).AbilitaToolBar((Self.Parent as TWP050FArrotondamenti).grdTabControl,False,nil);
end;

procedure TWP050FCodArrotondamentoFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  //Forzo la paginazione della testata
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=10;
end;

end.
