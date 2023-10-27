unit WR100UBase;

interface

uses
  WR010UBase,
  A000UInterfaccia,A000UCostanti, A000USessione,
  C004UParamForm, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  medpIWC700NavigatorBar,
  L021Call, RegistrazioneLog,
  SysUtils,ActnList,Classes,Controls,Graphics,Variants,
  IWGlobal,
  IWAppForm,IWApplication,IWTypes,IWControl,IWHTMLControls,
  IWTemplateProcessorHTML,IWCompEdit,
  IWCompLabel,IWCompGrids,IWCompListbox,
  IWBaseControl,IWBaseLayoutComponent,
  IWBaseContainerLayout,IWContainerLayout,IWVCLBaseControl,
  IWBaseHTMLControl,
  IWVCLComponent,StrUtils,Math,Oracle,System.Diagnostics,
  OracleData,Db, IWCompJQueryWidget, Forms, meIWGrid,
  meIWLink, medpIWStatusBar, medpIWMessageDlg, meIWImageFile, meIWDBLabel,
  IWRegion,A000UMessaggi, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls,WC019UProgressBarFM, IWCompButton,
  meIWButton,WC022UMsgElaborazioneFM, meIWImage, medpIWImageButton, meIWEdit,
  System.Threading;

type
  TTipoElab = (
    teServer,     // elaborazione server nel metodo "ElaborazioneCicloServer"
    teCicloServer // elaborazione server suddivisa nel ciclo di elaborazione della progressbar
  );

  TTipoElabRec = record
  const
    Server      = TTipoElab.teServer;      // elaborazione server nel metodo "ElaborazioneCicloServer"
    CicloServer = TTipoElab.teCicloServer; // elaborazione server suddivisa nel ciclo di elaborazione della progressbar
  end;

  TElabServer = record
    TipoElab: TTipoElab;
    Task: ITask;
    DurataTask: Cardinal;
    MessaggioTask: String;
    ErroreTask: String;
    IntervalloPing: Cardinal;
    procedure Create;
    procedure Inizializza; inline;
    procedure ForzaArresto;
    procedure Destroy;
    const
      // costanti per ping fine elaborazione
      INTERVALLO_PING_ELABORAZIONE = 5 * 1000; // espresso in ms
  end;

  TWR100FBase = class(TWR010FBase)
    grdStatusBar: TmedpIWStatusBar;
    AJNInizioElaborazione: TIWAJAXNotifier;
    AJNElaboraElemento: TIWAJAXNotifier;
    AJNMessaggioElaborazione: TIWAJAXNotifier;
    btnShowElabError: TmeIWButton;
    AJNElementoSuccessivo: TIWAJAXNotifier;
    AJNFineCicloElaborazione: TIWAJAXNotifier;
    AJNElaborazioneTerminata: TIWAJAXNotifier;
    AJNMsgElaborazione: TIWAJAXNotifier;
    procedure IWAppFormCreate(Sender:TObject);
    procedure IWAppFormDestroy(Sender:TObject);
    procedure TemplateProcessorBeforeProcess(var VTemplate: TStream);
    procedure AJNInizioElaborazioneNotify(Sender: TObject);
    procedure btnShowElabErrorClick(Sender: TObject);
    procedure AJNElaboraElementoNotify(Sender: TObject);
    procedure AJNElementoSuccessivoNotify(Sender: TObject);
    procedure AJNFineCicloElaborazioneNotify(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
    procedure AJNElaborazioneTerminataNotify(Sender: TObject);
    procedure AJNMessaggioElaborazioneNotify(Sender: TObject);
    procedure AJNMsgElaborazioneNotify(Sender: TObject);
  private
    FErroreElaborazione: Boolean;
    FMessaggioElaborazione: String;
    FStopWatch: TStopwatch;
    FShowDurataElaborazione: Boolean;
    FElabServer: TElabServer;
    FStepElaborazione: integer;
    procedure setMessaggioFinaleProgressBar(const Value: String);
    procedure AJNControllaFineElaborazioneNotify(Sender: TObject);
    procedure setStepElaborazione(const Value: integer);
  protected
    FContinueStopwatch: Boolean;
    WC019FProgressBarFM:TWC019FProgressBarFM;
    WC022FMsgElaborazioneFM:TWC022FMsgElaborazioneFM;
    NomeFileGenerato,StreamGenerato,DCOMMsg,AliasNomeFileGenerato: String;
    StreamGenerato2: TStream;
    AJNControllaFineElaborazione: TIWAJAXNotifier;
    AJNControllaFineElaborazione2: TIWAJAXNotifier;
    procedure MessageBoxFineElab(Msg: String; bErroreElaborazione: Boolean); virtual;
    function ElaborazioneConAnomalie: boolean; virtual;
    procedure CreaMsgElaborazioneFM;
    function  GetProgressivo: Integer; override;
    procedure ImpostaTemplate; override;
    procedure GestioneMenu; override;
    procedure AttivaGestioneC700Common;
    procedure AttivaGestioneC700; virtual;
    procedure AggiornaAnagr;
    procedure ImpostazioniWC700; virtual;
    procedure WC700AperturaSelezione(Sender: TObject); virtual;
    //procedure per gestione elaborazioni con progressBar
    procedure ElaborazioneCB(EventParams: TStringList); //Funzione Callback per inizio elaborazione in async
    procedure ReleaseOggettiElaborazione;
    procedure InizioElaborazione; virtual;
    procedure ElaboraElemento; virtual;
    function ElementoSuccessivo: Boolean; virtual;
    procedure FineCicloElaborazione; virtual;
    function ElaborazioneTerminata:String; virtual;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); virtual;
    function CurrentRecordElaborazione: Integer; virtual;
    function TotalRecordsElaborazione: Integer; virtual;
    function ElaborazioneCicloServer(const PShowDurataElaborazione: Boolean = False): String;
    procedure InviaFileGenerato;
    //Gestione notify per la chiamata al B028 di stampa
    procedure MsgElaborazioneServer(EventParams: TStringList);
    procedure ElaborazioneServer; virtual;
    procedure AfterElaborazione; virtual;
    procedure InizializzaMsgElaborazione; virtual;
    function GetTempoElaborazione: String;
    procedure StatusbarDefault; virtual;
    procedure StatusbarC700; virtual;
  public
    WR100LinkWC700:Boolean;
    grdC700:TmedpIWC700NavigatorBar;
    C004DM:TC004FParamForm;
    MsgFileNonCreato: String;
    RipartiElaborazione: boolean;
    procedure CambioDataLavoro; virtual;
    //procedure per gestione elaborazioni con progressBar
    procedure StartElaborazioneCiclo(SenderHTMLName: String; const PShowDurataElaborazione: Boolean = False; const PShowInterrompiElaborazione: Boolean = True); virtual;
    //Gestione notify per la chiamata al B028 di stampa
    procedure StartElaborazioneServer(SenderHTMLName: String; const PShowDurataElaborazione: Boolean = False);
    procedure StartElaborazioneCicloServer(SenderHTMLName: String; const PShowDurataElaborazione: Boolean = False);
    procedure AccediForm(PTag:Integer; const Params: String = ''; const EreditaSelezioneDaFormChiamante: Boolean = False);
    function  IsLoginForm: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); virtual;
    procedure MessaggioStatus(const PTipo, PTesto, PTestoPopup: String; const PDurataPopup: Integer = 5000; const PDurataTesto: Integer = -1); override;
    property MessaggioFinaleProgressBar :String write setMessaggioFinaleProgressBar;
    property StepElaborazione: integer read FStepElaborazione write setStepElaborazione;
  end;

