unit WA048UPastiMese;

interface

uses
  Windows,OracleData, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions, IWCompEdit, meIWEdit;

type
  TWA048FPastiMese = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA048UPastiMeseDM, WA048UPastiMeseBrowseFM;

{$R *.dfm}

procedure TWA048FPastiMese.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA048FPastiMeseDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA048FPastiMeseBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
