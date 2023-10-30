unit W017UStampaCedolino;

interface

uses
  W017UStampaCedolinoDM, System.IOUtils,
  DBClient, Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompEdit, IWCompButton, IWCompCheckbox, StrUtils,
  DB, Oracle, OracleData, Graphics, IWBaseControl, Variants,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  A000UInterfaccia, A000USessione, A000UMessaggi, A000UCostanti,
  R010UPaginaWeb, R012UWebAnagrafico, WC012UVisualizzaFileFM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, RegistrazioneLog,
  IWVCLBaseContainer, IWContainer, Forms, IWVCLComponent, IWDBGrids,
  ActnList, IWCompGrids, IWCompExtCtrls,
  meIWLabel, meIWLink, meIWCheckBox, meIWButton, meIWEdit,
  W000UMessaggi, medpIWDBGrid, meIWImageFile, meIWGrid;

type
  //***.ini
  {
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TCambi = record
    Valuta1:string;
    Valuta2:string;
    Cambio:real;
  end;
  }
  //***.fine

  TW017FStampaCedolino = class(TR012FWebAnagrafico)
    lblDataCedolinoDal: TmeIWLabel;
    edtDataCedolinoDal: TmeIWEdit;
    chkCumuloVociArretrate: TmeIWCheckBox;
    chkStampaOrigine: TmeIWCheckBox;
    cdsRiepilogo: TClientDataSet;
    cdsDettaglio: TClientDataSet;
    cdsNote: TClientDataSet;
    btnDataCedolino: TmeIWButton;
    edtDataCedolinoAl: TmeIWEdit;
    lblDataCedolinoAl: TmeIWLabel;
    lblOpzioni: TmeIWLabel;
    dgrdCedolini: TmedpIWDBGrid;
    cdsP441: TClientDataSet;
    dsrP441: TDataSource;
    procedure btnDataCedolinoClick(Sender: TObject);
    procedure StampaCedolino;
    procedure dgrdCedoliniAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure imgStampaClick(Sender: TObject);
    procedure dgrdCedoliniRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    IdCedolino: Integer;
    W017DM: TW017FStampaCedolinoDM; //***
    procedure Dipendente(P:Integer);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure VerificaRicezionePdf;
    procedure ImpostaDataConsegna;
    procedure AggiornaDati;
  protected
    procedure OnCambiaProgressivo; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, IWGlobal, SyncObjs;

