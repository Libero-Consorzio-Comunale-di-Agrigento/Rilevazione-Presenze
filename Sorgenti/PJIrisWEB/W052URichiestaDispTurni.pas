unit W052URichiestaDispTurni;

interface

uses
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  A000UCostanti, A000USessione, A000UInterfaccia, meIWComboBox, meIWCheckBox,
  W052URichiestaDispTurniDM,
  IWApplication, IWAppForm, SysUtils, Classes, meIWGrid,
  Controls, IWControl, IWCompListbox, meIWEdit,
  meIWButton, OracleData, Variants, IWVCLBaseControl,
  Forms, IWVCLBaseContainer, IWContainer, DB, meIWMemo,
  StrUtils, DBClient, Math, IWDBGrids, medpIWDBGrid,
  meIWLink, IWCompGrids, IWCompExtCtrls, meIWImageFile, meIWLabel, Menus,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl,
  IWHTMLControls, IWCompLabel, IWCompButton, IWCompEdit, meIWRadioGroup,
  IWCompJQueryWidget, WC013UCheckListFM;

type

  TDatiRichiesta = record
    Note:String;
  end;

  TW052FRichiestaDispTurni = class(TR013FIterBase)
    dsrT600: TDataSource;
    cdsT600: TClientDataSet;
    JQuery: TIWJQueryWidget;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure rgpVisualizzazioneClick(Sender: TObject);
    function FormattaDatiT280: String;
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    Operazione: String;
    vData:TDateTime;
    ColData,ColDaOre,ColAOre,ColSquadre,ColDbgIter:Integer;
    iRiga: Integer;
    StileCella1,StileCella2: String;
    DatiRichiesta:TDatiRichiesta;
    W052DM:TW052FRichiestaDispTurniDM;
    WC013FM: TWC013FCheckListFM;
    LstSquadreSel: TStringList;
    procedure actCancRichiesta(FN: String);
    procedure actInsRichiesta(FN: String);
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure AutorizzazioneOK(RowidT085,Aut: String);
    procedure CreaComponentiRiga(FN: String);
    procedure DistruggiComponentiRiga(FN: String);
    procedure imgModificaClick(Sender:TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgSquadreClick(Sender:TObject);
    procedure OnSelezioneSquadre(Sender: TObject; Result:Boolean);
    procedure TrasformaComponenti(FN:String);
    function ControlliOK(FN: String): Boolean;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure imgIterClick(Sender: TObject);
    procedure W052AutorizzaTutti(Sender: TObject; var Ok: Boolean);
  protected
    procedure GetDipendentiDisponibili(Data: TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses W001UIrisWebDtM, SyncObjs;

{$R *.DFM}

function TW052FRichiestaDispTurni.InizializzaAccesso:Boolean;
begin
  // inizializzazioni
  Result:=True;
  vData:=ParametriForm.Al;
  CampiV430:=CampiV430 + IfThen(CampiV430 <> '',',') + 'V430.T430SQUADRA';
  GetDipendentiDisponibili(vData);
  selAnagrafeW.SearchRecord('PROGRESSIVO', ParametriForm.Progressivo, [srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    //seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;

    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W052AutorizzaTutti;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TW052FRichiestaDispTurni.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,463,462);
  inherited;
  W052DM:=TW052FRichiestaDispTurniDM.Create(Self);
  Iter:=ITER_DISPTURNI;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W052DM.selT600,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W052DM.selT600,tiRichiesta);
  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'W052P1','W052P0');
  vData:=Parametri.DataLavoro;

  // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  grdRichieste.medpDataSet:=W052DM.selT600;
  LstSquadreSel:=TStringList.Create;
end;

procedure TW052FRichiestaDispTurni.IWAppFormRender(Sender: TObject);
begin
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  //autorizza / nega tutto
  btnTuttiSi.Confirmation:='Autorizzare tutte le disponibilità?';
  btnTuttiNo.Confirmation:='Negare l''autorizzazione a tutte le disponibilità?';
  if btnTuttiSi.Visible then
    btnTuttiSi.Visible:=(W052DM.selT600.RecordCount > 1);
  btnTuttiNo.Visible:=btnTuttiSi.Visible;
end;

procedure TW052FRichiestaDispTurni.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W052DM.selT600 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('La disponibilità da visualizzare non è più disponibile!');
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

procedure TW052FRichiestaDispTurni.GetDipendentiDisponibili(Data: TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW052FRichiestaDispTurni.VisualizzaDipendenteCorrente;
var
  FiltroAnag: String;
begin
  inherited;
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  //apertura dataset delle richieste cambi orari
  with W052DM.selT600 do
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
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    // MONDOEDP - commessa MAN/07.ini
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    // MONDOEDP - commessa MAN/07.fine
    R013Open(W052DM.selT600);
  end;
  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Data ins.','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Giorno','',nil);
    grdRichieste.medpAggiungiColonna('DAORE','Dalle','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Alle','',nil);
    grdRichieste.medpAggiungiColonna('CF_SQUADRE','Squadre','',nil);
    grdRichieste.medpAggiungiColonna('MESSAGGI','Messaggi','',nil);
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Data ins.','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Giorno','',nil);
    grdRichieste.medpAggiungiColonna('DAORE','Dalle','',nil);
    grdRichieste.medpAggiungiColonna('AORE','Alle','',nil);
    grdRichieste.medpAggiungiColonna('CF_SQUADRE','Squadre','',nil);
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
  end;
  ColData:=grdRichieste.medpIndexColonna('DATA');
  ColDaOre:=grdRichieste.medpIndexColonna('DAORE');
  ColAOre:=grdRichieste.medpIndexColonna('AORE');
  ColSquadre:=grdRichieste.medpIndexColonna('CF_SQUADRE');
  ColDbgIter:=grdRichieste.medpIndexColonna(DBG_ITER);
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  if not SolaLettura then
  begin
    if not WR000DM.Responsabile then
    begin
      //Riga inserimento
      grdRichieste.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');
      //Riga
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
    end
    else
    begin
      //Riga
      grdRichieste.medpPreparaComponenteGenerico('R',1,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',1,1,DBG_CHK,'','No','','');
    end;
  end;
  grdRichieste.medpCaricaCDS;
end;

procedure TW052FRichiestaDispTurni.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 463;
  VisualizzaDipendenteCorrente;
end;

procedure TW052FRichiestaDispTurni.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  IWImg: TmeIWImageFile;
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
      Cell[0,1].Css:='invisibile';
      Cell[0,2].Css:='invisibile';
    end;
  end;
  //Righe dati
  for i:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    IWImg:=TmeIWImageFile(grdRichieste.medpCompCella(i,DBG_ITER,0));
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      //***IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      //***if C018.SetIconaAllegati(IWImg) then
      //***  IWImg.OnClick:=imgAllegClick;
    end;
    if not SolaLettura then
    begin
      //Tolgo i componenti se non ci sono le condizioni per l'autorizzazione
      if WR000DM.Responsabile and (   (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') <> '')
                                   or (StrToDate(grdRichieste.medpValoreColonna(i,'DATA')) < Trunc(R180Sysdate(SessioneOracle)))) then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
      end;
      //Tolgo i componenti se non ci sono le condizioni per la cancellazione
      if (not WR000DM.Responsabile) and (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') <> '') then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      end;
      //Associo l'evento OnClick alle icone dei comandi
      if (not WR000DM.Responsabile) and (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        if StileCella1 = '' then
        begin
          with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
          begin
            StileCella1:=Cell[0,0].Css;
            StileCella2:=Cell[0,1].Css;
          end;
        end;
        (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
        (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
      end;
      //Associo l'evento OnClick alle icone dei comandi e al checkbox di autorizzazione SI/NO
      if WR000DM.Responsabile and (grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil) then
      begin
        C018.SetValoriAut(grdRichieste,i,1,0,1,chkAutorizzazioneClick);
      end;
    end;
  end;
end;

procedure TW052FRichiestaDispTurni.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;

  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);

  if ARow = 0 then
  begin
    if grdRichieste.medpColonna(NumColonna).DataField = 'DATA' then
      ACell.Hint:='Giorno in cui ci si rende disponibili';
    if grdRichieste.medpColonna(NumColonna).DataField = 'DAORE' then
      ACell.Hint:='Orario minimo di inizio disponibilità';
    if grdRichieste.medpColonna(NumColonna).DataField = 'AORE' then
      ACell.Hint:='Orario massimo di fine disponibilità';
    if grdRichieste.medpColonna(NumColonna).DataField = 'SQUADRE' then
      ACell.Hint:='Squadre per cui ci si rende disponibili';
  end;

  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (grdRichieste.medpColonna(NumColonna).DataField = 'D_AUTORIZZAZIONE') then
    ACell.Css:=ACell.Css + ' align_center font_grassetto';

  ACell.Wrap:=True;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1)
  and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW052FRichiestaDispTurni.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  cdsT600.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW052FRichiestaDispTurni.CreaComponentiRiga(FN: String);
var
  i: Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if Operazione = 'I' then
  begin
    //giorno
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'input_data_dmy','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColData,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColData,0) as TmeIWEdit) do
    begin
      Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro + 1);
    end;
    //dalle
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'input5','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColDaOre,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColDaOre,0) as TmeIWEdit) do
    begin
      Text:='00.00';
    end;
    //alle
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'input5','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColAOre,grdRichieste.Componenti);
    with (grdRichieste.medpCompCella(i,ColAOre,0) as TmeIWEdit) do
    begin
      Text:='23.59';
    end;
    //squadre
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'width50chr','','','','S');
    grdRichieste.medpPreparaComponenteGenerico('C',0,1,DBG_BTN,'','...','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColSquadre,grdRichieste.Componenti);
    (grdRichieste.medpCompCella(i,ColSquadre,0) as TmeIWLabel).Caption:=W052DM.selT600.FieldByName('CF_SQUADRE').AsString;
    (grdRichieste.medpCompCella(i,ColSquadre,1) as TmeIWButton).OnClick:=imgSquadreClick;
    //note di inserimento
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,ColDbgIter,grdRichieste.Componenti);
  end;
end;

procedure TW052FRichiestaDispTurni.DistruggiComponentiRiga(FN: String);
var
  i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if Operazione = 'I' then
  begin
    //giorno
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColData]);
    //dalle
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColDaOre]);
    //alle
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColAOre]);
    //squadre
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColSquadre]);
    //note in inserimento
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[ColDbgIter]);
  end;
