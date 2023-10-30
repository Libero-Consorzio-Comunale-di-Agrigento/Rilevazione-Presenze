unit WA015UPlusOraIndiv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions, meIWImageFile;

type
  TWA015FPlusOraIndiv = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA015UPlusOraIndivDM, WA015UPlusOraIndivBrowseFM, WA015UPlusOraIndivDettFM;

{$R *.dfm}

procedure TWA015FPlusOraIndiv.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA015FPlusOraIndivDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA015FPlusOraIndivBrowseFM.Create(Self);
  WDettaglioFM:=TWA015FPlusOraIndivDettFM.Create(Self);
  CreaTabDefault;
end;

end.
