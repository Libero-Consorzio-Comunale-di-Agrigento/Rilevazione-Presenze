unit WS028UMotivazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData;

type
  TWS028FMotivazioni = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  WS028UMotivazioniDettFM, WS028UMotivazioniBrowseFM, WS028UMotivazioniDM;

{$R *.dfm}

function TWS028FMotivazioni.InizializzaAccesso:Boolean;
var Codice:String;
begin
  Result:=True;
  Codice:=GetParam('CODICE');
  WR302DM.selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWS028FMotivazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=True;
  WR302DM:=TWS028FMotivazioniDM.Create(Self);
  WBrowseFM:=TWS028FMotivazioniBrowseFM.Create(Self);
  WDettaglioFM:=TWS028FMotivazioniDettFM.Create(Self);
  CreaTabDefault;
end;

end.
