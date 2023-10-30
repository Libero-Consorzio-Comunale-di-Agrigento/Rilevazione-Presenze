unit WA009UProfAsseAnn;

interface

uses
  WA009UProfAsseAnnBrowseFM, WA009UProfAsseAnnDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, C180FunzioniGenerali, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, StrUtils, Variants,
  WA009UProfAsseAnnDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  WA009UProfiliAssenzeFM, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile,
  IWCompEdit, meIWEdit;

type
  TWA009FProfAsseAnn = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
    WProfiliAssenzeFM:TWA009FProfiliAssenzeFM;
  end;

implementation

{$R *.dfm}

procedure TWA009FProfAsseAnn.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA009FProfAsseAnnDM.Create(Self);
  WBrowseFM:=TWA009FProfAsseAnnBrowseFM.Create(Self);
  WDettaglioFM:=TWA009FProfAsseAnnDettFM.Create(Self);
  WProfiliAssenzeFM:=TWA009FProfiliAssenzeFM.Create(Self);

  CreaTabDefault;

  grdTabControl.AggiungiTab('Profili assenze',WProfiliAssenzeFM);
  grdTabControl.ActiveTab:=WBrowseFM;
end;

function TWA009FProfAsseAnn.InizializzaAccesso: Boolean;
var Cod: String;
begin
  Result:=False;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;

  Cod:=GetParam('CODICE');
  if Cod <> '' then   //Richiamo da WA002
  begin
    if (WR302DM as TWA009FProfAsseAnnDM).selT261.SearchRecord('CODICE',Cod,[srFromBeginning]) then
      WProfiliAssenzeFM.grdProfiliAssenze.medpAggiornaCDS(True);
    if (WR302DM as TWA009FProfAsseAnnDM).selTabella.SearchRecord('CODPROFILO',Cod,[srFromEnd]) then
    begin
      (WR302DM as TWA009FProfAsseAnnDM).selTabella.SearchRecord('ANNO;CODPROFILO',VarArrayOf([R180Anno(Date),Cod]),[srFromBeginning]);
      WBrowseFM.grdTabella.medpAggiornaCDS(True);
    end;
  end;

  Result:=True;
end;

end.