implementation

uses A000UIrisWebDM, WR101ULogin, WR200UBaseFM, WR102UGestTabella,WR103UGestMasterDetail,WR203UGestDetailFM,
     WR207UMenuWebPJFM,WC700USelezioneAnagrafeFM
     {$IFDEF RILPRE},WC502UMenuRilPreFM {$ENDIF}
     {$IFDEF PAGHE} ,WC503UMenuPagheFM  {$ENDIF}
     {$IFDEF STAGIU},WC504UMenuStagiuFM {$ENDIF};

{$R *.dfm}

procedure TWR100FBase.IWAppFormCreate(Sender:TObject);
begin
  inherited;
  StepElaborazione:=1;
  FContinueStopwatch:=False;
  RipartiElaborazione:=False;
  AliasNomeFileGenerato:='';

  // gestione elaborazione server con ajax notifier
  FElabServer.Create;
  AJNControllaFineElaborazione:=TIWAJAXNotifier.Create(Self);
  AJNControllaFineElaborazione.Name:='AJNControllaFineElaborazione';
  AJNControllaFineElaborazione.OnNotify:=AJNControllaFineElaborazioneNotify;
  AJNControllaFineElaborazione2:=TIWAJAXNotifier.Create(Self);
  AJNControllaFineElaborazione2.Name:='AJNControllaFineElaborazione2';
  AJNControllaFineElaborazione2.OnNotify:=AJNControllaFineElaborazioneNotify;

  //Caratto 28/06/2013
  // HelpKeyword: se non impostato utilizza nome standard (codice form + P0)
  if Trim(HelpKeyword) = '' then
  begin
    HelpKeyword:=Format('%sP0',[medpCodiceForm]);
  end;

  WR100LinkWC700:=True;

  if not IsLoginForm then
  begin
    lnkIndietro.Visible:=True;
    lnkChiudiSchede.Visible:=True;
    C004DM:=CreaC004(SessioneOracle,medpCodiceForm,Parametri.ProgOper,False);
  end;
  StatusbarDefault;

  // preload immagini fisse per iriscloud (v. FunzioniGenerali.js)
  AddToInitProc('try { preloadImgFisse_IrisCloud(); } catch(err) {} ');

  GGetWebApplicationThreadVar.RegisterCallBack(self.name + 'ElaborazioneCB',ElaborazioneCB); //Funzione per start elaborazione in async
  GGetWebApplicationThreadVar.RegisterCallBack(self.name + 'MsgElaborazioneServer',MsgElaborazioneServer); //Funzione per start elaborazione (es. per stampa) in async
end;

procedure TWR100FBase.StatusbarDefault;
begin
  grdStatusBar.EliminaElementi;
  grdStatusBar.AggiungiElemento('DATALAVORO');
  grdStatusBar.AggiungiElemento('MESSAGGIO');
  grdStatusBar.CreaStatusBar;
  grdStatusBar.StatusBarComponent('DATALAVORO').Header:='Data Lavoro:';
  if Parametri.DataLavoro > 0 then
    grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Parametri.DataLavoro)
  else
    grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Date);
  MessaggioStatus(INFORMA,'');
end;

procedure TWR100FBase.IWAppFormDestroy(Sender:TObject);
begin
  FElabServer.Destroy;

  if C004DM <> nil then
    FreeAndNil(C004DM);
  //Per essere sicuri di distruggere gli oggetti quando l'elaborazione viene interrotta dalla chiusura del browser,
  //sarebbe bene eseguire questa chiamata a DistruzioneOggettiElaborazione, ma dovrebbe eseguire effettivamente solo le free
  //DistruzioneOggettiElaborazione(False);
  inherited;
end;

procedure TWR100FBase.MessaggioStatus(const PTipo, PTesto, PTestoPopup: String;
  const PDurataPopup, PDurataTesto: Integer);
var
  Stile: String;
begin
  if PTipo = INFORMA then
    Stile:='informazione'
  else if PTipo = ESCLAMA then
    Stile:='esclamazione'
  else if PTipo = ERRORE then
    Stile:='segnalazione'
  else
    raise Exception.Create('Parametri errati per la funzione SetStatusMessaggio.');

  if PDurataPopup > 0 then
    jqAlert.OnReady.Text:='$("#avviso").text("' + C190EscapeJS(PTestoPopup) + '").fadeIn(1500);' + CRLF +
                          '$("#avviso").delay(' + IntToStr(PDurataPopup) + ').effect("transfer",{to: "#GRDSTATUSBAR", className: "ui-effects-transfer"},1000).fadeOut();' + CRLF +
                          '';

  if (grdStatusBar <> nil) and (grdStatusBar.Owner <> nil) then
    if grdStatusBar is TIWGrid then
    try
      grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=PTesto;
      grdStatusBar.StatusBarComponent('MESSAGGIO').ValueCss:=Stile;
    except
    end;
end;

procedure TWR100FBase.TemplateProcessorBeforeProcess(var VTemplate: TStream);
var
  StrComponenti,StrDiv,S: String;
  StrListTemp: TStringList;
  i,x,y:Integer;