end;

procedure TW052FRichiestaDispTurni.imgModificaClick(Sender:TObject);
var
  FN: String;
begin
  // modifica - applicazione modifiche
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  LstSquadreSel.Clear;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  Operazione:='M';
  TrasformaComponenti(FN);
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msEdit;
end;

procedure TW052FRichiestaDispTurni.imgInserisciClick(Sender: TObject);
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

  W052DM.selT600.Append; //faccio qui l'append per innescare OnNewRecord
  LstSquadreSel.CommaText:=W052DM.selT600.FieldByName('SQUADRE').AsString;

  Operazione:='I';
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msInsert;
  with (grdRichieste.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
  begin
    //Nascondo il pulsante inserisci e visualizzo annulla/conferma
    Cell[0,0].Css:='invisibile';
    Cell[0,1].Css:=StileCella1;
    Cell[0,2].Css:=StileCella2;
  end;
  CreaComponentiRiga(FN);
end;

procedure TW052FRichiestaDispTurni.imgAnnullaClick(Sender: TObject);
// Annulla: annulla le modifiche apportate nei componenti editabili
begin
  DBGridColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  Operazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  grdRichieste.medpCaricaCDS;
end;

procedure TW052FRichiestaDispTurni.imgConfermaClick(Sender: TObject);
// Applica:  conferma i dati presenti nei componenti
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);

  if (Operazione = 'M') then
  begin
    // se il record non esiste -> errore
    if not W052DM.selT600.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      Operazione:='';
      TrasformaComponenti(FN);
      grdRichieste.medpBrowse:=True;
      grdRichieste.medpStato:=msBrowse;
      GGetWebApplicationThreadVar.ShowMessage('Errore durante la modifica del cambio orario:' + CRLF + 'il record non è più disponibile!');
      Exit;
    end;
  end;

  //effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;
  //inserimento / aggiornamento
  if Operazione = 'I' then
    actInsRichiesta(FN);
