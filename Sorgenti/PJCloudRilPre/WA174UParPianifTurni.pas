unit WA174UParPianifTurni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, OracleData,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, Oracle, IWCompEdit, meIWEdit;

type
  TWA174FParPianifTurni = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA174UParPianifTurniBrowseFM, WA174UParPianifTurniDettFM, WA174UParPianifTurniDM;

{$R *.dfm}

function TWA174FParPianifTurni.InizializzaAccesso: Boolean;
var Codice: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  if Codice <> '' then
    WR302DM.selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA174FParPianifTurni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA174FParPianifTurniDM.Create(Self);
  WBrowseFM:=TWA174FParPianifTurniBrowseFM.Create(Self);
  WDettaglioFM:=TWA174FParPianifTurniDettFM.Create(Self);
  CreaTabDefault;
end;
end.