begin

  StrListTemp:=TStringList.Create();
  StrListTemp.LoadFromStream(VTemplate);

  //MANIPOLAZIONE TEMPLATE
  StrComponenti:='';
  //statusbar
  StrComponenti:='{%grdStatusBar%}' + #13#10;

  //navigatore C700 (se attivo link a C700)
  if grdC700 <> nil then
  begin
    if WR100LinkWC700 then
    begin
      if Pos(LowerCase('{%grdC700NavigatorBar%}'),LowerCase(StrListTemp.Text)) = 0 then
        StrComponenti:=StrComponenti + '<div class="medpToolBarRiga">{%' + grdC700.Name + '%}</div>' + #13#10
      else
        StrListTemp.Text:=StringReplace(StrListTemp.Text,'{%grdC700NavigatorBar%}','<div class="medpToolBarRiga">{%' + grdC700.Name + '%}</div>',[rfIgnoreCase]);
    end;
    //non usare  WR100LinkWC700 perchè si può creare C700 senza usare link (navigazione su c700)
    StrComponenti:=StrComponenti + '<div id="' + grdC700.WC700FM.Name + '">{%' + grdC700.WC700FM.Name + '%}</div> ' + #13#10;
  end;
  //includo le altre WC700FM create eventualmente su form secondarie e riparenterizzate su quella principale, tramite la TWC007FFormContainerFM
  for i:=0 to ControlCount - 1 do
    if Controls[i] is TWC700FSelezioneAnagrafeFM then
    begin
      if (grdC700 = nil) or (Controls[i] <> grdC700.WC700FM) then
        StrComponenti:=StrComponenti + '<div id="' + (Controls[i] as TWC700FSelezioneAnagrafeFM).Name + '">{%' + (Controls[i] as TWC700FSelezioneAnagrafeFM).Name + '%}</div> ' + #13#10;
    end;

  if Self is TWR102FGestTabella then
  begin
    //navigatore
    StrComponenti:=StrComponenti + '{%grdNavigatorBar%} ' + #13#10;
    //navigatore storico
    if TWR102FGestTabella(Self).InterfacciaWR102.GestioneStoricizzata then
      StrComponenti:=StrComponenti + '{%grdToolBarStorico%} ' + #13#10;

    //eventuale intestazione dopo le toolbar e prima dei frame di browse/dettaglio
    while Pos('{grdnavigatorbar%',LowerCase(StrListTemp.Text)) > 0 do
    begin
      x:=Pos('{grdnavigatorbar%',LowerCase(StrListTemp.Text));
      y:=Pos('}',Copy(StrListTemp.Text,x,Length(StrListTemp.Text)));
      S:=Copy(StrListTemp.Text,x,y);
      StrListTemp.Text:=StringReplace(StrListTemp.Text,S,'',[]);
      StrComponenti:=StrComponenti + StringReplace(S,'grdnavigatorbar','',[rfIgnoreCase]) + #13#10;
    end;

    //tab control
    if TWR102FGestTabella(Self).InterfacciaWR102.TemplateAutomatico then
    begin
      if (TWR102FGestTabella(Self).grdTabControl.TabCount > 1) and (Pos('{%grdTabControl%}',StrListTemp.Text) = 0) then
        StrComponenti:=StrComponenti + '{%grdTabControl%} ' + #13#10;

      StrDiv:='';
      //pannello browse e dettaglio
      if TWR102FGestTabella(Self).WBrowseFM <> nil then
        //StrDiv:='{%'+ GetNomeForm +'BrowseFM%}';
        StrDiv:='{%'+ TWR102FGestTabella(Self).WBrowseFM.Name +'%}';

      if TWR102FGestTabella(Self).WDettaglioFM <> nil then
        //StrDiv:=StrDiv + ' {%'+GetNomeForm +'DettFM%}';
        StrDiv:=StrDiv + '{%'+ TWR102FGestTabella(Self).WDettaglioFM.Name +'%}';

      if StrDiv <> '' then
        StrComponenti:=StrComponenti +'<div style="width:100%">' + strDiv + '</div> ' ;
    end;
  end;

  if Self is TWR103FGestMasterDetail then
  begin
    if TWR103FGestMasterDetail(Self).DetailsCount >= 2 then
    begin
       //Alberto 20/01/2014: si aggiunge il tag dinamico solo se non è già stato messo manualmente sul template html
       // in questo modo
       if TWR102FGestTabella(Self).InterfacciaWR102.TemplateAutomatico then
         StrComponenti:=StrComponenti +'{%grdDetailTabControl%}'+ #13#10 ;
    end;
  end;

  //frame per funzioni con dialog (funzioni da barra navigazione
  StrComponenti:=StrComponenti + '<div id="WC003FRicercaDatiFM">{%WC003FRicercaDatiFM%}</div> ' + #13#10 +
                                 '<div id="WC004FEstrazioneDatiFM">{%WC004FEstrazioneDatiFM%}</div> ' + #13#10 +
                                 '<div id="WC009FCopiaSuFM">{%WC009FCopiaSuFM%}</div> ';
  //frame per funzioni con dialog (funzioni specifiche)
  StrComponenti:=StrComponenti + '<div id="WC010FMemoEditFM">{%WC010FMemoEditFM%}</div> '#13#10 +
                                 '<div id="WC011FListboxFM">{%WC011FListboxFM%}</div> '#13#10 +
                                 '<div id="WC012UVisualizzaFileFM">{%WC012UVisualizzaFileFM%}</div> '#13#10 +
                                 '<div id="WC013FCheckListFM">{%WC013FCheckListFM%}</div> '#13#10 +
                                 '<div id="WC015FSelEditGridFM">{%WC015FSelEditGridFM%}</div> '#13#10 +
                                 '<div id="WC015FSelEditGrid2FM">{%WC015FSelEditGrid2FM%}</div> '#13#10 +
                                 '<div id="WC019FProgressBarFM">{%WC019FProgressBarFM%}</div> '#13#10 +
                                 '<div id="WC020FInputDataOreFM">{%WC020FInputDataOreFM%}</div> '#13#10 +
                                 '<div id="WC022FMsgElaborazioneFM">{%WC022FMsgElaborazioneFM%}</div> '#13#10 +
                                 '<div id="WC023FCambioPasswordFM">{%WC023FCambioPasswordFM%}</div> '#13#10 +
                                 '<div id="WC024ULegendaFM">{%WC024ULegendaFM%}</div> '#13#10 +
                                 '<div id="WC025UUploadFile">{%WC025UUploadFile%}</div> '#13#10 +
                                 '<div id="WC026UAllegatiIterFM">{%WC026UAllegatiIterFM%}</div> '#13#10 +
                                 '<div id="WC027UInfoDatiFM">{%WC027UInfoDatiFM%}</div> '#13#10 +
                                 '<div id="WC028URichiesteInCorsoFM">{%WC028URichiesteInCorsoFM%}</div> '#13#10 +
                                 '<div id="WC029FSelezioneFontFM">{%WC029FSelezioneFontFM%}</div> '#13#10;

  StrListTemp.Text:=StringReplace(strListTemp.Text, '{%ContenutoDinamico%}', StrComponenti, [rfReplaceAll]);

  //SALVATAGGIO SU STREAM VTemplate
  FreeAndNil(VTemplate);//VTemplate.Free;
  VTemplate:=TStringStream.Create;
  strListTemp.SaveToStream(VTemplate);
  FreeAndNil(strListTemp);
  TStringStream(VTemplate).Seek(0, soFromBeginning);
