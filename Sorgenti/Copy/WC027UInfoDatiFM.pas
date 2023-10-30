unit WC027UInfoDatiFM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A087UImpAttestatiMalMW,
  A093UOperazioniMW,
  C018UIterAutDM,
  C021UDocumentiManagerDM,
  C180FunzioniGenerali,
  FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  WR010UBase,
  System.DateUtils,
  meIWImageFile, IWCompButton, meIWButton,
  System.StrUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompMemo, meIWMemo,
  IWDBGrids, medpIWDBGrid, IWCompLabel, meIWLabel, meIWRegion, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, meIWGrid,
  medpIWTabControl, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Vcl.Menus, Data.DB, Datasnap.DBClient, IWCompFileUploader, meIWFileUploader, IWCompExtCtrls, medpIWImageButton, medpIWMessageDlg;

type
  TWC027FInfoDatiFM = class(TWR200FBaseFM)
    grdTabDetail: TmedpIWTabControl;
    WC027InfoRichiestaRG: TmeIWRegion;
    lblIDRichiesta: TmeIWLabel;
    lblDataRichiesta: TmeIWLabel;
    lblCodiceIter: TmeIWLabel;
    lblRichiedente: TmeIWLabel;
    lblNoteRichiedente: TmeIWLabel;
    lblInformazioniDellaRichiesta: TmeIWLabel;
    lblIDRichiestaValue: TmeIWLabel;
    lblDataRichiestaValue: TmeIWLabel;
    lblCodiceIterValue: TmeIWLabel;
    lblRichiedenteValue: TmeIWLabel;
    lblInfoAutorizzatore: TmeIWLabel;
    lblInfoRevoca: TmeIWLabel;
    lblIDRevoca: TmeIWLabel;
    lblDataRevoca: TmeIWLabel;
    lblNoteRevoca: TmeIWLabel;
    lblIDRevocaValue: TmeIWLabel;
    grdDocumenti: TmedpIWDBGrid;
    mmNoteRichiedenteValue: TmeIWMemo;
    mmNoteRevocaValue: TmeIWMemo;
    lblDatarevocaValue: TmeIWLabel;
    lblElencoAllegati: TmeIWLabel;
    WC027InfoCertINPSRG: TmeIWRegion;
    WC027InfoLogRG: TmeIWRegion;
    cdsT048: TClientDataSet;
    grdCertINPS: TmedpIWDBGrid;
    grdLogOperazioni: TmedpIWDBGrid;
    tpcInfoRichiestaRG: TIWTemplateProcessorHTML;
    tpcInfoCertINPSRG: TIWTemplateProcessorHTML;
    tpcInfoLogRG: TIWTemplateProcessorHTML;
    btnChiudi: TmeIWButton;
    lblInfoCertINPS: TmeIWLabel;
    lblInfoLog: TmeIWLabel;
    cdsT048DATO: TStringField;
    cdsT048VALORE: TStringField;
    fileUpload: TmeIWFileUploader;
    btnUpload: TmedpIWImageButton;
    grdInfo: TmedpIWDBGrid;
    dsrT851: TDataSource;
    cdsT851: TClientDataSet;
    procedure grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure btnCaricaClick(Sender: TObject);
  private
    iIWFile: Integer;
    FLogCaricato: Boolean;
    FA087MW: TA087FImpAttestatiMalMW;
    FA093MW: TA093FOperazioniMW;
    FEsisteIndiceI000: Boolean;
    FGrpRevocaVisible: Boolean;
    FGrpDocumentiVisible: Boolean;
    FDatiGiust: TGiustificativi;
    FDatiTimb: TTimbrature;
    FC018IterInfo: TC018IterInfo;
    FDataSetIter: TDataSet;
    procedure OnCancellaFile(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure imgCancellaFileExecute(Sender: TObject);
    procedure imgFileDownloadExecute(Sender: TObject);
    procedure CaricaInfoCertificatoINPS(PIdCertificato: String);
    procedure CaricaInfoRichiesta(IDRichiesta:integer);
    procedure CaricaInfoLog;
    procedure MostraFrame(const PTitolo: String);
  public
    SolaLettura: Boolean;
    C018: TC018FIterAutDM;
    procedure ReleaseOggetti; override;
    procedure MostraInfoGiust(PDatiGiust: TGiustificativi);
    procedure MostraInfoTimb(PDatiTimb: TTimbrature);
    procedure MostraInfoRichiesta(PIdRichiesta: Integer); overload;
    procedure MostraInfoRichiesta(PDataSetIter: TDataSet); overload;
  end;

implementation

uses
  IWApplication, meIWLink, Math, Oracle, A000UMessaggi, System.IOUtils;

{$R *.dfm}

procedure TWC027FInfoDatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  SolaLettura:= False;
  FLogCaricato:=False;
  FA093MW:=TA093FOperazioniMW.Create(nil);
  FEsisteIndiceI000:=FA093MW.EsisteIndiceI000;
  FGrpRevocaVisible:=False;
  FGrpDocumentiVisible:=False;
  FDatiGiust.Clear;
  FDatiTimb.Clear;

  grdTabDetail.AggiungiTab('Info richiesta',WC027InfoRichiestaRG);
  grdTabDetail.AggiungiTab('Info certificato INPS',WC027InfoCertINPSRG);
  grdTabDetail.AggiungiTab('Log operazioni',WC027InfoLogRG);
end;

procedure TWC027FInfoDatiFM.ReleaseOggetti;
begin
  if Assigned(C018) and (C018.Owner = self) and (C018.Name = 'WC027') then
    try FreeAndNil(C018); except end;
  if FC018IterInfo <> nil then
    try FreeAndNil(FC018IterInfo); except end;
  try FreeAndNil(FA093MW); except end;
  try FreeAndNil(FA087MW); except end;
end;

procedure TWC027FInfoDatiFM.MostraFrame(const PTitolo: String);
begin
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,590,-1,-1,'<WC027> ' + PTitolo,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
  C190VisualizzaElemento(JQuery,'grpRevoca',FGrpRevocaVisible);
  C190VisualizzaElemento(JQuery,'grpDocumenti',FGrpDocumentiVisible);
end;

procedure TWC027FInfoDatiFM.MostraInfoGiust(PDatiGiust: TGiustificativi);
begin
  FDatiGiust:=PDatiGiust;

  // imposta visibilità dei tab
  grdTabDetail.Tabs[WC027InfoRichiestaRG].Visible:=PDatiGiust.IdRichiesta > 0;
  grdTabDetail.Tabs[WC027InfoCertINPSRG].Visible:=PDatiGiust.IdCertificato <> '';
  grdTabDetail.Tabs[WC027InfoLogRG].Visible:=True;

  if PDatiGiust.IdRichiesta > 0 then
  begin
    CaricaInfoRichiesta(PDatiGiust.IdRichiesta);
    grdTabDetail.ActiveTab:=WC027InfoRichiestaRG;
  end
  else if PDatiGiust.IdCertificato <> '' then
  begin
    CaricaInfoCertificatoINPS(PDatiGiust.IdCertificato);
    grdTabDetail.ActiveTab:=WC027InfoCertINPSRG;
  end
  else
  begin
    CaricaInfoLog;
    grdTabDetail.ActiveTab:=WC027InfoLogRG;
  end;

  MostraFrame('Informazioni giustificativo');
end;

procedure TWC027FInfoDatiFM.MostraInfoRichiesta(PDataSetIter: TDataSet);
begin
  if (not PDataSetIter.Active) or (PDataSetIter.RecordCount = 0) or (PDataSetIter.FieldByName('T850ID').AsInteger = 0) then
  begin
    R180MessageBox('L''identificativo della richiesta non è valido',ESCLAMA);
    Exit;
  end;
  FDataSetIter:=PDataSetIter;

  MostraInfoRichiesta(PDataSetIter.FieldByName('T850ID').AsInteger);
end;

procedure TWC027FInfoDatiFM.MostraInfoRichiesta(PIdRichiesta: Integer);
begin
  if PIdRichiesta = 0 then
  begin
    MsgBox.MessageBox(Format('L''identificativo della richiesta non è valido: %d',[PIdRichiesta]),ESCLAMA);
    Exit;
  end;

  // imposta visibilità dei tab
  grdTabDetail.Tabs[WC027InfoRichiestaRG].Visible:=True;
  grdTabDetail.Tabs[WC027InfoCertINPSRG].Visible:=False;
  grdTabDetail.Tabs[WC027InfoLogRG].Visible:=False;

  CaricaInfoRichiesta(PIdRichiesta);
  grdTabDetail.ActiveTab:=WC027InfoRichiestaRG;

  MostraFrame('Informazioni richiesta');
end;

procedure TWC027FInfoDatiFM.MostraInfoTimb(PDatiTimb: TTimbrature);
begin
  FDatiTimb:=PDatiTimb;

  // imposta visibilità dei tab
  grdTabDetail.Tabs[WC027InfoRichiestaRG].Visible:=PDatiTimb.IdRichiesta > 0;
  grdTabDetail.Tabs[WC027InfoCertINPSRG].Visible:=False;
  grdTabDetail.Tabs[WC027InfoLogRG].Visible:=True;

  if PDatiTimb.IdRichiesta > 0 then
  begin
    CaricaInfoRichiesta(PDatiTimb.IdRichiesta);
    grdTabDetail.ActiveTab:=WC027InfoRichiestaRG;
  end
  else
  begin
    CaricaInfoLog;
    grdTabDetail.ActiveTab:=WC027InfoLogRG;
  end;

  MostraFrame('Informazioni timbratura');
end;

procedure TWC027FInfoDatiFM.OnCancellaFile(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  LResCtrl: TResCtrl;
  C021DM: TC021FDocumentiManagerDM;
begin
  // se l'id non è valido esce immediatamente
  if iIWFile <= 0 then
    Exit;

  try
    if R = mrYes then
    begin
      C021DM:=TC021FDocumentiManagerDM.Create(Self);
      C021DM.Maschera:='A176';
      C021DM.CancellaFileTemp:=False;

      try
        // elimina il riferimento all'allegato dalla tabella T853
        C018.delT853.SetVariable('ID',FC018IterInfo.IDRichiesta);
        C018.delT853.SetVariable('ID_T960',iIWFile);
        C018.delT853.Execute;

        // elimina il documento da db
        LResCtrl:=C021DM.Delete(iIWFile);
        if not LResCtrl.Ok then
          raise Exception.Create(LResCtrl.Messaggio);

        SessioneOracle.Commit;

        (*
        // l'allegato è stato effettivamente cancellato se
        //   a. il suo id non compare nell'elenco di quelli inseriti
        //   b. il suo id non compare nel dataset iniziale
        if InfoAllegati.IdInAllegatiInseriti(LIdDoc) then
        begin
          // se l'id è nell'elenco di quelli inseriti lo elimina
          InfoAllegati.RimuoviDaAllegatiInseriti(LIdDoc);
          GestioneConfermaAllegatiInseriti;
        end
        else
        begin
          // altrimenti se l'id compare nel dataset iniziale imposta il flag di eliminazione
          InfoAllegati.AllegatiCancellati:=not VarIsNull(C018.selT853_T960.Lookup('ID_T960',LIdDoc,'ID_T960'));
        end;
        *)

        if Assigned(C021DM) then
          try FreeAndNil(C021DM); except end;

        // aggiorna visualizzazione
        FC018IterInfo.Allegati.Refresh;
        CaricaInfoRichiesta(FC018IterInfo.IDRichiesta);
      except
        on E: Exception do
        begin
          //Eseguo rollback solo se la sessione db è usata solo da me
          if SessioneOracle.Tag = 1 then
            SessioneOracle.Rollback
          else
            SessioneOracle.Commit;
          raise;
        end;
      end;
    end;
  finally
    iIWFile:=0;
  end;
end;



procedure TWC027FInfoDatiFM.btnCaricaClick(Sender: TObject);
var
  IterMaxAllegati, IterMaxDimAllegatoMB: integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
  LDimMB: Double;
  C021DM: TC021FDocumentiManagerDM;
begin
  inherited;

  IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
  if IterMaxAllegati < 0 then
    IterMaxAllegati:=999;

  //Condizione che non dovrebbe verificarsi perchè impedita a monte
  if FC018IterInfo.Allegati.RecordCount >= IterMaxAllegati then
    raise Exception.Create('Numero massimo di allegati raggiunto. Impossibile proseguire.');

  IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);

  if not fileUpload.IsPresenteFileUploadato then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_WC026_ERR_SELEZIONARE_DOC));

  C018.Iter:=FC018IterInfo.Iter;
  C021DM:=TC021FDocumentiManagerDM.Create(Self);
  C021DM.Maschera:='A176';
  C021DM.CancellaFileTemp:=False;
  try
    // crea oggetto documento
    LDoc:=TDocumento.Create;
    LDoc.SetNomeFileCompleto(fileUpload.NomeFile);
    //LDoc.ExtFile:=TPath.GetExtension(Myfile);
    LDoc.Progressivo:=FDataSetIter.FieldByName('PROGRESSIVO').AsInteger;
    LDoc.Tipologia:=DOC_TIPOL_ITER;
    LDoc.Ufficio:=DOC_UFFICIO_PREDEF;
    LDoc.PeriodoDal:=FDataSetIter.FieldByName(C018.GetColonnaVistaPeriodoInizio).AsDateTime;
    LDoc.PeriodoAl:=FDataSetIter.FieldByName(C018.GetColonnaVistaPeriodoFine).AsDateTime;
    LDoc.PathStorage:=Parametri.CampiRiferimento.C90_PathAllegati;
    LDoc.Provenienza:=DOC_PROVENIENZA_INTERNA;

    // Gestione web/cloud: se esiste già un file temporaneo con lo stesso nome lo cancella
    if TFile.Exists(LDoc.TempFile) then
      TFile.Delete(LDoc.TempFile);
    // effettua upload
    try
      fileUpload.SalvaSuFile(LDoc.TempFile);
      fileUpload.Ripristina;
    except
      on E: Exception do
      begin
        fileUpload.Ripristina;
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_WC026_ERR_FMT_DOC_UPLOAD),[E.Message]));
      end;
    end;

    // imposta proprietà documento
    LDoc.Dimensione:=R180GetFileSize(LDoc.TempFile);
    // controllo dimensione file
    LDimMB:=LDoc.Dimensione / BYTES_MB;
    if LDimMB > IterMaxDimAllegatoMB then
    begin
      // Gestione web/cloud: cancella file temporaneo
      try
        TFile.Delete(LDoc.TempFile);
      except
      end;
      // solleva eccezione
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DIM_ALLEGATO),[IterMaxDimAllegatoMB,LDimMB]));
    end;

    if LDoc.PathStorage = 'DB' then
    begin
      LDoc.Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
      LDoc.Blob.Tag:=Integer(btFree); // indica che il blob è da distruggere dal distruttore di TDocumento
      LDoc.Blob.LoadFromFile(LDoc.TempFile);
    end;

    LDoc.Note:='Caricato da back office'; //cdsAllegati.FieldByName('NOTE').AsString;

    LDoc.CFFamiliare:='';
    if FC018IterInfo.Iter = ITER_GIUSTIF then
      if not FDataSetIter.FieldByName('T050DATANAS').IsNull then
        LDoc.CFFamiliare:=C018.GetCFFamiliare(LDoc.Progressivo, FDataSetIter.FieldByName('T050DATANAS').AsDateTime);

    // operazioni su database
    try
      // salvataggio del documento
      LResCtrl:=C021DM.Save(LDoc);
      if not LResCtrl.Ok then
        raise Exception.Create(LResCtrl.Messaggio);

      // inserisce il riferimento all'allegato su T853
      C018.insT853.SetVariable('ID', FC018IterInfo.IDRichiesta);      //4899
      C018.insT853.SetVariable('ID_T960', LDoc.Id); //2491
      C018.insT853.Execute;

      SessioneOracle.Commit;

      (*
      // segnala la modifica
      if dgrdDocumenti.DataSource.DataSet.State = dsInsert then //grdAllegati.medpStato = msInsert then
      begin
        // l'allegato è stato inserito
          InfoAllegati.AggiungiAdAllegatiInseriti(LDoc.Id);

        // in caso di inserimento nuovi allegati si richiede la conferma di conformità all'originale
          GestioneConfermaAllegatiInseriti;
      end
      else
      begin
        // in alternativa l'allegato si considera modificato
          InfoAllegati.AllegatiModificati:=True;
      end;
      *)
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        raise;
      end;
    end;
  finally
    if Assigned(LDoc) then
      try FreeAndNil(LDoc); except end;

    if Assigned(C021DM) then
      try FreeAndNil(C021DM); except end;

    FC018IterInfo.Allegati.Refresh;
    CaricaInfoRichiesta(FC018IterInfo.IDRichiesta);
  end;

