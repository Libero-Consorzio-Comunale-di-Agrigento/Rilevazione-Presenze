unit W002UAnagrafeElenco;

interface

uses
  Db, SysUtils, Graphics, Oracle, IWApplication,
  IWDBGrids, IWTemplateProcessorHTML, IWHTMLControls, IWForm,
  IWAppForm, IWCompLabel, IWCompEdit, IWCompButton, IWControl,
  OracleData,
  Classes, Controls, Variants,
  IWBaseControl, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWVCLBaseControl, IWBaseHTMLControl,
  ActnList, Forms, IWVCLBaseContainer, IWContainer,
  IWVCLComponent, StrUtils, Math, IWCompCheckbox,
  A000UCostanti, A000UMessaggi, W000UMessaggi,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  meIWCheckBox, meIWButton, meIWEdit, meIWLabel, meIWImageFile,
  meIWDBGrid, meIWLink,
  IWCompGrids, IWCompExtCtrls, Menus, meIWGrid;

type
  TW002FAnagrafeElenco = class(TR010FPaginaWeb)
    chkDipendentiCessati: TmeIWCheckBox;
    lblDataLavoro: TmeIWLabel;
    edtDataLavoro: TmeIWEdit;
    btnApplicaData: TmeIWButton;
    lblNomeRicerca: TmeIWLabel;
    edtNomeRicerca: TmeIWEdit;
    btnSalvaRicerca: TmeIWButton;
    btnCancellaRicerca: TmeIWButton;
    lblNumRecord: TmeIWLabel;
    imgPrimo: TmeIWImageFile;
    imgPrec: TmeIWImageFile;
    imgSucc: TmeIWImageFile;
    imgUltimo: TmeIWImageFile;
    grdAnagrafe: TmeIWDBGrid;
    lblContaRecord: TmeIWLabel;
    lblAnagrafeCaption: TmeIWLabel;
    pmnTabella: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    lnkNotifica: TmeIWLink;
    mnuEsportaCSV: TMenuItem;
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure grdAnagrafeRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnSalvaRicercaClick(Sender: TObject);
    procedure grdAnagrafeColumnsMatricolaClick(ASender: TObject;
      const AValue: String);
    procedure imgPaginaPrimaClick(Sender: TObject);
    procedure imgPaginaPrecClick(Sender: TObject);
    procedure imgPaginaSuccClick(Sender: TObject);
    procedure imgPaginaUltimaClick(Sender: TObject);
    procedure btnCancellaRicercaClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnApplicaDataClick(Sender: TObject);
    procedure chkDipendentiCessatiClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWTemplateProcessorHTML1UnknownTag(const AName: string; var VValue: string);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure lnkNotificaClick(Sender: TObject);
    procedure mnuEsportaCSVClick(Sender: TObject);
  private
    NumRec,NumPagine:Integer;
    JsDipendenteSingolo: String;
    procedure VerificaMsgDaLeggere;
    procedure UpdateVistaPersonale;
    procedure AggiornaContatore;
    procedure ApriW035MsgDaLeggere;
    procedure VerificaDatiConiuge;
    procedure ApriW042Notifica;
  protected
    procedure RefreshPage; override;
    function  GetInfoFunzione: String; override;
  public
    RefreshCompleto,
    DipendenteSingolo: Boolean;
  end;

implementation

uses A000UInterfaccia, A000USessione,
     W001UIrisWebDtM, W035UMessaggistica,
     W042UDatiConiuge;

{$R *.dfm}

