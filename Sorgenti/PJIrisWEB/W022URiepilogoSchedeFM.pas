unit W022URiepilogoSchedeFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm, C180FunzioniGenerali, IWRegion,
  IWCompButton, IWTemplateProcessorHTML, R010UPAGINAWEB, StrUtils, IWApplication,
  C190FunzioniGeneraliWeb, DBClient, IWCompJQueryWidget, IWCompGrids,
  meIWGrid, meIWButton, IWVCLComponent, IWBaseLayoutComponent, A000UInterfaccia,
  IWBaseContainerLayout, IWContainerLayout, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWCompExtCtrls, meIWRadioGroup,
  IWCompLabel, meIWLabel;

type
  TW022FRiepilogoSchedeFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    jQRiepilogoSchede: TIWJQueryWidget;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    grdRiepilogoSchede: TmeIWGrid;
    btnEsportaInExcel: TmeIWButton;
    lblTipoRiepilogo: TmeIWLabel;
    rgpTipoRiepilogo: TmeIWRadioGroup;
    btnEsportaInCSV: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRiepilogoSchedeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnEsportaInExcelClick(Sender: TObject);
    procedure rgpTipoRiepilogoClick(Sender: TObject);
    procedure btnEsportaInCSVClick(Sender: TObject);
  private
    { Private declarations }
    function  ToCsv: String;
    procedure PopolaGrid;
  public
    ARiepilogo,MRiepilogo,GRiepilogo:Word;
    cdsRiepilogo:TClientDataSet;
    procedure Visualizza(Data:TDateTime; NonValutabili:Boolean = False);
  end;

implementation

{$R *.dfm}

procedure TW022FRiepilogoSchedeFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW022FRiepilogoSchedeFM.btnEsportaInExcelClick(Sender: TObject);
begin
  (Self.Owner as TR010FPaginaWeb).InviaFile('Riepilogo schede per l''anno ' + IntToStr(ARiepilogo) + '.xlsx',R180DatasetToXlsx(SessioneOracle,False,cdsRiepilogo,nil));
end;

procedure TW022FRiepilogoSchedeFM.btnEsportaInCSVClick(Sender: TObject);
begin
  (Self.Owner as TR010FPaginaWeb).InviaFile('Riepilogo schede per l''anno ' + IntToStr(ARiepilogo) + '.xls',ToCsv);
end;

function TW022FRiepilogoSchedeFM.ToCsv: String;
var
  Riga,ElencoCampiInvisibili: String;
  i: Integer;
begin
  Result:='';
  Riga:='';

  ElencoCampiInvisibili:='A';
  with cdsRiepilogo do
  begin
    if not Active then
      exit;
    DisableControls;
    First;
    try
      while not EOF do
      begin
        Riga:='';
        for i:=0 to FieldCount - 1 do
          if Pos(',' + Fields[i].FieldName + ',',',' + ElencoCampiInvisibili + ',') = 0 then
            Riga:=Riga + '"' + Trim(Fields[i].AsString) + '"' + TAB;
        Result:=Result + Riga + CRLF;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
  end;
end;

procedure TW022FRiepilogoSchedeFM.grdRiepilogoSchedeRenderCell(ACell: TIWGridCell;const ARow, AColumn: Integer);
begin
  ACell.Css:='';
  if AColumn = 0 then //Colonna ordinamento
    ACell.Css:='invisibile';
  if AColumn = 2 then //Descrizioni
    ACell.Wrap:=True;
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '1') and (AColumn > 0) then
    ACell.Css:='riga_intestazione';
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '2') and (AColumn > 0) then
    ACell.Css:='bg_celeste';
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '3') and (AColumn > 0) then
    ACell.Css:='riga_colorata';
  if (grdRiepilogoSchede.Cell[ARow,0].Text = '4') and (AColumn > 0) then
    ACell.Css:='bg_celeste';
end;

procedure TW022FRiepilogoSchedeFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TW022FRiepilogoSchedeFM.rgpTipoRiepilogoClick(Sender: TObject);
begin
  PopolaGrid;
end;

procedure TW022FRiepilogoSchedeFM.PopolaGrid;
var
  i:Integer;
begin
  with cdsRiepilogo do
  begin
    Filtered:=False;
    Filter:=IfThen(rgpTipoRiepilogo.ItemIndex = 0,'A IN (''1'',''2'',''3'',''9'')',
            IfThen(rgpTipoRiepilogo.ItemIndex = 1,'A = ''1''',
            IfThen(rgpTipoRiepilogo.ItemIndex = 2,'A IN (''4'',''9'')',
            IfThen(rgpTipoRiepilogo.ItemIndex = 3,'E = ''S''',
            IfThen(rgpTipoRiepilogo.ItemIndex = 4,'F = ''S''')))));
    Filtered:=True;
    First;
    grdRiepilogoSchede.ColumnCount:=4;
    grdRiepilogoSchede.RowCount:=cdsRiepilogo.RecordCount;

    i:=0;
    while not Eof do
    begin
      grdRiepilogoSchede.Cell[i,0].Text:=FieldByName('A').AsString;
      grdRiepilogoSchede.Cell[i,1].Text:=FieldByName('B').AsString;
      grdRiepilogoSchede.Cell[i,2].Text:=FieldByName('C').AsString;
      grdRiepilogoSchede.Cell[i,3].Text:=FieldByName('D').AsString;
      Next;
      i:=i+1;
    end;

    btnEsportaInExcel.Enabled:=RecordCount > 0;
    btnEsportaInCSV.Enabled:=RecordCount > 0;
  end;
end;

procedure TW022FRiepilogoSchedeFM.Visualizza(Data:TDateTime; NonValutabili:Boolean = False);
begin
  if NonValutabili then
    rgpTipoRiepilogo.Items.Add('Solo non valutabili');
  PopolaGrid;
  DecodeDate(Data,ARiepilogo,MRiepilogo,GRiepilogo);
  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQRiepilogoSchede, 800, -1,EM2PIXEL * 50, 'Riepilogo schede per l''anno ' + IntToStr(ARiepilogo), '#' + Name, False, True);
end;

end.
