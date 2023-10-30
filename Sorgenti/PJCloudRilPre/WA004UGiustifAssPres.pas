unit WA004UGiustifAssPres;

interface

uses
  medpIWC700NavigatorBar, A004UGiustifAssPresMW, WA004URecapitoVisFiscaliFM,
  WR100UBase, WC021URiepilogoAssenzeFM, A087UImpAttestatiMalMW,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWApplication,
  Oracle, OracleData, Windows, Messages, SysUtils, Variants, Classes,
  Controls, Forms, Math, StrUtils, DB, IWCompExtCtrls,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompCheckbox, meIWCheckBox,IWAdvRadioGroup,
  meTIWAdvRadioGroup, meIWImageFile, medpIWImageButton, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWRegion,
  meIWRegion, Menus, ActnList, medpIWMultiColumnComboBox, medpIWMessageDlg,
  IWWebGrid, IWHTMLContainer, IWHTML40Container,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWCompButton,
  meIWButton, medpIWStatusBar, IWCompJQueryWidget, IWCompMemo, System.Actions;

type
  TWA004FGiustifAssPres = class(TWR100FBase)
    WA004GestRG: TmeIWRegion;
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    lblNumGG: TmeIWLabel;
    edtNumGG: TmeIWEdit;
    chkNuovoPeriodo: TmeIWCheckBox;
    rgpTipoGiust: TmeTIWAdvRadioGroup;
    lblDaOre: TmeIWLabel;
    edtDaOre: TmeIWEdit;
    lblAOre: TmeIWLabel;
    edtAOre: TmeIWEdit;
    lblNote: TmeIWLabel;
    edtNote: TmeIWEdit;
    imgRecapitoAlternativo: TmedpIWImageButton;
    imgInserisci: TmedpIWImageButton;
    imgCancella: TmedpIWImageButton;
    imgAnomalie: TmedpIWImageButton;
    WA004VisualizzaRG: TmeIWRegion;
    grdGiustificativi: TmedpIWDBGrid;
    tpGest: TIWTemplateProcessorHTML;
    tpVisualizza: TIWTemplateProcessorHTML;
    pmnCausale: TPopupMenu;
    mnuCompetenzeResidui: TMenuItem;
    pmnTabella1: TPopupMenu;
    mnuRefresh: TMenuItem;
    mnuCopiaImpostazioni: TMenuItem;
    mnuCompetenzeResiduiTab: TMenuItem;
    actlstWA004NavigatorBar: TActionList;
    actImpostaStampante: TAction;
    actStampa: TAction;
    actCaricaGiustRichiesti: TAction;
    grdWA004NavigatorBar: TmeIWGrid;
    rgpCausali: TmeTIWAdvRadioGroup;
    rgpGestione: TmeTIWAdvRadioGroup;
    cmbCausale: TMedpIWMultiColumnComboBox;
    cmbFamiliari: TMedpIWMultiColumnComboBox;
    lblDescCausale: TmeIWLabel;
    lnkCausale: TmeIWLink;
    lnkFamiliari: TmeIWLink;
    btnFiltroCausaleSelezionata: TmedpIWImageButton;
    jqRiepAssenze: TIWJQueryWidget;
    pmnTabella2: TPopupMenu;
    mnuRefreshTabella: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure mnuCompetenzeResiduiClick(Sender: TObject);
    procedure edtNumGGAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDaDataAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtADataAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgRecapitoAlternativoClick(Sender: TObject);
    procedure rgpTipoGiustAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure actCaricaGiustRichiestiExecute(Sender: TObject);
    procedure mnuCopiaImpostazioniClick(Sender: TObject);
    procedure mnuCompetenzeResiduiTabClick(Sender: TObject);
    procedure rgpGestioneClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
    procedure rgpCausaliClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbFamiliariAsyncEnter(Sender: TObject; EventParams: TStringList);
    procedure grdGiustificativiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure mnuRefreshClick(Sender: TObject);
    procedure lnkCausaleClick(Sender: TObject);
    procedure lnkFamiliariClick(Sender: TObject);
    procedure btnFiltroCausaleSelezionataClick(Sender: TObject);
    procedure grdGiustificativiAfterCaricaCDS(Sender: TObject;
      DBG_ROWID: string);
  private
    WA004RecapitoFM: TWA004FRecapitoVisFiscaliFM;
    Assenza: Boolean;
    DataNasIniziale: TDateTime;
    procedure AbilitaRecapitoVisiteFiscali(Abilitato: Boolean);
    function  GetVisitaFiscale: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function  GetRecapitoAbilitato: Boolean;
    procedure AbilitaTipoFruizione;
    procedure AbilitaNote;
    procedure CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; _onClick: TprocSender);
    procedure imgNavBarClick(Sender: TObject);
    procedure RefreshSelSG101; // spostato da datamodule
    procedure PopolaComboCausale(PDataSet: TOracleDataSet);
    procedure PopolaComboFamiliari(PDataSource: TDataSource);
    procedure VisualizzaRiepilogo;
    procedure ElaboraInsCan(Sender: TObject);
    procedure INPS_TO_CSI_InsCanc;
  protected
    procedure RefreshPage; override;
  public
    A004MW: TA004FGiustifAssPresMW;
    function  InizializzaAccesso: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

function TWA004FGiustifAssPres.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  DataStr: String;
  Tipo: String;
  Ore1Str: String;
  Ore2Str: String;
  Causale: String;
  DataNasStr: String;
  CartelStr: String;
  GestioneSingolaStr: String;
  EseguiCommitStr: String;
  Data: TDateTime;
  DataNas: TDateTime;
  Cartel: Boolean;
