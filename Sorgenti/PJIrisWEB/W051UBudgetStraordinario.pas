unit W051UBudgetStraordinario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWDBGrids, medpIWDBGrid,
  Math, OracleData, System.StrUtils, DateUtils, C018UIterAutDM, System.Generics.Collections, IWApplication,
  meIWImageFile, medpIWMessageDlg, medpIWTabControl, A000UCostanti, A000UMessaggi, A000UInterfaccia, C004UParamForm, C180FunzioniGenerali, C190FunzioniGeneraliWeb, W000UMessaggi,
  IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, meIWDBComboBox, meIWComboBox, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompTabControl, meIWTabControl, meIWRegion, WC015USelEditGridFM, meIWCheckBox,
  W051UBudgetStraordinarioDM, WA065UStampaBudgetFM, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, R013UIterBase, Vcl.Menus;

type
  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
    Operazione:String;
  end;

  TRecord = record
    FN:string;
    CodGruppo: String;
    Tipo: string;
    Decorrenza:TDateTime;
    Ore:String;
    Importo:Double;
  end;

  (*
  TDatoPersonalizzato = class
    Codice: String;         // codice del gruppo T713.CODGRUPPO
    Tipo: String;           // T713.TIPO #B.O#=Banca Ore, #LIQ#=Liquidabile, altro=causale di presenza
    Decorrenza: TDateTime;
    Ore: String;
    Importo: Double;
  end;
  *)
  (*
  TRecordRichiesta = record
    Operazione:String;
    Data,Dal,Al: TDateTime;
    Descrizione:String;
    IDCertificazione: Integer;
    Definitiva: Boolean;
    //DatiPers: TDictionary<String,TDatoPersonalizzato>;
  end;
  *)

  TW051FBudgetStraordinario = class(TR013FIterBase)
    W051GestioneRG: TmeIWRegion;
    lblAnno: TmeIWLabel;
    cmbAnno: TmeIWComboBox;
    grdBudget: TmedpIWDBGrid;
    grdDettaglio: TmedpIWDBGrid;
    tpGestione: TIWTemplateProcessorHTML;
    tabBudget: TmedpIWTabControl;
    dsrT700: TDataSource;
    cdsT700: TClientDataSet;
    W051RichiesteRG: TmeIWRegion;
    tpRichieste: TIWTemplateProcessorHTML;
    pmnBudget: TPopupMenu;
    pmnDettaglio: TPopupMenu;
    mnuEsportaBudgetExcel: TMenuItem;
    mnuEsportaDettaglioExcel: TMenuItem;
    mnuEsportaBudgetCsv: TMenuItem;
    mnuEsportaDettaglioCSV: TMenuItem;
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure cmbAnnoChange(Sender: TObject);
    procedure grdBudgetAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure mnuEsportaBudgetExcelClick(Sender: TObject);
    procedure mnuEsportaDettaglioExcelClick(Sender: TObject);
    procedure mnuEsportaBudgetCsvClick(Sender: TObject);
    procedure mnuEsportaDettaglioCSVClick(Sender: TObject);
  private
    { Private declarations }
    DatiRiga: TRecord;
    FAutorizza: TAutorizza;
    C004DM_1: TC004FParamForm;
    WC015: TWC015FSelEditGridFM;
    W051DM: TW051FBudgetStraordinarioDM;
    WA065Stm: TWA065FStampaBudgetFM;
    function grdBudgetOnBeforeModifica(Sender: TObject): Boolean;
    procedure AutorizzazioneOK;
    procedure AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    procedure BloccaGrid(Sender: TObject; pBlocca: Boolean);
    procedure CallDCOMPrinter;
    procedure ConfermaInsRichiesta;
    procedure ConfermaUndoRichiesta;
    procedure EliminaDatoAutorizzatore;
    procedure grdBudgetOnModifica(Sender: TObject);
    procedure grdBudgetRowClick;
    procedure grdRichiesteRefresh;
    procedure imgAnagraficaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgConfermaClick(Sender:TObject);
    procedure imgIterClick(Sender: TObject);
    procedure PreparaComponentiBudget;
    procedure PreparaComponentiDettaglio;
    procedure PreparaGrid(pGrid: TmedpIWDBGrid; pDataset: TOracleDataSet);
    procedure SetAutorizzazione(Sender: TObject);
    procedure TrasformaComponentiBudget(FN: String);
  protected
    procedure VisualizzaDipendenteCorrente; override;
  public
    { Public declarations }
    procedure EseguiStampa;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TW051FBudgetStraordinario.grdBudgetOnBeforeModifica(Sender: TObject): Boolean;
begin
  DatiRiga.FN:=TmeIWImageFile(Sender).FriendlyName;
  BloccaGrid(grdDettaglio, True);
  Result:=True;
