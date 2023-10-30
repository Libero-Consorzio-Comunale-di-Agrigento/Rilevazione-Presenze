unit W050URichiestaDocumentale;

interface

uses
  System.SysUtils, System.Classes, System.Math, System.StrUtils, R013UIterBase, Vcl.Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, W000UMessaggi, A000UMessaggi,
  IWTemplateProcessorHTML, IWApplication, IWDBGrids, medpIWDBGrid, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, System.IOUtils, Oracle,
  Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, C180FunzioniGenerali,
  IWHTMLControls, meIWLink, A000UInterfaccia, A000UCostanti, OracleData, C021UDocumentiManagerDM, A155URicercaDocumentaleMW,
  W050URichiestaDocumentaleDM, C018UIterAutDM, C004UParamForm, meIWImageFile, meIWMemo,
  Data.DB, Datasnap.DBClient, C190FunzioniGeneraliWeb, Variants, meIWCheckBox, meIWFileUploader, meIWComboBox;

type
  TAzioniAbilitate = record
    Modifica: Boolean;
    Elimina: Boolean;
  end;

  TRichiestaDocumentale = class(TObject)
  public
    IdRichiesta: Integer;
    Definitiva: Boolean;
    AccessoResponsabile, NoteRichiesta: String;
    Documento: TDocumento;

    constructor Create;
    destructor Destroy; override;
  end;

  TW050FRichiestaDocumentale = class(TR013FIterBase)
    cdsT960: TClientDataSet;
    dsrT960: TDataSource;
    lblInfo: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
  private
    FRichiesta: TRichiestaDocumentale;
    vData: TDateTime;
    W050DM: TW050FRichiestaDocumentaleDM;
    C021: TC021FDocumentiManagerDM;
    Operazione, FNomeFileGenerato: String;
    ColDbgIter,ColNomeFile,ColDimensione,ColPeriodoDal,ColPeriodoAl,ColCFFamiliare: Integer;
    ColTipologia,ColVisualizResp, ColNote, ColTipoRichiesta: Integer;
    StileCella1,StileCella2: String;
    iImgDownload, jImgDownload: Integer;
    IterMaxDimAllegatoMB: Integer;
    procedure W050AutorizzaTutti(Sender: TObject; var Ok: Boolean);
    procedure imgIterClick(Sender: TObject);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure CreaComponentiRiga(FN: String);
    procedure DistruggiComponentiRiga(FN: String);
    procedure imgModificaClick(Sender:TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgDownloadClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String);
    function ControlliOK(FN: String): Boolean;
    function ControlliPeriodo(FN: string; pQ: integer; pUM: Char): Boolean;
    procedure actInsRichiesta(FN: String);
    procedure actModRichiesta(const FN: String);
    procedure ConfermaInsRichiesta;
    procedure ConfermaModRichiesta;
    procedure actCancRichiesta(FN: String);
    procedure AutorizzazioneOK(RowidT960,Aut: String);
    procedure CaricaJQAutocomplete(Griglia: TmedpIWDBGrid; r: Integer);
    function Occurrences(const Substring, Text: string): integer;
    procedure AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
    function GetAzioniAbilitateRiga(const PRiga: Integer): TAzioniAbilitate;
    function FormattaDatiRichiesta: String;
  protected
    procedure GetDipendentiDisponibili(Data: TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

const
  LIMITE_CARATTERI_NOTE = 100;  // limite di caratteri per le note da visualizzare in tabella
  LIMITE_RIGHE_NOTE     =   4;  // limite di ritorni a capo per le note da visualizzare in tabella

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TW050FRichiestaDocumentale }
function TW050FRichiestaDocumentale.InizializzaAccesso: Boolean;
begin
  // inizializzazioni
  Result:=True;
  vData:=ParametriForm.Al;
  GetDipendentiDisponibili(vData);
  selAnagrafeW.SearchRecord('PROGRESSIVO', ParametriForm.Progressivo, [srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    //seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;

    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W050AutorizzaTutti;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TW050FRichiestaDocumentale.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,458,457);
  inherited;
  W050DM:=TW050FRichiestaDocumentaleDM.Create(Self);
  C021:=TC021FDocumentiManagerDM.Create(Self);

  Iter:=ITER_DOCUMENTALE;
  vData:=Parametri.DataLavoro;
  FRichiesta:=nil;

  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W050DM.selT960, tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W050DM.selT960, tiRichiesta);

  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile, 'W050P1', 'W050P0');

  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W050DM.selT960;
  grdRichieste.medpTestoNoRecord:='Nessun documento';

  // dimensione max allegati solo se non responsabile
  if not WR000DM.Responsabile then
  begin
    IterMaxDimAllegatoMB:=StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);
    lblInfo.Caption:=Format(A000TraduzioneStringhe(A000MSG_W039_MSG_FMT_INFO_DIM_DOCUMENTO),[IterMaxDimAllegatoMB]);
  end
  else
    lblInfo.Caption:='';
end;

procedure TW050FRichiestaDocumentale.IWAppFormRender(Sender: TObject);
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  //gestione autorizza / nega tutto
  if btnTuttiSi.Visible then
    btnTuttiSi.Visible:=(W050DM.selT960.RecordCount > 1);
  btnTuttiNo.Visible:=btnTuttiSi.Visible;
end;

