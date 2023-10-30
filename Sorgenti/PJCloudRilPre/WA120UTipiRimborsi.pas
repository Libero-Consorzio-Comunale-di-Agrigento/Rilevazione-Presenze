unit WA120UTipiRimborsi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA120UTipiRimborsiDM, WA120UTipiRimborsiBrowseFM, WA120UTipiRImborsiDettFM,
  DB,OracleData, meIWImageFile;

type
  TWA120FTipiRimborsi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  protected
    procedure RefreshPage; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA120FTipiRimborsi.InizializzaAccesso: Boolean;
var Codice: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  if Codice <> '' then
  begin
    WR302DM.selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(False);
    AggiornaRecord;
  end;
  Result:=True;
end;

procedure TWA120FTipiRimborsi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA120FTipiRimborsiDM.Create(Self);

  WBrowseFM:=TWA120FTipiRimborsiBrowseFM.Create(Self);
  WDettaglioFM:=TWA120FTipiRImborsiDettFM.Create(Self);
  CreaTabDefault;
end;

procedure TWA120FTipiRimborsi.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA120FTipiRimborsiDM) do
  begin
    A120FTipiRimborsiMW.selP050.Refresh;
    if selTabella.State in [dsEdit,dsInsert] then
     (WDettaglioFM as TWA120FTipiRimborsiDettFM).CaricaMultiColumnCombobox;
  end;
end;

end.