end;

procedure TW051FBudgetStraordinario.grdBudgetOnModifica(Sender: TObject);
var
  r:  integer;
begin
  r:=grdBudget.medpRigaDiCompGriglia(DatiRiga.FN);
  TmeIWLabel(grdBudget.medpCompCella(r,grdBudget.medpIndexColonna('RIEPILOGO_ORARIO'),1)).Caption:='';
end;

procedure TW051FBudgetStraordinario.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: integer;
  IWImg: TmeIWImageFile;
  VisAutorizza:Boolean;
begin
  if not WR000DM.Responsabile then
  begin
    if (not SolaLettura) then
    begin
      for r:=IfThen(grdRichieste.medpRigaInserimento,1,0) to High(grdRichieste.medpCompGriglia) do
      begin
        // iter autorizzativo
        C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(r,'ID')),-1);
        C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(r,'COD_ITER'));

        // dettaglio iter
        IWImg:=(grdRichieste.medpCompCella(r,DBG_ITER,0) as TmeIWImageFile);
        IWImg.OnClick:=imgIterClick;
        IWImg.Hint:=C018.LeggiNoteComplete;
        IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

        if (grdRichieste.medpCompGriglia[r].CompColonne[0] <> nil) then
        begin
          // cancella
          IWImg:=(grdRichieste.medpCompCella(r,0,0) as TmeIWImageFile);
          IWImg.OnClick:=imgCancellaClick;
          IWImg.Confirmation:=Format(IWImg.Confirmation, [grdRichieste.medpValoreColonna(r,'D_CODGRUPPO') + ' - ' + grdRichieste.medpValoreColonna(r,'TIPO')]);

          //Tolgo i componenti se non ci sono le condizioni per la cancellazione
          if (not WR000DM.Responsabile) and  (grdRichieste.medpValoreColonna(r,'REVOCABILE') <> 'CANC') then //(grdRichieste.medpValoreColonna(r,'AUTORIZZAZIONE') <> '') then
            FreeAndNil(grdRichieste.medpCompGriglia[r].CompColonne[0]);
        end;
      end;
    end;
  end
  else  //Responsabile
  begin
    if (not SolaLettura) then
    begin
      for r:=0 to High(grdRichieste.medpCompGriglia) do
      begin
        // iter autorizzativo
        C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(r,'ID')),-1);
        C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(r,'COD_ITER'));

        // dettaglio iter
        IWImg:=(grdRichieste.medpCompCella(r,DBG_ITER,0) as TmeIWImageFile);
        IWImg.OnClick:=imgIterClick;
        IWImg.Hint:=C018.LeggiNoteComplete;
        IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);

        //Nascondo i check se l'iter è in sola lettura
        VisAutorizza:=(grdRichieste.medpValoreColonna(r,'AUTORIZZ_AUTOMATICA') <> 'S') and
                      (StrToIntDef(grdRichieste.medpValoreColonna(r,'LIVELLO_AUTORIZZAZIONE'),0) > 0);
        if not VisAutorizza then
          FreeAndNil(grdRichieste.medpCompGriglia[r].CompColonne[0]);
        if grdRichieste.medpCompGriglia[r].CompColonne[0] <> nil then
          C018.SetValoriAut(grdRichieste,r,0,0,1,chkAutorizzazioneClick);
      end;
    end;
  end;
end;

procedure TW051FBudgetStraordinario.CallDCOMPrinter;
begin
  try
    A000SessioneWEB.AnnullaTimeOut;
    WA065Stm.ElaborazioneServer;
    A000SessioneWEB.RipristinaTimeOut;
    if FileExists(DCOMNomeFile) then
      VisualizzaFile(DCOMNomeFile,DCOMNomeFile,nil,nil)
    else
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W004_ERR_TAB_NON_COMPATIBILE));
  except
    on E:Exception do
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W004_FMT_STAMPA_NON_DISPONIB),[E.message]));
  end;
end;

procedure TW051FBudgetStraordinario.chkAutorizzazioneClick(Sender: TObject);
begin
  SetAutorizzazione(Sender);
end;

procedure TW051FBudgetStraordinario.cmbAnnoChange(Sender: TObject);
begin
  inherited;
  if R180SetVariable(W051DM.selT713, 'ANNO', ' and T713.anno = ' + cmbAnno.Text) then
  begin
    W051DM.selT713.Open;
    grdBudget.medpCaricaCDS;
    if W051DM.selT713.RecordCount = 0 then
    begin
      W051DM.selT713AfterScroll(W051DM.selT713);
      grdDettaglio.medpCaricaCDS;
    end;
  end;
end;

procedure TW051FBudgetStraordinario.EseguiStampa;
begin
  CallDCOMPrinter;
end;

