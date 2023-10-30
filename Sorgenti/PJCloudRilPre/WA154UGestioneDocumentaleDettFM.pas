unit WA154UGestioneDocumentaleDettFM;

interface

uses
  A000UCostanti,
  System.SysUtils, System.Variants, System.Classes, System.IOUtils,
  WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompMemo, meIWDBMemo, IWCompListbox,
  meIWDBLookupComboBox, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  IWHTMLControls, meIWLink, System.Actions, Vcl.ActnList,
  C021UDocumentiManagerDM, medpIWMessageDlg, Vcl.Controls, Vcl.Forms,
  A000UInterfaccia, A000USessione, A000UMessaggi, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, IWApplication, IWGlobal, WC015USelEditGridFM,
  Oracle, OracleData, IWCompButton, meIWButton,
  System.StrUtils, Data.DB, IWCompCheckbox, meIWDBCheckBox, IWCompFileUploader,
  meIWFileUploader, IWDBExtCtrls, meIWDBRadioGroup, meIWDBComboBox, meIWComboBox, medpIWMultiColumnComboBox;

type
  TWA154FGestioneDocumentaleDettFM = class(TWR205FDettTabellaFM)
    lblID: TmeIWLabel;
    dedtID: TmeIWDBEdit;
    lblProprietario: TmeIWLabel;
    dedtDProprietario: TmeIWDBEdit;
    dedtDNomeFile: TmeIWDBEdit;
    lblNomeFile: TmeIWLabel;
    lblPeriodoDal: TmeIWLabel;
    dedtPeriodoDal: TmeIWDBEdit;
    dedtPeriodoAl: TmeIWDBEdit;
    lblPeriodoAl: TmeIWLabel;
    dedtDataCreazione: TmeIWDBEdit;
    lblDataCreazione: TmeIWLabel;
    lblDimensione: TmeIWLabel;
    dedtDDimensione: TmeIWDBEdit;
    lblNote: TmeIWLabel;
    dmemNote: TmeIWDBMemo;
    dcmbTipologia: TmeIWDBLookupComboBox;
    dcmbUfficio: TmeIWDBLookupComboBox;
    btnFileVisualizza: TmedpIWImageButton;
    lnkTipologia: TmeIWLink;
    lnkUfficio: TmeIWLink;
    ActionList2: TActionList;
    actFileVisualizza: TAction;
    actFileDownload: TAction;
    actAccediTabella: TAction;
    dchkAccessoResponsabile: TmeIWDBCheckBox;
    actResetDatiLettura: TAction;
    btnResetDatiLettura: TmedpIWImageButton;
    dedtDDatiAccesso: TmeIWDBEdit;
    lblDatiAccesso: TmeIWLabel;
    lblDataLetturaProgressivo: TmeIWLabel;
    dedtDataLetturaProgressivo: TmeIWDBEdit;
    dChkAutocertificazione: TmeIWDBCheckBox;
    dchkRichiedereEnte: TmeIWDBCheckBox;
    dEdtDataRichiestaEnte: TmeIWDBEdit;
    dEdtDataRicezioneEnte: TmeIWDBEdit;
    lblDataRichiestaEnte: TmeIWLabel;
    lblDataRicezioneEnte: TmeIWLabel;
    IWFile: TmeIWFileUploader;
    dchkAccessoPortale: TmeIWDBCheckBox;
    drgpPathStorage: TmeIWDBRadioGroup;
    lblPathStorage: TmeIWLabel;
    lblDataRilascio: TmeIWLabel;
    dEdtDataRilascio: TmeIWDBEdit;
    lblFamiliare: TmeIWLabel;
    lbld_Familiare: TmeIWLabel;
    dedtFamiliare: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lnkTipologiaClick(Sender: TObject);
    procedure lnkUfficioClick(Sender: TObject);
    procedure actFileDownloadExecute(Sender: TObject);
    procedure btnFileVisualizzaClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure actResetDatiLetturaExecute(Sender: TObject);
    procedure dChkAutocertificazioneClick(Sender: TObject);
    procedure dedtFamiliareAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    C021DM: TC021FDocumentiManagerDM;
    IterMaxDimAllegatoMB: Integer;
    procedure WC015TipologiaEvent(Sender: TObject; Result: Boolean);
    procedure WC015UfficioEvent(Sender: TObject; Result: Boolean);
  public
    procedure DataSet2Componenti; override;
    procedure ReleaseOggetti; override;
    procedure EffettuaUpload;
    procedure GestioneAfterScroll;
    procedure DecodeCFFamiliari(CF:String);
  end;

implementation

uses WR100UBase, WA154UGestioneDocumentale, WA154UGestioneDocumentaleDM;

{$R *.dfm}