begin
  // 1. lettura parametri

  // progressivo
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  // data
  Data:=DATE_NULL;
  DataStr:=GetParam('DATA');
  if DataStr <> '' then
  begin
    if not TryStrToDate(DataStr,Data) then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DATA_NON_VALIDA),[DataStr]));
  end;

  // tipo giustificativo
  Tipo:=GetParam('TIPO');

  // ore1, ore2
  Ore1Str:=GetParam('ORE1');
  Ore2Str:=GetParam('ORE2');

  // causale
  Causale:=GetParam('CAUSALE');

  // data di nascita familiare di riferimento
  DataNas:=DATE_NULL;
  DataNasStr:=GetParam('DATANAS');
  if DataNasStr <> '' then
  begin
    (*A023 - BugFix: Errore aprendo la maschera da cartellino interattivo in caso di causale con data nascita impostata
      La data nascita può avere anche l'ora.
      Tolta raise exception e sostituita con msgbox perchè l'eccezione non viene visualizzata a video (la finestra si chiude)
      Versione: 9.5(0)
      Utente: VENEZIA_IUAV Chiamata: 92685

    if not TryStrToDate(DataNasStr,DataNas) then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DATA_NON_VALIDA),[DataNasStr]));
    *)
    //VENEZIA_IUAV Chiamata: 92685 - Inizio
    if not TryStrToDate(DataNasStr,DataNas) then
    begin
      if not TryStrToDateTime(DataNasStr,DataNas) then
      begin
        MsgBox.WebMessageDlg(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_DATA_NON_VALIDA),[DataNasStr]),mtError,[mbOk],nil,'');
        Result:=False;
        Exit;
      end;
    end;
    // VENEZIA_IUAV Chiamata: 92685 - Fine
  end;

  // da cartellino
  CartelStr:=GetParam('CARTEL');
  Cartel:=UpperCase(CartelStr) = 'S';

  // gestione singola (S / non impostata, N = inserimento massivo) - default S
  GestioneSingolaStr:=GetParam('GESTIONESINGOLA');
  if GestioneSingolaStr = '' then
    GestioneSingolaStr:='S';
  A004MW.GestioneSingolaDM:=UpperCase(GestioneSingolaStr) = 'S';

  // 2. gestione parametri
  if Cartel then
  begin
    edtDaData.Text:=DateToStr(Data);
    edtAData.Text:=DateToStr(Data);
    if A004MW.Q275.Locate('Codice',Causale,[]) then
      rgpCausali.ItemIndex:=0
    else
      rgpCausali.ItemIndex:=1;
    if (Trim(Causale) <> '') and //AOSTA_REGIONE Chiamata:171548: la causale deve essere impostata solo se presente nei dataset altrimenti bypassa il FiltroDizionario
       (((rgpCausali.ItemIndex = 0) and A004MW.Q275.Locate('Codice',Causale,[])) or
        ((rgpCausali.ItemIndex = 1) and A004MW.Q265.Locate('Codice',Causale,[])))
       then
    begin
      cmbCausale.Text:=Causale;
      //Utente: VENEZIA_IUAV Chiamata: 91780; rgpTipoGiustificativo non impostato correttamente
      cmbCausaleAsyncChange(cmbCausale,nil,0,'');
    end;
    DataNasIniziale:=DataNas;
    with rgpTipoGiust do
    begin
      if Tipo = 'I' then
        ItemIndex:=0;
      if Tipo = 'M' then
        ItemIndex:=1;
      if Tipo = 'N' then
      begin
        if Items.Count = 4 then
          ItemIndex:=2
        else
          ItemIndex:=0;
      end;
      if Tipo = 'D' then
      begin
        if Items.Count = 4 then
          ItemIndex:=3
        else
          ItemIndex:=1;
      end;
    end;
    //rgpTipoGiustAsyncClick(rgpTipoGiust,nil); //*** verificare
      AbilitaTipoFruizione;
    if Ore1Str <> '' then
      edtDaOre.Text:=Ore1Str;
    if Ore2Str <> '' then
      edtAOre.Text:=Ore2Str;
  end
  else if Data <> DATE_NULL then
  begin
    edtDaData.Text:=DateToStr(Data);
    edtAData.Text:=DateToStr(Data);
  end
  else
  begin
    // nessun parametro impostato
    edtDaData.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
    edtAData.Text:=edtDaData.Text; // commessa MAN/08 SVILUPPO#56 - riesame del 06.09.2013
  end;

  // esegui commit - default 'S'
  EseguiCommitStr:=GetParam('ESEGUICOMMIT');
  if EseguiCommitStr = '' then
    EseguiCommitStr:='S';
  A004MW.EseguiCommit:=UpperCase(EseguiCommitStr) = 'S';

  rgpGestione.Enabled:=A004MW.GestioneSingolaDM;
  WA004VisualizzaRG.Visible:=A004MW.GestioneSingolaDM;
  imgCancella.Visible:=A004MW.GestioneSingolaDM;

  mnuCompetenzeResidui.Visible:=A004MW.GestioneSingolaDM;
  //***ProgressBar.Visible:=True;
  actCaricaGiustRichiesti.Visible:=not A004MW.GestioneSingolaDM; //***CaricaAssenze.Visible:=not GestioneSingola;
  lnkFamiliari.Visible:=A004MW.GestioneSingolaDM;
  cmbFamiliari.Visible:=A004MW.GestioneSingolaDM;

  if (rgpCausali.ItemIndex = 1) and (DataNasIniziale > 0) then
    cmbFamiliari.Text:=DateTimeToStr(DataNasIniziale);
  if Self.Visible then
    cmbCausale.SetFocus;
  A004MW.RecapitoAlternativo.Abilitato:=GetRecapitoAbilitato; //***
  AbilitaRecapitoVisiteFiscali(A004MW.RecapitoAlternativo.Abilitato); //***
  AbilitaTipoFruizione;

  GetParametriFunzione;

  Result:=True;
end;

procedure TWA004FGiustifAssPres.IWAppFormCreate(Sender: TObject);
var
  Code: String;
begin
  inherited;

  A004MW:=TA004FGiustifAssPresMW.Create(Self);
  A004MW.Chiamante:='WA004';
  A004MW.GestioneSingolaDM:=True;
  AttivaGestioneC700;
  A004MW.SelAnagrafe:=grdC700.selAnagrafe;

  //*** verificare.ini
  // impostazioni componenti data aware
  PopolaComboCausale(A004MW.Q265);
  PopolaComboFamiliari(A004MW.dsrSG101);
  //*** verificare.fine

  // tabella richieste
  grdGiustificativi.medpPaginazione:=False;
  grdGiustificativi.medpTestoNoRecord:='Nessun giustificativo';
  grdGiustificativi.medpRowSelect:=False;
  // forza cambio progressivo per aggiornare visualizzazione
  WC700CambioProgressivo(nil);

  // inizializzazioni form
  Assenza:=True;
  lnkCausale.Enabled:=A000GetInibizioni('Tag','105') <> 'N';
  lnkCausale.Hint:='Accesso alle causali di assenza' + IfThen(not lnkCausale.Enabled,' (funzione non abilitata)');
  imgInserisci.Enabled:=not SolaLettura;
  imgCancella.Enabled:=not SolaLettura;
  imgAnomalie.Enabled:=False;
  lblDescCausale.Caption:='';
  lblDaOre.Enabled:=False;
  edtDaOre.Enabled:=False;
  lblAOre.Enabled:=False;
  edtAOre.Enabled:=False;

  // navigator bar azioni
  actCaricaGiustRichiesti.Enabled:=A000GetInibizioni('Tag','96') <> 'N';
  actCaricaGiustRichiesti.Hint:=actCaricaGiustRichiesti.Hint + IfThen(not actCaricaGiustRichiesti.Enabled,' (funzione non abilitata)');
  CreaNavigatorBar(actlstWA004NavigatorBar,grdWA004NavigatorBar,imgNavBarClick);
end;