end;

procedure TWC027FInfoDatiFM.btnChiudiClick(Sender: TObject);
begin
  ReleaseOggetti;
  FreeAndNil(Self);
end;

procedure TWC027FInfoDatiFM.grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  IWImg: TmeIWImageFile;
begin
  inherited;
  for i:=0 to High(grdDocumenti.medpCompGriglia) do
  begin
    IWImg:=(grdDocumenti.medpCompCella(i,DBG_COMANDI,0) as TmeIWImageFile);
    if grdDocumenti.medpValoreColonna(i,'ID_ALLEGATO') <> '' then
    begin
      IWImg.Tag:=StrToInt(grdDocumenti.medpValoreColonna(i,'ID_ALLEGATO'));
      IWImg.medpDownloadButton:=True;
      IWImg.OnClick:=imgFileDownloadExecute;
    end
    else
      IWImg.medpDownloadButton:=False;

    IWImg:=(grdDocumenti.medpCompCella(i,DBG_COMANDI,1) as TmeIWImageFile);
    if grdDocumenti.medpCompCella(i,'DBG_COMANDI',1) <> nil then
      if grdDocumenti.medpValoreColonna(i,'ALLEGATO_BACKOFFICE') <> 'S' then
        IWImg.Css:='invisibile'
      else
      if grdDocumenti.medpValoreColonna(i,'ID_ALLEGATO') <> '' then
      begin
        IWImg.Tag:=StrToInt(grdDocumenti.medpValoreColonna(i,'ID_ALLEGATO'));
        IWImg.OnClick:=imgCancellaFileExecute;
      end;
  end;
