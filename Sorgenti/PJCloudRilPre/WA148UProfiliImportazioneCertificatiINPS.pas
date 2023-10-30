unit WA148UProfiliImportazioneCertificatiINPS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, OracleData,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA148FProfiliImportazioneCertificatiINPS = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses WA148UProfiliImportazioneCertificatiINPSDM, WA148UProfiliImportazioneCertificatiINPSBrowseFM;

{$R *.dfm}

function TWA148FProfiliImportazioneCertificatiINPS.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA148FProfiliImportazioneCertificatiINPS.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA148FProfiliImportazioneCertificatiINPSDM.Create(Self);
  WBrowseFM:=TWA148FProfiliImportazioneCertificatiINPSBrowseFM.Create(Self);
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  CreaTabDefault;
end;

end.
