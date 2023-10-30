unit WC028URichiesteInCorsoFM;

interface

uses
  A023UTimbratureMW,
  C190FunzioniGeneraliWeb,
  FunzioniGenerali,
  WC027UInfoDatiFM,
  WR010UBase,
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWCompButton, meIWButton,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWHTMLContainer,
  IWHTML40Container, Vcl.Menus, meIWImageFile, System.StrUtils, C018UIterAutDM, A000UCostanti;

type
  TWC028FRichiesteInCorsoFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    dgrdRichiesteTimb: TmedpIWDBGrid;
    dgrdRichiesteGiust: TmedpIWDBGrid;
    lblGiustificativi: TmeIWLabel;
    lblTimbrature: TmeIWLabel;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    btnChiudi: TmeIWButton;
    lblData: TmeIWLabel;
    lblCambioOrario: TmeIWLabel;
    dgrdRichiesteCambioOrario: TmedpIWDBGrid;
    procedure btnChiudiClick(Sender: TObject);
    procedure dgrdRichiesteTimbRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure dgrdRichiesteGiustRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure dgrdRichiesteTimbAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure dgrdRichiesteGiustAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure dgrdRichiesteCambioOrarioAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure dgrdRichiesteCambioOrarioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    procedure MostraInfoRichiesta(const PId: Integer);
    procedure imgAccediTimbClick(Sender: TObject);
    procedure imgAccediGiustClick(Sender: TObject);
    procedure imgAccediCambioOrarioClick(Sender: TObject);
    { Private declarations }
  public
    A023MW: TA023FTimbratureMW;
    procedure Visualizza(const PData: TDateTime);
  end;

implementation

{$R *.dfm}

procedure TWC028FRichiesteInCorsoFM.btnChiudiClick(Sender: TObject);
begin
  // ripristina lo stato di filter dei dataset
  A023MW.selVT105.Filtered:=False;
  A023MW.selVT050.Filtered:=False;
  A023MW.selVT085.Filtered:=False;
  // distrugge il frame
  Free;
end;

procedure TWC028FRichiesteInCorsoFM.MostraInfoRichiesta(const PId: Integer);
var
  WC027: TWC027FInfoDatiFM;
begin
  WC027:=TWC027FInfoDatiFM.Create(Self.Owner);
  WC027.MostraInfoRichiesta(PId);
end;

procedure TWC028FRichiesteInCorsoFM.dgrdRichiesteCambioOrarioAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  LIWImg: TmeIWImageFile;
begin
  for r:=0 to High(dgrdRichiesteCambioOrario.medpCompGriglia) do
  begin
    if dgrdRichiesteCambioOrario.medpCompCella(r,DBG_COMANDI,0) <> nil then
    begin
      LIWImg:=(dgrdRichiesteCambioOrario.medpCompCella(r,DBG_COMANDI,0) as TmeIWImageFile);
      LIWImg.Enabled:=true;
      LIWImg.Hint:='Accedi info richiesta';
      LIWImg.OnClick:=imgAccediCambioOrarioClick;
    end;
  end;
end;