end;

// ******************************************* //
// ************* GESTIONE  FORM ************** //
// ******************************************* //

function TWR100FBase.IsLoginForm: Boolean;
begin
  Result:=Self is TWR101FLogin;
end;

function TWR100FBase.GetProgressivo: Integer;
begin
  Result:=-1;
  if WR000DM.cdsAnagrafe.Active then
    Result:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

function TWR100FBase.GetTempoElaborazione: String;
begin
  Result:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,FStopWatch.ElapsedMilliseconds / MSecsPerDay);
end;

procedure TWR100FBase.ImpostaTemplate;
begin
  if IsLoginForm then
    TemplateProcessor.Templates.Default:=Copy(TWR101FLogin.ClassName,2) + '.html';
  inherited;
end;

//Richiamata dopo la creazione della WC700
//Inserire qui le impostazioni, come campi visualizzati, campi selezionati,
procedure TWR100FBase.ImpostazioniWC700;
begin
  //ridefinire
end;

procedure TWR100FBase.GestioneMenu;
var
 C004DMMenu: TC004FParamForm;
begin
  // form di login -> menu non creato
  if IsLoginForm then
    Exit;

  if WMenuFM = nil then
    {$IFDEF RILPRE}
    WMenuFM:=TWC502FMenuRilPreFM.Create(Self);
    {$ENDIF}
    {$IFDEF PAGHE}
    WMenuFM:=TWC503FMenuPagheFM.Create(Self);
    {$ENDIF}
    {$IFDEF STAGIU}
    WMenuFM:=TWC504FMenuStagiuFM.Create(Self);
    {$ENDIF}
  //Caratto 07/01/2015. Imposto action filtro cessati. sia in create che in render perchè
  //menù presente su ogni pagina e il cambio su una deve essere riflesso su tutte
   C004DMMenu:=CreaC004(SessioneOracle,WA001PaginaPrincipale,Parametri.ProgOper,False);
   (WMenuFM as TWR207FMenuWEbPJFM).ImpostaCheckFiltroCessati(C004DMMenu.GetParametro('CESSATI','N') = 'S');
   FreeAndNil(C004DMMenu);
end;

// ******************************************* //
// ********** SELEZIONE ANAGRAFICA *********** //
// ******************************************* //

procedure TWR100FBase.WC700AperturaSelezione(Sender: TObject);
// gestione apertura selezione
begin
  // ridefinire opportunamente se necessario
end;

procedure TWR100FBase.WC700CambioProgressivo;
// gestione del cambio di progressivo
begin
  //AggiornaAnagr; //Caratto 04/01/2013 Aggiornamento statusbar anagrafiche su selezione da WC700
  // ridefinire opportunamente se necessario
end;

procedure TWR100FBase.AccediForm(PTag: Integer; const Params: String = ''; const EreditaSelezioneDaFormChiamante: Boolean = False);
begin
  (WMenuFM as
    {$IFDEF RILPRE}TWC502FMenuRilPreFM{$ENDIF}
    {$IFDEF PAGHE} TWC503FMenuPagheFM {$ENDIF}
    {$IFDEF STAGIU}TWC504FMenuStagiuFM{$ENDIF}).Accedi(PTag,Params,EreditaSelezioneDaFormChiamante);
end;

procedure TWR100FBase.AggiornaAnagr;
begin
  //Caratto 20/12/2012 test se già presente anagrafiche.
  //Necessario con aggiunta di evento AfterScroll su selAnagrafe
  if (grdStatusBar.StatusBarComponent('ANAGRAFICHE') <> nil) and (grdC700 <> nil) and (grdC700.selAnagrafe.Active) then
    grdStatusBar.StatusBarComponent('ANAGRAFICHE').Value:=IntToStr(grdC700.selAnagrafe.RecNo) + '/' + IntToStr(grdC700.selAnagrafe.RecordCount);
end;

procedure TWR100FBase.AttivaGestioneC700Common;
begin
  if grdC700 = nil then
    grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  // bugfix: la lettura delle impostazioni non veniva effettuata
  grdC700.Impostazioni:=ImpostazioniWC700;
  grdC700.AggiornaAnagr:=AggiornaAnagr;
  grdC700.CambioProgressivoEvent:=WC700CambioProgressivo;
  grdC700.AperturaSelezioneEvent:=WC700AperturaSelezione;
  grdC700.CreaSelezioneIniziale(True);
end;

procedure TWR100FBase.AttivaGestioneC700;
begin
  AttivaGestioneC700Common;
  StatusbarC700;
end;

procedure TWR100FBase.StatusbarC700;
begin
  grdStatusBar.EliminaElementi;
  grdStatusBar.AggiungiElemento('DATALAVORO');
  grdStatusBar.AggiungiElemento('ANAGRAFICHE');
  grdStatusBar.AggiungiElemento('MESSAGGIO');
  grdStatusBar.CreaStatusBar;
  grdStatusBar.StatusBarComponent('DATALAVORO').Header:='Data Lavoro:';
  grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Parametri.DataLavoro);
  grdStatusBar.StatusBarComponent('ANAGRAFICHE').Header:='Anagrafiche:';
  grdStatusBar.StatusBarComponent('ANAGRAFICHE').Value:='0/0';
  MessaggioStatus(INFORMA,'');
  AggiornaAnagr;
end;

//Massimo 04/12/2013 Ridefinito rispetto a WR010 perchè su Cloud il flusso di sendFile è più complesso rispetto a IrisWeb,
//dove si invia direttamente il file fsico al browser.
procedure TWR100FBase.btnSendFileClick(Sender: TObject);
var
  Nome: string;