procedure TWA004FGiustifAssPres.INPS_TO_CSI_InsCanc;
begin
  imgCancella.Enabled:=not (A004MW.A087ElencoCausali as TA087InfoCertificati).EsisteCausale(VarToStr(CmbCausale.Text)) or
                     (not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
  imgInserisci.Enabled:=not (A004MW.A087ElencoCausali as TA087InfoCertificati).EsisteCausale(VarToStr(CmbCausale.Text)) or
                     (not Parametri.ModuloInstallato['TORINO_CSI_PRV']);
  imgInserisci.Enabled:=imgInserisci.Enabled and (not SolaLettura);
  imgCancella.Enabled:=imgCancella.Enabled and (not SolaLettura);
end;

procedure TWA004FGiustifAssPres.IWAppFormRender(Sender: TObject);
begin
  // PopupMenu2Popup
  // determina
  with A004MW do
  begin
    mnuCompetenzeResiduiTab.Visible:=(dsrVisualizza.DataSet = Q040B) and
                                     (Q040B.Active) and
                                     (Q040B.RecordCount > 0) and
                                     (VarToStr(Q265.Lookup('CODICE',Q040B.FieldByName('CAUSALE').AsString,'DESCRIZIONE')) <> '');
  end;
  // familiari
  lnkFamiliari.Enabled:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger > 0; //***C700Progressivo > 0;
  INPS_TO_CSI_InsCanc;
  inherited;
end;

procedure TWA004FGiustifAssPres.RefreshPage;
var
  BM: TBookmark;
begin
  inherited;

  // aggiornamento causali di presenza
  with A004MW.Q275 do
  begin
    if Active then
    begin
      BM:=GetBookmark;
      try
        //DisableControls;
        Refresh;
        //EnableControls;
        if BookmarkValid(BM) then
          GotoBookmark(BM);
      finally
        FreeBookmark(BM);
      end;
    end;
  end;

  // aggiornamento causali di assenza
  with A004MW.Q265 do
  begin
    if Active then
    begin
      BM:=GetBookmark;
      try
        //DisableControls;
        Refresh;
        //EnableControls;
        if BookmarkValid(BM) then
          GotoBookmark(BM);
      finally
        FreeBookmark(BM);
      end;
    end;
  end;

  // aggiornamento dataset familiari
  with A004MW.dsrSG101.DataSet do
  begin
    //DisableControls;
    if Active then
      Refresh;
    //EnableControls;
  end;
  //
end;

procedure TWA004FGiustifAssPres.IWAppFormDestroy(Sender: TObject);
begin
  C004DM.Cancella001;
  PutParametriFunzione;

  A004MW.SessioneOracleA004.Commit; //***
  FreeAndNil(A004MW);

  //***frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TWA004FGiustifAssPres.GetParametriFunzione;
begin
  // verificare
  A004MW.AnomalieInterattive:=C004DM.GetParametro('ANOMALIE_INTERATTIVE','N') = 'S';
end;

procedure TWA004FGiustifAssPres.PutParametriFunzione;
begin
  // verificare
  C004DM.PutParametro('ANOMALIE_INTERATTIVE',IfThen(A004MW.AnomalieInterattive,'S','N'));
end;

procedure TWA004FGiustifAssPres.CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; _onClick: TprocSender);
// procedure per collegare una actionlist ad una tabella
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdNavBar.RowCount:=1;
  grdNavBar.ColumnCount:=actlstNavBar.ActionCount;

  // prima categoria
  if actlstNavBar.ActionCount > 0 then
    PrecCategory:=(actlstNavBar.Actions[0] as TAction).Category;

  k:=0;
  for i:=0 to actlstNavBar.ActionCount - 1 do
  begin
    if PrecCategory <> (actlstNavBar.Actions[i] as TAction).Category  then
    begin
      grdNavBar.Cell[0,k].Css:='x';
      grdNavBar.Cell[0,k].Text:='';
      k:=k + 1;
      grdNavBar.ColumnCount:=grdNavBar.ColumnCount + 1;
      PrecCategory:=(actlstNavBar.Actions[i] as TAction).Category;
    end;

    grdNavBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
    with (grdNavBar.Cell[0,k].Control as TmeIWImageFile) do
    begin
      Name:=C190CreaNomeComponente((actlstNavBar.Actions[i] as TAction).Name,Self);
      OnClick:=_onClick;
      Tag:=i;
    end;

    grdNavBar.Cell[0,k].Css:='x';
    grdNavBar.Cell[0,k].Text:='';

    k:=k + 1;
  end;
  AggiornaToolBar(grdNavBar,actlstNavBar);
end;

// verificare, specie x quanto riguarda la oraclesession
procedure TWA004FGiustifAssPres.imgAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    Params:=Format('AZIENDA=%s%sOPERATORE=%s%sMASCHERA=%s%sID=%d%sTIPO=A,B',
                   [Parametri.Azienda,ParamDelimiter,
                    Parametri.Operatore,ParamDelimiter,
                    medpCodiceForm,ParamDelimiter,
                    RegistraMsg.ID,ParamDelimiter]);
    AccediForm(201,Params,True);
  end;
end;

procedure TWA004FGiustifAssPres.imgInserisciClick(Sender: TObject);
begin
  StartThreadElaborazione(ElaboraInsCan,Sender);
end;

procedure TWA004FGiustifAssPres.ElaboraInsCan(Sender: TObject);
// Controlla che ci siano tutti i dati richiesti per l'inserimento/cancellazione
var
  Msg: String;
  NGiorni: Integer;

  procedure InizializzaDati;
  begin
    A004MW.Var_Gestione:=rgpGestione.ItemIndex;
    A004MW.Var_TipoGiust:=rgpTipoGiust.ItemIndex;
    A004MW.Var_TipoGiust_Count:=rgpTipoGiust.Items.Count;
    A004MW.Var_DaOre:=edtDaOre.Text;
    A004MW.Var_AOre:=edtAOre.Text;
    A004MW.Var_DaData:=edtDaData.Text;
    A004MW.Var_AData:=edtAData.Text;
    A004MW.Var_NumGG:=StrToIntDef(edtNumGG.Text,0);
    A004MW.Var_Causale:=cmbCausale.Text;
    A004MW.Var_TipoCaus:=rgpCausali.ItemIndex;
    if A004MW.GestioneSingolaDM then
      A004MW.Var_Familiari:=StringReplace(CmbFamiliari.Text,Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll])
    else
      A004MW.Var_Familiari:='';
    A004MW.Var_Note:=IfThen(edtNote.Enabled,edtNote.Text,'');
    A004MW.Var_Progressivo:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

    if A004MW.GestioneSingolaDM or grdC700.selAnagrafe.Bof then
    begin
      try
        A004MW.Controlli(True,Sender = imgInserisci);
      except
        on E: Exception do
        begin
          if not (E is EAbort) then
            raise;//R180MessageBox(E.Message,ESCLAMA);
          Exit;
        end;
      end;
      edtDaOre.Text:=A004MW.Var_DaOre;
      edtAOre.Text:=A004MW.Var_AOre;
    end;
    // fine controlli

    // imposta variabile Giustif
    A004MW.Giustif.Inserimento:=Sender = imgInserisci;
    case rgpTipoGiust.ItemIndex of
      0:A004MW.Giustif.Modo:=R180CarattereDef(IfThen(rgpCausali.ItemIndex = 0,'N','I'));
      1:A004MW.Giustif.Modo:=R180CarattereDef(IfThen(rgpCausali.ItemIndex = 0,'D','M'));
      2:A004MW.Giustif.Modo:='N';
      3:A004MW.Giustif.Modo:='D';
    end;
    A004MW.Giustif.Causale:=cmbCausale.Text;
    A004MW.Giustif.DaOre:=edtDaOre.Text;
    A004MW.Giustif.AOre:=edtAOre.Text;
  end;

  procedure GestioneGiustificativo;
  begin
    A004MW.chkNuovoPeriodo:=chkNuovoPeriodo.Checked;

    // valuta tipo gestione (dipendenti / coniugi esterni)
    if rgpGestione.ItemIndex = 0 then
    begin
      // gestione dipendenti
      if Sender = imgInserisci then
      begin
        // inserimento giustificativo
        A004MW.InserisciGiustif(True);
      end
      else
      begin
        // cancellazione giustificativo
        A004MW.CancellaGiustif(True);
      end;
      if not A004MW.GestioneSingolaDM then
        A004MW.DataInizio:=StrToDate(A004MW.Var_DaData); //Alberto 09/04/2009: reimposto DataInizio all'originale, in quanto può essere variata per via del parametro COPRI_GGNONLAV
    end
    else
    begin
      // gestione coniugi esterni
      if Sender = imgInserisci then
        A004MW.InserisciGiustFamiliari
      else
        A004MW.CancellaGiustFamiliari;
    end;
  end;
