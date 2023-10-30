unit WA160URegoleIncentivi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA160FRegoleIncentivi = class(TWR102FGestTabella)
  procedure IWAppFormCreate(Sender: TObject);
  private
  public
  end;

implementation

uses WA160URegoleIncentiviDM, WA160URegoleIncentiviBrowseFM, WA160URegoleIncentiviDettFM;

{$R *.dfm}

procedure TWA160FRegoleIncentivi.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA160FRegoleIncentiviDM.Create(Self);
  WBrowseFM:=TWA160FRegoleIncentiviBrowseFM.Create(Self);
  WDettaglioFM:=TWA160FRegoleIncentiviDettFM.Create(Self);

  CreaTabDefault;
end;

end.
