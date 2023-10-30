unit WP030UValute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  OracleData,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions, meIWImageFile;

type
  TWP030FValute = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WP030UValuteBrowseFM, WP030UValuteDM;

{$R *.dfm}

procedure TWP030FValute.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWP030FValuteDM.Create(Self);
  WBrowseFM:=TWP030FValuteBrowseFM.Create(Self);
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
end;

function TWP030FValute.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('COD_VALUTA',GetParam('COD_VALUTA'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
