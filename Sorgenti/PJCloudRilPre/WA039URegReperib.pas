unit WA039URegReperib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA039FRegReperib = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);Override;
  private
    function InizializzaAccesso: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses WA039URegreperibDM, WA039URegreperibBrowseFM, WA039URegreperibDettFM;

{$R *.dfm}

procedure TWA039FRegReperib.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA039FRegreperibDM.Create(Self);
  WBrowseFM:=TWA039FRegreperibBrowseFM.Create(Self);
  WDettaglioFM:=TWA039FRegreperibDettFM.Create(Self);
  CreaTabDefault;
end;

function TWA039FRegReperib.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA039FRegReperib.actConfermaExecute(Sender: TObject);
begin
  with (WR302DM as TWA039FRegreperibDM) do
  begin
    if MsgAllineamentoList <> nil then
      MsgAllineamentoList.Clear;
    if MsgRiepiloghiList <> nil then
      MsgRiepiloghiList.Clear;
  end;
  inherited;
end;

end.