begin
  if (DCOMNomeFile <> '') or (NomeFileGenerato <> '')  then
  begin
    if NomeFileGenerato = '' then
      NomeFileGenerato:=DCOMNomeFile;
    if (StreamGenerato = '') and (StreamGenerato2 = nil) then //invia file fisico
    begin
      if AliasNomeFileGenerato <> '' then
        Nome:=AliasNomeFileGenerato
      else
        Nome:=ExtractFileName(NomeFileGenerato);
      GGetWebApplicationThreadVar.SendFile(NomeFileGenerato,true,'application/x-download',Nome);
    end
    else if StreamGenerato <> '' then //invio come stream (String)
      InviaFile(NomeFileGenerato,StreamGenerato)
    else                              //invio come stream (TStream)
      InviaFile(NomeFileGenerato,StreamGenerato2);
  end;
  AfterElaborazione;
  TA000FInterfaccia(gSC).SegnaSessioneAttiva;
end;

procedure TWR100FBase.MessageBoxFineElab(Msg:String; bErroreElaborazione:Boolean);
begin
  Msgbox.MessageBox(Msg,IfThen(bErroreElaborazione,ERRORE,INFORMA));
end;

procedure TWR100FBase.btnShowElabErrorClick(Sender: TObject);
begin
  inherited;
  if FMessaggioElaborazione <> '' then  //se messaggio vuoto non visualizza alcun messaggio
  begin
    if not MsgBox.IsActive then //CARATTO 19/05/2014 su IE8 in download compare tool pr chiedere conferma di download file. Se si conferma la pagina viene reInviata e Msg già attivo
      MessageBoxFineElab(FMessaggioElaborazione,FErroreElaborazione);
  end;

  InviaFileGenerato;
end;

//Gestione elaborazione con progressbar

procedure TWR100FBase.StartElaborazioneCiclo(SenderHTMLName: String; const PShowDurataElaborazione: Boolean = False; const PShowInterrompiElaborazione: Boolean = True);
begin
  // segnala al programma di visualizzare la durata dell'elaborazione
  FShowDurataElaborazione:=PShowDurataElaborazione;

  // in base ad un flag valuta se far ripartire o meno il timer di elaborazione
  if FContinueStopwatch then
  begin
    FStopWatch.Start;
    FContinueStopwatch:=False;
  end
  else
    FStopWatch:=TStopwatch.StartNew;

  // segnala avvio elaborazione
  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;

  //Frame di progress bar
  WC019FProgressBarFM:=TWC019FProgressBarFM.Create(Self);
  WC019FProgressBarFM.InterrompiElaborazione:=PShowInterrompiElaborazione;
  WC019FProgressBarFM.Visualizza;
  //durante l'elaborazione non si scatena il rendercell medpIWC700NavigatorBar
  //pertanto se parto da un dipendente cessato (rosso) vedrò tutti con lo stesso colore.
  //Imposto Flag in modo che si visualizzi con font neutro (nero)
  if grdC700 <> nil then
    grdC700.InibisciColoreFont:=True;

  //start elaborazione
  AddToInitProc(format('executeAjaxEvent("", %sIWCL,"%sElaborazioneCB",false,null,true);',[SenderHTMLName,Self.name ]));
end;

procedure TWR100FBase.ElaborazioneCB(EventParams: TStringList);
begin
  AJNInizioElaborazione.Notify;
end;

procedure TWR100FBase.AJNInizioElaborazioneNotify(Sender: TObject);
begin
  try
    A000SessioneWEB.AnnullaTimeOut;
    InizioElaborazione; //Inizializzazione Elaborazione
    WC019FProgressBarFM.AggiornaAvanzamento(STEP1);
    if TotalRecordsElaborazione = 0 then
    begin
      WC019FProgressBarFM.AggiornaAvanzamento(STEP3);
      AJNFineCicloElaborazione.Notify;
    end
    else
      AJNElaboraElemento.Notify;
  except
    on E:Exception do
    begin
      W000RegistraLog('Errore','InizioElaborazione: (' + medpCodiceForm + ') ' + E.ClassName + '/' + E.Message);
      FMessaggioElaborazione:=Format(A000MSG_ERR_FMT_ERRORE,[E.Message]);
      FErroreElaborazione:=True;
      AJNMessaggioElaborazione.Notify;
    end;
  end;
end;

procedure TWR100FBase.AJNElaboraElementoNotify(Sender: TObject);
begin
  try
    ElaboraElemento; //Elaborazione elemento corrente
    if ((CurrentRecordElaborazione div FStepElaborazione) = (CurrentRecordElaborazione / FStepElaborazione)) or
       (CurrentRecordElaborazione = TotalRecordsElaborazione) then
    begin
      WC019FProgressBarFM.AggiornaAvanzamento(STEP2, CurrentRecordElaborazione,TotalRecordsElaborazione);
      AJNElementoSuccessivo.Notify;
    end
    else
    begin
      ElementoSuccessivo;
      AJNElaboraElementoNotify(Sender);
    end;
  except
    on E:Exception do
    begin
      W000RegistraLog('Errore','ElaboraElemento: (' + medpCodiceForm + ') ' + E.ClassName + '/' + E.Message);
      FMessaggioElaborazione:=Format(A000MSG_ERR_FMT_ERRORE,[E.Message]);
      FErroreElaborazione:=True;
      AJNMessaggioElaborazione.Notify;
    end;
  end;
end;

procedure TWR100FBase.AJNElementoSuccessivoNotify(Sender: TObject);
begin
  try
    //sposta elemento successivo.
    if ElementoSuccessivo then
    begin
      if WC019FProgressBarFM.chkInterrompiElaborazione.Checked then
      begin
        WC019FProgressBarFM.AggiornaAvanzamento(STEP3);
        AJNFineCicloElaborazione.Notify;
        //AJNElaborazioneTerminata.Notify  //scommentare se si vuole interrompere senza fare e annulare l'elaborazione
      end
      else
        //esegue calcolo su nuovo elemento
        AJNElaboraElemento.Notify;
    end
    else
    begin
      //ciclo elaborazione finito. finalizzazione.
      WC019FProgressBarFM.AggiornaAvanzamento(STEP3);
      AJNFineCicloElaborazione.Notify;
    end;
  except
    on E:Exception do
    begin
      W000RegistraLog('Errore','ElementoSuccessivo: (' + medpCodiceForm + ') ' + E.ClassName + '/' + E.Message);
      FMessaggioElaborazione:=Format(A000MSG_ERR_FMT_ERRORE,[E.Message]);
      FErroreElaborazione:=True;
      AJNMessaggioElaborazione.Notify;
    end;
  end;
