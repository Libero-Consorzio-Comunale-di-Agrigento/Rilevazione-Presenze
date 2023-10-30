unit A073UImportazioneAcquistiExcel;

interface

uses
  A000UInterfaccia,
  C180FunzioniGenerali,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, System.IOUtils, Winapi.ShellAPI, A000UCostanti,
  C700USelezioneAnagrafe, Winapi.ActiveX, System.Win.ComObj,
  A073UAcquistoBuoniMW, System.StrUtils, System.Math;

type
  TA073FImportazioneAcquistiExcel = class(TForm)
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    pnlButtons: TPanel;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    btnAnomalie: TBitBtn;
    btnVisualizzaFile: TBitBtn;
    dsrMappaturaExcel: TDataSource;
    StatusBar1: TStatusBar;
    pnlImpostazioni: TPanel;
    rgpTipoImportazione: TRadioGroup;
    pnlFileExcel: TPanel;
    lblFileExcel: TLabel;
    Panel3: TPanel;
    edtFile: TEdit;
    btnFile: TBitBtn;
    chkRigaIntestazione: TCheckBox;
    grpMappaturaColonne: TGroupBox;
    dgrdMappaturaExcel: TDBGrid;
    rgpTipoFile: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
  private
    procedure OnCambiaFile;
    procedure SetFileName(const Value: string);
    procedure LeggiInfoFile;
  public
    { Public declarations }
  end;

var
  A073FImportazioneAcquistiExcel: TA073FImportazioneAcquistiExcel;

implementation

uses
  A073UAcquistoBuoni,
  A073UAcquistoBuoniDtM1,
  A083UMsgElaborazioni;

{$R *.dfm}

procedure TA073FImportazioneAcquistiExcel.FormCreate(Sender: TObject);
begin
  // prepara i dati per l'importazione
  A073FAcquistoBuoniDtM1.A073MW.PreparaImportazione(dsrMappaturaExcel);

  edtFile.Text:=A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName;
  LeggiInfoFile;

  // legge altre opzioni
  chkRigaIntestazione.Checked:=A073FAcquistoBuoniDtM1.A073MW.FOpzioni.RigaIntestazione;
  rgpTipoImportazione.ItemIndex:=IfThen(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.TipoImportazione = TTipoImportazioneRec.Buoni,0,1);
  rgpTipoFile.ItemIndex:=IfThen(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.TipoFile = TTipoFileRec.XLS,0,1);

  // abilitazione pulsanti visualizzazione file
  btnVisualizzaFile.Enabled:=(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName <> '');
  btnEsegui.Enabled:=(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName <> '');
  btnAnomalie.Enabled:=False;
end;

