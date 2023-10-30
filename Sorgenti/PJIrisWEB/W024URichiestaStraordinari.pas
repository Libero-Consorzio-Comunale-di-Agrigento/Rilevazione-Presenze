unit W024URichiestaStraordinari;

interface

uses
  IWApplication, IWAppForm, SysUtils, Classes, Graphics,
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  Controls, IWCompLabel, IWControl, IWCompListbox, IWCompEdit, meIWEdit,
  IWCompButton, OracleData, IWCompCheckbox, Variants,  IWVCLBaseControl,
  Forms, IWVCLBaseContainer, IWContainer, DB, StrUtils, DBClient, Math, ActnList,
  IWDBGrids, medpIWDBGrid, A000UCostanti, A000USessione, A000UInterfaccia,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWComboBox,
  R400UCartellinoDtM, W024URichiestaStraordinariDM, R450, meIWGrid, meIWLabel, meIWButton,
  IWCompGrids, IWCompExtCtrls, meIWImageFile, meIWLink, Menus, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, meIWCheckBox,
  IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl, IWHTMLControls,
  IWTypes;

type
  TW024FRichiestaStraordinari = class(TR013FIterBase)
    dsrT065: TDataSource;
    cdsT065: TClientDataSet;
    grdRiepilogo: TmeIWGrid;
    lblMessaggio: TmeIWLabel;
    btnInserisci: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure CampoOreAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnInserisciClick(Sender: TObject);
  private
    FData: TDateTime;
    FDataPrimaRichiesta: TDateTime;
    FColOreEcc: Integer;
    FColOreComp: Integer;
    FColOreLiq: Integer;
    FColCaus: Integer;
    FColOreCaus: Integer;
    FColOreCausComp: Integer;
    FColOreCausLiq: Integer;
    RigheAutorizzabili: Integer;
    FMinutiArrotEcc: Integer;
    FMinutiArrotLiq: Integer;
    FMinutiArrotCausLiq: Integer;
    FArrotCausLiqFasce: String;
    FMinimoLiq: Integer;
    MinTotAnnuoComp: Integer;
    MinTotAnnuoLiq: Integer;
    MinTotAutComp: Integer;
    MinTotAutLiq: Integer;
    MinTotInAttAutComp: Integer;
    MinTotInAttAutLiq: Integer;
    FMinResiduiComp: Integer;
    FMinResiduiLiq: Integer;
    FOperazione: String;
    R400:TR400FCartellinoDtM;
    R450DtM1: TR450DtM1;
    StileCella1: String;
    StileCella2: String;
    // ConsideraRigheValidabili: Boolean;   // spostata nel contesto locale dove è utilizzata
    // DipValidabile: Boolean;              // spostata nel contesto locale dove è utilizzata
    W024DM: TW024FRichiestaStraordinariDM;
    FGestioneCausale: Boolean;
    function AssegnaCodIterMancanti:Boolean;
    procedure actCancRichiesta(FN:String);
    procedure actModRichiesta(FN:String);
    procedure AutorizzazioneOK(RowidT065:String;Aut:Boolean);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String);
    function  ControlliOK(FN: String): Boolean;
    procedure AggiornamentoSchedaRiepilogativa(Aut:Boolean);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure imgIterClick(Sender: TObject);
    function EsisteCodIterValidabile:Boolean;
    procedure ImpostaGrigliaRiepilogo;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure W024AutorizzaTutti(Sender: TObject; var Ok: Boolean);
    procedure AperturaDataSetIterTemp;
    procedure ConfermaModRichiesta;
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure OnCambiaProgressivo; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

const
  EDTORECAUSCOMP = 'edtOreCausComp';
  EDTORECAUSLIQ  = 'edtOreCausLiq';

implementation

uses W001UIrisWebDtM, SyncObjs;

{$R *.DFM}

function TW024FRichiestaStraordinari.InizializzaAccesso:Boolean;
begin
  Result:=True;
  FData:=ParametriForm.Al;
  GetDipendentiDisponibili(FData);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
  if WR000DM.Responsabile then
    cmbDipendentiDisponibili.ItemIndex:=0;

  // aggiorna dati
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per apertura funzione

  if WR000DM.Responsabile then
  begin
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W024AutorizzaTutti;
  end;

  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.IWAppFormCreate(Sender: TObject);
begin
  Tag:=IfThen(WR000DM.Responsabile,427,426);
  inherited;
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE';
  W024DM:=TW024FRichiestaStraordinariDM.Create(nil);
  W024DM.evtAperturaDataSetIterTemp:=AperturaDataSetIterTemp;
  Iter:=ITER_STRMESE;
  W024DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W024DM.selT065,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W024DM.selT065,tiRichiesta);
  C018.Periodo.SetVuoto;
  FData:=Parametri.DataLavoro;

  btnInserisci.Confirmation:='Si vuole inserire una nuova richiesta di straordinario per il mese di ' + FormatDateTime('mm/yyyy',R180AddMesi(Date,-W024DM.C90_W024MMIndietro)) + '?';

  //Tipo richiesta straordinario
  FGestioneCausale:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCaus) and (Parametri.CampiRiferimento.C15_LimitiMensCaus = 'S');

  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,
                           IfThen(W024DM.TipoRichStr = TTipoRichStrRec.BancaOre,
                                  'W024P1',
                                  'W024P4'),
                           IfThen(W024DM.TipoRichStr = TTipoRichStrRec.BancaOre,
                                  'W024P0',
                                  'W024P3'));

  // apertura dataset causali presenza filtrato
  WR000DM.selT275.Open;
  WR000DM.selT275.Filtered:=True;
  WR000DM.selT275.Tag:=WR000DM.selT275.Tag + 1;

  // apertura dataset causali presenza completo per lookup
  WR000DM.selT275Lookup.Open;
  WR000DM.selT275Lookup.Tag:=WR000DM.selT275Lookup.Tag + 1;

  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W024DM.selT065;

  // imposta tipo richieste (v. anche OnFormRender)
  if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
    C018.TipoRichiesteDisp:=C018.TipoRichiesteDisp - [trNonAutorizzabili];
end;

procedure TW024FRichiestaStraordinari.IWAppFormRender(Sender: TObject);
var RichiestaPendente:Boolean;
    OreEccedCalc:Integer;
begin
  inherited;

  //BloccaGestione:=grdRichieste.medpStato <> msBrowse; // sovrascritto da riga successiva
  BloccaGestione:=FOperazione <> '';

  btnInserisci.Visible:=(not SolaLettura) and
                        (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and
                        (not WR000DM.Responsabile) and
                        (R180Between(R180Giorno(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31))) and
                        (not WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)),'T820'));
  if btnInserisci.Visible then
  begin
    W024DM.selaT065.Close;
    W024DM.selaT065.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    W024DM.selaT065.SetVariable('DATA',R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)));
    W024DM.selaT065.Open;
    RichiestaPendente:=True;
    OreEccedCalc:=0;
    if W024DM.selaT065.RecordCount > 0 then
    begin
      RichiestaPendente:=False;
      while not W024DM.selaT065.Eof do
      begin
        if W024DM.selaT065.FieldByName('STATO').IsNull then
        begin
          RichiestaPendente:=True;
          Break;
        end;
        W024DM.selaT065.Next;
      end;
      W024DM.selaT065.Last;
      OreEccedCalc:=R180OreMinutiExt(W024DM.selaT065.FieldByName('ORE_ECCED_CALC').AsString) - IfThen(W024DM.selaT065.FieldByName('STATO').AsString = 'S',R180OreMinutiExt(W024DM.selaT065.FieldByName('ORE_ECCEDENTI').AsString),0);
    end;
    btnInserisci.Visible:=(not RichiestaPendente) and (OreEccedCalc > 0);
  end;

  // autorizza / nega tutto
  if btnTuttiSi.Visible then
    btnTuttiSi.Visible:=(not (trRichiedibili in C018.TipoRichiesteSel)) and
                        (not (trNonAutorizzabili in C018.TipoRichiesteSel)) and
                        (not (trAutorizzate in C018.TipoRichiesteSel)) and
                        (not (trNegate in C018.TipoRichiesteSel)) and
                        (not (trTutte in C018.TipoRichiesteSel)) and // suppongo sia inutile
                        (RigheAutorizzabili > 1);
  btnTuttiNo.Visible:=btnTuttiSi.Visible and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);
end;

procedure TW024FRichiestaStraordinari.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;
end;

procedure TW024FRichiestaStraordinari.OnCambiaProgressivo;
begin
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per cambio dipendente
  inherited;
end;

procedure TW024FRichiestaStraordinari.AperturaDataSetIterTemp;
var
  FiltroPeriodo,FiltroDip,FiltroVis,sOreComp,sOreLiq:String;
  DFin:TDateTime;
  DipValidabile: Boolean;
begin
  // aperture temporanee del dataset delle richieste straordinari per estrarre dati utili alla gestione
  // indico se considerare il livello della validazione
  if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
  begin
    // ricalcolo i dati annuali alla data dell'ultimo mese elaborato (Tipo=C; Mese più recente=T065.Data DESC)
    FiltroVis:='and T850.TIPO_RICHIESTA <> ''C''';
    R180SetVariable(W024DM.selT065,'FILTRO_VISUALIZZAZIONE',FiltroVis);
    // apertura temporanea per estrarre il riepilogo delle ore
    W024DM.selT065.Open;
    if (not TuttiDipSelezionato)
    and (W024DM.selT065.SearchRecord('TIPO','C',[srFromBeginning]))  then
    begin
      R450DtM1:=TR450DtM1.Create(nil);
      R450DtM1.ConteggiMese('Generico',R180Anno(W024DM.selT065.FieldByName('DATA').AsDateTime),R180Mese(W024DM.selT065.FieldByName('DATA').AsDateTime),selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      lblMessaggio.Caption:='Mese: <b>' + FormatDateTime('mm/yyyy',W024DM.selT065.FieldByName('DATA').AsDateTime) + '</b> &nbsp;&nbsp;&nbsp;&nbsp; Totale ore straordinario anno: <b>' + R180MinutiOre(R450DtM1.BancaOreAnno) + '</b> &nbsp;&nbsp;&nbsp;&nbsp; Residuo ore compensabili anno: <b>' + R180MinutiOre(R450DtM1.BancaOreResidua) + '</b>';
      FreeAndNil(R450DtM1);
    end;
    FDataPrimaRichiesta:=0;
    if W024DM.selT065.SearchRecord('TIPO_RICHIESTA;TIPO',VarArrayOf(['R','C']),[srFromBeginning]) then
    begin
      repeat
        FDataPrimaRichiesta:=W024DM.selT065.FieldByName('DATA').AsDateTime
      until not W024DM.selT065.SearchRecord('TIPO_RICHIESTA;TIPO',VarArrayOf(['R','C']),[]);
    end;
  end
  else if W024DM.AggiornaTotali then
  begin
    //Prelevo i riepiloghi di tutti i dipendenti selezionati
    FiltroDip:=selAnagrafeW.SubstitutedSql;
    FiltroDip:=IfThen(TuttiDipSelezionato,
                      'IN (SELECT PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')',
                      '= ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
    //Prelevo il riepilogo del Totale annuo
    W024DM.RecuperaLimitiAnnuali(FiltroDip,R180Anno(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)),sOreComp,sOreLiq);
    MinTotAnnuoComp:=R180OreMinutiExt(sOreComp);
    MinTotAnnuoLiq:=R180OreMinutiExt(sOreLiq);
    //Prelevo il riepilogo del Totale autorizzato
    W024DM.RecuperaLimitiMensili(FiltroDip,R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)),sOreComp,sOreLiq);
    MinTotAutComp:=R180OreMinutiExt(sOreComp);
    MinTotAutLiq:=R180OreMinutiExt(sOreLiq);
    //Prelevo il riepilogo del Totale in attesa di autorizzazione + Totale autorizzato del mese in modifica
    MinTotInAttAutComp:=0;
    MinTotInAttAutLiq:=0;
    FiltroPeriodo:=Format('and T_ITER.DATA = to_date(''%s'',''dd/mm/yyyy'')',
                          [FormatDateTime('dd/mm/yyyy',R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)))]);
    R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',FiltroPeriodo);
    FiltroVis:='and (T850.TIPO_RICHIESTA IN (''A'',''I'',''S'') and not ' + W024DM.FiltroNonAutorizzabili + ')';
    R180SetVariable(W024DM.selT065,'FILTRO_VISUALIZZAZIONE',FiltroVis);
    // apertura temporanea per estrarre il riepilogo delle ore
    W024DM.selT065.Open;
    W024DM.selT065.First;
    while not W024DM.selT065.Eof do
    begin
      if W024DM.selT065.FieldByName('TIPO_RICHIESTA').AsString = 'S' then
      begin
        MinTotAutComp:=MinTotAutComp + R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString);
        MinTotAutLiq:=MinTotAutLiq + R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString);
        if VarToStr(WR000DM.selT275.Lookup('CODICE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString,'ORENORMALI')) <> 'A' then
          MinTotAutLiq:=MinTotAutLiq + R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString);
      end
      else
      begin
        MinTotInAttAutComp:=MinTotInAttAutComp + R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString);
        MinTotInAttAutLiq:=MinTotInAttAutLiq + R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString);
        if VarToStr(WR000DM.selT275.Lookup('CODICE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString,'ORENORMALI')) <> 'A' then
          MinTotInAttAutLiq:=MinTotInAttAutLiq + R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString);
      end;
      W024DM.selT065.Next;
    end;
    FMinResiduiComp:=MinTotAnnuoComp - (MinTotAutComp + MinTotInAttAutComp);
    FMinResiduiLiq:=MinTotAnnuoLiq - (MinTotAutLiq + MinTotInAttAutLiq);
    W024DM.AggiornaTotali:=False;//Totali aggiornati fino alla prossima modifica, autorizzazione o cambio dipendente
  end;
  if W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre then
  begin
    // determina la data di fine periodo
    if not TryEncodeDate(R180Anno(Date),R180Mese(Date),StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31),DFin) then
      DFin:=R180FineMese(Date);
    lblMessaggio.Caption:='Periodo di richiesta/autorizzazione dal ' + IntToStr(StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1)) + ' al ' + FormatDateTime('dd mmmm yyyy',DFin);
  end;
  lblMessaggio.Visible:=lblMessaggio.Caption <> '';

  // riepilogo visible per autorizzatore, se tipo richiesta non è banca ore o causale liquidabile
  // grdRiepilogo.Visible:=(W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and WR000DM.Responsabile;
  grdRiepilogo.Visible:=(WR000DM.Responsabile) and (not R180In(W024DM.TipoRichStr,[TTipoRichStrRec.BancaOre,TTipoRichStrRec.StraordAnnuoCausPagComp]));
  if grdRiepilogo.Visible then
    ImpostaGrigliaRiepilogo;

  CorrezionePeriodo;
  R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',C018.Periodo.Filtro);

  if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
  begin
    // apertura temporanea per sapere se il dipendente è validabile nel periodo (eventualmente variato)
    W024DM.selT065.Open;
    DipValidabile:=(W024DM.selT065.RecordCount > 0) and EsisteCodIterValidabile;
  end
  else
    DipValidabile:=False;

  C018.TipoRichiesteDisp:=C018.TipoRichiesteDisp + [trValidate];
  if not DipValidabile then
    C018.TipoRichiesteDisp:=C018.TipoRichiesteDisp - [trValidate];
  CorrezionePeriodo;
  R180SetVariable(W024DM.selT065,'FILTRO_PERIODO',C018.Periodo.Filtro);
