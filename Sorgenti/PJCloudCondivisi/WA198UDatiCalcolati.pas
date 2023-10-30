unit WA198UDatiCalcolati;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA198UDatiCalcolatiDM, WA198UDatiCalcolatiBrowseFM,
  WA198UDatiCalcolatiDettFM, OracleData;

type
  TWA198FDatiCalcolati = class(TWR102FGestTabella)
    actInutilizzati: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actInutilizzatiExecute(Sender: TObject);
  protected
    procedure AbilitaActListNavBar(Browse: boolean); override;
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA198FDatiCalcolati.AbilitaActListNavBar(Browse: boolean);
begin
  actInutilizzati.Enabled:=Browse;
  inherited;
end;

procedure TWA198FDatiCalcolati.actInutilizzatiExecute(Sender: TObject);
var
  RI: String;
begin
  actInutilizzati.Checked:=not actInutilizzati.Checked;
  with (WR302DM as TWA198FDatiCalcolatiDM) do
  begin
    RI:=selTabella.RowID;
    R003FGeneratoreStampeMW.setFiltroInutilizzati(selTabella,actInutilizzati.Checked);
    selTabella.SearchRecord('ROWID',RI,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS;
    AggiornaRecord;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

function TWA198FDatiCalcolati.InizializzaAccesso: Boolean;
begin
  WR302DM.selTabella.SearchRecord('ID_SERBATOIO',StrToIntDef(getParam('IDSERBATOIO'),-1),[srFromBeginning]);
  WR302DM.selTabella.SearchRecord('NOME',getParam('NOME'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;

  Result:=True;
end;

procedure TWA198FDatiCalcolati.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA198FDatiCalcolatiDM.Create(Self);
  WBrowseFM:=TWA198FDatiCalcolatiBrowseFM.Create(Self);
  WDettaglioFM:=TWA198FDatiCalcolatiDettFM.Create(Self);

  CreaTabDefault;
end;

end.