procedure TA073FImportazioneAcquistiExcel.SetFileName(const Value: string);
begin
  if not TFile.Exists(Value) then
    raise Exception.CreateFmt('Il file indicato non è stato trovato!'#13#10'%s',[Value]);

  A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName:=Value;
  if A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName <> edtFile.Text then
    OnCambiaFile;
end;

procedure TA073FImportazioneAcquistiExcel.LeggiInfoFile;
var LNumRighe:Integer;
begin
  Screen.Cursor:=crHourGlass;
  try
    LNumRighe:=A073FAcquistoBuoniDtM1.A073MW.LeggiInfoFile;
    StatusBar1.SimpleText:=Format('Numero righe: %d',[LNumRighe]);
    StatusBar1.Repaint;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA073FImportazioneAcquistiExcel.OnCambiaFile;
begin
  // visualizza il nome file e abilita l'apertura
  edtFile.Text:=A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName;
  btnVisualizzaFile.Enabled:=True;
  btnEsegui.Enabled:=True;

  // salva il nome file sui parametri db
  A073FAcquistoBuoniDtM1.A073MW.C004.PutParametro(A073_OPT_FILENAME,A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName);
  SessioneOracle.Commit;

  LeggiInfoFile;
end;

procedure TA073FImportazioneAcquistiExcel.btnFileClick(Sender: TObject);
begin
  // selezione del file degli acquisti da importare
  OpenDialog1.Title:='Selezione file da importare';
  if edtFile.Text <> '' then
    OpenDialog1.InitialDir:=TPath.GetDirectoryName(edtFile.Text);
  if OpenDialog1.Execute then
    SetFileName(OpenDialog1.FileName);
end;

procedure TA073FImportazioneAcquistiExcel.btnVisualizzaFileClick(Sender: TObject);
begin
  // verifica indicazione del file
  if A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName = '' then
  begin
    R180MessageBox('Non è stato specificato il file degli acquisti!',INFORMA);
    Exit;
  end;

  // verifica esistenza del file
  if not TFile.Exists(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName) then
  begin
    R180MessageBox(Format('Il file degli acquisti indicato è inesistente:%s',[A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName]),ESCLAMA);
    Exit;
  end;

  // apre il documento con il visualizzatore associato
  ShellExecute(0,'open',PChar(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName),nil,nil,SW_SHOWNORMAL);
end;

procedure TA073FImportazioneAcquistiExcel.btnAnomalieClick(Sender: TObject);
// visualizza il log registrato su database
begin
  A073FAcquistoBuoni.frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A073','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  A073FAcquistoBuoni.frmSelAnagrafe.RipristinaC00SelAnagrafe(A073FAcquistoBuoniDtM1.A073MW);
end;

procedure TA073FImportazioneAcquistiExcel.btnChiudiClick(Sender: TObject);
begin
  Close;
end;

procedure TA073FImportazioneAcquistiExcel.btnEseguiClick(Sender: TObject);
var
  LDS: TDataSet;
  LResCtrl: TResCtrl;
begin
  //verifica che l'estensione per il csv sia corretta
  if rgpTipoFile.ItemIndex = 1 then
    if ExtractFileExt(A073FAcquistoBuoniDtM1.A073MW.FOpzioni.FileName) <> '.csv'  then
    begin
      R180MessageBox('L''estensione del file non è coerente con la scelta',ESCLAMA);
      Exit;
    end
    else if not chkRigaIntestazione.Checked then
    begin
      R180MessageBox('Per i file csv è obbligatoria la riga di intestazione',ESCLAMA);
      Exit;
    end;

  // richiede conferma
  if R180MessageBox('Effettuare l''importazione dei dati di acquisto '#13#10 +
                    'contenuti nel file indicato '#13#10 +
                    'e relativi ai dipendenti selezionati?',DOMANDA) = mrNo then
    Exit;

  Screen.Cursor:=crHourGlass;

  try
    // aggiorna le opzioni di importazione
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.RigaIntestazione:=chkRigaIntestazione.Checked;
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.TipoImportazione:=IfThen(rgpTipoImportazione.ItemIndex = 0,TTipoImportazioneRec.Buoni,TTipoImportazioneRec.Ticket);
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.TipoFile:=IfThen(rgpTipoFile.ItemIndex = 0, TTipoFileRec.XLS, TTipoFileRec.CSV);
    LDS:=dgrdMappaturaExcel.DataSource.DataSet;
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.ColMatricola:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_MATRICOLA,'COLONNA')),0);
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.ColCodFiscale:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_CODFISCALE,'COLONNA')),0);
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.ColDataAcquisto:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_DATA_ACQUISTO,'COLONNA')),0);
    A073FAcquistoBuoniDtM1.A073MW.FOpzioni.ColQuantita:=StrToIntDef(VarToStr(LDS.Lookup('DATO',EXCEL_DATO_QUANTITA,'COLONNA')),0);

    // verifica impostazioni
    LResCtrl:=A073FAcquistoBuoniDtM1.A073MW.VerificaOpzioniImportazione;
    if not LResCtrl.Ok then
    begin
      R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
      Exit;
    end;

    // esegue importazione
    try
      A073FAcquistoBuoniDtM1.A073MW.EseguiImportazione;

      // verifica risultato elaborazione
      btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB);
      if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      begin
        if R180MessageBox('Elaborazione terminata con anomalie.'#13#10'Si desidera visualizzarle?',DOMANDA) = mrYes then
          btnAnomalieClick(nil);
      end
      else
      begin
        R180MessageBox('Elaborazione terminata', INFORMA);
      end;
    except
      on E: Exception do
      begin
        R180MessageBox(Format('Elaborazione fallita: %s (%s)',[E.Message,E.ClassName]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

end.
