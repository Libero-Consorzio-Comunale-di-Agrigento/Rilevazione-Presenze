unit WP150USetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl,
  IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, System.Actions, meIWImageFile;

type
  TWP150FSetup = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CambioDataDecorrenza; override;
  end;

implementation

uses WP150USetupDettFM, WP150USetupDM, WP150USetupBrowseFM;

{$R *.dfm}

procedure TWP150FSetup.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=true;
  WR302DM:=TWP150FSetupDM.Create(Self);
  WBrowseFM:=TWP150FSetupBrowseFM.Create(Self);
  WDettaglioFM:=TWP150FSetupDettFM.Create(Self);
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
end;

procedure TWP150FSetup.CambioDataDecorrenza;
begin
  inherited;
  (WR302DM as TWP150FSetupDM).P150FSetupMW.P150CalcFields;
  WDettaglioFM.CaricaMultiColumnComboBox;
end;

end.
