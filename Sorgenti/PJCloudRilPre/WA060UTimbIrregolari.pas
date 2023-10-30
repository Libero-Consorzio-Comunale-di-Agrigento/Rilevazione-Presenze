unit WA060UTimbIrregolari;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWApplication, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWCompListbox, meIWComboBox, IWDBGrids,
  meIWDBGrid, meIWImageFile, medpIWImageButton, medpIWDBGrid,medpIWMessageDlg, C180FunzioniGenerali,
  A000UInterfaccia, A000UMessaggi, medpIWMultiColumnComboBox, A060UTimbIrregolariMW, Menus;

type
  TWA060FTimbIrregolari = class(TWR100FBase)
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    lblDalBadge: TmeIWLabel;
    lblAlBadge: TmeIWLabel;
    lblAzienda: TmeIWLabel;
    lblBadge: TmeIWLabel;
    lblAziendaDescr: TmeIWLabel;
    lblBadgeDescr: TmeIWLabel;
    btnIniziaRecupero: TmedpIWImageButton;
    btnCancella: TmedpIWImageButton;
    grdRisultati: TmedpIWDBGrid;
    btnRefresh: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    lblDaChiave: TmeIWLabel;
    lblAChiave: TmeIWLabel;
    lblDaScarico: TmeIWLabel;
    lblAScarico: TmeIWLabel;
    cmbDaBadge: TmeIWComboBox;
    cmbABadge: TmeIWComboBox;
    cmbDaChiave: TmeIWComboBox;
    cmbAChiave: TmeIWComboBox;
    cmbDaScarico: TmeIWComboBox;
    cmbAScarico: TmeIWComboBox;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnIniziaRecuperoClick(Sender: TObject);
    procedure cmbDaBadgeChange(Sender: TObject; Index: Integer);
    procedure btnRefreshClick(Sender: TObject);
    procedure edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCancellaClick(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    A060MW:TA060FTimbIrregolariMW;
    procedure AggiornaRisultati;
    procedure CaricaComboBox;
    procedure ResultEliminaTimbrature(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA060FTimbIrregolari.IWAppFormCreate(Sender: TObject);
var DaData, AData: TDateTime;
begin
  inherited;
  try
    A060MW:=TA060FTimbIrregolariMW.Create(Self);
    DaData:=R180InizioMese(Parametri.DataLavoro);
    AData:=R180FineMese(Parametri.DataLavoro);
    edtDaData.Text:=FormatDateTime('dd/MM/yyyy',DaData);
    edtAData.Text:=FormatDateTime('dd/MM/yyyy',AData);
    btnIniziaRecupero.Enabled:=not SolaLettura;
    btnCancella.Enabled:=not SolaLettura;
    grdRisultati.medpPaginazione:=True;
    grdRisultati.medpRighePagina:=10;
    grdRisultati.medpAttivaGrid(A060MW.QI101,False,False,False);
    CaricaComboBox;
    AggiornaRisultati;
  finally
    FreeAndNil(DaData);
    FreeAndNil(AData);
  end;
end;

procedure TWA060FTimbIrregolari.actScaricaInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdRisultati.ToCsv
  else
    inviaFile('Estrazione.xls',csvDownload);
end;

procedure TWA060FTimbIrregolari.actScaricaInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdRisultati.ToXlsx
  else
    inviaFile('Estrazione.xlsx',streamDownload);
end;

procedure TWA060FTimbIrregolari.AggiornaRisultati;
begin
  with A060MW do
  begin
    DaData:=StrToDate(edtDaData.Text);
    AData:=StrToDate(edtAData.Text);
    DaBadge:=cmbDaBadge.Text;
    ABadge:=cmbABadge.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    DaChiave:=cmbDaChiave.Text;
    AChiave:=cmbAChiave.Text;
    DaScarico:=cmbDaScarico.Text;
    AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    CaricaTimbrature;
    grdRisultati.medpAggiornaCDS;
  end;
end;

procedure TWA060FTimbIrregolari.btnCancellaClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A060_DLG_FMT_ELIMINA_TIMBRATURE,[edtDaData.Text,edtAData.Text]),mtConfirmation,[mbYes,mbNo],ResultEliminaTimbrature,'');
end;