procedure TWC028FRichiesteInCorsoFM.dgrdRichiesteCambioOrarioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=dgrdRichiesteCambioOrario.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(dgrdRichiesteCambioOrario.medpCompGriglia) + 1) and (dgrdRichiesteCambioOrario.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdRichiesteCambioOrario.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWC028FRichiesteInCorsoFM.dgrdRichiesteGiustAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  LIWImg: TmeIWImageFile;
begin
  for r:=0 to High(dgrdRichiesteGiust.medpCompGriglia) do
  begin
    if dgrdRichiesteGiust.medpCompCella(r,DBG_COMANDI,0) <> nil then
    begin
      LIWImg:=(dgrdRichiesteGiust.medpCompCella(r,DBG_COMANDI,0) as TmeIWImageFile);
      LIWImg.Enabled:=true;
      LIWImg.Hint:='Accedi info richiesta';
      LIWImg.OnClick:=imgAccediGiustClick;
    end;
  end;
end;

procedure TWC028FRichiesteInCorsoFM.dgrdRichiesteGiustRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=dgrdRichiesteGiust.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(dgrdRichiesteGiust.medpCompGriglia) + 1) and (dgrdRichiesteGiust.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdRichiesteGiust.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWC028FRichiesteInCorsoFM.dgrdRichiesteTimbAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  LIWImg: TmeIWImageFile;
begin
  for r:=0 to High(dgrdRichiesteTimb.medpCompGriglia) do
  begin
    if dgrdRichiesteTimb.medpCompCella(r,DBG_COMANDI,0) <> nil then
    begin
      LIWImg:=(dgrdRichiesteTimb.medpCompCella(r,DBG_COMANDI,0) as TmeIWImageFile);
      LIWImg.Enabled:=true;
      LIWImg.Hint:='Accedi info richiesta';
      LIWImg.OnClick:=imgAccediTimbClick;
    end;
  end;
end;

procedure TWC028FRichiesteInCorsoFM.dgrdRichiesteTimbRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=dgrdRichiesteTimb.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(dgrdRichiesteTimb.medpCompGriglia) + 1) and (dgrdRichiesteTimb.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdRichiesteTimb.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWC028FRichiesteInCorsoFM.imgAccediTimbClick(Sender: TObject);
var
  LId: Integer;
begin
  LId:=dgrdRichiesteTimb.medpDataSet.FieldByName('ID').AsInteger;
  if LId > 0 then
    MostraInfoRichiesta(LId);
end;

procedure TWC028FRichiesteInCorsoFM.imgAccediCambioOrarioClick(Sender: TObject);
var
  LId: Integer;
begin
  LId:=dgrdRichiesteCambioOrario.medpDataSet.FieldByName('ID').AsInteger;
  if LId > 0 then
    MostraInfoRichiesta(LId);
end;

procedure TWC028FRichiesteInCorsoFM.imgAccediGiustClick(Sender: TObject);
var
  LId: Integer;
begin
  LId:=dgrdRichiesteGiust.medpDataSet.FieldByName('ID').AsInteger;
  if LId > 0 then
    MostraInfoRichiesta(LId);
end;

procedure TWC028FRichiesteInCorsoFM.Visualizza(const PData: TDateTime);
var
  LTimbVisible: Boolean;
  LGiustVisible: Boolean;
  LCambioOrarioVisible: Boolean;
  LJSCode: String;
begin
  LJSCode:='';
  lblData.Caption:='Data di riferimento: ' + PData.ToString('dd/mm/yyyy');

  // imposta grid timbrature
  A023MW.selVT105.Filtered:=False;
  A023MW.selVT105.Filter:=Format('DATA = %s',[FloatToStr(PData)]);
  A023MW.selVT105.Filtered:=True;

  LTimbVisible:=A023MW.selVT105.RecordCount > 0;
  lblTimbrature.Visible:=LTimbVisible;
  dgrdRichiesteTimb.Visible:=LTimbVisible;

  // predispone grid
  if LTimbVisible then
  begin
    dgrdRichiesteTimb.medpPaginazione:=False;
    dgrdRichiesteTimb.medpComandiCustom:=True;
    dgrdRichiesteTimb.medpTestoNoRecord:='Nessuna richiesta';
    dgrdRichiesteTimb.medpRowSelect:=False;
    dgrdRichiesteTimb.medpAttivaGrid(A023MW.selVT105,False,False,False);
    dgrdRichiesteTimb.medpPreparaComponentiDefault;
    dgrdRichiesteTimb.medpPreparaComponenteGenerico('WR102-R',DBG_COMANDI,0,DBG_IMG,'','ACCEDI','','','');
    dgrdRichiesteTimb.medpCaricaCDS;
  end;

  // imposta grid giustificativi
  A023MW.selVT050.Filtered:=False;
  A023MW.selVT050.Filter:=Format('DATA = %s',[FloatToStr(PData)]);
  A023MW.selVT050.Filtered:=True;

  LGiustVisible:=A023MW.selVT050.RecordCount > 0;
  lblGiustificativi.Visible:=LGiustVisible;
  dgrdRichiesteGiust.Visible:=LGiustVisible;

  // predispone grid
  if LGiustVisible then
  begin
    dgrdRichiesteGiust.medpPaginazione:=False;
    dgrdRichiesteGiust.medpComandiCustom:=True;
    dgrdRichiesteGiust.medpTestoNoRecord:='Nessuna richiesta';
    dgrdRichiesteGiust.medpRowSelect:=False;
    dgrdRichiesteGiust.medpAttivaGrid(A023MW.selVT050,False,False,False);
    dgrdRichiesteGiust.medpPreparaComponentiDefault;
    dgrdRichiesteGiust.medpPreparaComponenteGenerico('WR102-R',DBG_COMANDI,0,DBG_IMG,'','ACCEDI','','','');
    dgrdRichiesteGiust.medpCaricaCDS;
  end;

  // imposta grid cambio orario
  A023MW.selVT085.Filtered:=False;
  A023MW.selVT085.Filter:=Format('DATA = %s',[FloatToStr(PData)]);
  A023MW.selVT085.Filtered:=True;

  LCambioOrarioVisible:=A023MW.selVT085.RecordCount > 0;
  lblCambioOrario.Visible:=LCambioOrarioVisible;
  dgrdRichiesteCambioOrario.Visible:=LCambioOrarioVisible;

  // predispone grid
  if LCambioOrarioVisible then
  begin
    dgrdRichiesteCambioOrario.medpPaginazione:=False;
    dgrdRichiesteCambioOrario.medpComandiCustom:=True;
    dgrdRichiesteCambioOrario.medpTestoNoRecord:='Nessuna richiesta';
    dgrdRichiesteCambioOrario.medpRowSelect:=False;
    dgrdRichiesteCambioOrario.medpAttivaGrid(A023MW.selVT085,False,False,False);
    dgrdRichiesteCambioOrario.medpPreparaComponentiDefault;
    dgrdRichiesteCambioOrario.medpPreparaComponenteGenerico('WR102-R',DBG_COMANDI,0,DBG_IMG,'','ACCEDI','','','');
    dgrdRichiesteCambioOrario.medpCaricaCDS;
  end;

  // visibilità elementi contenitori
  LJSCode:=LJSCode +
    Format('$("#divTimbrature").%s();'#13#10,[IfThen(LTimbVisible,'show','hide')]) +
    Format('$("#divGiustificativi").%s();'#13#10,[IfThen(LGiustVisible,'show','hide')]);
    Format('$("#divCambioOrario").%s();'#13#10,[IfThen(LCambioOrarioVisible,'show','hide')]);
  (Self.Owner as TWR010FBase).AddToInitProc(LJSCode);

  // visualizza modal dialog
  (Self.Owner as TWR010FBase).VisualizzajQMessaggio(jQVisFrame,820,-1,EM2PIXEL * 24,'<WC028> Richieste in corso','#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
end;

end.