end;

procedure TW024FRichiestaStraordinari.VisualizzaDipendenteCorrente;
var
  LivelloAutorizzazione: Integer;
  ConsideraRigheValidabili: Boolean;
  RigheLimiti: Integer;
  RigheAvvertimenti: Integer;
begin
  inherited;
  FOperazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  lblMessaggio.Caption:='';
  //Disabilita l'estrazione dei campi calcolati finché non servono
  W024DM.CampiCalcolati:=False;
  // filtro in base alla selezione anagrafica
  W024DM.AperturaDataSetIter(IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,FiltroSingoloAnagrafico));
  // apertura dataset delle richieste straordinari
  // proseguo con l'apertura ufficiale del dataset
  R013Open(W024DM.selT065);
  if (not WR000DM.Responsabile) and AssegnaCodIterMancanti then
    W024DM.selT065.Refresh;
  ConsideraRigheValidabili:=(W024DM.selT065.RecordCount > 0) and EsisteCodIterValidabile;
  RigheAutorizzabili:=0;
  RigheLimiti:=0;
  RigheAvvertimenti:=0;
  if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
  begin
    //Per non visualizzare il pulsante "Autorizza tutto" quando accedo come Validatore,
    //bisogna controllare che non ci siano righe con un livello di autorizzazione relativo alla fase 2
    if WR000DM.Responsabile then
    begin
      W024DM.selT065.First;
      while not W024DM.selT065.Eof do
      begin
        C018.Id:=W024DM.selT065.FieldByName('ID').AsInteger;
        C018.CodIter:=W024DM.selT065.FieldByName('COD_ITER').AsString;
        LivelloAutorizzazione:=W024DM.selT065.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
        if (LivelloAutorizzazione > 0)  //per escludere i livelli < 0 che non possono più intervenire in quanto sono presenti autorizzazioni a livelli superiori
        and (C018.FaseLivello[LivelloAutorizzazione] = 2)
        and R180In(W024DM.selT065.FieldByName('TIPO_RICHIESTA').AsString,['A','V','I']) then
          inc(RigheAutorizzabili);
        if RigheAutorizzabili > 1 then
          Break;
        W024DM.selT065.Next;
      end;
    end;
    W024DM.CampiCalcolati:=True;//Riabilita l'estrazione dei campi calcolati
  end
  else
  begin
    RigheAutorizzabili:=W024DM.selT065.RecordCount; //utilizzato solo quando il responsabile visualizza le righe passibili di autorizzazione
    W024DM.CampiCalcolati:=True;//Riabilita l'estrazione dei campi calcolati
    W024DM.selT065.First;
    while not W024DM.selT065.Eof do
    begin
      //Righe con i limiti annuali
      if not W024DM.selT065.FieldByName('CF_Res_Ore_Comp_Anno').IsNull
      or not W024DM.selT065.FieldByName('CF_Res_Ore_Liq_Anno').IsNull then
        inc(RigheLimiti);
      //Righe con avvertimenti
      if not W024DM.selT065.FieldByName('D_Avvertimenti').IsNull then
        inc(RigheAvvertimenti);
      if (RigheLimiti > 0) and (RigheAvvertimenti > 0) then
        Break;
      W024DM.selT065.Next;
    end;
  end;
  W024DM.selT065.First; //W024DM.CampiCalcolati deve essere assolutamente abilitato prima di questa istruzione!

  //Creazione ClientDataSet con stessa struttura del DataSet di partenza
  grdRichieste.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
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
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
    grdRichieste.medpAggiungiColonna('CF_DATA','Mese','',nil);
    grdRichieste.medpAggiungiColonna('DESC_TIPO','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCED_CALC','Ore maturate','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCEDENTI','Ore da autorizzare','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_VALID','Ore validate','',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_VALID','Ore compensabili validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_VALID','Ore liquidabili validate','',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_VALID','Ore compensabili validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_AUTORIZ','Ore ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_AUTORIZ','Ore compensabili ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_AUTORIZ','Ore liquidabili ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_AUTORIZ','Ore compensabili ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_CAUSALE_AUTORIZ','Causale ' + IfThen(C018.IterModificaValori,'autorizzata','richiesta'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_AUTORIZ','Ore causalizzate ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_DACOMP_AUTORIZ','Ore causalizzate da comp. ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_DALIQ_AUTORIZ','Ore causalizzate da liq. ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_DACOMP_AUTORIZ','Ore causalizzate da comp. ' + IfThen(C018.IterModificaValori,'autorizzate','richieste'),'',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSABILI_ANNO','Limite ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSATE_ANNO','Ore compensate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_COMP_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDABILI_ANNO','Limite ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDATE_ANNO','Ore liquidate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_LIQ_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_COMP','Riepilogo ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_LIQ','Riepilogo ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
    grdRichieste.medpAggiungiColonna('MIN_ORE_DALIQUIDARE','MIN_ORE_DALIQUIDARE','',nil);
    grdRichieste.medpAggiungiColonna('MIN_ORE_DACOMPENSARE','MIN_ORE_DACOMPENSARE','',nil);
    grdRichieste.medpAggiungiColonna('MAX_ORE_DALIQUIDARE','MAX_ORE_DALIQUIDARE','',nil);
    grdRichieste.medpAggiungiColonna('MAX_ORE_CAUSALIZZATE_DALIQ','MAX_ORE_CAUSALIZZATE_DALIQ','',nil);

    grdRichieste.medpColonna('DBG_COMANDI').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('DESC_TIPO').Visible:=W024DM.TipoRichStr = TTipoRichStrRec.BancaOre;
    grdRichieste.medpColonna('ORE_ECCED_CALC').Visible:=W024DM.TipoRichStr = TTipoRichStrRec.BancaOre;
    grdRichieste.medpColonna('ORE_ECCEDENTI').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_ECCED_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_COMP_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_LIQ_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_CAUSALE_AUTORIZ').Visible:=FGestioneCausale or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('CF_ORE_CAUS_AUTORIZ').Visible:=FGestioneCausale or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('CF_ORE_CAUS_DACOMP_AUTORIZ').Visible:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('CF_ORE_CAUS_DALIQ_AUTORIZ').Visible:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('CF_ORE_COMPENSABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_COMPENSATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_COMP_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_LIQ_ANNO').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DALIQUIDARE').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DACOMPENSARE').Visible:=False;
    grdRichieste.medpColonna('CF_RIEP_ORE_COMP').Visible:=not R180In(W024DM.TipoRichStr,[TTipoRichStrRec.BancaOre,TTipoRichStrRec.StraordAnnuoCausPagComp]);
    grdRichieste.medpColonna('CF_RIEP_ORE_LIQ').Visible:=W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre;
    grdRichieste.medpColonna('D_AVVERTIMENTI').Visible:=(W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and (RigheAvvertimenti > 0);
    grdRichieste.medpColonna('MAX_ORE_DALIQUIDARE').Visible:=False;
    grdRichieste.medpColonna('MAX_ORE_CAUSALIZZATE_DALIQ').Visible:=False;
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('CF_DATA','Mese','',nil);
    grdRichieste.medpAggiungiColonna('DESC_TIPO','Tipo','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCED_CALC','Ore maturate','',nil);
    grdRichieste.medpAggiungiColonna('ORE_ECCEDENTI','Ore da autorizzare','',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('ORE_DACOMPENSARE','Ore da compensare','',nil);
    grdRichieste.medpAggiungiColonna('ORE_DALIQUIDARE','Ore in pagamento','',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('ORE_DACOMPENSARE','Ore da compensare','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('ORE_CAUSALIZZATE','Ore causalizzate','',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('ORE_CAUSALIZZATE_DACOMP','Ore causalizzate comp.','',nil);
    grdRichieste.medpAggiungiColonna('ORE_CAUSALIZZATE_DALIQ','Ore causalizzate liq.','',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('ORE_CAUSALIZZATE_DACOMP','Ore causalizzate comp.','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_VALID','Ore validate','',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_VALID','Ore compensabili validate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_VALID','Ore liquidabili validate','',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_VALID','Ore compensabili validate','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_ECCED_AUTORIZ','Ore autorizzate','',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_AUTORIZ','Ore compensabili autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQ_AUTORIZ','Ore liquidabili autorizzate','',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_COMP_AUTORIZ','Ore compensabili autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_CAUSALE_AUTORIZ','Causale autorizzata','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_AUTORIZ','Ore causalizzate autorizzate','',nil);
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_DACOMP_AUTORIZ','Ore causalizzate da comp. autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_DALIQ_AUTORIZ','Ore causalizzate da liq. autorizzate','',nil);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then 
      grdRichieste.medpAggiungiColonna('CF_ORE_CAUS_DACOMP_AUTORIZ','Ore causalizzate da comp. autorizzate','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSABILI_ANNO','Limite ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_COMPENSATE_ANNO','Ore compensate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_COMP_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDABILI_ANNO','Limite ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_ORE_LIQUIDATE_ANNO','Ore liquidate','',nil);
    grdRichieste.medpAggiungiColonna('CF_RES_ORE_LIQ_ANNO','Residuo','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_COMP','Riepilogo ore compensabili','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEP_ORE_LIQ','Riepilogo ore liquidabili','',nil);
    grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('D_AVVERTIMENTI','Avvertimenti','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('MIN_ORE_DALIQUIDARE','MIN_ORE_DALIQUIDARE','',nil);
    grdRichieste.medpAggiungiColonna('MIN_ORE_DACOMPENSARE','MIN_ORE_DACOMPENSARE','',nil);
    grdRichieste.medpAggiungiColonna('MAX_ORE_DALIQUIDARE','MAX_ORE_DALIQUIDARE','',nil);
    grdRichieste.medpAggiungiColonna('MAX_ORE_CAUSALIZZATE_DALIQ','MAX_ORE_CAUSALIZZATE_DALIQ','',nil);

    grdRichieste.medpColonna('DESC_TIPO').Visible:=W024DM.TipoRichStr = TTipoRichStrRec.BancaOre;
    grdRichieste.medpColonna('ORE_ECCED_CALC').Visible:=W024DM.TipoRichStr = TTipoRichStrRec.BancaOre;
    grdRichieste.medpColonna('CAUSALE').Visible:=FGestioneCausale or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('ORE_CAUSALIZZATE').Visible:=FGestioneCausale or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('ORE_CAUSALIZZATE_DACOMP').Visible:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('ORE_CAUSALIZZATE_DALIQ').Visible:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp);
    grdRichieste.medpColonna('CF_ORE_ECCED_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_COMP_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_LIQ_VALID').Visible:=ConsideraRigheValidabili;
    grdRichieste.medpColonna('CF_ORE_ECCED_AUTORIZ').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_COMP_AUTORIZ').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_LIQ_AUTORIZ').Visible:=C018.IterModificaValori;
    grdRichieste.medpColonna('CF_CAUSALE_AUTORIZ').Visible:=FGestioneCausale and C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_CAUS_AUTORIZ').Visible:=(FGestioneCausale or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp)) and C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_CAUS_DACOMP_AUTORIZ').Visible:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) and C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_CAUS_DALIQ_AUTORIZ').Visible:=(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) and C018.IterModificaValori;
    grdRichieste.medpColonna('CF_ORE_COMPENSABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_COMPENSATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_COMP_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDABILI_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_ORE_LIQUIDATE_ANNO').Visible:=False;
    grdRichieste.medpColonna('CF_RES_ORE_LIQ_ANNO').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DALIQUIDARE').Visible:=False;
    grdRichieste.medpColonna('MIN_ORE_DACOMPENSARE').Visible:=False;
    grdRichieste.medpColonna('CF_RIEP_ORE_COMP').Visible:=(RigheLimiti > 0) and not R180In(W024DM.TipoRichStr,[TTipoRichStrRec.BancaOre,TTipoRichStrRec.StraordAnnuoCausPagComp]);
    grdRichieste.medpColonna('CF_RIEP_ORE_LIQ').Visible:=RigheLimiti > 0;
    grdRichieste.medpColonna('D_AVVERTIMENTI').Visible:=(W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and (RigheAvvertimenti > 0);
    grdRichieste.medpColonna('MAX_ORE_DALIQUIDARE').Visible:=False;
    grdRichieste.medpColonna('MAX_ORE_CAUSALIZZATE_DALIQ').Visible:=False;
  end;

  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  if not SolaLettura then
  begin
    grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
    grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
    grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
    grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
    if WR000DM.Responsabile then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',1,0,DBG_CHK,'',IfThen(W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre,'Si',''),'','');
      if W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre then
        grdRichieste.medpPreparaComponenteGenerico('R',1,1,DBG_CHK,'','No','','');
    end;
  end;
  grdRichieste.medpCaricaCDS;
end;

function TW024FRichiestaStraordinari.EsisteCodIterValidabile:Boolean;
begin
  Result:=False;

  W024DM.selT065.First;
  while not W024DM.selT065.Eof do
  begin
    C018.CodIter:=W024DM.selT065.FieldByName('COD_ITER').AsString;
    if C018.EsisteFase[T065FASE_VALIDAZIONE] then
    begin
      Result:=True;
      Break;
    end;
    W024DM.selT065.Next;
  end;
  W024DM.selT065.First;
end;

function TW024FRichiestaStraordinari.AssegnaCodIterMancanti:Boolean;
begin
  Result:=False;
  while not W024DM.selT065.Eof do
  begin
    if (W024DM.selT065.FieldByName('TIPO_RICHIESTA').AsString = 'R') and (W024DM.selT065.FieldByName('COD_ITER').IsNull) then
    begin
      C018.SetCodIter;
      if C018.CodIter <> '' then
      begin
        SessioneOracle.Commit;
        Result:=True;
      end;
    end;
    W024DM.selT065.Next;
  end;
  W024DM.selT065.First;
end;

procedure TW024FRichiestaStraordinari.grdRiepilogoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  if not grdRiepilogo.Visible then
    exit;
  ACell.Css:=ACell.Css + ' align_center';
  if AColumn > 0 then
    ACell.Css:=ACell.Css + ' elencoOre';
  if ARow = 0 then
    ACell.Css:=ACell.Css + ' riga_intestazione'
  else
    ACell.Css:=ACell.Css + ' riga_bianca';
end;

procedure TW024FRichiestaStraordinari.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,LivelloAutorizzazione: Integer;
  IWImg: TmeIWImageFile;
  LIWGrd: TmeIWGrid;
begin
  //Righe dati
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
    IWImg.OnClick:=imgIterClick;
    IWImg.Hint:=C018.LeggiNoteComplete;
    IWImg.ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      //***IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      //***if C018.SetIconaAllegati(IWImg) then
      //***  IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if not SolaLettura then
    begin
      LivelloAutorizzazione:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
      //Tolgo i componenti se non ci sono le condizioni per la modifica/autorizzazione
      //Validatore
      if WR000DM.Responsabile and (C018.FaseLivello[LivelloAutorizzazione] = 1) then
      begin
        //elimino check di autorizzazione
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
        //Stato diverso da 'A' e 'V': elimino l'icona di modifica
        if not R180In(grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA'),['A','V']) then
          FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      end;
      //Responsabile: Stato diverso da 'A', 'V' e 'I'
      if WR000DM.Responsabile and (C018.FaseLivello[LivelloAutorizzazione] = 2) and
         not R180In(grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA'),['A','V','I']) and
         (LivelloAutorizzazione <> C018.LivMaxAut) then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
      end;
      //Responsabile o Validatore: verifico se posso modificare i valori
      if WR000DM.Responsabile and
         not C018.ModificaValori(LivelloAutorizzazione) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      //Dipendente:
      //  Gestione Banca ore: Stato diverso da 'R' (oppure stato 'R' ma la richiesta 'Corrente' non è la prima) e 'A'
      //  Gestione Str. ann.: Stato diverso da 'R' e 'A'
      if (not WR000DM.Responsabile) and
         (   not R180In(grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA'),['R','A'])
          or ((W024DM.TipoRichStr = TTipoRichStrRec.BancaOre) and
              (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R') and
              (grdRichieste.medpValoreColonna(i,'TIPO') = 'C') and
              (grdRichieste.medpValoreColonna(i,'DATA') <> DateTimeToStr(FDataPrimaRichiesta))
              )) then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
      if LivelloAutorizzazione < 0 then
      begin
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[1]);
      end;
      // Associo l'evento OnClick all'icona di modifica
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        if StileCella1 = '' then
        begin
          LIWGrd:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
          StileCella1:=LIWGrd.Cell[0,0].Css;
          StileCella2:=LIWGrd.Cell[0,1].Css;
        end;
        (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaClick;
        (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
        (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
        (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
        if (W024DM.TipoRichStr = TTipoRichStrRec.BancaOre)
        or WR000DM.Responsabile
        or (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R') then
          (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css:='invisibile';
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,2].Css:='invisibile';
        (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,3].Css:='invisibile';
      end;
      // Associo l'evento OnClick al checkbox di autorizzazione
      if WR000DM.Responsabile and (grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil) then
        C018.SetValoriAut(grdRichieste,i,1,0,IfThen(W024DM.TipoRichStr = TTipoRichStrRec.BancaOre,-1,1),chkAutorizzazioneClick);
    end;
  end;
end;

procedure TW024FRichiestaStraordinari.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  S: String;
  LCampo: String;
begin
  inherited;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  LCampo:=grdRichieste.medpColonna(NumColonna).DataField;

  if not grdRichieste.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if ((W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuo) and not WR000DM.Responsabile)
  and (LCampo = 'ORE_ECCEDENTI') then
    ACell.CSS:='invisibile'; //Se si rende invisibile la colonna fuori dal render, non si riesce ad assegnare il testo al relativo edit nell'evento async
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (LCampo = 'D_AUTORIZZAZIONE') then
    ACell.CSS:=ACell.CSS + ' align_center font_grassetto';
  ACell.Wrap:=ARow <> 1;
  //Formatto il titolo dei riepiloghi
  if (ARow = 0) and (   (LCampo = 'CF_RIEP_ORE_COMP')
                     or (LCampo = 'CF_RIEP_ORE_LIQ')) then
  begin
    ACell.Css:=ACell.Css + ' align_center elencoOre';
    ACell.RawText:=True;
    ACell.Text:=ACell.Text + '<div align="center">' +
                             '<span>Limite</span>' +
                             '<span>Fruito</span>' +
                             '<span>Residuo</span>' +
                             '</div>';
  end;
  //Imposto l'hint con la descrizione del mese
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (   (LCampo = 'CAUSALE')
       or (LCampo = 'CF_CAUSALE_AUTORIZ'))
  and (ACell.Text <> '') then
    ACell.Hint:=VarToStr(WR000DM.selT275.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
  //Imposto l'hint con la descrizione della causale
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (   (LCampo = 'CAUSALE')
       or (LCampo = 'CF_CAUSALE_AUTORIZ'))
  and (ACell.Text <> '') then
    ACell.Hint:=VarToStr(WR000DM.selT275.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
  //Imposto l'hint con la descrizione della tipologia
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0)
  and (LCampo = 'D_TIPO_RICHIESTA') then
  begin
    if ACell.Text = 'R' then
      ACell.Hint:='richiedibile'
    else if ACell.Text = 'A' then
      ACell.Hint:='da autorizzare'
    else if ACell.Text = 'X' then
      ACell.Hint:='non autorizzabile'
    else if ACell.Text = 'V' then
      ACell.Hint:='validata'
    else if ACell.Text = 'I' then
      ACell.Hint:='in autorizzazione'
    else if ACell.Text = 'S' then
      ACell.Hint:='autorizzata'
    else if ACell.Text = 'N' then
      ACell.Hint:='negata';
  end;
  //Formatto il riepilogo delle ore compensabili
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (LCampo = 'CF_RIEP_ORE_COMP') then
  begin
    S:=grdRichieste.medpValoreColonna(ARow - 1,'CF_Riep_Ore_Comp');
    if S <> '' then
    begin
      ACell.Css:=ACell.Css + ' align_center elencoOre';
      ACell.RawText:=True;
      ACell.Text:='<div align="center">';
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span' + IfThen(R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Compensate_Anno')) > R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Compensabili_Anno')),' class="riga_evidenziata"') + '>' + S + '</span>';
      ACell.Text:=ACell.Text + '</div>';
    end;
  end;
  //Formatto il riepilogo delle ore liquidabili
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (LCampo = 'CF_RIEP_ORE_LIQ') then
  begin
    S:=grdRichieste.medpValoreColonna(ARow - 1,'CF_Riep_Ore_Liq');
    if S <> '' then
    begin
      ACell.Css:=ACell.Css + ' align_center elencoOre';
      ACell.RawText:=True;
      ACell.Text:='<div align="center">';
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span>' + Copy(S,1,Pos(' ',S) - 1) + '</span>';
      S:=Copy(S,Pos(' ',S) + 1);
      ACell.Text:=ACell.Text + '<span' + IfThen(R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Liquidate_Anno')) > R180OreMinutiExt(grdRichieste.medpValoreColonna(ARow - 1,'CF_Ore_Liquidabili_Anno')),' class="riga_evidenziata"') + '>' + S + '</span>';
      ACell.Text:=ACell.Text + '</div>';
    end;
  end;
  //Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];

    // centra i componenti delle ore richieste
    if R180In(LCampo,
              ['ORE_ECCEDENTI','ORE_DACOMPENSARE','ORE_DALIQUIDARE','ORE_CAUSALIZZATE','CAUSALE','ORE_CAUSALIZZATE_DACOMP','ORE_CAUSALIZZATE_DALIQ']) then
    begin
      if not ACell.Css.Contains('align_center') then
        ACell.Css:=(ACell.Css + ' align_center').Trim;
    end;
  end;
end;

procedure TW024FRichiestaStraordinari.DBGridColumnClick(ASender: TObject; const AValue: string);
begin
  inherited;
  if (FOperazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;
  cdsT065.Locate('DBG_ROWID',AValue,[]);
end;

procedure TW024FRichiestaStraordinari.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per riga in meno
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
    Exit;
  end;
  //C018.VisualizzaDettagli(Sender);
  VisualizzaDettagli(Sender);
end;

procedure TW024FRichiestaStraordinari.imgCancellaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if (FOperazione = 'M') then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;

  DBGridColumnClick(Sender,FN);

  // se record non esiste -> errore grave
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Si è verificato un errore durante la modifica della richiesta: il record non è più disponibile.');
    Exit;
  end;

  actCancRichiesta(FN);
end;

procedure TW024FRichiestaStraordinari.actCancRichiesta(FN:String);
var i:Integer;
begin
  //cancellazione riga
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
  C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
  if grdRichieste.medpValoreColonna(i,'DESC_TIPO') = 'Conguaglio' then
    C018.EliminaIter
  else
  begin
    W024DM.selT065.RefreshRecord;
    W024DM.selT065.Edit;
    W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString:=W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString;
    W024DM.selT065.FieldByName('ORE_DACOMPENSARE').AsString:='';
    W024DM.selT065.FieldByName('ORE_DALIQUIDARE').AsString:='';
    if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      W024DM.selT065.FieldByName('CAUSALE').AsString:='';
      W024DM.selT065.FieldByName('ORE_CAUSALIZZATE').AsString:='';
    end;
    W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString:='';
    W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DACOMP').AsString:='';
    W024DM.selT065.Post;
    C018.SetTipoRichiesta('R');
    C018.SetDataRichiesta;
  end;
  SessioneOracle.Commit;
  VisualizzaDipendenteCorrente;

  //eventuale posizionamento su riga appena stroncata
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',FN,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW024FRichiestaStraordinari.imgModificaClick (Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // modifica
  if FOperazione = 'M' then
    Exit;

  // verifica richiesta esistente
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per riga in meno
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage('La richiesta da visualizzare non è più disponibile!');
    Exit;
  end;

  // posizionamento su richiesta
  DBGridColumnClick(grdRichieste,FN);

  // porta la riga in modifica: trasforma i componenti
  FOperazione:='M';
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpStato:=msEdit;

  // arrotondamenti e minimi
  // inizializza ai valori di default
  FMinutiArrotEcc:=1;
  FMinutiArrotLiq:=1;
  FMinimoLiq:=0;
  if W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre then
  begin
    // estrae dati di arrotondamento e minimi previsti sulla tipologia di cartellino del dipendente a fine mese della richiesta
    R180SetVariable(W024DM.selT025Info,'PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(W024DM.selT025Info,'DATA',R180FineMese(W024DM.selT065.FieldByName('DATA').AsDateTime));
    W024DM.selT025Info.Open;
    if W024DM.selT025Info.RecordCount > 0 then
    begin
      if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
      begin
        // arrotondamento liquidabile specifico
        FMinutiArrotLiq:=R180OreMinutiExt(W024DM.selT025Info.FieldByName('ITER_AUTSTR_ARROT_LIQ').AsString);

        // minimo liquidabile
        FMinimoLiq:=R180OreMinutiExt(W024DM.selT025Info.FieldByName('ITER_AUTSTR_MINIMO_LIQ').AsString);
      end
      else
      begin
        // arrotondamento generico delle eccedenze
        FMinutiArrotEcc:=R180OreMinutiExt(W024DM.selT025Info.FieldByName('ITER_AUTSTR_ARROT_ECC').AsString);
      end;
    end
    else
    begin
      raise Exception.CreateFmt('Nessuna tipologia di cartellino associata al dipendente al %s',[FormatDateTime('dd/mm/yyyy',R180FineMese(W024DM.selT065.FieldByName('DATA').AsDateTime))]);
    end;
  end;

  // estrae dati di arrotondamento della causale per la tipologia 5
  FMinutiArrotCausLiq:=1;
  FArrotCausLiqFasce:='N';

  if (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) and (W024DM.selT065.FieldByName('CAUSALE').AsString <> '') then
  begin
    R180SetVariable(W024DM.selT235,'CODICE',W024DM.selT065.FieldByName('CAUSALE').AsString);
    R180SetVariable(W024DM.selT235,'DATA',R180FineMese(W024DM.selT065.FieldByName('DATA').AsDateTime));
    W024DM.selT235.Open;
    if W024DM.selT235.RecordCount > 0 then
    begin
      FMinutiArrotCausLiq:=R180OreMinutiExt(W024DM.selT235.FieldByName('ITER_AUTSTR_ARROT_LIQ').AsString);
      FArrotCausLiqFasce:=W024DM.selT235.FieldByName('ITER_AUTSTR_ARROT_LIQ_FASCE').AsString
    end;
  end;

  // porta in modifica la riga
  TrasformaComponenti(FN);
end;

procedure TW024FRichiestaStraordinari.imgConfermaClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // applicazione modifiche
  // se record non esiste -> errore grave
  if not W024DM.selT065.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    FOperazione:='';
    grdRichieste.medpBrowse:=True;
    grdRichieste.medpStato:=msBrowse;
    TrasformaComponenti(FN);
    GGetWebApplicationThreadVar.ShowMessage('Si è verificato un errore durante la modifica della richiesta: il record non è più disponibile.');
    Exit;
  end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  actModRichiesta(FN);
end;

procedure TW024FRichiestaStraordinari.imgAnnullaClick(Sender: TObject);
var i:Integer;
    FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // annullamento modifiche
  FOperazione:='';
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  TrasformaComponenti(FN);

  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre)
  and (not WR000DM.Responsabile)
  and (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R')
  and (grdRichieste.medpValoreColonna(i,'DESC_TIPO') = 'Conguaglio') then
    actCancRichiesta(FN);
end;

procedure TW024FRichiestaStraordinari.TrasformaComponenti(FN:String);
{ Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdRichieste }
  function ApplicaArrotondamento(S:String):String;
  var min:Integer;
  begin
    Result:=S;
    min:=R180OreMinutiExt(S);
    if (FMinutiArrotEcc <> 1) and (min > 0) then
      Result:=R180MinutiOre(Trunc(R180Arrotonda(min,FMinutiArrotEcc,'E')));
  end;
var
  DaTestoAControlli: Boolean;
  i: Integer;
  LLivelloAut: Integer;
  LFaseLivello: Integer;
  S:String;
  LIWGrd: TmeIWGrid;
  LIWEdt: TmeIWEdit;
  LIWCmb: TmeIWComboBox;
  LOreEccedenti: Integer;
  LOreCausalizzate: Integer;
  LCausale: string;
  LCausaleInesistente: Boolean;
  LCausaleOreNormali: string;
  LBlocca: Boolean;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
  LLivelloAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
  LFaseLivello:=C018.FaseLivello[LLivelloAut];

  // determina gli indici di colonna dei dati in base alla fase
  case LFaseLivello of
    0:begin
        FColOreEcc:=grdRichieste.medpIndexColonna('ORE_ECCEDENTI');
        FColOreComp:=grdRichieste.medpIndexColonna('ORE_DACOMPENSARE');
        FColOreLiq:=grdRichieste.medpIndexColonna('ORE_DALIQUIDARE');
        FColCaus:=grdRichieste.medpIndexColonna('CAUSALE');
        FColOreCaus:=grdRichieste.medpIndexColonna('ORE_CAUSALIZZATE');
        FColOreCausComp:=grdRichieste.medpIndexColonna('ORE_CAUSALIZZATE_DACOMP');
        FColOreCausLiq:=grdRichieste.medpIndexColonna('ORE_CAUSALIZZATE_DALIQ');
      end;
    1:begin
        FColOreEcc:=grdRichieste.medpIndexColonna('CF_ORE_ECCED_VALID');
        FColOreComp:=grdRichieste.medpIndexColonna('CF_ORE_COMP_VALID');
        FColOreLiq:=grdRichieste.medpIndexColonna('CF_ORE_LIQ_VALID');
        (*
        FColCaus:=grdRichieste.medpIndexColonna('CF_CAUSALE_VALID');
        FColOreCaus:=grdRichieste.medpIndexColonna('CF_ORE_CAUSALIZZATE_VALID');
        FColOreCausComp:=grdRichieste.medpIndexColonna('CF_ORE_CAUSALIZZATE_DACOMP_VALID');
        FColOreCausLiq:=grdRichieste.medpIndexColonna('CF_ORE_CAUSALIZZATE_DALIQ_VALID');
        *)
      end;
    2:begin
        FColOreEcc:=grdRichieste.medpIndexColonna('CF_ORE_ECCED_AUTORIZ');
        FColOreComp:=grdRichieste.medpIndexColonna('CF_ORE_COMP_AUTORIZ');
        FColOreLiq:=grdRichieste.medpIndexColonna('CF_ORE_LIQ_AUTORIZ');
        FColCaus:=grdRichieste.medpIndexColonna('CF_CAUSALE_AUTORIZ');
        FColOreCaus:=grdRichieste.medpIndexColonna('CF_ORE_CAUS_AUTORIZ');
        FColOreCausComp:=grdRichieste.medpIndexColonna('CF_ORE_CAUS_DACOMP_AUTORIZ');
        FColOreCausLiq:=grdRichieste.medpIndexColonna('CF_ORE_CAUS_DALIQ_AUTORIZ');
      end;
  end;

  DaTestoAControlli:=grdRichieste.medpCompGriglia[i].CompColonne[FColOreEcc] = nil;

  // Gestione icone comandi
  LIWGrd:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
  LIWGrd.Cell[0,0].Css:=IfThen(DaTestoAControlli or (W024DM.TipoRichStr = TTipoRichStrRec.BancaOre) or WR000DM.Responsabile or (grdRichieste.medpValoreColonna(i,'D_TIPO_RICHIESTA') = 'R'),'invisibile',StileCella1);
  LIWGrd.Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',StileCella2);
  LIWGrd.Cell[0,2].Css:=IfThen(DaTestoAControlli,StileCella1,'invisibile');
  LIWGrd.Cell[0,3].Css:=IfThen(DaTestoAControlli,StileCella2,'invisibile');

  // flag autorizzazione
  if grdRichieste.medpCompGriglia[i].CompColonne[1] <> nil then
  begin
    (grdRichieste.medpCompCella(i,1,0) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
    if grdRichieste.medpCompCella(i,1,1) <> nil then
      (grdRichieste.medpCompCella(i,1,1) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
  end;

  if DaTestoAControlli then
  begin
    // ore da autorizzare/autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,FColOreEcc,grdRichieste.Componenti);
    LIWEdt:=(grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit);
    LIWEdt.Name:='edtOreEcc';
    case LFaseLivello of
      0: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORE_ECCEDENTI');
      1: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_ECCED_VALID');
      2: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_ECCED_AUTORIZ');
    end;
    LOreEccedenti:=R180OreMinuti(LIWEdt.Text);
    // blocca il dato in questi casi:
    // - per il responsabile, se il tipo richiesta è 5
    // - per il richiedente se il tipo richiesta è
    if WR000DM.Responsabile then
      LBlocca:=W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp
    else
      LBlocca:=R180In(W024DM.TipoRichStr,[TTipoRichStrRec.StraordAnnuoCaus,TTipoRichStrRec.OreCausalizzate,TTipoRichStrRec.StraordAnnuoCausPagComp]);
    if LBlocca then
    begin
      LIWEdt.ReadOnly:=True;
      LIWEdt.Css:=LIWEdt.Css + ' readonly_like_disabled';
    end;
    LIWEdt.OnAsyncExit:=CampoOreAsyncExit;

    // ore da compensare/da compensare autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,IfThen(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp,'input_hour_hhhmm2 ') + 'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,FColOreComp,grdRichieste.Componenti);
    LIWEdt:=(grdRichieste.medpCompCella(i,FColOreComp,0) as TmeIWEdit);
    LIWEdt.Name:='edtOreComp';
    case LFaseLivello of
      0: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORE_DACOMPENSARE');
      1: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_VALID');
      2: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_AUTORIZ');
    end;
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      LIWEdt.ReadOnly:=True;
      LIWEdt.Css:=LIWEdt.Css + ' readonly_like_disabled';
    end
    else
      LIWEdt.OnAsyncExit:=CampoOreAsyncExit;
    if W024DM.TipoRichStr = TTipoRichStrRec.OreCausalizzate then
    begin
      LIWEdt.Hint:='Ore minime da compensare: ' + ApplicaArrotondamento(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DACOMPENSARE')));
    end;

    // ore in pagamento/in pagamento autorizzate
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,IfThen(W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp,'input_hour_hhhmm2 ') + 'width4chr','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,FColOreLiq,grdRichieste.Componenti);
    LIWEdt:=(grdRichieste.medpCompCella(i,FColOreLiq,0) as TmeIWEdit);
    LIWEdt.Name:='edtOreLiq';
    case LFaseLivello of
      0: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORE_DALIQUIDARE');
      1: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_VALID');
      2: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_AUTORIZ');
    end;
    LIWEdt.OnAsyncExit:=CampoOreAsyncExit;
    if W024DM.TipoRichStr = TTipoRichStrRec.OreCausalizzate then
    begin
      LIWEdt.Hint:='Ore minime da liquidare: ' + ApplicaArrotondamento(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DALIQUIDARE')));
    end
    else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      if Trunc(R180Arrotonda(max(LOreEccedenti,FMinimoLiq),FMinutiArrotLiq,'D')) <= 0 then
      begin
        LIWEdt.ReadOnly:=True;
        LIWEdt.Css:=LIWEdt.Css + ' readonly_like_disabled';
      end
      else
      // info relativa a minimo e arrotondamento
      if (FMinimoLiq > 0) or (FMinutiArrotLiq > 1) then
      begin
        LIWEdt.Hint:='<html><b>Ore in pagamento</b>'#13#10 +
                     Format('Massimo richiedibile: %s'#13#10,[grdRichieste.medpValoreColonna(i,'MAX_ORE_DALIQUIDARE')]) +
                     IfThen(FMinimoLiq > 0,Format('Tot. liquidazioni minimo: %s'#13#10,[R180MinutiOre(FMinimoLiq)])) +
                     IfThen(FMinutiArrotLiq > 1,Format('Arrotondamento per difetto a %d minuti',[FMinutiArrotLiq]));
      end;
    end;

    if FGestioneCausale then
    begin
      // causale/causale autorizzata
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','Selezione della causale per lo straordinario','','','S');
      grdRichieste.medpCreaComponenteGenerico(i,FColCaus,grdRichieste.Componenti);
      LIWCmb:=(grdRichieste.medpCompCella(i,FColCaus,0) as TmeIWComboBox);
      LIWCmb.Name:='cmbCausale';
      LIWCmb.ItemsHaveValues:=True;
      LIWCmb.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
      LIWCmb.Items.BeginUpdate;
      LIWCmb.Items.Add('');
      WR000DM.selT275.First;
      while not WR000DM.selT275.Eof do
      begin
        LIWCmb.Items.Values[Format('%-5s %s',[WR000DM.selT275.FieldByName('CODICE').AsString,WR000DM.selT275.FieldByName('DESCRIZIONE').AsString])]:=WR000DM.selT275.FieldByName('CODICE').AsString;
        WR000DM.selT275.Next;
      end;
      LIWCmb.Items.EndUpdate;
      case LFaseLivello of
        0: S:=grdRichieste.medpValoreColonna(i,'CAUSALE');
        2: S:=grdRichieste.medpValoreColonna(i,'CF_CAUSALE_AUTORIZ');
      end;
      LIWCmb.ItemIndex:=Max(0,R180IndexOf(LIWCmb.Items,S,5));
      LIWCmb.OnAsyncChange:=cmbCausaleAsyncChange;
    end;

    if (FGestioneCausale) or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) then
    begin
      // ore causalizzate/causalizzate autorizzate
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'width4chr','','','','S');
      grdRichieste.medpCreaComponenteGenerico(i,FColOreCaus,grdRichieste.Componenti);
      LIWEdt:=(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit);
      LIWEdt.Name:='edtOreCaus';
      case LFaseLivello of
        0: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORE_CAUSALIZZATE');
        2: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_CAUS_AUTORIZ');
      end;
      // in caso di gestione con causale liquidabile / compensabile questo dato è in sola lettura
      if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
      begin
        LIWEdt.ReadOnly:=True;
        LIWEdt.Css:=LIWEdt.Css + ' readonly_like_disabled';
      end
      else
      begin
        LIWEdt.OnAsyncExit:=CampoOreAsyncExit;
      end;
    end;

    // in caso di gestione con causale liquidabile / compensabile
    // predispone i relativi dati
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      // verifica se la causale è indicata ed esiste sul db
      case LFaseLivello of
        0: LCausale:=grdRichieste.medpValoreColonna(i,'CAUSALE');
        2: LCausale:=grdRichieste.medpValoreColonna(i,'CF_CAUSALE_AUTORIZ');
      end;
      LCausaleInesistente:=(LCausale <> '') and (not WR000DM.selT275Lookup.SearchRecord('CODICE',LCausale,[srFromBeginning]));
      if LCausaleInesistente then
      begin
        MsgBox.MessageBox(Format('La causale di riepilogo per le richieste di compensazione o liquidazione (%s) non è presente nel database!'#13#10 +
                                 'I relativi dati sono pertanto disabilitati!',[LCausale]),ESCLAMA);
      end;
      LCausaleOreNormali:=VarToStr(WR000DM.selT275Lookup.Lookup('CODICE',LCausale,'ORENORMALI'));

      // numero di minuti da distribuire
      LOreCausalizzate:=R180OreMinutiExt((grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text);

      // ore causalizzate da compensare
      //   se la causale è esclusa dalle ore normali:
      //   il dato non è abilitato, ma si possono specificare solo le ORE_CAUSALIZZATE_DALIQ
      //   (le ORE_CAUSALIZZATE_DACOMP saranno = (ORE_CAUSALIZZATE - ORE_CAUSALIZZATE_DALIQ)
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'input_hour_hhhmm2 width4chr','','','','S');
      grdRichieste.medpCreaComponenteGenerico(i,FColOreCausComp,grdRichieste.Componenti);
      LIWEdt:=(grdRichieste.medpCompCella(i,FColOreCausComp,0) as TmeIWEdit);
      LIWEdt.Name:=EDTORECAUSCOMP;
      case LFaseLivello of
        0: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORE_CAUSALIZZATE_DACOMP');
        2: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_CAUS_DACOMP_AUTORIZ');
      end;
      // il dato viene disabilitato in questi casi (valutati in or):
      // - non ci sono ore causalizzate disponibili oppure
      // - la causale non è indicata o è inesistente
      // - la causale è esclusa dalle ore normali
      // il dato viene disabilitato
      if (LOreCausalizzate = 0) or
         (LCausale = '') or (LCausaleInesistente) or
         (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) or
         (TTipoInclusioneOreNormaliRec.IsEsclusa(LCausaleOreNormali)) then
      begin
        LIWEdt.ReadOnly:=True;
        LIWEdt.Css:=LIWEdt.Css + ' readonly_like_disabled';
      end
      else
      begin
        LIWEdt.OnAsyncExit:=CampoOreAsyncExit;
      end;

      // ore causalizzate da liquidare
      grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'input_hour_hhhmm2 width4chr','','','','S');
      grdRichieste.medpCreaComponenteGenerico(i,FColOreCausLiq,grdRichieste.Componenti);
      LIWEdt:=(grdRichieste.medpCompCella(i,FColOreCausLiq,0) as TmeIWEdit);
      LIWEdt.Name:=EDTORECAUSLIQ;
      case LFaseLivello of
        0: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'ORE_CAUSALIZZATE_DALIQ');
        2: LIWEdt.Text:=grdRichieste.medpValoreColonna(i,'CF_ORE_CAUS_DALIQ_AUTORIZ');
      end;

      // il dato viene disabilitato in questi casi (valutati in or):
      // - nn ci sono ore causalizzate disponibili, il dato viene disabilitato
      // - la causale non è indicata o è inesistente
      if (Trunc(R180Arrotonda(max(LOreCausalizzate,FMinimoLiq),FMinutiArrotCausLiq,'D')) <= 0) or
         (LCausaleInesistente) then
      begin
        LIWEdt.ReadOnly:=True;
        LIWEdt.Css:=LIWEdt.Css + ' readonly_like_disabled';
      end
      else
      begin
        LIWEdt.OnAsyncExit:=CampoOreAsyncExit;

        // info relativa a minimo e arrotondamento
        if (FMinimoLiq > 0) or (FMinutiArrotCausLiq > 1) then
        begin
          LIWEdt.Hint:='<html><b>Ore causalizzate liq.</b>'#13#10 +
                       Format('Massimo richiedibile: %s'#13#10,[grdRichieste.medpValoreColonna(i,'MAX_ORE_CAUSALIZZATE_DALIQ')]) +
                       IfThen(FMinimoLiq > 0,Format('Tot. liquidazioni minimo: %s'#13#10,[R180MinutiOre(FMinimoLiq)])) +
                       IfThen(FMinutiArrotCausLiq > 1,Format('Arrot. per difetto a %d minuti (causale %s)',[FMinutiArrotCausLiq,LCausale]));
        end;
      end;
    end;
  end
  else
  begin
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColOreEcc]);
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColOreComp]);
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColOreLiq]);
    if FGestioneCausale then
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColCaus]);
    if (FGestioneCausale) or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) then
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColOreCaus]);
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColOreCausComp]);
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[FColOreCausLiq]);
    end;
  end;
end;

procedure TW024FRichiestaStraordinari.CampoOreAsyncExit(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
  LEdtEcc: TmeIWEdit;
  LMinutiEcc: Integer;
  LEdtComp: TmeIWEdit;
  LMinutiComp: Integer;
  LEdtLiq: TmeIWEdit;
  LMinutiLiq: Integer;
  LEdtCaus: TmeIWEdit;
  LMinutiCaus: Integer;
  LEdtCausComp: TmeIWEdit;
  LMinutiCausComp: Integer;
  LEdtCausLiq: TmeIWEdit;
  LMinutiCausLiq: Integer;
  LMinOreDaLiquidare: Integer;
  LMinOreDaCompensare: Integer;
  LMaxOreDaLiquidare: Integer;
  LMaxOreCausDaLiquidare: Integer;
  LElencoDatiModificati: String;
  LJS: string;
begin
  i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);

  // gestione valore nullo
  if Trim((Sender as TmeIWEdit).Text) = '' then
  begin
    if W024DM.TipoRichStr = TTipoRichStrRec.OreCausalizzate then //Per TORINO_CSI, se il campo è nullo non si valorizza automaticamente l'altro
      exit
    else
      (Sender as TmeIWEdit).Text:='00.00';
  end;

  //Controllo che il valore sia stato inserito nel formato corretto
  try
    if (Length(Copy((Sender as TmeIWEdit).Text,Pos('.',(Sender as TmeIWEdit).Text) + 1)) <> 2)
    or not OreMinutiValidate((Sender as TmeIWEdit).Text) then
      (Sender as TmeIWEdit).Text:=R180MinutiOre(R180OreMinutiExt((Sender as TmeIWEdit).Text));
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      (Sender as TmeIWEdit).SetFocus;
      Exit;
    end;
  end;

  // applica immediatamente l'arrotondamento generico (ITER_AUTSTR_ARROT_ECC) al valore impostato
  // solo se tipologia <> StraordAnnuoCausPagComp
  if (FMinutiArrotEcc <> 1) and (W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp) then
    (Sender as TmeIWEdit).Text:=R180MinutiOre(R180OreMinutiExt((Sender as TmeIWEdit).Text) - (R180OreMinutiExt((Sender as TmeIWEdit).Text) mod FMinutiArrotEcc));

  // legge le ore eccedenti
  LEdtEcc:=(grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit);

  // legge le ore da compensare, da liquidare e causalizzate
  LEdtComp:=(grdRichieste.medpCompCella(i,FColOreComp,0) as TmeIWEdit);
  LMinutiComp:=R180OreMinutiExt(LEdtComp.Text);
  LEdtLiq:=(grdRichieste.medpCompCella(i,FColOreLiq,0) as TmeIWEdit);
  LMinutiLiq:=R180OreMinutiExt(LEdtLiq.Text);

  // Ore causalizzate
  if FGestioneCausale or (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) then
    LEdtCaus:=(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit)
  else
    LEdtCaus:=nil;
  LMinutiCaus:=0;
  if (FGestioneCausale and (Trim((grdRichieste.medpCompCella(i,FColCaus,0) as TmeIWComboBox).Text) <> '')) or
     (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp) then
    LMinutiCaus:=R180OreMinutiExt(LEdtCaus.Text);

  // legge le ore causalizzate destinate a compensazione e liquidazione
  if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    LEdtCausLiq:=(grdRichieste.medpCompCella(i,FColOreCausLiq,0) as TmeIWEdit);
    LMinutiCausLiq:=R180OreMinutiExt(LEdtCausLiq.Text);
    LEdtCausComp:=(grdRichieste.medpCompCella(i,FColOreCausComp,0) as TmeIWEdit);
    LMinutiCausComp:=LMinutiCaus - LMinutiCausLiq;
  end
  else
  begin
    LEdtCausComp:=nil;
    LMinutiCausComp:=0;
    LEdtCausLiq:=nil;
    LMinutiCausLiq:=0;
  end;

  if (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuo) and not WR000DM.Responsabile then
  begin
    // determina le ore eccedenti
    LMinutiEcc:=LMinutiComp + LMinutiLiq;
    LEdtEcc.Text:=R180MinutiOre(LMinutiEcc);
  end
  else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    // tipo di gestione straordinario con possibilità di liquidare
    // le ore rese con una causale specifica

    // determina le ore eccedenti
    LMinutiEcc:=R180OreMinutiExt(LEdtEcc.Text);
    LMinutiComp:=LMinutiEcc - LMinutiLiq;

    if (Sender as TmeIWEdit).Name = 'edtOreComp' then
    begin
      // verifica limite massimo (<= ore eccedenti)
      LMinutiComp:=Min(LMinutiComp, LMinutiEcc);

      // imposta le ore liquidabili per differenza
      LMinutiLiq:=LMinutiEcc - LMinutiComp;
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreLiq' then
    begin
      // verifica limite massimo (<= ore eccedenti)
      LMinutiLiq:=Min(LMinutiLiq, LMinutiEcc);

      // imposta le ore compensabili per differenza
      LMinutiComp:=LMinutiEcc - LMinutiLiq;
    end
    else if (Sender as TmeIWEdit).Name = EDTORECAUSCOMP then
    begin
      // verifica limite massimo (<= ore causalizzate)
      LMinutiCausComp:=Min(LMinutiCausComp, LMinutiCaus);

      // imposta le ore caus. liq per differenza
      LMinutiCausLiq:=LMinutiCaus - LMinutiCausComp;
    end
    else if (Sender as TmeIWEdit).Name = EDTORECAUSLIQ then
    begin
      // verifica limite massimo (<= ore causalizzate)
      LMinutiCausLiq:=Min(LMinutiCausLiq, LMinutiCaus);

      // imposta le ore caus. comp per differenza
      LMinutiCausComp:=LMinutiCaus - LMinutiCausLiq;
    end;

    // verifiche sulle ore liquidabili, se richieste
    if LMinutiLiq > 0 then
    begin
      // applica arrotondamento specifico (per difetto)
      if FMinutiArrotLiq > 1 then
        LMinutiLiq:=Trunc(R180Arrotonda(LMinutiLiq,FMinutiArrotLiq,'D'));

      // il valore massimo di ore liquidabili è indicato in MAX_ORE_DALIQUIDARE
      //LMaxOreDaLiquidare:=R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'MAX_ORE_DALIQUIDARE'));
      //LMinutiLiq:=Min(LMinutiLiq,LMaxOreDaLiquidare);

      // imposta le ore compensabili per differenza
      LMinutiComp:=LMinutiEcc - LMinutiLiq;
    end;

    // verifiche sulle ore caus. liq., se richieste
    if LMinutiCausLiq > 0 then
    begin
      // applica arrotondamento specifico (per difetto)
      if FMinutiArrotCausLiq > 1 then
        LMinutiCausLiq:=Trunc(R180Arrotonda(LMinutiCausLiq,FMinutiArrotCausLiq,'D'));

      //LMaxOreCausDaLiquidare:=R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'MAX_ORE_CAUSALIZZATE_DALIQ'));
      //LMinutiCausLiq:=Min(LMinutiCausLiq,LMaxOreCausDaLiquidare);

      // imposta le ore caus. comp per differenza
      LMinutiCausComp:=LMinutiCaus - LMinutiCausLiq;
    end;
  end
  else
  begin
    // determina le ore eccedenti
    LMinutiEcc:=R180OreMinutiExt((grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit).Text);

    //Se ho cambiato le ore eccedenti...
    if (Sender as TmeIWEdit).Name = 'edtOreEcc' then
    begin
      LMinutiEcc:=IfThen(LMinutiEcc > 0,LMinutiEcc,0);
      //Se diminuisco le ore, tolgo prima dalle ore compensabili
      if (LMinutiComp + LMinutiLiq + LMinutiCaus) > LMinutiEcc then
      begin
        LMinutiComp:=LMinutiEcc - LMinutiLiq - LMinutiCaus;
        LMinutiComp:=IfThen(LMinutiComp > 0,LMinutiComp,0);
        LMinutiLiq:=LMinutiEcc - LMinutiComp - LMinutiCaus;
        LMinutiLiq:=IfThen(LMinutiLiq > 0,LMinutiLiq,0);
      end
      //Se aumento le ore, aggiungo prima sulle ore liquidabili
      else if (LMinutiComp + LMinutiLiq + LMinutiCaus) < LMinutiEcc then
      begin
        LMinutiLiq:=LMinutiEcc - LMinutiComp - LMinutiCaus;
        LMinutiLiq:=IfThen(LMinutiLiq > 0,LMinutiLiq,0);
        LMinutiComp:=LMinutiEcc - LMinutiLiq - LMinutiCaus;
        LMinutiComp:=IfThen(LMinutiComp > 0,LMinutiComp,0);
      end;
      LMinutiCaus:=LMinutiEcc - LMinutiComp - LMinutiLiq;
      LMinutiCaus:=IfThen(LMinutiCaus > 0,LMinutiCaus,0);
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreComp' then
    begin
      LMinutiComp:=IfThen(LMinutiComp > 0,IfThen(LMinutiComp > LMinutiEcc,LMinutiEcc,LMinutiComp),0);
      LMinutiLiq:=LMinutiEcc - LMinutiComp - LMinutiCaus;
      LMinutiLiq:=IfThen(LMinutiLiq > 0,LMinutiLiq,0);
      LMinutiCaus:=LMinutiEcc - LMinutiComp - LMinutiLiq;
      LMinutiCaus:=IfThen(LMinutiCaus > 0,LMinutiCaus,0);
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreLiq' then
    begin
      LMinutiLiq:=IfThen(LMinutiLiq > 0,IfThen(LMinutiLiq > LMinutiEcc,LMinutiEcc,LMinutiLiq),0);
      LMinutiComp:=LMinutiEcc - LMinutiLiq - LMinutiCaus;
      LMinutiComp:=IfThen(LMinutiComp > 0,LMinutiComp,0);
      LMinutiCaus:=LMinutiEcc - LMinutiComp - LMinutiLiq;
      LMinutiCaus:=IfThen(LMinutiCaus > 0,LMinutiCaus,0);
    end
    else if (Sender as TmeIWEdit).Name = 'edtOreCaus' then
    begin
      LMinutiCaus:=IfThen(LMinutiCaus > 0,IfThen(LMinutiCaus > LMinutiEcc,LMinutiEcc,LMinutiCaus),0);
      LMinutiComp:=LMinutiEcc - LMinutiLiq - LMinutiCaus;
      LMinutiComp:=IfThen(LMinutiComp > 0,LMinutiComp,0);
      LMinutiLiq:=LMinutiEcc - LMinutiComp - LMinutiCaus;
      LMinutiLiq:=IfThen(LMinutiLiq > 0,LMinutiLiq,0);
    end;
  end;

  if W024DM.TipoRichStr = TTipoRichStrRec.OreCausalizzate then
  begin
    //TORINO_CSI_PRV: verifico che le ore da liquidare non siano sotto il minimo previsto (arrotondato)
    LMinOreDaLiquidare:=R180OreMinutiExt(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DALIQUIDARE')));
    if (FMinutiArrotEcc <> 1) and (LMinOreDaLiquidare > 0) then
      LMinOreDaLiquidare:=Trunc(R180Arrotonda(LMinOreDaLiquidare,FMinutiArrotEcc,'E'));
    if LMinutiLiq < LMinOreDaLiquidare then
    begin
      dec(LMinutiComp,LMinOreDaLiquidare - LMinutiLiq);
      LMinutiLiq:=LMinOreDaLiquidare;
    end;
    //TORINO_CSI_PRV: verifico che le ore da compensare non siano sotto il minimo previsto (arrotondato)
    LMinOreDaCompensare:=R180OreMinutiExt(VarToStr(grdRichieste.medpValoreColonna(i,'MIN_ORE_DACOMPENSARE')));
    if (FMinutiArrotEcc <> 1) and (LMinOreDaCompensare > 0) then
      LMinOreDaCompensare:=Trunc(R180Arrotonda(LMinOreDaCompensare,FMinutiArrotEcc,'E'));
    if LMinutiComp < LMinOreDaCompensare then
    begin
      dec(LMinutiLiq,LMinOreDaCompensare - LMinutiComp);
      LMinutiComp:=LMinOreDaCompensare;
    end;
  end;

  // imposta gli altri valori in base alla modifica effettuata sul campo
  LElencoDatiModificati:='';

  // ore da autorizzare
  if LEdtEcc.Text <> R180MinutiOre(LMinutiEcc) then
    LElencoDatiModificati:=LElencoDatiModificati + Format('#%s,',[LEdtEcc.HTMLName]);
  LEdtEcc.Text:=R180MinutiOre(LMinutiEcc);

  // ore da compensare
  if LEdtComp.Text <> R180MinutiOre(LMinutiComp) then
    LElencoDatiModificati:=LElencoDatiModificati + Format('#%s,',[LEdtComp.HTMLName]);
  LEdtComp.Text:=R180MinutiOre(LMinutiComp);

  // ore da liquidare
  if LEdtLiq.Text <> R180MinutiOre(LMinutiLiq) then
    LElencoDatiModificati:=LElencoDatiModificati + Format('#%s,',[LEdtLiq.HTMLName]);
  LEdtLiq.Text:=R180MinutiOre(LMinutiLiq);

  if FGestioneCausale then
  begin
    // ore causalizzate
    if LEdtCaus.Text <> R180MinutiOre(LMinutiCaus) then
      LElencoDatiModificati:=LElencoDatiModificati + Format('#%s,',[LEdtCaus.HTMLName]);
    LEdtCaus.Text:=R180MinutiOre(LMinutiCaus);
  end
  else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    // ore causalizzate (non modificabile)
    LEdtCaus.Text:=R180MinutiOre(LMinutiCaus);

    // ore causalizzate da compensare
    if LEdtCausComp.Text <> R180MinutiOre(LMinutiCausComp) then
      LElencoDatiModificati:=LElencoDatiModificati + Format('#%s,',[LEdtCausComp.HTMLName]);
    LEdtCausComp.Text:=R180MinutiOre(LMinutiCausComp);

    // ore causalizzate da liquidare
    if LEdtCausLiq.Text <> R180MinutiOre(LMinutiCausLiq) then
      LElencoDatiModificati:=LElencoDatiModificati + Format('#%s,',[LEdtCausLiq.HTMLName]);
    LEdtCausLiq.Text:=R180MinutiOre(LMinutiCausLiq);
  end;

  if W024DM.TipoRichStr <> TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    // se si esce dal campo "ore da autorizzare" imposta il focus su "ore da compensare"
    if (Sender as TmeIWEdit).Name = 'edtOreCaus' then
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('FindElem("EDTORECOMP").focus();');
  end;

  if (   ((W024DM.TipoRichStr = TTipoRichStrRec.BancaOre) and ((Sender as TmeIWEdit).Name = 'edtOreEcc'))
      or ((W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and ((Sender as TmeIWEdit).Name = 'edtOreComp')))
  and (LMinutiComp = 0)
  and (LMinutiLiq = 0)
  and (LMinutiCaus = 0)
  and (R180OreMinutiExt(IfThen(WR000DM.Responsabile,grdRichieste.medpValoreColonna(i,'ORE_ECCEDENTI'),grdRichieste.medpValoreColonna(i,'ORE_ECCED_CALC'))) <> 0) then
    GGetWebApplicationThreadVar.ShowMessage('Attenzione! Verranno ' + IfThen(WR000DM.Responsabile,'autorizzate','richieste e autorizzate') + ' 0 ore!');

  // evidenzia i campi modificati per dare un feedback visuale all'utente
  if LElencoDatiModificati <> '' then
  begin
    LElencoDatiModificati:=LElencoDatiModificati.Substring(0,LElencoDatiModificati.Length - 1);
    LJS:=Format('try { $("%s").effect("highlight", {}, %d); } catch(err) {} ',[LElencoDatiModificati,1500]);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(LJS);
  end;
end;

procedure TW024FRichiestaStraordinari.cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList);
var
  LEdtCaus: TmeIWEdit;
begin
  if (Sender as TmeIWComboBox).Text = '' then
  begin
    // azzera le ore causalizzate
    LEdtCaus:=(FindComponent('EDTORECAUS') as TmeIWEdit);
    LEdtCaus.Text:=R180MinutiOre(0);

    // fa scattare alcuni focus per ricalcolare le ore
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(
      //'FindElem("EDTORECAUS").value = "' + R180MinutiOre(0) + '";' + CRLF +
      'FindElem("EDTORECOMP").focus();' + CRLF +
      'FindElem("EDTORELIQ").focus();'+ CRLF + //Necessario per far scattare il ricalcolo delle ore, privilegiando le liquidabili
      'FindElem("EDTORECOMP").focus();');
  end;
end;

function TW024FRichiestaStraordinari.ControlliOK(FN: String): Boolean;
var
  i,Diff:Integer;
  SEcc,SComp,SLiq,SCaus,SCausComp,SCausLiq:String;
  LSomma: Integer;
  LTotLiq: Integer;
begin
  Result:=False;
  try
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    SEcc:=(grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit).Text;
    SComp:=(grdRichieste.medpCompCella(i,FColOreComp,0) as TmeIWEdit).Text;
    SLiq:=(grdRichieste.medpCompCella(i,FColOreLiq,0) as TmeIWEdit).Text;
    if (Length(Copy(SEcc,Pos('.',SEcc) + 1)) <> 2) or not OreMinutiValidate(SEcc) then
      raise exception.create('Indicare il valore delle ' + IfThen(WR000DM.Responsabile,'Ore autorizzate','Ore da autorizzare') + ' nel formato HH.MM');
    if (Length(Copy(SComp,Pos('.',SComp) + 1)) <> 2) or not OreMinutiValidate(SComp) then
      raise exception.create('Indicare il valore delle Ore da compensare nel formato HH.MM');
    if (Length(Copy(SLiq,Pos('.',SLiq) + 1)) <> 2) or not OreMinutiValidate(SLiq) then
      raise exception.create('Indicare il valore delle Ore in pagamento nel formato HH.MM');
    if FGestioneCausale then
    begin
      SCaus:=(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text;
      if (Length(Copy(SCaus,Pos('.',SCaus) + 1)) <> 2) or not OreMinutiValidate(SCaus) then
        raise exception.create('Indicare il valore delle Ore causalizzate nel formato HH.MM');
    end
    else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      SCaus:=(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text;
      SCausComp:=(grdRichieste.medpCompCella(i,FColOreCausComp,0) as TmeIWEdit).Text;
      if (Length(Copy(SCausComp,Pos('.',SCausComp) + 1)) <> 2) or not OreMinutiValidate(SCausComp) then
        raise exception.create('Indicare il valore delle Ore causalizzate da compensare nel formato HH.MM');
      SCausLiq:=(grdRichieste.medpCompCella(i,FColOreCausLiq,0) as TmeIWEdit).Text;
      if (Length(Copy(SCausLiq,Pos('.',SCausLiq) + 1)) <> 2) or not OreMinutiValidate(SCausLiq) then
        raise exception.create('Indicare il valore delle Ore causalizzate nel formato HH.MM');
    end;
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      Exit;
    end;
  end;
  //Ore da autorizzare maggiore o uguale a 00.00
  if R180OreMinutiExt(SEcc) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di ' + IfThen(WR000DM.Responsabile,'Ore autorizzate','Ore da autorizzare') + ' minore di 00.00!');
    Exit;
  end;
  //Ore da compensare maggiore o uguale a 00.00
  if R180OreMinutiExt(SComp) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore da compensare minore di 00.00!');
    Exit;
  end;
  //Ore in pagamento maggiore o uguale a 00.00
  if R180OreMinutiExt(SLiq) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore in pagamento minore di 00.00!');
    Exit;
  end;
  //Ore causalizzate maggiore o uguale a 00.00
  if R180OreMinutiExt(SCaus) < 0 then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore causalizzate minore di 00.00!');
    Exit;
  end;
  if W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre then
  begin
    //Ore da compensare maggiori del disponibile
    if (grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Comp_Anno') <> '')
    and (R180OreMinutiExt(SComp) > 0) then
    begin
      Diff:=R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Comp_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,IfThen(WR000DM.Responsabile,'CF_ORE_COMP_AUTORIZ','ORE_DACOMPENSARE')));
      if R180OreMinutiExt(SComp) > Diff then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore da compensare (' + SComp + ') maggiore di quelle disponibili (' + R180MinutiOre(Max(0,Diff)) + ')!');
        Exit;
      end;
    end;
    //Ore da liquidare maggiori del disponibile
    if (grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno') <> '')
    and (R180OreMinutiExt(SLiq) > 0) then
    begin
      Diff:=R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_Res_Ore_Liq_Anno')) + R180OreMinutiExt(grdRichieste.medpValoreColonna(i,IfThen(WR000DM.Responsabile,'CF_ORE_LIQ_AUTORIZ','ORE_DALIQUIDARE')));
      if R180OreMinutiExt(SLiq) > Diff then
      begin
        GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore in pagamento (' + SLiq + ') maggiore di quelle disponibili (' + R180MinutiOre(Max(0,Diff)) + ')!');
        Exit;
      end;
    end;
  end;
  //Ore da autorizzare minore o uguale a quelle richieste/calcolate
  if not WR000DM.Responsabile
  and (R180OreMinutiExt(SEcc) > R180OreMinutiExt(W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString)) then
  begin
    if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
      GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore da autorizzare (' + SEcc + ') maggiore di quello calcolato (' + W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString + ')!')
    else
      GGetWebApplicationThreadVar.ShowMessage('Il numero di ore indicato non è disponibile!');
    Exit;
  end
  else if WR000DM.Responsabile
  and (R180OreMinutiExt(SEcc) > R180OreMinutiExt(W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString)) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile indicare un numero di Ore autorizzate (' + SEcc + ') maggiore di quello richiesto (' + W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString + ')!');
    Exit;
  end;

  // Ore da compensare + Ore in pagamento [+ Ore Causalizzate] = Ore da autorizzare
  LSomma:=R180OreMinutiExt(SComp) +
          R180OreMinutiExt(SLiq) +
          IfThen(FGestioneCausale,R180OreMinutiExt(SCaus));
  if LSomma <> R180OreMinutiExt(SEcc) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La somma delle Ore da compensare con le Ore in pagamento' + IfThen(FGestioneCausale,' e con le Ore causalizzate') + ' deve essere uguale al numero di ' + IfThen(WR000DM.Responsabile,'Ore autorizzate','Ore da autorizzare') + '!');
    Exit;
  end;

  // ore caus. da comp + ore caus. da liq = ore causalizzate
  if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    // verifica che le [ore in pagamento + ore causalizzate liq.] raggiungano il limite minimo
    // impostato sul tipo cartellino ITER_AUTSTR_MINIMO_LIQ
    LTotLiq:=R180OreMinutiExt(SLiq) + R180OreMinutiExt(SCausLiq);
    if LTotLiq < FMinimoLiq then
    begin
      GGetWebApplicationThreadVar.ShowMessage(Format('La somma delle Ore in pagamento con le Ore causalizzate liq. deve essere di almeno %s',[R180MinutiOre(FMinimoLiq)]));
      Exit;
    end;

    // verifica totale ore causalizzate
    LSomma:=R180OreMinutiExt(SCausComp) + R180OreMinutiExt(SCausLiq);
    if LSomma <> R180OreMinutiExt(SCaus) then
    begin
      GGetWebApplicationThreadVar.ShowMessage('La somma delle Ore causalizzate comp. con le Ore causalizzate liq. ' +
                                              'deve essere uguale al numero di ' +
                                              IfThen(WR000DM.Responsabile,
                                              'Ore causalizzate autorizzate',
                                              'Ore causalizzate') + '!');
      Exit;
    end;
  end;

  // tutto ok
  Result:=True;
end;

procedure TW024FRichiestaStraordinari.actModRichiesta(FN:String);
var i,LivelloAutorizzazione,LivSetDato:Integer;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  C018.Id:=W024DM.selT065.FieldByName('ID').AsInteger;
  C018.CodIter:=W024DM.selT065.FieldByName('COD_ITER').AsString;
  LivelloAutorizzazione:=W024DM.selT065.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
  if C018.EsisteFase[T065FASE_VALIDAZIONE] then
    LivSetDato:=C018.FaseLivello[LivelloAutorizzazione]
  else
    LivSetDato:=1;
  if WR000DM.Responsabile then
  begin
    C018.SetDatoAutorizzatore('ORE_ECCEDENTI',(grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit).Text,LivSetDato);
    C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',(grdRichieste.medpCompCella(i,FColOreComp,0) as TmeIWEdit).Text,LivSetDato);
    C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',(grdRichieste.medpCompCella(i,FColOreLiq,0) as TmeIWEdit).Text,LivSetDato);
    if FGestioneCausale then
    begin
      C018.SetDatoAutorizzatore('CAUSALE',Copy((grdRichieste.medpCompCella(i,FColCaus,0) as TmeIWComboBox).Text,1,5),LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text,LivSetDato);
    end
    else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      C018.SetDatoAutorizzatore('CAUSALE',W024DM.selT065.FieldByName('CAUSALE').AsString,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ',(grdRichieste.medpCompCella(i,FColOreCausLiq,0) as TmeIWEdit).Text,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP',(grdRichieste.medpCompCella(i,FColOreCausComp,0) as TmeIWEdit).Text,LivSetDato);
    end;
    if C018.FaseLivello[LivelloAutorizzazione] = 1 then
    begin
      C018.SetTipoRichiesta('V');
      C018.InsAutorizzazione(LivelloAutorizzazione,C018SI,Parametri.Operatore,'','');
    end
    else
    begin
      C018.SetTipoRichiesta('I');
      C018.InsAutorizzazione(LivelloAutorizzazione,'',Parametri.Operatore,'','');
    end;
  end
  else
  begin
    W024DM.selT065.RefreshRecord;
    W024DM.selT065.Edit;
    W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString:=(grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit).Text;
    W024DM.selT065.FieldByName('ORE_DACOMPENSARE').AsString:=(grdRichieste.medpCompCella(i,FColOreComp,0) as TmeIWEdit).Text;
    W024DM.selT065.FieldByName('ORE_DALIQUIDARE').AsString:=(grdRichieste.medpCompCella(i,FColOreLiq,0) as TmeIWEdit).Text;
    if FGestioneCausale then
    begin
      W024DM.selT065.FieldByName('CAUSALE').AsString:=Copy((grdRichieste.medpCompCella(i,FColCaus,0) as TmeIWComboBox).Text,1,5);
      W024DM.selT065.FieldByName('ORE_CAUSALIZZATE').AsString:=(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text;
    end
    else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DACOMP').AsString:=(grdRichieste.medpCompCella(i,FColOreCausComp,0) as TmeIWEdit).Text;
      W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString:=(grdRichieste.medpCompCella(i,FColOreCausLiq,0) as TmeIWEdit).Text;
    end;

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

procedure TW024FRichiestaStraordinari.W024AutorizzaTutti(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva di tutte le richieste ancora da autorizzare visibili a video.
var
  Aut,ErrModCan,RichOltreLimiti,RichAZero,RichDaValid: Boolean;
  Messaggio:String;
  LivelloAutorizzazione,LivSetDato:Integer;
  function FormattaDatiRichiesta: String;
  begin
    // formatta la richiesta
    Result:=Format('Richiesta effettuata da %s (%s) il %s',
                   [W024DM.selT065.FieldByName('NOMINATIVO').AsString,
                    W024DM.selT065.FieldByName('MATRICOLA').AsString,
                    W024DM.selT065.FieldByName('DATA_RICHIESTA').AsString]) + CRLF +
            'Data: ' + FormatDateTime('mm/yyyy',W024DM.selT065.FieldByName('DATA').AsDateTime) + CRLF +
            'Tipo: ' + W024DM.selT065.FieldByName('Desc_Tipo').AsString;
  end;
begin
  if FOperazione = 'M' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;
  Aut:=Sender = btnTuttiSi;
  // inizializzazione variabili
  ErrModCan:=False;
  RichOltreLimiti:=False;
  RichAZero:=False;
  RichDaValid:=False;
  // autorizzazione richieste
  // niente refresh: autorizza solo ciò che è visualizzato nella pagina
  W024DM.selT065.First;
  while not W024DM.selT065.Eof do
  begin
    try
      C018.CodIter:=W024DM.selT065.FieldByName('COD_ITER').AsString;
      C018.Id:=W024DM.selT065.FieldByName('ID').AsInteger;
      LivelloAutorizzazione:=W024DM.selT065.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
      if C018.EsisteFase[T065FASE_VALIDAZIONE] then
        LivSetDato:=C018.FaseLivello[LivelloAutorizzazione]
      else
        LivSetDato:=1;
      try
        if Aut and
           (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and
           (   ((R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString) > 0) and
                (R180OreMinutiExt(W024DM.selT065.FieldByName('CF_RES_ORE_COMP_ANNO').AsString) < 0))
            or ((R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString) > 0) and
                (R180OreMinutiExt(W024DM.selT065.FieldByName('CF_RES_ORE_LIQ_ANNO').AsString) < 0))) then
          RichOltreLimiti:=True
        else if (W024DM.selT065.FieldByName('D_TIPO_RICHIESTA').AsString = 'A')
        and C018.EsisteFase[T065FASE_VALIDAZIONE] then
          RichDaValid:=True
        else if (not Aut)
             or (R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString) <> 0)
             or (R180OreMinutiExt(W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString) = 0) then
        begin
          try
            C018.SetDatoAutorizzatore('ORE_ECCEDENTI',W024DM.selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString,LivSetDato);
            C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',W024DM.selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString,LivSetDato);
            C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString,LivSetDato);
            if FGestioneCausale then
            begin
              C018.SetDatoAutorizzatore('CAUSALE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString,LivSetDato);
              C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,LivSetDato);
            end
            else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
            begin
              C018.SetDatoAutorizzatore('CAUSALE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString,LivSetDato);
              C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,LivSetDato);
              C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP',W024DM.selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString,LivSetDato);
              C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ',W024DM.selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString,LivSetDato);
            end;
            LivelloAutorizzazione:=C018.InsAutorizzazione(LivelloAutorizzazione,IfThen(Aut,C018SI,C018NO),Parametri.Operatore,'','',True);
            if C018.MessaggioOperazione <> '' then
              raise Exception.Create(C018.MessaggioOperazione);

            if not Aut then
              C018.SetTipoRichiesta('N')
            else if LivelloAutorizzazione >= C018.LivMaxObb then
              C018.SetTipoRichiesta('S')
            else
              C018.SetTipoRichiesta('I'); //A?

            W024DM.selT065.RefreshOptions:=[roAllFields];
            W024DM.selT065.RefreshRecord;
            W024DM.selT065.RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
            if LivelloAutorizzazione >= C018.LivMaxObb then
              AggiornamentoSchedaRiepilogativa(Aut);
            SessioneOracle.Commit;
          except
            on E: Exception do
            begin
              // messaggio bloccante
              SessioneOracle.Commit;
              MsgBox.MessageBox('Impostazione dell''autorizzazione fallita!' + CRLF +
                                'Motivo: ' + E.Message + CRLF + CRLF +
                                FormattaDatiRichiesta,ESCLAMA);
              W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per riga in meno
              VisualizzaDipendenteCorrente;
              Exit;
            end;
          end;
        end
        else
          RichAZero:=True;
      except
        // errore probabilmente dovuto a record modificato / cancellato da altro utente
        on E:Exception do
        begin
          ErrModCan:=True;
        end;
      end;
    finally
      W024DM.selT065.Next;
    end;
  end;

  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per righe autorizzate
  VisualizzaDipendenteCorrente;
  if ErrModCan then
    Messaggio:='Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.';
  if RichOltreLimiti then
    Messaggio:=Messaggio + IfThen(Messaggio <> '',CRLF) + 'Alcune richieste non sono state considerate per l''autorizzazione in quanto è stato superato il limite annuale.';
  if RichAZero then
    Messaggio:=Messaggio + IfThen(Messaggio <> '',CRLF) + 'Alcune richieste non sono state considerate per l''autorizzazione in quanto sarebbero state autorizzate 0 ore. Autorizzare tali richieste singolarmente!';
  if RichDaValid then
    Messaggio:=Messaggio + IfThen(Messaggio <> '',CRLF) + 'Alcune richieste non sono state considerate per l''autorizzazione in quanto le ore richieste non sono state validate. Autorizzare tali richieste singolarmente!';
  if Messaggio <> '' then
    GGetWebApplicationThreadVar.ShowMessage(Messaggio);
end;

procedure TW024FRichiestaStraordinari.btnInserisciClick(Sender: TObject);
begin
  W024DM.selaT065.Close;
  W024DM.selaT065.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W024DM.selaT065.SetVariable('DATA',R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)));
  W024DM.selaT065.Open;
  W024DM.selaT065.Last;

  W024DM.selT065.Append;
  W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W024DM.selT065.FieldByName('DATA').AsDateTime:=R180InizioMese(R180AddMesi(Date,-W024DM.C90_W024MMIndietro));
  W024DM.selT065.FieldByName('ID_CONGUAGLIO').AsInteger:=W024DM.selaT065.FieldByName('ID_CONGUAGLIO').AsInteger + 1;
  W024DM.selT065.FieldByName('TIPO').AsString:='G';
  W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString:=R180MinutiOre(R180OreMinutiExt(W024DM.selaT065.FieldByName('ORE_ECCED_CALC').AsString) - IfThen(W024DM.selaT065.FieldByName('STATO').AsString = 'S',R180OreMinutiExt(W024DM.selaT065.FieldByName('ORE_ECCEDENTI').AsString),0));
  W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString:=W024DM.selT065.FieldByName('ORE_ECCED_CALC').AsString;

  if not C018.WarningRichiesta then
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta)
  else
    ConfermaInsRichiesta;
end;

procedure TW024FRichiestaStraordinari.ConfermaInsRichiesta;
var IdIns:String;
    i:Integer;
    Trovato:Boolean;
begin
  try
    C018.InsRichiesta('R','','');
    if C018.MessaggioOperazione <> '' then
    begin
      W024DM.selT065.Cancel;
      raise Exception.Create(C018.MessaggioOperazione);
    end;
    IdIns:=W024DM.selT065.RowId;
    SessioneOracle.Commit;
  except
    on E:Exception do
    begin
      SessioneOracle.Commit;
      GGetWebApplicationThreadVar.ShowMessage('Inserimento della richiesta fallito!' + CRLF + 'Motivo: ' + E.Message);
      Exit;
    end;
  end;

  C018.Periodo.Estendi(W024DM.selT065.FieldByName('DATA').AsDateTime,W024DM.selT065.FieldByName('DATA').AsDateTime);
  C018.StrutturaSel:=C018STRUTTURA_TUTTE;

  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',IdIns,[]);
  grdRichieste.medpAggiornaCDS(False);

  //lancio l'evento di modifica del nuovo record
  Trovato:=False;
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if grdRichieste.medpCompGriglia[i].CompColonne[0] is TmeIWGrid then
    begin
      if (grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Control is TmeIWImageFile then
      begin
        if ((grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Control as TmeIWImageFile).FriendlyName = IdIns then
        begin
          Trovato:=True;
          Break;
        end;
      end;
    end;
  end;
  if Trovato then
    imgModificaClick(((grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Control as TmeIWImageFile));
end;

procedure TW024FRichiestaStraordinari.ConfermaModRichiesta;
var
  i, Liv, LivSetDato: integer;
  FN:String;
begin
  FN:=W024DM.selT065.RowId;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if not WR000DM.Responsabile then
  begin
    W024DM.selT065.Post;
    C018.SetTipoRichiesta('A');
    C018.SetDataRichiesta;
    Liv:=C018.VerificaRichiestaEsistente('');
    if C018.EsisteFase[T065FASE_VALIDAZIONE] then
      LivSetDato:=C018.FaseLivello[C018.LivMaxObb]
    else
      LivSetDato:=1;
    if Liv >= C018.LivMaxObb then
    begin
      C018.SetTipoRichiesta('S');
      //Alberto 17/10/2012: in caso di autorizzazione automatica registro i dati richiesti sulla T852
      C018.SetDatoAutorizzatore('ORE_ECCEDENTI',(grdRichieste.medpCompCella(i,FColOreEcc,0) as TmeIWEdit).Text,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',(grdRichieste.medpCompCella(i,FColOreComp,0) as TmeIWEdit).Text,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',(grdRichieste.medpCompCella(i,FColOreLiq,0) as TmeIWEdit).Text,LivSetDato);
      if FGestioneCausale then
      begin
        C018.SetDatoAutorizzatore('CAUSALE',Copy((grdRichieste.medpCompCella(i,FColCaus,0) as TmeIWComboBox).Text,1,5),LivSetDato);
        C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text,LivSetDato);
      end
      else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
      begin
        C018.SetDatoAutorizzatore('CAUSALE',W024DM.selT065.FieldByName('CAUSALE').AsString,LivSetDato);
        C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',(grdRichieste.medpCompCella(i,FColOreCaus,0) as TmeIWEdit).Text,LivSetDato);
        C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP',(grdRichieste.medpCompCella(i,FColOreCausComp,0) as TmeIWEdit).Text,LivSetDato);
        C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ',(grdRichieste.medpCompCella(i,FColOreCausLiq,0) as TmeIWEdit).Text,LivSetDato);
      end;
      AggiornamentoSchedaRiepilogativa(True);
    end;
  end;
  try
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage('Inserimento fallito: ' + E.Message);
      W024DM.selT065.Cancel;
    end;
  end;
  grdRichieste.medpBrowse:=True;
  grdRichieste.medpStato:=msBrowse;
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per riga modificata
  VisualizzaDipendenteCorrente;

  //posizionamento su riga appena inserita
  grdRichieste.medpDataSet.Refresh;
  grdRichieste.medpDataSet.Locate('ROWID',FN,[]);
  grdRichieste.medpAggiornaCDS(False);
end;

procedure TW024FRichiestaStraordinari.AnnullaInsRichiesta;
begin
  W024DM.selT065.Cancel;
  //aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.chkAutorizzazioneClick(Sender: TObject);
var i:Integer;
begin
  // blocca se è in corso una modifica
  if FOperazione = 'M' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione di variazione in corso prima di procedere!');
    exit;
  end;

  i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWCheckBox).FriendlyName);

  { TODO : Rivedere per tipologia 5 }
  // verifica limite annuale
  if (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and
     ((Sender as TmeIWCheckBox).Caption = 'Si') and
     (   ((R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_ORE_COMP_AUTORIZ')) > 0) and
          (R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_RES_ORE_COMP_ANNO')) < 0))
      or ((R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_ORE_LIQ_AUTORIZ')) > 0) and
          (R180OreMinutiExt(grdRichieste.medpValoreColonna(i,'CF_RES_ORE_LIQ_ANNO')) < 0))) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Non è possibile autorizzare la richiesta perché è stato superato il limite annuale!');
    Exit;
  end;

  // effettua autorizzazione
  (Sender as TmeIWCheckBox).Checked:=True;
  AutorizzazioneOK((Sender as TmeIWCheckBox).FriendlyName,(W024DM.TipoRichStr = TTipoRichStrRec.BancaOre) or ((Sender as TmeIWCheckBox).Caption = 'Si'));
end;

procedure TW024FRichiestaStraordinari.AutorizzazioneOK(RowidT065:String;Aut:Boolean);
var LivelloAutorizzazione,LivSetDato:Integer;
begin
  // verifica presenza record
  //W024DM.selT065.Refresh; //11/08/2011 Danilo: Remmato per problemi con RichiestaAZero perché lo stato cambia in actModRichiesta
  if not W024DM.selT065.SearchRecord('ROWID',RowidT065,[srFromBeginning]) then
  begin
    W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per riga in meno
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage('Attenzione! La richiesta da autorizzare non è più disponibile!');
    Exit;
  end;

  // salva i dati di autorizzazione
  try
    C018.CodIter:=W024DM.selT065.FieldByName('COD_ITER').AsString;
    C018.Id:=W024DM.selT065.FieldByName('ID').AsInteger;
    LivelloAutorizzazione:=W024DM.selT065.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
    if C018.EsisteFase[T065FASE_VALIDAZIONE] then
      LivSetDato:=C018.FaseLivello[LivelloAutorizzazione]
    else
      LivSetDato:=1;
    C018.SetDatoAutorizzatore('ORE_ECCEDENTI',W024DM.selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString,LivSetDato);
    C018.SetDatoAutorizzatore('ORE_DACOMPENSARE',W024DM.selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString,LivSetDato);
    C018.SetDatoAutorizzatore('ORE_DALIQUIDARE',W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString,LivSetDato);
    if FGestioneCausale then
    begin
      C018.SetDatoAutorizzatore('CAUSALE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,LivSetDato);
    end
    else if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      C018.SetDatoAutorizzatore('CAUSALE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE',W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DACOMP',W024DM.selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString,LivSetDato);
      C018.SetDatoAutorizzatore('ORE_CAUSALIZZATE_DALIQ',W024DM.selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString,LivSetDato);
    end;
    LivelloAutorizzazione:=C018.InsAutorizzazione(LivelloAutorizzazione,IfThen(Aut,C018SI,C018NO),Parametri.Operatore,'','',True);
    if C018.MessaggioOperazione <> '' then
      raise Exception.Create(C018.MessaggioOperazione);

    if not Aut then
      C018.SetTipoRichiesta('N')
    else if LivelloAutorizzazione >= C018.LivMaxObb then
      C018.SetTipoRichiesta('S')
    else
      C018.SetTipoRichiesta('I'); //A?

    W024DM.selT065.RefreshOptions:=[roAllFields];
    W024DM.selT065.RefreshRecord;
    W024DM.selT065.RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
    if LivelloAutorizzazione >= C018.LivMaxObb then
      AggiornamentoSchedaRiepilogativa(Aut);
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      GGetWebApplicationThreadVar.ShowMessage('Impostazione dell''autorizzazione fallita!' + CRLF + 'Motivo: ' + E.Message);
    end;
  end;
  W024DM.AggiornaTotali:=WR000DM.Responsabile and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre);//Aggiornare totali per riga autorizzata
  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.AggiornamentoSchedaRiepilogativa(Aut:Boolean);
var
  OreComp: String;
  LOreCausComp: String;
  OreLiq: String;
  LOreCausLiq: string;
  LMinCausLiq: Integer;
  OreEcc: String;
  OreOld: String;
  LCausale: String;
  LCausaleOreNormali: String;
  LLimiteMMEccLiqDefault: string;
  LLimiteMMEccResDefault: string;
  LSetLimiteRes: Boolean;
begin
  if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
  begin
    //Aggiorno Banca ore liquidata
    W024DM.selT070.Close;
    W024DM.selT070.SetVariable('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
    W024DM.selT070.SetVariable('DATA',W024DM.selT065.FieldByName('DATA').AsDateTime);
    W024DM.selT070.Open;
    if not W024DM.selT070.Eof then
    begin
      OreOld:=W024DM.selT070.FieldByName('ORECOMP_LIQUIDATE').AsString;
      W024DM.selT070.Edit;
      W024DM.selT070.FieldByName('ORECOMP_LIQUIDATE').AsString:=R180MinutiOre(R180OreMinutiExt(W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString) + IfThen(W024DM.selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(W024DM.selT070.FieldByName('ORECOMP_LIQUIDATE').AsString)));
      if W024DM.selT065.FieldByName('TIPO').AsString = 'C' then
        W024DM.selT070.FieldByName('BANCAORE_LIQ_VAR').AsString:='00.00';
      RegistraLog.SettaProprieta('M','T070_SCHEDARIEPIL',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsString,'');
      RegistraLog.InserisciDato('DATA',W024DM.selT065.FieldByName('DATA').AsString,'');
      RegistraLog.InserisciDato('ORECOMP_LIQUIDATE',OreOld,W024DM.selT070.FieldByName('ORECOMP_LIQUIDATE').AsString);
      if W024DM.selT065.FieldByName('TIPO').AsString = 'C' then
        RegistraLog.InserisciDato('BANCAORE_LIQ_VAR',W024DM.selT070.FieldByName('BANCAORE_LIQ_VAR').medpOldValue,W024DM.selT070.FieldByName('BANCAORE_LIQ_VAR').AsString);
      W024DM.selT070.Post;
      RegistraLog.RegistraOperazione;
    end;
    W024DM.selT070.Close;
  end;



  // determina i limiti mensili per aggiornarli (gestione diversa per dipendente / responsabile)
  if WR000DM.Responsabile then
  begin
    OreComp:=W024DM.selT065.FieldByName('CF_ORE_COMP_AUTORIZ').AsString;
    OreLiq:=W024DM.selT065.FieldByName('CF_ORE_LIQ_AUTORIZ').AsString;
    OreEcc:=W024DM.selT065.FieldByName('CF_ORE_ECCED_AUTORIZ').AsString;
    (*
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      // se la causale è inclusa nelle ore normali modifica i limiti
      LCausale:=W024DM.selT065.FieldByName('CAUSALE').AsString;
      LCausaleOreNormali:=VarToStr(WR000DM.selT275Lookup.Lookup('CODICE',LCausale,'ORENORMALI'));
      if TTipoInclusioneOreNormaliRec.IsInclusa(LCausaleOreNormali) then
      begin
        // limite ore compensabili = ore compensabili autorizzate + ore causalizzate da compensare autorizzate
        LOreCausComp:=W024DM.selT065.FieldByName('CF_ORE_CAUS_DACOMP_AUTORIZ').AsString;
        OreComp:=R180MinutiOre(R180OreMinutiExt(OreComp) + R180OreMinutiExt(LOreCausComp));

        // limite ore liquidabili =  ore liquidabili autorizzate + ore causalizzate da liquidare autorizzate
        LOreCausLiq:=W024DM.selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString;
        OreLiq:=R180MinutiOre(R180OreMinutiExt(OreLiq) + R180OreMinutiExt(LOreCausLiq));
      end;
    end;
    *)
  end
  else
  begin
    // dati inseriti in fase di richiesta, per gestire l'autorizzazione automatica
    // con l'aggiornamento della scheda con i dati richiesti
    OreComp:=W024DM.selT065.FieldByName('ORE_DACOMPENSARE').AsString;
    OreLiq:=W024DM.selT065.FieldByName('ORE_DALIQUIDARE').AsString;
    OreEcc:=W024DM.selT065.FieldByName('ORE_ECCEDENTI').AsString;
    (*
    if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    begin
      // se la causale è inclusa nelle ore normali modifica i limiti
      LCausale:=W024DM.selT065.FieldByName('CAUSALE').AsString;
      LCausaleOreNormali:=VarToStr(WR000DM.selT275Lookup.Lookup('CODICE',LCausale,'ORENORMALI'));
      if TTipoInclusioneOreNormaliRec.IsInclusa(LCausaleOreNormali) then
      begin
        // limite ore compensabili = ore compensabili + ore causalizzate da compensare
        LOreCausComp:=W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DACOMP').AsString;
        OreComp:=R180MinutiOre(R180OreMinutiExt(OreComp) + R180OreMinutiExt(LOreCausComp));

        // limite ore compensabili = ore liquidabili + ore causalizzate da liquidare
        LOreCausLiq:=W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString;
        OreLiq:=R180MinutiOre(R180OreMinutiExt(OreLiq) + R180OreMinutiExt(LOreCausLiq));
      end;
    end;
    *)
  end;

  // estrae dal tipo cartellino i flag per impostazione limiti
  R180SetVariable(W024DM.selT025Info,'PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(W024DM.selT025Info,'DATA',R180FineMese(W024DM.selT065.FieldByName('DATA').AsDateTime));
  W024DM.selT025Info.Open;
  if W024DM.selT025Info.RecordCount > 0 then
  begin
    LLimiteMMEccLiqDefault:=W024DM.selT025Info.FieldByName('LIMITE_MM_ECCLIQ_DEFAULT').AsString;
    LLimiteMMEccResDefault:=W024DM.selT025Info.FieldByName('LIMITE_MM_ECCRES_DEFAULT').AsString;
  end
  else
    raise Exception.CreateFmt('Nessuna tipologia di cartellino associata al dipendente al %s',[FormatDateTime('dd/mm/yyyy',R180FineMese(W024DM.selT065.FieldByName('DATA').AsDateTime))]);

  // imposta limite residuabile (banca ore)
  // Per TORINO_CSI_PRV non si setta il limite sulla banca ore
  if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
    LSetLimiteRes:=LLimiteMMEccResDefault <> 'N'
  else
    LSetLimiteRes:=W024DM.TipoRichStr <> TTipoRichStrRec.OreCausalizzate;
  if LSetLimiteRes then
  begin
    W024DM.selT820.Close;
    W024DM.selT820.SetVariable('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
    W024DM.selT820.SetVariable('DATA',W024DM.selT065.FieldByName('DATA').AsDateTime);
    W024DM.selT820.SetVariable('CAUSALE','* B');
    W024DM.selT820.Open;
    if not W024DM.selT820.Eof then
    begin
      W024DM.selT820.Edit;
      W024DM.selT820.FieldByName('LIQUIDABILE').AsString:='N';
      W024DM.selT820.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(IfThen(W024DM.TipoRichStr = TTipoRichStrRec.BancaOre,OreEcc,IfThen(Aut,OreComp,'00.00'))) + IfThen(W024DM.selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(W024DM.selT820.FieldByName('ORE').AsString)));
      RegistraLog.SettaProprieta('M','T820_LIMITIIND',medpCodiceForm,W024DM.selT820,True);
      W024DM.selT820.Post;
      RegistraLog.RegistraOperazione;
    end
    else
    begin
      W024DM.selT820.Insert;
      W024DM.selT820.FieldByName('PROGRESSIVO').AsInteger:=W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger;
      W024DM.selT820.FieldByName('ANNO').AsInteger:=R180Anno(W024DM.selT065.FieldByName('DATA').AsDateTime);
      W024DM.selT820.FieldByName('MESE').AsInteger:=R180Mese(W024DM.selT065.FieldByName('DATA').AsDateTime);
      W024DM.selT820.FieldByName('DAL').AsInteger:=1;
      W024DM.selT820.FieldByName('AL').AsInteger:=31;
      W024DM.selT820.FieldByName('CAUSALE').AsString:='* B';
      W024DM.selT820.FieldByName('LIQUIDABILE').AsString:='N';
      W024DM.selT820.FieldByName('ORE_TEORICHE').AsString:='';
      W024DM.selT820.FieldByName('ORE').AsString:=IfThen(W024DM.TipoRichStr = TTipoRichStrRec.BancaOre,OreEcc,IfThen(Aut,OreComp,'00.00'));
      RegistraLog.SettaProprieta('I','T820_LIMITIIND',medpCodiceForm,W024DM.selT820,True);
      W024DM.selT820.Post;
      RegistraLog.RegistraOperazione;
    end;
  end;

  // imposta limite liquidabile
  //Per TORINO_CSI_PRV non si setta il limite sul liquidabile
  if (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) and (W024DM.TipoRichStr <> TTipoRichStrRec.OreCausalizzate) then
  begin
    W024DM.selT820.Close;
    W024DM.selT820.SetVariable('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
    W024DM.selT820.SetVariable('DATA',W024DM.selT065.FieldByName('DATA').AsDateTime);
    W024DM.selT820.SetVariable('CAUSALE','* L');
    W024DM.selT820.Open;
    if not W024DM.selT820.Eof then
    begin
      W024DM.selT820.Edit;
      W024DM.selT820.FieldByName('LIQUIDABILE').AsString:='S';
      W024DM.selT820.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(IfThen(Aut,OreLiq,'00.00')) + IfThen(W024DM.selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(W024DM.selT820.FieldByName('ORE').AsString)));
      RegistraLog.SettaProprieta('M','T820_LIMITIIND',medpCodiceForm,W024DM.selT820,True);
      W024DM.selT820.Post;
      RegistraLog.RegistraOperazione;
    end
    else
    begin
      W024DM.selT820.Insert;
      W024DM.selT820.FieldByName('PROGRESSIVO').AsInteger:=W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger;
      W024DM.selT820.FieldByName('ANNO').AsInteger:=R180Anno(W024DM.selT065.FieldByName('DATA').AsDateTime);
      W024DM.selT820.FieldByName('MESE').AsInteger:=R180Mese(W024DM.selT065.FieldByName('DATA').AsDateTime);
      W024DM.selT820.FieldByName('DAL').AsInteger:=1;
      W024DM.selT820.FieldByName('AL').AsInteger:=31;
      W024DM.selT820.FieldByName('CAUSALE').AsString:='* L';
      W024DM.selT820.FieldByName('LIQUIDABILE').AsString:='S';
      W024DM.selT820.FieldByName('ORE_TEORICHE').AsString:='';
      W024DM.selT820.FieldByName('ORE').AsString:=IfThen(Aut,OreLiq,'00.00');
      RegistraLog.SettaProprieta('I','T820_LIMITIIND',medpCodiceForm,W024DM.selT820,True);
      W024DM.selT820.Post;
      RegistraLog.RegistraOperazione;
    end;
  end;

  if (W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCaus)
  and not W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').IsNull then
  begin
    W024DM.selT820.Close;
    W024DM.selT820.SetVariable('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
    W024DM.selT820.SetVariable('DATA',W024DM.selT065.FieldByName('DATA').AsDateTime);
    W024DM.selT820.SetVariable('CAUSALE',W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString);
    W024DM.selT820.Open;
    if not W024DM.selT820.Eof then
    begin
      W024DM.selT820.Edit;
      W024DM.selT820.FieldByName('LIQUIDABILE').AsString:='S';
      W024DM.selT820.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(IfThen(Aut,W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,'00.00')) + IfThen(W024DM.selT065.FieldByName('TIPO').AsString = 'C',0,R180OreMinutiExt(W024DM.selT820.FieldByName('ORE').AsString)));
      RegistraLog.SettaProprieta('M','T820_LIMITIIND',medpCodiceForm,W024DM.selT820,True);
      W024DM.selT820.Post;
      RegistraLog.RegistraOperazione;
    end
    else
    begin
      W024DM.selT820.Insert;
      W024DM.selT820.FieldByName('PROGRESSIVO').AsInteger:=W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger;
      W024DM.selT820.FieldByName('ANNO').AsInteger:=R180Anno(W024DM.selT065.FieldByName('DATA').AsDateTime);
      W024DM.selT820.FieldByName('MESE').AsInteger:=R180Mese(W024DM.selT065.FieldByName('DATA').AsDateTime);
      W024DM.selT820.FieldByName('DAL').AsInteger:=1;
      W024DM.selT820.FieldByName('AL').AsInteger:=31;
      W024DM.selT820.FieldByName('CAUSALE').AsString:=W024DM.selT065.FieldByName('CF_CAUSALE_AUTORIZ').AsString;
      W024DM.selT820.FieldByName('LIQUIDABILE').AsString:='S';
      W024DM.selT820.FieldByName('ORE_TEORICHE').AsString:='';
      W024DM.selT820.FieldByName('ORE').AsString:=IfThen(Aut,W024DM.selT065.FieldByName('CF_ORE_CAUS_AUTORIZ').AsString,'00.00');
      RegistraLog.SettaProprieta('I','T820_LIMITIIND',medpCodiceForm,W024DM.selT820,True);
      W024DM.selT820.Post;
      RegistraLog.RegistraOperazione;
    end;
  end;

  // chiude il dataset dei limiti
  W024DM.selT820.Close;

  // alla fine si esegue la procedura personalizzabile T065P_GESTIONESTRAORDINARIO
  W024DM.T065P_GESTIONESTRAORDINARIO.SetVariable('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
  W024DM.T065P_GESTIONESTRAORDINARIO.SetVariable('DATA',W024DM.selT065.FieldByName('DATA').AsDateTime);
  W024DM.T065P_GESTIONESTRAORDINARIO.Execute;

  //In caso di autorizzazione positiva, cancellazione delle richieste ancora pendenti successive, in quanto i saldi sono necessariamente da ricalcolare in seguito alle operazioni di liquidazione.
  if Aut and (W024DM.TipoRichStr <> TTipoRichStrRec.BancaOre) then
  begin
    W024DM.delT065.SetVariable('PROGRESSIVO',W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger);
    W024DM.delT065.SetVariable('DATA',W024DM.selT065.FieldByName('DATA').AsDateTime);
    W024DM.delT065.Execute;
  end;

  if W024DM.TipoRichStr = TTipoRichStrRec.StraordAnnuoCausPagComp then
  begin
    //  le ORE_CAUSALIZZATE_DALIQ devono essere scritte in T074_CAUSPRESFASCE.LIQUIDATO
    //  nelle fasce in cui c'è disponibilità di T074.OREPRESENZA, partendo dalla fascia più alta.
    if WR000DM.Responsabile then
      LOreCausLiq:=W024DM.selT065.FieldByName('CF_ORE_CAUS_DALIQ_AUTORIZ').AsString
    else
      LOreCausLiq:=W024DM.selT065.FieldByName('ORE_CAUSALIZZATE_DALIQ').AsString;
    LMinCausLiq:=R180OreMinutiExt(LOreCausLiq);
    if LMinCausLiq > 0 then
    begin
      W024DM.LiquidaOre(
        W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger,
        W024DM.selT065.FieldByName('DATA').AsDateTime,
        W024DM.selT065.FieldByName('CAUSALE').AsString,
        LMinCausLiq
      );
    end;
  end;

  //Aggiornamento scheda riepilogativa - Solo Aosta Regione per aggiornamento riepilogo presenza per ore supplementari part-time
  if W024DM.TipoRichStr = TTipoRichStrRec.BancaOre then
  begin
    try
      R400:=TR400FCartellinoDtM.Create(nil);
      R400.A027SelAnagrafe:=selAnagrafeW;
      R400.AggiornamentoScheda:=True;
      R400.SoloAggiornamento:=True;
      R400.EludiBloccoRiepiloghi:=True;
      R400.NumGiorniCartolina:=0;
      R400.CartolinaDipendente(W024DM.selT065.FieldByName('PROGRESSIVO').AsInteger,R180Anno(W024DM.selT065.FieldByName('DATA').AsDateTime),R180Mese(W024DM.selT065.FieldByName('DATA').AsDateTime),1,R180GiorniMese(W024DM.selT065.FieldByName('DATA').AsDateTime));
    finally
      FreeAndNil(R400);
    end;
  end
end;

procedure TW024FRichiestaStraordinari.RefreshPage;
begin
  WR000DM.Responsabile:=Tag = 427;
  VisualizzaDipendenteCorrente;
end;

procedure TW024FRichiestaStraordinari.DistruggiOggetti;
begin
  FreeAndNil(W024DM);

  // chiude dataset condivisi
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT275);
    R180CloseDataSetTag0(WR000DM.selT275Lookup);
  end;

  inherited;
end;

procedure TW024FRichiestaStraordinari.ImpostaGrigliaRiepilogo;
begin
  grdRiepilogo.ColumnCount:=3;
  grdRiepilogo.RowCount:=2;
  grdRiepilogo.Cell[0,0].Css:='';
  grdRiepilogo.Cell[0,0].RawText:=True;
  grdRiepilogo.Cell[0,0].Text:='Anno';
  grdRiepilogo.Cell[0,1].Css:='';
  grdRiepilogo.Cell[0,1].RawText:=True;
  grdRiepilogo.Cell[0,1].Text:='Totale ore compensabili' +
                               '<div align="center" class="width100pc">' +
                               '<span>Limite</span>' +
                               '<span>Fruito</span>' +
                               '<span>In attesa</span>' +
                               '<span>Residuo</span>' +
                               '</div>';
  grdRiepilogo.Cell[0,2].Css:='';
  grdRiepilogo.Cell[0,2].RawText:=True;
  grdRiepilogo.Cell[0,2].Text:='Totale ore liquidabili' +
                               '<div align="center" class="width100pc">' +
                               '<span>Limite</span>' +
                               '<span>Fruito</span>' +
                               '<span>In attesa</span>' +
                               '<span>Residuo</span>' +
                               '</div>';
  grdRiepilogo.Cell[1,0].Css:='';
  grdRiepilogo.Cell[1,0].RawText:=True;
  grdRiepilogo.Cell[1,0].Text:=IntToStr(R180Anno(R180AddMesi(Date,-W024DM.C90_W024MMIndietro)));
  grdRiepilogo.Cell[1,1].Css:='';
  grdRiepilogo.Cell[1,1].RawText:=True;
  grdRiepilogo.Cell[1,1].Text:='<div align="center" class="width100pc">' +
                               '<span>' + R180MinutiOre(MinTotAnnuoComp) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotAutComp) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotInAttAutComp) + '</span>' +
                               '<span' + IfThen(FMinResiduiComp < 0,' class="riga_evidenziata"') + '>' + R180MinutiOre(FMinResiduiComp) + '</span>' +
                               '</div>';
  grdRiepilogo.Cell[1,2].Css:='';
  grdRiepilogo.Cell[1,2].RawText:=True;
  grdRiepilogo.Cell[1,2].Text:='<div align="center" class="width100pc">' +
                               '<span>' + R180MinutiOre(MinTotAnnuoLiq) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotAutLiq) + '</span>' +
                               '<span>' + R180MinutiOre(MinTotInAttAutLiq) + '</span>' +
                               '<span' + IfThen(FMinResiduiLiq < 0,' class="riga_evidenziata"') + '>' + R180MinutiOre(FMinResiduiLiq) + '</span>' +
                               '</div>';
end;

end.
