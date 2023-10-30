unit WA142UQualifMinisteriali;

interface

uses
  WA142UQualifMinisterialiBrowseFM, WA142UQualifMinisterialiDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA142UQualifMinisterialiDM, IWCompButton, WR102UGestTabella, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls,OracleData, System.Actions, meIWEdit, Oracle;

type
  TWA142FQualifMinisteriali = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  public
    function InizializzaAccesso: Boolean; override;
  public
  end;

implementation

{$R *.dfm}

procedure TWA142FQualifMinisteriali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;

  WR302DM:=TWA142FQualifMinisterialiDM.Create(Self);
  WBrowseFM:=TWA142FQualifMinisterialiBrowseFM.Create(Self);
  WDettaglioFM:=TWA142FQualifMinisterialiDettFM.Create(Self);

  CreaTabDefault;
end;

function TWA142FQualifMinisteriali.InizializzaAccesso: Boolean;
var Cod: String;
begin
  Result:=False;
  Cod:=GetParam('CODICE');
  if Cod <> '' then
  begin
    WR302DM.selTabella.SearchRecord('CODICE',Cod,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    CercaStoricoCorrente(Parametri.DataLavoro);
    AggiornaRecord;
  end;
  Result:=True;
end;

end.