procedure TW051FBudgetStraordinario.grdBudgetAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: integer;
  cFiltro: integer;
begin
  inherited;
  W051DM.A064MW.AperturaDipendenti;

  with TmedpIWDBGrid(Sender) do
    begin
      cFiltro:=medpIndexColonna('RIEPILOGO_ORARIO');
      for i:=IfThen(RigaInserimento,1,0) to High(medpCompGriglia) do
      begin
        if not WR000DM.Responsabile then
        begin
          //Assegna procedura customizzata per conferma modifica
          (medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;

        //Visualizza immagine per cancellazione richiesta solo se non in attesa di autorizzazione
        if medpValoreColonna(i,'BLOCCATO') = 'S' then
          TmeIWGrid(medpCompGriglia[i].CompColonne[0]).Cell[0,0].Css:='invisibile'
        else
          TmeIWGrid(medpCompGriglia[i].CompColonne[0]).Cell[0,0].Css:='align_center'
        end;

        //Imposta la colonna anagrafica
        if (medpCompCella(i,cFiltro,0) is TmeIWImageFile) then
        begin
          W051DM.A064MW.selbV430.Close;
          W051DM.A064MW.selbV430.SetVariable('C700DATADAL', StrToDateTime(medpValoreColonna(i,'DECORRENZA')));
          W051DM.A064MW.selbV430.SetVariable('DATALAVORO', StrToDateTime(medpValoreColonna(i,'DECORRENZA_FINE')));
          W051DM.A064MW.selbV430.SetVariable('FILTRO', medpValoreColonna(i,'FILTRO_ANAGRAFE'));
          //W051DM.A064MW.selbV430.Open;
          (medpCompCella(i,cFiltro,1) as TmeIWLabel).RawText:=True;
          (medpCompCella(i,cFiltro,1) as TmeIWLabel).Caption:='<TABLE><TR><TD style="width:20%">Ore residue: </TD><TD style="width:15%">' + medpValoreColonna(i,'TOT_ORE_R') + '</TD><TD style="width:20%">' +  'Ore fruite: </TD><TD style="width:15%">' + medpValoreColonna(i,'TOT_ORE_F') + '</TD><TD style="width:20%">Dipendenti: </TD><TD style="width:10%">' + IntToStr(W051DM.A064MW.selbV430.CountQueryHits) + '</TD></TR></TABLE>';
          (medpCompCella(i,cFiltro,0) as TmeIWImageFile).OnClick:=imgAnagraficaClick;
        end;
      end;
    end;
end;

procedure TW051FBudgetStraordinario.grdBudgetRowClick;
begin
  grdDettaglio.medpCaricaCDS;
end;

procedure TW051FBudgetStraordinario.imgAnagraficaClick(Sender: TObject);
var i:Integer;
begin
  grdBudget.medpColumnClick(nil, (Sender as TmeIWImageFile).FriendlyName);
  i:=grdBudget.medpClientDataSet.RecNo - 1;

  W051DM.A064MW.selbV430.Close;
  W051DM.A064MW.selbV430.SetVariable('C700DATADAL', StrToDateTime(grdBudget.medpValoreColonna(i,'DECORRENZA')));
  W051DM.A064MW.selbV430.SetVariable('DATALAVORO', StrToDateTime(grdBudget.medpValoreColonna(i,'DECORRENZA_FINE')));
  W051DM.A064MW.selbV430.SetVariable('FILTRO', grdBudget.medpValoreColonna(i,'FILTRO_ANAGRAFE'));
  W051DM.A064MW.selbV430.Open;

  WC015:=TWC015FSelEditGridFM.Create(Self);
  WC015.Visualizza('Elenco dipendenti selezionati',W051DM.A064MW.selbV430, False, False);
end;

procedure TW051FBudgetStraordinario.imgCancellaClick(Sender: TObject);
var
  FN:string;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W051DM.selT700 do
  begin
    if (not SearchRecord('ROWID',FN,[srFromBeginning])) or
       (not CheckRecord(FN)) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Attenzione! La richiesta da cancellare non è più disponibile!',INFORMA);
      Exit;
    end;

    try
      //elimina la richiesta
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.EliminaIter;
      SessioneOracle.Commit;
      Refresh;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Cancellazione della richiesta fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
      end;
    end;
  end;
  grdRichieste.medpCaricaCDS;

  W051DM.selT713.Refresh;
  grdBudget.medpCaricaCDS;
end;

procedure TW051FBudgetStraordinario.imgConfermaClick(Sender: TObject);
  function ModificheOre(FN:String):Boolean;
  // Restituisce True/False a seconda che il record sia stato modificato o meno
  var
    i,cOre: Integer;
  begin
    i:=grdBudget.medpRigaDiCompGriglia(FN);
    cOre:=grdBudget.medpIndexColonna('ORE');
    DatiRiga.Ore:=(grdBudget.medpCompCella(i,cOre,0) as TmeIWEdit).Text;
    Result:=
      (VarToStr(grdBudget.DataSource.DataSet.Lookup('DBG_ROWID',FN,'ORE')) <> DatiRiga.Ore);
  end;
  function ModificheImporto(FN:String):Boolean;
  // Restituisce True/False a seconda che il record sia stato modificato o meno
  var
    i,cImporto:Integer;
  begin
    i:=grdBudget.medpRigaDiCompGriglia(FN);
    cImporto:=grdBudget.medpIndexColonna('IMPORTO');
    DatiRiga.Importo:=StrToFloat((grdBudget.medpCompCella(i,cImporto,0) as TmeIWEdit).Text);
    Result:=
      (VarToStr(grdBudget.DataSource.DataSet.Lookup('DBG_ROWID',FN,'IMPORTO')) <> (grdBudget.medpCompCella(i,cImporto,0) as TmeIWEdit).Text);
  end;
var
  FN:string;
  blnModificheOre, blnModificheImporto : Boolean;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  grdBudget.DataSource.DataSet.Locate('DBG_ROWID',FN,[]);
  blnModificheOre:=ModificheOre(FN);
  blnModificheImporto:=ModificheImporto(FN);
  // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
  if blnModificheOre or blnModificheImporto then
  begin
    if not W051DM.selT713.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      TrasformaComponentiBudget(FN);
      MsgBox.WebMessageDlg('Errore durante la modifica:' + CRLF + 'il record non è più disponibile!', mtConfirmation, [mbOK],nil, 'Errore');
    end;

    W051DM.selT700.Append;
    W051DM.selT700.FieldByName('CODGRUPPO').AsString:=W051DM.selT713.FieldByName('CODGRUPPO').AsString;
    W051DM.selT700.FieldByName('TIPO').AsString:=W051DM.selT713.FieldByName('TIPO').AsString;
    W051DM.selT700.FieldByName('DECORRENZA').AsDateTime:=W051DM.selT713.FieldByName('DECORRENZA').AsDateTime;
    W051DM.selT700.FieldByName('ORE').AsString:=DatiRiga.Ore;
    W051DM.selT700.FieldByName('IMPORTO').AsFloat:=DatiRiga.Importo;

    if not C018.WarningRichiesta then
      Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,nil)
    else
      ConfermaInsRichiesta;
  end
  else
    TrasformaComponentiBudget(FN);
