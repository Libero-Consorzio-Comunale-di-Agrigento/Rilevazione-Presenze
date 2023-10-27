unit R013UIterBase;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi,
  C018UIterAutDM, WC018URiepilogoIterFM, WC026UAllegatiIterFM, C021UDocumentiManagerDM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Variants, StrUtils, Math, meIWLabel, meIWEdit, meIWButton, meIWGrid, meIWCheckBox,
  SysUtils, IWAppForm,IWControl,IWHTMLControls, DB, Oracle, OracleData, IWApplication,
  IWTemplateProcessorHTML, Classes, ActnList, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWCompLabel, Controls, IWVCLBaseControl, meIWRadioGroup,
  IWBaseControl, IWBaseHTMLControl, IWCompCheckbox, meTIWAdvRadioGroup,
  IWAdvRadioGroup, meIWLink, IWCompGrids, IWDBGrids, medpIWDBGrid, IWCompButton,
  IWCompExtCtrls, meIWImageFile, Vcl.Graphics, meIWImage, meIWComboBox,
  IWCompEdit, IW.Browser.InternetExplorer, IW.Browser.Firefox, IW.Browser.Chrome,
  IW.Browser.Browser, Datasnap.DBClient;

type
  TProcObject = procedure(Sender: TObject) of object;

  TProcObjectBool = procedure(Sender: TObject; var Ok: Boolean) of object;

  TR013FIterBase = class(TR012FWebAnagrafico)
    pmnTabella: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    grdRichieste: TmedpIWDBGrid;
    mnuEsportaCsv: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure mnuEsportaCsvClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    FIter: String;
    FOnApplicaFiltro: TProcObject;
    FOnModificaTutto: TProcObject;
    FOnConfermaTutto: TProcObjectBool;
    FOnAnnullaTutto: TProcObject;
    FOnAutorizzaTutto: TProcObjectBool;
    FOnDownloadAllegati: TProcObject;
    FChkArr: array of TmeIWCheckBox;
    chkVisto,
    chkNoVisto,
    chkLastClicked: TmeIWCheckBox;
    OldPeriodoDal,
    OldPeriodoAl: String;
    FVisti: Boolean;
    FBloccaGestione: Boolean;
    FEditMultiplo: Boolean;
    FAutorizzaMultiplo: Boolean;
    FInModificaTutti: Boolean;
    FInAutorizzaTutti: Boolean;
    OperazioneOK: Boolean;
    FNumCheck: Integer;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    WC026: TWC026FAllegatiIterFM;
    ImgAllegati: TmeIWImageFile;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    FCampiMetadati: TStringList;
    cdsMetadati: TClientDataset;
    DimAllegati, NrAllegati: Int64; //Dimensione totale e nr di allegati visibili con la selezione corrente
    function  GetIter: String;
    procedure SetIter(const Val: String);
    function  GetEditMultiplo: Boolean;
    procedure SetEditMultiplo(const Val: Boolean);
    function  GetAutorizzaMultiplo: Boolean;
    procedure SetAutorizzaMultiplo(const Val: Boolean);
    function  IndexOfCheck(const PTipo: TTipoRichieste): Integer;
    function  EsisteCheck(const PTipo: TTipoRichieste): Boolean;
    function  AddCheck(const PTipo: TTipoRichieste): Boolean;
    function  GetBloccaGestione: Boolean;
    procedure SetBloccaGestione(const Val: Boolean);
    procedure FormatAndRaiseError(E: Exception; const PNomeProc: String; const PFase: String = '');
    procedure OnTipoRichiesteClick(Sender: TObject);
    procedure OnTipoRichiesteAsyncClick(Sender: TObject; EventParams: TStringList);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    procedure OnStrutturaAsyncChange(Sender: TObject; EventParams: TStringList);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    procedure GestCambioPeriodo;
    procedure OnPeriodoClick(Sender: TObject);
    procedure OnPeriodoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure OnVistoAsyncClick(Sender: TObject; EventParams: TStringList);
    function  GetInModificaTutti: Boolean;
    procedure SetInModificaTutti(const Val: Boolean);
    function  GetInAutorizzaTutti: Boolean;
    procedure SetInAutorizzaTutti(const Val: Boolean);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    procedure PreparaFiltroStruttura;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    procedure SetBtnDownloadAllegati;
  protected
    lblFiltroVis: TmeIWLabel;
    grdFiltroVis: TmeIWGrid;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    lblFiltroStruttura: TmeIWLabel;
    cmbFiltroStruttura: TmeIWComboBox;
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    lblPeriodo: TmeIWLabel;
    rgpPeriodo: TmeTIWAdvRadioGroup;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    // MONDOEDP - commessa MAN/07.ini - modificato per PARMA_COMUNE - 162156
    rgpAllegati: TmeIWRadioGroup;
    rgpCondizAllegato: TmeIWRadioGroup;
    lblAllegati: TmeIWLabel;
    lblCondizAllegato: TmeIWLabel;
    // MONDOEDP - commessa MAN/07.fine

    btnFiltra: TmeIWButton;
    btnModificaTutti: TmeIWButton;
    btnAnnullaTutti: TmeIWButton;
    btnTuttiSi: TmeIWButton;
    btnTuttiNo: TmeIWButton;
    btnDownloadAllegati: TmeIWButton;
    WC018Esiste: Integer;
    WC018: TWC018FRiepilogoIterFM;
    ApplicaFiltroRefreshDipendenti:Boolean;
    function  GetInfoFunzione: String; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
    procedure IterBaseApplicaFiltro(Sender: TObject);
    procedure IterBaseModificaTutto(Sender: TObject);
    procedure IterBaseConfermaTutto(Sender: Tobject);
    procedure IterBaseAnnullaTutto(Sender: TObject);
    procedure IterBaseAutorizzaTutto(Sender: TObject);
    procedure IterBaseDownloadAllegati(Sender: TObject);
    procedure CorrezionePeriodo;
    function  CheckRecord(RI:String):Boolean;
    procedure R013Open(PDataset: TDataSet; PInfoDebug: Boolean = False);
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure DisponiFiltriVis;
    procedure AggiornaFiltriVis;
    procedure VisualizzaDettagli(Sender:TObject);
    procedure VisualizzaAllegati(Sender: TObject);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    C018:TC018FIterAutDM;
    property Iter: String read GetIter write SetIter;
    property BloccaGestione: Boolean read GetBloccaGestione write SetBloccaGestione;
    property InModificaTutti: Boolean read GetInModificaTutti write SetInModificaTutti;
    property InAutorizzaTutti: Boolean read GetInAutorizzaTutti write SetInAutorizzaTutti;
    procedure AddCampoMetadati(pLabel, pValore: string; pSize: integer = 0);
    procedure CreaDataSetMetadati;
  published
    property medpEditMultiplo: Boolean read GetEditMultiplo write SetEditMultiplo;
    property medpAutorizzaMultiplo: Boolean read GetAutorizzaMultiplo write SetAutorizzaMultiplo;
    property OnApplicaFiltro: TProcObject read FOnApplicaFiltro write FOnApplicaFiltro;
    property OnModificaTutto: TProcObject read FOnModificaTutto write FOnModificaTutto;
    property OnConfermaTutto: TProcObjectBool read FOnConfermaTutto write FOnConfermaTutto;
    property OnAnnullaTutto: TProcObject read FOnAnnullaTutto write FOnAnnullaTutto;
    property OnAutorizzaTutto: TProcObjectBool read FOnAutorizzaTutto write FOnAutorizzaTutto;
    property OnDownloadAllegati: TProcObject read FOnDownloadAllegati write FOnDownloadAllegati;
  end;

const
  SOGLIA_ELEMENTI_RIGAUNICA    = 5; // soglia oltre la quale le tipologie specifiche vengono inserite su una riga dedicata
  SOGLIA_ELEMENTI_RIGADEDICATA = 5; // soglia oltre la quale viene inserita una ulteriore riga, in presenza di riga dedicata per tipologie specifiche
  CAMBIOPERIODO_ASYNC = False;      // indica se il radiogroup del periodo deve utilizzare il metodo asincrono
                                    // lasciarlo a False per cortesia
  CHKSI_NAME = 'chkSi';
  CHKNO_NAME = 'chkNo';

implementation

uses
  WC501UMenuIrisWebFM;

{$R *.dfm}

procedure TR013FIterBase.IWAppFormCreate(Sender: TObject);
var
  LHeight: Integer;
  LBrowser: TBrowser;
