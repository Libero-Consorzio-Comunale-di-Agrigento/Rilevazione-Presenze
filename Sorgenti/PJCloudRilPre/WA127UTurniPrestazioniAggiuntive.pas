unit WA127UTurniPrestazioniAggiuntive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, OracleData,
  System.Actions;

type
  TWA127FTurniPrestazioniAggiuntive = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses WA127UTurniPrestazioniAggiuntiveDM,
     WA127UTurniPrestazioniAggiuntiveBrowseFM,
     WA127UTurniPrestazioniAggiuntiveDettFM;

{$R *.dfm}

procedure TWA127FTurniPrestazioniAggiuntive.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA127FTurniPrestazioniAggiuntiveDM.Create(Self);
  WBrowseFM:=TWA127FTurniPrestazioniAggiuntiveBrowseFM.Create(Self);
  WDettaglioFM:=TWA127FTurniPrestazioniAggiuntiveDettFM.Create(Self);
  CreaTabDefault;
end;

function TWA127FTurniPrestazioniAggiuntive.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