end;

procedure TWR100FBase.AJNFineCicloElaborazioneNotify(Sender: TObject);
begin
  inherited;
  try
    NomeFileGenerato:='';
    StreamGenerato:='';
    FineCicloElaborazione;
    AJNElaborazioneTerminata.Notify; //messaggio fine elaborazione
  except
    on E:Exception do
    begin
      W000RegistraLog('Errore','FineElaborazione: (' + medpCodiceForm + ') ' + E.ClassName + '/' + E.Message);
      FMessaggioElaborazione:=Format(A000MSG_ERR_FMT_ERRORE,[E.Message]);
      FErroreElaborazione:=True;
      AJNMessaggioElaborazione.Notify;
    end;
  end;
end;

function TWR100FBase.ElaborazioneConAnomalie(): boolean;
begin
  Result:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB)
end;

procedure TWR100FBase.AJNElaborazioneTerminataNotify(Sender: TObject);
begin
  inherited;

  if WC019FProgressBarFM.chkInterrompiElaborazione.Checked then //Elaborazione interrotta da utente
  begin
    //richiamo comunque ElaborazioneTerminata per abilitazione pulsante anomalie. valutare se centralizzare  abilitazione pulsante
    ElaborazioneTerminata;
    FMessaggioElaborazione:=A000MSG_MSG_ELABORAZIONE_INTERROTTA;
    if ElaborazioneConAnomalie then
      FMessaggioElaborazione:=FMessaggioElaborazione + #13#10 + A000MSG_MSG_ELABORAZIONE_ANOMALIE;
  end
  else //messaggio di fine elaborazione. Possibile personalizzare ad esempio se anomalie ecc.
    FMessaggioElaborazione:=ElaborazioneTerminata;
  FErroreElaborazione:=False;
  A000SessioneWEB.RipristinaTimeOut;
  AJNMessaggioElaborazione.Notify;

end;

procedure TWR100FBase.AJNMessaggioElaborazioneNotify(Sender: TObject);
var
  LElaborazioneInterrotta: Boolean;
begin
  if WC019FProgressBarFM <> nil then
    LElaborazioneInterrotta:=WC019FProgressBarFM.chkInterrompiElaborazione.Checked
  else
    LElaborazioneInterrotta:=False;

  // effettua distruzione oggetti creati per l'elaborazione
  ReleaseOggettiElaborazione;

  // ripristina il timeout normale
  A000SessioneWEB.RipristinaTimeOut;

  // stop timer di precisione per tempo elaborazione
  FStopWatch.Stop;

  // se è attivo il flag RipartiElaborazione e l'elaborazione non è stata interrotta dall'utente
  // riavvia un'altra elaborazione
  if RipartiElaborazione and (not LElaborazioneInterrotta) then
  begin
    RipartiElaborazione:=False;
    // segnala al metodo di far ripartire il timer
    FContinueStopwatch:=True;
    StartElaborazioneCiclo(btnSendFile.HTMLName,FShowDurataElaborazione);
    exit;
  end;

  // segnala fine elaborazione
  if FShowDurataElaborazione then
    grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=GetTempoElaborazione
  else
    grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='';

  //In async non si chiude il Frame WC019 ne viene presentata la MessageDlg.
  //Forzo un click e visualizzo errore
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnShowElabError.HTMLName]));
end;

//Ridefinire
//Richiamata al cambio della data lavoro
procedure TWR100FBase.CambioDataLavoro;
begin
  inherited;
end;

//Ridefinire
//Restituisce l'ordinale del progressivo corrente
function TWR100FBase.CurrentRecordElaborazione: Integer;
begin
  Result:=0;
end;

//Ridefinire
//Restituisce il numero totale di record da elaborare
function TWR100FBase.TotalRecordsElaborazione: Integer;
begin
  Result:=0;
end;

//ridefinire
//Procedura inizializzazione elaborazione
procedure TWR100FBase.InizioElaborazione;
begin
  RegistraMsg.IniziaMessaggio(medpCodiceForm);
end;

//Forza il submit di btnSendFile
procedure TWR100FBase.InviaFileGenerato;
begin
  if NomeFileGenerato <> ''  then  //Se creato un file esegui submit per spedirlo al client
    AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]))
  else
    AfterElaborazione;
end;

//ridefinire
//Procedura elaborazione record corrente
procedure TWR100FBase.ElaboraElemento;
begin
  //ridefinire
end;

//ridefinire
//Se si è e arrivati all'utimo record per elaborazione resituire False,
//altrimenti spostarsi e restituire True;
function TWR100FBase.ElementoSuccessivo: Boolean;
begin
  Result:=False;
end;

//ridefinire
//Procedura eseguita a fine ciclo elaborazione.
//Eventualmente creare File da restituire al client.
//Valorizzare nomeFileGenerato per attivare step successivo di invio file, altrimenti elaborazione termina
procedure TWR100FBase.FineCicloElaborazione;
//ridefinire opportunamente
begin
 
end;

procedure TWR100FBase.ReleaseOggettiElaborazione;
begin
  DistruzioneOggettiElaborazione(FErroreElaborazione);
  //distruzione frame progressbar
  if WC019FProgressBarFM <> nil then
    WC019FProgressBarFM.Chiudi;
    
  WC019FProgressBarFM:=nil;
  if grdC700 <> nil then
    grdC700.InibisciColoreFont:=False;
end;

procedure TWR100FBase.setMessaggioFinaleProgressBar(const Value: String);
begin
  if WC019FProgressBarFM <> nil then
    WC019FProgressBarFM.MessaggioStep3:=Value;
end;

procedure TWR100FBase.setStepElaborazione(const Value: integer);
begin
  FStepElaborazione:=Max(1,Value);
end;

//ridefinire
//Distruzione oggetti usati per elaborazione, chiusura dataset ecc.
procedure TWR100FBase.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  //ridefinire
end;

//ridefinire se necessario
//Messaggio di fine elaborazione.
function TWR100FBase.ElaborazioneTerminata: String;
begin
  if ElaborazioneConAnomalie then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=A000MSG_MSG_ELABORAZIONE_TERMINATA;
end;