procedure TWA060FTimbIrregolari.ResultEliminaTimbrature(Sender: TObject; R: TmeIWModalResult; KI: String);
var Msg:String;
begin
  if R = mrYes then
    with A060MW do
    begin
      DaData:=StrToDate(edtDaData.Text);
      AData:=StrToDate(edtAData.Text);
      DaBadge:=cmbDaBadge.Text;
      ABadge:=cmbABadge.Text;
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
      DaChiave:=cmbDaChiave.Text;
      AChiave:=cmbAChiave.Text;
      DaScarico:=cmbDaScarico.Text;
      AScarico:=cmbAScarico.Text;
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
      Msg:=CancellaTimbrature;
      if Msg <> '' then
        MsgBox.WebMessageDlg(Msg,mtInformation,[mbOK],nil,'');
      grdRisultati.medpAggiornaCDS;
    end;
end;

procedure TWA060FTimbIrregolari.btnIniziaRecuperoClick(Sender: TObject);
var msg:String;
begin
  with A060MW do
  begin
    DaBadge:=cmbDaBadge.Text;
    ABadge:=cmbABadge.Text;
    DaData:=StrToDate(edtDaData.Text);
    AData:=StrToDate(edtAData.Text);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    DaChiave:=cmbDaChiave.Text;
    AChiave:=cmbAChiave.Text;
    DaScarico:=cmbDaScarico.Text;
    AScarico:=cmbAScarico.Text;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
    GrdRisultatiVisibile:=(grdRisultati <> nil) and (grdRisultati.Visible);
    msg:=Scarico;
    lblAziendaDescr.Text:=AziendaDescr;
    lblBadgeDescr.Text:=BadgeDescr;
    if msg <> '' then
      MsgBox.WebMessageDlg(msg,mtInformation,[mbOK],nil,'');
    grdRisultati.medpAggiornaCDS;
  end;
end;

procedure TWA060FTimbIrregolari.CaricaComboBox;
var
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
  //tmpLista:TStringList;
  tmpListaBadge,
  tmpListaChiavi,
  tmpListaScarico: TStringList;
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
begin
  try
    with A060MW do
    begin
      DaData:=StrToDate(edtDaData.Text);
      AData:=StrToDate(edtAData.Text);
    end;
    tmpListaBadge:=A060MW.CaricaListaBadge;
    cmbDaBadge.Items:=tmpListaBadge;
    cmbABadge.Items:=tmpListaBadge;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    // i valori di badge da/a sono impostati vuoti
    {
    if cmbDaBadge.Text = '' then
      cmbDaBadge.Text:='0';
    if cmbABadge.Text = '' then
      cmbABadge.Text:='999999999999999';
    }
    // lista delle chiavi alternative al badge
    tmpListaChiavi:=A060MW.CaricaListaChiavi;
    cmbDaChiave.Items:=tmpListaChiavi;
    cmbAChiave.Items:=tmpListaChiavi;
    // lista delle parametrizzazioni di scarico
    tmpListaScarico:=A060MW.CaricaListaParamScarico;
    cmbDaScarico.Items:=tmpListaScarico;
    cmbAScarico.Items:=tmpListaScarico;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  finally
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.ini
    {
    if tmpLista <> nil then
      FreeAndNil(tmpLista);
    }
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    if tmpListaScarico <> nil then
      FreeAndNil(tmpListaScarico);
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6 - riesame del 15.01.2014.fine
  end;
end;

procedure TWA060FTimbIrregolari.btnRefreshClick(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TWA060FTimbIrregolari.cmbDaBadgeChange(Sender: TObject; Index: Integer);
begin
  AggiornaRisultati;
end;

procedure TWA060FTimbIrregolari.cmbChange(Sender: TObject);
begin
  AggiornaRisultati;
end;

procedure TWA060FTimbIrregolari.edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  try
    //PALERMO_POLICLINICO-159914 - controllato l'errore per data non valida
    StrToDate(edtDaData.Text);
    StrToDate(edtAData.Text);
    AggiornaRisultati;
    grdRisultati.Repaint;
    CaricaComboBox;
  except
    exit;
  end;
end;

procedure TWA060FTimbIrregolari.grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

end.