begin
  imgAnomalie.Enabled:=False;

  // controlla selezione dipendenti
  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    chkNuovoPeriodo.Checked:=False;
    R180MessageBox(A000TraduzioneStringhe(A000MSG_ERR_NO_DIP),ESCLAMA);
    Exit;
  end;

  A004MW.selDatiBloccati.Close;
  RegistraMsg.IniziaMessaggio(medpCodiceForm);
  if not A004MW.GestioneSingolaDM then
    grdC700.selAnagrafe.First;
  InizializzaDati;

  // richiede conferma operazione
  NGiorni:=StrToIntDef(edtNumGG.Text,0);
  if NGiorni = 0 then
    Msg:=Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_CONFERMA_DAL_AL),
                [IfThen(Sender = imgInserisci,'l''inserimento','la cancellazione'),
                 A004MW.Var_DaData,A004MW.Var_AData])
  else
    Msg:=Format(A000TraduzioneStringhe(A000MSG_A004_DLG_FMT_CONFERMA_DAL_NUMGG),
                [IfThen(Sender = imgInserisci,'l''inserimento','la cancellazione'),
                 A004MW.Var_DaData,NGiorni]);
  if R180MessageBox(Msg,DOMANDA) = mrNo then
    Exit;

  // elaborazione
  //***Screen.Cursor:=crHourGlass;
  //***ProgressBar.Position:=0;
  if A004MW.GestioneSingolaDM then
  begin
    // progressbar legata al numero di giorni dell'operazione
    //ProgressBar.Max:=Trunc(DataFine - DataInizio) + 1;
    GestioneGiustificativo;
  end
  else
  begin
    // progressbar legata ai dipendenti
    //***ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    while not grdC700.selAnagrafe.Eof do
    begin
      // aggiorna progressbar
      //***ProgressBar.StepBy(1);
      //***ProgressBar.Repaint;
      //Reinizializza i dati di inserimento che possono modificarsi da un dipendente all'altro dalla gestione della catena di causali
      InizializzaDati;
      // elabora dipendente
      GestioneGiustificativo;
      grdC700.selAnagrafe.Next;
    end;
    //***ProgressBar.Position:=0;
    A004MW.SessioneOracleA004.Commit;
  end;

  // impostazione parametri middleware prima di chiamata a procedura
  A004MW.Var_Gestione:=rgpGestione.ItemIndex;
  A004MW.Var_FiltroCausaleSelezionata:=btnFiltroCausaleSelezionata.Down;
  A004MW.Var_Causale:=cmbCausale.Text;
  A004MW.SettaGiustificativiVisualizzati;
  grdGiustificativi.medpCaricaCDS; // è necessario ricaricare la grid di visualizzazione

  //Screen.Cursor:=crDefault;
  Self.chkNuovoPeriodo.Checked:=False;
  // gestione anomalie
  imgAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    if R180MessageBox(A000TraduzioneStringhe(A000MSG_DLG_ELAB_ANOMALIE_VIS),DOMANDA) = mrYes then
    begin
      imgAnomalieClick(nil);
    end;
  end;
end;

procedure TWA004FGiustifAssPres.imgNavBarClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  (actlstWA004NavigatorBar.Actions[(Sender as TmeIWImageFile).Tag] as TAction).Execute;
end;

// gestione eventi interfaccia
procedure TWA004FGiustifAssPres.rgpGestioneClick(Sender: TObject);
begin
  mnuCompetenzeResidui.Visible:=A004MW.GestioneSingolaDM and (rgpGestione.ItemIndex = 0) and (rgpCausali.ItemIndex = 1);
  mnuCopiaImpostazioni.Visible:=rgpGestione.ItemIndex = 0;
  rgpCausali.Enabled:=rgpGestione.ItemIndex = 0;

  // per i coniugi esterni è prevista la sola gestione delle assenze
  if rgpGestione.ItemIndex = 1 then
  begin
    rgpCausali.ItemIndex:=1;
    // a differenza di win, non scatta l'evento onClick -> occorre forzarlo
    rgpCausaliClick(rgpCausali);
  end;

  A004MW.RecapitoAlternativo.Abilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(A004MW.RecapitoAlternativo.Abilitato);
  AbilitaTipoFruizione;

  WC700CambioProgressivo(nil); //***CambiaProgressivo;
end;

procedure TWA004FGiustifAssPres.rgpTipoGiustAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  edtDaOre.Enabled:=rgpTipoGiust.ItemIndex > (rgpTipoGiust.Items.Count - 4);
  edtAOre.Enabled:=rgpTipoGiust.ItemIndex > (rgpTipoGiust.Items.Count - 2);
  lblDaOre.Enabled:=edtDaOre.Enabled;
  lblAOre.Enabled:=edtAOre.Enabled;
  if (rgpTipoGiust.ItemIndex = 1) and (rgpCausali.ItemIndex = 1) then
    edtDaOre.Text:='';
  if Self.Visible then
  begin
    A004MW.RecapitoAlternativo.Abilitato:=GetRecapitoAbilitato;
    AbilitaRecapitoVisiteFiscali(A004MW.RecapitoAlternativo.Abilitato);
    //AbilitaTipoFruizione;
  end;
end;

procedure TWA004FGiustifAssPres.edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RefreshSelSG101;
  lblDescCausale.Caption:=IfThen(cmbCausale.Text <> '',lblDescCausale.Caption);
end;

procedure TWA004FGiustifAssPres.edtDaDataAsyncExit(Sender: TObject; EventParams: TStringList);
// Se A Data è vuota assegno il valore di Da Data}
begin
  if edtAData.Text = '' then
    edtAData.Text:=edtDaData.Text;
end;

procedure TWA004FGiustifAssPres.edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  edtNumGG.Text:='0';
end;

procedure TWA004FGiustifAssPres.edtADataAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  edtAdata.Text:=edtDaData.Text;
end;

procedure TWA004FGiustifAssPres.edtNumGGAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  edtAData.OnAsyncChange:=nil;
  edtAData.Clear;
  edtAData.OnAsyncChange:=edtADataAsyncChange;
end;