end;

procedure TW051FBudgetStraordinario.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W051DM.selt700 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La richiesta selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

function TW051FBudgetStraordinario.InizializzaAccesso: Boolean;
begin
  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=AutorizzaTutto;

    btnTuttiSi.Caption:='Valida tutto';
    btnTuttiSi.Confirmation:='Validare tutte le richieste di modifica budget?';
    btnTuttiNo.Caption:='Nega tutto';
    btnTuttiNo.Confirmation:='Negare la validazione a tutte le richieste di modifica budget?';
  end
  else
  begin
    // se data filtro è specificata -> funzione chiamata dal cartellino
    if ParametriForm.DataFiltro = 0 then
      ParametriForm.DataFiltro:=Date;
  end;

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;
end;

procedure TW051FBudgetStraordinario.IWAppFormCreate(Sender: TObject);
var
  Anno: Integer;
begin
  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'W051P0','W051P1');

  Tag:=IfThen(WR000DM.Responsabile,460,461);
  inherited;
  C004DM_1:=CreaC004(SessioneOracle,'W051_1',Parametri.Operatore,False);
  W051DM:=TW051FBudgetStraordinarioDM.Create(nil);
  Iter:=ITER_BUDGET_STRAORD;
  W051DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W051DM.selT700,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W051DM.selT700,tiRichiesta);

  C018.Periodo.ColonnaAl:=C018.Periodo.ColonnaDal;

  WA065Stm:=TWA065FStampaBudgetFM.Create(Self);
  WA065Stm.C004DMStm:=C004DM_1;
  WA065Stm.SolaLettura:=SolaLettura;
  WA065Stm.evtEseguiStampa:=EseguiStampa;
  WA065Stm.evtT713FilterRecord:=W051DM.selT713FilterRecord;
  WA065Stm.InizializzaFrame(GetParam('TIPO'),GetParam('CODGRUPPO'),GetParam('DECORRENZA'));

  //Impostazioni del frame per la stampa da W051
  WA065Stm.A065MW.IgnoraInibizioni:=True;
  WA065Stm.rgpTipoBudget.ItemIndex:=0;
  WA065Stm.rgpTipoBudget.Visible:=False; //nascosto anche tramite javascript
  WA065Stm.chkAggiornaFruito.Checked:=False;
  WA065Stm.chkAggiornaFruito.Visible:=False;

  //Sposta componenti sulla region per visualizzarli in tab
  lblFiltroVis.Parent:=W051RichiesteRG;
  grdFiltroVis.Parent:=W051RichiesteRG;
  lblFiltroStruttura.Parent:=W051RichiesteRG;
  cmbFiltroStruttura.Parent:=W051RichiesteRG;
  lblPeriodo.Parent:=W051RichiesteRG;
  rgpPeriodo.Parent:=W051RichiesteRG;
  edtPeriodoDal.Parent:=W051RichiesteRG;
  lblPeriodoDal.Parent:=W051RichiesteRG;
  edtPeriodoAl.Parent:=W051RichiesteRG;
  lblPeriodoAl.Parent:=W051RichiesteRG;
  lblAllegati.Parent:=W051RichiesteRG;
  rgpAllegati.Parent:=W051RichiesteRG;
  lblCondizAllegato.Parent:=W051RichiesteRG;
  rgpCondizAllegato.Parent:=W051RichiesteRG;
  btnFiltra.Parent:=W051RichiesteRG;
  btnModificaTutti.Parent:=W051RichiesteRG;
  btnAnnullaTutti.Parent:=W051RichiesteRG;
  btnTuttiSi.Parent:=W051RichiesteRG;
  btnTuttiNo.Parent:=W051RichiesteRG;
  grdRichieste.Parent:=W051RichiesteRG;

  tabBudget.AggiungiTab('Richieste', W051RichiesteRG);
  tabBudget.AggiungiTab('Gestione', W051GestioneRG);
  tabBudget.AggiungiTab('Stampa', WA065Stm);
  tabBudget.ActiveTab:=W051GestioneRG;

  cmbAnno.Items.Clear;
  W051DM.selT713lstAnno.First;
  while not W051DM.selT713lstAnno.Eof do
  begin
    cmbAnno.Items.Add(W051DM.selT713lstAnno.FieldByName('ANNO').AsString);
    W051DM.selT713lstAnno.Next;
  end;
  Anno:=YearOf(Parametri.DataLavoro);
  if cmbAnno.Items.IndexOf(IntToStr(Anno)) < 0 then
    Anno:=IfThen(cmbAnno.Items.Count > 0, StrToInt(cmbAnno.Items[0]), 0);
  cmbAnno.ItemIndex:=cmbAnno.Items.IndexOf(IntToStr(Anno));
  R180SetVariable(W051DM.selT713,'ANNO','  and T713.anno = ' + IntToStr(Anno));

  // tabella delle richieste
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W051DM.selT700;
  grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

  PreparaGrid(grdBudget, W051DM.selT713);
  PreparaComponentiBudget;
  PreparaGrid(grdDettaglio, W051DM.selT714);
  PreparaComponentiDettaglio;
