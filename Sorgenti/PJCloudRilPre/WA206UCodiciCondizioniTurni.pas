unit WA206UCodiciCondizioniTurni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, Oracle, OracleData,
  System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit,
  meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA206FCodiciCondizioniTurni = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    CodCond:String;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
                       const PAddToHistory: Boolean;
                       CodCond:String);
  end;

implementation

uses WA206UCodiciCondizioniTurniDM, WA206UCodiciCondizioniTurniBrowseFM, WA206UCodiciCondizioniTurniDettFM;

{$R *.dfm}

constructor TWA206FCodiciCondizioniTurni.Create(AOwner: TComponent;
                                                const PAddToHistory: Boolean;
                                                CodCond:String);
begin
  Self.CodCond:=CodCond;
  inherited Create(AOwner,PAddToHistory);
end;

procedure TWA206FCodiciCondizioniTurni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=False;
  WR302DM:=TWA206FCodiciCondizioniTurniDM.Create(Self);
  WBrowseFM:=TWA206FCodiciCondizioniTurniBrowseFM.Create(Self);
  WDettaglioFM:=TWA206FCodiciCondizioniTurniDettFM.Create(Self);
  CreaTabDefault;
  WR302DM.selTabella.SearchRecord('CODICE',CodCond,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  actElimina.Visible:=False;
  actCopiaSu.Visible:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

end.