end;

procedure TWC027FInfoDatiFM.grdTabDetailTabControlChange(Sender: TObject);
begin
//***  if grdTabDetail.TabIndex = tabLog then
  begin
    CaricaInfoLog;
  end;
end;

procedure TWC027FInfoDatiFM.imgCancellaFileExecute(Sender: TObject);
// operazioni in fase di cancellazione dell'allegato
var
  r: Integer;
  LResCtrl: TResCtrl;
  C021DM: TC021FDocumentiManagerDM;
begin
  // estrae id richiesta (è contenuto nel tag)
  iIWFile:=(Sender as TmeIWImageFile).Tag;

  // se l'id non è valido esce immediatamente
  if iIWFile <= 0 then
    Exit;

  r:=grdDocumenti.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);

  //Controlla che l'allegato provenga da backoffice
  if grdDocumenti.medpValoreColonna(r,'ALLEGATO_BACKOFFICE') <> 'S' then
    raise Exception.Create('Impossibile eliminare un allegato non caricato da back office');

  MsgBox.WebMessageDlg('Eliminare l''allegato selezionato?',mtConfirmation,[mbYes,mbNo],OnCancellaFile,'C027');
end;

procedure TWC027FInfoDatiFM.imgFileDownloadExecute(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LC021DM: TC021FDocumentiManagerDM;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta (è contenuto nel tag)
  LId:=(Sender as TmeIWImageFile).Tag;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae il file con i metadati associati
  LC021DM:=TC021FDocumentiManagerDM.Create(nil);
  A000SessioneWEB.AnnullaTimeOut;
  try
    // estrae il file con i metadati associati
    try
      LResCtrl:=LC021DM.GetById(LId,True,LDoc);

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
    FreeAndNil(LC021DM);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWC027FInfoDatiFM.CaricaInfoCertificatoINPS(PIdCertificato: String);
var
  LField: TField;
  i: Integer;
begin
  if FA087MW = nil then
    FA087MW:=TA087FImpAttestatiMalMW.Create(nil);

  FA087MW.selT048Info.Close;
  FA087MW.selT048Info.SetVariable('ID_CERTIFICATO',PIdCertificato);
  FA087MW.selT048Info.Open;
  if FA087MW.selT048Info.RecordCount = 0 then
    lblInfoCertINPS.Caption:=Format('Certificato %s non presente in archivio',[PIdCertificato]);

  grdCertINPS.Visible:=FA087MW.selT048Info.RecordCount > 0;
  if grdCertINPS.Visible then
  begin
    cdsT048.EmptyDataSet;
    for i:=0 to FA087MW.selT048Info.Fields.Count - 1 do
    begin
      LField:=FA087MW.selT048Info.Fields[i];
      if LField.Visible then
      begin
        cdsT048.Append;
        cdsT048.FieldByName('DATO').AsString:=LField.DisplayLabel;
        cdsT048.FieldByName('VALORE').AsString:=LField.AsString;
        cdsT048.Post;
      end;
    end;
    grdCertINPS.medpAttivaGrid(cdsT048,False,False,False);
  end;
  lblInfoCertINPS.Visible:=FA087MW.selT048Info.RecordCount = 0;
end;

procedure TWC027FInfoDatiFM.CaricaInfoLog;
var
  LOra: String;
begin
  // se manca l'indice su I000 (TABELLA + PROGRESSIVO) non tenta nemmeno il caricamento dei log
  if not FEsisteIndiceI000 then
  begin
    grdLogOperazioni.Visible:=False;
    lblInfoLog.Caption:='Le informazioni di log non possono essere cercate: manca un indice sulla tabella!';
    lblInfoLog.Visible:=True;
    Exit;
  end;

  // se i dati dei log sono già stati caricati termina subito
  if FLogCaricato then
    Exit;

  if FDatiGiust.Progressivo <> 0 then
  begin
    // cerca log giustificativo
    FA093MW.selI000_T040.Close;
    FA093MW.selI000_T040.SetVariable('PROGRESSIVO',FDatiGiust.Progressivo);
    FA093MW.selI000_T040.SetVariable('DATA',FDatiGiust.Data);
    FA093MW.selI000_T040.SetVariable('CAUSALE',FDatiGiust.Causale);
    FA093MW.selI000_T040.SetVariable('TIPOGIUST',FDatiGiust.Tipo);
    FA093MW.selI000_T040.SetVariable('DAORE',DateTimeToStr(FDatiGiust.DaOre));
    FA093MW.selI000_T040.SetVariable('AORE',DateTimeToStr(FDatiGiust.AOre));
    FA093MW.selI000_T040.SetVariable('DATANAS',FDatiGiust.DataNas);
    FA093MW.selI000_T040.Open;
    if FA093MW.selI000_T040.RecordCount = 0 then
      lblInfoLog.Caption:='Nessun log presente per questo giustificativo';

    grdLogOperazioni.Visible:=FA093MW.selI000_T040.RecordCount > 0;
    if grdLogOperazioni.Visible then
      grdLogOperazioni.medpAttivaGrid(FA093MW.selI000_T040,False,False,False);
    lblInfoLog.Visible:=FA093MW.selI000_T040.RecordCount = 0;
  end
  else if FDatiTimb.Progressivo <> 0 then
  begin
    FA093MW.selI000_T100.Close;
    FA093MW.selI000_T100.SetVariable('PROGRESSIVO',FDatiTimb.Progressivo);
    FA093MW.selI000_T100.SetVariable('DATA',FDatiTimb.Data);
    if VarIsType(FDatiTimb.Ora,varDate) then
    begin
      // trasforma l'ora in stringa, azzerandone i secondi
      // le timbrature manuali e richieste da web/app, infatti, non dispongono di questa info
      LOra:=DateTimeToStr(RecodeSecond(FDatiTimb.Ora,0))
    end
    else
      LOra:=VarToStr(FDatiTimb.Ora);
    FA093MW.selI000_T100.SetVariable('ORA',LOra);
    FA093MW.selI000_T100.SetVariable('VERSO',FDatiTimb.Verso);
    FA093MW.selI000_T100.SetVariable('FLAG',FDatiTimb.Flag);
    FA093MW.selI000_T100.Open;
    if FA093MW.selI000_T100.RecordCount = 0 then
      lblInfoLog.Caption:='Nessun log presente per questa timbratura';

    grdLogOperazioni.Visible:=FA093MW.selI000_T100.RecordCount > 0;
    if grdLogOperazioni.Visible then
      grdLogOperazioni.medpAttivaGrid(FA093MW.selI000_T100,False,False,False);
    lblInfoLog.Visible:=FA093MW.selI000_T100.RecordCount = 0;
  end;

  FLogCaricato:=True;
end;

procedure TWC027FInfoDatiFM.CaricaInfoRichiesta(IDRichiesta:integer);
var
  c:integer;
  AbilitaModifica: Boolean;
  IterMaxAllegati: integer;
begin
  if FC018IterInfo = nil then
    FC018IterInfo:=TC018IterInfo.create;
  if not assigned(C018) then
  begin
    C018:=TC018FIterAutDM.Create(Self);
    C018.Name:='WC027';
  end;

  FC018IterInfo.IDRichiesta:=IDRichiesta;
  //Info richiesta
  lblIDRichiestaValue.Caption:=FC018IterInfo.IDRichiesta.ToString;
  lblDataRichiestaValue.Caption:=FC018IterInfo.DataRichiesta.ToString('dd/mm/yyyy hh.mm');
  lblCodiceIterValue.Caption:=FC018IterInfo.CodIter;
  lblRichiedenteValue.Caption:=FC018IterInfo.Richiedente;
  mmNoteRichiedenteValue.Text:=FC018IterInfo.NoteRichiesta;
  //Info autorizzatore
  C018.Id:=IDRichiesta;
  C018.Iter:=FC018IterInfo.Iter;
  C018.CodIter:=FC018IterInfo.CodIter;
  C018.LeggiIterCompleto;

  grdInfo.medpDataSet:=C018.selT851;
  grdInfo.medpPaginazione:=False;
  grdInfo.medpBrowse:=False;
  grdInfo.medpDataSet.Refresh;
  grdInfo.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  grdInfo.medpEliminaColonne;
  grdInfo.medpAggiungiColonna('TITOLO_LIVELLO','Livello','',nil,nil);
  grdInfo.medpAggiungiColonna('STATO','Autorizzazione','',nil,nil);
  grdInfo.medpAggiungiColonna('DATA','Data','',nil,nil);
  grdInfo.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil,nil);
  grdInfo.medpAggiungiColonna('NOTE','Note','',nil,nil);
  grdInfo.medpInizializzaCompGriglia;
  grdInfo.RigaInserimento:=False;
  grdInfo.medpCaricaCDS;

  //Info revoca
  lblIDRevocaValue.Caption:=FC018IterInfo.IDRevoca.ToString;
  lblDataRevocaValue.Caption:=FC018IterInfo.DataRevoca.ToString('dd/mm/yyyy hh.mm');
  mmNoteRevocaValue.Text:=FC018IterInfo.NoteRevoca;

  //Gestione allegati
  AbilitaModifica:=(FDataSetIter <> nil) and (FDataSetIter.Active) and (not SolaLettura);
  grdDocumenti.medpComandiCustom:=True;
  grdDocumenti.RigaInserimento:=False;
  grdDocumenti.medpAttivaGrid(FC018IterInfo.Allegati, False, False, False);
  grdDocumenti.medpPreparaComponentiDefault;
  c:=grdDocumenti.medpIndexColonna(DBG_COMANDI);
  grdDocumenti.medpPreparaComponenteGenerico('WR102-R',c,0,DBG_IMG,'','SALVA','Salva il documento','','');
  grdDocumenti.medpPreparaComponenteGenerico('WR102-R',c,1,DBG_IMG,'','CANCELLA','Elimina il documento','','');
  grdDocumenti.medpCaricaCDS;

  IterMaxAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
  if IterMaxAllegati < 0 then
    IterMaxAllegati:=999;
  fileUpload.Enabled:=(FC018IterInfo.Allegati.RecordCount < IterMaxAllegati) and AbilitaModifica;
  btnUpload.Enabled:=fileUpload.Enabled;
  fileUpload.Visible:=fileUpload.Enabled;

  FGrpRevocaVisible:=FC018IterInfo.IDRevoca > 0;
  FGrpDocumentiVisible:=FC018IterInfo.EsisteGestioneAllegati;

  fileUpload.AllowedExtensions:=Parametri.CampiRiferimento.C90_IterEstensioneAllegato;
end;

end.