procedure TW002FAnagrafeElenco.IWAppFormCreate(Sender: TObject);
var i: Integer;
begin
  medpFissa:=True;
  inherited;
  edtDataLavoro.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  imgPrimo.Hint:='Prima pagina';
  imgPrec.Hint:='Pagina precedente';
  imgSucc.Hint:='Pagina successiva';
  imgUltimo.Hint:='Ultima pagina';
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  //grdAnagrafe.RowLimit:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,18);
  grdAnagrafe.RowLimit:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  //grdAnagrafe.medpFixedColumns:=4;

  DipendenteSingolo:=False;
  RefreshCompleto:=False;
  UpdateVistaPersonale;

  if A000GetInibizioni('Tag','445') <> 'N' then
    VerificaMsgDaLeggere;

  // aggiorna le icone di accesso rapido
  AggiornaIconeAccessoRapido;
  // per tutte le icone trovate, mostra la notifica se previsto
  for i:=Low(WR000DM.NotificheAttivita.Items) to High(WR000DM.NotificheAttivita.Items) do
  begin
    if WR000DM.NotificheAttivita.Items[i].MsgNotifica <> '' then
      Notifica(WR000DM.NotificheAttivita.Items[i].TitoloNotifica, WR000DM.NotificheAttivita.Items[i].MsgNotifica, '', True, True);
  end;

  (*Non più necessario dare la notifica
  if A000GetInibizioni('Tag','450') = 'S' then
    VerificaDatiConiuge;
  *)

  //Gestione Notifiche custom
  NotificheCustom;

  // MONDOEDP - commessa MAN/07 SVILUPPO#0.ini
  // verifica se il browser in uso è supportato e notifica nel caso di incompatibilità
  VerificaCompatibilitaBrowser;
  // MONDOEDP - commessa MAN/07 SVILUPPO#0.fine
end;

procedure TW002FAnagrafeElenco.RefreshPage;
var
  LNomeCampo: String;
begin
  if RefreshCompleto then
  begin
    WR000DM.selAnagrafe.Close;
    WR000DM.selAnagrafe.Open;

    // caption da layout anagrafico - daniloc 04.10.2010
    // operazione necessaria dopo close + open per riallineamento del displaylabel dei campi
    WR000DM.cdsI010.IndexName:='Visualizzazione';
    WR000DM.cdsI010.Filtered:=False;
    WR000DM.cdsI010.First;
    while not WR000DM.cdsI010.Eof do
    begin
      LNomeCampo:=WR000DM.cdsI010.FieldByName('NOME_CAMPO').AsString;
      if WR000DM.selAnagrafe.FindField(LNomeCampo) <> nil then
        WR000DM.selAnagrafe.FieldByName(LNomeCampo).DisplayLabel:=WR000DM.cdsI010.FieldByName('CAPTION_LAYOUT').AsString;
      WR000DM.cdsI010.Next;
    end;
    // caption da layout anagrafico.fine

    UpdateVistaPersonale;
    WR000DM.cdsAnagrafe.Locate('PROGRESSIVO',ParametriForm.Progressivo,[]);
    RefreshCompleto:=False;
  end
  else
  begin
    WR000DM.cdsAnagrafe.Locate('PROGRESSIVO',ParametriForm.Progressivo,[]);
    AggiornaContatore;
  end;
end;

procedure TW002FAnagrafeElenco.VerificaMsgDaLeggere;
// verifica se ci sono messaggi da leggere ed eventualmente visualizza una notifica
var
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  MsgDaLeggere: TNumMessaggi;
  S: String;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
  NumMsg: Integer;
begin
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
  //NumMsg:=WR000DM.GetNumMsgDaLeggere;
  MsgDaLeggere:=WR000DM.GetNumMsgDaLeggere;
  NumMsg:=MsgDaLeggere.Totali;
  // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

  // se ci sono messaggi da leggere li visualizza come notifica
  if NumMsg > 0 then
  begin
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
    if MsgDaLeggere.LetturaObbligatoria > 0 then
    begin
      // sono presenti messaggi con lettura obbligatoria -> accesso immediato alla W035
      S:=Format('SubmitClick("%s","W035",true); ',[lnkNotifica.HTMLName]);
      AddToInitProc(S);
    end
    else
    begin
      { notifica rimossa: il contatore notifiche è ora disponibile su icone di accesso rapido
      // notifica i nuovi messaggi da leggere
      NumMsgStr:=IfThen(NumMsg = 1,'1 nuovo messaggio',Format('%d nuovi messaggi',[NumMsg]));
      Testo:=Format('Hai <a href="javascript:SubmitClick(''%s'',''W035'',true);" ' +
                    '     title="Visualizza i messaggi da leggere">%s</a> da leggere',
                    [lnkNotifica.HTMLName,NumMsgStr]);
      Notifica('Nuovi messaggi',Testo,'../img/mail-icon.png',False,True);
      }
    end;
    // MONDOEDP - commessa MAN/07 SVILUPPO#57.fine
  end;
end;

