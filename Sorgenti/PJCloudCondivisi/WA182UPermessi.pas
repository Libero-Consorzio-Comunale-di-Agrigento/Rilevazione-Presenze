unit WA182UPermessi;

interface

uses
  WA182UPermessiBrowseFM, WA182UPermessiDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  IWCompButton, WR102UGestTabella, OracleData, Variants,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, medpIWMessageDlg,
  IWCompGrids,A000UMessaggi, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile, meIWEdit;

type
  TWA182FPermessi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    function InizializzaAccesso: Boolean; override;
  public
  end;

implementation

uses WA182UPermessiDM;

{$R *.dfm}

procedure TWA182FPermessi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA182FPermessiDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=True;

  WDettaglioFM:=TWA182FPermessiDettFM.Create(Self);
  WBrowseFM:=TWA182FPermessiBrowseFM.Create(Self);
  CreaTabDefault;

  TWA182FPermessiDM(WR302DM).selI010AfterOpen(nil);
end;

function TWA182FPermessi.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('AZIENDA;PROFILO',VarArrayOf([GetParam('AZIENDA'),GetParam('PROFILO')]),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA182FPermessi.actEliminaExecute(Sender: TObject);
begin
  if TWA182FPermessiDM(WR302DM).ProfiloUtilizzato then
    raise Exception.Create(A000MSG_ERR_ELIMINA_PROFILO);
  inherited;
end;

end.