procedure TWR100FBase.CreaMsgElaborazioneFM;
begin
  if WC022FMsgElaborazioneFM = nil then
  begin
    WC022FMsgElaborazioneFM:=TWC022FMsgElaborazioneFM.Create(Self);
  end;
  // procedure utile se si decide di modificare label, title o filename di WC022
  InizializzaMsgElaborazione;
  WC022FMsgElaborazioneFM.Visualizza;
end;

// Gestione Notify per messaggio di attesa durante il richiamo al B028    ----- ini
procedure TWR100FBase.StartElaborazioneServer(SenderHTMLName: String; const PShowDurataElaborazione: Boolean = False);
begin
  CreaMsgElaborazioneFM;

  // segnala al programma di visualizzare la durata dell'elaborazione
  FShowDurataElaborazione:=PShowDurataElaborazione;

  // segnala avvio elaborazione
  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;

  //start elaborazione
  AddToInitProc(Format('executeAjaxEvent("&tipo=%d", %sIWCL,"%sMsgElaborazioneServer",false,null,true);',[Ord(TTipoElabRec.Server),SenderHTMLName,Self.Name]));
end;

procedure TWR100FBase.StartElaborazioneCicloServer(SenderHTMLName: String; const PShowDurataElaborazione: Boolean = False);
begin
  CreaMsgElaborazioneFM;

  // segnala al programma di visualizzare la durata dell'elaborazione
  FShowDurataElaborazione:=PShowDurataElaborazione;

  // segnala avvio elaborazione
  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;

  //start elaborazione
  AddToInitProc(Format('executeAjaxEvent("&tipo=%d", %sIWCL,"%sMsgElaborazioneServer",false,null,true);',[Ord(TTipoElabRec.CicloServer),SenderHTMLName,Self.Name]));
end;

procedure TWR100FBase.MsgElaborazioneServer(EventParams: TStringList);
var
  LTipoElab: Integer;
begin
  // TODO: sistemare...
  if not TryStrToInt(EventParams.Values['tipo'],LTipoElab) then
    raise Exception.Create('Il tipo di elaborazione non è stato indicato. Contattare il servizio di assistenza software');

  LTipoElab:=StrToIntDef(EventParams.Values['tipo'],0);
  AJNMsgElaborazione.Tag:=LTipoElab;
  AJNMsgElaborazione.Notify;
end;

procedure TWR100FBase.AJNMsgElaborazioneNotify(Sender: TObject);
var
  LErr: String;
  LAppID: string;
begin
  LErr:='';
  NomeFileGenerato:='';
  DCOMMsg:='';
  MsgFileNonCreato:=Format(A000MSG_ERR_FMT_ERRORE +#13#10+ LErr,[A000MSG_ERR_FILE_NON_CREATO]);

  {
  try
    // imposta un valore molto alto per il timeout di sessione
    A000SessioneWEB.AnnullaTimeOut;

    // avvio timer di precisione per tempo elaborazione
    FStopWatch:=TStopwatch.StartNew;

    ElaborazioneServer;
  except
    // Necessario perchè se vengono intercettati errori allora viene visualizzato anche in async il messaggio
    // di errore gestito in seguito nel caso di file non creato.
    on E:Exception do
      LErr:=E.Message;
  end;

  // segnala fine elaborazione
  if FShowDurataElaborazione then
    grdStatusBar.StatusBarComponent('MESSAGGIO').Value:=GetTempoElaborazione
  else
    grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='';

  // stop timer di precisione per tempo elaborazione
  FStopWatch.Stop;

  // ripristina il timeout di sessione
  A000SessioneWEB.RipristinaTimeOut;

  if WC022FMsgElaborazioneFM <> nil then
  begin
    WC022FMsgElaborazioneFM.Chiudi;
    WC022FMsgElaborazioneFM:=nil;
  end;

  if LErr <> '' then
  begin
    MsgBox.MessageBox(Format(A000MSG_ERR_FMT_ERRORE +#13#10+ LErr,[IfThen((DCOMNomeFile <> ''),A000MSG_ERR_FILE_NON_CREATO,'')]),ERRORE);
  end
  else if (DCOMNomeFile <> '') then
  begin
    if FileExists(DCOMNomeFile) then
    begin
      Msgbox.MessageBox(IfThen((DCOMMsg <> ''),DCOMMsg,A000MSG_MSG_ELABORAZIONE_TERMINATA),INFORMA);
      NomeFileGenerato:=DCOMNomeFile;
    end
    else
      Msgbox.MessageBox(MsgFileNonCreato,ERRORE);
  end
  else
    Msgbox.MessageBox(IfThen((DCOMMsg <> ''),DCOMMsg,A000MSG_MSG_ELABORAZIONE_TERMINATA),INFORMA);

  // forza submit per chiudere frame e presentare risultato elaborazione
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnShowElabError.HTMLName]));
  }

  // avvia il task di elaborazione
  FElabServer.TipoElab:=TTipoElab((Sender as TIWAjaxNotifier).Tag);
  LAppID:=GGetWebApplicationThreadVar.AppID;

  FElabServer.Inizializza;
  FElabServer.Task:=TTask.Create(
    procedure
    var
      LLstSessioni: TList;
      i: Integer;
      LStopwatch: TStopwatch;
    begin
      // 1. imposta la variabile GGetWebApplicationThreadVar per il task di elaborazione
      LLstSessioni:=GSessions.LockList;
      try
        for i:=0 to LLstSessioni.Count - 1 do
        begin
          if LAppID = (TObject(LLstSessioni.Items[i]) as TIWApplication).AppID then
          begin
            GSetWebApplicationThreadVar((TObject(LLstSessioni.Items[i]) as TIWApplication));
            Break;
          end;
        end;
      finally
        GSessions.UnLockList(LLstSessioni);
      end;

      // 2. esegue il task di elaborazione
      // avvia timer di precisione per tempo elaborazione
      LStopwatch:=TStopwatch.StartNew;
      try
        if FElabServer.TipoElab = TTipoElabRec.Server then
        begin
          // elaborazione lato server:
          //normalmente usato per richiamare il B028
          //(o altra elaborazione che non può prevedre la struttura a ciclo usata in StartElaborazioneCiclo
          ElaborazioneServer;
        end
        else if FElabServer.TipoElab = TTipoElabRec.CicloServer then
        begin
          // elaborazione lato server alternativa a StartElaborazioneCiclo,
          //ma usa tutti i suoi elementi (InizioElaborazione-ElaboraElemento-ElementoSuccessivo-FineCicloElaborazione)
          //ingloba la gestione con finta progressbar eseguendola tutta lato server
          FElabServer.MessaggioTask:=ElaborazioneCicloServer;
        end;

        // stop timer di precisione per tempo elaborazione
        LStopwatch.Stop;
      except
        // Necessario perchè se vengono intercettati errori allora viene visualizzato anche in async il messaggio
        // di errore gestito in seguito nel caso di file non creato.
        on E:Exception do
        begin
          // stop timer di precisione per tempo elaborazione
          LStopwatch.Stop;

          // imposta il messaggio di errore
          FElabServer.ErroreTask:=E.Message;
        end;
      end;

      // al termine dell'elaborazione salva la durata di elaborazione ed elimina il task
//      TThread.Queue(nil,
//        procedure
//        begin
          FElabServer.DurataTask:=LStopwatch.ElapsedMilliseconds;
          FElabServer.Task:=nil;
//        end
//      );
    end
  );
  FElabServer.Task.Start;

  // tenta di consentire l'avvio del task
  TThread.Sleep(100);

  // notifica al metodo di verifica fine elaborazione
  // LogConsole(Format('Attendo inizialmente %d secondi per il prossimo controllo...',[FElabServer.IntervalloPing div 1000]));
  AJNControllaFineElaborazione.Notify;