procedure TW002FAnagrafeElenco.VerificaDatiConiuge;
// verifica l'esistenza di queste condizioni:
// - 1. accesso su singola anagrafica;
// - 2. Parametri.ModuloInstallato['FAMILIARI_WEB']
// - 3. la query WR000DM.selConiuge restituisce un record
// e nel caso fornisce una notifica all'utente
var
  NumNotifiche:Integer;
  VisNotifica: Boolean;
  CF,Testo: String;
begin
  // PRE: verificata abilitazione alla funzione "(W042) Dati coniuge" (lettura / scrittura)

  // verifica le prime 2 condizioni
  VisNotifica:=Parametri.ModuloInstallato['FAMILIARI_WEB'];

  if not VisNotifica then
    Exit;

  // verifica la query WR000DM.selConiuge: solo se il codice fiscale è sempre lo stesso
  NumNotifiche:=0;
  with WR000DM.cdsAnagrafe do
  begin
    First;
    //Verifico che tutte le anagrafiche abbiano lo stesso codice fiscale, altrimenti non si dà la notifica
    if WR000DM.cdsAnagrafe.FindField('CODFISCALE') <> nil then
    begin
      CF:=WR000DM.cdsAnagrafe.FieldByName('CODFISCALE').AsString;
      Next;
      while (not Eof) and VisNotifica do
      begin
        if CF <> WR000DM.cdsAnagrafe.FieldByName('CODFISCALE').AsString then
          VisNotifica:=False;
        Next;
      end;
      if not VisNotifica then
      begin
        First;
        Exit;
      end;
    end;
    First;
    try
      while not Eof do
      try
        WR000DM.selConiuge.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
        WR000DM.selConiuge.Execute;
        if WR000DM.selConiuge.GetVariable('RESULT') > 0 then
          inc(NumNotifiche);
        Next;
      except
        on E: Exception do
        begin
          MsgBox.MessageBox('Errore durante il controllo del coniuge',ERRORE);
          Abort;
        end;
      end;
    finally
      First;
    end;
  end;
  VisNotifica:=NumNotifiche > 0;

  // notifica verifica coniuge
  if VisNotifica then
  begin
    Testo:=Format(IfThen(NumNotifiche = 1,A000MSG_W042_MSG_FMT_NOTIFICA_CU_2016,A000MSG_W042_MSG_FMT_NOTIFICA_CU_2016_MULTI),
                  [Format('<a href="javascript:SubmitClick(''%s'',''W042'',true);" ' +
                          '   title="Accede alla funzione Dati del coniuge">Dati del coniuge</a>%s',
                          [lnkNotifica.HTMLName,Testo])]);
    Notifica('CU 2016',Testo,'',True,True);
  end;
end;

procedure TW002FAnagrafeElenco.IWAppFormRender(Sender: TObject);
begin
  inherited;

  if DipendenteSingolo then
    JsDipendenteSingolo:='document.getElementById("PagNavBarAnagrafe").className = "invisibile";' + CRLF +
                         'document.getElementById("W002Filtri").className = "invisibile";';
  chkDipendentiCessati.Checked:=VarToStr(WR000DM.selAnagrafe.GetVariable('FILTRO_IN_SERVIZIO')) = '';
end;

procedure TW002FAnagrafeElenco.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    lblCommentoCorrente.Caption:='';
    if not jqPublicIP.Enabled then
      RimuoviNotifiche;
  end;
end;

procedure TW002FAnagrafeElenco.IWTemplateProcessorHTML1UnknownTag(const AName: string; var VValue: string);
begin
  inherited;
  if UpperCase(AName) = 'DIPENDENTESINGOLO' then
    VValue:=JsDipendenteSingolo;
end;

procedure TW002FAnagrafeElenco.UpdateVistaPersonale;
// Apre il clientdataset cdsAnagrafe e ricostruisce grdAnagrafe
var
  i:Integer;