procedure TWA004FGiustifAssPres.rgpCausaliClick(Sender: TObject);
// Attivo le causali di assenza o presenza a seconda della selezione
// NOTA: vedere se async utilizzabile: non aggiorna radiogroup -> usare invalidate
//       (inoltre fa casini con i dblookup)
begin
  if (rgpCausali.ItemIndex = 0) and (Assenza) then
  begin
    // causali di presenza
    rgpTipoGiust.Items.Delete(0);
    rgpTipoGiust.Items.Delete(0);
    rgpTipoGiust.ItemIndex:=0;
    PopolaComboCausale(A004MW.Q275);
    Assenza:=False;
    //rgpTipoGiustAsyncClick(Sender,nil); //*** verificare
    lnkFamiliari.Enabled:=False;
    cmbFamiliari.Enabled:=False;
    lnkCausale.Enabled:=A000GetInibizioni('Tag','107') <> 'N';
    lnkCausale.Hint:='Accesso alle causali di presenza' + IfThen(not lnkCausale.Enabled,' (funzione non abilitata)');
  end;
  if (rgpCausali.ItemIndex = 1) and (not Assenza) then
  begin
    // causali di assenza
    rgpTipoGiust.Items.Insert(0,'Mezza giornata');
    rgpTipoGiust.Items.Insert(0,'Giornata');
    rgpTipoGiust.ItemIndex:=0;
    PopolaComboCausale(A004MW.Q265);
    Assenza:=True;
    //rgpTipoGiustAsyncClick(Sender,nil); //*** verificare
    lnkFamiliari.Enabled:=True;
    cmbFamiliari.Enabled:=True;
    lnkCausale.Enabled:=A000GetInibizioni('Tag','105') <> 'N';
    lnkCausale.Hint:='Accesso alle causali di assenza' + IfThen(not lnkCausale.Enabled,' (funzione non abilitata)');
  end;

  cmbCausale.Text:=''; //***
  cmbCausaleAsyncChange(cmbCausale,nil,-1,'');

  lblDescCausale.Caption:='';
  mnuCompetenzeResidui.Visible:=(A004MW.GestioneSingolaDM) and (rgpGestione.ItemIndex = 0) and (rgpCausali.ItemIndex = 1);
end;

procedure TWA004FGiustifAssPres.cmbCausaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  //*** forza posizionamento sul dataset di riferimento per il ListSource
  if rgpCausali.ItemIndex = 0 then
  begin
    // causali presenza
    A004MW.Q275.Locate('CODICE',cmbCausale.Text,[]);
    lblDescCausale.Caption:=A004MW.Q275.FieldByName('DESCRIZIONE').AsString;
  end
  else
  begin
    // causali assenza
    A004MW.Q265.Locate('CODICE',cmbCausale.Text,[]);
    lblDescCausale.Caption:=A004MW.Q265.FieldByName('DESCRIZIONE').AsString;
  end;

  RefreshSelSG101;
  lblDescCausale.Caption:=IfThen(cmbCausale.ItemIndex >= 0,lblDescCausale.Caption);
  btnFiltroCausaleSelezionata.Enabled:=cmbCausale.ItemIndex >=0; //***
  INPS_TO_CSI_InsCanc;

  A004MW.RecapitoAlternativo.Abilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(A004MW.RecapitoAlternativo.Abilitato);
  AbilitaTipoFruizione;
end;

procedure TWA004FGiustifAssPres.cmbFamiliariAsyncEnter(Sender: TObject;
  EventParams: TStringList);
begin
  RefreshSelSG101;
  //lblDescCausale.Visible:=cmbCausale.ItemIndex >= 0;
  lblDescCausale.Caption:=IfThen(cmbCausale.ItemIndex >= 0,lblDescCausale.Caption);
end;

//****************

procedure TWA004FGiustifAssPres.PopolaComboCausale(PDataSet: TOracleDataSet);
// popola la multicolumncombobox delle causali indicata con i valori
var
  BM: TBookmark;
begin
  // controllo dataset di riferimento
  if not Assigned(PDataSet) then
    raise Exception.Create('Dataset non indicato');

  cmbCausale.Items.Clear;
  if PDataSet.Active then
  begin
    // popola la combo delle causali
    BM:=PDataSet.GetBookmark;
    PDataSet.First;
    while not PDataSet.Eof do
    begin
      cmbCausale.AddRow(Format('%s;%s',[PDataSet.FieldByName('CODICE').AsString,
                                        PDataSet.FieldByName('DESCRIZIONE').AsString]));
      PDataSet.Next;
    end;
    if PDataSet.BookmarkValid(BM) then
      PDataSet.GotoBookmark(BM)
    else
      PDataSet.First;
  end;
end;

procedure TWA004FGiustifAssPres.PopolaComboFamiliari(PDataSource: TDataSource);
// popola la multicolumncombobox dei familiari indicata con i valori del dataset indicato
var
  BM: TBookmark;
  selValori: TOracleDataSet;
begin
  // controllo dataset di riferimento
  if not Assigned(PDataSource) then
    raise Exception.Create('Datasource non indicato');
  if not Assigned(PDataSource.DataSet) then
    raise Exception.Create('Dataset non associato');

  selValori:=(PDataSource.DataSet as TOracleDataSet);

  cmbFamiliari.Items.Clear;
  if (selValori.Active) and (selValori.RecordCount > 0) then
  begin
    // popola la combo dei familiari
    BM:=selValori.GetBookmark;
    selValori.First;
    while not selValori.Eof do
    begin
      cmbFamiliari.AddRow(Format('%s;%s',[selValori.FieldByName('DATA').AsString,
                                          selValori.FieldByName('NOME').AsString]));
      selValori.Next;
    end;
    if selValori.BookmarkValid(BM) then
      selValori.GotoBookmark(BM)
    else
      selValori.First;
  end;
end;

// spostato da datamodule
procedure TWA004FGiustifAssPres.RefreshSelSG101;
var DN:TDateTime;
begin
  if not A004MW.R600DtM1.selSG101.Active then
    exit;
  A004MW.Var_Causale:=cmbCausale.Text;
  A004MW.Var_DaData:=edtDaData.Text;
  if cmbFamiliari.Text = '' then
    DN:=0
  else
    DN:=StrToDateTime(cmbFamiliari.Text);

  with A004MW.R600DtM1.selSG101 do
  begin
    Filtered:=False;
    Filtered:=True;

    PopolaComboFamiliari(A004MW.dsrSG101);

    if RecordCount = 1 then
      cmbFamiliari.Text:=cmbFamiliari.Items[0].RowData[0]
    else if SearchRecord('DATA',DN,[srFromBeginning]) then
      cmbFamiliari.Text:=DateTimeToStr(DN)
    else
      cmbFamiliari.Text:='';
  end;
end;

// gestione anagrafica
procedure TWA004FGiustifAssPres.WC700CambioProgressivo(Sender: TObject);
var
  i,Prog: Integer;