end;

procedure TW051FBudgetStraordinario.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  WA065Stm.ReleaseOggetti;
  FreeAndNil(C004DM_1);
  WA065Stm.Free;
end;

procedure TW051FBudgetStraordinario.mnuEsportaBudgetCsvClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdBudget.ToCsv
  else
    InviaFile('Budget.xls',csvDownload);
end;

procedure TW051FBudgetStraordinario.mnuEsportaBudgetExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdBudget.ToXlsx
  else
    InviaFile('Budget.xlsx',streamDownload);
end;

procedure TW051FBudgetStraordinario.mnuEsportaDettaglioCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdDettaglio.ToCsv
  else
    InviaFile('Dettaglio.xls',csvDownload);
end;

procedure TW051FBudgetStraordinario.mnuEsportaDettaglioExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdDettaglio.ToXlsx
  else
    InviaFile('Dettaglio.xlsx',streamDownload);
end;

procedure TW051FBudgetStraordinario.PreparaGrid(pGrid: TmedpIWDBGrid; pDataset: TOracleDataSet);
begin
  with pGrid do
  begin
    medpPaginazione:=True;
    medpRighePagina:=GetRighePaginaTabella;
    medpAttivaGrid(pDataset, (pGrid=grdBudget) and (not WR000DM.Responsabile), False, False);
    medpPreparaComponentiDefault;
  end;
end;

procedure TW051FBudgetStraordinario.SetAutorizzazione(Sender: TObject);
// conferma l'autorizzazione indicata sulla richiesta
begin
  FAutorizza.Rowid:=TmeIWCheckBox(Sender).FriendlyName;
  FAutorizza.Checked:=TmeIWCheckBox(Sender).Checked;
  FAutorizza.Caption:=TmeIWCheckBox(Sender).Caption;

  // esegue l'autorizzazione della richiesta
  AutorizzazioneOK;