end;

procedure TW052FRichiestaDispTurni.imgCancellaClick(Sender: TObject);
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

procedure TW052FRichiestaDispTurni.imgSquadreClick(Sender: TObject);
begin
  iRiga:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWButton).FriendlyName);
  WC013FM:=TWC013FCheckListFM.Create(Self);
  FreeNotification(WC013FM);

  if LstSquadreSel.Count = 0 then
    LstSquadreSel.CommaText:=W052DM.selT600.FieldByName('SQUADRE').AsString;

  // prepara e visualizza il frame di selezione destinatari
  WC013FM.CaricaLista(W052DM.FLstDescSquadre,W052DM.FLstValSquadre);
  WC013FM.ImpostaValoriSelezionati(LstSquadreSel);
  WC013FM.ResultEvent:=OnSelezioneSquadre;
  //WC013FM.MinElem:=1;
  WC013FM.Visualizza(0,0,'Selezionare le squadre');
end;

procedure TW052FRichiestaDispTurni.OnSelezioneSquadre(Sender: TObject; Result:Boolean);
// procedura eseguita dopo aver confermato una selezione di squadre
begin
  if Result then
  begin
    LstSquadreSel.CommaText:=WC013FM.LeggiValoriSelezionati.CommaText;
    (grdRichieste.medpCompCella(iRiga,ColSquadre,0) as TmeIWLabel).Caption:=W052DM.GetCFSquadre(LstSquadreSel.CommaText);
  end;
