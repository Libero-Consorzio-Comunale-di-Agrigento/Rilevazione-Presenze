unit WA010UProfAsseInd;

interface

uses
  WA010UProfAsseIndBrowseFM, WA010UProfAsseIndDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, C180FunzioniGenerali, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA010UProfAsseIndDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  System.Actions, meIWImageFile, meIWEdit;

type
  TWA010FProfAsseInd = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
  public
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

procedure TWA010FProfAsseInd.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA010FProfAsseIndDM.Create(Self);

  AttivaGestioneC700;

  WDettaglioFM:=TWA010FProfAsseIndDettFM.Create(Self);
  WBrowseFM:=TWA010FProfAsseIndBrowseFM.Create(Self);
  CreaTabDefault;
end;

procedure TWA010FProfAsseInd.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  R180SetVariable(TWA010FProfAsseIndDM(WR302DM).selSG101,'PROGRESSIVO',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
  TWA010FProfAsseIndDM(WR302DM).selSG101.Open;
end;

end.
