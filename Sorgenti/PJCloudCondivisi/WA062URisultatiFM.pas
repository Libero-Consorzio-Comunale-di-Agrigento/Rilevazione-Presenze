unit WA062URisultatiFM;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  medpIWMessageDlg, A000UInterfaccia, IWCompGrids, IWDBGrids, medpIWDBGrid, IWCompEdit, meIWEdit, IWCompButton,
  meIWButton, IWCompExtCtrls,meIWImageFile, medpIWImageButton, IWCompCheckbox, meIWCheckBox, IWCompLabel,
  meIWLabel,C180FunzioniGenerali, Menus, A000UCostanti, meIWRadioGroup, IWApplication;

type
  TWA062FRisultatiFM = class(TWR200FBaseFM)
    grdRisultati: TmedpIWDBGrid;
    lblSalvataggioRisultato: TmeIWLabel;
    chkIntestazione: TmeIWCheckBox;
    chkNoRitornoACapo: TmeIWCheckBox;
    btnEsportaFile: TmedpIWImageButton;
    lblNomeTabella: TmeIWLabel;
    edtNomeTab: TmeIWEdit;
    btnCartellino: TmedpIWImageButton;
    btnCreaTab: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    actEsportaExcel: TMenuItem;
    lblInfo: TmeIWLabel;
    lblFormatoFile: TmeIWLabel;
    rgpFormatoFile: TmeIWRadioGroup;
    actEsportaCSV: TMenuItem;
    procedure btnCreaTabClick(Sender: TObject);
    procedure grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure edtNomeTabAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure actEsportaExcelClick(Sender: TObject);
    procedure btnEsportaFileClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnCartellinoClick(Sender: TObject);
    procedure actEsportaCSVClick(Sender: TObject);
  private
    { Private declarations}
  public
    { Public declarations }
  end;

implementation

uses WA062UQueryServizio, WA062UQueryServizioDM, WA062UQueryServizioDettFM;

{$R *.dfm}

procedure TWA062FRisultatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdRisultati.medpPaginazione:=True;
  grdRisultati.medpRighePagina:=2000;
end;

procedure TWA062FRisultatiFM.IWFrameRegionRender(Sender: TObject);
var nome:String;
begin
  inherited;
  nome:=(WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString;
  edtNomeTab.Text:='';
  with TWA062FQueryServizioDettFM((Self.Owner as TWA062FQueryServizio).WDettaglioFM) do
    if (Trim(nome) <> '') and (edtNomeTab.Text = '') and
       (Trim(memoSql.Lines.Text) <> '') then
      edtNomeTab.Text:=nome;
  with (WR302DM as TWA062FQueryServizioDM).A062MW.Q1 do
    if State <> dsInactive then
    begin
      btnCartellino.Enabled:=(Parametri.Applicazione = 'RILPRE') and (RecordCount > 0);
      btnCartellino.Visible:=btnCartellino.Enabled;
      btnEsportaFile.Enabled:=RecordCount > 0;
      btnCreaTab.Enabled:=(RecordCount > 0) and (Trim(edtNomeTab.Text) <> '');
    end
    else
    begin
      btnCartellino.Visible:=False;
      btnEsportaFile.Enabled:=False;
      btnCreaTab.Enabled:=False;
    end;
end;

procedure TWA062FRisultatiFM.btnCartellinoClick(Sender: TObject);
var Data:TDateTime;
    Params: String;
begin
  inherited;
  try
    Data:=TWA062FQueryServizioDM(WR302DM).A062MW.Q1.FieldByName('Data').AsDatetime
  except
    Data:=Parametri.DataLavoro;
  end;
  with TWA062FQueryServizioDM(WR302DM).A062MW.Q1 do
    Params:='PROGRESSIVO=' + FieldByName('PROGRESSIVO').AsString + ParamDelimiter +
            'DATARIF=' + DateToStr(Data);
  (Self.Owner as TWA062FQueryServizio).AccediForm(7,Params,True);
end;

procedure TWA062FRisultatiFM.btnCreaTabClick(Sender: TObject);
var
  LElapsedMs: Int64;
begin
  TWA062FQueryServizioDettFM((Self.Owner as TWA062FQueryServizio).WDettaglioFM).EseguiSql(Sender,LElapsedMs);

  // riporta il tempo di elaborazione a video
  (Self.Owner as TWA062FQueryServizio).grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='Durata esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LElapsedMs / MSecsPerDay);
end;

procedure TWA062FRisultatiFM.edtNomeTabAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  btnCreaTab.Enabled:=Trim(edtNomeTab.Text) <> '';
end;

procedure TWA062FRisultatiFM.grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TWA062FRisultatiFM.btnEsportaFileClick(Sender: TObject);
var NomeFile:String;
    StreamFile: TStream;
begin
  with TWA062FQueryServizioDM(WR302DM).A062MW do
  begin
    chkIntestazioneChecked:=chkIntestazione.Checked;
    chkNoRitornoACapoChecked:=chkNoRitornoACapo.Checked;
    NomeFile:=(WR302DM as TWA062FQueryServizioDM).SelTabella.FieldByName('NOME').AsString + '.' + rgpFormatoFile.Items[rgpFormatoFile.ItemIndex];
    StreamFile:=CreaTestoFile(NomeFile);
  end;
  (Self.Owner as TWA062FQueryServizio).inviaFile(NomeFile,StreamFile);
end;

procedure TWA062FRisultatiFM.actEsportaCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWA062FQueryServizio).csvDownload:=grdRisultati.ToCsv
  else
    (Self.Owner as TWA062FQueryServizio).inviaFile('Estrazione.xls',(Self.Owner as TWA062FQueryServizio).csvDownload);
end;

procedure TWA062FRisultatiFM.actEsportaExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    (Self.Owner as TWA062FQueryServizio).streamDownload:=grdRisultati.ToXlsx
  else
    (Self.Owner as TWA062FQueryServizio).inviaFile('Estrazione.xlsx',(Self.Owner as TWA062FQueryServizio).streamDownload);
end;

end.
