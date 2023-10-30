unit WA096UProfiliLibProf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData;

type
  TWA096FProfiliLibProf = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    function InizializzaAccesso: Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses WA096UProfiliLibProfBrowseFM, WA096UProfiliLibProfDM, WA096UPianificazioneFM;
{$R *.dfm}

procedure TWA096FProfiliLibProf.IWAppFormCreate(Sender: TObject);
var
  Detail: TWA096FPianificazioneFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA096FProfiliLibProfDM.Create(Self);
  WBrowseFM:=TWA096FProfiliLibProfBrowseFM.Create(Self);

  Detail:=TWA096FPianificazioneFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA096FProfiliLibProfDM(WR302DM).Q311,TWA096FProfiliLibProfDM(WR302DM).D311);

  CreaTabDefault;
end;

function TWA096FProfiliLibProf.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

end.
