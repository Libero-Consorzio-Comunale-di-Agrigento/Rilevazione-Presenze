unit WA007UProfiliOrari;

interface

uses
  WA007UProfiliOrariBrowseFM, WA007UProfiliOrariDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase, WR102UGestTabella,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA007UProfiliOrariDM, IWCompButton, WR103UGestMasterDetail, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  WA007UProfiliOrariSettimaneFM, IWCompGrids, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, OracleData,
  System.Actions, meIWImageFile, meIWEdit, Oracle;

type
  TWA007FProfiliOrari = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    Detail:TWA007FProfiliOrariSettimaneFM;
  public
    function InizializzaAccesso: Boolean; override;
    procedure RefreshPage; override;
  end;

implementation

{$R *.dfm}

procedure TWA007FProfiliOrari.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA007FProfiliOrariDM.Create(Self);
  WBrowseFM:=TWA007FProfiliOrariBrowseFM.Create(Self);
  WDettaglioFM:=TWA007FProfiliOrariDettFM.Create(Self);

  Detail:=TWA007FProfiliOrariSettimaneFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA007FProfiliOrariDM(WR302DM).selT221,TWA007FProfiliOrariDM(WR302DM).dsrT221);

  CreaTabDefault;
end;

procedure TWA007FProfiliOrari.RefreshPage;
begin
  inherited;
  Detail.CaricaListModelli;
end;

function TWA007FProfiliOrari.InizializzaAccesso: Boolean;
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