procedure TWA154FGestioneDocumentaleDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // impostazione campi
  dedtID.ReadOnly:=True;
  dedtDataCreazione.ReadOnly:=True;
  dedtDProprietario.ReadOnly:=True;
  dedtDNomeFile.ReadOnly:=True;
  dedtDDimensione.ReadOnly:=True;
  dedtDataLetturaProgressivo.ReadOnly:=True;
  dedtdDatiAccesso.ReadOnly:=True;
  //Gestione visibilita caricamento allegato
  lblNomeFile.Css:=C190ImpostaCssNascosto(lblNomeFile.Css,(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale);
  dedtDNomeFile.Css:=C190ImpostaCssNascosto(dedtDNomeFile.Css,(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale);
  lblDimensione.Css:=C190ImpostaCssNascosto(lblDimensione.Css,(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale);
  dedtDDimensione.Css:=C190ImpostaCssNascosto(dedtDDimensione.Css,(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale);
  btnFileVisualizza.Css:=C190ImpostaCssNascosto(btnFileVisualizza.Css,(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale);
  btnResetDatiLettura.Css:=C190ImpostaCssNascosto(btnResetDatiLettura.Css,(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale);

  // abilitazione pulsanti
  IWFile.Visible:=False;
  btnFileVisualizza.Enabled:=False;
  btnResetDatiLettura.Enabled:=(not TWR100FBase(Owner).SolaLettura);

  // combobox
  dcmbTipologia.ListSource:=(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.dsrT962Lookup;
  dcmbUfficio.ListSource:=(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.dsrT963Lookup;

  // scorciatoia per datamodulo di servizio per allegati
  C021DM:=(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.C021DM;

  // dimensione max allegati
  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);
  IWFile.MEdpMaxFileSize:=IterMaxDimAllegatoMB * BYTES_MB;
end;

procedure TWA154FGestioneDocumentaleDettFM.DecodeCFFamiliari(CF:String);
begin
  with (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selSG101 do
    lblD_Familiare.Caption:=VarToStr(Lookup('CODFISCALE',CF,'DENOMINAZIONE'));
end;

procedure TWA154FGestioneDocumentaleDettFM.DataSet2Componenti;
begin
  inherited;
  C190VisualizzaElemento(JQuery,'grpBoxAutoCertificazioni',(WR302DM as TWA154FGestioneDocumentaleDM).selTabella.FieldByName('AUTOCERTIFICAZIONE').AsString = 'S');
end;

procedure TWA154FGestioneDocumentaleDettFM.IWFrameRegionRender(Sender: TObject);
  function GetCss(PComp: TmeIWDBEdit): String;
  const
    CSS_READONLY = 'readonly_like_disabled';
  begin
    Result:=PComp.Css.Replace(CSS_READONLY,'',[]).Trim +
            IfThen(PComp.ReadOnly,' ' + CSS_READONLY);
  end;
begin
  inherited;
  dedtID.Css:=GetCss(dedtID);
  dedtDataCreazione.Css:=GetCss(dedtDataCreazione);
  dedtDProprietario.Css:=GetCss(dedtDProprietario);
  dedtDNomeFile.Css:=GetCss(dedtDNomeFile);
  dedtDDimensione.Css:=GetCss(dedtDDimensione);
  dedtDataLetturaProgressivo.Css:=GetCss(dedtDataLetturaProgressivo);
  dedtDDatiAccesso.Css:=GetCss(dedtDDatiAccesso);

  // dati periodo
  dedtPeriodoDal.Css:=GetCss(dedtPeriodoDal);
  dedtPeriodoAl.Css:=GetCss(dedtPeriodoAl);
end;

procedure TWA154FGestioneDocumentaleDettFM.ReleaseOggetti;
begin
  //
end;

procedure TWA154FGestioneDocumentaleDettFM.actFileDownloadExecute(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta dal tag del componente
  LId:=WR302DM.selTabella.FieldByName('ID').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  A000SessioneWEB.AnnullaTimeOut;
  try
    // estrae il file con i metadati associati
    try
      LResCtrl:=C021DM.GetById(LId,True,LDoc);
      if not LResCtrl.Ok then
      begin
        MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // invia il file al browser
      GGetWebApplicationThreadVar.SendFile(LDoc.FilePath,True,'application/x-download',LDoc.GetNomeFileCompleto);
    except
      on E: Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(Format('Errore durante il download del documento:'#13#10'%s',[E.Message]));
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWA154FGestioneDocumentaleDettFM.actResetDatiLetturaExecute(Sender: TObject);
var
  LId: Integer;
  LOldRowId: String;
begin
  // verifica dataset attivo
  if not WR302DM.selTabella.Active then
    Exit;

  // verifica presenza di almeno un record
  if WR302DM.selTabella.RecordCount = 0 then
    Exit;

  // verifica che il dataset sia in browse
  if WR302DM.selTabella.State <> dsBrowse then
    Exit;

  // annulla i dati di lettura (data_accesso e utente_accesso)
  LId:=WR302DM.selTabella.FieldByName('ID').AsInteger;
  LOldRowId:=WR302DM.selTabella.RowId;
  C021DM.ResetDatiAccesso(LId);

  // refresh dataset
  WR302DM.selTabella.Refresh;
  WR302DM.selTabella.SearchRecord('ID',LId,[srFromBeginning]);
  (Self.Owner as TWA154FGestioneDocumentale).WBrowseFM.grdTabella.medpCaricaCDS(LOldRowId);
end;

procedure TWA154FGestioneDocumentaleDettFM.EffettuaUpload;
var
  Att,LFileName,LNomeFile,LExtFile: String;
  LDimensioneByte: Int64;
begin
  { DONE : TEST IW 14 OK }
  // verifica indicazione file
  if not IWFile.IsPresenteFileUploadato then
  begin
    // messaggio di errore fornito su beforepost
    //GGetWebApplicationThreadVar.ShowMessage('Selezionare un file da allegare al messaggio!');
    Exit;
  end;

  // determina il nome dell'allegato
  Att:=IWFile.NomeFile;

  try
    // path e nome per il salvataggio su file system
    LFileName:=GGetWebApplicationThreadVar.UserCacheDir + Att;

    // se esiste già un file con lo stesso nome lo cancella
    if TFile.Exists(LFileName) then
      TFile.Delete(LFileName);

    // effettua upload
    IWFile.SalvaSuFile(LFileName);
    IWFile.Ripristina;

    // determina cartella file
    WR302DM.selTabella.FieldByName('D_CARTELLA_FILE').AsString:=TPath.GetDirectoryName(LFileName);
    // determina nome + estensione
    LNomeFile:=TPath.GetFileNameWithoutExtension(LFileName);
    LExtFile:=TPath.GetExtension(LFileName).Replace(TPath.ExtensionSeparatorChar,'');
    WR302DM.selTabella.FieldByName('NOME_FILE').AsString:=LNomeFile;
    WR302DM.selTabella.FieldByName('EXT_FILE').AsString:=LExtFile;

    // dimensione
    LDimensioneByte:=R180GetFileSize(LFileName);
    WR302DM.selTabella.FieldByName('DIMENSIONE').AsFloat:=LDimensioneByte;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,ERRORE,'Errore upload');
    end;
  end;
end;

procedure TWA154FGestioneDocumentaleDettFM.btnFileVisualizzaClick(Sender: TObject);
begin
  actFileDownloadExecute(btnFileVisualizza);
end;

procedure TWA154FGestioneDocumentaleDettFM.dChkAutocertificazioneClick(
  Sender: TObject);
begin
  inherited;
  C190VisualizzaElemento(JQuery,'grpBoxAutoCertificazioni',dChkAutocertificazione.Checked);
end;

procedure TWA154FGestioneDocumentaleDettFM.dedtFamiliareAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  DecodeCFFamiliari(dedtFamiliare.Text);
end;

procedure TWA154FGestioneDocumentaleDettFM.GestioneAfterScroll;
var LEsisteFile:Boolean;
begin
  LEsisteFile:=WR302DM.selTabella.FieldByName('NOME_FILE').AsString <> '';
  btnFileVisualizza.Enabled:=LEsisteFile and (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.ModuloGestioneDocumentale;
  dchkAccessoPortale.Enabled:=(WR302DM.selTabella.FieldByName('UTENTE').AsString <> '');

  DecodeCFFamiliari(WR302DM.selTabella.FieldByName('CF_FAMILIARE').AsString);

  btnResetDatiLettura.Enabled:=(not TWR100FBase(Owner).SolaLettura) and
                               (WR302DM.selTabella.State = dsBrowse) and
                               (not WR302DM.selTabella.FieldByName('UTENTE_ACCESSO').IsNull);
end;

procedure TWA154FGestioneDocumentaleDettFM.lnkTipologiaClick(Sender: TObject);
// apre gestione tipologie - T962
var
  WC015: TWC015FSelEditGridFM;
  LDataset: TOracleDataSet;
begin
  LDataset:=(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT962;

  // apre frame WC015
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  WC015.medpCurrRecord:=LDataset.SearchRecord('CODICE',VarArrayOf([WR302DM.selTabella.FieldByName('TIPOLOGIA').AsString]),[srFromBeginning]);
  WC015.ResultEvent:=WC015TipologiaEvent;
  WC015.Visualizza('Tipologie documenti',LDataset,True,True,False);
end;

procedure TWA154FGestioneDocumentaleDettFM.WC015TipologiaEvent(Sender: TObject; Result: Boolean);
begin
  // refresh dataset di lookup tipologie
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT962Lookup.Close;
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT962Lookup.Open;
end;

procedure TWA154FGestioneDocumentaleDettFM.lnkUfficioClick(Sender: TObject);
// apre gestione uffici - T963
var
  WC015: TWC015FSelEditGridFM;
  LDataset: TOracleDataSet;
begin
  LDataset:=(WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT963;

  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  WC015.medpCurrRecord:=LDataset.SearchRecord('CODICE',VarArrayOf([WR302DM.selTabella.FieldByName('UFFICIO').AsString]),[srFromBeginning]);
  WC015.ResultEvent:=WC015UfficioEvent;
  WC015.Visualizza('Uffici',LDataset,True,True,False);
end;

procedure TWA154FGestioneDocumentaleDettFM.WC015UfficioEvent(Sender: TObject; Result: Boolean);
begin
  // refresh dataset di lookup tipologie
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT963Lookup.Close;
  (WR302DM as TWA154FGestioneDocumentaleDM).A154MW.selT963Lookup.Open;
end;

end.