function TW017FStampaCedolino.InizializzaAccesso:Boolean;
begin
  Result:=True;
  lnkDipendente.Caption:='';

  //***.ini
  // crea il datamodule del cedolino
  W017DM:=TW017FStampaCedolinoDM.Create(nil);
  W017DM.selAnagrafeW:=selAnagrafeW;
  W017DM.W017CSStampa:=CSStampa;
  W017DM.RaveProjectPath:=TPath.Combine(gSC.ContentPath,'report');
  { DONE : TEST IW 14 OK }
  //W017DM.TempPDFPath:=gSC.UserCacheDir;
  W017DM.TempPDFPath:=GGetWebApplicationThreadVar.UserCacheDir;  
  //***.fine

  // imposta grid cedolini
  dgrdCedolini.medpRighePagina:=GetRighePaginaTabella;
  //***.ini
  //dgrdCedolini.medpDataSet:=WR000DM.selP441;
  dgrdCedolini.medpDataSet:=W017DM.selP441;

  {
  with WR000DM do
    selP500.Tag:=selP500.Tag + 1;
  }
  //***.fine

  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.P430RETRIB_MESE_PREC,V430.T430AZIENDA_BASE';

  //***.ini
  // linea di codice protetta da errori
  try
  //***.fine
    GetDipendentiDisponibili(R180FineMese(Parametri.DataLavoro)); //Apro il selAnagrafeW
  except
    on E: Exception do
    begin
      Result:=False;
      Log('Errore',Format('GetDipendentiDisponibili: apertura dataset anagrafico non riuscita:'#13#10'%s',[E.Message]));
      MsgBox.MessageBox(Format('%s'#13#10'Si è verificato un errore durante l''estrazione dei dati dei dipendenti:'#13#10'%s',[Self.Title,E.Message]),ESCLAMA);
      Exit;
    end;
  end;

  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  cmbDipendentiDisponibili.ItemIndex:=R180IndexOf(cmbDipendentiDisponibili.Items,selAnagrafeW.FieldByName('MATRICOLA').AsString,8);
  btnDataCedolinoClick(nil);
  OnCambiaProgressivo;

  // determina data dell'ultimo cedolino chiuso
  with WR000DM.selSQL do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select max(DATA_CEDOLINO) DATA_CEDOLINO from P441_CEDOLINO where CHIUSO = ''S'' and PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
    Open;
    if not FieldByName('DATA_CEDOLINO').IsNull then
    begin
      edtDataCedolinoDal.Text:=FormatDateTime('mm/yyyy',FieldByName('DATA_CEDOLINO').AsDateTime);
      edtDataCedolinoAl.Text:=FormatDateTime('mm/yyyy',FieldByName('DATA_CEDOLINO').AsDateTime);
    end
    else
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W017_MSG_NO_CEDOLINO_DISP),ESCLAMA);
      Exit;
    end;
    //***.ini
    {
    QueryCambio:=TQueryCambio.Create(nil);
    QueryCambio.Session:=SessioneOracle;
    }
    //***.fine
    btnDataCedolinoClick(nil);
    Close;
  end;

  // gestione sola lettura / cedolini pdf già esistenti
  if SolaLettura or (Parametri.WEBCedoliniFilePDF = 'S') then
  begin
    JavascriptBottom.Add('document.getElementById("grbOpzioni").className = "invisibile";');
    lblOpzioni.Visible:=False;
    chkCumuloVociArretrate.Visible:=False;
    chkStampaOrigine.Visible:=False;
  end;
end;

procedure TW017FStampaCedolino.DistruggiOggetti;
begin
  //***.ini
  {
  try FreeAndNil(QueryCambio); except end;

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try R180CloseDataSetTag0(WR000DM.selP500); except end;
  end;
  }
  try FreeAndNil(W017DM); except end;
  //***.fine
end;

procedure TW017FStampaCedolino.OnCambiaProgressivo;
var M:String;
begin
  M:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',M,[srFromBeginning]) then
    ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger
  else
    ParametriForm.Progressivo:=0;
  Dipendente(ParametriForm.Progressivo);
  btnDataCedolinoClick(nil);
end;

procedure TW017FStampaCedolino.Dipendente(P:Integer);
begin
  inherited;
  lnkDipendente.Caption:='';
  if not selAnagrafeW.SearchRecord('PROGRESSIVO',P,[srFromBeginning]) then
    selAnagrafeW.First;
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  VisualizzaDipendenteCorrente;
end;

procedure TW017FStampaCedolino.VisualizzaDipendenteCorrente;
begin
  inherited;

  dgrdCedolini.medpBrowse:=True;
  dgrdCedolini.medpStato:=msBrowse;
  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  dgrdCedolini.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  dgrdCedolini.medpEliminaColonne;
  dgrdCedolini.medpAggiungiColonna('DBG_COMANDI','','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_CEDOLINO','Data cedolino','',nil);
  dgrdCedolini.medpAggiungiColonna('TIPO_CEDOLINO','Tipo cedolino','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_RETRIBUZIONE','Data retribuzione','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_EMISSIONE','Data emissione','',nil);
  dgrdCedolini.medpAggiungiColonna('DATA_CONSEGNA','Data consegna','',nil);
  dgrdCedolini.medpAggiungiColonna('ID_CEDOLINO','Id cedolino','',nil);

  dgrdCedolini.medpColonna('TIPO_CEDOLINO').Visible:=Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S';
  dgrdCedolini.medpColonna('DATA_CONSEGNA').Visible:=False;
  dgrdCedolini.medpColonna('ID_CEDOLINO').Visible:=False;

  dgrdCedolini.medpAggiungiRowClick('ID_CEDOLINO',DBGridColumnClick);
  dgrdCedolini.medpInizializzaCompGriglia;
  dgrdCedolini.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','STAMPA','Stampa','','');
  dgrdCedolini.medpCaricaCDS;
end;

procedure TW017FStampaCedolino.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  if (ASender is TmeIWImageFile) then
    IdCedolino:=cdsP441.Lookup('DBG_ROWID',AValue,'ID_CEDOLINO')
  else
    IdCedolino:=StrToIntDef(AValue,0);
  //Mi posiziono sull'anno giusto nella griglia
  cdsP441.Locate('ID_CEDOLINO',IntToStr(IdCedolino),[]);

  //***.ini
  //WR000DM.selP441.Locate('ID_CEDOLINO',IntToStr(IdCedolino),[]);
  W017DM.selP441.Locate('ID_CEDOLINO',IntToStr(IdCedolino),[]);
  //***.fine
end;

procedure TW017FStampaCedolino.StampaCedolino;
var
  LNomeFilePdf: String;
  LRisultatoStampa: String;
  LMsg: String;
  LAzioneCedolino: TAzioneCedolino;
begin
  // determina il nome del file del cedolino da generare
  // (nel caso in cui Parametri.WEBCedoliniFilePDF <> 'S')
  LNomeFilePdf:=GetNomeFile('pdf');

  try
    W017DM.GeneraCedolinoPDF(selAnagrafeW.FieldByName('MATRICOLA').AsString,
                             chkCumuloVociArretrate.Checked,
                             chkStampaOrigine.Checked,
                             LNomeFilePdf,
                             LAzioneCedolino,
                             LRisultatoStampa);

    // verifica necessità di azioni utente
    LMsg:=A000TraduzioneStringhe(A000MSG_W017_MSG_ANTEPRIMA_CEDOLINO);
    case LAzioneCedolino of
      acNessuna:
        VisualizzaFile(LNomeFilePdf,LMsg,nil,nil);
      acImpostaConsegna:
        VisualizzaFile(LNomeFilePdf,LMsg,AggiornaDati,nil);
      acRichiediImpostazioneConsegna:
        VisualizzaFile(LNomeFilePdf,LMsg,nil,VerificaRicezionePdf);
    end;
    if W017DM.selP441.SearchRecord('ID_CEDOLINO',IdCedolino,[srFromBeginning]) and (Trim(W017DM.selP441.FieldByName('NOME_FILEPDF').AsString) <> '') then
    begin
      LNomeFilePdf:=W017DM.selP441.FieldByName('NOME_FILEPDF').AsString;
      LMsg:=IfThen(W017DM.selP441.FieldByName('DESCRIZIONE_FILEPDF').AsString <> '', W017DM.selP441.FieldByName('DESCRIZIONE_FILEPDF').AsString, W017DM.selP441.FieldByName('NOME_FILEPDF').AsString);
      VisualizzaFile(LNomeFilePdf,LMsg,nil,nil,fdGlobal);
    end;
  except
    on E: Exception do
    begin
      LRisultatoStampa:=Format('Errore durante la stampa del cedolino:'#13#10'%s',[E.Message]);
      Log('Errore','StampaCedolino',E);
    end;
  end;

  if LRisultatoStampa <> '' then
  begin
    MsgBox.MessageBox(LRisultatoStampa,ESCLAMA);
    Exit;
  end;
end;

procedure TW017FStampaCedolino.VerificaRicezionePdf;
var Msg:String;
begin
  Msg:=Format(A000TraduzioneStringhe(A000MSG_W017_FMT_RICEZIONE_CEDOLINO),
       [W017DM.selP441.FieldByName('TIPO_CEDOLINO').AsString,W017DM.selP441.FieldByName('DATA_RETRIBUZIONE').AsString]);
  if W017DM.selP441.SearchRecord('ID_CEDOLINO',IdCedolino,[srFromBeginning]) and (Trim(W017DM.selP441.FieldByName('NOME_FILEPDF').AsString) <> '') and
    (Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S') then //TORINO_ITC
  begin
    Msg:=StringReplace(Msg,'?',' e del relativo allegato',[rfReplaceAll]);
    if Trim(W017DM.selP441.FieldByName('DESCRIZIONE_FILEPDF').AsString) <> '' then
      Msg:=Msg + ' "' + W017DM.selP441.FieldByName('DESCRIZIONE_FILEPDF').AsString + '"';
    Msg:=Msg + '?';
  end;
  Messaggio(A000TraduzioneStringhe(A000MSG_MSG_CONFERMA),Msg,ImpostaDataConsegna,nil);
end;

//***.ini
procedure TW017FStampaCedolino.ImpostaDataConsegna;
begin
  W017DM.ImpostaDataConsegna(IdCedolino);
  AggiornaDati;
end;

procedure TW017FStampaCedolino.AggiornaDati;
begin
  btnDataCedolinoClick(nil);
  W017DM.selP441.SearchRecord('ID_CEDOLINO',IdCedolino,[srFromBeginning]);
end;
//***.fine

procedure TW017FStampaCedolino.btnDataCedolinoClick(Sender: TObject);
var
  Mat,sErrMsg:String;
  CurrentProg: Integer;
  LData1, LData2: TDateTime;
begin
  inherited;
  if cmbDipendentiDisponibili.ItemIndex = -1 then
    exit;

  //***.ini
  // determina date di riferimento per i cedolini
  // il metodo seguente evita di sollevare eccezioni
  LData1:=Parametri.DataLavoro;
  if edtDataCedolinoDal.Text <> '' then
  begin
    if TryStrToDate(Format('01/%s',[edtDataCedolinoDal.Text]),LData1) then
      LData1:=R180FineMese(LData1);
  end;
  LData2:=Parametri.DataLavoro;
  if edtDataCedolinoAl.Text <> '' then
  begin
    if TryStrToDate(Format('01/%s',[edtDataCedolinoAl.Text]),LData2) then
      LData2:=R180FineMese(LData2);
  end;
  //***.fine

  if Sender <> nil then
  begin
    if not R180ControllaPeriodo(LData1,LData2,sErrMsg) then
    begin
      MsgBox.MessageBox(A000TraduzioneStringhe(sErrMsg),INFORMA);
      Exit;
    end;
    if LData1 < Parametri.WEBCedoliniDataMin then
    begin
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W017_FMT_STOP_CED_PRIMA_DEL),[DateToStr(Parametri.WEBCedoliniDataMin)]),INFORMA);
      Exit;
    end;
    if (Parametri.WEBCedoliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(LData1),Parametri.WEBCedoliniMMPrec) < R180InizioMese(Date)) then
    begin
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W017_FMT_STOP_CED_PRIMA_MESI),[Parametri.WEBCedoliniMMPrec]),INFORMA);
      Exit;
    end;
  end;

  //***with WR000DM do
  //begin
  W017DM.selP441.Close;
    W017DM.selP441.ClearVariables; //***
    // 12.2.6
    //Mat:=Trim(Copy(StringReplace(cmbDipendentiDisponibili.Text,SPAZIO,' ',[rfReplaceAll]),1,8));
  Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
  if selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
    W017DM.selP441.SetVariable('PROGRESSIVO',selAnagrafeW.Lookup('MATRICOLA',Mat,'PROGRESSIVO'))
  else
    W017DM.selP441.SetVariable('PROGRESSIVO',0);
    //***.ini
    // utilizza metodo per evitare di sollevare eccezioni
    {
    try
      W017DM.selP441.SetVariable('DATA_CEDOLINO1',R180FineMese(StrToDate('01/' + edtDataCedolinoDal.Text)));
    except
      W017DM.selP441.SetVariable('DATA_CEDOLINO1',R180FineMese(Parametri.DataLavoro));
    end;
    try
      W017DM.selP441.SetVariable('DATA_CEDOLINO2',R180FineMese(StrToDate('01/' + edtDataCedolinoAl.Text)));
    except
      W017DM.selP441.SetVariable('DATA_CEDOLINO2',R180FineMese(Parametri.DataLavoro));
    end;
    }
  W017DM.selP441.SetVariable('DATA_CEDOLINO1',LData1);
  W017DM.selP441.SetVariable('DATA_CEDOLINO2',LData2);
    //***.fine
  W017DM.selP441.SetVariable('WEB_CEDOLINI_GGEMISS',Parametri.WEBCedoliniGGEmiss);
  W017DM.selP441.SetVariable('WEB_CEDOLINI_DATAMIN',Parametri.WEBCedoliniDataMin);
  W017DM.selP441.SetVariable('WEB_CEDOLINI_MMPREC',Parametri.WEBCedoliniMMPrec);
  W017DM.selP441.Open;
  W017DM.selP441.Filtered:=Parametri.WEBCedoliniFilePDF = 'S';
  if selAnagrafeW.RecordCount > 0 then
    CurrentProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  Dipendente(CurrentProg);
  //end;