end;

procedure TW051FBudgetStraordinario.PreparaComponentiBudget;
var
  cFiltro: integer;
begin
  with grdBudget do
  begin
    //Colonna RIEPILOGO_ORARIO (accedi - label)
    cFiltro:=medpIndexColonna('RIEPILOGO_ORARIO');
    medpPreparaComponenteGenerico('R',cFiltro,0,DBG_IMG,'','ACCEDI','Visualizza anagrafiche selezionate','','S');
    medpPreparaComponenteGenerico('R',cFiltro,1,DBG_LBL,'','','','','S');
    OnRowClick:=grdBudgetRowClick;
    OnBeforeModifica:=grdBudgetOnBeforeModifica;
    OnModifica:=grdBudgetOnModifica;
    medpCaricaCDS;
  end;
end;

procedure TW051FBudgetStraordinario.PreparaComponentiDettaglio;
begin
  with grdDettaglio do
  begin
    medpPaginazione:=False;
    medpCaricaCDS;
  end;
end;

procedure TW051FBudgetStraordinario.AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva / negativa di tutte le richieste
// ancora da autorizzare visibili a video.
var
  Aut: String;
  ErrModCan: Boolean;
function FormattaDatiRichiesta: String;
  begin
    with W051DM.selT700 do
    begin
      Result:=Format('Richiesta %s di %s ore e importo %s effettuata il %s',
                     [FieldByName('CODGRUPPO').AsString + ' - ' + FieldByName('TIPO').AsString,
                      FieldByName('ORE').AsString,
                      FieldByName('IMPORTO').AsString]);
    end;
  end;
