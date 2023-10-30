unit WS746UStatiAvanzamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWS746FStatiAvanzamento = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WS746UStatiAvanzamentoDM, WS746UStatiAvanzamentoBrowseFM, WS746UStatiAvanzamentoDettFM;

{$R *.dfm}

procedure TWS746FStatiAvanzamento.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWS746FStatiAvanzamentoDM.Create(Self);
  WBrowseFM:=TWS746FStatiAvanzamentoBrowseFM.Create(Self);
  WDettaglioFM:=TWS746FStatiAvanzamentoDettFM.Create(Self);
  CreaTabDefault;
end;

end.