begin
  inherited IWAppFormCreate(Sender);

  // elementi per filtro tipologia richieste
  lblFiltroVis:=TmeIWLabel.Create(Self);
  lblFiltroVis.Name:='lblFiltroVis';
  lblFiltroVis.Parent:=Self;
  lblFiltroVis.Caption:='Filtro richieste';

  LBrowser:=GetBrowser;
  if LBrowser is TChrome then
    LHeight:=75
  else if LBrowser is TFirefox then
    LHeight:=100
  else
    LHeight:=100;
  grdFiltroVis:=TmeIWGrid.Create(Self);
  grdFiltroVis.Name:='grdFiltroVis';
  grdFiltroVis.Parent:=Self;
  grdFiltroVis.Css:='gridTrasparente';
  grdFiltroVis.ExtraTagParams.Text:=Format('style=height:%d%%',[LHeight]);
  grdFiltroVis.UseFrame:=True;

  // elementi per filtro struttura
  lblFiltroStruttura:=TmeIWLabel.Create(Self);
  lblFiltroStruttura.Name:='lblFiltroStruttura';
  lblFiltroStruttura.Parent:=Self;
  lblFiltroStruttura.Caption:='Filtro tipologia richieste';

  cmbFiltroStruttura:=TmeIWComboBox.Create(Self);
  cmbFiltroStruttura.Name:='cmbFiltroStruttura';
  cmbFiltroStruttura.Parent:=Self;
  cmbFiltroStruttura.ItemsHaveValues:=True;
  cmbFiltroStruttura.NoSelectionText:='';
  cmbFiltroStruttura.OnAsyncChange:=OnStrutturaAsyncChange;
  cmbFiltroStruttura.OnAsyncKeyPress:=OnStrutturaAsyncChange;

  // elementi per filtro periodo
  lblPeriodo:=TmeIWLabel.Create(Self);
  lblPeriodo.Name:='lblPeriodo';
  lblPeriodo.Parent:=Self;
  lblPeriodo.Caption:='Periodo';

  rgpPeriodo:=TmeTIWAdvRadioGroup.Create(Self);
  rgpPeriodo.Name:='rgpPeriodo';
  rgpPeriodo.Parent:=Self;
  rgpPeriodo.Caption:='x'; // non impostare a '' -> bug del componente TMS!!!
  rgpPeriodo.Columns:=2;
  rgpPeriodo.Css:='groupbox noborder nolegend width20chr'; // classe noborder nasconde il bordo del groupbox
  rgpPeriodo.Items.StrictDelimiter:=True;
  rgpPeriodo.Items.CommaText:='giorno precedente,dal';
  if CAMBIOPERIODO_ASYNC then
    rgpPeriodo.OnAsyncClick:=OnPeriodoAsyncClick
  else
    rgpPeriodo.OnClick:=OnPeriodoClick;
  rgpPeriodo.Visible:=False;

  edtPeriodoDal:=TmeIWEdit.Create(Self);
  edtPeriodoDal.Name:='edtPeriodoDal';
  edtPeriodoDal.Parent:=Self;
  edtPeriodoDal.Css:='input_data_dmy';
  edtPeriodoDal.Hint:='Periodo di inizio delle richieste. Formato ggmmaaaa';
  edtPeriodoDal.Text:='';

  lblPeriodoDal:=TmeIWLabel.Create(Self);
  lblPeriodoDal.Name:='lblPeriodoDal';
  lblPeriodoDal.Parent:=Self;
  lblPeriodoDal.Caption:='dal';
  lblPeriodoDal.ForControl:=edtPeriodoDal;
  lblPeriodoDal.Hint:='Formato gg mm aaaa';

  edtPeriodoAl:=TmeIWEdit.Create(Self);
  edtPeriodoAl.Name:='edtPeriodoAl';
  edtPeriodoAl.Parent:=Self;
  edtPeriodoAl.Css:='input_data_dmy';
  edtPeriodoAl.Hint:='Periodo di fine delle richieste. Formato ggmmaaaa';
  edtPeriodoAl.Text:='';

  lblPeriodoAl:=TmeIWLabel.Create(Self);
  lblPeriodoAl.Name:='lblPeriodoAl';
  lblPeriodoAl.Parent:=Self;
  lblPeriodoAl.Caption:='al';
  lblPeriodoAl.ForControl:=edtPeriodoAl;
  lblPeriodoAl.Hint:='Formato gg mm aaaa';

  // imposta la gestione automatica della selezione del periodo
  AssegnaGestPeriodo(edtPeriodoDal, edtPeriodoAl);

  lblAllegati:=TmeIWLabel.Create(Self);
  lblAllegati.Name:='lblAllegati';
  lblAllegati.Parent:=Self;
  lblAllegati.Caption:='Allegati';

  rgpAllegati:=TmeIWRadioGroup.Create(Self);
  rgpAllegati.Name:='rgAllegati';
  rgpAllegati.Parent:=Self;
  rgpAllegati.Hint:='Consente di filtrare le richieste secondo la presenza di allegati';
  rgpAllegati.Layout:=glHorizontal;
  rgpAllegati.Items.Add('Tutti');
  rgpAllegati.Items.Add('Con allegato');
  rgpAllegati.Items.Add('Senza allegato');

  lblCondizAllegato:=TmeIWLabel.Create(Self);
  lblCondizAllegato.Name:='lblCondizAllegato';
  lblCondizAllegato.Parent:=Self;
  lblCondizAllegato.Caption:='Condizione allegato';

  rgpCondizAllegato:=TmeIWRadioGroup.Create(Self);
  rgpCondizAllegato.Name:='rgCondizAllegato';
  rgpCondizAllegato.Parent:=Self;
  rgpCondizAllegato.Hint:='Consente di filtrare le richieste le regole di inserimento allegati impostate';
  rgpCondizAllegato.Layout:=glHorizontal;
  rgpCondizAllegato.Items.Add('Tutti');
  rgpCondizAllegato.Items.Add('Allegati non previsti');
  rgpCondizAllegato.Items.Add('Allegati facoltativi');
  rgpCondizAllegato.Items.Add('Allegati obbligatori');

  // applica filtri
  btnFiltra:=TmeIWButton.Create(Self);
  btnFiltra.Name:='btnFiltra';
  btnFiltra.Parent:=Self;
  btnFiltra.Caption:='Filtra';
  btnFiltra.OnClick:=IterBaseApplicaFiltro;

  // modifica tutto / annulla tutto
  btnModificaTutti:=TmeIWButton.Create(Self);
  btnModificaTutti.Name:='btnModificaTutti';
  btnModificaTutti.Parent:=Self;
  btnModificaTutti.Caption:='Modifica tutto';
  btnModificaTutti.OnClick:=IterBaseModificaTutto;
  btnModificaTutti.Visible:=False;

  btnAnnullaTutti:=TmeIWButton.Create(Self);
  btnAnnullaTutti.Name:='btnAnnullaTutti';
  btnAnnullaTutti.Parent:=Self;
  btnAnnullaTutti.Caption:='Annulla tutto';
  btnAnnullaTutti.OnClick:=IterBaseAnnullaTutto;
  btnAnnullaTutti.Visible:=False;

  // autorizza tutto / nega tutto
  btnTuttiSi:=TmeIWButton.Create(Self);
  btnTuttiSi.Name:='btnTuttiSi';
  btnTuttiSi.Parent:=Self;
  btnTuttiSi.Caption:='Autorizza tutto';
  btnTuttiSi.Confirmation:='Autorizzare tutte le richieste?';
  btnTuttiSi.OnClick:=IterBaseAutorizzaTutto;
  btnTuttiSi.Visible:=False;

  btnTuttiNo:=TmeIWButton.Create(Self);
  btnTuttiNo.Name:='btnTuttiNo';
  btnTuttiNo.Parent:=Self;
  btnTuttiNo.Caption:='Nega tutto';
  btnTuttiNo.Confirmation:='Negare l''autorizzazione a tutte le richieste?';
  btnTuttiNo.OnClick:=IterBaseAutorizzaTutto;
  btnTuttiNo.Visible:=False;

  btnDownloadAllegati:=TmeIWButton.Create(Self);
  btnDownloadAllegati.Name:='btnDownloadAllegati';
  btnDownloadAllegati.Parent:=Self;
  btnDownloadAllegati.Caption:='Scarica tutti gli allegati';
  btnDownloadAllegati.Hint:='Scarica file zip contenente gli allegati di tutte le richieste selezionate';
  btnDownloadAllegati.medpDownloadButton:=True;
  btnDownloadAllegati.OnClick:=IterBaseDownloadAllegati;
  btnDownloadAllegati.Visible:=True;

  // inizializzazioni
  SetLength(FChkArr,0);
  FNumCheck:=0;
  FVisti:=False;
  FEditMultiplo:=False;
  FAutorizzaMultiplo:=False;
  FInModificaTutti:=False;
  FInAutorizzaTutti:=False;
  FBloccaGestione:=False;
  chkLastClicked:=nil;

  grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  ImgAllegati:=nil;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  // integra info login
  LoginInfo.ProfiloIter:=Parametri.ProfiloWEBIterAutorizzativi;
  ApplicaFiltroRefreshDipendenti:=False;

  FCampiMetadati:=TStringList.Create;
  CreaDataSetMetadati;
end;

procedure TR013FIterBase.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCampiMetadati);
end;

procedure TR013FIterBase.IWAppFormRender(Sender: TObject);
var
  JsCode: String;
begin
  inherited;

  // mantiene la coerenza fra le richieste disponibili e selezionate di C018
  // e i checkbox presenti a video
  AggiornaFiltriVis;

  // imposta via javascript le altezze dei radiogroup di filtro
  // in modo che risultino tutte uguali
  JsCode:='try { '#13#10 +
          '  var grpFiltroVis = $("#filtroVis > div.groupbox > fieldset"); '#13#10 +
          '  var grpFiltroVisH = grpFiltroVis.height(); '#13#10 +
          '  if (grpFiltroVisH > 0) { '#13#10 +
          '    grpFiltroVisH = (grpFiltroVisH < 38)? 38 : grpFiltroVisH; '#13#10 +
          '    grpFiltroVis.height(grpFiltroVisH); '#13#10 +
          '    $("#filtroStruttura > div.groupbox > fieldset").height(grpFiltroVisH); '#13#10 +
          '    $("#filtroPeriodo > div.groupbox > fieldset").height(grpFiltroVisH); '#13#10 +
          '    $("#filtroCausale > div.groupbox > fieldset").height(grpFiltroVisH); '#13#10 +
          '    $("#pulsantiAzione").height(grpFiltroVisH); '#13#10 +
          '  } '#13#10 +
          '} '#13#10 +
          'catch(err) { '#13#10 +
          '} '#13#10;

	JsCode:=JsCode + 'try {  '#13#10 +
          ' var grpFiltroAll = $("#filtroPresAllegati > div.groupbox > fieldset");  '#13#10 +
          ' var grpFiltroAllH = grpFiltroAll.height(); '#13#10 +
          ' if (grpFiltroAllH > 0) { '#13#10 +
          ' 	grpFiltroAllH = (grpFiltroAllH < 38)? 38 : grpFiltroAllH; '#13#10 +
          ' 	grpFiltroAll.height(grpFiltroAllH); '#13#10 +
          ' 	$("#filtroRichAllegati > div.groupbox > fieldset").height(grpFiltroAllH); '#13#10 +
          ' 	$("#pulsantiAllegati").height(grpFiltroAllH); '#13#10 +
          ' } '#13#10 +
          '} '#13#10 +
          '	catch(err) { '#13#10 +
          '} '#13#10;

  if rgpPeriodo.Visible then
  begin
    // aumenta la larghezza del groupbox rispetto a quella di default
    JsCode:=JsCode + #13#10 +
            'try { '#13#10 +
            '  $("#filtroPeriodo > div.groupbox").removeClass("width30chr").addClass("width47chr");'#13#10 +
            '} '#13#10 +
            'catch(err) { '#13#10 +
            '} '#13#10;
  end;
  jqTemp.OnReady.Text:=JsCode;
  C190VisualizzaElemento(jqTemp,'filtroStruttura',cmbFiltroStruttura.Visible);

  // imposta visibilità check filtro allegati
  if C018 <> nil then
    C190VisualizzaElemento(jqTemp,'filtriAllegati',C018.EsisteGestioneAllegati);

  // daniloc.ini - 30.08.2012
  // il problema con le region è stato parzialmente risolto:
  // abbiamo scoperto che la IWRegion è un contenitore ma solo in teoria,
  // perché ogni componente al suo interno deve essere creato
  // con Parent = IWForm (o IWFrame)
  // prima impostavamo erroneamente Parent = IWRegion

  // verifica abilitazione edit multiplo
  if FEditMultiplo then
    btnModificaTutti.Visible:=not SolaLettura;

  // verifica possibilità di autorizzazione multipla
  if FAutorizzaMultiplo then
  begin
    if C018.Iter = ITER_STRMESE then
    begin
      // caso particolare straordinario mensile
      btnTuttiSi.Visible:=(not SolaLettura) and
                          (WR000DM.Responsabile) and
                          ((trDaAutorizzare in C018.TipoRichiesteSel) or
                           (trInAutorizzazione in C018.TipoRichiesteSel) or
                           (trValidate in C018.TipoRichiesteSel));
    end
    else
    begin
      // caso normale
      btnTuttiSi.Visible:=(not SolaLettura) and
                          (WR000DM.Responsabile) and
                          (C018.TipoRichiesteSel = [trDaAutorizzare]);
    end;
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;

  // traduzione elementi interfaccia
  TraduzioneElementi(Self);