begin
  // prepara i campi di cdsAnagrafe
  WR000DM.cdsAnagrafe.Close;
  WR000DM.cdsAnagrafe.FieldDefs.Assign(WR000DM.selAnagrafe.FieldDefs);
  WR000DM.cdsAnagrafe.CreateDataSet;
  WR000DM.cdsAnagrafe.LogChanges:=False;
  for i:=0 to WR000DM.selAnagrafe.FieldCount - 1 do
  begin
    WR000DM.cdsAnagrafe.FieldByName(WR000DM.selAnagrafe.Fields[i].FieldName).Index:=WR000DM.selAnagrafe.Fields[i].Index;
    WR000DM.cdsAnagrafe.Fields[i].Visible:=WR000DM.selAnagrafe.Fields[i].Visible;
    WR000DM.cdsAnagrafe.Fields[i].DisplayLabel:=WR000DM.selAnagrafe.Fields[i].DisplayLabel;
  end;

  // carica i valori di selAnagrafe su cdsAnagrafe
  WR000DM.selAnagrafe.First;
  while not WR000DM.selAnagrafe.Eof do
  begin
    WR000DM.cdsAnagrafe.Append;
    for i:=0 to WR000DM.selAnagrafe.FieldCount - 1 do
    begin
      WR000DM.cdsAnagrafe.Fields[i].Value:=WR000DM.selAnagrafe.Fields[i].Value;
    end;
    WR000DM.cdsAnagrafe.Post;
    WR000DM.selAnagrafe.Next;
  end;
  WR000DM.selAnagrafe.CloseAll;

  // imposta proprietà griglia
  grdAnagrafe.Columns.Clear;
  grdAnagrafe.CreateImplicitColumns;
  for i:=0 to grdAnagrafe.Columns.Count - 1 do
  begin
    if (TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).DataField = 'MATRICOLA') or
       (TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).DataField = 'COGNOME') or
       (TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).DataField = 'NOME') then
    begin
      TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).OnClick:=grdAnagrafeColumnsMatricolaClick;
      TIWDBGridColumn(grdAnagrafe.Columns.Items[i]).LinkField:='MATRICOLA';
    end;
  end;
  NumPagine:=WR000DM.cdsAnagrafe.RecordCount div grdAnagrafe.RowLimit;
  if (WR000DM.cdsAnagrafe.RecordCount mod grdAnagrafe.RowLimit) > 0 then
    inc(NumPagine);
  WR000DM.cdsAnagrafe.First;
  if WR000DM.cdsAnagrafe.RecordCount > 0 then
  begin
    ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
  end;

  NumRec:=1;
  AggiornaContatore;
end;

function TW002FAnagrafeElenco.GetInfoFunzione: String;
begin
  Result:='';
  try
    if (WR000DM <> nil) and
       (WR000DM.cdsAnagrafe <> nil) then
    begin
      if not WR000DM.cdsAnagrafe.Active then
        Result:='' // dataset non pronto
      else if WR000DM.cdsAnagrafe.RecordCount = 0 then
        Result:=A000TraduzioneStringhe(A000MSG_MSG_NESSUN_DIP)
      else
      begin
        Result:=Format('%s: %s<br>%s: %s %s',
                       [A000TraduzioneStringhe(A000MSG_MSG_MATRICOLA),
                        WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString,
                        A000TraduzioneStringhe(A000MSG_MSG_NOMINATIVO),
                        WR000DM.cdsAnagrafe.FieldByName('COGNOME').AsString,
                        WR000DM.cdsAnagrafe.FieldByName('NOME').AsString]);
      end;
    end;
  except
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#57.ini
procedure TW002FAnagrafeElenco.ApriW035MsgDaLeggere;
// accesso alla funzione messaggistica sui messaggi da leggere
var
  W035: TW035FMessaggistica;
begin
  W035:=TW035FMessaggistica.Create(GGetWebApplicationThreadVar);
  W035.SetParam('PROGRESSIVO',medpProgressivo);
  W035.SetParam('MODALITA','L'); // L = lettura, I = invio
  W035.OpenPage;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#57.fine

procedure TW002FAnagrafeElenco.ApriW042Notifica;
// accesso alla funzione di dati coniuge
var
  W042: TW042FDatiConiuge;
begin
  WR000DM.Responsabile:=False;
  W042:=TW042FDatiConiuge.Create(GGetWebApplicationThreadVar);
  W042.SetParam('PROGRESSIVO',medpProgressivo);
  W042.OpenPage;
end;

procedure TW002FAnagrafeElenco.lnkNotificaClick(Sender: TObject);
// gestione click su un'azione di notifica
var
  ParStr: String;
begin
  // parametro inviato via javascript
  // serve a determinare il tipo di azione da eseguire
  ParStr:=(Sender as TmeIWLink).GetSubmitParam;

  // click su notifica
  if ParStr = 'W035' then
    ApriW035MsgDaLeggere
  else if ParStr = 'W042' then
    ApriW042Notifica;
