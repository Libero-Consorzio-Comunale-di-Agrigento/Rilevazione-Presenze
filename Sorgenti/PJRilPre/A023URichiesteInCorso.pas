unit A023URichiesteInCorso;

interface

uses
  A023UTimbratureDtm1,
  A023UTimbratureMW,
  FunzioniGenerali,
  A000UCostanti, C018UIterAutDM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Data.DB,
  OracleData, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls, System.Math;

type
  TPanelBlock = record
    Panel: TPanel;
    Grid: TDBGrid;
    Splitter: TSplitter;
  private
    function  GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
  end;


  TA023FRichiesteInCorso = class(TForm)
    dsrVT050: TDataSource;
    dsrVT105: TDataSource;
    pmnInfo: TPopupMenu;
    mnuInfoRichiesta: TMenuItem;
    pnlTimbrature: TPanel;
    pnlData: TPanel;
    lblData: TLabel;
    dgrdRichiesteTimb: TDBGrid;
    splTimbrature: TSplitter;
    pnlTimbratureHead: TPanel;
    lblTimbrature: TLabel;
    pnlGiustificativi: TPanel;
    pnlGiustificativiHead: TPanel;
    lblGiustificativi: TLabel;
    dgrdRichiesteGiust: TDBGrid;
    splGiustificativi: TSplitter;
    pnlCambioOrario: TPanel;
    pnlCambioOrarioHead: TPanel;
    lblCambioOrario: TLabel;
    dgrdRichiesteCambioOrario: TDBGrid;
    splCambioOrario: TSplitter;
    dsrVT085: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure mnuInfoRichiestaClick(Sender: TObject);
  private
    FData: TDateTime;
    FPanelBlockArr: array[0..2] of TPanelBlock;
    procedure SetData(Value: TDateTime);
    procedure MostraInfoRichiesta(const PId: Integer);
    procedure RealignPanels;
    const
      SPLITTER_HEIGHT = 5;
  public
    property Data: TDateTime read FData write SetData;
  end;

implementation

uses
  C023UInfoDati;

{$R *.dfm}

procedure TA023FRichiesteInCorso.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // imposta la struttura dati di visualizzazione
  i:=0;
  dgrdRichiesteTimb.DataSource.DataSet:=A023FTimbratureDtM1.A023FTimbratureMW.selVT105;
  FPanelBlockArr[i].Panel:=pnlTimbrature;
  FPanelBlockArr[i].Grid:=dgrdRichiesteTimb;
  FPanelBlockArr[i].Splitter:=splTimbrature;

  i:=i + 1;
  dgrdRichiesteGiust.DataSource.DataSet:=A023FTimbratureDtM1.A023FTimbratureMW.selVT050;
  FPanelBlockArr[i].Panel:=pnlGiustificativi;
  FPanelBlockArr[i].Grid:=dgrdRichiesteGiust;
  FPanelBlockArr[i].Splitter:=splGiustificativi;

  i:=i + 1;
  dgrdRichiesteCambioOrario.DataSource.DataSet:=A023FTimbratureDtM1.A023FTimbratureMW.selVT085;
  FPanelBlockArr[i].Panel:=pnlCambioOrario;
  FPanelBlockArr[i].Grid:=dgrdRichiesteCambioOrario;
  FPanelBlockArr[i].Splitter:=splCambioOrario;
end;

procedure TA023FRichiesteInCorso.FormShow(Sender: TObject);
var
  LDS: TDataSet;
  LTotRich: Integer;
  i: Integer;
  LPnlBlock: TPanelBlock;
begin
  LTotRich:=0;
  for i:=Low(FPanelBlockArr) to High(FPanelBlockArr) do
  begin
    LPnlBlock:=FPanelBlockArr[i];

    // filtra il dataset sulla data indicata
    LDS:=LPnlBlock.Grid.DataSource.DataSet;
    LDS.Filtered:=False;
    LDS.Filter:=Format('DATA = %s',[FloatToStr(FData)]);
    LDS.Filtered:=True;

    // imposta la visibilità del pannello
    LPnlBlock.SetVisible(LDS.RecordCount > 0);

    LTotRich:=LTotRich + LDS.RecordCount;
  end;

  RealignPanels;

  if LTotRich = 0 then
    ShowMessage('Nessuna richiesta!');
end;

procedure TA023FRichiesteInCorso.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
  LDS: TDataSet;
begin
  for i:=Low(FPanelBlockArr) to High(FPanelBlockArr) do
  begin
    LDS:=FPanelBlockArr[i].Grid.DataSource.DataSet;
    LDS.Filtered:=False;
  end;
end;

procedure TA023FRichiesteInCorso.RealignPanels;
var
  i: Integer;
  LPnlBlock: TPanelBlock;
  LH: Integer;
begin
  LH:=pnlData.Height;

  for i:=High(FPanelBlockArr) downto Low(FPanelBlockArr) do
  begin
    LPnlBlock:=FPanelBlockArr[i];

    if not LPnlBlock.GetVisible then
      Continue;

    // imposta splitter
    LPnlBlock.Splitter.Visible:=True;
    LPnlBlock.Splitter.Top:=0;
    LPnlBlock.Splitter.Height:=SPLITTER_HEIGHT;

    // imposta panel
    LPnlBlock.Panel.Align:=TAlign.alTop;
    LPnlBlock.Panel.Top:=0;

    // determina altezza componenti
    LH:=LH + LPnlBlock.Panel.Height + LPnlBlock.Splitter.Height
  end;

  for i:=High(FPanelBlockArr) downto Low(FPanelBlockArr) do
  begin
    LPnlBlock:=FPanelBlockArr[i];

    if LPnlBlock.GetVisible then
    begin
      LPnlBlock.Splitter.Visible:=False;
      LH:=LH - LPnlBlock.Splitter.Height;
      LPnlBlock.Panel.Align:=TAlign.alClient;
      Break;
    end;
  end;

  // riporta il pannello data al top
  pnlData.Top:=0;

  ClientHeight:=Min(800,Max(150,LH));
end;

procedure TA023FRichiesteInCorso.SetData(Value: TDateTime);
begin
  FData:=Value;
  lblData.Caption:='Data di riferimento: ' + FData.ToString('dd/mm/yyyy');
end;

procedure TA023FRichiesteInCorso.MostraInfoRichiesta(const PId: Integer);
var
  LC023: TC023FInfoDati;
begin
  LC023:=TC023FInfoDati.Create(nil);
  try
    LC023.MostraInfoRichiesta(PId);
  finally
    FreeAndNil(LC023);
  end;
end;

procedure TA023FRichiesteInCorso.mnuInfoRichiestaClick(Sender: TObject);
var
  LGrid: TComponent;
  LId: Integer;
begin
  if (Sender = nil) or
     (not (Sender is TMenuItem)) or
     (TMenuItem(Sender).GetParentMenu = nil) or
     (not (TMenuItem(Sender).GetParentMenu is TPopupMenu)) then
    Exit;

  LGrid:=TPopupMenu(TMenuItem(Sender).GetParentMenu).PopupComponent;

  if LGrid = nil then
    Exit;

  if not (LGrid is TDBGrid) then
    Exit;

  LId:=(LGrid as TDBGrid).DataSource.DataSet.FieldByName('ID').AsInteger;

  if LId > 0 then
    MostraInfoRichiesta(LId);
end;

{ TPanelBlock }

function TPanelBlock.GetVisible: Boolean;
begin
  Result:=Panel.Visible;
end;

procedure TPanelBlock.SetVisible(const Value: Boolean);
begin
  Panel.Visible:=Value;
  Splitter.Visible:=Value;
end;

end.