end;

procedure TR013FIterBase.Notification(AComponent: TComponent; Operation: TOperation);
var
  InChiusura: Boolean;
  LivCorr,LivAtt:Integer;
begin
  inherited Notification(AComponent, Operation);

  if Operation = opRemove then
  begin
    // chiusura frame allegati
    // questo evento viene richiamato anche dopo il destroy della form stessa
    // pertanto non bisogna aggiornare l'interfaccia in questo caso
    if GGetWebApplicationThreadVar = nil then
      Exit;
    InChiusura:=GGetWebApplicationThreadVar.FindComponent(Name) = nil;
    if (not InChiusura) and (AComponent = WC026) then
    begin
      try
        LivAtt:=-1;
        LivCorr:=-1;
        // aggiorna interfaccia se gli allegati sono stati modificati
        if WC026.InfoAllegati.EsistonoModifiche then
        begin
          // imposta l'icona degli allegati
          if WC026.InfoAllegati.NumAllegati > 0 then
          begin
            // icona allegati gialla (evidenzia presenza allegati)
            ImgAllegati.ImageFile.FileName:=fileImgAllegatiHighlight;
            if WC026.InfoAllegati.AllegatiInseriti then
            begin
              LivCorr:=max(C018.LivMaxAut,0);
              try
                LivAtt:=C018.VerificaRichiestaEsistente('V');
              except
                on E:Exception do
                begin
                  if RegistraMsg.ID = -1 then
                    RegistraMsg.IniziaMessaggio(medpCodiceForm);
                  RegistraMsg.InserisciMessaggio('A','TR013FIterBase.Notification.C018.VerificaRichiestaEsistente - ' + E.Message,Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
                end;
              end;
            end;
          end
          else
          begin
            // se non sono presenti allegati
            // - se la richiesta ha gli allegati obbligatori imposta icona rossa (evidenzia obbligatorietà)
            // - altrimenti imposta icona grigia
            ImgAllegati.ImageFile.FileName:=IfThen(WC026.InfoAllegati.GestAllegati = 'O',fileImgAllegatiObblig,fileImgAllegati);
          end;
          ImgAllegati.Hint:=WC026.InfoAllegati.HintImmagine;
        end;
        WC026:=nil;

        // aggiorna visualizzazione solo se è cambiato il livello di autorizzazione
        if LivAtt > LivCorr then
        try
          VisualizzaDipendenteCorrente;
        except
          on E:Exception do
          begin
            if RegistraMsg.ID = -1 then
              RegistraMsg.IniziaMessaggio(medpCodiceForm);
            RegistraMsg.InserisciMessaggio('A','TR013FIterBase.Notification.VisualizzaDipendenteCorrente - ' + E.Message,Parametri.Azienda,selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end;
      except
      end;
    end;
  end;
end;

procedure TR013FIterBase.DistruggiOggetti;
// distrugge gli oggetti creati a runtime
var
  i: Integer;
begin
  // componenti groupbox tipi richieste
  if chkVisto <> nil then
    FreeAndNil(chkVisto);
  if chkNoVisto <> nil then
    FreeAndNil(chkNoVisto);
  for i:=Low(FChkArr) to High(FChkArr) do
    FreeAndNil(FChkArr[i]);
  SetLength(FChkArr,0);
  FreeAndNil(grdFiltroVis);

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // componenti filtro struttura
  FreeAndNil(lblFiltroStruttura);
  FreeAndNil(cmbFiltroStruttura);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // componenti filtro periodo
  FreeAndNil(lblPeriodo);
  FreeAndNil(rgpPeriodo);
  FreeAndNil(lblPeriodoDal);
  FreeAndNil(edtPeriodoDal);
  FreeAndNil(lblPeriodoAl);
  FreeAndNil(edtPeriodoAl);

  // MONDOEDP - commessa MAN/07.ini - modificato per PARMA_COMUNE - 162156
  // filtro allegati
  FreeAndNil(lblAllegati);
  FreeAndNil(rgpAllegati);
  FreeAndNil(lblCondizAllegato);
  FreeAndNil(rgpCondizAllegato);
  // MONDOEDP - commessa MAN/07.fine

  // pulsanti di azione
  FreeAndNil(btnFiltra);
  FreeAndNil(btnModificaTutti);
  FreeAndNil(btnAnnullaTutti);
  FreeAndNil(btnTuttiSi);
  FreeAndNil(btnTuttiNo);

  // distrugge datamodulo iter
  try FreeAndNil(C018); except end;
end;

procedure TR013FIterBase.mnuEsportaCsvClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdRichieste.ToCsv
  else
    InviaFile('Richieste.xls',csvDownload);
end;

procedure TR013FIterBase.mnuEsportaExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdRichieste.ToXlsx
  else
  InviaFile('Richieste.xlsx',streamDownload);
end;

function TR013FIterBase.GetIter: String;
begin
  Result:=FIter;
end;

procedure TR013FIterBase.SetIter(const Val: String);
var
  ElemTipoRich: TTipoRichieste;
begin
  if C018 = nil then
    C018:=TC018FIterAutDM.Create(Self);
  C018.Responsabile:=WR000DM.Responsabile;
  C018.AccessoReadOnly:=SolaLettura;
  C018.Iter:=Val;

  if WR000DM.Responsabile and C018.NoAccessoAut then
    Notifica('Autorizzazione inibita','Attenzione!'#13#10'L''autorizzazione delle richieste è inibita su tutti i livelli.','',True,False,20000);

  // prepara componenti dell'interfaccia
  FNumCheck:=0;
  for ElemTipoRich in C018.TipoRichiesteDisp do
  begin
    if AddCheck(ElemTipoRich) then
      inc(FNumCheck);
  end;

  // filtro da autorizzare: se ci sono iter con AVVISO = 'S'
  // visualizza i checkbox per gestire visibilità delle richieste "con visto" / "senza visto"
  FVisti:=False;
  if WR000DM.Responsabile and C018.UtilizzoAvviso then
  begin
    // 1. checkbox "con visto"
    chkVisto:=TmeIWCheckBox.Create(Self);
    chkVisto.Name:='chkVisto';
    chkVisto.Parent:=Self;
    chkVisto.Caption:='con visto';
    chkVisto.Checked:=True;
    chkVisto.OnAsyncClick:=OnVistoAsyncClick;

    // 2. checkbox "senza visto"
    chkNoVisto:=TmeIWCheckBox.Create(Self);
    chkNoVisto.Name:='chkNoVisto';
    chkNoVisto.Parent:=Self;
    chkNoVisto.Caption:='senza visto';
    chkNoVisto.Checked:=True;
    chkNoVisto.OnAsyncClick:=OnVistoAsyncClick;

    FVisti:=True;
  end;

  // associa i check alle celle della grid di filtro
  DisponiFiltriVis;

  // prepara la combobox del filtro struttura
  PreparaFiltroStruttura;

  // imposta il periodo di filtro iniziale
  edtPeriodoDal.Text:=C018.Periodo.InizioStr;
  edtPeriodoAl.Text:=C018.Periodo.FineStr;

  FIter:=Val;
end;

function TR013FIterBase.GetEditMultiplo: Boolean;
begin
  Result:=FEditMultiplo;
end;

procedure TR013FIterBase.SetEditMultiplo(const Val: Boolean);
begin
  if Val = FeditMultiplo then
    Exit;

  // se la maschera era in modifica massiva, ritorna allo stato normale
  if not Val then
    InModificaTutti:=False;

  btnModificaTutti.Visible:=Val;
  FEditMultiplo:=Val;
end;

function TR013FIterBase.GetAutorizzaMultiplo: Boolean;
begin
  Result:=FAutorizzaMultiplo;
end;

procedure TR013FIterBase.SetAutorizzaMultiplo(const Val: Boolean);
begin
  if Val = FAutorizzaMultiplo then
    Exit;

  btnTuttiSi.Visible:=Val;
  btnTuttiNo.Visible:=Val;

  FAutorizzaMultiplo:=Val;
end;

procedure TR013FIterBase.DisponiFiltriVis;
// disposizione automatica dei filtri di visualizzazione su N righe
// riga 1       : tipologie standard
// riga [2..N-1]: tipologie specifiche
// {TODO: raggruppamenti di filtri}
// riga N       : visti
var
  i,r,c,contaStd,contaAltri: Integer;
  RigaUnica: Boolean;
  TempElem: TTipoRichieste;
  function GetRowCount: Integer;
  begin
    // riga dei valori standard
    Result:=1;
    // numero di righe per i valori specifici
    if not RigaUnica then
      Result:=Result + Trunc(R180Arrotonda(contaAltri / SOGLIA_ELEMENTI_RIGADEDICATA,1,'E'));
    // riga dei visti
    if FVisti then
      inc(Result);
  end;
  function GetColCount: Integer;
  begin
    if RigaUnica then
      Result:=contaStd + contaAltri
    else
      Result:=max(contaStd,min(contaAltri,SOGLIA_ELEMENTI_RIGADEDICATA));
    if FVisti then
      Result:=max(Result,2);
  end;
begin
  // in base al TipoRichiesteEsclusivo imposta il gestore del click
  //   se esclusivo -> evento sincrono
  //   se multiplo -> evento asincrono
  for i:=Low(FChkArr) to High(FChkArr) do
  begin
    if C018.TipoRichiesteEsclusivo then
    begin
      FChkArr[i].OnClick:=OnTipoRichiesteClick;
      FChkArr[i].OnAsyncClick:=nil;
    end
    else
    begin
      FChkArr[i].OnClick:=nil;
      FChkArr[i].OnAsyncClick:=OnTipoRichiesteAsyncClick;
    end;
  end;

  // conta elementi standard e specifici
  contaStd:=0;
  contaAltri:=0;
  for TempElem in C018.TipoRichiesteDisp do
  begin
    if TempElem in TIPORICHIESTE_STANDARD then
      inc(contaStd)
    else
      inc(contaAltri);
  end;

  if contaStd + contaAltri + IfThen(FVisti,1,0) = 1 then
  begin
    // una sola scelta -> nasconde la grid di visualizzazione
    grdFiltroVis.Visible:=False;
    JavascriptBottom.Add('document.getElementById("filtroVis").className = "invisibile";');
  end
  else
  begin
    // tenta di ottimizzare la disposizione dei checkbox
    // evita di creare due righe se il totale di checkbox è al di sotto di una soglia predefinita
    RigaUnica:=(contaAltri = 0) or
               (contaStd + contaAltri <= SOGLIA_ELEMENTI_RIGAUNICA);

    grdFiltroVis.RowCount:=GetRowCount;
    grdFiltroVis.ColumnCount:=GetColCount;
    r:=-1;

    // prima riga: tipologie standard
    if contaStd > 0 then
    begin
      inc(r);
      c:=0;

      // verifica caso di riga unica
      if RigaUnica then
      begin
        for TempElem in C018.TipoRichiesteDisp do
          if not (TempElem in TIPORICHIESTE_STANDARD) then
          begin
            grdFiltroVis.Cell[r,c].Control:=FChkArr[IndexOfCheck(TempElem)];
            inc(c);
          end;
      end;

      for TempElem in C018.TipoRichiesteDisp do
      begin
        if TempElem in TIPORICHIESTE_STANDARD then
        begin
          grdFiltroVis.Cell[r,c].Control:=FChkArr[IndexOfCheck(TempElem)];
          inc(c);
        end;
      end;
    end;

    // riga successiva: tipologie specifiche dell'iter
    // viene impostata se le tipologie specifiche sono più di 2
    if not RigaUnica then
    begin
      inc(r);
      c:=0;
      for TempElem in C018.TipoRichiesteDisp do
      begin
        if not (TempElem in TIPORICHIESTE_STANDARD) then
        begin
          grdFiltroVis.Cell[r,c].Control:=FChkArr[IndexOfCheck(TempElem)];
          inc(c);
          if c >= grdFiltroVis.ColumnCount then
          begin
            inc(r);
            c:=0;
          end;
        end;
      end;
    end;

    // riga successiva: visti
    if FVisti then
    begin
      inc(r);
      c:=0;
      grdFiltroVis.Cell[r,c].Control:=chkVisto;
      inc(c);
      grdFiltroVis.Cell[r,c].Control:=chkNoVisto;
    end;
  end;
end;

procedure TR013FIterBase.AggiornaFiltriVis;
// mantiene coerenti le proprietà di C018 con i checkbox dell'interfaccia
// questa procedure è richiamata nell'evento FormRender
var
  i: Integer;
  TipoRich: TTipoRichieste;
begin
  // filtro tipologia richieste
  for i:=Low(FChkArr) to High(FChkArr) do
  begin
    TipoRich:=TTipoRichieste(FChkArr[i].Tag);
    FChkArr[i].Caption:=C018.TipoRichiestaCaption[TipoRich];
    FChkArr[i].Css:='intestazione';
    FChkArr[i].Visible:=True;
    // verifica se il checkbox è tra le tipologie di richiesta disponibili
    if not (TipoRich in C018.TipoRichiesteDisp) then
    begin
      FChkArr[i].Checked:=False;
      FChkArr[i].Visible:=False;
      FChkArr[i].Css:='invisibile'; // workaround: proprietà visible non viene applicata correttamente
    end
    // se il checkbox è selezionato ma non è tra le tipologie di richiesta attualmente selezionate, lo deseleziona
    else if (FChkArr[i].Checked) and
            (not (TipoRich in C018.TipoRichiesteSel)) then
    begin
      FChkArr[i].Checked:=False;
    end
    // se il checkbox è deselezionato ma è tra le tipologie di richiesta attualmente selezionate, lo seleziona
    else if (not FChkArr[i].Checked) and
            (TipoRich in C018.TipoRichiesteSel) then
    begin
      FChkArr[i].Checked:=True;
    end;
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
procedure TR013FIterBase.PreparaFiltroStruttura;
// prepara la combobox del filtro struttura
var
  Codice, Descrizione: String;
  VisualizzaFiltro: Boolean;
begin
  // popola la combobox con le strutture disponibili,
  // incluso l'item speciale denominato "<Tutte>"
  cmbFiltroStruttura.Items.Clear;
  for Codice in C018.StruttureDisp.Split([',']) do
  begin
    Descrizione:=VarToStr(C018.selI095.Lookup('COD_ITER',Codice,'DESCRIZIONE'));
    if Descrizione = '' then
      Descrizione:=Codice;
    cmbFiltroStruttura.Items.Add(Format('%s=%s',[Descrizione,Codice]));
  end;
  cmbFiltroStruttura.ItemIndex:=cmbFiltroStruttura.Items.IndexOfName(C018STRUTTURA_STANDARD);

  // la combobox è visibile solo se esistono N>1 strutture
  // (il controllo è > 2 perché include la struttura speciale <Tutte>)
  // IMPORTANTE: la visibilità del groupbox che contiene gli elementi di filtro è determinata sul formrender
  VisualizzaFiltro:=cmbFiltroStruttura.Items.Count > 2;
  lblFiltroStruttura.Visible:=VisualizzaFiltro;
  cmbFiltroStruttura.Visible:=VisualizzaFiltro;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

procedure TR013FIterBase.VisualizzaDettagli(Sender:TObject);
// visualizza i dettagli di autorizzazione della richiesta (tabella T851)
begin
  // imposta proprietà di C018
  C018.CodIter:=C018.selTabellaIter.FieldByName('COD_ITER').AsString;
  C018.Id:=C018.selTabellaIter.FieldByName(C018.GetIDIter).AsInteger;
  C018.LeggiIterCompleto;

  // gestione particolare per la corretta gestione del free del componente
  if WC018Esiste = 1 then
  begin
    try
      FreeAndNil(TWC018FRiepilogoIterFM(WC018));
    except
    end;
  end;

  // prepara e visualizza il frame dei dettagli di autorizzazione
  WC018:=TWC018FRiepilogoIterFM.Create(Self);
  WC018Esiste:=1;
  WC018.C018:=C018;
  C018.AccessoReadOnly:=SolaLettura;//Inizializzo per successivo controllo in TWC018FRiepilogoIterFM.PutLivello
  WC018.Livello:=IfThen(WR000DM.Responsabile,C018.selTabellaIter.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,0);
  WC018.WC018Esiste:=@WC018Esiste;
  WC018.ComponenteHint:=TIWCustomControl(Sender);
  WC018.Visualizza;
end;

procedure TR013FIterBase.VisualizzaAllegati(Sender: TObject);
// visualizza i dettagli di autorizzazione della richiesta (tabella T851)
var
  AbilMod, LRichAnnullata: Boolean;
  AutDef, AbilInfo: String;
begin
  ImgAllegati:=(Sender as TmeIWImageFile);

  // imposta proprietà di C018
  C018.CodIter:=C018.selTabellaIter.FieldByName('COD_ITER').AsString;
  C018.Id:=C018.selTabellaIter.FieldByName('ID').AsInteger;
  C018.AccessoReadOnly:=SolaLettura;

  // determina se la richiesta è annullata (basandosi su tipo richiesta)
  if C018.selTabellaIter.FindField('TIPO_RICHIESTA') <> nil then
    LRichAnnullata:=C018.selTabellaIter.FieldByName('TIPO_RICHIESTA').AsString = C018TR_ANNULLATA
  else
    LRichAnnullata:=False;

  // determina abilitazione alla modifica degli allegati
  if WR000DM.Responsabile then
  begin
    // per l'autorizzatore gli allegati non sono modificabili
    AbilMod:=False;
    AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_AUT);
  end
  else if LRichAnnullata then
  begin
    // se la richiesta è annullata gli allegati non sono modificabili
    AbilMod:=False;
    AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_RIC_ANNULL);
  end
  else
  begin
    // per il richiedente gli allegati sono modificabili se:
    // - la richiesta non è autorizzata
    // - la richiesta è stata autorizzata definitivamente
    //   e il flag ALLEGATI_MODIFICABILI sulla struttura vale 'S'
    AutDef:=C018.selTabellaIter.FieldByName('AUTORIZZAZIONE').AsString;
    if AutDef = '' then
    begin
      // richiesta non ancora autorizzata definitivamente
      // modifica consentita
      AbilMod:=True;
      AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_RIC_DA_AUT);
    end
    else if C018.StatoNegato(AutDef) then
    begin
      // richiesta negata
      // modifica impedita
      AbilMod:=False;
      AbilInfo:=A000TraduzioneStringhe(A000MSG_C018_MSG_NOABIL_ALL_RIC_NEG);
    end
    else if C018.StatoAutorizzato(AutDef) then
    begin
      // richiesta autorizzata definitivamente
      // valuta il flag ALLEGATI_MODIFICABILI
      // - 'S': modifica consentita
      // - 'N': modifica impedita
      AbilMod:=(C018.GetAllegatiModificabili = 'S');
      AbilInfo:=Format(A000TraduzioneStringhe(A000MSG_C018_MSG_FMT_NOABIL_ALL_RIC_AUT),
                       [A000TraduzioneStringhe(IfThen(AbilMod,'consentita','impedita'))]);
    end
    else
    begin
      // situazione inconsistente
      AbilMod:=False;
      AbilInfo:='';
    end;
  end;

  // gestione frame allegati
  if Assigned(WC026) then
    FreeAndNil(WC026);
  WC026:=TWC026FAllegatiIterFM.Create(Self);
  FreeNotification(WC026);
  WC026.Abilitazioni.Inserimento:=AbilMod;
  WC026.Abilitazioni.Modifica:=AbilMod;
  WC026.Abilitazioni.Cancellazione:=AbilMod;
  WC026.Abilitazioni.Info:=AbilInfo;
  WC026.C018:=C018;
  WC026.Visualizza;