end;

procedure TW052FRichiestaDispTurni.TrasformaComponenti(FN:String);
{ Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdRichieste }
var
  DaTestoAControlli:Boolean;
  i:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  DaTestoAControlli:=Operazione <> '';

  if not WR000DM.Responsabile then
  begin
    if grdRichieste.medpRigaInserimento and (i = 0) then
    begin
      with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
        Cell[0,1].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
        Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
      end;
    end
    else
    begin
      with (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella1);
        Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
        Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
        Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');
      end;
    end;
  end;

  if DaTestoAControlli then
    CreaComponentiRiga(FN)
  else
    DistruggiComponentiRiga(FN);
end;

function TW052FRichiestaDispTurni.ControlliOK(FN: String): Boolean;
var
  i: Integer;
  dGiorno: TDateTime;
  sDaOre,sAOre: String;
begin
  Result:=False;
  if Operazione = 'I' then
  begin
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    //giorno
    if Length((grdRichieste.medpCompCella(i,ColData,0) as TmeIWedit).Text) <> 10 then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare il giorno nel formato GG/MM/AAAA!');
      Exit;
    end;
    try
      dGiorno:=StrToDate((grdRichieste.medpCompCella(i,ColData,0) as TmeIWEdit).Text);
    except
      GGetWebApplicationThreadVar.ShowMessage('Indicare il giorno nel formato GG/MM/AAAA!');
      Exit;
    end;
    if dGiorno < Trunc(R180Sysdate(SessioneOracle)) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Non è possibile inserire la disponibilità per un giorno ormai trascorso!');
      Exit;
    end;
    //da ore / a ore
    sDaOre:=(grdRichieste.medpCompCella(i,ColDaOre,0) as TmeIWEdit).Text;
    sAOre:=(grdRichieste.medpCompCella(i,ColAOre,0) as TmeIWEdit).Text;
    if not OreMinutiValidate(sDaOre) or not OreMinutiValidate(sAOre) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare gli orari nel formato HH.MM!');
      Exit;
    end;
    //squadre
    if (grdRichieste.medpCompCella(i,ColSquadre,0) as TmeIWLabel).Caption = '' then
    begin
      GGetWebApplicationThreadVar.ShowMessage('Indicare almeno una squadra!');
      Exit;
    end;
    //richiesta da autorizzare nello stesso giorno
    with W052DM.selaT600 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',dGiorno);
      Execute;
      if Field(0) > 0 then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Esiste già una disponibilità non negata relativa al giorno indicato!');
        Exit;
      end;
    end;
    //causale di assenza non compatibile
    with W052DM.selT040 do
    begin
      SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DATA',dGiorno);
      Execute;
      if Field(0) > 0 then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Nel giorno indicato è presente una causale di assenza incompatibile con la disponibilità dei turni!');
        Exit;
      end;
    end;
  end;
  Result:=True;