begin
  // la prima chiamata a questa funzione è eseguita con A004MW.SelAnagrafe non ancora impostato
  if A004MW.SelAnagrafe = nil then
    Exit;

  with A004MW do
  begin
    Prog:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

    cmbFamiliari.ItemIndex:=-1;
    Q040.SetVariable('Progressivo',Prog);
    selT046.SetVariable('Progressivo',Prog);
    selT046.SetVariable('Data1',DataInizio);
    selT046.SetVariable('Data2',DataFine);
    selConiuge.SetVariable('Progressivo',Prog);
    R600DtM1.selSG101Causali.SetVariable('Progressivo',Prog);
    R600DtM1.selSG101Causali.Close;
    R600DtM1.selSG101Causali.Open;
    R600DtM1.selSG101.SetVariable('Progressivo',Prog);
    R600DtM1.selSG101.Close;
    R600DtM1.selSG101.OnFilterRecord:=selSG101FilterRecord;
    Var_Causale:=cmbCausale.Text;
    Var_DaData:=edtDaData.Text;
    R600DtM1.selSG101.Open;
    RefreshSelSG101;
    //lblDescCausale.Visible:=cmbCausale.ItemIndex >= 0;
    lblDescCausale.Caption:=IfThen(cmbCausale.ItemIndex >= 0,lblDescCausale.Caption);
    if rgpGestione.ItemIndex = 0 then
    begin
      // dataset di gestione
      Q040.Close;
      Q040.Open;
    end
    else
    begin
      // dataset di gestione
      selConiuge.Close;
      selConiuge.Open;
    end;

    // recapito alternativo
    RecapitoAlternativo.Clear; //***

    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=rgpGestione.ItemIndex;
    Var_FiltroCausaleSelezionata:=btnFiltroCausaleSelezionata.Down;
    Var_Causale:=cmbCausale.Text;

    // aggiorna visualizzazione
    SettaGiustificativiVisualizzati;

    grdGiustificativi.medpAttivaGrid(dsrVisualizza.Dataset,False,False,False);
    for i:=0 to A004MW.dsrVisualizza.Dataset.FieldCount - 1 do
      if A004MW.dsrVisualizza.Dataset.Fields[i].Visible then
        grdGiustificativi.medpPreparaComponenteGenerico('WR102-R',grdGiustificativi.medpIndexColonna(A004MW.dsrVisualizza.Dataset.Fields[i].FieldName),0,DBG_LBL,'','','','','');
    // forzato per gestione componenti WR102-R
    grdGiustificativi.medpCaricaCDS;
  end;
end;

// menu contestuale causali
procedure TWA004FGiustifAssPres.lnkCausaleClick(Sender: TObject);
// link di accesso alle causali di presenza / assenza
var
  S, Params:String;
begin
  S:=cmbCausale.Text;
  with A004MW do
  begin
    Params:=Format('CODICE=%s',[S]);
    case rgpCausali.ItemIndex of
      0:begin
        // accesso alle causali di presenza
        AccediForm(107,Params);
        end;
      1:begin
        // accesso alle causali di assenza
        AccediForm(105,Params);
        end;
    end;
  end;
  A004MW.RecapitoAlternativo.Abilitato:=GetRecapitoAbilitato;
  AbilitaRecapitoVisiteFiscali(A004MW.RecapitoAlternativo.Abilitato);
  AbilitaTipoFruizione;
end;

// accesso al frame di visualizzazione competenze / residui assenze
procedure TWA004FGiustifAssPres.mnuCompetenzeResiduiClick(Sender: TObject);
var
  DataRif, DataNasFam: TDateTime;
  WC021FM: TWC021FRiepilogoAssenzeFM;