end;

function TR013FIterBase.IndexOfCheck(const PTipo: TTipoRichieste): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=Low(FChkArr) to High(FChkArr) do
  begin
    if FChkArr[i].Tag = Integer(PTipo) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TR013FIterBase.EsisteCheck(const PTipo: TTipoRichieste): Boolean;
// restituisce True se è già stato creato il checkbox relativo al tipo richiesta indicato
// altrimenti restituisce False
begin
  Result:=IndexOfCheck(PTipo) > -1;
end;

function TR013FIterBase.AddCheck(const PTipo: TTipoRichieste): Boolean;
// crea e aggiunge alla relativa struttura un nuovo checkbox
// per il tipo di richiesta indicato
var
  n: Integer;
begin
  if EsisteCheck(PTipo) then
    Result:=False
  else
  begin
    n:=Length(FChkArr);
    SetLength(FChkArr,n + 1);
    FChkArr[n]:=TmeIWCheckBox.Create(Self);
    FChkArr[n].Name:=C018.TipoRichiestaNome[PTipo];
    FChkArr[n].Parent:=Self;
    FChkArr[n].Caption:=C018.TipoRichiestaCaption[PTipo];
    FChkArr[n].Checked:=PTipo in C018.TipoRichiesteDefault;
    FChkArr[n].Tag:=Integer(PTipo);
    FChkArr[n].OnAsyncClick:=OnTipoRichiesteAsyncClick;

    Result:=True;
  end;