end;

procedure TW017FStampaCedolino.dgrdCedoliniAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  LIWImg: TmeIWImageFile;
begin
  inherited;
  //Righe dati
  for i:=0 to High(dgrdCedolini.medpCompGriglia) do
  begin
    DBGridColumnClick(nil,dgrdCedolini.medpValoreColonna(i,'ID_CEDOLINO'));
    // Associo l'evento OnClick all'icona di stampa
    if dgrdCedolini.medpCompGriglia[i].CompColonne[0] <> nil then
    begin
      LIWImg:=(dgrdCedolini.medpCompCella(i,0,0) as TmeIWImageFile);
      LIWImg.OnClick:=imgStampaClick;
      LIWImg.Hint:=Format('Stampa cedolino di %s (%s)',
                          [W017DM.selP441.FieldByName('DATA_CEDOLINO').AsString,
                           W017DM.selP441.FieldByName('TIPO_CEDOLINO').AsString]);
      // lo screen reader JAWS necessita dell'attributo alt valorizzato
      LIWImg.AltText:=LIWImg.Hint;
    end;
  end;
end;

procedure TW017FStampaCedolino.dgrdCedoliniRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna:Integer;
begin
  inherited;
  NumColonna:=dgrdCedolini.medpNumColonna(AColumn);
  if not dgrdCedolini.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow > 0)
  and (dgrdCedolini.medpNumColonna(AColumn) <> dgrdCedolini.medpIndexColonna('DBG_COMANDI')) then
    ACell.Css:=ACell.Css + ' align_center';
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(dgrdCedolini.medpCompGriglia) + 1) and (dgrdCedolini.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdCedolini.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW017FStampaCedolino.imgStampaClick(Sender: TObject);
begin
  //inherited;
  if not (Sender is TmeIWImageFile) then
    Exit;
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  StampaCedolino;
end;

procedure TW017FStampaCedolino.RefreshPage;
begin
  //***with WR000DM do
  //begin
    W017DM.selP500.Close;
    W017DM.selP500.SetVariable('Anno',0);
    W017DM.selP500.Open;
  //end;
end;
end.