begin
  // inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);
  try
    // autorizzazione richieste
    with W051DM.selT700 do
    begin
      // niente refresh: autorizza solo ciò che è visualizzato nella pagina
      First;
      while not Eof do
      begin
        try
          if (FieldByName('ID_REVOCA').IsNull) and
             (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
             (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
          begin
            try
              C018.CodIter:=FieldByName('COD_ITER').AsString;
              C018.Id:=FieldByName('ID').AsInteger;
              try
                C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
                SessioneOracle.Commit;
                if C018.MessaggioOperazione <> '' then
                  raise Exception.Create(C018.MessaggioOperazione);
              except
                on E: Exception do
                begin
                  SessioneOracle.Commit;
                  // messaggio bloccante
                  MsgBox.MessageBox('Impostazione dell''autorizzazione fallita!' + CRLF +
                                    'Motivo: ' + E.Message + CRLF + CRLF +
                                    FormattaDatiRichiesta,ESCLAMA);
                  Exit;
                end;
              end;
              try //Aggiorna la T713
                if Aut=C018SI then
                begin
                  W051DM.updT713.SetVariable('ORE',FieldByName('ORE').AsString);
                  W051DM.updT713.SetVariable('IMPORTO',FieldByName('IMPORTO').AsFloat);
                  W051DM.updT713.SetVariable('CODGRUPPO',FieldByName('CODGRUPPO').AsString);
                  W051DM.updT713.SetVariable('TIPO',FieldByName('TIPO').AsString);
                  W051DM.updT713.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
                  W051DM.updT713.Execute;
                  SessioneOracle.Commit;
                end;
              except
                on E: Exception do
                begin
                  // messaggio bloccante
                  MsgBox.MessageBox('Aggiornamento del budget fallito!' + CRLF +
                                    'Motivo: ' + E.Message + CRLF + CRLF +
                                    FormattaDatiRichiesta,ESCLAMA);
                  Exit;
                end;
              end;
            except
              // errore probabilmente dovuto a record modificato / cancellato da altro utente
              on E:Exception do
              begin
                ErrModCan:=True;
              end;
            end;
          end;
        finally
          Next;
        end;
      end;
    end;
  finally
    W051DM.selT713.Refresh;
    grdBudget.medpCaricaCDS;
  end;
  if ErrModCan then
    MsgBox.MessageBox('Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.',INFORMA);
  Ok:=True;
end;

procedure TW051FBudgetStraordinario.AutorizzazioneOK;
// Importante: può essere richiamato anche da eventi async
var
  Aut,Resp: String;
  OreOld: String;
  ImportoOld: String;
begin
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W051DM.selT700 do
  begin
    // verifica presenza record
    //Refresh;
    if (not SearchRecord('ROWID',FAutorizza.RowId,[srFromBeginning])) or
       (not CheckRecord(FAutorizza.RowId)) then
    begin
      if GGetWebApplicationThreadVar.IsCallBack then
      begin
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      end
      else
      begin
        VisualizzaDipendenteCorrente;
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2),INFORMA);
      end;
      Exit;
    end;
  end;

  // imposta i dati di autorizzazione
  Resp:=Parametri.Operatore;
  if FAutorizza.Checked and (FAutorizza.Caption = 'Si') then
    // autorizzazione SI
    Aut:=C018SI
  else if FAutorizza.Checked and (FAutorizza.Caption = 'No') then
    // autorizzazione NO
    Aut:=C018NO
  else if not FAutorizza.Checked then
    // autorizzazione non impostata
    Aut:='';
  // salva i dati di autorizzazione
  try
    DatiRiga.Ore:=W051DM.selT700.FieldByName('ORE').AsString;
    DatiRiga.Importo:=W051DM.selT700.FieldByName('IMPORTO').AsFloat;
    DatiRiga.CodGruppo:=W051DM.selT700.FieldByName('CODGRUPPO').AsString;
    DatiRiga.Tipo:=W051DM.selT700.FieldByName('TIPO').AsString;
    DatiRiga.Decorrenza:=W051DM.selT700.FieldByName('DECORRENZA').AsDateTime;

    C018.CodIter:=W051DM.selT700.FieldByName('COD_ITER').AsString;
    C018.Id:=W051DM.selT700.FieldByName('ID').AsInteger;
    C018.InsAutorizzazione(W051DM.selT700.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
    SessioneOracle.Commit;
    if C018.MessaggioOperazione <> '' then
      raise Exception.Create(C018.MessaggioOperazione);

    if (Aut=C018SI) and (W051DM.selT700.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger >= C018.LivMaxObb) then  //Aggiorna la T713
    begin
      //Salva i dati attuali su T852
      OreOld:=VarToStr(W051DM.selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([DatiRiga.CodGruppo,DatiRiga.Tipo,DatiRiga.Decorrenza]),'ORE'));
      ImportoOld:=W051DM.selT713.Lookup('CODGRUPPO;TIPO;DECORRENZA',VarArrayOf([DatiRiga.CodGruppo,DatiRiga.Tipo,DatiRiga.Decorrenza]),'IMPORTO');
      C018.SetDatoAutorizzatore('ORE',OreOld,W051DM.selT700.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
      C018.SetDatoAutorizzatore('IMPORTO',ImportoOld,W051DM.selT700.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
      with W051DM.updT713 do
      begin
        SetVariable('ORE',DatiRiga.Ore);
        SetVariable('IMPORTO',DatiRiga.Importo);
        SetVariable('CODGRUPPO',DatiRiga.CodGruppo);
        SetVariable('TIPO',DatiRiga.Tipo);
        SetVariable('DECORRENZA',DatiRiga.Decorrenza);
        Execute;
        SessioneOracle.Commit;
      end;
      W051DM.selT713.Refresh;
      grdBudget.medpCaricaCDS;
      grdRichiesteRefresh;
    end
    else if R180In(Aut,[C018NO,''])
    and (C018.GetDatoAutorizzatore('ORE').Esiste and C018.GetDatoAutorizzatore('IMPORTO').Esiste) then //Verifica la presenza dei dati per il recupero su T852
      Messaggio('Conferma',Format('Ripristinare il budget: %s ore e importo %s?',[C018.GetDatoAutorizzatore('ORE').Valore,C018.GetDatoAutorizzatore('IMPORTO').Valore]),ConfermaUndoRichiesta, EliminaDatoAutorizzatore)
    else
      if not GGetWebApplicationThreadVar.IsCallBack then
        grdRichiesteRefresh;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      GGetWebApplicationThreadVar.ShowMessage('Impostazione della validazione fallita!' + CRLF +
                                 'Motivo: ' + E.Message);
    end;
  end;
end;

procedure TW051FBudgetStraordinario.EliminaDatoAutorizzatore;
begin
  C018.DelDatoAutorizzatore('ORE', C018.GetDatoAutorizzatore('ORE').Livello);
  C018.DelDatoAutorizzatore('IMPORTO', C018.GetDatoAutorizzatore('IMPORTO').Livello);
  grdRichiesteRefresh;
end;

procedure TW051FBudgetStraordinario.grdRichiesteRefresh;
begin
  W051DM.selT700.Refresh;
  grdRichieste.medpCaricaCDS;
end;

procedure TW051FBudgetStraordinario.BloccaGrid(Sender: TObject; pBlocca: Boolean);
var
  i: integer;
begin
  with TmedpIWDBGrid(Sender) do
  begin
    for i:=IfThen(RigaInserimento,1,0) to High(medpCompGriglia) do
    begin
      if Assigned(TmeIWGrid(medpCompGriglia[i].CompColonne[0])) then
        TmeIWGrid(medpCompGriglia[i].CompColonne[0]).Cell[0,0].Css:=IfThen(pBlocca,'invisibile','align_right');
    end;
  end;
end;

procedure TW051FBudgetStraordinario.TrasformaComponentiBudget(FN: String);
// Trasforma i componenti della riga indicata da text a control e viceversa
var
  i:Integer;
  cOre, cImporto: Integer;
begin
  i:=grdBudget.medpRigaDiCompGriglia(FN);

  cOre:=grdBudget.medpIndexColonna('ORE');
  cImporto:=grdBudget.medpIndexColonna('IMPORTO');

  grdBudget.medpBrowse:=True;

  //ORE
  FreeAndNil(grdBudget.medpCompGriglia[i].CompColonne[cOre]);
  //IMPORTO
  FreeAndNil(grdBudget.medpCompGriglia[i].CompColonne[cImporto]);

  grdBudget.medpCaricaCDS;
  grdDettaglio.medpCaricaCDS;

  BloccaGrid(grdDettaglio, False);
end;

procedure TW051FBudgetStraordinario.VisualizzaDipendenteCorrente;
begin
  inherited;
// salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  grdRichieste.medpBrowse:=True;

  // apre il dataset delle richieste di certificazione
  with W051DM.selT700 do
  begin
    Close;

    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
  end;
  R013Open(W051DM.selT700);

  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Val.','',nil);
    if C018.IterModificaValori then
      grdRichieste.medpAggiungiColonna('DBG_COMANDI','Modifica','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg val SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg val NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
  end
  else
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);

  grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);

  if not WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('TIPO_RICHIESTA','TIPO_RICHIESTA','',nil);
    grdRichieste.medpColonna('TIPO_RICHIESTA').Visible:=False;
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
  end;

  grdRichieste.medpAggiungiColonna('CODGRUPPO','Codice','',nil);
  grdRichieste.medpAggiungiColonna('D_CODGRUPPO','Descrizione','',nil);
  grdRichieste.medpAggiungiColonna('TIPO','Tipo','',nil);
  grdRichieste.medpAggiungiColonna('DECORRENZA','Decorrenza','',nil);
  grdRichieste.medpAggiungiColonna('ORE','Ore','',nil);
  grdRichieste.medpAggiungiColonna('IMPORTO','Importo','',nil);

  if not WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
  end;
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  if (not SolaLettura) then
  begin
    if not WR000DM.Responsabile then
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di modifica budget','Eliminare la richiesta di modifica budget "%s?"','',True)
    else
    begin
      // autorizzazione
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
    end;
  end;
  grdRichieste.medpCaricaCDS;
end;

procedure TW051FBudgetStraordinario.ConfermaInsRichiesta;
var IdIns:String;
begin
  try
    with W051DM.selT700 do
    begin
      C018.InsRichiesta('','','');
      if C018.MessaggioOperazione <> '' then
      begin
        Cancel;
        raise Exception.Create(C018.MessaggioOperazione);
      end;
      IdIns:=RowId;
      SessioneOracle.Commit;
      RegistraLog.RegistraOperazione;
      TrasformaComponentiBudget(DatiRiga.FN);
    end;
  except
    on E:Exception do
    begin
      SessioneOracle.Commit;
      GGetWebApplicationThreadVar.ShowMessage('Inserimento richiesta variazione budget fallito!' + CRLF + 'Motivo: ' + E.Message);
      exit;
    end;
  end;

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  grdBudget.medpDataSet.Refresh;
  grdBudget.medpDataSet.Locate('ROWID',DatiRiga.FN,[]);
  grdBudget.medpAggiornaCDS(True);

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW051FBudgetStraordinario.ConfermaUndoRichiesta;
var
  OreOld, ImportoOld: string;
begin
  try
    //Recupera i dati da T852
    OreOld:=C018.GetDatoAutorizzatore('ORE').Valore;
    ImportoOld:=C018.GetDatoAutorizzatore('IMPORTO').Valore;

    C018.DelDatoAutorizzatore('ORE', C018.GetDatoAutorizzatore('ORE').Livello);
    C018.DelDatoAutorizzatore('IMPORTO', C018.GetDatoAutorizzatore('IMPORTO').Livello);
    with W051DM.updT713 do
    begin
      SetVariable('ORE',OreOld);
      SetVariable('IMPORTO',ImportoOld);
      SetVariable('CODGRUPPO',DatiRiga.CodGruppo);
      SetVariable('TIPO',DatiRiga.Tipo);
      SetVariable('DECORRENZA',DatiRiga.Decorrenza);
      Execute;
      SessioneOracle.Commit;
    end;
    W051DM.selT713.Refresh;
    grdBudget.medpCaricaCDS;
    grdRichiesteRefresh;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      GGetWebApplicationThreadVar.ShowMessage('Impostazione della validazione fallita!' + CRLF +
                                 'Motivo: ' + E.Message);
    end;
  end;
end;

end.