end;

procedure TW052FRichiestaDispTurni.actInsRichiesta(FN: String);
var
  i: Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  with W052DM.selT600 do
  begin
    FieldByName('DATA').AsDateTime:=StrToDate((grdRichieste.medpCompCella(i,ColData,0) as TmeIWEdit).Text);
    FieldByName('DAORE').AsString:=(grdRichieste.medpCompCella(i,ColDaOre,0) as TmeIWEdit).Text;
    FieldByName('AORE').AsString:=(grdRichieste.medpCompCella(i,ColAOre,0) as TmeIWEdit).Text;
    FieldByName('SQUADRE').AsString:=LstSquadreSel.CommaText;
    DatiRichiesta.Note:=Trim((grdRichieste.medpCompCella(i,ColDbgIter,0) as TmeIWMemo).Text);
  end;

  // imposta le note per valutazione condizioni validità
  C018.Note:=DatiRichiesta.Note;

  if not C018.WarningRichiesta then
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;

procedure TW052FRichiestaDispTurni.ConfermaInsRichiesta;
var IdIns:String;
    Liv:Integer;
begin
  with W052DM.selT600 do
  begin
    try
      Liv:=C018.InsRichiesta('',DatiRichiesta.Note,'');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      IdIns:=RowId;
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Inserimento della disponibilità fallito!' + CRLF + 'Motivo: ' + E.Message);
      end;
    end;
  end;

  C018.Periodo.Estendi(W052DM.selT600.FieldByName('DATA').AsDateTime,W052DM.selT600.FieldByName('DATA').AsDateTime);
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

procedure TW052FRichiestaDispTurni.AnnullaInsRichiesta;
begin
  W052DM.selT600.Cancel;
  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW052FRichiestaDispTurni.actCancRichiesta(FN: String);
