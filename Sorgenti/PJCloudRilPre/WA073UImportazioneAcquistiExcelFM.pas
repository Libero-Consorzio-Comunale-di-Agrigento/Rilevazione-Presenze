unit WA073UImportazioneAcquistiExcelFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData, Oracle,
  Dialogs, Menus, System.Math, System.StrUtils,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, medpIWMessageDlg, W000UMessaggi, C180FunzioniGenerali, WR100UBase, WR200UBaseFM,
  IWCompEdit, meIWEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWApplication,
  IWControl, IWCompLabel, meIWLabel, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  IWCompGrids, IWDBGrids, meIWDBGrid, medpIWDBGrid,
  meIWRadioGroup, IWCompCheckbox, meIWCheckBox, IWCompFileUploader,
  meIWFileUploader, IWAdvRadioGroup, meTIWAdvRadioGroup,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove, FireDAC.Stan.Intf,
  FireDAC.Comp.BatchMove.Text;

type
  TWA073FImportazioneAcquistiExcelFM = class(TWR200FBaseFM)
    dgrdMappaturaExcel: TmedpIWDBGrid;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    rgpTipoImportazione: TmeTIWAdvRadioGroup;
    chkRigaIntestazione: TmeIWCheckBox;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    IWFile: TmeIWFileUploader;
    lblFileExcel: TmeIWLabel;
    dsrMappaturaExcel: TDataSource;
    rgpTipoFile: TmeTIWAdvRadioGroup;
    procedure dgrdMappaturaExcelRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
  private
    Prog:LongInt;
    procedure MsgVisualizzaAnomalie(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
  public
  end;

implementation

uses WA073UAcquistoBuoni, WA073UAcquistoBuoniDM, A073UAcquistoBuoniMW;

{$R *.dfm}

procedure TWA073FImportazioneAcquistiExcelFM.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  if  (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + TWA073FAcquistoBuoni(Self.Owner).medpCodiceForm + ParamDelimiter +
            'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
            'TIPO=A,B';

    TWA073FAcquistoBuoni(Self.Owner).AccediForm(201,Params,True);
  end;
end;

procedure TWA073FImportazioneAcquistiExcelFM.btnEseguiClick(Sender: TObject);
var
  LDS: TDataSet;
  LResCtrl: TResCtrl;
  LFileName:String;
begin
  if TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);

  //verifico estensione del file se compatibile con il radiobutton
  if rgpTipoFile.ItemIndex = 1 then
  begin
    if not (ExtractFileExt(IWFile.NomeFile)= '.csv') then
    begin
      raise Exception.Create('Il file non ha l''estensione corretta');
    end
    else if ((ExtractFileExt(IWFile.NomeFile) = '.csv') and (not chkRigaIntestazione.Checked)) then
    begin
      raise Exception.Create('Per i file csv è obbligatoria la riga di intestazione');
    end
  end;

  // ottenimento del path in cui salvare il file
  if IWFile.IsPresenteFileUploadato then
  begin
    LFileName:=GGetWebApplicationThreadVar.UserCacheDir + IWFile.NomeFile;

    // eliminazione file precedente e effettuazione upload
    DeleteFile(LFileName);
    IWFile.SalvaSuFile(LFileName);
    IWFile.Ripristina;

    //salvataggio path su variabile pubblica per l'utilizzo in R200
    TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.FileName:=LFileName;
  end;

  // aggiorna le opzioni di importazione
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.TipoFile:=IfThen(rgpTipoFile.ItemIndex = 0,TTipoFileRec.XLS,TTipoFileRec.CSV);
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.RigaIntestazione:=chkRigaIntestazione.Checked;
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.TipoImportazione:=IfThen(rgpTipoImportazione.ItemIndex = 0,TTipoImportazioneRec.Buoni,TTipoImportazioneRec.Ticket);
  LDS:=dgrdMappaturaExcel.DataSource.DataSet;
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.ColMatricola:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_MATRICOLA,'COLONNA')),0);
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.ColCodFiscale:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_CODFISCALE,'COLONNA')),0);
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.ColDataAcquisto:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_DATA_ACQUISTO,'COLONNA')),0);
  TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.ColQuantita:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_QUANTITA,'COLONNA')),0);

  // verifica impostazioni
  LResCtrl:=TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.VerificaOpzioniImportazione;
  if not LResCtrl.Ok then
  begin
    raise Exception.Create(LResCtrl.Messaggio);
  end;

  try
    //importa file
    TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.EseguiImportazione;
    // verifica risultato elaborazione
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB);
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
    begin
      MsgBox.WebMessageDlg('Elaborazione terminata con anomalie.'#13#10'Si desidera visualizzarle?',mtConfirmation,[mbYes,mbNo],MsgVisualizzaAnomalie,'','Anomalie riscontrate',mbYes);
      exit;
    end
    else
    begin
      R180MessageBox('Elaborazione terminata', INFORMA);
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(Format('Elaborazione fallita: %s (%s)',[E.Message,E.ClassName]));
    end;
  end;
end;

procedure TWA073FImportazioneAcquistiExcelFM.MsgVisualizzaAnomalie(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if ModalResult = mrYes then
    btnAnomalieClick(nil);
end;

procedure TWA073FImportazioneAcquistiExcelFM.dgrdMappaturaExcelRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=dgrdMappaturaExcel.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(dgrdMappaturaExcel.medpCompGriglia) + 1) and (dgrdMappaturaExcel.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdMappaturaExcel.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA073FImportazioneAcquistiExcelFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // prepara i dati per l'importazione
  with TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW do
    PreparaImportazione(dsrMappaturaExcel);
  dgrdMappaturaExcel.medpAttivaGrid(TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.cdsMappaturaExcel,True,False,False);
  dgrdMappaturaExcel.Visible:=True;

  //TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.LeggiInfoFile; --passaggio inutile

  // legge altre opzioni
  rgpTipoFile.ItemIndex:=IfThen(TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.TipoFile = TTipoFileRec.XLS,0,1);
  chkRigaIntestazione.Checked:=TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.RigaIntestazione;
  rgpTipoImportazione.ItemIndex:=IfThen(TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.TipoImportazione = TTipoImportazioneRec.Buoni,0,1);

  // abilitazione pulsanti visualizzazione file
  btnEsegui.Confirmation:='Effettuare l''importazione dei dati di acquisto '+ CRLF +
                          'contenuti nel file Excel indicato ' + CRLF +
                          'e relativi ai dipendenti selezionati?';
  btnEsegui.Enabled:=(TWA073FAcquistoBuoniDM(Self.WR302DM).A073MW.FOpzioni.FileName <> '');
  btnAnomalie.Enabled:=False;
end;

end.
