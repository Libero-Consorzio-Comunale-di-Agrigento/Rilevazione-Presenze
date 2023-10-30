unit WP682URaggruppamentiFondi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, Oracle,
  System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit,
  meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, OracleData;

type
  TWP682FRaggruppamentiFondi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses WP682URaggruppamentiFondiBrowseFM, WP682URaggruppamentiFondiDM;

function TWP682FRaggruppamentiFondi.InizializzaAccesso;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('COD_RAGGR',GetParam('COD_RAGGR'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWP682FRaggruppamentiFondi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.ChiaveReadOnly:=True;
  WR302DM:=TWP682FRaggruppamentiFondiDM.Create(Self);
  WBrowseFM:=TWP682FRaggruppamentiFondiBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