procedure TW050FRichiestaDocumentale.GetDipendentiDisponibili(Data: TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW050FRichiestaDocumentale.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  cdsT960.Locate('DBG_ROWID',AValue,[]);
  // posizionamento dataset
  W050DM.selT960.SearchRecord('ROWID',cdsT960.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);
end;

procedure TW050FRichiestaDocumentale.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
begin
  inherited;
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  //apertura dataset delle richieste
  with W050DM.selT960 do
  begin
    Close;
    //filtro in base alla selezione anagrafica
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       FiltroSingoloAnagrafico
                       );
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);

    R013Open(W050DM.selT960);
  end;
  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;

  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Data rich.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    grdRichieste.medpAggiungiColonna('D_NOME_FILE','Nome file','',nil);
    grdRichieste.medpAggiungiColonna('D_DIMENSIONE','Dimensione','',nil);
    grdRichieste.medpAggiungiColonna('PERIODO_DAL','Inizio periodo','',nil);
    grdRichieste.medpAggiungiColonna('PERIODO_AL','Fine periodo','',nil);
    grdRichieste.medpAggiungiColonna('CF_FAMILIARE','CF Familiare','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPOLOGIA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('D_ACCESSO_RESPONSABILE','Visualizzabile dai resp.','',nil);
    grdRichieste.medpColonna('D_ACCESSO_RESPONSABILE').Visible:=False;
    grdRichieste.medpAggiungiColonna('NOTE','Note','',nil);

    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;

  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Data rich.','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Stato','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna('D_NOME_FILE','Nome file','',nil);
    grdRichieste.medpAggiungiColonna('D_DIMENSIONE','Dimensione','',nil);
    grdRichieste.medpAggiungiColonna('PERIODO_DAL','Inizio periodo','',nil);
    grdRichieste.medpAggiungiColonna('PERIODO_AL','Fine periodo','',nil);
    grdRichieste.medpAggiungiColonna('CF_FAMILIARE','CF Familiare','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPOLOGIA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('D_ACCESSO_RESPONSABILE','Visualizzabile dai resp.','',nil);
    grdRichieste.medpAggiungiColonna('NOTE','Note','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
  end;

  ColTipoRichiesta:=grdRichieste.medpIndexColonna('D_TIPO_RICHIESTA');
  ColNomeFile:=grdRichieste.medpIndexColonna('D_NOME_FILE');
  ColDimensione:=grdRichieste.medpIndexColonna('D_DIMENSIONE');
  ColPeriodoDal:=grdRichieste.medpIndexColonna('PERIODO_DAL');
  ColPeriodoAl:=grdRichieste.medpIndexColonna('PERIODO_AL');
  ColCFFamiliare:=grdRichieste.medpIndexColonna('CF_FAMILIARE');
  ColTipologia:=grdRichieste.medpIndexColonna('D_TIPOLOGIA');
  ColVisualizResp:=grdRichieste.medpIndexColonna('D_ACCESSO_RESPONSABILE');
  ColNote:=grdRichieste.medpIndexColonna('NOTE');
  ColDbgIter:=grdRichieste.medpIndexColonna(DBG_ITER);

  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');

  if (not SolaLettura) then
  begin
    if not WR000DM.Responsabile then
    begin
      //riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','C');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');
      //riga dati
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','C');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','SALVA','Download del documento','','D');
    end
    else
    begin  //componenti riga responsabile
      //riga dati
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','SALVA','Download del documento','','');
      grdRichieste.medpPreparaComponenteGenerico('R',1,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',1,1,DBG_CHK,'','No','','');
    end;
  end;
  grdRichieste.medpCaricaCDS;
end;

procedure TW050FRichiestaDocumentale.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 458;
  VisualizzaDipendenteCorrente;
end;

procedure TW050FRichiestaDocumentale.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  IWImg: TmeIWImageFile;
  LAbilRiga: TAzioniAbilitate;
begin
  if grdRichieste.medpRigaInserimento and (not SolaLettura) then
  begin
    if StileCella1 = '' then
    begin
      with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        StileCella1:=Cell[0,0].Css;
        StileCella2:=Cell[0,2].Css;
      end;
    end;
    //Riga di inserimento
    (grdRichieste.medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
    (grdRichieste.medpCompCella(0,0,1)as TmeIWImageFile).OnClick:=imgAnnullaClick;
    (grdRichieste.medpCompCella(0,0,2)as TmeIWImageFile).OnClick:=imgConfermaClick;
    with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,1].Css:='invisibile';  //annulla e conferma non visibili
      Cell[0,2].Css:='invisibile';
    end;
  end;
  //righe dati
  for r:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(r,'ID_RICHIESTA')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(r,'COD_ITER'));
    // dettaglio iter
    IWImg:=TmeIWImageFile(grdRichieste.medpCompCella(r,DBG_ITER,0));
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

    if not SolaLettura then
    begin
      if not WR000DM.Responsabile then
      begin
        //Associo l'evento OnClick alle icone dei comandi
        if (grdRichieste.medpCompGriglia[r].CompColonne[0] <> nil) then
        begin
          if StileCella1 = '' then
          begin
            with (grdRichieste.medpCompGriglia[r].CompColonne[0] as TmeIWGrid) do
            begin
              StileCella1:=Cell[0,0].Css;
              StileCella2:=Cell[0,1].Css;
            end;
          end;
          (grdRichieste.medpCompCella(r,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
          (grdRichieste.medpCompCella(r,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
          (grdRichieste.medpCompCella(r,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
          (grdRichieste.medpCompCella(r,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
          (grdRichieste.medpCompCella(r,0,4)as TmeIWImageFile).OnClick:=imgDownloadClick;
          with (grdRichieste.medpCompGriglia[r].CompColonne[0] as TmeIWGrid) do
          begin
            Cell[0,2].Css:='invisibile';  //annulla e conferma non visibili
            Cell[0,3].Css:='invisibile';
          end;

          // determina abilitazioni per operazioni su documento
          LAbilRiga:=GetAzioniAbilitateRiga(r);

          // modifica
          IWImg:=(grdRichieste.medpCompCella(r,DBG_COMANDI,0) as TmeIWImageFile);
          if IWImg <> nil then
            IWImg.Css:=IfThen(not LAbilRiga.Modifica,'invisibile');

          // cancella
          IWImg:=(grdRichieste.medpCompCella(r,DBG_COMANDI,1) as TmeIWImageFile);
          if IWImg <> nil then
            IWImg.Css:=IfThen(not LAbilRiga.Elimina,'invisibile');

          // Download
          IWImg:=(grdRichieste.medpCompCella(r,DBG_COMANDI,4) as TmeIWImageFile);
          if IWImg <> nil then
            IWImg.Css:=IfThen(Operazione = 'M','invisibile');  //non visibile se sono in modifica
        end;
      end
      else
      begin
        (grdRichieste.medpCompCella(r,0,0) as TmeIWImageFile).OnClick:=imgDownloadClick;
        C018.SetValoriAut(grdRichieste,r,1,0,1,chkAutorizzazioneClick);

        if grdRichieste.medpValoreColonna(r,'AUTORIZZAZIONE') <> '' then
          FreeAndNil(grdRichieste.medpCompGriglia[r].CompColonne[1]);
      end;
    end;
  end;
end;

procedure TW050FRichiestaDocumentale.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna, x: Integer;
  Campo: String;
  NoteLimitate: Boolean;
begin
  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  Campo:=grdRichieste.medpColonna(NumColonna).DataField;

  if (ARow <> 0) and (Length(grdRichieste.medpCompGriglia) > 0) then
  begin
    //il responsabile può scaricare il documento solo se l'accesso è consentito dal dipendente
    if (Campo = DBG_COMANDI) and WR000DM.Responsabile and (grdRichieste.medpValoreColonna(ARow - 1,'ACCESSO_RESPONSABILE')  <> 'S') then
      (grdRichieste.medpCompCella(ARow-1,NumColonna,0) as TmeIWImageFile).Css:='invisibile';

    if (Campo = 'PERIODO_DAL') or (Campo = 'PERIODO_AL') or (Campo = 'DATA_RICHIESTA')
    or (Campo = 'D_TIPO_RICHIESTA') or (Campo = 'D_AUTORIZZAZIONE') or (Campo = 'D_DIMENSIONE')
    or (Campo = 'D_ACCESSO_RESPONSABILE') or (Campo = 'CF_FAMILIARE') or (Campo = 'D_TIPOLOGIA') then
      ACell.Css:=ACell.Css + ' align_center';

    if Campo = 'NOTE' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda dimensioni accettabili
      if (ACell.Text = '') or (ACell.Text = '<br>') then
      begin
        ACell.Hint:='';
        ACell.ShowHint:=False;
      end
      else
      begin
        ACell.Hint:=C190ConvertiSimboliHtml(ACell.Text);
        NoteLimitate:=False;
        if Length(ACell.Text) > LIMITE_CARATTERI_NOTE then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_NOTE)]);
        end;
        x:=Occurrences('<br>',ACell.Text) - IfThen(ACell.Text.EndsWith('<br>'),1);
        if x >= LIMITE_RIGHE_NOTE then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %d.5em;">%s</div>',[LIMITE_RIGHE_NOTE,ACell.Text]);
        end;
        ACell.ShowHint:=NoteLimitate;
        if ACell.ShowHint then
          ACell.Css:=ACell.Css + ' tooltipHtml';
      end;
    end;
  end;
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    if ACell.Control is TmeIWFileUploader then
      Self.ContainerImplementation.AddComponent(ACell.Control); // Bugfix IW 14 (no JS con AddToInitProc())
  end;
end;

procedure TW050FRichiestaDocumentale.imgModificaClick(Sender: TObject);
var FN: String;
begin
  // modifica - applicazione modifiche
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  // rendo il pulsante di download invisibile in modifica
  (grdRichieste.medpCompCella(grdRichieste.medpRigaDiCompGriglia(FN),DBG_COMANDI,4) as TmeIWImageFile).Css:='invisibile';

  W050DM.selT960.Edit;
  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  TrasformaComponenti(FN);
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msEdit;
end;

procedure TW050FRichiestaDocumentale.imgInserisciClick(Sender: TObject);
var FN: String;
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  W050DM.selT960.Append; //faccio qui l'append per innescare OnNewRecord su TA154FGestioneDocumentaleMW

  Operazione:='I';
  TrasformaComponenti(FN);
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msInsert;
end;

procedure TW050FRichiestaDocumentale.imgIterClick(Sender: TObject);
var FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W050DM.selT960 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

procedure TW050FRichiestaDocumentale.imgConfermaClick(Sender: TObject);
// Applica:  conferma i dati presenti nei componenti
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  //effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;
  //inserimento / aggiornamento
  if Operazione = 'I' then
    actInsRichiesta(FN)
  else
    actModRichiesta(FN);
end;

procedure TW050FRichiestaDocumentale.imgAnnullaClick(Sender: TObject);
// Annulla: annulla le modifiche apportate nei componenti editabili
begin
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  grdRichieste.medpCaricaCDS;
end;

procedure TW050FRichiestaDocumentale.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  //cancellazione riga
  actCancRichiesta(FN);
end;

procedure TW050FRichiestaDocumentale.imgDownloadClick(Sender: TObject);
// effettua il download dell'allegato
var
  i: Integer;
  FN: String;
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // estrae id richiesta
  LId:=grdRichieste.medpValoreColonna(i,'ID').ToInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  A000SessioneWEB.AnnullaTimeOut;
  try
    // estrae il file con i metadati associati
    LResCtrl:=C021.GetById(LId,True,LDoc);
    if not LResCtrl.Ok then
    begin
      MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
      Exit;
    end;

    // aggiorna i dati di accesso e scarica il documento
    // IMPORTANTE: al momento i dati di accesso non sono aggiornati!!!
    try
      AggiornaAccessoEScarica(LDoc.Id,LDoc.FilePath);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(E.Message,ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TW050FRichiestaDocumentale.btnSendFileClick(Sender: TObject);
begin
  GGetWebApplicationThreadVar.SendFile(FNomeFileGenerato,true,'application/x-download',ExtractFileName(FNomeFileGenerato));
end;

procedure TW050FRichiestaDocumentale.TrasformaComponenti(FN: String);
{ Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdRichieste }
var
  DaTestoAControlli:Boolean;
  i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  DaTestoAControlli:=Operazione <> '';

  if not WR000DM.Responsabile then  //dipendente
  begin
    if grdRichieste.medpRigaInserimento and (i = 0) then  //se sono in inserimento
    begin
      with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
        Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
        Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
      end;
    end
    else  //in modifica
    begin
      with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
        Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
        Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
        Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
        Cell[0,4].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      end;
    end;
  end
  else   //responsabile
  begin
    with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
    end;
  end;

  if DaTestoAControlli then
    CreaComponentiRiga(FN)
  else
    DistruggiComponentiRiga(FN);
end;

function TW050FRichiestaDocumentale.ControlliPeriodo(FN: string; pQ: integer; pUM: Char): Boolean;
//Controlla che la certificazione in inserimento non rispetti la regola di unicità nel periodo
var
  strErr, strInfo: string;
  Dal, Al: TDateTime;
  DataI, DataF : String;
  DATA_IMin, DATA_IMax: String;
  cntDoc: integer;
begin
  strErr:='';
  strInfo:='(Tipologia di documento non ripetibile entro ';
  //Controllo intersezione periodo
  Dal:=IfThen(FRichiesta.Documento.PeriodoDal>0,FRichiesta.Documento.PeriodoDal,FRichiesta.Documento.DataCreazione);
  Al:=IfThen(FRichiesta.Documento.PeriodoAl>0,FRichiesta.Documento.PeriodoAl,FRichiesta.Documento.DataCreazione);
  DataI:= 'to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy'')';
  DataF:= 'to_date(''' + DateToStr(Al) + ''', ''dd/mm/yyyy'')';

  //Controllo distanza da inizio periodo
  case pUM of
    'D': begin
    DATA_IMin:='to_date(''' + DateToStr(Dal-pQ) + ''', ''dd/mm/yyyy'')';
    DATA_IMax:='to_date(''' + DateToStr(Dal+pQ) + ''', ''dd/mm/yyyy'')';
    strInfo:=strInfo + IntToStr(pQ) + ' giorni)';
    end;

    'W': begin
    DATA_IMin:='to_date(''' + DateToStr(Dal-pQ*7) + ''', ''dd/mm/yyyy'')';
    DATA_IMax:='to_date(''' + DateToStr(Dal+pQ*7) + ''', ''dd/mm/yyyy'')';
    strInfo:=strInfo + IntToStr(pQ) + ' settimane)';
    end;

    'M': begin
    DATA_IMin:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''),- ' + IntToStr(pQ)+ ')';
    DATA_IMax:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''), ' + IntToStr(pQ)+ ')';
    strInfo:=strInfo + IntToStr(pQ) + ' mesi)';
    end;

    'Y': begin
    DATA_IMin:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''),- ' + IntToStr(pQ*12)+ ')';
    DATA_IMax:='Add_months(to_date(''' + DateToStr(Dal) + ''', ''dd/mm/yyyy''), ' + IntToStr(pQ*12)+ ')';
    strInfo:=strInfo + IntToStr(pQ) + ' anni)';
    end;

    else begin
    Result:=False;
    Exit;
    end;
  end;
  with W050DM.selQueryT960 do
  begin
    SetVariable('DATA_I',DataI);
    SetVariable('DATA_F',DataF);
    SetVariable('DATA_IMin',DATA_IMin);
    SetVariable('DATA_IMax',DATA_IMax);

    if FN <> '*' then
      SetVariable('ROWID_T', ' and T960.ROWID <> ' + '''' + FN + '''')
    else
      SetVariable('ROWID_T', '');
    SetVariable('TIPOLOGIA',FRichiesta.Documento.Tipologia);
    SetVariable('PROGRESSIVO', selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    Execute;
    if RowCount > 0 then
    begin
      cntDoc:=0;
      while not (Eof) and (cntDoc < 100) do //Controllo di uscita su cntDoc per sicurezza
      begin
        if cntDoc < 3 then
        begin
          strErr:=strErr + CRLF + '- ' + FieldAsString(0);
          strErr:=strErr + ' del ' + FieldAsString(1);
          if (FieldAsString(2) <> '') and (FieldAsString(3) <> '') then
          strErr:=strErr + ' valido dal ' + FieldAsString(2) + ' al ' + FieldAsString(3);
        end
        else if cntDoc = 3 then
          strErr:=strErr + CRLF + '-  .....';
        inc(cntDoc);
        Next;
      end;
      strErr:=strErr + CRLF + strInfo;
      MsgBox.MessageBox('Documento non ammesso perchè ripetuto nel periodo per la tipologia selezionata, presenti già ' + IntToStr(RowCount) + ' documenti:'  + strErr ,INFORMA);

      Result:=False;
    end
    else
      Result:=True;
  end;
end;

function TW050FRichiestaDocumentale.ControlliOK(FN: String): Boolean;
var i: Integer;
    LIWFileUploader: TmeIWFileUploader;
    IWCmb: TmeIWComboBox;
    sDataDal, sDataAl: String;
    LValore: String;
    Quantita: integer;  //Durata del periodo entro cui non deve ripetersi il documento
    UM: Char;           //Unità di misura del periodo (D = giorni, W = settimane, M = mesi, Y = anni)
begin
  Result:=False;

  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  if Assigned(FRichiesta) then
    FreeAndNil(FRichiesta);

  FRichiesta:=TRichiestaDocumentale.Create;
  with FRichiesta do
  begin
    if Operazione = 'I' then
    begin
      IdRichiesta:=0;
      Documento.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

      A000SessioneWEB.AnnullaTimeOut;
      try
        // gestione oggetto IWFile
        LIWFileUploader:=(grdRichieste.medpCompCella(i,ColNomeFile,0) as TmeIWFileUploader);
        if not LIWFileUploader.IsPresenteFileUploadato then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W039_ERR_SELEZIONARE_DOC));
          Exit;
        end;

        Documento.SetNomeFileCompleto(LIWFileUploader.NomeFile);

        // se esiste già un file temporaneo con lo stesso nome lo cancella
        if TFile.Exists(Documento.TempFile) then
          TFile.Delete(Documento.TempFile);

        // copia il file dalla posizione temporanea del file uploader alla nostra
        // posizione temporanea
        try
          LIWFileUploader.SalvaSuFile(Documento.TempFile);
          LIWFileUploader.Ripristina;
        except
          on E: Exception do
          begin
            LIWFileUploader.Ripristina;
            GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_WC026_ERR_FMT_DOC_UPLOAD),[E.Message]));
            Exit;
          end;
        end;

        Documento.Id:=Documento.GeneraId;
        Documento.Dimensione:=R180GetFileSize(Documento.TempFile);
        Documento.PathStorage:=Parametri.CampiRiferimento.C90_PathAllegati;

        //se PATH_STORAGE = 'DB' upload documento su database
        if Documento.PathStorage = 'DB' then
        begin
          // carica il file in una struttura dati
          Documento.Blob:=TLOBLocator.CreateTemporary(SessioneOracle,otBLOB,True);
          Documento.Blob.Tag:=Integer(btFree); // indica che il blob è da distruggere dal distruttore di TDocumento
          Documento.Blob.LoadFromFile(Documento.TempFile);
        end;
      finally
        A000SessioneWEB.RipristinaTimeOut;
      end;
    end
    else
      IdRichiesta:=grdRichieste.medpDataset.FieldByName('ID_RICHIESTA').AsInteger;

    //tipo richiesta
    Definitiva:=(grdRichieste.medpCompCella(i,ColTipoRichiesta,0) as TmeIWCheckBox).Checked;

    //se la richiesta non è definitiva, i campi sono modificabili
    if (grdRichieste.medpDataset.FieldByName('TIPO_RICHIESTA').AsString <> 'D') or (Operazione = 'I') then
    begin
      sDataDal:=(grdRichieste.medpCompCella(i,ColPeriodoDal,0) as TmeIWEdit).Text;
      sDataAl:=(grdRichieste.medpCompCella(i,ColPeriodoAl,0) as TmeIWEdit).Text;

      if sDataDal <> '' then
        Documento.PeriodoDal:=StrToDate(sDataDal)
      else
        Documento.PeriodoDal:=DATE_NULL;

      if sDataAl <> '' then
        Documento.PeriodoAl:=StrToDate(sDataAl)
      else
        Documento.PeriodoAl:=DATE_NULL;

      Documento.CFFamiliare:=(grdRichieste.medpCompCella(i,ColCFFamiliare,0) as TmeIWEdit).Text;

      //tipologia
      IWCmb:=(grdRichieste.medpCompCella(i,ColTipologia,0) as TmeIWComboBox);
      if IWCmb <> nil then
      begin
        if IWCmb.ItemIndex = -1 then
          LValore:=''
        else
          LValore:=TValore(IWCmb.Items.Objects[IWCmb.ItemIndex]).Valore;
        Documento.Tipologia:=LValore;
      end;

      Documento.Note:=Trim((grdRichieste.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text);
      AccessoResponsabile:=IfThen((grdRichieste.medpCompCella(i,'D_ACCESSO_RESPONSABILE',0) as TmeIWCheckBox).Checked,'S','N');
    end
    else
    begin
      Documento.PeriodoDal:=grdRichieste.medpDataset.FieldByName('PERIODO_DAL').AsDateTime;
      Documento.PeriodoAl:=grdRichieste.medpDataset.FieldByName('PERIODO_DAL').AsDateTime;
      Documento.CFFamiliare:=grdRichieste.medpDataset.FieldByName('CF_FAMILIARE').AsString;
      Documento.Tipologia:=grdRichieste.medpDataset.FieldByName('TIPOLOGIA').AsString;
      Documento.Note:=grdRichieste.medpDataset.FieldByName('NOTE').AsString;
      AccessoResponsabile:=grdRichieste.medpDataset.FieldByName('ACCESSO_RESPONSABILE').AsString;
    end;

    with W050DM.selT962 do
    begin
      Close;
      SetVariable('TIPOLOGIA', Documento.Tipologia);
      Open;

      if RecordCount <> 1 then
        raise Exception.Create('Tipologia documento non trovata per il controllo del periodo selezionato');

      Quantita:=FieldByName('QUANTITA').AsInteger;
      UM:=R180CarattereDef(FieldByName('UM').AsString);
      if (UM in ['D','W','M','Y']) and (Quantita > 0) then
        if not ControlliPeriodo(FN, Quantita, UM) then
          Exit;
    end;
  end;

  Result:=True;
end;

procedure TW050FRichiestaDocumentale.actInsRichiesta(FN: String);
begin
  with W050DM.selT960 do
  begin
    FieldByName('ID').AsInteger:=FRichiesta.Documento.Id;
    FieldByName('NOME_FILE').AsString:=FRichiesta.Documento.NomeFile;
    FieldByName('EXT_FILE').AsString:=FRichiesta.Documento.ExtFile;
    FieldByName('DIMENSIONE').AsFloat:=FRichiesta.Documento.Dimensione;
    FieldByName('PATH_STORAGE').AsString:=FRichiesta.Documento.PathStorage;

    if FRichiesta.Documento.PeriodoDal <> DATE_NULL then
      FieldByName('PERIODO_DAL').AsDateTime:=FRichiesta.Documento.PeriodoDal
    else
      FieldByName('PERIODO_DAL').Value:=null;

    if FRichiesta.Documento.PeriodoAl <> DATE_NULL then
      FieldByName('PERIODO_AL').AsDateTime:=FRichiesta.Documento.PeriodoAl
    else
      FieldByName('PERIODO_AL').Value:=null;

    FieldByName('CF_FAMILIARE').AsString:=FRichiesta.Documento.CFFamiliare;
    FieldByName('TIPOLOGIA').AsString:=FRichiesta.Documento.Tipologia;
    FieldByName('NOTE').AsString:=FRichiesta.Documento.Note;
    FieldByName('ACCESSO_RESPONSABILE').AsString:=FRichiesta.AccessoResponsabile;
  end;
  // note richiesta
  C018.Note:=FRichiesta.NoteRichiesta;

  if not C018.WarningRichiesta then
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,nil)
  else
    ConfermaInsRichiesta;
end;

procedure TW050FRichiestaDocumentale.ConfermaInsRichiesta;
var IdIns:String;
    LResCtrl: TResCtrl;
begin
  with W050DM.selT960 do
  begin
    try
      C018.InsRichiesta(IfThen(FRichiesta.Definitiva, 'D', ''), FRichiesta.NoteRichiesta, ''); //fa qui il post sulla selT960
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);

      IdIns:=RowId;

      LResCtrl:=C021.Upload(FRichiesta.Documento);

      if not LResCtrl.Ok then
      begin
        C018.EliminaIter; //elimino l'iter inserito con C018.InsRichiesta
        SessioneOracle.Commit;
        raise Exception.Create(LResCtrl.Messaggio);
      end;

      SessioneOracle.Commit;
      FreeAndNil(FRichiesta);
    except
      on E:Exception do
      begin
        Cancel;
        grdRichieste.medpDataSet.Refresh; //necessario dopo C018.EliminaIter x evitare che il record compaia nella dbgrid
        Append;
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della richiesta fallito!' + CRLF + 'Motivo: ' + E.Message);
        Exit;
      end;
    end;
  end;

  C018.Periodo.Estendi(W050DM.selT960.FieldByName('DATA_CREAZIONE').AsDateTime, W050DM.selT960.FieldByName('DATA_CREAZIONE').AsDateTime);
  C018.IncludiTipoRichieste(trDaAutorizzare);
  C018.StrutturaSel:=C018STRUTTURA_TUTTE;

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW050FRichiestaDocumentale.actModRichiesta(const FN: String);
begin
  with W050DM.selT960 do
  begin
    //quando la modifica consiste nel passaggio di richiesta da definitiva a da confermare
    //non eseguo i controlli di validità, già fatti in inserimento
    if not((FieldByName('TIPO_RICHIESTA').AsString = 'D') and not FRichiesta.Definitiva) then
    begin
      FieldByName('TIPOLOGIA').AsString:=FRichiesta.Documento.Tipologia;
      if FRichiesta.Documento.PeriodoDal = DATE_NULL then
        FieldByName('PERIODO_DAL').Value:=null
      else
        FieldByName('PERIODO_DAL').AsDateTime:=FRichiesta.Documento.PeriodoDal;
      if FRichiesta.Documento.PeriodoAl = DATE_NULL then
        FieldByName('PERIODO_AL').Value:=null
      else
        FieldByName('PERIODO_AL').AsDateTime:=FRichiesta.Documento.PeriodoAl;
      FieldByName('CF_FAMILIARE').AsString:=FRichiesta.Documento.CFFamiliare;
      FieldByName('NOTE').AsString:=FRichiesta.Documento.Note;
      FieldByName('ACCESSO_RESPONSABILE').AsString:=FRichiesta.AccessoResponsabile;

      if not C018.ValiditaRichiesta then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Inserimento delle modifiche fallito!' + CRLF + 'Motivo: ' + C018.MessaggioOperazione);
        Exit;
      end;
      if not C018.WarningRichiesta then
      begin
        Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaModRichiesta,nil);
        Exit;
      end;
    end;
    ConfermaModRichiesta;
  end;
end;

procedure TW050FRichiestaDocumentale.ConfermaModRichiesta;
begin
  try
    W050DM.selT960.Post;

    C018.Id:=FRichiesta.IdRichiesta;
    C018.SetTipoRichiesta(IfThen(FRichiesta.Definitiva,'D',''));
    SessioneOracle.Commit;

    if FRichiesta.Definitiva then
      C018.VerificaRichiestaEsistente('');

    // aggiorna visualizzazione
    grdRichieste.medpResetOffset;
    VisualizzaDipendenteCorrente;
  except
    on E: Exception do
    begin
      W050DM.selT960.Cancel;
      W050DM.selT960.Edit;
      GGetWebApplicationThreadVar.ShowMessage('Inserimento delle modifiche fallito!' + CRLF + 'Motivo: ' + E.Message);
    end;
  end;
end;

procedure TW050FRichiestaDocumentale.actCancRichiesta(FN: String);
begin
  //cancellazione record
  with W050DM.selT960 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      try
        C018.CodIter:=FieldByName('COD_ITER').AsString;
        C018.Id:=FieldByName('ID_RICHIESTA').AsInteger;
        C018.EliminaIter;

        W050DM.selT960.Delete;  //oltre alla richiesta, elimino anche il documento dal db!

        SessioneOracle.Commit;
      except
        on E:Exception do
        begin
          SessioneOracle.Commit;
          GGetWebApplicationThreadVar.ShowMessage('Cancellazione della richiesta fallita!' + CRLF + 'Motivo: ' + E.Message);
        end;
      end;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW050FRichiestaDocumentale.CreaComponentiRiga(FN: String);
var i,k: Integer;
    IWCmb: TmeIWComboBox;
    IWChk: TmeIWCheckBox;
    idx: Integer;
    LCodTipologia, LDescTipologia: String;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  //Componente per download (colonna comandi) -> OK I/M
  iImgDownload:=grdRichieste.medpIndexColonna(DBG_COMANDI);
  jImgDownload:=4;
  grdRichieste.medpPreparaComponenteGenerico('R',iImgDownload,jImgDownload,DBG_IMG,'','SALVA','Salva il documento','','');

  //Nome file (upload) -> OK I/M
  if Operazione = 'I' then
    grdRichieste.medpPreparaComponenteGenerico('C',ColNomeFile,0,DBG_FPK,'','','','','C')
  else
    grdRichieste.medpPreparaComponenteGenerico('C',ColNomeFile,0,DBG_LBL,'','','','','');
  grdRichieste.medpCreaComponenteGenerico(i,ColNomeFile,grdRichieste.Componenti);

  if Operazione = 'I' then   //se sono in inserimento imposto la dimensione massima del file
    (grdRichieste.medpCompCella(i,ColNomeFile,0) as TmeIWFileUploader).MEdpMaxFileSize:=IterMaxDimAllegatoMB * BYTES_MB
  else
    (grdRichieste.medpCompCella(i,ColNomeFile,0) as TmeIWLabel).Caption:=grdRichieste.medpDataset.FieldByName('D_NOME_FILE').AsString;

  //Richiesta definitiva -> OK I/M
  grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','C');
  grdRichieste.medpCreaComponenteGenerico(i,ColTipoRichiesta,grdRichieste.Componenti);
  IWChk:=(grdRichieste.medpCompCella(i,ColTipoRichiesta,0) as TmeIWCheckBox);
  IWChk.Caption:='Definitiva';
  IWChk.Checked:=grdRichieste.medpDataset.FieldByName('TIPO_RICHIESTA').AsString = 'D';

  //se sono in inserimento o in modifica ma con richiesta non definitiva posso editare anche gli altri campi
  if (Operazione = 'I') or (grdRichieste.medpDataset.FieldByName('TIPO_RICHIESTA').AsString <> 'D') then
  begin
    //Periodo dal  -> OK I/M
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','C');
    grdRichieste.medpCreaComponenteGenerico(i,ColPeriodoDal,grdRichieste.Componenti);
    if Operazione = 'M' then
      (grdRichieste.medpCompCella(i,ColPeriodoDal,0) as TmeIWEdit).Text:=grdRichieste.medpDataset.FieldByName('PERIODO_DAL').AsString;

    //Periodo al  -> OK I/M
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'DATA','','','','C');
    grdRichieste.medpCreaComponenteGenerico(i,ColPeriodoAl,grdRichieste.Componenti);
    if Operazione = 'M' then
      (grdRichieste.medpCompCella(i,ColPeriodoAl,0) as TmeIWEdit).Text:=grdRichieste.medpDataset.FieldByName('PERIODO_AL').AsString;

    //CF Familiare  -> OK I/M
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'','','','','C');
    grdRichieste.medpCreaComponenteGenerico(i,ColCFFamiliare,grdRichieste.Componenti);
    CaricaJQAutocomplete(grdRichieste,i);
    if Operazione = 'M' then
      (grdRichieste.medpCompCella(i,ColCFFamiliare,0) as TmeIWEdit).Text:=grdRichieste.medpDataset.FieldByName('CF_FAMILIARE').AsString;

    //Tipologia -> OK I/M
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'16','','','','S',True);
    grdRichieste.medpCreaComponenteGenerico(i,ColTipologia,grdRichieste.Componenti);

    LCodTipologia:=grdRichieste.medpDataset.FieldByName('TIPOLOGIA').AsString;
    LDescTipologia:=VarToStr(W050DM.A154MW.selT962Lookup.Lookup('CODICE',LCodTipologia,'DESCRIZIONE'));
    IWCmb:=(grdRichieste.medpCompCella(i,ColTipologia,0) as TmeIWComboBox);
    IWCmb.NoSelectionText:=' ';
    IWCmb.RequireSelection:=False;
    IWCmb.Items.Assign(W050DM.A154MW.ListaTipologieNoVersione);
    idx:=-1;
    for k:=0 to IWCmb.Items.Count - 1 do
    begin
      if LCodTipologia = TValore(IWCmb.Items.Objects[k]).Valore then
      begin
        idx:=k;
        Break;
      end;
    end;
    IWCmb.ItemIndex:=idx;

    //Note del documento (T960) -> OK I/M
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColNote,grdRichieste.Componenti);
    if Operazione = 'M' then
      (grdRichieste.medpCompCella(i,ColNote,0) as TmeIWMemo).Text:=grdRichieste.medpDataset.FieldByName('NOTE').AsString;

    //Visualizzabile dal responsabile -> OK I/M
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','','C');
    grdRichieste.medpCreaComponenteGenerico(i,ColVisualizResp,grdRichieste.Componenti);
    if Operazione = 'M' then
     (grdRichieste.medpCompCella(i,ColVisualizResp,0) as TmeIWCheckBox).Checked:=(grdRichieste.medpDataset.FieldByName('ACCESSO_RESPONSABILE').AsString = 'S');
  end;
end;

procedure TW050FRichiestaDocumentale.DistruggiComponentiRiga(FN: String);
var
  i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColNomeFile]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColPeriodoDal]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColPeriodoAl]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColCFFamiliare]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColTipologia]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColVisualizResp]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColTipoRichiesta]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColNote]);
  FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColDbgIter]);
end;

procedure TW050FRichiestaDocumentale.AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
var
  LId: Integer;
  LOldRowId: String;
begin
  LId:=W050DM.selT960.FieldByName('ID').AsInteger;
  LOldRowId:=W050DM.selT960.RowId;

  // aggiorna i dati di lettura del file
  if Parametri.TipoOperatore = 'I060' then
  begin
    // utente di creazione è di I060 e il suo progressivo = T960.PROGRESSIVO
    // accesso al documento da parte di utente I060,
    // progressivo = T960.PROGRESSIVO e DATA_LETTURA_PROGRESSIVO is null
    C021.AggiornaDatiLettura(PId,Parametri.ProgressivoOper);
  end;

  // aggiorna i dati di accesso al file (esegue l'operazione solo per operatore win)
  C021.AggiornaDatiAccesso(PId,Parametri.Operatore);

  // refresh dataset
  W050DM.selT960.Refresh;
  W050DM.selT960.SearchRecord('ID',LId,[srFromBeginning]);
  grdRichieste.medpCaricaCDS(LOldRowId);

  // effettua il download del file
  FNomeFileGenerato:=PFilePath;
  AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]));
end;

function TW050FRichiestaDocumentale.GetAzioniAbilitateRiga(const PRiga: Integer): TAzioniAbilitate;
var
  LTipologia,
  LCampoUser,
  LCampoUserAltro,
  LUser,
  LUserAltro: String;
  LIsVisualizzato,
  LIsCaricatoDaAltroUser,
  LAbilita: Boolean;
  LAutorizzato: Boolean;
begin
  // variabili di supporto per verifica abilitazioni
  LTipologia:=grdRichieste.medpValoreColonna(PRiga,'TIPOLOGIA');
  LIsVisualizzato:=(grdRichieste.medpValoreColonna(PRiga,'DATA_ACCESSO') <> '') or
                   (grdRichieste.medpValoreColonna(PRiga,'UTENTE_ACCESSO') <> '');
  LAutorizzato:=(grdRichieste.medpValoreColonna(PRiga,'AUTORIZZAZIONE') <> '');

  LCampoUser:=IfThen(Parametri.TipoOperatore = 'I070','UTENTE','NOME_UTENTE');
  LCampoUserAltro:=IfThen(LCampoUser = 'NOME_UTENTE','UTENTE','NOME_UTENTE');

  LUser:=grdRichieste.medpValoreColonna(PRiga,LCampoUser);
  LUserAltro:=grdRichieste.medpValoreColonna(PRiga,LCampoUserAltro);

  LIsCaricatoDaAltroUser:=(LUserAltro <> '') or (LUser <> Parametri.Operatore);

  // le abilitazioni  di modifica e cancellazione - al momento - sono le stesse
  // abilitato se:
  // - tipologia è diversa da "ITER"
  // - documento non ancora visualizzato da un altro utente
  // - documento non caricato da altri utenti
  LAbilita:=(LTipologia <> DOC_TIPOL_ITER) and
            (not LIsVisualizzato) and
            (not LIsCaricatoDaAltroUser)and
            (not LAutorizzato);

  // abilitazione modifica e cancellazione
  Result.Modifica:=LAbilita;
  Result.Elimina:=LAbilita;
end;

procedure TW050FRichiestaDocumentale.chkAutorizzazioneClick(Sender: TObject);
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  (Sender as TmeIWCheckBox).Checked:=True;
  AutorizzazioneOK((Sender as TmeIWCheckBox).FriendlyName,IfThen((Sender as TmeIWCheckBox).Caption = 'Si',C018SI,C018NO));
end;

procedure TW050FRichiestaDocumentale.AutorizzazioneOK(RowidT960, Aut: String);
begin
  with W050DM.selT960 do
  begin
    //verifica presenza record
    Refresh;
    if not SearchRecord('ROWID',RowidT960,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('Attenzione! La richiesta da autorizzare non è più disponibile!');
      Exit;
    end;
    //salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID_RICHIESTA').AsInteger;
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);

      SessioneOracle.Commit;
    except
      on E: exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Impostazione dell''autorizzazione fallita!' + CRLF + 'Motivo: ' + E.Message);
      end;
    end;
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW050FRichiestaDocumentale.W050AutorizzaTutti(Sender: TObject; var Ok: Boolean);
{ Effettua l'autorizzazione positiva/negativa di tutte le richieste ancora da autorizzare }
var
  ErrModCan: Boolean;
  Aut:String;
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  //inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen((Sender as TmeIWButton).Name = 'btnTuttiSi',C018SI,C018NO);
  //autorizzazione richieste
  with W050DM.selT960 do
  begin
    First;
    while not Eof do
    begin
      try
        if (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
          try
            try
              C018.CodIter:=FieldByName('COD_ITER').AsString;
              C018.Id:=FieldByName('ID_RICHIESTA').AsInteger;
              C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);

              WR000DM.RegistraMessaggioT280(FieldByName('PROGRESSIVO').AsInteger,
                                                    IfThen(Aut = 'S','0','2'),
                                                    '<W050> ESITO ' + IfThen(Aut = 'S','POSITIVO','NEGATIVO') + ' - Richiesta documentale',
                                                    FormattaDatiRichiesta,
                                                    IfThen(Aut = 'S','Autorizzato da ','Non autorizzato da ') + Parametri.Operatore);
              SessioneOracle.Commit;
            except
              on E:Exception do
              begin
                SessioneOracle.Commit;
                //messaggio bloccante
                MsgBox.MessageBox('Autorizzazione documentale - Errore',
                                  'Impostazione dell''autorizzazione fallita!'
                                  + CRLF + 'Motivo: ' + E.Message + CRLF + CRLF
                                  + Format('Richiesta effettuata da %s (%s) il %s', [FieldByName('NOMINATIVO').AsString,FieldByName('MATRICOLA').AsString,FieldByName('DATA_RICHIESTA').AsString]) + CRLF
                                  + FormattaDatiRichiesta);
                VisualizzaDipendenteCorrente;
                Exit;
              end;
            end;
          except
            //errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
              ErrModCan:=True;
          end;
      finally
        Next;
      end;
    end;
  end;
  Ok:=True;
  if ErrModCan then
    GGetWebApplicationThreadVar.ShowMessage('Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.');
end;

function TW050FRichiestaDocumentale.FormattaDatiRichiesta: String;
begin
  with W050DM.selT960 do
  begin
    //formatta la richiesta
    Result:='Nome file:       ' + FieldByName('D_NOME_FILE').AsString + CRLF
            + 'Tipologia:       ' + FieldByName('D_TIPOLOGIA').AsString + CRLF
            + 'Ufficio:         ' + FieldByName('D_UFFICIO').AsString + CRLF
            + 'Inizio periodo:  ' + FieldByName('PERIODO_DAL').AsString + CRLF
            + 'Fine periodo:    ' + FieldByName('PERIODO_AL').AsString;
  end;
end;

function TW050FRichiestaDocumentale.Occurrences(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset := PosEx(Substring, Text, offset + length(Substring));
  end;
end;

//autocomplete del CF familiari
procedure TW050FRichiestaDocumentale.CaricaJQAutocomplete(Griglia: TmedpIWDBGrid; r: Integer);
var Col: Integer;
    NomeComponente,CFFamiliari,CodeAC: String;
begin
  CodeAC:='';
  CFFamiliari:='';
  NomeComponente:='';
  with W050DM.A154MW.selSG101 do
  begin
    First;
    while not eof do
    begin
      CFFamiliari:=CFFamiliari + IfThen(CFFamiliari <> '',''',''') + C190EscapeJS(FieldByName('CODFISCALE').AsString);
      next;
    end;
  end;
  CFFamiliari:='''' + CFFamiliari + '''';

  // prepara autocomplete
  jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  if CFFamiliari <> '' then
  begin
    Col:=Griglia.medpIndexColonna('CF_FAMILIARE');
    NomeComponente:=(Griglia.medpCompCella(r,Col,0)).HTMLName;

    if NomeComponente <> '' then
    begin
      CodeAC:=CodeAC + CRLF +
              'var elementi = [' + CFFamiliari + ']; ' + CRLF +
              '$("#' + NomeComponente + '").autocomplete({ ' + CRLF +
              '  source: elementi, ' + CRLF +
              '  delay: 0,' + CRLF +
              '  minLength: 0' + CRLF +
              '}).focus(function(){ ' + CRLF +
              '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
              '}); ';
      CodeAC:='try { ' +
            CodeAC +
            '} ' +
            'catch(e) { ' +
            '  try { console.log("jqAutocomplete: " + e.message); } catch(err) {} ' +
            '}';

    end;
    jQAutocomplete.OnReady.Add(CodeAC);
  end;
end;

procedure TW050FRichiestaDocumentale.DistruggiOggetti;
begin
  FreeAndNil(FRichiesta);
  inherited;
end;

{ TRichiestaDocumentale }

constructor TRichiestaDocumentale.Create;
begin
  inherited;
  Documento:=TDocumento.Create;
end;

destructor TRichiestaDocumentale.Destroy;
begin
  FreeAndNil(Documento);
  inherited;
end;

end.
