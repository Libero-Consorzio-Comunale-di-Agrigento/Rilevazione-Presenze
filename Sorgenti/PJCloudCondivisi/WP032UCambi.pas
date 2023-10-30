unit WP032UCambi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions, meIWImageFile, OracleData;

type
  TWP032FCambi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
    procedure CambioDataDecorrenza; override;
  end;


implementation

uses WP032UCambiBrowseFM, WP032UCambiDM, WP032UCambiDettFM;

{$R *.dfm}

procedure TWP032FCambi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWP032FCambiDM.Create(Self);
  WBrowseFM:=TWP032FCambiBrowseFM.Create(Self);
  WDettaglioFM:=TWP032FCambiDettFM.Create(Self);
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
end;

procedure TWP032FCambi.CambioDataDecorrenza;
begin
  inherited;
  (WR302DM as TWP032FCambiDM).P032FCambiMW.P032DECORRENZAChange;
  WDettaglioFM.CaricaMultiColumnComboBox;
end;

function TWP032FCambi.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('COD_VALUTA1',GetParam('COD_VALUTA1'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