begin
  // data di riferimento (data inizio / data odierna)
  if not TryStrToDate(edtDaData.Text,DataRif) then
    DataRif:=Date;

  // causale
  if cmbCausale.ItemIndex < 0 then
    raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_A004_MSG_NO_CAUSALE));

  // giustificativi legati a familiari
  if ((R180CarattereDef(A004MW.Q265.FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
      (R180CarattereDef(A004MW.Q265.FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D'])) and
      (cmbFamiliari.ItemIndex < 0) then
    raise ExceptionNoLog.Create(A000TraduzioneStringhe(A000MSG_A023_ERR_GIUST_NO_FAMILIARE));

  if cmbFamiliari.Text = '' then
    DataNasFam:=DATE_NULL
  else
    DataNasFam:=StrToDateTime(StringReplace(cmbFamiliari.Text,Parametri.TimeSeparatorDef,{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator,[rfReplaceAll]));

  WC021FM:=TWC021FRiepilogoAssenzeFM.Create(Self);
  WC021FM.VisualizzaFrame:=VisualizzaRiepilogo;
  WC021FM.CaricaDati(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,cmbCausale.Text,DataRif,DataNasFam);
end;

// accesso alla form di gestione familiari
procedure TWA004FGiustifAssPres.lnkFamiliariClick(Sender: TObject);
var
  Params: String;
begin
  Params:=Format('PROGRESSIVO=%d%sDATANAS=%s',
                 [grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                  ParamDelimiter,cmbFamiliari.Text]);
  AccediForm(303,Params,True);
  // aggiornamento dataset su refreshpage
end;

// menu contestuale tabella giustificativi
procedure TWA004FGiustifAssPres.mnuRefreshClick(Sender: TObject);
// aggiorna la tabella dei giustificativi in base al periodo attualmente specificato
begin
  with A004MW do
  begin
    // impostazione parametri middleware prima di chiamata a procedura
    if not TryStrToDate(edtDaData.Text,DataInizio) then
      DataInizio:=DATE_NULL;
    if not TryStrToDate(edtAData.Text,DataFine) then
      DataFine:=DATE_MAX;
    Var_Gestione:=rgpGestione.ItemIndex;
    Var_FiltroCausaleSelezionata:=btnFiltroCausaleSelezionata.Down;
    Var_Causale:=cmbCausale.Text;
    SettaGiustificativiVisualizzati;
    grdGiustificativi.medpCaricaCDS;
  end;
end;

procedure TWA004FGiustifAssPres.mnuCopiaImpostazioniClick(Sender: TObject);
// Copio le impostazioni del giustificativo selezionato in modo da poter
// effettuare gli inserimenti/cancellazioni più velocemente
var
  Tipo:Char;
  Comp: TComponent;
  PosizioneRec: Integer;
begin
 // determina il record su cui posizionarsi
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  if (Assigned(Comp)) and
     (Comp is TmeIWLabel) then
  begin
    PosizioneRec:=(Comp as TmeIWLabel).Tag;
  end
  else
  begin
    PosizioneRec:=1;
  end;

  with A004MW.Q040B do
  begin
    // posizionamento sul record corretto
    RecNo:=PosizioneRec;

    if FieldByName('D_TipoCausale').AsString = 'Pres' then
      rgpCausali.ItemIndex:=0
    else
      rgpCausali.ItemIndex:=1;
    cmbCausale.Text:=FieldByName('Causale').AsString;

    cmbFamiliari.Text:='';
    if FieldByName('DataNas').AsDateTime <> DATE_NULL then
    begin
      cmbFamiliari.Text:=DateTimeToStr(FieldByName('DataNas').AsDateTime);
      RefreshSelSG101;
    end;
    Tipo:=R180CarattereDef(FieldByName('TipoGiust').AsString,1,#0);
    if Tipo = 'I' then
      rgpTipoGiust.ItemIndex:=0;
    if Tipo = 'M' then
      rgpTipoGiust.ItemIndex:=1;
    if Tipo = 'N' then
    begin
      if rgpTipoGiust.Items.Count = 4 then
        rgpTipoGiust.ItemIndex:=2
      else
        rgpTipoGiust.ItemIndex:=0;
    end;
    if Tipo = 'D' then
    begin
      if rgpTipoGiust.Items.Count = 4 then
        rgpTipoGiust.ItemIndex:=3
      else
        rgpTipoGiust.ItemIndex:=1;
    end;
    rgpTipoGiust.Invalidate;
    rgpTipoGiustAsyncClick(rgpTipoGiust,nil);

    edtDaOre.Text:='';
    edtAOre.Text:='';
    if Tipo in ['N','D'] then
      edtDaOre.Text:=FormatDateTime('hh:mm',FieldByName('DaOre').AsDateTime);
    if Tipo = 'D' then
      edtAOre.Text:=FormatDateTime('hh:mm',FieldByName('AOre').AsDateTime);

    // forza change su causale
    cmbCausaleAsyncChange(cmbCausale,nil,0,'');

    // riposizionamento sul primo record
    First;
  end;
end;

procedure TWA004FGiustifAssPres.btnFiltroCausaleSelezionataClick(Sender: TObject);
begin
  // toggle stato down
  btnFiltroCausaleSelezionata.Down:=not btnFiltroCausaleSelezionata.Down;

  with A004MW do
  begin
    // impostazione parametri middleware prima di chiamata a procedura
    Var_Gestione:=rgpGestione.ItemIndex;
    Var_FiltroCausaleSelezionata:=btnFiltroCausaleSelezionata.Down;
    Var_Causale:=cmbCausale.Text;
    SettaGiustificativiVisualizzati;
    grdGiustificativi.medpCaricaCDS;
  end;
end;

procedure TWA004FGiustifAssPres.mnuCompetenzeResiduiTabClick(Sender: TObject);
// Visualizzazione Competenze/Residui della causale specificata
var
  Comp: TComponent;
  PosizioneRec: Integer;
  WC021FM: TWC021FRiepilogoAssenzeFM;
begin
  // determina il record su cui posizionarsi
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  if (Assigned(Comp)) and
     (Comp is TmeIWLabel) then
  begin
    PosizioneRec:=(Comp as TmeIWLabel).Tag;
  end
  else
  begin
    PosizioneRec:=1;
  end;

  with A004MW do
  begin
    // posizionamento sul record corretto
    Q040B.RecNo:=PosizioneRec;

    if ((R180CarattereDef(VarToStr(Q265.Lookup('CODICE',Q040B.FieldByName('CAUSALE').AsString,'CUMULO_FAMILIARI')),1,'N') in ['S','D']) or
        (R180CarattereDef(VarToStr(Q265.Lookup('CODICE',Q040B.FieldByName('CAUSALE').AsString,'FRUIZIONE_FAMILIARI')),1,'N') in ['S','D']))
    and (Q040B.FieldByName('DATANAS').IsNull) then
      raise Exception.Create('Manca il familiare di riferimento!');

    WC021FM:=TWC021FRiepilogoAssenzeFM.Create(Self);
    WC021FM.VisualizzaFrame:=VisualizzaRiepilogo;
    WC021FM.CaricaDati(Q040B.FieldByName('PROGRESSIVO').AsInteger,
        Q040B.FieldByName('CAUSALE').AsString,Q040B.FieldByName('DATA').AsDateTime,Q040B.FieldByName('DATANAS').AsDateTime);

    // riposizionamento sul primo record
    Q040B.First;
  end;
end;

procedure TWA004FGiustifAssPres.VisualizzaRiepilogo;
begin
  VisualizzaJQMessaggio(jqRiepAssenze,770,-1,570, 'Prospetto assenze','#wc021_container',False,True);
end;

procedure TWA004FGiustifAssPres.AbilitaNote;
begin
  lblNote.Visible:=(Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S') and (rgpGestione.ItemIndex = 0) and (rgpCausali.ItemIndex = 1);
  edtNote.Visible:=lblNote.Visible;
  lblNote.Enabled:=lblNote.Visible and (rgpTipoGiust.Items.Count = 4) and (rgpTipoGiust.ItemIndex = 1);
  edtNote.Enabled:=lblNote.Enabled;
end;

procedure TWA004FGiustifAssPres.AbilitaRecapitoVisiteFiscali(Abilitato: Boolean);
var TipoCumulo:String;
begin
  imgRecapitoAlternativo.Enabled:=Abilitato;

  //*** verificare.ini
  // nuova gestione recapito alternativo
  (*
  // pulizia dei campi
  if not Abilitato then
  begin
    ComuneAlt:='';
    IndirizzoAlt:='';
    CapAlt:='';
    TelefonoAlt:='';
    NoteAlt:='';
    A004MW.RecapitoAlternativoClear;

  end;
  *)
  //*** verificare.fine

  //Alberto 08/04/2009: Torino_Comune - Gestione nuovo periodo per Tipo cumulo = O
  TipoCumulo:=VarToStr(A004MW.Q265.Lookup('CODICE',cmbCausale.Text,'TIPOCUMULO'));
  chkNuovoPeriodo.Enabled:=(R180In(TipoCumulo,['I','O'])) and
                           (rgpGestione.ItemIndex = 0) and
                           (rgpTipoGiust.ItemIndex = 0) and
                           (A004MW.GestioneSingolaDM);
  if not chkNuovoPeriodo.Enabled then
    chkNuovoPeriodo.Checked:=False;
end;

function TWA004FGiustifAssPres.GetVisitaFiscale: String;
// Estrae il valore del flag VISITA_FISCALE a fronte della causale di assenza attualmente selezionata
begin
  Result:=VarToStr(A004MW.Q265.Lookup('CODICE',cmbCausale.Text,'VISITA_FISCALE'));
  if Result <> 'S' then
    Result:='N';
end;

procedure TWA004FGiustifAssPres.grdGiustificativiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r,c: Integer;
  IWLbl: TmeIWLabel;
begin
  inherited;

  if High(grdGiustificativi.medpCompGriglia) >= 0 then
    grdGiustificativi.medpContextMenu:=nil
  else
    grdGiustificativi.medpContextMenu:=pmnTabella2;
  // imposta la label della prima colonna
  for r:=0 to High(grdGiustificativi.medpCompGriglia) do
    for c:=0 to High(grdGiustificativi.medpCompGriglia[r].CompColonne) do
      begin
        IWLbl:=(grdGiustificativi.medpCompCella(r,c,0) as TmeIWLabel);
        if Assigned(IWLbl) then
        begin
          IWLbl.Caption:=grdGiustificativi.medpValoreColonna(r,grdGiustificativi.medpColonna(c).DataField);
          IWLbl.Css:='inlineblock100pc';
          IWLbl.Tag:=r + 1;
          //IWLbl.Hint:=Format('Tag = %d',[Tag]);
          IWLbl.medpContextMenu:=pmnTabella1;
        end;
      end;
end;

procedure TWA004FGiustifAssPres.grdGiustificativiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not GGetWebApplicationThreadVar.IsCallback then
  begin
    if not grdGiustificativi.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
      Exit;

    NumColonna:=grdGiustificativi.medpNumColonna(AColumn);
    Campo:=grdGiustificativi.medpColonna(NumColonna).DataField;

    if ARow = 0 then
    begin
      //
    end
    else
    begin
      //
    end;

    // assegnazione componenti
    if (ARow > 0) and (ARow <= High(grdGiustificativi.medpCompGriglia) + 1) and (grdGiustificativi.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
    begin
      ACell.Text:='';
      ACell.Control:=grdGiustificativi.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      if TmeIWLabel(ACell.Control).Caption = '' then
      begin
        TmeIWLabel(ACell.Control).RawText:=True;
        TmeIWLabel(ACell.Control).Caption:='&nbsp'; //permette la visualizzazione del menu contestuale
      end;
    end;
  end;
end;

procedure TWA004FGiustifAssPres.imgRecapitoAlternativoClick(Sender: TObject);
var
  T047Data:TDateTime;
begin
  if not TryStrToDate(edtDaData.Text,T047Data) then
  begin
    MsgBox.MessageBox('Indicare una data di inizio valida!',ERRORE);
    Exit;
  end;

  WA004RecapitoFM:=TWA004FRecapitoVisFiscaliFM.Create(Self);
  WA004RecapitoFM.Prog:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger; //***
  WA004RecapitoFM.DataInizio:=T047Data;
  WA004RecapitoFM.A004MW:=A004MW;
  WA004RecapitoFM.Visualizza;
end;

function TWA004FGiustifAssPres.GetRecapitoAbilitato: Boolean;
var
  DipendentiSelezionati, GestioneDipendenti, CausaleAssenza, FlagVisitaFiscale,
  GiustifAGiornata, Giustif4Scelte: Boolean;
begin
  // introduzione variabili per facilitare debug
  DipendentiSelezionati:=grdC700.selAnagrafe.RecordCount > 0;
  GestioneDipendenti:=rgpGestione.ItemIndex = 0;
  CausaleAssenza:=rgpCausali.ItemIndex = 1;
  FlagVisitaFiscale:=GetVisitaFiscale = 'S';
  GiustifAGiornata:=rgpTipoGiust.ItemIndex = 0;
  Giustif4Scelte:=rgpTipoGiust.Items.Count = 4;

  // valuta l'abilitazione del recapito alternativo
  Result:=A004MW.GestioneSingolaDM and
          DipendentiSelezionati and
          GestioneDipendenti and
          CausaleAssenza and
          FlagVisitaFiscale and
          GiustifAGiornata and
          Giustif4Scelte;
end;

{
function TWA004FGiustifAssPres.GetCodComuneAlt: String;
begin
  Result:=CodComuneAlt;
end;

function TWA004FGiustifAssPres.GetComuneAlt: String;
begin
  Result:=ComuneAlt;
end;

function TWA004FGiustifAssPres.GetCapAlt: String;
begin
  Result:=CapAlt;
end;

function TWA004FGiustifAssPres.GetIndirizzoAlt: String;
begin
  Result:=IndirizzoAlt;
end;

function TWA004FGiustifAssPres.GetTelefonoAlt: String;
begin
  Result:=TelefonoAlt;
end;

function TWA004FGiustifAssPres.GetMedicinaLegaleAlt: String;
begin
  Result:=MedicinaLegaleAlt;
end;

function TWA004FGiustifAssPres.GetNoteAlt: String;
begin
  Result:=NoteAlt;
end;

procedure TWA004FGiustifAssPres.SetRecapitoAlternativo(const PCodComuneAlt, PComuneAlt,
  PCapAlt, PIndirizzoAlt, PTelefonoAlt, PMedicinaLegaleAlt, PNoteAlt: String);
begin
  CodComuneAlt:=PCodComuneAlt;
  ComuneAlt:=PComuneAlt;
  CapAlt:=PCapAlt;
  IndirizzoAlt:=PIndirizzoAlt;
  TelefonoAlt:=PTelefonoAlt;
  MedicinaLegaleAlt:=PMedicinaLegaleAlt;
  NoteAlt:=PNoteAlt;
end;
}

procedure TWA004FGiustifAssPres.AbilitaTipoFruizione;
// abilita i radiobutton delle tipologie di fruizione in base alle impostazioni della causale
var
  i: Integer;
  ItemModificato: Boolean;
begin
  if cmbCausale.ItemIndex < 0 then
  begin
    // causale non selezionata
    for i:=0 to rgpTipoGiust.Items.Count - 1 do
      rgpTipoGiust.EnabledItems[i]:=0;
  end
  else
  begin
    // ciclo di abilitazione dei tipi fruizione
    if rgpCausali.ItemIndex = 0 then
    begin
      // causali di presenza
      with A004MW.Q275 do
      begin
        rgpTipoGiust.EnabledItems[0]:=IfThen(FieldByName('UM_INSERIMENTO_H').AsString = 'S',1,0);
        rgpTipoGiust.EnabledItems[1]:=IfThen(FieldByName('UM_INSERIMENTO_D').AsString = 'S',1,0);
      end;
    end
    else
    begin
      // causali di assenza
      with A004MW.Q265 do
      begin
        rgpTipoGiust.EnabledItems[0]:=IfThen(FieldByName('UM_INSERIMENTO').AsString = 'S',1,0);
        rgpTipoGiust.EnabledItems[1]:=IfThen(FieldByName('UM_INSERIMENTO_MG').AsString = 'S',1,0);
        rgpTipoGiust.EnabledItems[2]:=IfThen(FieldByName('UM_INSERIMENTO_H').AsString = 'S',1,0);
        rgpTipoGiust.EnabledItems[3]:=IfThen(FieldByName('UM_INSERIMENTO_D').AsString = 'S',1,0);
      end;
    end;
  end;
  rgpTipoGiust.Invalidate;

  // verifica che l'item attualmente selezionato sia abilitato
  ItemModificato:=False;
  if rgpTipoGiust.EnabledItems[rgpTipoGiust.ItemIndex] = 0 then
  begin
    for i:=0 to rgpTipoGiust.Items.Count - 1 do
    begin
      if rgpTipoGiust.EnabledItems[i] = 1 then
      begin
        rgpTipoGiust.ItemIndex:=i;
        ItemModificato:=True;
        rgpTipoGiust.Invalidate;
        Break;
      end;
    end;
  end;

  // se l'itemindex è stato modificato richiama l'evento onAsyncClick
  //if ItemModificato then
  begin
    //rgpTipoGiust.Invalidate;
    rgpTipoGiustAsyncClick(rgpTipoGiust,nil);
  end;

  // se nessun tipo di fruizione è abilitato
  // disabilito l'input delle ore
  if rgpTipoGiust.EnabledItems[rgpTipoGiust.ItemIndex] = 0 then
  begin
    edtDaOre.Enabled:=False;
    edtAOre.Enabled:=False;
    lblDaOre.Enabled:=False;
    lblAOre.Enabled:=False;
  end;

  // abilitazione campo note
  AbilitaNote;
end;

procedure TWA004FGiustifAssPres.actCaricaGiustRichiestiExecute(Sender: TObject);
// azione di caricamento giustificativi da iter
begin
  AccediForm(96,'',True);
end;

end.
