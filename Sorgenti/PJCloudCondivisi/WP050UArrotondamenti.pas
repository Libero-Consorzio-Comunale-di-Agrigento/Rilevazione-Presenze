unit WP050UArrotondamenti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  WC007UFormContainerFM, WP050UCodArrotondamenti, WR102UGestTabella, WR203UGestDetailFM, WP050UCodArrotondamentoFM,
  System.Actions, OracleData, meIWImageFile;

type
  TWP050FArrotondamenti = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    {private declarations}
  public
    Detail:TWP050FCodArrotondamentoFM;
    function  InizializzaAccesso:Boolean; override;
    procedure CambioDataDecorrenza; override;
  end;

implementation

uses WP050UArrotondamentiBrowseFM, WP050UArrotondamentiDM, WP050UArrotondamentiDettFM;

{$R *.dfm}

//IN QUESTO PROGETTO LA MASCHERA CHE NORMALMENTE E' IL DETAIL DIVENTA LA TESTATA
procedure TWP050FArrotondamenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=True;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.FChiaveReadOnly:=True;
  WR302DM:=TWP050FArrotondamentiDM.Create(Self);
  WBrowseFM:=TWP050FArrotondamentiBrowseFM.Create(Self);
  WDettaglioFM:=TWP050FArrotondamentiDettFM.Create(Self);

  Detail:=TWP050FCodArrotondamentoFM.Create(Self);
  Detail.Relazionato:=False;
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWP050FArrotondamentiDM).selP050K,(WR302DM as TWP050FArrotondamentiDM).dsrP050K);

  CreaTabDefault;
end;

function TWP050FArrotondamenti.InizializzaAccesso: Boolean;
begin
  Result:=False;
  (WR302DM as TWP050FArrotondamentiDM).selP050K.SearchRecord('COD_ARROTONDAMENTO',GetParam('COD_ARROTONDAMENTO'),[srFromBeginning]);
  Detail.grdTabella.medpAggiornaCDS(False);
  WBrowseFM.grdTabella.medpAggiornaCDS(False);
  AggiornaRecord;
  Result:=True;
end;

procedure TWP050FArrotondamenti.CambioDataDecorrenza;
begin
  inherited;
  (WR302DM as TWP050FArrotondamentiDM).P050FArrotondamentiMW.P050DecorrenzaChange;
  WDettaglioFM.CaricaMultiColumnComboBox;
end;

end.