end;

procedure TWR100FBase.AJNControllaFineElaborazioneNotify(Sender: TObject);
begin
  // verifica se l'elaborazione è terminata (in quel caso Task = nil)
  if Assigned(FElabServer.Task) then
  begin
    // l'elaborazione è ancora in corso
    // effettua una sleep per il tempo definito in IntervalloPing
    TThread.Sleep(FElabServer.IntervalloPing);
    // LogConsole(Format('Attendo %d secondi per il prossimo controllo...',[FElabServer.IntervalloPing div 1000]));

    // workaround: il notify ripetuto sullo stesso notifier non funziona
    if Sender = AJNControllaFineElaborazione then
      AJNControllaFineElaborazione2.Notify
    else
      AJNControllaFineElaborazione.Notify;

    Exit;
  end;

  // segnala fine elaborazione
  if FShowDurataElaborazione then
    grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,FElabServer.DurataTask / MSecsPerDay)
  else
    grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='';

  // chiude il frame di attesa elaborazione se presente
  if WC022FMsgElaborazioneFM <> nil then
  begin
    WC022FMsgElaborazioneFM.Chiudi;
    WC022FMsgElaborazioneFM:=nil;
  end;

  if FElabServer.TipoElab = TTipoElabRec.Server then
  begin
    // visualizza il risultato dell'elaborazione
    if FElabServer.ErroreTask  <> '' then
    begin
      MsgBox.MessageBox(Format(A000MSG_ERR_FMT_ERRORE + #13#10 + FElabServer.ErroreTask,[IfThen((DCOMNomeFile <> ''),A000MSG_ERR_FILE_NON_CREATO,'')]),ERRORE);
    end
    else if (DCOMNomeFile <> '') then
    begin
      if FileExists(DCOMNomeFile) then
      begin
        Msgbox.MessageBox(IfThen((DCOMMsg <> ''),DCOMMsg,A000MSG_MSG_ELABORAZIONE_TERMINATA),INFORMA);
        NomeFileGenerato:=DCOMNomeFile;
      end
      else
        Msgbox.MessageBox(MsgFileNonCreato,ERRORE);
    end
    else
      Msgbox.MessageBox(IfThen((DCOMMsg <> ''),DCOMMsg,A000MSG_MSG_ELABORAZIONE_TERMINATA),INFORMA);
  end
  else if FElabServer.TipoElab = TTipoElabRec.CicloServer then
  begin
    // il messaggio da visualizzare è contenuto in "MessaggioTask"
    FMessaggioElaborazione:=FElabServer.MessaggioTask;
  end;

  // forza submit per chiudere il frame e presentare il risultato dell'elaborazione
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnShowElabError.HTMLName]));
end;

//ridefinire
//Elaborazione lato server
procedure TWR100FBase.ElaborazioneServer;
begin
  //ridefinire
end;

procedure TWR100FBase.AfterElaborazione;
begin
  // ridefinire
end;

//ridefinire
//Utile se si decide di modificare label, title o filename di WC022
procedure TWR100FBase.InizializzaMsgElaborazione;
begin
  //ridefinire
end;

// Gestione Notify per messaggio di attesa durante il richiamo al B028    ----- fine

function TWR100FBase.ElaborazioneCicloServer(const PShowDurataElaborazione: Boolean = False): String;
begin
  // segnala al programma di visualizzare la durata dell'elaborazione
  FShowDurataElaborazione:=PShowDurataElaborazione;

  try
    A000SessioneWeb.AnnullaTimeOut;
    repeat
      RipartiElaborazione:=False;
      try
        InizioElaborazione;
        if TotalRecordsElaborazione > 0 then
        begin
          ElaboraElemento;
          while ElementoSuccessivo do
            ElaboraElemento;
        end;
        NomeFileGenerato:='';
        StreamGenerato:='';
        FineCicloElaborazione;
        Result:=ElaborazioneTerminata;
        FErroreElaborazione:=False;
        DistruzioneOggettiElaborazione(FErroreElaborazione);
      except
        on E:Exception do
        begin
          Result:=Format(A000MSG_ERR_FMT_ERRORE,[E.Message]);
          FErroreElaborazione:=True;
          DistruzioneOggettiElaborazione(FErroreElaborazione);
        end;
      end;
    until not RipartiElaborazione;
  finally
    A000SessioneWeb.RipristinaTimeOut;
  end;
end;

{ TElabServer }

procedure TElabServer.Create;
begin
  TipoElab:=TTipoElabRec.Server;
  Task:=nil;
  DurataTask:=0;
  MessaggioTask:='';
  ErroreTask:='';
  IntervalloPing:=INTERVALLO_PING_ELABORAZIONE;
end;

procedure TElabServer.Destroy;
begin
  ForzaArresto;
end;

procedure TElabServer.Inizializza;
begin
  DurataTask:=0;
  ErroreTask:='';
  IntervalloPing:=INTERVALLO_PING_ELABORAZIONE;
end;

procedure TElabServer.ForzaArresto;
begin
  if Assigned(Task) then
  begin
    Task.Cancel;

    while Assigned(Task) do
    begin
      if not Task.Wait(1000) then
        CheckSynchronize;
    end;
  end;
end;

end.