end;

procedure TW002FAnagrafeElenco.btnSalvaRicercaClick(Sender: TObject);
var i:Integer;
begin
  if Trim(edtNomeRicerca.Text) = '' then  //Lorena 15/06/2006
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W002_MSG_INSERIRE_NOME_SELEZIONE),INFORMA);
    exit;
  end;
  if WR000DM.lstSQL.Count = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W002_MSG_SELEZIONE_NON_ATTIVA),INFORMA);
    Exit;
  end;
  with WR000DM do
  begin
    seldistT003.Close; //Lorena 12/06/2006
    seldistT003.Filtered:=False;
    seldistT003.Open; //Lorena 12/06/2006
    if not seldistT003.SearchRecord('NOME',edtNomeRicerca.Text,[srFromBeginning]) then
    begin
      insT003.SetVariable('NOME',edtNomeRicerca.Text);
      for i:=0 to WR000DM.lstSQL.Count - 1 do
      begin
        insT003.SetVariable('POSIZIONE',i);
        insT003.SetVariable('RIGA',WR000DM.lstSQL[i]);
        insT003.Execute;
      end;
      insT003.Session.Commit;
      RefreshT003:=True;
      MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W002_MSG_FMT_SELEZIONE_SALVATA),[edtNomeRicerca.Text]),INFORMA);
    end
    else
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W002_ERR_SELEZIONE_GIA_ESISTENTE),INFORMA);
    seldistT003.Close; //Lorena 12/06/2006
    seldistT003.Filtered:=True;
  end;
end;

procedure TW002FAnagrafeElenco.grdAnagrafeColumnsMatricolaClick(ASender: TObject; const AValue: String);
begin
  WR000DM.cdsAnagrafe.Locate('MATRICOLA',AValue,[]);
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.mnuEsportaCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdAnagrafe.ToCsv
  else
    InviaFile('ElencoDipendenti.xls',csvDownload);
end;

procedure TW002FAnagrafeElenco.mnuEsportaExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdAnagrafe.ToXlsx
  else
    InviaFile('ElencoDipendenti.xlsx',streamDownload);
end;

procedure TW002FAnagrafeElenco.AggiornaContatore;
// Aggiorna visualizzazione del contatore di record / pagine
var
   recDa,recA,recTot,pagCurr,pagTot: Integer;
begin
  // calcoli per num. record
  if WR000DM.cdsAnagrafe.RecordCount = 0 then
  begin
    pagTot:=0;
    imgPrimo.Visible:=False;
    imgPrec.Visible:=False;
    lblNumRecord.Visible:=True;
    lblNumRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_PAG),[0,0]);
    lblNumRecord.Hint:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT),[0,0,0]);
    lblContaRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_REC),[0,0,0]);
    imgSucc.Visible:=False;
    imgUltimo.Visible:=False;
  end
  else
  begin
    // calcoli per num. record
    recDa:=WR000DM.cdsAnagrafe.RecNo;
    recA:=min(WR000DM.cdsAnagrafe.RecNo + grdAnagrafe.RowLimit - 1,WR000DM.cdsAnagrafe.RecordCount);
    recTot:=WR000DM.cdsAnagrafe.RecordCount;

    // contatore in formato numero pagine
    pagCurr:=NumRec div grdAnagrafe.RowLimit + 1;
    pagTot:=NumPagine;

    // imposta label in base a tipo visualizzazione
    lblNumRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_PAG),[pagCurr,pagTot]);
    lblNumRecord.Hint:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT),[recDa,recA,recTot]);
    lblContaRecord.Caption:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_REC),[recDa,recA,recTot]);
    lblContaRecord.Css:='contatore align_right';

    // se num. pag. totale è maggiore di 1 visualizza le immagini per la navigazione
    imgPrimo.Visible:=(pagTot > 1);
    imgPrec.Visible:=(pagTot > 1);
    imgSucc.Visible:=(pagTot > 1);
    imgUltimo.Visible:=(pagTot > 1);
    if pagTot > 1 then
    begin
      imgPrimo.Enabled:=(pagCurr > 1);
      imgPrimo.ImageFile.FileName:=IfThen(imgPrimo.Enabled,filebtnPrimo,filebtnPrimoDisab);
      imgPrec.Enabled:=(recDa - grdAnagrafe.RowLimit >= 0);
      imgPrec.ImageFile.FileName:=IfThen(imgPrec.Enabled,filebtnPrec,filebtnPrecDisab);
      imgSucc.Enabled:=(recDa + grdAnagrafe.RowLimit <= recTot);
      imgSucc.ImageFile.FileName:=IfThen(imgSucc.Enabled,filebtnSucc,filebtnSuccDisab);
      imgUltimo.Enabled:=(recA < recTot);
      imgUltimo.ImageFile.FileName:=IfThen(imgUltimo.Enabled,filebtnUltimo,filebtnUltimoDisab);
    end;
  end;
  lblNumRecord.Css:='contatore' + IfThen(pagTot > 1,'_pad');
