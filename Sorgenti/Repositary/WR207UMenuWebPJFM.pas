unit WR207UMenuWebPJFM;

interface

uses
  Windows, Messages, Dialogs, IWBaseContainerLayout, OracleData,
  IWContainerLayout, IWTemplateProcessorHTML, IWContainer, Jpeg, pngimage,
  IWVCLComponent, IWVCLBaseContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, Classes, Controls, Forms, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompMenu, meIWMenu, ActnList, ImgList,
  meIWImageList, Menus, A000UCostanti, A000USessione, meIWImage, meIWImageFile, SysUtils,
  medpIWMessageDlg,A000UInterfaccia, IWCompJQueryWidget, meIWLink,IWAppForm,
  WR200UBaseFM, IWImageList,A000UMessaggi, WR206UMenuFM, IWApplication,
  IWBaseLayoutComponent,WR100UBase,WR010UBase,WC700USelezioneAnagrafeFM, System.Actions,
  medpIWC700NavigatorBar, IWGlobal, DB, C004UParamForm, StrUtils, Generics.Collections,
  meIWLabel, meIWGrid, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent, IWCompExtCtrls, medpIWImageButton, IWCompButton, meIWButton;
type

  TWR207FMenuWebPJFM = class(TWR206FMenuFM)
    actMsgElaborazioni: TAction;
    File1: TMenuItem;
    Amministrazionesistema1: TMenuItem;
    Personale1: TMenuItem;
    Ambiente1: TMenuItem;
    Interfacce1: TMenuItem;
    Moduliaccessori1: TMenuItem;
    N4: TMenuItem;
    N1: TMenuItem;
    N8: TMenuItem;
    Messaggidelleelaborazioni1: TMenuItem;
    N9: TMenuItem;
    AziendeOperatori1: TMenuItem;
    Operatori1: TMenuItem;
    Aziende1: TMenuItem;
    FiltroFunzioni1: TMenuItem;
    FiltroAnagrafe1: TMenuItem;
    FiltroDizionario1: TMenuItem;
    Accessi1: TMenuItem;
    Permessi1: TMenuItem;
    Logindipendenti1: TMenuItem;
    actOperatori: TAction;
    actAziende: TAction;
    actPermessi: TAction;
    actFiltroAnagrafe: TAction;
    actFiltroFunzioni: TAction;
    actFiltroDizionario: TAction;
    actLoginDipendenti: TAction;
    actAccessi: TAction;
    actDatiLiberi: TAction;
    Definizionedatiliberi1: TMenuItem;
    actUtilityDB: TAction;
    Utilitydeldatabase1: TMenuItem;
    abelledatiliberi1: TMenuItem;
    Monitoraggiotabelladilog1: TMenuItem;
    actMonitoraggioLog: TAction;
    EntiLocalieRegioni1: TMenuItem;
    actEntiLocali: TAction;
    actTabelleDatiLiberi: TAction;
    actRelazioni: TAction;
    Relazionitracampianagrafici1: TMenuItem;
    actAllineaStorici: TAction;
    AllineaStorici1: TMenuItem;
    actGestioneSicurezza: TAction;
    actDataLavoro: TAction;
    actFiltroCessati: TAction;
    CambioPassword1: TMenuItem;
    Datadilavoro1: TMenuItem;
    Visualizzadipendenticessati1: TMenuItem;
    N26: TMenuItem;
    actDatiCalcolati: TAction;
    actCheckRimborsi: TAction;
    actManipolazioneDati: TAction;
    Utilitymanipolazionedati1: TMenuItem;
    actElaborazioneFluper: TAction;
    actAnagraficaStipendi: TAction;
    Anagraficastipendi1: TMenuItem;
    actInformazioniSu: TAction;
    Informazionisu1: TMenuItem;
    Profiliiterautorizzativi1: TMenuItem;
    actProfiloIterAutorizzativi: TAction;
    actCambioAzienda: TAction;
    Cambioazienda1: TMenuItem;
    NWR207_2: TMenuItem;
    NWR207_3: TMenuItem;
    actFotoDipendente: TAction;
    actDownloadTeamViewer: TAction;
    DownloadTeamViewer1: TMenuItem;
    procedure actExecute(Sender: TObject); override;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actGestioneSicurezzaExecute(Sender: TObject);
    procedure actDataLavoroExecute(Sender: TObject);
    procedure actFiltroCessatiExecute(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    FSenderTag: Integer;
    SetFormParams: Boolean;
    LstFormParams: TStringList;
    EreditaSelAnagrafe: Boolean;
    actFiltroCessatiImageIndex: Integer;
    grdMenuSceltaRapida:TmeIWGrid; // creata a runtime
    procedure SetParams(FForm:TWR100FBase);
    procedure ResultDataLavoro(Sender: TObject; Result: Boolean; Valore: String);
    function AggiungiImmagineCustom(nomeImg: String): Integer;
    function InformazioniSu:string;
    procedure CreaIconeMenuSceltaRapida;
  protected
    procedure AttivaForm(PTag: Integer);
    function CreaForm(PTag: Integer): TWR100FBase; virtual;
    function FindActionMenu(PTag: Integer):TAction; virtual;
  public
    procedure ImpostaCheckFiltroCessati(val: Boolean);
    procedure Accedi(PTag:Integer; Params: String; EreditaSelezioneDaFormChiamante: Boolean);
  end;

implementation

{ DONE : TEST IW 14 OK }
// WB007UManipolazioneDati era stato spento durante la migrazione
uses
  WR102UGestTabella,
  WC020UInputDataOreFM,
  WC023UCambioPasswordFM,
  WA005UDatiLiberi,
  WA011UEntiLocali,
  WA026UDatiLiberi,
  WA044UAllineaStorici,
  WA083UMsgElaborazioni,
  WA093UOperazioni,
  WA099UUtilityDB,
  WA136URelazioniAnagrafe,
  WA146UFotoDipendente,
  WA179UProfiliIterAut,
  WA180UOperatori,
  WA181UAziende,
  WA182UPermessi,
  WA183UFiltroAnagrafe,
  WA184UFiltroFunzioni,
  WA185UFiltroDizionario,
  WA186ULoginDipendenti,
  WA187UAccessi,
  WA198UDatiCalcolati,
  WA201UCambioAzienda,
  WB007UManipolazioneDati,
  WP430UAnagrafico,
  WP656UElaborazioneFluper,
  C180FunzioniGenerali,
  L021Call,
  IW.CacheStream,
  C021UDocumentiManagerDM;

{$R *.dfm}

function TWR207FMenuWebPJFM.FindActionMenu(PTag: Integer): TAction;
var
  i:Integer;
begin
  Result:=nil;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if (ActionList.Actions[i] as TAction).Tag = PTag  then
    begin
      Result:=(ActionList.Actions[i] as TAction);
      Break;
    end;
  end;
end;

procedure TWR207FMenuWebPJFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  SetFormParams:=False;
  //Aggiungo a ImageList le immagini non relative a funzioni col tag, ma che devono essere comunque usate nel menu
  actFiltroCessatiImageIndex:=AggiungiImmagineCustom('check');
  actFiltroCessati.ImageIndex:=actFiltroCessatiImageIndex;
  grdMenuSceltaRapida:=nil;
  if not WR000DM.RichiestaAssistenza then
    actDownloadTeamViewer.Visible:=False;
end;

procedure TWR207FMenuWebPJFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  //crea gli elementi del menù solo se non sono già stati creati in precedenza.
  CreaIconeMenuSceltaRapida;
end;

function TWR207FMenuWebPJFM.InformazioniSu:string;
var
  listaModuliInstallati:string;
begin
  listaModuliInstallati:='';
  if Parametri.ModuliInstallati = '' then
    listaModuliInstallati:='nessuno'
  else
    listaModuliInstallati:=StringReplace(Parametri.ModuliInstallati,#13,#13#10,[rfReplaceAll]);

  Result:='IrisCloud - ' + Parametri.NomePJ + #13#10 +
          'Versione: ' + Parametri.VersionePJ + '(' + Parametri.BuildPJ  + ')' + #13#10 +
          'Data di rilascio: ' + Parametri.DataPJ + #13#10 + #13#10 +
          'by Mondo Edp' + #13#10 +
          'Via Barbaresco, 11 - 12100 CUNEO' + #13#10 + #13#10 +
          'Contatti:' + #13#10 +
          'e-mail informazioni: staff@mondoedp.com' + #13#10 +
          'e-mail assistenza: assistenza@mondoedp.com' + #13#10 +
          'Tel: 0171 34 66 85 - Fax: 0171 34 66 86' + #13#10 + #13#10 +
          'Moduli installati:' + #13#10 +
          listaModuliInstallati;
end;

procedure TWR207FMenuWebPJFM.CreaIconeMenuSceltaRapida;
// creazione delle icone di accesso rapido per il menu
var
  i,x: Integer;
  UrlImg, Code: String;
  Azione: TAction;
  ImgList: TStringList;
  CategorieAzioni:TCategorieAzioniRapide;
  CategoriaAzioneAttuale:TCategoriaAzioniRapide;
  GridBloccoCat,GridIcone:TmeIWGrid;
  IconaCorrente:TmeIWImageFile;
begin
  if Self.grdMenuSceltaRapida <> nil then
    Exit;

  CategorieAzioni:=Self.GetCategorieAzioniRapide;

  if CategorieAzioni = nil then
    raise Exception.Create('Menu: errore durante la creazione della mappa per il menù di scelta rapida');


  // A parte imgList gli oggetti istanziati da ora in avanti hanno Owner = Self.
  // Vengono in ogni caso dellocati direttamente dal form quando viene distrutto.
  // Creo la tabella contenitore
  grdMenuSceltaRapida:=TmeIWGrid.Create(Self);

  grdMenuSceltaRapida.Parent:=Self.Parent;
  grdMenuSceltaRapida.Name:='grdMenuSceltaRapida';
  grdMenuSceltaRapida.Css:='';
  grdMenuSceltaRapida.RowCount:=0;
  grdMenuSceltaRapida.ColumnCount:=1;
  try
    try
      imgList:=TStringList.Create;
      for x:=0 to CategorieAzioni.Count - 1 do
      begin
        CategoriaAzioneAttuale:=CategorieAzioni[x];
        // Creo la tabella che conterrà la descrizione della categoria (riga 1)
        // e la tabella con le immagini (riga 2);
        GridBloccoCat:=TmeIWGrid.Create(Self);
        GridBloccoCat.Css:='int_sez3Cloud_menuCat';
        GridBloccoCat.RowCount:=2;
        GridBloccoCat.ColumnCount:=1;
        // Descrizione categoria
        GridBloccoCat.Cell[0,0].Control:=TmeIWLabel.Create(Self);
        (GridBloccoCat.Cell[0,0].Control as TmeIWLabel).Caption:=CategoriaAzioneAttuale.Nome;
        // Creo la tabella con le icone
        GridIcone:=TmeIWGrid.Create(Self);
        GridIcone.Css:='int_sez3Cloud_menuIco';
        GridIcone.RowCount:=1;
        GridIcone.ColumnCount:=Length(CategoriaAzioneAttuale.Azioni);
        for i:=0 to Length(CategoriaAzioneAttuale.Azioni) - 1 do
        begin
          Azione:=CategoriaAzioneAttuale.Azioni[i];
          UrlImg:='';
          if (Azione.ImageIndex > -1) and (Azione.Tag > -1) then
          begin
            // crea una nuova icona e la aggiunge alla tabella
            IconaCorrente:=TmeIWImageFile.Create(Self);
            IconaCorrente.AltText:=Azione.Caption;
            IconaCorrente.Cacheable:=True;
            IconaCorrente.Css:='icona iconaMenuSceltaRapida';
            IconaCorrente.ExtraTagParams.Add('medpdescr=' + Azione.Hint);
            try
              { DONE : TEST IW 14 OK }
              UrlImg:=WR000DM.IWImageList.ExtractImageToCache(Azione.ImageIndex);
            except
              // ExtractImageToCache può sollevare eccezioni perché genera un file png nella usercachedir
              // se fallisce, sono comunque presenti immagini png con il nome uguale al tag della action
              UrlImg:=Format('img/%d.png',[Azione.Tag]);
              ImgList.Add(UrlImg);
            end;
            IconaCorrente.ImageFile.URL:=UrlImg;
            IconaCorrente.Tag:=Azione.Tag;
            IconaCorrente.OnClick:=actExecute;
            GridIcone.Cell[0,i].Control:=IconaCorrente;
            IconaCorrente:=nil;
          end;
        end;
        // Aggiungiamo la tabella con le icone alla tabella padre...
        GridBloccoCat.Cell[1,0].Control:=GridIcone;
        GridIcone:=nil;
        // e la tabella con descrizione e icone alla tabella contenitore
        grdMenuSceltaRapida.RowCount:=grdMenuSceltaRapida.RowCount + 1;
        grdMenuSceltaRapida.Cell[grdMenuSceltaRapida.RowCount - 1,0].Control:=GridBloccoCat;
        GridBloccoCat:=nil;
      end;

      // utilizza una funzione js per precaricare le immagini
      if ImgList.Count > 0 then
      begin
        Code:='try { ' +
              '  preloadImgVar("%s"); ' +
              '} ' +
              'catch(err) {} ';
        Code:=Format(Code,[ImgList.CommaText]);
        (Self.Parent as TWR010FBase).AddToInitProc(Code);
      end;
    except
      on E:Exception do
      begin
        raise Exception.Create('Menu: Errore in fase di generazione del menu: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(CategorieAzioni);
    FreeAndNil(ImgList);
  end;
end;

//Funzione richiamata da link per accedi Form. In questo caso vanno settati parametri specifici per i form
procedure TWR207FMenuWebPJFM.Accedi(PTag: Integer; Params: String;EreditaSelezioneDaFormChiamante: Boolean);
begin
  (Self.Parent as TWR100FBase).Log('Traccia',Format('Accedi Form %d',[PTag]));
  LstFormParams:=TStringList.Create();
  try
    LstFormParams.Delimiter:=ParamDelimiter;
    LstFormParams.StrictDelimiter:=True;
    LstFormParams.DelimitedText:=Params;
    SetFormParams:=True;
    EreditaSelAnagrafe:=EreditaSelezioneDaFormChiamante;

    //Caratto 14/03/2014 getione funzione non abilitata
    //salvo tag della form attiva
    FSenderTag:=(GGetWebApplicationThreadVar.ActiveForm as TWR010FBase).Tag;

    actExecute(FindActionMenu(PTag));
    SetFormParams:=False;
  finally
    FreeAndNil(LstFormParams);
  end;
end;

procedure TWR207FMenuWebPJFM.actExecute(Sender: TObject);
var
  (*RICERCA DEL FILE IN LOCALE O SU SITO MEDP
  PathTeamViewer: string;
  HTTPResponse: IHTTPResponse;
  HTTPHeaders: TArray<TNameValuePair>;*)
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
  C021DM: TC021FDocumentiManagerDM;
  HashCalc: String;
  i: integer;
begin
  {Gestione pressione informazioni}
  if Sender = actInformazioniSu then
  begin
    MsgBox.MessageBox(InformazioniSu,INFORMA,'Informazioni su...');
    Exit;
  end
  else if Sender = actDownloadTeamViewer then
  begin
    A000SessioneWEB.AnnullaTimeOut;
    try
      C021DM:=TC021FDocumentiManagerDM.Create(Owner);
      // estrae il file con i metadati associati
      try
        //Cerca la posizione nell'array del file da scaricare
        for i:=1 to Length(VettFileInstallati) do
          if VettFileInstallati[i].Codice = Supporto then
            break;

        LResCtrl:=C021DM.GetById(VettFileInstallati[i].Id,True,LDoc);
        If C021DM.GetBase64HashSHA512(LDoc.Blob) <> LDoc.Hash then  //confronta l'hash calcolato con quello salvato su DB prima di scaricare
        begin
          MsgBox.MessageBox('File corrotto. Download interrotto.',ESCLAMA);
          Exit;
        end;
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
      (*RICERCA DEL FILE IN LOCALE O SU SITO MEDP
      NB necessario aggiungere TNetHTTPClient e TNetHTTPRequest all'interfaccia per il funzionamento
      PathTeamViewer:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B016','PathServizi','') + '\TMVW_medp.exe';
      if FileExists(PathTeamViewer) then
        GGetWebApplicationThreadVar.SendFile(PathTeamViewer, True,'application/x-download','TMVW_medp.exe')
      else
      begin
        HTTPResponse:=HTTPRequest.Get('https://www.mondoedp.com/uploads/media/irisftp/download/TMVW_medp.exe');
        if HTTPResponse.StatusCode = 200 then
          GGetWebApplicationThreadVar.SendStream(HTTPResponse.ContentStream, True,'application/x-download','TMVW_medp.exe')
        else
          raise Exception.Create(Format('Errore nella comunicazione con il server - HTTP status: %s - %s - %s', [HTTPResponse.StatusCode.ToString, HTTPResponse.StatusText, HTTPResponse.ContentAsString]));
      end;*)
    finally
      FreeAndNil(C021DM);
      if Assigned(LDoc) then
        FreeAndNil(LDoc);
      A000SessioneWEB.RipristinaTimeOut;
    end;
    Exit;
  end;
  try
    inherited;
  except
    on E:EAbort do
      Abort;
  end;
  // determina la form in base alla voce selezionata
  if NewForm or (F = nil) then
  begin
    if WR000DM.History.Count >= ELEMENTI_HISTORY then
    begin
      MsgBox.WebMessageDlg(A000MSG_MSG_LIMITE_HISTORY,mtInformation,[mbOk],nil,'');
      Exit;
    end;
    F:=CreaForm(FTag);  //CreaForm definito virtual. Esegue quello del figlio istanziato
  end;

  if F = nil then
    exit;

  AttivaForm(FTag);
end;

function TWR207FMenuWebPJFM.CreaForm(PTag: Integer): TWR100FBase;
begin
  Result:=nil;
  (Self.Parent as TWR100FBase).Log('Traccia',Format('CreaForm %d',[PTag]));

  //Verifica se deve essere selezionata almeno una anagrafica
  if (L021RichiedeAnagraficaSelezionata(PTag)) and
     (not SetFormParams) and
     (WR000DM.C700NavigatorBarMain <> nil) and
     (TmedpIWC700NavigatorBar(WR000DM.C700NavigatorBarMain).selAnagrafe.RecordCount = 0) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Abort;
  end;

  if PTag = actTabelleDatiLiberi.Tag then
    Result:=TWA005FDatiLiberi.Create(A000App)
  else if PTag = actEntiLocali.Tag then
    Result:=TWA011FEntiLocali.Create(A000App)
  else if PTag = actDatiLiberi.Tag then
    Result:=TWA026FDatiLiberi.Create(A000App)
  else if PTag = actMsgElaborazioni.Tag then
    Result:=TWA083FMsgElaborazioni.Create(A000App)
  else if PTag = actMonitoraggioLog.Tag then
    Result:=TWA093FOperazioni.Create(A000App)
  else if PTag = actUtilityDB.Tag then
    Result:=TWA099FUtilityDB.Create(A000App)
  else if PTag = actOperatori.Tag then
    Result:=TWA180FOperatori.Create(A000App)
  else if PTag = actAziende.Tag then
    Result:=TWA181FAziende.Create(A000App)
  else if PTag = actPermessi.Tag then
    Result:=TWA182FPermessi.Create(A000App)
  else if PTag = actFiltroAnagrafe.Tag then
    Result:=TWA183FFiltroAnagrafe.Create(A000App)
  else if PTag = actFiltroFunzioni.Tag then
    Result:=TWA184FFiltroFunzioni.Create(A000App)
  else if PTag = actFiltroDizionario.Tag then
    Result:=TWA185FFiltroDizionario.Create(A000App)
  else if PTag = actProfiloIterAutorizzativi.Tag then
    Result:=TWA179FProfiliIterAut.Create(A000App)
  else if PTag = actLoginDipendenti.Tag then
    Result:=TWA186FLoginDipendenti.Create(A000App)
  else if PTag = actAccessi.Tag then
    Result:=TWA187FAccessi.Create(A000App)
  else if PTag = actRelazioni.Tag then
    Result:=TWA136FRelazioniAnagrafe.Create(A000App)
  else if PTag = actAllineaStorici.Tag then
    Result:=TWA044FAllineaStorici.Create(A000App)
  else if PTag = actDatiCalcolati.Tag then
    Result:=TWA198FDatiCalcolati.Create(A000App)
  { DONE : TEST IW 14 OK }
  else if PTag = actManipolazioneDati.Tag then
    Result:=TWB007FManipolazioneDati.Create(A000App)
  else if PTag = actElaborazioneFluper.Tag then
    Result:=TWP656FElaborazioneFluper.Create(A000App)
  else if PTag = actAnagraficaStipendi.Tag then
    Result:=TWP430FAnagrafico.Create(A000App)
  else if PTag = actCambioAzienda.Tag then
    Result:=TWA201FCambioAzienda.Create(A000App)
  else if PTag = actFotoDipendente.Tag then
    Result:=TWA146FFotoDipendente.Create(A000App);
end;

procedure TWR207FMenuWebPJFM.AttivaForm(PTag: Integer);
var
  ChiudiTab: Boolean;
  Conferma: String;
  F1: TWR100FBase;
begin
  (Self.Parent as TWR100FBase).Log('Traccia',Format('AttivaForm %d',[PTag]));

  if not NewForm then
  begin
    //Se form già presente
    if ReloadForm then
    begin
      (Self.Parent as TWR100FBase).Log('Traccia',Format('AttivaForm Reload %d',[PTag]));
      //Se selezione tramite menù deve ricreare il form
      ChiudiTab:=True;
      F.OnTabClosing(ChiudiTab,Conferma);
      if ChiudiTab then
      begin
        //Chiudo Pagina vecchia e ricreo
        F.ClosePage;
        F1:=CreaForm(PTag);
        SetParams(F1);
        F1.OpenPage;
      end
      else
      begin
        //Modifiche pendenti sul form. segnalo e non faccio alcun refresh
        MsgBox.WebMessageDlg(A000MSG_ERR_FORM_CON_MODIFICHE,mtInformation,[mbOK],nil,'');
        F.Show;
      end;
    end
    else
    begin
      //se selezione dalla history deve eseguire refreshPage
      (Self.Parent as TWR100FBase).Log('Traccia',Format('AttivaForm Refresh %d',[PTag]));
      F.RefreshPageAttivo:=True;
      F.Show;
    end;
  end
  else
  begin
    SetParams((F as TWR100FBase));
    F.OpenPage;
  end;
end;

procedure TWR207FMenuWebPJFM.SetParams(FForm: TWR100FBase);
var
  i: Integer;
begin
  if FForm = nil then
    raise Exception.Create('Menu: form non indicata!');

  if SetFormParams then //Apertura form tramite accedi. settaggio parametri sul form
  try
    //Caratto 14/03/2014 getione funzione non abilitata
    //imposto su form il tag della form dalla quale è stata aperta
    FForm.OpenerTag:=FSenderTag;

    for i:=0 to LstFormParams.Count - 1 do
      FForm.setParam(LstFormParams.Names[i],LstFormParams.ValueFromIndex[i]);
    if EreditaSelAnagrafe and
       (FForm.grdC700 <> nil) and
       (Self.Owner is TWR100FBase) and
       ((Self.Owner as TWR100FBase).grdC700 <> nil)
    then
      FForm.grdC700.SelezioneDaEreditare:=(Self.Owner as TWR100FBase).grdC700.WC700FM.C700SelAnagrafeBridge;
  except
  end;
end;

procedure TWR207FMenuWebPJFM.actGestioneSicurezzaExecute(Sender: TObject);
var WC023FCambioPswFM : TWC023FCambioPasswordFM;
begin
  WC023FCambioPswFM:=TWC023FCambioPasswordFM.Create(Self.Parent);
  WC023FCambioPswFM.Visualizza;
end;

procedure TWR207FMenuWebPJFM.actDataLavoroExecute(Sender: TObject);
var WC020FInputDataOreFM : TWC020FInputDataOreFM;
begin
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self.Parent);
  WC020FInputDataOreFM.ImpostaCampiData('Data lavoro:',Parametri.DataLavoro,'dd/mm/yyyy');
  WC020FInputDataOreFM.ResultEvent:=ResultDataLavoro;
  WC020FInputDataOreFM.Visualizza('Data lavoro');
end;

procedure TWR207FMenuWebPJFM.ImpostaCheckFiltroCessati(val: Boolean);
begin
  actFiltroCessati.Checked:=val;
  WR000DM.VisualizzaCessati:=actFiltroCessati.Checked;
  if actFiltroCessati.Checked then
    actFiltroCessati.ImageIndex:=actFiltroCessatiImageIndex
  else
    actFiltroCessati.ImageIndex:=-1;
end;

procedure TWR207FMenuWebPJFM.actFiltroCessatiExecute(Sender: TObject);
var
  C004DMMenu: TC004FParamForm;
  i:Integer;
  AllineaHistory:Boolean;
begin
  inherited;
  ImpostaCheckFiltroCessati(not actFiltroCessati.Checked);

  //Salvare con la C004 lo stato dell'azione
  //Caratto 07/01/2015. Imposto valore in C004DM
  C004DMMenu:=CreaC004(SessioneOracle,WA001PaginaPrincipale,Parametri.ProgOper,False);
  C004DMMenu.PutParametro('CESSATI', IfThen(actFiltroCessati.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
  FreeAndNil(C004DMMenu);

  AllineaHistory:=False;
  //Allineo la C700 della pagina principale
  if WR000DM.C700NavigatorBarMain <> nil then
  begin
    with (WR000DM.C700NavigatorBarMain as TmedpIWC700NavigatorBar).WC700FM do
    begin
      PreparaListSQL;
      actConfermaExecute(actConferma);
    end;
  end;
  //Renderla disponibile alle successive C700 che verranno create per default con lo stesso stato della C700 principale
  // Massimo 20/01/2014: scorro tutti gli elementi della history e aggiorno se hanno C700.
  //Lo faccio SOLO per la pagina attiva (attualmente AllineaHistory = False)
  for i:=0 to WR000DM.History.Count - 1 do
  begin
    if (WR000DM.History.FormByIndex(i) as TWR100FBase).grdC700 <> nil then
    begin
      //Se è la C700 dela pagina principale la salto perchè già gestita prima
      if (WR000DM.C700NavigatorBarMain <> nil) and
         ((WR000DM.History.FormByIndex(i) as TWR100FBase).grdC700 = (WR000DM.C700NavigatorBarMain as TmedpIWC700NavigatorBar)) then
        Continue;
      if AllineaHistory or ((WR000DM.History.FormByIndex(i) as TWR100FBase) = (GGetWebApplicationThreadVar.ActiveForm as TIWAppForm)) then
        with (WR000DM.History.FormByIndex(i) as TWR100FBase).grdC700.WC700FM do
        begin
          //Riallineo la sezione di Parametri.Inibizioni
          PreparaListSQL;
          actConfermaExecute(actConferma);
        end;
    end;
  end;
end;

procedure TWR207FMenuWebPJFM.ResultDataLavoro(Sender: TObject; Result: Boolean; Valore: String);
var i,p: Integer;
  F102: TWR102FGestTabella;
  bSkip: Boolean;
  procedure AllineaC700(grdC700:TmedpIWC700NavigatorBar);
  begin
    with grdC700 do
    begin
      WC700FM.C700DataLavoro:=Parametri.DataLavoro;
      if WC700FM.C700MergeSettaPeriodo(selAnagrafe,Parametri.DataLavoro,Parametri.DataLavoro) then
      begin
        p:=0;
        if selAnagrafe.Active then
          p:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        selAnagrafe.Close;
        selAnagrafe.Open;
        selAnagrafe.SearchRecord('PROGRESSIVO',p,[srFromBeginning]);
        if Assigned(CambioProgressivoEvent) then
          CambioProgressivoEvent(nil);
      end;
    end;
  end;
begin
  if Result and (Parametri.DataLavoro <> StrToDate(Valore))  then
  begin
    Parametri.DataLavoro:=StrToDate(Valore);
    //Aggiornare T432
    with WR000DM do
    try
      R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
      selT432.Open;
      selT432.First;
      if Parametri.DataLavoro <> Date then
      begin
        selT432.Edit;
        selT432.FieldByName('UTENTE').AsString:=Parametri.Operatore;
        selT432.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
        selT432.Post;
      end
      else if not selT432.Eof then
        selT432.Delete;
      selT432.Close;
    except
    end;

    //Allineo la C700 della pagina principale
    if WR000DM.C700NavigatorBarMain <> nil then
    begin
      AllineaC700(WR000DM.C700NavigatorBarMain as TmedpIWC700NavigatorBar);
    end;

    // Massimo 20/01/2014: scorro tutti gli elementi della history e aggiorno se hanno C700.
    //Lo faccio sempre per la pagina attiva e opzionalmente per tutta la History
    for i:=0 to WR000DM.History.Count - 1 do
    begin
      //Aggiorno Status bar con nuova DataLavoro
      if Parametri.DataLavoro > 0 then
        (WR000DM.History.FormByIndex(i) as TWR100FBase).grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Parametri.DataLavoro)
      else
        (WR000DM.History.FormByIndex(i) as TWR100FBase).grdStatusBar.StatusBarComponent('DATALAVORO').Value:=DateToStr(Date);

      //Aggiorno tabella se storica con visione corrente attiva
      if (WR000DM.History.FormByIndex(i) is TWR102FGestTabella) then
      begin
        F102:=(WR000DM.History.FormByIndex(i) as TWR102FGestTabella);
        if (F102.InterfacciaWR102.GestioneStoricizzata) and
           (F102.actVisioneCorrente.Checked) and
           (F102.WR302DM.selTabella.State = dsBrowse)  then
        begin
          F102.actVisioneCorrenteExecute(Self);
        end;
      end;

      //Aggiorno C700
      if (WR000DM.History.FormByIndex(i) as TWR100FBase).grdC700 <> nil then
      begin
        //Se è la C700 dela pagina principale la salto perchè già gestita prima
        bSkip:=False;
        if (WR000DM.C700NavigatorBarMain <> nil) and
           ((WR000DM.History.FormByIndex(i) as TWR100FBase).grdC700 = (WR000DM.C700NavigatorBarMain as TmedpIWC700NavigatorBar)) then
          bSkip:=True;
        if not bSkip then
          AllineaC700((WR000DM.History.FormByIndex(i) as TWR100FBase).grdC700);
      end;

      //Richiamo metodo personalizzato per evenutali azioni custom
      (WR000DM.History.FormByIndex(i) as TWR100FBase).CambioDataLavoro;
    end;
  end;
end;

(*
  Funzione che aggiunge l'immagine all'imageList anche se non è legata ad un tag particolare (es. check.png)
  Input: nomeFile SENZA estensione
  Output: ImageIndex
*)
function TWR207FMenuWebPJFM.AggiungiImmagineCustom(nomeImg: String):Integer;
var
  ImgFile,ImgFileCompleto,Errore: String;
begin
  // 1. carica le immagini in formato png nella imagelist
  // nota: tutte le immagini devono avere la stessa dimensione,
  //       che al momento è definita in 16 x 16
  Errore:='';
  Result:=-1;
  try
    ImgFile:=Format('%s.png',[nomeImg]);

    // cerca il file con l'immagine prima nella cartella personalizzata,
    // poi in wwwroot\img
    if FileExists(WR000DM.UsrFolder + ImgFile) then
      ImgFileCompleto:=WR000DM.UsrFolder + ImgFile
    else if FileExists(WR000DM.BaseFolder + ImgFile) then
      ImgFileCompleto:=WR000DM.BaseFolder + ImgFile
    else
      ImgFileCompleto:='';

    Errore:=WR000DM.CaricaImmagine(ImgFileCompleto,'',False);
    // eccezione
    if Errore <> '' then
      raise Exception.Create(Errore);
    Result:=WR000DM.IWImageList.Count-1;
  except
    on E: Exception do
    begin
      (Self.Parent as TWR010FBase).Log('Errore','Errore durante il caricamento delle icone di menu',E);
      A000App.ShowMessage('Errore durante il caricamento delle icone di menu:' + CRLF + E.Message);
    end;
  end;
end;

end.

