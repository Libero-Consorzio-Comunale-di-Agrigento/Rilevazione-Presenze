unit WA080USoglieStraordinario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData,
  Dialogs, WR103UGestMasterDetail, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink,WA080USoglieStraordinarioOutputFM, WR102UGestTabella,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, System.Actions, IWCompEdit, meIWEdit;

type
  TWA080FSoglieStraordinario = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  public
    WA080FSoglieStraordinarioOutputFM:TWA080FSoglieStraordinarioOutputFM;
  private
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA080USoglieStraordinarioDM, WA080USoglieStraordinarioBrowseFM;

{$R *.dfm}

function TWA080FSoglieStraordinario.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA080FSoglieStraordinario.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  InterfacciaWR102.DettaglioFM:=False;

  WR302DM:=TWA080FSoglieStraordinarioDM.Create(Self);
  WBrowseFM:=TWA080FSoglieStraordinarioBrowseFM.Create(Self);

  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  WA080FSoglieStraordinarioOutputFM:=TWA080FSoglieStraordinarioOutputFM.Create(Self);
  AggiungiDetail(WA080FSoglieStraordinarioOutputFM);
  WA080FSoglieStraordinarioOutputFM.CaricaDettaglio(TWA080FSoglieStraordinarioDM(WR302DM).selT028,TWA080FSoglieStraordinarioDM(WR302DM).dsrT028);
  CreaTabDefault;
  AttivaGestioneStoricizzazione;
end;

end.