end;

procedure TW002FAnagrafeElenco.imgPaginaPrimaClick(Sender: TObject);
begin
  WR000DM.cdsAnagrafe.First;
  if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
     WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
  begin
    WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
    WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
    WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
  end;
  NumRec:=1;
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.imgPaginaSuccClick(Sender: TObject);
begin
  if (NumRec + grdAnagrafe.RowLimit) <= WR000DM.cdsAnagrafe.RecordCount then
  begin
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    WR000DM.cdsAnagrafe.MoveBy(grdAnagrafe.RowLimit);
    NumRec:=WR000DM.cdsAnagrafe.RecNo;
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
    begin
      WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
      WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    end;
  end;
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.imgPaginaPrecClick(Sender: TObject);
begin
  if NumRec > 1 then
  begin
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    WR000DM.cdsAnagrafe.MoveBy(- grdAnagrafe.RowLimit);
    NumRec:=WR000DM.cdsAnagrafe.RecNo;
    if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
       WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
    begin
      WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
      WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
      WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
    end;
  end;
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.imgPaginaUltimaClick(Sender: TObject);
begin
  WR000DM.cdsAnagrafe.Last;
  if WR000DM.cdsAnagrafe.RecNo mod grdAnagrafe.RowLimit = 0 then
    WR000DM.cdsAnagrafe.MoveBy(-(grdAnagrafe.RowLimit - 1))
  else
    WR000DM.cdsAnagrafe.MoveBy(-(WR000DM.cdsAnagrafe.RecNo mod grdAnagrafe.RowLimit) + 1);
  if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
     WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
  begin
    WR000DM.cdsAnagrafe.FreeBookmark(WR000DM.BookmarkIP);
    WR000DM.BookmarkIP:=WR000DM.cdsAnagrafe.GetBookmark;
  end;
  NumRec:=WR000DM.cdsAnagrafe.RecNo;
  if {$IFNDEF VER185}(Length(WR000DM.BookmarkIP) > 0) and{$ENDIF}
     WR000DM.cdsAnagrafe.BookmarkValid(WR000DM.BookmarkIP) then
    WR000DM.cdsAnagrafe.GotoBookmark(WR000DM.BookmarkIP);
  AggiornaContatore;
  ParametriForm.Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TW002FAnagrafeElenco.grdAnagrafeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  S:String;
  v: Variant;
begin
  if ARow = 0 then
  begin
    // intestazione
    v:=WR000DM.cdsI010.Lookup('NOME_CAMPO',ACell.Text,'CAPTION_LAYOUT;NOME_LOGICO');
    if (not VarIsNull(v)) then
    begin
      if not VarIsNull(v[0]) then
        S:=VarToStr(v[0])
      else
        S:=VarToStr(v[1]);
      if S <> '' then
        ACell.Text:=S;
    end
  end;
  RenderCell(ACell,ARow,AColumn,True,True);
end;