begin
  //cancellazione record
  with W052DM.selT600 do
  begin
    if SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      try
        C018.CodIter:=FieldByName('COD_ITER').AsString;
        C018.Id:=FieldByName('ID').AsInteger;
        C018.EliminaIter;
        SessioneOracle.Commit;
      except
        on E:Exception do
        begin
          SessioneOracle.Commit;
          GGetWebApplicationThreadVar.ShowMessage('Cancellazione della disponibilità fallita!' + CRLF + 'Motivo: ' + E.Message);
        end;
      end;
    end;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW052FRichiestaDispTurni.W052AutorizzaTutti(Sender: TObject; var Ok: Boolean);
{ Effettua l'autorizzazione positiva di tutte le richieste ancora da autorizzare }
var
  ErrModCan: Boolean;
  Aut:String;
  Liv:Integer;
  function FormattaDatiRichiesta: String;
  begin
    with W052DM.selT600 do
    begin
      //formatta la richiesta
      Result:=Format('Inserimento effettuato da %s (%s) il %s',
              [FieldByName('NOMINATIVO').AsString,FieldByName('MATRICOLA').AsString,FieldByName('DATA_RICHIESTA').AsString])
              + CRLF + 'Giorno:  ' + FieldByName('DATA').AsString
              + CRLF + 'Dalle:   ' + FieldByName('DAORE').AsString
              + CRLF + 'Alle:    ' + FieldByName('AORE').AsString
              + CRLF + 'Squadre: ' + FieldByName('SQUADRE').AsString;
    end;
  end;

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
  with W052DM.selT600 do
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
              C018.Id:=FieldByName('ID').AsInteger;
              Liv:=C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);
              WR000DM.RegistraMessaggioT280(FieldByName('PROGRESSIVO').AsInteger,
                                                    IfThen(Aut = 'S','0','2'),
                                                    '<W052> ESITO ' + IfThen(Aut = 'S','POSITIVO','NEGATIVO') + ' - Inserimento disponibilità turni',
                                                    FormattaDatiT280,
                                                    IfThen(Aut = 'S','Autorizzato da ','Non autorizzato da ') + FieldByName('D_RESPONSABILE').AsString);
              SessioneOracle.Commit;
            except
              on E:Exception do
              begin
                SessioneOracle.Commit;
                //messaggio bloccante
                MsgBox.MessageBox('Autorizzazione disponibilità turni - Errore','Impostazione dell''autorizzazione fallita!'
                                  + CRLF + 'Motivo: ' + E.Message + CRLF + CRLF + FormattaDatiRichiesta);
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

procedure TW052FRichiestaDispTurni.chkAutorizzazioneClick(Sender: TObject);
begin
  if Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione' + CRLF + 'di ' + IfThen(Operazione = 'I','inserimento','variazione') + ' in corso prima di procedere!');
    Exit;
  end;
  (Sender as TmeIWCheckBox).Checked:=True;
  AutorizzazioneOK((Sender as TmeIWCheckBox).FriendlyName,IfThen((Sender as TmeIWCheckBox).Caption = 'Si',C018SI,C018NO));
end;

procedure TW052FRichiestaDispTurni.AutorizzazioneOK(RowidT085,Aut: String);
var Liv:Integer;
begin
  with W052DM.selT600 do
  begin
    //verifica presenza record
    Refresh;
    if not SearchRecord('ROWID',RowidT085,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      GGetWebApplicationThreadVar.ShowMessage('Attenzione! La disponibilità da autorizzare non è più disponibile!');
      Exit;
    end;
    //salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      Liv:=C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
      WR000DM.RegistraMessaggioT280(FieldByName('PROGRESSIVO').AsInteger,
                                            IfThen(Aut = 'S','0','2'),
                                            '<W052> ESITO ' + IfThen(Aut = 'S','POSITIVO','NEGATIVO') + ' - Inserimento disponibilità turni',
                                            FormattaDatiT280,
                                            IfThen(Aut = 'S','Autorizzato da ','Non autorizzato da ') + FieldByName('D_RESPONSABILE').AsString);
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

procedure TW052FRichiestaDispTurni.rgpVisualizzazioneClick(Sender: TObject);
begin
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

function TW052FRichiestaDispTurni.FormattaDatiT280: String;
begin
  with W052DM.selT600 do
  begin
    //formatta la richiesta
    Result:='Giorno:  ' + FieldByName('DATA').AsString + CRLF +
            'Dalle:   ' + FieldByName('DAORE').AsString + CRLF +
            'Alle:    ' + FieldByName('AORE').AsString + CRLF +
            'Squadre: ' + FieldByName('SQUADRE').AsString;
  end;
end;

procedure TW052FRichiestaDispTurni.DistruggiOggetti;
begin
  FreeAndNil(LstSquadreSel);
  FreeAndNil(W052DM);
  inherited;
end;

end.