end;

procedure TR013FIterBase.GestCambioPeriodo;
// IMPORTANTE: può essere richiamata in async
var
  Abil: Boolean;
begin
  Abil:=(rgpPeriodo.ItemIndex = 1);
  AbilitazioneComponente(lblPeriodoDal,Abil);
  AbilitazioneComponente(edtPeriodoDal,Abil);
  AbilitazioneComponente(lblPeriodoAl,Abil);
  AbilitazioneComponente(edtPeriodoAl,Abil);

  if rgpPeriodo.ItemIndex = 0 then
  begin
    edtPeriodoDal.Text:='';
    edtPeriodoAl.Text:='';
  end
  else
  begin
    edtPeriodoDal.Text:=C018.Periodo.InizioStr;
    edtPeriodoAl.Text:=C018.Periodo.FineStr;
  end;
end;

procedure TR013FIterBase.OnPeriodoClick(Sender: TObject);
begin
  GestCambioPeriodo;
end;

procedure TR013FIterBase.OnPeriodoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  GestCambioPeriodo;
end;

procedure TR013FIterBase.OnTipoRichiesteClick(Sender: TObject);
// evento di gestione del click sui checkbox
// caso di TipoRichiesteEsclusivo = True (tipo richieste singolo)
var
  i: Integer;
  Found: Boolean;
begin
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // 1. tipo richieste esclusivo: comportamento dei check = radiobutton
    C018.TipoRichiesteSel:=[TTipoRichieste((Sender as TmeIWCheckBox).Tag)];
    for i:=Low(FChkArr) to High(FChkArr) do
    begin
      if (FChkArr[i].Tag <> (Sender as TmeIWCheckBox).Tag) and
         (FChkArr[i].Checked) then
      begin
        FChkArr[i].Checked:=False;
        Break;
      end;
    end;
  end
  else
  begin
    // impedisce di deselezionare tutti i checkbox
    Found:=False;
    for i:=Low(FChkArr) to High(FChkArr) do
    begin
      if (FChkArr[i].Tag <> (Sender as TmeIWCheckBox).Tag) and
         (FChkArr[i].Checked) then
      begin
        Found:=True;
        Break;
      end;
    end;
    if not Found then
    begin
      // forza la selezione del check attuale
      (Sender as TmeIWCheckBox).Checked:=True;
    end;
  end;

  // verifica se è necessaria una correzione del periodo indicato a video
  CorrezionePeriodo;

  IterBaseApplicaFiltro(nil);
end;

procedure TR013FIterBase.OnTipoRichiesteAsyncClick(Sender: TObject; EventParams: TStringList);
// evento di gestione del click su ogni checkbox
// caso di TipoRichiesteEsclusivo = False (tipo richieste multiplo)
var
  i: Integer;
  Found,Tutte: Boolean;
  TipoCheck: TTipoRichieste;
begin
  TipoCheck:=TTipoRichieste((Sender as TmeIWCheckBox).Tag);
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // checkbox selezionato
    // verifica se è stato spuntato il check "Tutte"
    // oppure se sono spuntati tutti i checkbox visibili
    Tutte:=TipoCheck = trTutte;
    if not Tutte then
    begin
      Found:=False;
      for i:=Low(FChkArr) to High(FChkArr) do
      begin
        if (FChkArr[i].Tag <> Integer(trTutte)) and
           (FChkArr[i].Visible) and
           (not FChkArr[i].Checked) then
        begin
          Found:=True;
          Break;
        end;
      end;
      if not Found then
        Tutte:=True;
    end;

    if Tutte then
    begin
      // seleziona tutti i checkbox visibili
      for i:=Low(FChkArr) to High(FChkArr) do
      begin
        if FChkArr[i].Visible then
          FChkArr[i].Checked:=True;
      end;
      C018.TipoRichiesteSel:=C018.TipoRichiesteDisp;
    end
    else
    begin
      C018.TipoRichiesteSel:=C018.TipoRichiesteSel + [TipoCheck];
    end;
  end
  else
  begin
    // checkbox deselezionato
    // 1. impedisce di deselezionare l'item "Tutte" se tutti i check sono spuntati

    // impedisce di deselezionare tutti i checkbox
    Found:=False;
    for i:=Low(FChkArr) to High(FChkArr) do
    begin
      if (FChkArr[i].Tag <> (Sender as TmeIWCheckBox).Tag) and
         (FChkArr[i].Checked) then
      begin
        Found:=True;
        Break;
      end;
    end;
    // forza la selezione del checkbox cliccato in precedenza se esistente
    // oppure impedisce di deselezionare il checkbox attuale
    if not Found then
    begin
      if Assigned(chkLastClicked) then
      begin
        // tenta di forzare il click dell'ultimo check cliccato
        chkLastClicked.Checked:=True;
        // (richieste selezionate modificate)
        C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [TipoCheck] + [TTipoRichieste(chkLastClicked.Tag)];
      end
      else
      begin
        // forza la selezione del check attuale
        // (richieste selezionate non modificate)
        (Sender as TmeIWCheckBox).Checked:=True;
      end;
    end
    else if TipoCheck = trTutte then
    begin
      // impedisce di deselezionare il checkbox "Tutte" se tutti gli altri checkbox
      // sono selezionati
      (Sender as TmeIWCheckBox).Checked:=True;
    end
    else
    begin
      // se necessario deseleziona il checkbox "Tutte"
      for i:=Low(FChkArr) to High(FChkArr) do
      begin
        if (FChkArr[i].Tag = Integer(trTutte)) and
           (FChkArr[i].Visible) and
           (FChkArr[i].Checked) then
        begin
          FChkArr[i].Checked:=False;
          C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [trTutte];
          Break;
        end;
      end;
      C018.TipoRichiesteSel:=C018.TipoRichiesteSel - [TipoCheck];
    end;
  end;

  // salva l'ultimo check cliccato
  chkLastClicked:=(Sender as TmeIWCheckBox);

  // verifica se è necessaria una correzione del periodo indicato a video
  CorrezionePeriodo;

  // segnalazione visiva della necessità di rieffettuare il filtro
  //GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('try { $("#' + btnFiltra.HTMLName + '").effect("pulsate",{times: 3},250); } catch(err) {}');
end;

procedure TR013FITerBase.CorrezionePeriodo;
// se necessario effettua una correzione del periodo indicato a video
var
  Ieri, ValorizzaPeriodo: String;
  IsPeriodoVuoto,
  ModelloFiltriVuoto: Boolean;