procedure TW002FAnagrafeElenco.btnApplicaDataClick(Sender: TObject);
begin
  inherited;

  // controlli su data indicata
  if Trim(edtDataLavoro.Text) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_INSERIRE_DATALAVORO));
    ActiveControl:=edtDataLavoro;
    Exit;
  end;
  if not TryStrToDate(edtDataLavoro.Text,Parametri.DataLavoro) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_ERR_DATALAVORO_NON_VALIDA));
    ActiveControl:=edtDataLavoro;
    Exit;
  end;

  // verifica se è necessario aggiornare la vista anagrafica
  if R180VarToDateTime(WR000DM.selAnagrafe.GetVariable('DATALAVORO')) <> Parametri.DataLavoro then
  begin
    WR000DM.selAnagrafe.SetVariable('DATALAVORO',Parametri.DataLavoro);
    WR000DM.selAnagrafe.Open;
    UpdateVistaPersonale;

    // salva data di lavoro su tabella
    if WR000DM.TipoUtente = 'Supervisore' then
    begin
      with WR000DM.selT432 do
      try
        R180SetVariable(WR000DM.selT432,'UTENTE',Parametri.Operatore);
        Open;
        First;
        if Parametri.DataLavoro <> Date then
        begin
          Edit;
          FieldByName('UTENTE').AsString:=Parametri.Operatore;
          FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
          RegistraLog.SettaProprieta('M','T432_DATALAVORO','W002',WR000DM.selT432,True);
          RegistraLog.RegistraOperazione;
          Post;
        end
        else if not Eof then
          Delete;
        SessioneOracle.Commit;
        Close;
      except
        //on E: Exception do GGetWebApplicationThreadVar.ShowMessage(E.Message + ' (' + E.ClassName + ')');
      end;
    end;

    // distrugge tutte le form attive poiché la selezione anagrafica è cambiata
    WR000DM.History.FormReleaseAll;
  end;
end;

procedure TW002FAnagrafeElenco.chkDipendentiCessatiClick(Sender: TObject);
var
  LFiltroInServizio: String;
  LVarFiltroInServizio: String;
  LEsisteFiltro: Boolean;
begin
  // determina il filtro dipendenti in servizio
  LFiltroInServizio:=IfThen(Parametri.CampiRiferimento.C90_FiltroAnagrafeConsideraRichiesteCessati = 'S',FILTRO_IN_SERVIZIO_CON_RICHIESTE,FILTRO_IN_SERVIZIO);

  // applica il filtro dipendenti in servizio / cessati
  LVarFiltroInServizio:=IfThen(chkDipendentiCessati.Checked,'',LFiltroInServizio);
  WR000DM.selAnagrafe.SetVariable('FILTRO_IN_SERVIZIO',LVarFiltroInServizio);
  WR000DM.selAnagrafe.Open;
  UpdateVistaPersonale;

  // determina se il filtro dipendenti in servizio è presente nella property FiltroRicerca
  LEsisteFiltro:=WR000DM.FiltroRicerca.IndexOf(LFiltroInServizio) >= 0;

  // aggiorna variabile FiltroRicerca
  if chkDipendentiCessati.Checked and LEsisteFiltro then
  begin
    // se si richiedono i cessati, rimuove il filtro in servizio
    WR000DM.FiltroRicerca:=WR000DM.FiltroRicerca.Replace(LFiltroInServizio,'',[rfReplaceAll,rfIgnoreCase]);
  end
  else if (not chkDipendentiCessati.Checked) and (not LEsisteFiltro) then
  begin
    // se si escludono i cessati, include il filtro in servizio
    WR000DM.FiltroRicerca:=LFiltroInServizio + WR000DM.FiltroRicerca;
  end;

  // distrugge tutte le form attive poiché la selezione anagrafica è cambiata
  WR000DM.History.FormReleaseAll;
end;

procedure TW002FAnagrafeElenco.btnCancellaRicercaClick(Sender: TObject);
begin
  inherited;
  if Trim(edtNomeRicerca.Text) = '' then  //Lorena 15/06/2006
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_SELEZIONE_CANCELLARE));
    exit;
  end;

  WR000DM.seldistT003.Close; //Lorena 12/06/2006
  WR000DM.seldistT003.Open; //Lorena 12/06/2006
  if WR000DM.seldistT003.SearchRecord('NOME',edtNomeRicerca.Text,[srFromBeginning]) then
  begin
    WR000DM.delT003.SetVariable('NOME',edtNomeRicerca.Text);
    WR000DM.delT003.Execute;
    WR000DM.delT003.Session.Commit;
    WR000DM.RefreshT003:=True;
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_SELEZIONE_CANCELLATA));
  end
  else
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W002_MSG_IMPOSSIB_CANC_SELEZIONE));
  WR000DM.seldistT003.Close; //Lorena 12/06/2006
end;

end.
