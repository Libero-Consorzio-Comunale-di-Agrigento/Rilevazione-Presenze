unit WA143UMedicineLegali;

interface

uses
  Windows,OracleData, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton, System.Actions, meIWImageFile;

type
  TWA143FMedicineLegali = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
  end;

implementation

uses WA143UMedicineLegaliDM, WA143UMedicineLegaliBrowseFM, WA143UMedicineLegaliDettFM;

{$R *.dfm}

function TWA143FMedicineLegali.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA143FMedicineLegali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA143FMedicineLegaliDM.Create(Self);
  WBrowseFM:=TWA143FMedicineLegaliBrowseFM.Create(Self);
  WDettaglioFM:=TWA143FMedicineLegaliDettFM.Create(Self);

  CreaTabDefault;
end;


end.