begin
  ValorizzaPeriodo:='NO';

  // indica se il periodo attualmente indicato è vuoto
  IsPeriodoVuoto:=(Trim(edtPeriodoDal.Text) = '') and (Trim(edtPeriodoAl.Text) = '');

  // indica l'impostazione delle tipologie di richiesta
  // per cui  il periodo deve essere vuoto
  // inizializzazione standard: tipo richieste selezionato = da autorizzare
  ModelloFiltriVuoto:=(C018.TipoRichiesteSel = [trDaAutorizzare]);

  // gestione iter particolari
  if C018.Iter = ITER_MISSIONI then
  begin
    // iter missioni
    ModelloFiltriVuoto:=(trDaAutorizzare in C018.TipoRichiesteSel) and
                        (not (trAutorizzate in C018.TipoRichiesteSel)) and
                        (not (trNegate in C018.TipoRichiesteSel)) and
                        (not (trAnnullate in C018.TipoRichiesteSel));
  end
  else if C018.Iter = ITER_GIUSTIF then
  begin
    // iter giustificativi
    // le richieste da definire richiedono il periodo vuoto
    ModelloFiltriVuoto:=(C018.TipoRichiesteSel <= [trDaAutorizzare,trDaDefinire]);
  end
  else if C018.Iter = ITER_STRMESE then
  begin
    // iter straordinario mensile
    if WR000DM.Responsabile then
      ModelloFiltriVuoto:=(trDaAutorizzare in C018.TipoRichiesteSel) or
                          (trInAutorizzazione in C018.TipoRichiesteSel) or
                          (trValidate in C018.TipoRichiesteSel)
    else
      ModelloFiltriVuoto:=(trRichiedibili in C018.TipoRichiesteSel);
  end
  else if C018.Iter = ITER_STRGIORNO then
  begin
    // non svuota il periodo nel caso di autorizzazione contestuale alla richiesta e doppio passaggio di conferma su cartellino
    if (not Responsabile) and
       (Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A') and
       (Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S') then
    begin
      ModelloFiltriVuoto:=False;
    end;
  end;

  // gestione standard
  if ModelloFiltriVuoto and (not IsPeriodoVuoto) then
  begin
    // richieste da autorizzare con periodo impostato -> propone periodo vuoto
    ValorizzaPeriodo:='VUOTO';
  end
  else if (not ModelloFiltriVuoto) and IsPeriodoVuoto then
  begin
    // richieste non da autorizzare con periodo vuoto -> propone periodo di default
    ValorizzaPeriodo:='SI';
  end;

  // applica il periodo in base all'indicazione
  if ValorizzaPeriodo = 'VUOTO' then
  begin
    // pulisce periodo solo se non è stato ridefinito manualmente
    if C018.Periodo.Tipo <> 'M' then
    begin
      edtPeriodoDal.Clear;
      edtPeriodoAl.Clear;
    end;
  end
  else if ValorizzaPeriodo = 'SI' then
  begin
    // richieste <> da autorizzare con periodo vuoto -> propone periodo di default
    if C018.PeriodoVisual.Dal = DATE_MIN {EncodeDate(1900,1,1)} then   // utilizzo costante
      edtPeriodoDal.Text:=''
    else
      edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',C018.PeriodoVisual.Dal);
    if C018.PeriodoVisual.Al = DATE_MAX {EncodeDate(3999,12,31)} then  // utilizzo costante
      edtPeriodoAl.Text:=''
    else
      edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',C018.PeriodoVisual.Al);
    C018.Periodo.Tipo:='A';
  end;

  OldPeriodoDal:=edtPeriodoDal.Text;
  OldPeriodoAl:=edtPeriodoAl.Text;

  // caso del giorno precedente
  Ieri:=FormatDateTime('dd/mm/yyyy',Date - 1);
  if (rgpPeriodo.Visible) and (edtPeriodoDal.Text = Ieri) and (edtPeriodoAl.Text = Ieri) then
  begin
    rgpPeriodo.ItemIndex:=0;
    if CAMBIOPERIODO_ASYNC then
      rgpPeriodo.OnAsyncClick(rgpPeriodo,nil)
    else
      rgpPeriodo.OnClick(rgpPeriodo);
  end;
end;

procedure TR013FIterBase.CreaDataSetMetadati;
var
  i,Dim: Integer;
  CampoIter: String;
begin
  if not Parametri.DownloadMassivoAllegati or
     not assigned(C018) or
     not C018.EsisteGestioneAllegati or
     not WR000DM.Responsabile then
  Exit;

  if Assigned(cdsMetadati) then
    FreeAndNil(cdsMetadati);

  cdsMetadati:=TClientDataSet.Create(self);
  with cdsMetadati.FieldDefs do
  begin
    Add('COGNOME', ftString, 50);
    Add('NOME', ftString, 50);
    Add('CODFISCALE', ftString, 16);
    Add('MATRICOLA', ftString, 8);
    Add('NOME_FILE', ftString, 200);
    Add('NOME_ORIGINALE', ftString, 200);
    Add('DATA_RICHIESTA', ftDateTime, 0);
    Add('ID_RICH', ftInteger,0);
    Add('ID_T960', ftInteger,0);

    for i:=0 to FCampiMetadati.Count-1 do
    begin
      CampoIter:=FCampiMetadati.ValueFromIndex[i].Split([';'])[0];
      Dim:=StrToInt(FCampiMetadati.ValueFromIndex[i].Split([';'])[1]);
      Add(FCampiMetadati.Names[i], C018.selTabellaIter.Fields.FindField(CampoIter).DataType, dim)
    end;
  end;

  cdsMetadati.CreateDataSet;
end;

function TR013FIterBase.CheckRecord(RI:String):Boolean;
{verifica se il record esiste ancora nella condizione di filtro corrente, eseguendo la query principale per il solo RowID interessato
 Il RefreshRecord non funziona}
var
  i,x:Integer;
  RIName:String;
  lstVariabili:TStringList;
  LODS: TOracleDataSet;
begin
  Result:=True;
  if not (C018.selTabellaIter is TOracleDataSet) then
    exit;

  LODS:=TOracleDataSet.Create(nil);
  try
    LODS.Session:=SessioneOracle;
    LODS.SQL.Text:=(C018.selTabellaIter as TOracleDataSet).SQL.Text;
    //Ottimizzo query: non interessa il valore delle colonne ma solo se esiste il record
    //Sostituisco le colonne con la sola colonna rownum
    x:=LODS.SQL.IndexOf('from');
    if x = 0 then
      x:=LODS.SQL.IndexOf('FROM');
    if x > 0 then
    begin
      for i:=1 to x - 1 do
        LODS.SQL.Delete(1);
      LODS.SQL.Insert(1,'rownum');
    end;
    RIName:='ROWID';
    if Pos('T_ITER.ROWID_T',C018.ColonneIter) > 0 then
      RIName:='ROWID_T';
    //Assegno le variabili dell'sql originale
    LODS.Variables.Assign((C018.selTabellaIter as TOracleDataSet).Variables);
    LODS.SetVariable('FILTRO_VISUALIZZAZIONE',VarToStr(TOracleDataSet(C018.selTabellaIter).GetVariable('FILTRO_VISUALIZZAZIONE')) + ' and T_ITER.' + RIName + ' = ''' + RI + '''');
    // elimina ordinamento
    LODS.SetVariable('ORDINAMENTO','');
    //Leggo le variabili effettive dell'sql modificato
    lstVariabili:=FindVariables(LODS.SQL.Text, False);
    //Cancello le variabili che ho assegnato ma non sono più utilizzate con l'sql modificato
    try
      for i:=LODS.VariableCount - 1 downto 0 do
        if lstVariabili.IndexOf(StringReplace(LODS.VariableName(i),':','',[])) = -1 then
          LODS.DeleteVariable(LODS.VariableName(i));
    finally
      lstVariabili.Free;
    end;
    LODS.Open;
    if LODS.RecordCount = 0 then
      Result:=False;
  finally
    FreeAndNil(LODS);
  end;
end;

// MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
procedure TR013FIterBase.OnStrutturaAsyncChange(Sender: TObject; EventParams: TStringList);
var
  IWCmb: TmeIWComboBox;
  Elemento: String;
begin
  IWCmb:=(Sender as TmeIWComboBox);
  Elemento:=IWCmb.Items.ValueFromIndex[IWCmb.ItemIndex];
  C018.StrutturaSel:=Elemento;
end;
// MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

procedure TR013FIterBase.OnVistoAsyncClick(Sender: TObject; EventParams: TStringList);
// gestione del click sui checkbox "Con visto" e "Senza visto"
begin
  if not (Sender as TmeIWCheckBox).Checked then
  begin
    if (Sender = chkVisto) and (not chkNoVisto.Checked) then
      chkNoVisto.Checked:=True
    else if (Sender = chkNoVisto) and (not chkVisto.Checked) then
      chkVisto.Checked:=True;
  end;
  if chkVisto.Checked and chkNoVisto.Checked then
    C018.TipoVisto:=tvTutti
  else if chkVisto.Checked then
    C018.TipoVisto:=tvVisto
  else
    C018.TipoVisto:=tvNoVisto;
end;

function TR013FIterBase.GetInModificaTutti: Boolean;
begin
  Result:=FInModificaTutti;
end;

procedure TR013FIterBase.SetInModificaTutti(const Val: Boolean);
var
  i: Integer;
begin
  if Val = FInModificaTutti then
    Exit;

  // gestione pulsante
  if Val then
  begin
    btnModificaTutti.Caption:='Conferma tutto';
    btnModificaTutti.Confirmation:=IfThen(WR000DM.Responsabile,'Confermare le autorizzazioni indicate?','Confermare le modifiche effettuate nella tabella?');
    btnModificaTutti.OnClick:=IterBaseConfermaTutto;
  end
  else
  begin
    btnModificaTutti.Caption:='Modifica tutto';
    btnModificaTutti.Confirmation:='';
    btnModificaTutti.OnClick:=IterBaseModificaTutto;
  end;
  btnAnnullaTutti.Visible:=Val;

  // abilitazione combobox dipendente
  AbilitazioneComponente(cmbDipendentiDisponibili,not Val);

  // abilitazione filtri richieste
  AbilitazioneComponente(lblFiltroVis,not Val);
  for i:=Low(FChkArr) to High(FChkArr) do
    AbilitazioneComponente(FChkArr[i],not Val);

  // abilitazione checkbox "con / senza visto"
  if Assigned(chkVisto) then
    AbilitazioneComponente(chkVisto,not Val);
  if Assigned(chkNoVisto) then
    AbilitazioneComponente(chkNoVisto,not Val);

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // abilitazione filtro struttura
  AbilitazioneComponente(lblFiltroStruttura,not Val);
  AbilitazioneComponente(cmbFiltroStruttura,not Val);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // abilitazione periodo
  if rgpPeriodo.Visible then
    AbilitazioneComponente(rgpPeriodo,not Val);
  AbilitazioneComponente(lblPeriodo,not Val);
  AbilitazioneComponente(lblPeriodoDal,not Val);
  AbilitazioneComponente(edtPeriodoDal,not Val);
  AbilitazioneComponente(lblPeriodoAl,not Val);
  AbilitazioneComponente(edtPeriodoAl,not Val);

  // MONDOEDP - commessa MAN/07.ini - modificato per PARMA_COMUNE - 162156
  AbilitazioneComponente(lblAllegati, not Val);
  AbilitazioneComponente(rgpAllegati, not Val);
  AbilitazioneComponente(lblCondizAllegato, not Val);
  AbilitazioneComponente(rgpCondizAllegato, not Val);
  // MONDOEDP - commessa MAN/07.fine

  // abilitazione pulsante di filtro
  AbilitazioneComponente(btnFiltra,not Val);

  FInModificaTutti:=Val;
end;

function TR013FIterBase.GetInAutorizzaTutti: Boolean;
begin
  Result:=FInAutorizzaTutti;
end;

procedure TR013FIterBase.SetInAutorizzaTutti(const Val: Boolean);
begin
  FInAutorizzaTutti:=Val;
end;

function TR013FIterBase.GetBloccaGestione: Boolean;
begin
  Result:=FBloccaGestione;
end;

procedure TR013FIterBase.SetBloccaGestione(const Val: Boolean);
// abilita i componenti di filtro in base al parametro
var
  i: Integer;
begin
  if Val = FBloccaGestione then
    Exit;

  // abilitazione cambio dipendente
  AbilitazioneComponente(cmbDipendentiDisponibili,not Val);

  // abilitazione filtri richieste
  AbilitazioneComponente(lblFiltroVis,not Val);
  for i:=Low(FChkArr) to High(FChkArr) do
    AbilitazioneComponente(FChkArr[i],not Val);

  // abilitazione checkbox "con / senza visto"
  if Assigned(chkVisto) then
    AbilitazioneComponente(chkVisto,not Val);
  if Assigned(chkNoVisto) then
    AbilitazioneComponente(chkNoVisto,not Val);

  // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
  // abilitazione filtro struttura
  AbilitazioneComponente(lblFiltroStruttura,not Val);
  AbilitazioneComponente(cmbFiltroStruttura,not Val);
  // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine

  // abilitazione periodo
  if Assigned(rgpPeriodo) then
    AbilitazioneComponente(rgpPeriodo,not Val);
  AbilitazioneComponente(lblPeriodo,not Val);
  AbilitazioneComponente(lblPeriodoDal,not Val);
  AbilitazioneComponente(edtPeriodoDal,not Val);
  AbilitazioneComponente(lblPeriodoAl,not Val);
  AbilitazioneComponente(edtPeriodoAl,not Val);

  // MONDOEDP - commessa MAN/07.ini - modificato per PARMA_COMUNE - 162156
  // abilitazione filtro allegati
  AbilitazioneComponente(lblAllegati, not Val);
  AbilitazioneComponente(rgpAllegati, not Val);
  AbilitazioneComponente(lblCondizAllegato, not Val);
  AbilitazioneComponente(rgpCondizAllegato, not Val);
  // MONDOEDP - commessa MAN/07.fine

  // abilitazione pulsante di filtro
  AbilitazioneComponente(btnFiltra,not Val);

  // abilitazione pulsanti di gestione
  AbilitazioneComponente(btnTuttiSi,not Val);
  AbilitazioneComponente(btnTuttiNo,not Val);
  AbilitazioneComponente(btnModificaTutti,not Val);
  AbilitazioneComponente(btnAnnullaTutti,not Val);

  FBloccaGestione:=Val;
end;

procedure TR013FIterBase.SetBtnDownloadAllegati;
//Imposta il messaggio di conferma sul btn di download allegati (spostare in visualizzadipendente?)
var
  MaxNrAllegati, MaxDimAllegatiMB: int64;
begin
  btnDownloadAllegati.Visible:=Parametri.DownloadMassivoAllegati and C018.EsisteGestioneAllegati and WR000DM.Responsabile;
  if not btnDownloadAllegati.Visible then
    exit;
  NrAllegati:=0;
  DimAllegati:=0;
  with C018.selTabellaIter do
  begin
    if RecordCount = 0 then
      Exit;
    First;
    while not Eof do
    begin
      C018.Id:=FieldByName('ID').AsInteger;
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      if (not C018.EsisteGestioneAllegati) or
         (not C018.EsisteGestioneAllegatiCodIter) or
         (C018.AllegatiVisibili[FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] = 'N') then
      begin
        Next;
        Continue;
      end;

      R180SetVariable(C018.selT853_T960, 'ID', FieldByName('ID').AsInteger);
      C018.selT853_T960.Open;
      C018.selT853_T960.First;
      while not C018.selT853_T960.Eof do
      begin
        inc(NrAllegati);
        inc(DimAllegati, C018.selT853_T960.FieldByName('DIMENSIONE').AsLargeInt);
        C018.selT853_T960.Next;
      end;
      Next;
    end;
    First;
  end;

  MaxDimAllegatiMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterDimMaxDownloadMassivoMB,0);
  MaxNrAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterNrMaxDownloadMassivo,0);

  if ((MaxNrAllegati > 0) and (NrAllegati > MaxNrAllegati)) or
     ((MaxDimAllegatiMB > 0) and (DimAllegati > MaxDimAllegatiMB * BYTES_MB)) then
    btnDownloadAllegati.Confirmation:=''
  else
    btnDownloadAllegati.Confirmation:=Format('Scaricare %s file allegati? (%s)',[NrAllegati.ToString,R180GetFileSizeStr(DimAllegati)]);
  btnDownloadAllegati.Enabled:=NrAllegati > 0;
end;

procedure TR013FIterBase.AddCampoMetadati(pLabel,pValore: string; pSize: integer = 0);
begin
  FCampiMetadati.Add(pLabel + '=' + pValore + ';' + pSize.ToString);
end;

procedure TR013FIterBase.FormatAndRaiseError(E: Exception; const PNomeProc: String; const PFase: String = '');
// procedura comune di gestione degli errori
var
  Fase, Tipo, Msg, Err: String;
begin
  Fase:=IfThen(Trim(PFase) = '','Si è verificato un errore:','Errore in fase di ' + PFase + ':') + CRLF;
  Msg:=E.Message;
  if (RightStr(E.Message,1) <> CR) and
     (RightStr(E.Message,1) <> LF) then
    Msg:=Msg + CRLF;
  Tipo:=IfThen(E.ClassName = 'Exception','','Tipo: ' + E.ClassName + CRLF);
  Err:=Format('Maschera: %s%s%s%s%sRiferimento errore: %s.%s',
              [Title,CRLF,Fase,Msg,Tipo,medpCodiceForm,PNomeProc]);
  raise Exception.Create(Err);
end;

procedure TR013FIterBase.GetDipendentiDisponibili(Data:TDateTime);
// le selezioni anagrafiche vengono eseguite alla data finale del periodo
// di visualizzazione attualmente indicato
// se la data fine è vuota (31/12/3999) viene utilizzata la data odierna
begin
  if (Data = DATE_MAX) and
     (C018.Periodo.Fine = Data) then
  begin
    //Data:=Date;
    Data:=Parametri.DataLavoro;
  end;
  inherited GetDipendentiDisponibili(Data);
end;

function TR013FIterBase.GetInfoFunzione: String;
var
  PeriodoStr: String;
begin
  Result:=inherited;
  if C018 <> nil then
  begin
    PeriodoStr:=C190PeriodoStr(C018.Periodo.Inizio,C018.Periodo.Fine);
    if PeriodoStr = '' then
      PeriodoStr:=A000TraduzioneStringhe(A000MSG_MSG_COMPLETO);
    Result:=Result + '<hr>' + A000TraduzioneStringhe(A000MSG_MSG_PERIODO_RICHIESTE) + ': ' + PeriodoStr;
  end;
end;

procedure TR013FIterBase.VisualizzaDipendenteCorrente;
// ridefinisce la procedura
// per impostare alcune property di default
begin
  InModificaTutti:=False;
  InAutorizzaTutti:=False;
  inherited;
end;

// ############################################################
// #########   Aggiornamento filtro visualizzazione   #########
// ############################################################

procedure TR013FIterBase.R013Open(PDataset: TDataSet; PInfoDebug: Boolean = False);
var
  LStartTime: TDateTime;
  S,FiltroP: String;
  L: TStringList;
  i: Integer;
  LOrdinamento: String;
const
  FUNZIONE = 'R013Open';
begin
  try
    // informazioni di debug
    if PInfoDebug and (PDataset is TOracleDataset) then
    begin
      S:=FormatDateTime('hh.nn.ss',Now) + ' - filtro ' +
         IfThen(C018.TipoRichiesteEsclusivo,'esclusivo (immediato)','multiplo (async)');
      DebugAdd(S);
      DebugAdd('----');
      DebugAdd('Filtro visualizzazione:');
      DebugAdd(VarToStr((PDataset as TOracleDataset).GetVariable('FILTRO_VISUALIZZAZIONE')));
      DebugAdd('----');
      DebugAdd('Filtro struttura:');
      DebugAdd(VarToStr((PDataset as TOracleDataset).GetVariable('FILTRO_STRUTTURA')));
      DebugAdd('----');
      DebugAdd('Filtro allegati:');
      DebugAdd(VarToStr((PDataset as TOracleDataset).GetVariable('FILTRO_ALLEGATI')));
      DebugAdd('----');
      DebugAdd('Filtro periodo ' + IfThen(C018.Periodo.Tipo = 'M','manuale','automatico') + ':');
      FiltroP:=VarToStr((PDataset as TOracleDataset).GetVariable('FILTRO_PERIODO'));
      DebugAdd(IfThen(FiltroP = '<vuoto>','',FiltroP));
      DebugAdd(IfThen(PDataset.Filtered,PDataset.Name + '.Filtered = True'));
    end;

    //Ottimizzazione query sostituendo T430 a V430
    if PDataSet is TOracleDataSet then
      WR000DM.TransV430toT430((PDataset as TOracleDataSet));

    // TORINO_ITC.ini
    // chiamata 114864 - ordinamento delle richieste da autorizzare per data richiesta in base a parametro aziendale
    if PDataset is TOracleDataSet then
    begin
      if C018.NotificaAttivita then
      begin
        LOrdinamento:='';
      end
      else
      begin
        if C018.Iter=ITER_BUDGET_STRAORD then
        begin
          if (Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta = 'S') and
             (trDaAutorizzare in C018.TipoRichiesteSel) and
             (not (trTutte in C018.TipoRichiesteSel)) then
            LOrdinamento:='T850.DATA DESC, %s'
          else
            LOrdinamento:='%s, T850.DATA DESC';
        end
        else
        begin
          if (Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta = 'S') and
             (trDaAutorizzare in C018.TipoRichiesteSel) and
             (not (trTutte in C018.TipoRichiesteSel)) then
            LOrdinamento:='T850.DATA DESC, NOMINATIVO, T030A.MATRICOLA, %s'
          else
            LOrdinamento:='NOMINATIVO, T030A.MATRICOLA, %s, T850.DATA DESC';
        end;
        LOrdinamento:=Format(LOrdinamento,[C018.OrderByIter]);
      end;

      // imposta l'ordinamento
      TOracleDataSet(PDataset).SetVariable('ORDINAMENTO',IfThen(LOrdinamento <> '','order by ' + LOrdinamento));

      // debug
      if PInfoDebug then
      begin
        DebugAdd('----');
        DebugAdd('Ordinamento:');
        DebugAdd(VarToStr(TOracleDataset(PDataset).GetVariable('ORDINAMENTO')));
      end;
    end;
    // TORINO_ITC.fine

    LStartTime:=Now;

    // apertura dataset
    PDataset.Open;
    SetBtnDownloadAllegati;

    if PInfoDebug then
    begin
      DebugAdd('----');
      DebugAdd('Tempo esecuzione query: ' + FormatDateTime('ss.zzz',Now - LStartTime));
    end;
    LogConsoleTime(Format('%s - apertura dataset %s',[FUNZIONE,PDataset.Name]),LStartTime);
  except
    on E: Exception do
    begin
      if PDataset is TOracleDataset then
      begin
        // salva il testo della query errata nei messaggi delle elaborazioni (per B000)
        Log('Errore','R013Open;inizio query ' + PDataset.Name,E);
        S:=(PDataset as TOracleDataset).SubstitutedSQL;
        L:=TStringList.Create;
        try
          L.Text:=S;
          R180SplitLines(L,[' ',','],1800);
          for i:=0 to L.Count - 1 do
            Log('Errore',L[i]);
          Log('Errore','R013Open;fine query ' + PDataset.Name,E);
        finally
          FreeAndNil(L);
          FormatAndRaiseError(E,Format('R013Open (%s)',[PDataset.Name]),'interrogazione delle richieste');
        end;
      end
      else
      begin
        Log('Errore','R013Open',E);
        FormatAndRaiseError(E,Format('R013Open (%s)',[PDataset.Name]),'apertura elenco richieste');
      end;
    end;
  end;
end;

procedure TR013FIterBase.IterBaseApplicaFiltro(Sender: TObject);
// procedura base per la gestione del pulsante "Filtra"
var
  DalStr,AlStr: String;
  IsGiornoPrec: Boolean;
begin
  DebugClear;

  // gestione caso particolare giorno precedente
  IsGiornoPrec:=(rgpPeriodo.Visible) and (rgpPeriodo.ItemIndex = 0);
  if IsGiornoPrec then
  begin
    // caso particolare del giorno precedente
    DalStr:=DateToStr(Date - 1);
    AlStr:=DalStr;
  end
  else
  begin
    // caso normale: periodo dal.. al..
    DalStr:=edtPeriodoDal.Text;
    AlStr:=edtPeriodoAl.Text;
  end;

  // imposta il periodo manuale
  if (DalStr <> OldPeriodoDal) or
     (AlStr <> OldPeriodoAl) then
  begin
    C018.Periodo.Tipo:='M';
  end;

  // pulisce info periodo
  C018.Periodo.SetVuoto;

  // imposta inizio periodo
  try
   C018.Periodo.InizioStr:=DalStr;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      edtPeriodoDal.SetFocus;
      Exit;
    end;
  end;

  // imposta fine periodo
  try
    C018.Periodo.FineStr:=AlStr;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,INFORMA);
      edtPeriodoAl.SetFocus;
      Exit;
    end;
  end;

  // MONDOEDP - commessa MAN/07.ini - modificato per PARMA_COMUNE - 162156
  case rgpAllegati.ItemIndex of
    0: C018.RichiesteConAllegati:=raTutte;
    1: C018.RichiesteConAllegati:=raConAllegati;
    2: C018.RichiesteConAllegati:=raSenzaAllegati;
  end;
  case rgpCondizAllegato.ItemIndex of
    0: C018.CondizioneAllegati:=caTutte;
    1: C018.CondizioneAllegati:=caNonPrevisti;
    2: C018.CondizioneAllegati:=caFacoltativi;
    3: C018.CondizioneAllegati:=caObbligatori;
  end;
  // MONDOEDP - commessa MAN/07.fine

  if ApplicaFiltroRefreshDipendenti then
    GetDipendentiDisponibili(C018.Periodo.Fine);

  // se indicata, esegue la funzione di filtro definita nella unit specifica
  // altrimenti esegue la procedura VisualizzaDipendenteCorrente
  if Assigned(OnApplicaFiltro) then
  begin
    try
      OnApplicaFiltro(Sender);
    except
      on E: Exception do
        FormatAndRaiseError(E,'OnApplicaFiltro','filtro delle richieste');
    end;
  end
  else
  begin
    // comportamento standard
    VisualizzaDipendenteCorrente;
  end;
end;

// ############################################################
// ###############   Autorizzazione richieste   ###############
// ############################################################

procedure TR013FIterBase.IterBaseModificaTutto(Sender: TObject);
// porta in modifica tutte le righe per effettuare una operazione massiva
begin
  InModificaTutti:=True;

  // se indicata, esegue la funzione di filtro definita nella unit specifica
  if Assigned(OnModificaTutto) then
  begin
    try
      OnModificaTutto(Sender);
    except
      on E: Exception do
        FormatAndRaiseError(E,'OnModificaTutto');
    end;
  end;
  //else
    //...
end;

procedure TR013FIterBase.IterBaseConfermaTutto(Sender: TObject);
// permette la conferma massiva di tutte le autorizzazioni / richieste
begin
  if Assigned(OnConfermaTutto) then
  begin
    OperazioneOK:=False;
    try
      OnConfermaTutto(Sender,OperazioneOK);
    except
      on E: EC018RichiestaNonValidaException do
      begin
        MsgBox.MessageBox(E.Message,ESCLAMA,'Errore di validità richiesta');
        Exit;
      end;
      on E: Exception do
      begin
        // gestione standard dell'errore
        FormatAndRaiseError(E,'OnConfermaTutto');
      end;
    end;
  end
  else
    OperazioneOK:=True;

  if OperazioneOK then
  begin
    InModificaTutti:=False;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TR013FIterBase.IterBaseDownloadAllegati(Sender: TObject);
  // procedura di download massivo degli allegati
  // se indicata, esegue la funzione di download definita nella unit specifica
var
  C021DM: TC021FDocumentiManagerDM;
  DocZip: String;
  ResCtrl: TResCtrl;
  FileCsv: TStream;
  CampoTabIter, CampoTabMetadati: string;
  i: integer;
  MaxDimAllegatiMB, MaxNrAllegati: integer;
  ColonnaDal, DataR, Causale: string;
begin
  try
    if not Parametri.DownloadMassivoAllegati or
       not C018.EsisteGestioneAllegati then
      Exit;
    A000SessioneWEB.AnnullaTimeOut;

    MaxDimAllegatiMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterDimMaxDownloadMassivoMB,0);
    MaxNrAllegati:=StrToIntDef(Parametri.CampiRiferimento.C90_IterNrMaxDownloadMassivo,0);

    if ((MaxNrAllegati > 0) and (NrAllegati > MaxNrAllegati)) then
    begin
      MsgBox.MessageBox(Format('Impossibile effettuare il download perché sono stati selezionati %s allegati. ' + CRLF +
                               'È impostato un limite di %s file scaricabili in un unico archivio.', [NrAllegati.ToString, MaxNrAllegati.ToString]), ESCLAMA);
      Exit;
    end
    else if ((MaxDimAllegatiMB > 0) and (DimAllegati > MaxDimAllegatiMB  * BYTES_MB)) then
    begin
      MsgBox.MessageBox(Format('Impossibile effettuare il download perché la dimensione complessiva degli allegati selezionati %s ' + CRLF +
                               'è superiore al limite di %s MB scaricabili in un unico archivio.', [R180GetFileSizeStr(DimAllegati), MaxDimAllegatiMB.ToString]), ESCLAMA);
      Exit;
    end;

    cdsMetadati.EmptyDataSet;
    with C018.selTabellaIter do
    begin
      if RecordCount = 0 then
        Exit;
      C021DM:=TC021FDocumentiManagerDM.Create(self);
      First;
      while not Eof do
      begin
        //Aggiungere i controlli di accessibilità agli allegati
        C018.Id:=FieldByName('ID').AsInteger;
        C018.CodIter:=FieldByName('COD_ITER').AsString;
        if (not C018.EsisteGestioneAllegati) or
           (not C018.EsisteGestioneAllegatiCodIter) or
           (C018.AllegatiVisibili[FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger] = 'N') then
        begin
          Next;
          Continue;
        end;

        R180SetVariable(C018.selT853_T960, 'ID', FieldByName('ID').AsInteger);
        C018.selT853_T960.Open;
        C018.selT853_T960.First;
        while not C018.selT853_T960.Eof do
        begin
          ColonnaDal:=C018.ColonnaPeriodoInizio.Replace('T_ITER.','',[rfReplaceAll]);
          if FindField(ColonnaDal) <> nil then
            DataR:=FormatDateTime('dd-mm-yy',FieldByName(ColonnaDal).AsDateTime) + '_'
          else
            DataR:='';

          Causale:=IfThen(Iter = ITER_GIUSTIF, FieldByName('CAUSALE').AsString + '_', '');

          ResCtrl:=C021DM.AddAllegatoByIdToZip(C018.selT853_T960.FieldByName('ID_T960').AsInteger, Format('%s_%s_%s%s%s', [selAnagrafeW.Lookup('MATRICOLA',FieldByName('MATRICOLA').AsString,'COGNOME'), FieldByName('MATRICOLA').AsString, Causale, DataR, C018.selT853_T960.FieldByName('ID').AsString]), DocZip);
          if not ResCtrl.Ok then
          begin
            MsgBox.MessageBox(ResCtrl.Messaggio,ESCLAMA);
            Exit;
          end;

          cdsMetadati.Append;
          cdsMetadati.FieldByName('COGNOME').AsString:=VarToStr(selAnagrafeW.Lookup('MATRICOLA',FieldByName('MATRICOLA').AsString,'COGNOME'));
          cdsMetadati.FieldByName('NOME').AsString:=VarToStr(selAnagrafeW.Lookup('MATRICOLA',FieldByName('MATRICOLA').AsString,'NOME'));
          cdsMetadati.FieldByName('CODFISCALE').AsString:=VarToStr(selAnagrafeW.Lookup('MATRICOLA',FieldByName('MATRICOLA').AsString,'CODFISCALE'));
          cdsMetadati.FieldByName('MATRICOLA').AsString:=FieldByName('MATRICOLA').AsString;
          cdsMetadati.FieldByName('NOME_FILE').AsString:=ResCtrl.Messaggio;
          cdsMetadati.FieldByName('NOME_ORIGINALE').AsString:=C018.selT853_T960.FieldByName('NOME_FILE').AsString + '.' + C018.selT853_T960.FieldByName('EXT_FILE').AsString;
          cdsMetadati.FieldByName('DATA_RICHIESTA').AsDateTime:=FieldByName('DATA_RICHIESTA').AsDateTime;
          cdsMetadati.FieldByName('ID_RICH').AsInteger:=FieldByName('ID').AsInteger;
          cdsMetadati.FieldByName('ID_T960').AsInteger:=C018.selT853_T960.FieldByName('ID_T960').AsInteger;
          for i:=0 to FCampiMetadati.Count-1 do
          begin
            CampoTabIter:=FCampiMetadati.ValueFromIndex[i].Split([';'])[0];
            CampoTabMetadati:=FCampiMetadati.Names[i];
            cdsMetadati.FieldByName(CampoTabMetadati).Value:=FieldByName(CampoTabIter).Value;
          end;

          cdsMetadati.Post;
          C018.selT853_T960.Next;
        end;
        Next;
      end;
      First;

      if DocZip <> '' then
      begin
        FileCsv:=R180DatasetToXlsx(A000UInterfaccia.SessioneOracle, True,cdsMetadati);
        ResCtrl:=C021DM.AddFileToZip(FileCsv, 'Riepilogo.xlsx', DocZip);
        if not ResCtrl.Ok then
        begin
          MsgBox.MessageBox(ResCtrl.Messaggio,ESCLAMA);
          Exit;
        end;
        C021DM.CloseZip;
      end;

      //Download del file .zip creato
      GGetWebApplicationThreadVar.SendFile(DocZip,True,'application/x-download',ExtractFileName(DocZip));
    end;

    if Assigned(OnDownloadAllegati) then
    begin
      try
        OnDownloadAllegati(Sender);
      except
        on E: Exception do
          FormatAndRaiseError(E,'OnDownloadAllegati');
      end;
    end;

  finally
    if Assigned(C021DM) then
      FreeAndNil(C021DM);
    A000SessioneWEB.RipristinaTimeOut;
  end;
  InModificaTutti:=False;
end;

procedure TR013FIterBase.IterBaseAnnullaTutto(Sender: TObject);
// procedura di annullamento della modifica massiva
begin
  // se indicata, esegue la funzione di filtro definita nella unit specifica
  if Assigned(OnAnnullaTutto) then
  begin
    try
      OnAnnullaTutto(Sender);
    except
      on E: Exception do
        FormatAndRaiseError(E,'OnAnnullaTutto');
    end;
  end;

  InModificaTutti:=False;
end;

procedure TR013FIterBase.IterBaseAutorizzaTutto(Sender: TObject);
// permette l'autorizzazione massiva di tutte le richieste
// (gestione dei pulsanti "Autorizza tutto" e "Nega tutto")
begin
  InAutorizzaTutti:=True;

  if Assigned(OnAutorizzaTutto) then
  begin
    OperazioneOK:=False;
    try
      OnAutorizzaTutto(Sender,OperazioneOK);
    except
      on E: Exception do
        FormatAndRaiseError(E,'OnAutorizzaTutto','autorizzazione delle richieste');
    end;
  end
  else
    OperazioneOK:=True;

  if OperazioneOK then
    VisualizzaDipendenteCorrente;
end;

end.
