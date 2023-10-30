unit W026URichiestaStrGG;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  W000UMessaggi, W026URichiestaStrGGDM, IWApplication,
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, C018UIterAutDM,
  R450, R500Lin, Rp502Pro, A023UGestMeseMW, A029ULiquidazione,
  StrUtils, DatiBloccati, DBClient, DB, Oracle, OracleData, Variants,
  IWAppForm, SysUtils, Classes, medpIWDBGrid,
  IWHTMLControls, IWVCLBaseControl, IWBaseHTMLControl, IWVCLBaseContainer,
  IWContainer, IWCompCheckBox, Math, IWDBGrids,
  Controls, medpIWMessageDlg, meIWButton, meIWGrid, meIWCheckBox, meIWEdit,
  meIWComboBox, meIWImageFile, IWControl, IWCompEdit,
  medpIWMultiColumnComboBox, IWCompGrids, IWCompExtCtrls, meIWLink,
  IWCompButton, Menus, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWBaseControl, IWCompJQueryWidget;

const
  MAX_SPEZZONI = 3;

  // valori di TIPO_RIGA
  W026_TROW_D = 'D';               // riga letta da database
  W026_TROW_C = 'C';               // riga inserita dai conteggi (calcolata al volo)

type
  TTipoElab = (
    Autorizza,                     // solo autorizzazione
    Applica,                       // applica l'autorizzazione sul cartellino (la rende effettiva)
    AutorizzaApplica               // autorizza la richiesta e la rende effettiva
  );

  // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
  TDatiCartellino = record
    Prog: Integer;                 // progressivo dipendente
    DataInizioMeseCont: TDateTime; // data di inizio del mese (identifica il mese per i conteggi)
    SaldoDisponibile: Integer;     // saldo disponibile del mese (R450.salmeseatt)
    CheckSaldo:Boolean;            //Indica se effetturare o meno il controllo di supero del saldo disponibile
    EccAutAnno:Integer;            //Eccedenza autorizzata annua
    EccLiqAnno:Integer;            //Eccedenza autorizzata liquidata
    RecAutAnno:Integer;            //Recupero autorizzato annuo
    RecMatAnno:Integer;            //Recupero maturato annuo
  end;
  // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  TMotivazioni = record
    Codice: String;
    Descrizione: String;
  end;
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine

  TCausali = record
    Codice: String;
    Descrizione: String;
    InclusioneOre: String;
    Text: String;
    TipoRichiestaWeb: String;
    AbbatteBudget: String;
    NoLimiteAnnualeLiq:String;
    ArrotRiepGG: Integer;
    MinutiMin: Integer;
    MinutiMax: Integer;
  end;

  TRecordRichiesta = record
    Id: Integer;
    Data: TDateTime;
    Spez,
    Dalle1E,
    Alle1E,
    Caus1E,
    AutE,
    Dalle1U,
    Alle1U,
    Caus1U,
    AutU,
    AutT: String;
    DalleT: array[1..MAX_SPEZZONI] of String;
    AlleT: array[1..MAX_SPEZZONI] of String;
    OraT: array[1..MAX_SPEZZONI] of String;
    CausT: array[1..MAX_SPEZZONI] of String;
    Motivazione: String; // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1
    Eliminata:Boolean;
  end;

  TCheckBudget = record
    Causali: String;
    TipoRichiestaWeb: String;
    AbbatteBudget: String;
    NumOre: Integer;
  end;

  TW026FRichiestaStrGG = class(TR013FIterBase)
    dsrT325: TDataSource;
    cdsT325: TClientDataSet;
    cdsGestMese: TClientDataSet;
    cdsGestMeseFLAG_RIGA: TStringField;
    cdsGestMeseFLAG_RIGA_SUBCOD: TIntegerField;
    cdsGestMeseDATA: TDateTimeField;
    cdsGestMeseDATA_CONTEGGI: TDateTimeField;
    cdsGestMeseTIPO: TStringField;
    cdsGestMeseDALLE_H: TStringField;
    cdsGestMeseALLE_H: TStringField;
    cdsGestMeseC_AUTORIZZATO: TStringField;
    cdsGestMeseDESC_CAUSALE: TStringField;
    cdsGestMeseCAUSALE: TStringField;
    cdsGestMeseTOTLAV: TIntegerField;
    cdsGestMeseDEBITOGG: TIntegerField;
    cdsGestMeseSCOST: TIntegerField;
    cdsGestMeseC_TOTLAV_H: TStringField;
    cdsGestMeseC_DEBITOGG_H: TStringField;
    cdsGestMeseC_SCOST_H: TStringField;
    cdsGestMeseCAVALLO_MEZZANOTTE: TStringField;
    cdsGestMeseDATA_ORIG: TDateTimeField;
    cdsGestMeseDALLE_ORIG: TIntegerField;
    cdsGestMeseALLE_ORIG: TIntegerField;
    cdsGestMeseCAUSALE_ORIG: TStringField;
    cdsGestMeseC_ARROT_RIEPGG: TIntegerField;
    cdsGestMeseC_MODIFICATO: TStringField;
    grdRiepilogo: TmeIWGrid;
    edtRiepilogo: TmeIWEdit;
    btnEseguiConteggi: TmeIWButton;
    btnRichiestaCumulativa: TmeIWButton;
    lblSaldoMeseDisp: TmeIWLabel;
    cdsGestMeseID_EVENTO_STR: TIntegerField;
    cdsGestMeseSERVIZIO: TStringField;
    cdsGestMeseSERVIZIO_ORIG: TStringField;
    lblSaldoMese: TmeIWLabel;
    cdsGestMeseID_SPEZZONE_ACCORPATO: TIntegerField;
    btnConfermaAut: TmeIWButton;
    JQuery: TIWJQueryWidget;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnEseguiConteggiClick(Sender: TObject);
    procedure btnRichiestaCumulativaClick(Sender: TObject);
    procedure btnConfermaAutClick(Sender: TObject);
  private
    R502ProDtM1: TR502ProDtM1;
    Richiesta: TRecordRichiesta;
    ArrCausali: array of TCausali;
    EseguiConteggi,RigheBloccate: Boolean;
    ContaRec,ContaPag:Integer;
    StileCella1,StileCella2,CausUnica,CausRecUnica,CausPagUnica,ElencoCausRec,ElencoCausPag: String;
    ListaTimb: TStringList;
    MaxArrotRiepGG, MaxIdDb, SpezzoneMinimo, SogliaEccedenza: Integer;
    W026DM: TW026FRichiestaStrGGDM;
    cdsGrid: TClientDataset; // riferimento veloce al medpDataset della grid delle ecced. gg.
    A023FGestMeseMW: TA023FGestMeseMW;
    EsisteOrarioScorrimento, // gestione MOS
    InsRichFittizio, SalvataggioParziale: Boolean;
    DataInizioModCanc,DataFineModCanc: TDateTime; // TORINO_COMUNE
    DatiCartellino: TDatiCartellino; // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2
    // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
    ArrMotivazioni: array of TMotivazioni;
    MotivazioneDefault: Integer;
    EseguitoInsRichiesta: Boolean;
    // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
    ConfermaAutorizzazioniInCorso: Boolean;
    function  _ArrCausaliGetIndex(const Codice: String; p,r:Integer): Integer; inline;
    function  ArrCausaliGetIndex(const Codice: String): Integer; inline;
    function GetLDatiModificabiliResp(pRiga: integer):Boolean;
    procedure CaricaRecordConteggi(const PInizio, PFine: TDateTime);
    procedure ApriDataset;
    procedure AllineaCdsGrid;
    procedure actInsRichiesta;
    procedure ConfermaInsRichiesta;
    procedure actModRichiesta;
    procedure actCanRichiesta;
    procedure AnnullaInsRichiesta;
    procedure actAutorizzazioneOK(const PTipoElab: TTipoElab);
    procedure ImpostaAutorizzazione(const PTipoElab: TTipoElab; const PTipoSpezzone: String);
    procedure ImportaSuCartellino(const PTipo, PAut, PResp: String); inline;
    procedure ImportaSuT100(const PTipo, PAut, PResp: String);
    procedure ImportaSuT320(const PTipo, PAut, PResp: String);
    procedure ElaboraAnnullamento(const PSpez: String = '');
    procedure chkAutSiNoAsyncClick(Sender: TObject; EventParams: TStringList); // PER PROBLEMI CON IW 10.0.xx: TMEIWCOMBOBOX1IWCL is not defined se combo creato in una sottogrid (usare Grid = False)
    procedure imgIterClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    function  ModificheRiga(const FN: String):Boolean;
    function  CausaleAbilitata(PCausale,PProgressivo,PData:String):Boolean;
    function  Controlli_EU(const FN: String; var RErrMsg: String):Boolean;
    // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
    function  IsRichiestaZeroMinuti(const FN: String): Boolean;
    function  _CtrlLimiteSaldoMese(const FN: String; const POreRec, POrePag: String; var ErrMsg: String): Boolean;
    function  CtrlLimiteSaldoMeseRich(const FN: String; const POreRec, POrePag: String; var ErrMsg: String): Boolean;
    function  CtrlLimiteSaldoMeseAut(const FN: String; var ErrMsg: String): Boolean;
    // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine
    function  Controlli_T(const FN: String; var ErrMsg: String):Boolean;
    function  ControlliBudget(const FN: String; var ErrMsg: String):Boolean;
    function  ControlliOK(const FN: String):Boolean;
    function  ControlliAutOK(const FN: String):Boolean;
    procedure GetDatiTabellari;
    function  GetDiffArr(const Dalle, Alle, Caus: String): Integer;
    procedure TrasformaComponenti(const FN:String; DaTestoAControlli:Boolean);
    procedure BloccaComponenti(const FN:String);
    function  IsRigaInModificaTutti(const FN:String): Boolean;
    function  IsRigaBloccata(const FN:String): Boolean;
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure edtOraAsyncExit(Sender: TObject; EventParams: TStringList);
    // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
    function  GetDatiCartellinoMese(const PProg: Integer; const PDataMese: TDateTime): TDatiCartellino;
    procedure GetDatiAnnualiEccedenza(var DC:TDatiCartellino; R450:TR450DtM1);
    procedure AggiornamentoSchedaRiepilogativa(var DatiCartellino:TDatiCartellino);
    // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine
    procedure RiepilogoTotali;
    procedure W026ApplicaFiltro(Sender: TObject);
    procedure W026ModificaTutto(Sender: TObject);
    procedure W026AnnullaTutto(Sender: TObject);
    procedure W026ConfermaTutto(Sender: Tobject; var Ok: Boolean);
    procedure W026AutorizzaTutto(Sender: Tobject; var Ok: Boolean);
    function  GetRichiesteDaConfermare: Integer;
    procedure AggiornaConteggiT325(const PProg: Integer; const PData: TDateTime);
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

uses W001UIrisWebDtM, W009UStampaCartellinoDtM;

{$R *.DFM}

function TW026FRichiestaStrGG.InizializzaAccesso:Boolean;
var
  Temp: String;
begin
  // controlli bloccanti di accesso sui parametri aziendali
  Result:=False;
  Temp:='Per accedere alla funzione "' + medpNomeFunzione + '"' + CRLF +
        'è necessario impostare il seguente dato aziendale del gruppo IrisWEB: ' + CRLF +
        '%s';
  if Parametri.CampiRiferimento.C90_W026TipoRichiesta = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(Temp,['Web: Iter autorizzativo straordinario']));
    Exit;
  end;
  if Parametri.CampiRiferimento.C90_W026Spezzoni = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(Temp,['Web: Tipo spezzoni straordinario']));
    Exit;
  end;
  if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(Temp,['Web: Tipo autorizzazione straordinario']));
    Exit;
  end;
  if Parametri.CampiRiferimento.C90_W026TipoStraord = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(Temp,['Web: Tipo ore straordinario']));
    Exit;
  end;

  // inizializzazioni
  Result:=True;
  ApplicaFiltroRefreshDipendenti:=True;
  rgpPeriodo.ItemIndex:=IfThen((C018.Periodo.Inizio = Date - 1) and (C018.Periodo.Inizio = C018.Periodo.Fine),0,1);
  if Assigned(@rgpPeriodo.OnAsyncClick) then
    rgpPeriodo.OnAsyncClick(rgpPeriodo,nil)
  else
    rgpPeriodo.OnClick(rgpPeriodo);

  GetDipendentiDisponibili(C018.Periodo.Fine);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  if (WR000DM.Responsabile) or (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end;

  // TORINO_COMUNE - chiamata 75369.ini
  // le richieste parziali di eccedenza fatte per giorni al di fuori
  // del periodo di modifica/cancellazione non vengono visualizzate,
  // al fine di impedire eventuali inoltri di richieste vecchie
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
  begin
    C018.FiltroRichiesta[trTutte]:=Format('(T850.TIPO_RICHIESTA <> ''%s'' or T_ITER.DATA between to_date(''%s'',''dd/mm/yyyy'') and to_date(''%s'',''dd/mm/yyyy''))',
                                          [T325TR_P,FormatDateTime('dd/mm/yyyy',DataInizioModCanc),FormatDateTime('dd/mm/yyyy',DataFineModCanc)]);
    C018.FiltroRichiestaClient[trTutte]:=Format('(TIPO_RICHIESTA <> ''%s'' or (DATA >= %s and DATA <= %s))',
                                                [T325TR_P,FloatToStr(DataInizioModCanc),FloatToStr(DataFineModCanc)]);
  end;
  // TORINO_COMUNE - chiamata 75369.fine

  // imposta variabili dataset principale
  W026DM.selT325Vis.SetVariable('AZIENDA',Parametri.Azienda);
  W026DM.selT325Vis.SetVariable('DATALAVORO',Parametri.DataLavoro);

  // imposta variabili per i dataset di supporto
  W026DM.selT325.SetVariable('DATA1',C018.Periodo.Inizio);
  W026DM.selT325.SetVariable('DATA2',C018.Periodo.Fine);
  W026DM.selT326.SetVariable('DATA1',C018.Periodo.Inizio);
  W026DM.selT326.SetVariable('DATA2',C018.Periodo.Fine);

  // TORINO_COMUNE
  // modalità salvataggi parziali
  SalvataggioParziale:=(Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') and
                       (not WR000DM.Responsabile);

  // impostazione eventi e proprietà
  medpAutorizzaMultiplo:=True;

  //medpEditMultiplo:=True;
  medpEditMultiplo:=R180In(Parametri.CampiRiferimento.C90_W026ModificaTutto,['E','']);
  if Parametri.CampiRiferimento.C90_W026ModificaTutto = 'A' then
    medpEditMultiplo:=WR000DM.Responsabile
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'R' then
    medpEditMultiplo:=not WR000DM.Responsabile;

  OnApplicaFiltro:=W026ApplicaFiltro;
  OnModificaTutto:=W026ModificaTutto;
  OnAnnullaTutto:=W026AnnullaTutto;
  OnConfermaTutto:=W026ConfermaTutto;
  OnAutorizzaTutto:=W026AutorizzaTutto;

  VisualizzaDipendenteCorrente;
end;

procedure TW026FRichiestaStrGG.IWAppFormCreate(Sender: TObject);
var
  DalGG,AlGG:Word;
var
  Oggi,DataInizio,DataFine: TDateTime;
  Msg: String;
begin
  Tag:=IfThen(WR000DM.Responsabile,433,432);
  inherited;
  W026DM:=TW026FRichiestaStrGGDM.Create(Self);
  Iter:=ITER_STRGIORNO;
  EseguitoInsRichiesta:=False;
  ConfermaAutorizzazioniInCorso:=False;

  if WR000DM.Responsabile then
  begin
    C018.PreparaDataSetIter(W026DM.selT325Vis,tiAutorizzazione);
    HelpKeyWord:='W026P1';
  end
  else
  begin
    C018.PreparaDataSetIter(W026DM.selT325Vis,tiRichiesta);
    HelpKeyWord:=IfThen(Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A,'W026P2','W026P0');
  end;

  // il dataset di riferimento è un clientdataset
  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    // ROMA_HSANDREA
    C018.PreparaDataSetIter(W026DM.cdsT325VisEU,tiNone)
  else
    // TORINO_COMUNE
    C018.PreparaDataSetIter(W026DM.cdsT325Vis,tiNone);

  // inizializza variabili
  A023FGestMeseMW:=nil;
  MaxIdDb:=0;
  InsRichFittizio:=False;
  ListaTimb:=TStringList.Create;

  DataInizioModCanc:=R180InizioMese(R180AddMesi(Date,-Parametri.CampiRiferimento.C90_W026MMIndietroDal.ToInteger));
  DataFineModCanc:=R180FineMese(R180AddMesi(Date,-Parametri.CampiRiferimento.C90_W026MMIndietroAl.ToInteger));

  // elementi del filtro periodo
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
  begin
    // TORINO_COMUNE
    rgpPeriodo.Visible:=False;
    lblPeriodoDal.Visible:=True;
  end
  else
  begin
    rgpPeriodo.Visible:=True;
    lblPeriodoDal.Visible:=False;
  end;

  // estrazione dati in array di supporto
  GetDatiTabellari;

  // gestione tabella
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpEditMultiplo:=True;
  grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

  // per spezzoni di tipo EU utilizza un diverso clientdataset
  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    grdRichieste.medpDataSet:=W026DM.cdsT325VisEU
  else
    grdRichieste.medpDataSet:=W026DM.cdsT325Vis;
  cdsGrid:=(grdRichieste.medpDataSet as TClientDataSet);
  grdRichieste.medpRowIDField:='ID';
  cdsGrid.CreateDataSet;
  cdsGrid.LogChanges:=True;

  EsisteOrarioScorrimento:=False; // gestione MOS
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
  begin
    // TORINO_COMUNE
    cdsGestMese.CreateDataset;
    cdsGestMese.LogChanges:=False;

    // gestione MOS.ini - daniloc. 19.01.2012
    W026DM.selT020Scorr.Close;
    W026DM.selT020Scorr.Open;
    EsisteOrarioScorrimento:=(W026DM.selT020Scorr.Fields[0].AsInteger > 0);
    W026DM.selT020Scorr.Close;
    // gestione MOS.fine
  end;

  // indica al programma l'esecuzione iniziale dei conteggi per estrarre i record
  EseguiConteggi:=True;
  btnEseguiConteggi.Visible:=(not WR000DM.Responsabile) or (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A);

  // periodo di abilitazione per richieste
  if not WR000DM.Responsabile then
  begin
    DalGG:=StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoDal,1);
    AlGG:=StrToIntDef(Parametri.CampiRiferimento.C90_W026UtilizzoAl,31);
    Oggi:=Date;
    DataInizio:=EncodeDate(R180Anno(Oggi),R180Mese(Oggi),DalGG);
    if AlGG > R180GiorniMese(Oggi) then
      DataFine:=R180FineMese(Oggi)
    else
      DataFine:=EncodeDate(R180Anno(Oggi),R180Mese(Oggi),AlGG);
    // se il periodo operativo è stato limitato, dà segnalazione all'utente
    if (DalGG > 1) or (AlGG < 31) then
    begin
      if (DebugHook = 0) and ((Oggi < DataInizio) or (Oggi > DataFine)) then
      begin
        // abilita la maschera in lettura ma non consente modifiche
        SolaLettura:=True;
        Msg:=Format('Non è possibile effettuare richieste in data odierna,'#13#10 +
                    'poiché il periodo operativo è limitato dal %d al %s'#13#10 +
                    'Sarà possibile utilizzare questa funzione'#13#10'a partire %s',
                    [R180Giorno(DataInizio),
                     FormatDateTime('dd mmmm yyyy',DataFine),
                     IfThen(Oggi < DataInizio,
                            'da ' + FormatDateTime('dddd dd mmmm',DataInizio),
                            'dal giorno ' + IntToStr(R180Giorno(DataInizio)) + ' del mese prossimo.')]);
        FMsgBox.MessageBox(Msg,ESCLAMA);
      end
      else
      begin
        Msg:=Format('Avviso: il periodo operativo per le richieste è limitato nei giorni dal %d al %d del mese',
                    [R180Giorno(DataInizio),R180Giorno(DataFine)]);
        if DebugHook <> 0 then
          Msg:=Msg+ ' (limitazione non valida in debug)';
        Notifica('Limite periodo',Msg,'',True,False,15000);
      end;
    end;
  end;

  WR000DM.selT275.Tag:=WR000DM.selT275.Tag + 1;
  WR000DM.selAssPres.Tag:=WR000DM.selAssPres.Tag + 1;
end;

procedure TW026FRichiestaStrGG.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  if SolaLettura then
    Exit;

  // richiede conferma se modifica tutti è attivo
  if (grdRichieste.medpStato <> msBrowse) or (InModificaTutti) then
  begin
    Conferma:='Attenzione! L''operazione in corso non è stata confermata.' + CRLF +
              'Vuoi uscire comunque dalla funzione?';
    Exit;
  end;

  // controlli in base a responsabile / richiedente
  if WR000DM.Responsabile then
  begin
    // autorizzatore
    // richiede conferma se sono presenti richieste da rendere effettive su cartellino
    if (grdRichieste.medpStato = msBrowse) and
       (not InModificaTutti) and
       (Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S') and
       (GetRichiesteDaConfermare > 0) then
    begin
      Conferma:='Attenzione!'#13#10 +
                'Sono presenti autorizzazioni da confermare.'#13#10 +
                'Le modifiche non verrano perse, ma sarà necessario'#13#10 +
                'confermarle la volta successiva.'#13#10 +
                'Uscire comunque?';
    end;
  end
  else
  begin
    // richiedente
    // richiede conferma se sono presenti richieste da inoltrare
    if (grdRichieste.medpStato = msBrowse) and
       (not InModificaTutti) and
       (cdsGrid <> nil) and
       (VarToStr(cdsGrid.Lookup('TIPO_RICHIESTA',T325TR_P,'TIPO_RICHIESTA')) = T325TR_P) then
    begin
      Conferma:=Format('Attenzione! Affinché il Responsabile possa procedere'#13#10 +
                       'con l''approvazione delle richieste, è obbligatorio'#13#10 +
                       'confermarle cliccando sul pulsante "%s"'#13#10 +
                       'Vuoi uscire comunque dalla funzione?',
                       [btnRichiestaCumulativa.Caption]);
    end;
  end;
end;

procedure TW026FRichiestaStrGG.RefreshPage;
begin
  WR000DM.Responsabile:=(Tag = 433);
  R180SetVariable(W026DM.selT325Vis,'DATALAVORO',Parametri.DataLavoro);
  VisualizzaDipendenteCorrente;
end;

procedure TW026FRichiestaStrGG.IWAppFormRender(Sender: TObject);
var
  StrTemp: String;
  LDaConfermare: Integer;
const
  DATA_ATTRIBUTE_FMT = 'data-notification-counter=%s';
begin
  // titolo maschera
  if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
    Title:='(W026) Autorizzazione ecced. giornaliere'
  else
  begin
    StrTemp:=IfThen(WR000DM.Responsabile,'Autorizzazione','Gestione');
    Title:=Format('(W026) %s richieste ecced. giornaliere',[StrTemp]);
  end;

  inherited;

  // se la tabella non è in browse blocca la gestione dei filtri
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;
  AbilitazioneComponente(btnEseguiConteggi,not BloccaGestione);

  // modifica tutti
  if btnModificaTutti.Visible then
  begin
    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    begin
      // ROMA_HSANDREA
      btnModificaTutti.Visible:=(C018.TipoRichiesteSel = [trDaEffettuare]) and
                                (grdRichieste.medpStato = msBrowse) and
                                (cdsGrid.RecordCount > 0) and
                                ((WR000DM.Responsabile) or (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A));
    end
    else
    begin
      // TORINO_COMUNE
      btnModificaTutti.Visible:=(grdRichieste.medpStato = msBrowse) and
                                (cdsGrid.RecordCount > 0) and
                                ((not WR000DM.Responsabile) or (C018.TipoRichiesteSel = [trDaAutorizzare])); //###  prima: not WR000DM.Responsabile
    end;
  end;
  btnAnnullatutti.Visible:=InModificaTutti;

  // filtra / esegui conteggi
  btnEseguiConteggi.Visible:=(not SolaLettura) and
                             (not WR000DM.Responsabile) and
                             (not InModificaTutti);

  if btnTuttiSi.Visible then
  begin
    btnTuttiSi.Visible:=(grdRichieste.medpStato = msBrowse) and
                        (cdsGrid.RecordCount > 0) and
                        (not InModificaTutti);
  end;
  btnTuttiNo.Visible:=btnTuttiSi.Visible;

  // conferma autorizzazioni
  // abilitata solo se il corrispondente parametro aziendale è attivo
  btnConfermaAut.Visible:=(not SolaLettura) and
                          (Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S') and
                          (C018.TipoRichiesteSel = [trDaAutorizzare]) and
                          (not InModificaTutti) and
                          ((WR000DM.Responsabile) or (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A)) and
                          (cdsGrid.RecordCount > 0);
  if btnConfermaAut.Visible then
  begin
    LDaConfermare:=GetRichiesteDaConfermare;
    btnConfermaAut.Visible:=LDaConfermare > 0;
    btnConfermaAut.ExtraTagParams.Text:=Format(DATA_ATTRIBUTE_FMT,[LDaConfermare.ToString]);
  end;

  // TORINO_COMUNE
  // richiesta cumulativa
  btnRichiestaCumulativa.Visible:=(grdRichieste.medpStato = msBrowse) and
                                  (not SolaLettura) and // chiamata 75334
                                  (not WR000DM.Responsabile) and
                                  (not InModificaTutti) and
                                  (VarToStr(cdsGrid.Lookup('TIPO_RICHIESTA',T325TR_P,'TIPO_RICHIESTA')) = T325TR_P);

  // tabella di riepilogo totali visibile per tipo straordinario A = abilitato
  AddToInitProc(Format('document.getElementById("%s").style.visibility = "%s";',
                       ['divGrdSaldoMese',
                        IfThen(lblSaldoMeseDisp.Visible,'visible','hidden')]));
end;

function TW026FRichiestaStrGG.GetRichiesteDaConfermare: Integer;
// estrae il numero di richieste autorizzate (o negate) da confermare sul cartellino
// (quelle da autorizzare con tipo richiesta R = effettuata)
var
  LRecNo: Integer;
  LIsAutorizzata: Boolean;
begin
  Result:=0;
  if (not SolaLettura) and
     (Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S') and
     ((WR000DM.Responsabile) or (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A)) and
     (cdsGrid.RecordCount > 0) then
  begin
    LRecNo:=cdsGrid.RecNo;
    try
      try
        cdsGrid.First;
        while not cdsGrid.Eof do
        begin
          if cdsGrid.FieldByName('TIPO_RICHIESTA').AsString = T325TR_R then
          begin
            if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
            begin
              LIsAutorizzata:=cdsGrid.FieldByName('AUTORIZZAZIONE').AsString <> '';
            end
            else if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
            begin
              LIsAutorizzata:=((cdsGrid.FindField('AUTORIZZAZIONE_E') <> nil) and (cdsGrid.FieldByName('AUTORIZZAZIONE_E').AsString <> '')) or
                              ((cdsGrid.FindField('AUTORIZZAZIONE_U') <> nil) and (cdsGrid.FieldByName('AUTORIZZAZIONE_U').AsString <> ''));
            end
            else
              LIsAutorizzata:=False;
            if LIsAutorizzata then
              Result:=Result + 1;
          end;
          cdsGrid.Next;
        end;
      except
        Result:=0;
      end;
    finally
      cdsGrid.RecNo:=LRecNo;
    end;
  end;
end;

procedure TW026FRichiestaStrGG.chkAutSiNoAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i,c,x: Integer;
begin
  // inverte eventualmente il checkbox opposto
  if (Sender as TmeIWCheckBox).Checked then
  begin
    i:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWCheckBox).FriendlyName);
    c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
    x:=IfThen((Sender as TmeIWCheckBox).Caption = 'Si',1,0);
    (grdRichieste.medpCompCella(i,c,x) as TmeIWCheckBox).Checked:=False;
  end;
end;

procedure TW026FRichiestaStrGG.W026ApplicaFiltro(Sender: TObject);
begin
  // reimposta variabili per i dataset di supporto
  R180SetVariable(W026DM.selT325,'DATA1',C018.Periodo.Inizio);
  R180SetVariable(W026DM.selT325,'DATA2',C018.Periodo.Fine);
  R180SetVariable(W026DM.selT326,'DATA1',C018.Periodo.Inizio);
  R180SetVariable(W026DM.selT326,'DATA2',C018.Periodo.Fine);
  VisualizzaDipendenteCorrente;
end;

procedure TW026FRichiestaStrGG.W026ModificaTutto(Sender: TObject);
var
  i: Integer;
begin
  grdRichieste.medpBrowse:=False;
  grdRichieste.medpColonna('DBG_COMANDI').Visible:=False;

  // crea i componenti per tutte le righe
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    if (WR000DM.Responsabile) or
       (R180In(grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA'),[T325TR_I,T325TR_R,T325TR_P])) then
    begin
      TrasformaComponenti(grdRichieste.medpValoreColonna(i,'DBG_ROWID'),True);
    end;
  end;
end;

procedure TW026FRichiestaStrGG.W026AnnullaTutto(Sender: TObject);
var
  i: Integer;
begin
  if RigheBloccate then
  begin
    // alcune righe sono state già inserite: ricarica tutto
    EseguiConteggi:=True;
    IterBaseApplicaFiltro(nil);
  end
  else
  begin
    grdRichieste.medpBrowse:=True;
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=True;
    // crea i componenti per tutte le righe
    for i:=0 to High(grdRichieste.medpCompGriglia) do
      TrasformaComponenti(grdRichieste.medpValoreColonna(i,'DBG_ROWID'),False);
  end;
end;

procedure TW026FRichiestaStrGG.W026ConfermaTutto(Sender: TObject; var Ok: Boolean);
var
  i: Integer;
  FN: String;
  LRichZeroMinuti: Boolean;
  LTipoElab: TTipoElab;
begin
  // blocca operazione se c'è un'operazione pendente
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione in corso prima di procedere!',INFORMA);
    Exit;
  end;

  // conferma di ogni singola riga
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    FN:=grdRichieste.medpValoreColonna(i,'ID');

    // se la riga non è da considerare passa a quella successiva
    if not IsRigaInModificaTutti(FN) then
      Continue;

    if not IsRigaBloccata(FN) then
    begin
      // verifica se la riga è stata modificata
      if ModificheRiga(FN) then
      begin //10.8(9) ASTI_ASL19 171085: il blocco deve essere eseguito anche nel caso di Responsabile con GetLDatiModificabiliResp
        if (not WR000DM.Responsabile) or GetLDatiModificabiliResp(grdRichieste.medpRigaDiCompGriglia(FN)) then
        begin
          // effettua controlli per inserimento o modifica
          if not ControlliOK(FN) then
            Exit;
          cdsGrid.Locate('ID',Richiesta.Id,[]);

          // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
          // per San Giuliano è consentita la richiesta di 0 minuti
          LRichZeroMinuti:=IsRichiestaZeroMinuti(FN);
          // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine

          // esegue inserimento / modifica
          if cdsGrid.FieldByName('TIPO_RICHIESTA').AsString = T325TR_I then
          begin
            // caso possibile solo se Parametri.CampiRiferimento.C90_W026TipoRichiesta = TIPO_RICHIESTA_A
            if not LRichZeroMinuti then
              actInsRichiesta;
          end
          else
          begin
            // caso possibile solo se TIPO_RICHIESTA = T325TR_P (salvataggio parziale)
            if not LRichZeroMinuti then
              actModRichiesta
            else
              actCanRichiesta;
          end;
        end;
        if WR000DM.Responsabile then
        begin //10.8(9) ASTI_ASL19 171085: questo blocco non deve necessariamente alternativo al precedente
          // effettua controlli per autorizzazione
          if not ControlliAutOK(FN) then
            Exit;

          // esegue autorizzazione
          cdsGrid.Locate('ID',Richiesta.Id,[]);

          // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
          if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
            LTipoElab:=TTipoElab.Autorizza
          else
            LTipoElab:=TTipoElab.AutorizzaApplica;

          actAutorizzazioneOK(LTipoElab);
        end;

        // blocca i componenti nella riga e segnala che sono presenti righe bloccate
        BloccaComponenti(FN);
        RigheBloccate:=True;
      end;
    end
    else
    begin
      RigheBloccate:=True;
    end;
  end;
  EseguiConteggi:=True;
  Ok:=True;
end;

procedure TW026FRichiestaStrGG.W026AutorizzaTutto(Sender: TObject; var Ok: Boolean);
var
  LAut: String;
  LErrModCan: Boolean;
  LTipoElab: TTipoElab;
begin
  // inizializzazione variabili
  LErrModCan:=False;
  LAut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);

  // autorizzazione richieste
  cdsGrid.First;
  while not cdsGrid.Eof do
  begin
    // imposta i dati in RecordRichiesta per l'autorizzazione
    Richiesta.Id:=cdsGrid.FieldByName('ID').AsInteger;
    if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
      Richiesta.Spez:=cdsGrid.FieldByName('SPEZ').AsString;

    // imposta autorizzazione spezzone
    Richiesta.AutT:=LAut;
    Richiesta.AutE:=LAut;
    Richiesta.AutU:=LAut;

    Richiesta.Eliminata:=False;

    // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
    if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
      LTipoElab:=TTipoElab.Autorizza
    else
      LTipoElab:=TTipoElab.AutorizzaApplica;

    try
      actAutorizzazioneOK(LTipoElab);
    except
      // errore probabilmente dovuto a record modificato / cancellato da altro utente
      on E: Exception do
        LErrModCan:=True;
    end;
    cdsGrid.Next;
  end;

  // se non ci sono errori imposta il filtro su "Richieste autorizzate"
  // solo per ROMA_HSANDREA
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'N') and
     (not LErrModCan) then
    C018.TipoRichiesteSel:=[trAutorizzate];

  Ok:=True;
  if LErrModCan then
    MsgBox.MessageBox('Alcune richieste non sono state considerate per l''autorizzazione ' +
                      'in quanto modificate nel frattempo o non più disponibili.',ESCLAMA);
end;

procedure TW026FRichiestaStrGG.GetDatiTabellari;
var
  i: Integer;
begin
  // array per le causali di presenza
  WR000DM.selT275.Close;
  WR000DM.selT275.Filtered:=True;
  WR000DM.selT275.Open;
  WR000DM.selT275.First;
  SetLength(ArrCausali,WR000DM.selT275.RecordCount + 1);
  ContaRec:=0;
  ContaPag:=0;
  // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini
  CausUnica:='';
  // MONDOEDP - commessa MAN/07 SVILUPPO#68.fine
  ElencoCausRec:='';
  ElencoCausPag:='';
  CausRecUnica:='';
  CausPagUnica:='';
  i:=1;
  MaxArrotRiepGG:=Parametri.CampiRiferimento.C90_W026Arrotondamento.ToInteger;
  SpezzoneMinimo:=999;
  while not WR000DM.selT275.Eof do
  begin
    ArrCausali[i].Codice:=WR000DM.selT275.FieldByName('CODICE').AsString;
    ArrCausali[i].Descrizione:=WR000DM.selT275.FieldByName('DESCRIZIONE').AsString;
    ArrCausali[i].Text:=Format('%-5s %s',[WR000DM.selT275.FieldByName('CODICE').AsString,WR000DM.selT275.FieldByName('DESCRIZIONE').AsString]);
    ArrCausali[i].TipoRichiestaWeb:=WR000DM.selT275.FieldByName('TIPO_RICHIESTA_WEB').AsString;
    ArrCausali[i].AbbatteBudget:=WR000DM.selT275.FieldByName('ABBATTE_BUDGET').AsString;
    ArrCausali[i].NoLimiteAnnualeLiq:=WR000DM.selT275.FieldByName('NO_LIMITE_ANNUALE_LIQ').AsString;
    ArrCausali[i].InclusioneOre:=WR000DM.selT275.FieldByName('ORENORMALI').AsString;
    if R180In(ArrCausali[i].TipoRichiestaWeb,['P','R']) then
      SpezzoneMinimo:=Min(SpezzoneMinimo,WR000DM.selT275.FieldByName('MINMINUTI').AsInteger);
    if WR000DM.selT275.RecordCount = 1 then
      CausUnica:=ArrCausali[i].Codice;
    if ArrCausali[i].TipoRichiestaWeb = 'R' then
    begin
      CausRecUnica:=ArrCausali[i].Codice;
      ElencoCausRec:=ElencoCausRec + CausRecUnica + ',';
      ContaRec:=ContaRec + 1;
    end
    else if ArrCausali[i].TipoRichiestaWeb = 'P' then
    begin
      CausPagUnica:=ArrCausali[i].Codice;
      ElencoCausPag:=ElencoCausPag + CausPagUnica + ',';
      ContaPag:=ContaPag + 1;
    end;
    if WR000DM.selT275.FieldByName('ARROT_RIEPGG').IsNull then
    begin
      ArrCausali[i].ArrotRiepGG:=0;
    end
    else
    begin
      ArrCausali[i].ArrotRiepGG:=R180OreMinutiExt(WR000DM.selT275.FieldByName('ARROT_RIEPGG').AsString);
      (*
      // determina il max(ARROT_RIEP_GG) delle causali con TIPO_RICHIESTA_WEB in ('P','R')
      // che rappresenta lo spezzone minimo che il dipendente può richiedere
      if (ArrCausali[i].ArrotRiepGG > MaxArrotRiepGG) and
         (Parametri.CampiRiferimento.C90_W026EccedGGTutta <> 'N') and
         (R180In(ArrCausali[i].TipoRichiestaWeb,['P','R'])) then
        MaxArrotRiepGG:=ArrCausali[i].ArrotRiepGG;
      *)
    end;
    // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
    if WR000DM.selT275.FieldByName('MINMINUTI').IsNull then
      ArrCausali[i].MinutiMin:=0
    else
      ArrCausali[i].MinutiMin:=WR000DM.selT275.FieldByName('MINMINUTI').AsInteger;
    if WR000DM.selT275.FieldByName('MAXMINUTI').IsNull then
      ArrCausali[i].MinutiMax:=MaxInt
    else
      ArrCausali[i].MinutiMax:=WR000DM.selT275.FieldByName('MAXMINUTI').AsInteger;
    // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine
    WR000DM.selT275.Next;
    i:=i + 1;
  end;
  if SpezzoneMinimo = 999 then
    SpezzoneMinimo:=1;
  SpezzoneMinimo:=max(SpezzoneMinimo,Parametri.CampiRiferimento.C90_W026SpezzoneMinimo.ToInteger);
  SogliaEccedenza:=StrToIntDef(Parametri.CampiRiferimento.C90_W026SogliaEccedenza,0);

  if ElencoCausRec <> '' then
    ElencoCausRec:=Copy(ElencoCausRec,1,Length(ElencoCausRec) - 1);
  if ElencoCausPag <> '' then
    ElencoCausPag:=Copy(ElencoCausPag,1,Length(ElencoCausPag) - 1);
  WR000DM.selT275.Filtered:=False;
  W026DM.MaxArrotRiepGG:=MaxArrotRiepGG;

  // TORINO_COMUNE: errore se non ci sono causali impostate come recupero / pagamento
  if ((Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T')) and
     ((ContaRec = 0) or (ContaPag = 0)) then
  begin
    if (ContaRec = 0) and (ContaPag = 0) then
      raise Exception.Create('Nessuna causale di presenza è definita come causale di recupero o di pagamento!');
    (*
    else if ContaRec = 0 then
      raise Exception.Create('Nessuna causale di presenza è definita come causale di recupero!')
    else
      raise Exception.Create('Nessuna causale di presenza è definita come causale di pagamento!');
    *)
  end;
  if ContaRec > 1 then
    CausRecUnica:='';
  if ContaPag > 1 then
    CausPagUnica:='';

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  // array per le motivazioni della richiesta
  MotivazioneDefault:=-1;
  R180SetVariable(W026DM.selT106,'TIPO','T325');
  W026DM.selT106.Open;
  W026DM.selT106.First;
  SetLength(ArrMotivazioni,W026DM.selT106.RecordCount);
  i:=0;
  while not W026DM.selT106.Eof do
  begin
    ArrMotivazioni[i].Codice:=W026DM.selT106.FieldByName('CODICE').AsString;
    ArrMotivazioni[i].Descrizione:=W026DM.selT106.FieldByName('DESCRIZIONE').AsString;
    if W026DM.selT106.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      MotivazioneDefault:=i;
    W026DM.selT106.Next;
    i:=i + 1;
  end;
  W026DM.selT106.Close;
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
end;

procedure TW026FRichiestaStrGG.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=(WR000DM.Responsabile) or (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A);
  inherited;
end;

function TW026FRichiestaStrGG.GetLDatiModificabiliResp(pRiga: integer): Boolean;
var
  LivAut: Integer;
begin
  Result:=False;
  if WR000DM.Responsabile then
  begin
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(pRiga,'LIVELLO_AUTORIZZAZIONE'),-1);
    C018.CodIter:=grdRichieste.medpValoreColonna(pRiga,'COD_ITER');
    Result:=C018.ModificaValori(LivAut);
  end;
end;

function TW026FRichiestaStrGG._ArrCausaliGetIndex(const Codice: String; p,r:Integer): Integer;
// Funzione di ricerca dicotomica per l'array delle causali
var
  q, Res: Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < ArrCausali[q].Codice) then
      Res:=_ArrCausaliGetIndex(Codice,p,q - 1);
    if (Codice > ArrCausali[q].Codice) then
      Res:=_ArrCausaliGetIndex(Codice,q + 1,r);
    if (Codice = ArrCausali[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrCausali[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
end;

function TW026FRichiestaStrGG.ArrCausaliGetIndex(const Codice: String): Integer;
begin
  Result:=_ArrCausaliGetIndex(Codice,0,High(ArrCausali));
end;

procedure TW026FRichiestaStrGG.ApriDataset;
// apre il dataset delle richieste e i dataset di supporto per gli aggiornamenti
var
  LFiltroAnag: String;
  LFiltroAnagClient: String;
  LFiltroPeriodo: String;
  LFiltroVis: String;
  LFiltroClient: String;
  LNomeCampo: String;
  S: String;
  LRiapriDataset: Boolean;
  i: Integer;
begin
  // determina filtri
  LFiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger.ToString);
  LFiltroAnagClient:=IfThen(TuttiDipSelezionato,'','PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger.ToString);

  if (C018.TipoRichiesteSel = [trDaEffettuare]) and
     (Parametri.CampiRiferimento.C90_W026TipoRichiesta <> W026_PAR_TIPORICHIESTA_A) then
  begin
    LFiltroAnag:=''; // condizione sempre False
    LFiltroPeriodo:='';
  end
  else
    LFiltroPeriodo:=C018.Periodo.Filtro;
  LFiltroVis:=C018.FiltroRichieste;

  LRiapriDataset:=(LFiltroAnag <> VarToStr(W026DM.selT325Vis.GetVariable('FILTRO_ANAG'))) or
                  (LFiltroPeriodo <> VarToStr(W026DM.selT325Vis.GetVariable('FILTRO_PERIODO'))) or
                  (LFiltroVis <> VarToStr(W026DM.selT325Vis.GetVariable('FILTRO_VISUALIZZAZIONE')));
  DebugClear;
  if (LRiapriDataset) or (not W026DM.selT325Vis.Active) then
  begin
    W026DM.selT325Vis.Close;
    if W026DM.selT325Vis.VariableIndex('FILTRO_ANAG') >= 0 then
      W026DM.selT325Vis.SetVariable('FILTRO_ANAG',LFiltroAnag);
    if W026DM.selT325Vis.VariableIndex('FILTRO_PROGRESSIVI') >= 0 then
    begin
      LFiltroAnag:='T030A.PROGRESSIVO in (' + ElencoProgressivi + ')';
      W026DM.selT325Vis.SetVariable('FILTRO_PROGRESSIVI',LFiltroAnag);
    end;
    W026DM.selT325Vis.SetVariable('FILTRO_PERIODO',LFiltroPeriodo);
    W026DM.selT325Vis.SetVariable('FILTRO_VISUALIZZAZIONE',LFiltroVis);
    W026DM.selT325Vis.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    W026DM.selT325Vis.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    R013Open(W026DM.selT325Vis);
  end
  else
  begin
    W026DM.selT325Vis.Refresh;
  end;

  // pulisce clientdataset in base all'operazione richiesta
  cdsGrid.OnCalcFields:=nil;
  cdsGrid.AfterScroll:=nil;
  cdsGrid.Filtered:=False;

  if EseguiConteggi then
    // svuota completamente dataset
    cdsGrid.EmptyDataSet
  else
  begin
    // rimuove i record caricati da database
    cdsGrid.First;
    try
      while cdsGrid.Locate('TIPO_RIGA',W026_TROW_D,[]) do
      begin
        cdsGrid.Delete;
      end;
    except
      on E: Exception do
      begin
        // in caso di errori (es. "Operation not applicable")
        // svuota il dataset e predispone il riconteggio degli spezzoni
        EseguiConteggi:=True;
        cdsGrid.EmptyDataSet;
      end;
    end;
  end;

  // inserisce nel clientdataset i record del dataset riaperto
  try
    W026DM.selT325Vis.First;
    while not W026DM.selT325Vis.Eof do
    begin
      cdsGrid.Insert;
      // inserisce tutti i campi del dataset principale
      for i:=0 to W026DM.selT325Vis.FieldCount - 1 do
      begin
        LNomeCampo:=W026DM.selT325Vis.Fields[i].FieldName;
        if cdsGrid.FindField(LNomeCampo) <> nil then
        begin
          cdsGrid.FieldByName(LNomeCampo).Value:=W026DM.selT325Vis.Fields[i].Value;
          // determina il valore ID più alto
          if (LNomeCampo = 'ID') and
             (W026DM.selT325Vis.Fields[i].AsInteger > MaxIdDb) then
            MaxIdDb:=W026DM.selT325Vis.Fields[i].AsInteger;
        end;
      end;
      cdsGrid.FieldByName('TIPO_RIGA').AsString:=W026_TROW_D; // tipo riga 'D' = da database
      cdsGrid.Post;
      W026DM.selT325Vis.Next;
    end;

    // applica i filtri al clientdataset se non sono stati rieseguiti i conteggi
    //if not EseguiConteggi then // daniloc 08.06.2012 per S.Andrea
    begin
      S:=C018.Periodo.FiltroClient;
      LFiltroClient:=LFiltroAnagClient + IfThen((LFiltroAnagClient <> '') and (S <> ''),' and ') + S;
      S:=C018.FiltroRichiesteClient;
      LFiltroClient:=LFiltroClient + IfThen((LFiltroClient <> '') and (S <> ''),' and ') + S;
      cdsGrid.Filter:=LFiltroClient;
      cdsGrid.Filtered:=True;
    end;
  finally
    cdsGrid.AfterScroll:=W026DM.cdsT325VisAfterScroll;
    cdsGrid.OnCalcFields:=W026DM.cdsT325VisCalcFields;
  end;
end;

procedure TW026FRichiestaStrGG.CaricaRecordConteggi(const PInizio, PFine: TDateTime);
var
  D: TDateTime;
  i,IniSpez,FineSpez,Prog,DurataSpez,EccDisponibile: Integer;
  T,OldT: String;
  OrarioScorrimento: Boolean; // gestione MOS
  procedure ImpostaCampiT325(Id: Integer; D: TDateTime);
  var
    S,Temp: String;
    Ritardo,i: Integer;
  begin
    cdsGrid.FieldByName('ID').AsInteger:=MaxIdDb; // ID fittizio
    cdsGrid.FieldByName('TIPO_RIGA').AsString:=W026_TROW_C; // 'C' = inserita dai conteggi
    cdsGrid.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    cdsGrid.FieldByName('MATRICOLA').AsString:=selAnagrafeW.FieldByName('MATRICOLA').AsString;
    cdsGrid.FieldByName('NOMINATIVO').AsString:=selAnagrafeW.FieldByName('COGNOME').AsString + ' ' + selAnagrafeW.FieldByName('NOME').AsString;
    cdsGrid.FieldByName('TIPO_RICHIESTA').AsString:=T325TR_I;
    cdsGrid.FieldByName('DATA').AsDateTime:=D;
    // gestione elenco timbrature del giorno
    Temp:='';
    for i:=0 to High(R502ProDtM1.TimbratureDelGiorno) do
    begin
      // ROMA_HSANTANDREA - chiamata 75471.ini
      // in caso di turno a cavallo di mezzanotte esclude dal giorno
      // la prima timbratura di uscita (che viene riportata sul giorno precedente)
      if (i = 0) and (R502ProDtM1.primat_u = 'si') then
        Continue;
      // ROMA_HSANTANDREA - chiamata 75471.fine

      if R502ProDtM1.TimbratureDelGiorno[i].tversotimb <> '' then
      begin
        if Temp <> '' then
          Temp:=Temp + ' ';
        S:=R502ProDtM1.TimbratureDelGiorno[i].tversotimb +
           R180MinutiOre(R502ProDtM1.TimbratureDelGiorno[i].toratimb) +
           IfThen(R502ProDtM1.TimbratureDelGiorno[i].tcaustimb <> '',
                  '(' + R502ProDtM1.TimbratureDelGiorno[i].tcaustimb + ')');
        Temp:=Temp + S;
      end;
    end;
    // ROMA_HSANTANDREA - chiamata 75471.ini
    // in caso di turno a cavallo di mezzanotte include nel giorno
    // la prima timbratura di uscita (che viene riportata sul giorno precedente)
    if R502ProDtM1.ultimt_e = 'si' then
    begin
      S:=R502ProDtM1.verso_suc +
         R180MinutiOre(R502ProDtM1.minuti_suc) +
         IfThen(R502ProDtM1.caus_suc <> '',
                '(' + R502ProDtM1.caus_suc + ')');
      Temp:=Temp + ' ' + S;
    end;
    // ROMA_HSANTANDREA - chiamata 75471.fine

    //TORINO_CITTADELLASALUTE: Giustificativi di assenza da considerare nelle eccedenze
    for i:=0 to High(R502ProDtM1.GiustificativiDelGiorno) do
    begin
      if (R502ProDtM1.ValStrT265[R502ProDtM1.GiustificativiDelGiorno[i].tcausgius,'ITER_ECCGG'] = 'S') and
         (R502ProDtM1.GiustificativiDelGiorno[i].ttipogius = 'D')
      then
      begin
        if Temp <> '' then
          Temp:=Temp + ' ';
        S:='G' + R180MinutiOre(R502ProDtM1.GiustificativiDelGiorno[i].tdallegius) + '-' + R180MinutiOre(R502ProDtM1.GiustificativiDelGiorno[i].tallegius);
        Temp:=Temp + S;
      end;
    end;

    cdsGrid.FieldByName('TIMBRATURE').AsString:=Temp;
    cdsGrid.FieldByName('ORE_LORDE').AsString:=R180MinutiOre(R502ProDtM1.OreReseTotali + R502ProDtM1.ProlungamentoNonCausalizzato['']);
    cdsGrid.FieldByName('ORE_CONTEGGIATE').AsString:=R180MinutiOre(R502ProDtM1.OreReseTotali);
    cdsGrid.FieldByName('DEBITO').AsString:=R180MinutiOre(R502ProDtM1.debitogg);
    cdsGrid.FieldByName('DETR_MENSA').AsString:=R180MinutiOre(R502ProDtM1.paumendet);
    Ritardo:=0;
    for i:=1 to R502ProDtM1.n_timbrnom do
      Ritardo:=Ritardo + R502ProDtM1.ttimbraturenom[i].Ritardo;
    cdsGrid.FieldByName('RITARDO').AsString:=R180MinutiOre(Ritardo);
  end;
  procedure AccorpaRecordsContigui;
  var i,j,{Inizio,}Fine:Integer;
  begin
    //Verifico se posso accorpare i records contigui
    //Assegnazione id iniziali
    cdsGestMese.First;
    while not cdsGestMese.Eof do
    begin
      cdsGestMese.Edit;
      cdsGestMese.FieldByName('ID_SPEZZONE_ACCORPATO').AsInteger:=cdsGestMese.RecNo;
      cdsGestMese.Post;
      cdsGestMese.Next;
    end;

    //Per ogni record, ricerca di records contigui tra quelli successivi
    for i:=1 to cdsGestMese.RecordCount do
    begin
      if cdsGestMese.Locate('ID_SPEZZONE_ACCORPATO',i,[]) then
      begin
        if (Parametri.CampiRiferimento.C90_W026EccedOltreDebito = 'S') and
           (R502ProDtM1.ValStrT275[cdsGestMese.FieldByName('CAUSALE_ORIG').AsString,'ORENORMALI'] = 'A') then
          Continue;
        //Inizio:=cdsGestMese.FieldByName('DALLE_ORIG').AsInteger;
        Fine:=cdsGestMese.FieldByName('ALLE_ORIG').AsInteger;

        for j:=i + 1 to cdsGestMese.RecordCount do
          if cdsGestMese.Locate('ID_SPEZZONE_ACCORPATO',j,[]) then
          begin
            if (Parametri.CampiRiferimento.C90_W026EccedOltreDebito = 'S') and
               (R502ProDtM1.ValStrT275[cdsGestMese.FieldByName('CAUSALE_ORIG').AsString,'ORENORMALI'] = 'A') then
              Continue;
            if (Fine = cdsGestMese.FieldByName('DALLE_ORIG').AsInteger) then
            begin
              Fine:=cdsGestMese.FieldByName('ALLE_ORIG').AsInteger;
              cdsGestMese.Edit;
              cdsGestMese.FieldByName('ID_SPEZZONE_ACCORPATO').AsInteger:=-cdsGestMese.FieldByName('ID_SPEZZONE_ACCORPATO').AsInteger;
              cdsGestMese.Post;
            end;
          end;

        cdsGestMese.Locate('ID_SPEZZONE_ACCORPATO',i,[]);
        cdsGestMese.Edit;
        cdsGestMese.FieldByName('ALLE_ORIG').AsInteger:=Fine;
        cdsGestMese.FieldByName('ALLE_H').AsString:=R180MinutiOre(Fine);
        cdsGestMese.Post;
      end;
    end;
    //Cancellazione records che sono stati accorpati
    cdsGestMese.First;
    while not cdsGestMese.Eof do
    begin
      if cdsGestMese.FieldByName('ID_SPEZZONE_ACCORPATO').AsInteger < 0 then
        cdsGestMese.Delete
      else
        cdsGestMese.Next;
    end;
  end;
  function CreaNuovoRecord: Boolean;
  var
    i: Integer;
    BloccoRiep: Boolean;
    DataBlocco: TDateTime;
  begin
    Result:=False;
    if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
    begin
      // TORINO_COMUNE
      // ciclo su spezzoni abilitati
      cdsGestMese.EmptyDataset;
      cdsGestMese.Filter:='';
      cdsGestMese.Filtered:=False;

      // se blocco riepiloghi non effettua i conteggi
      DataBlocco:=R180InizioMese(D);
      BloccoRiep:=WR000DM.selDatiBloccati.DatoBloccato(Prog,DataBlocco,'T070') or
                  WR000DM.selDatiBloccati.DatoBloccato(Prog,D,'T325'); // aggiunto per CSI (blocca se è già stata utilizzata la Gestione Mensile IrisWin) - 15.12.2011
      if BloccoRiep then
        Exit;
      if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione = 'T' then
        BloccoRiep:=BloccoRiep or (WR000DM.SelDatiBloccati.DatoBloccato(Prog,DataBlocco,'T100'));
      if BloccoRiep then
        Exit;

      // gestione MOS.ini - daniloc. 19.01.2012
      // verifica se il profilo orario del dipendente comprende un orario a scorrimento
      OrarioScorrimento:=False;
      if EsisteOrarioScorrimento then
      begin
        //Profilo:=R502ProDtM1.Q430.FieldByName('POrario').AsString;
        R180SetVariable(W026DM.selT221,'PROGRESSIVO',Prog);
        R180SetVariable(W026DM.selT221,'DATARIF',D);
        W026DM.selT221.Open;
        OrarioScorrimento:=W026DM.selT221.Fields[0].AsInteger > 0;
      end;
      A023FGestMeseMW.OrarioScorrimento:=OrarioScorrimento;
      // gestione MOS.fine

      A023FGestMeseMW.PopolaDataset(D);

      cdsGestMese.Filter:='(TIPO = ''GP'' or TIPO = ''P'')';
      cdsGestMese.Filtered:=True;
      Result:=cdsGestMese.RecordCount > 0;

      //TORINO_CITTADELLASLUTE: spezzoni contigui accorpati
      if (Parametri.CampiRiferimento.C90_W026AccorpaSpezzoni = 'S') and
         (cdsGestMese.RecordCount > 1) then
        AccorpaRecordsContigui;
    end
    else if Parametri.CampiRiferimento.C90_W026TipoStraord = 'N' then
    begin
      // ROMA_HSANDREA, GENOVA_HSMARTINO
      // ciclo su spezzoni non abilitati
      for i:=0 to High(R502ProDtM1.SpezzoniNonAbilitati) do
      begin
        if (Parametri.CampiRiferimento.C90_W026Spezzoni <> 'T') and
           (R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez <> 'FO') and
           (R502ProDtM1.SpezzoniNonAbilitati[i].TipoAbil = 'NC') then
        begin
          Result:=True;
          Break;
        end;
      end;
    end;
  end;
begin
  if WR000DM.Responsabile then
    Exit;

  // controllo periodo vuoto
  if C018.Periodo.Vuoto then
  begin
    // segnalazione di periodo non impostato
    raise Exception.Create('E'' necessario impostare il periodo di visualizzazione iniziale' + CRLF +
                           'nella maschera di configurazione dell''iter autorizzativo "Eccedenze giornaliere".');
  end;

  // ciclo di conteggi e corrispondenti inserimenti nel client dataset
  if TuttiDipSelezionato then
    selAnagrafeW.First;

  // imposta i conteggi nel periodo
  R502ProDtM1:=TR502ProDtM1.Create(Self);
  try
    R502ProDtM1.PeriodoConteggi(PInizio,PFine);
    while not selAnagrafeW.Eof do
    begin
      Prog:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
      cdsGrid.OnCalcFields:=nil; // disattiva temporaneamente il calcfields

      // TORINO_COMUNE
      if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
      begin
        // ordinamento default: tipo 'P'(presenze), codice
        WR000DM.selAssPres.SetVariable('ORDINAMENTO','ORDER BY 1 DESC,2');
        WR000DM.selAssPres.Filtered:=True;
        WR000DM.selAssPres.Open;

        // inizializzazione middleware gestione mensile
        if A023FGestMeseMW = nil then
          A023FGestMeseMW:=TA023FGestMeseMW.Create(nil);
        A023FGestMeseMW.Progressivo:=Prog;
        A023FGestMeseMW.R502ProDtM:=R502ProDtM1;
        A023FGestMeseMW.AccessoGiust:=A000GetInibizioni('Tag','401');
        A023FGestMeseMW.Q275:=WR000DM.selT275;
        A023FGestMeseMW.selAssPres:=WR000DM.selAssPres;
        A023FGestMeseMW.cdsGestMese:=cdsGestMese;
      end;

      // dataset di supporto per la ricerca dei giorni da escludere nei conteggi
      W026DM.selT325Search.Close;
      W026DM.selT325Search.SetVariable('PROGRESSIVO',Prog);
      W026DM.selT325Search.SetVariable('DATA1',PInizio);
      W026DM.selT325Search.SetVariable('DATA2',PFine);
      W026DM.selT325Search.Open;

      D:=PInizio;
      while D <= PFine do
      begin
        // esegue i conteggi se non ci sono richieste di tipo
        // - T325TR_R = da autorizzare
        // - T325TR_P = salvataggi parziali (TORINO_COMUNE)
        // - T325TR_E = elaborate
        if (not W026DM.selT325Search.SearchRecord('DATA;TIPO_RICHIESTA',VarArrayOf([D,T325TR_R]),[srFromBeginning])) and
           (not W026DM.selT325Search.SearchRecord('DATA;TIPO_RICHIESTA',VarArrayOf([D,T325TR_P]),[srFromBeginning])) and
           (not W026DM.selT325Search.SearchRecord('DATA;TIPO_RICHIESTA',VarArrayOf([D,T325TR_E]),[srFromBeginning])) then
        begin
          // esegue i conteggi
          R502ProDtM1.ConsideraRichiesteWeb:=False;
          R502ProDtM1.Conteggi('Cartolina',Prog,D);

          { Gallizio 16.10.18: ROMA_HSANTANDREA, se C90_W026IncludiSpezzoniFuoriOrario è 'S'
            devo considerare anche gli spezzoni che risiedono fuori dai punti nominali
            del modello orario. Per farlo cambio il tipo spezzone da FO a E (prima dell'entrata nominale)
            o U (dopo l'uscita nominale) }
          if (Parametri.CampiRiferimento.C90_W026Spezzoni <> 'T') and
             (Parametri.CampiRiferimento.C90_W026IncludiSpezzoniFuoriOrario = 'S') then
          begin
            for i:=0 to High(R502ProDtM1.SpezzoniNonAbilitati) do
            begin
              if (R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez = 'FO') then
              begin
                if (R502ProDtM1.EntrataTeorica >= 0) and
                   (R502ProDtM1.SpezzoniNonAbilitati[i].Inizio < R502ProDtM1.EntrataTeorica) then
                  R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez:='E'
                else if (R502ProDtM1.UscitaTeorica >= 0) and
                        (R502ProDtM1.SpezzoniNonAbilitati[i].Fine > R502ProDtM1.UscitaTeorica) then
                  R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez:='U';
                // Negli altri casi lascio il tipo spezzone a FO, sarà ignorato.
              end;
            end;
          end;

          if (R502ProDtM1.Blocca = 0) and
             (R502ProDtM1.dipinser = 'si') and // 08.08.2011: no operazioni se il dipendente non è in servizio nel giorno in elaborazione
             (IfThen(Parametri.CampiRiferimento.C90_W026TipoStraord = 'N',R502ProDtM1.ProlungamentoNonCausalizzato[''],1) > 0) and
             (CreaNuovoRecord) then
          begin
            if Parametri.CampiRiferimento.C90_W026TipoStraord = 'A' then
              EccDisponibile:=max(0,R502ProDtM1.scost)
            else
              EccDisponibile:=max(0,R502ProDtM1.ProlungamentoNonCausalizzato[''] - R502ProDtM1.CompNeg_UNonCaus);
            // inserimento spezzoni su T326
            if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
            begin
              // spezzoni abilitati (TORINO_COMUNE, SGIULIANOMILANESE_COMUNE)
              //Alberto 07/11/2016: scorro il dataset al contrario per considerare prima gli ultimi spezzoni
              cdsGestMese.Last;
              while not cdsGestMese.Bof do
              begin
                //inserimento solo se spezzone > SPEZZONEMINIMO
                DurataSpez:=cdsGestMese.FieldByName('ALLE_ORIG').AsInteger - cdsGestMese.FieldByName('DALLE_ORIG').AsInteger;
                //Limite all'eccedenza giornaliera
                if Parametri.CampiRiferimento.C90_W026EccedOltreDebito = 'S' then
                begin
                  //Esclusione automatica delle causali escluse dalle ore normali
                  if R502ProDtM1.ValStrT275[cdsGestMese.FieldByName('CAUSALE_ORIG').AsString,'ORENORMALI'] = 'A' then
                    DurataSpez:=0
                  else
                  begin
                    DurataSpez:=min(DurataSpez,EccDisponibile);
                    dec(EccDisponibile,DurataSpez);
                  end;
                end;
                if (DurataSpez >= SpezzoneMinimo) then
                begin
                  // inserimento record testata
                  // ATTENZIONE!! è in rapporto 1:1 con il dettaglio
                  // anche se non è corretto dal punto di vista teorico,
                  // si mantiene questa struttura del db per compatibilità con le altre gestioni
                  cdsGrid.OnCalcFields:=nil; // disattiva temporaneamente il calcfields
                  cdsGrid.Append;
                  inc(MaxIdDb);
                  // parte di t325
                  ImpostaCampiT325(MaxIdDb,D);
                  // parte di t326
                  cdsGrid.FieldByName('TIPO').AsString:='T';
                  cdsGrid.FieldByName('DATA_SPEZ').AsDateTime:=cdsGestMese.FieldByName('DATA').AsDateTime;
                  IniSpez:=cdsGestMese.FieldByName('DALLE_ORIG').AsInteger;
                  FineSpez:=cdsGestMese.FieldByName('ALLE_ORIG').AsInteger;
                  IniSpez:=IniSpez - IfThen(IniSpez >= 1440,1440,0);
                  FineSpez:=FineSpez - IfThen(FineSpez >= 1440,1440,0);
                  if Parametri.CampiRiferimento.C90_W026EccedOltreDebito = 'S' then
                  begin
                    //ASTI_ASL
                    if (DurataSpez < SogliaEccedenza) and (SpezzoneMinimo > 0) then
                    begin
                      DurataSpez:=DurataSpez - SpezzoneMinimo + 1;
                    end;
                    IniSpez:=FineSpez - DurataSpez;
                    //Se spezzone -hh.mm - kk.nn --> (1440 - hh.mm) - kk.nn
                    if IniSpez < 0 then
                      IniSpez:=1440 + IniSpez;
                  end;
                  cdsGrid.FieldByName('SPEZ').AsString:=R180MinutiOre(IniSpez) + '-' + R180MinutiOre(FineSpez);
                  cdsGrid.FieldByName('CAUS_ORIG').AsString:=cdsGestMese.FieldByName('CAUSALE_ORIG').AsString;
                  cdsGrid.Post;
                  cdsGrid.OnCalcFields:=W026DM.cdsT325VisCalcFields; // riattiva il calcfields
                end;
                cdsGestMese.Prior;//Next;
              end;
            end
            else if Parametri.CampiRiferimento.C90_W026TipoStraord = 'N' then
            begin
              // spezzoni non abilitati (ROMA_HSANDREA, GENOVA_HSMARTINO)
              OldT:='';
              for i:=0 to High(R502ProDtM1.SpezzoniNonAbilitati) do
              begin
                // gestione cavallo di mezzanotte
                IniSpez:=R502ProDtM1.SpezzoniNonAbilitati[i].Inizio - IfThen(R502ProDtM1.SpezzoniNonAbilitati[i].Inizio >= 1440,1440,0);
                FineSpez:=R502ProDtM1.SpezzoniNonAbilitati[i].Fine - IfThen(R502ProDtM1.SpezzoniNonAbilitati[i].Fine >= 1440,1440,0);
                DurataSpez:=FineSpez - IniSpez;
                if DurataSpez < 0 then
                  DurataSpez:=1440 + DurataSpez;
                // inserimento solo se spezzone > SPEZZONEMINIMO
                if (DurataSpez < SpezzoneMinimo) then
                  Continue;
                if (Parametri.CampiRiferimento.C90_W026Spezzoni <> 'T') and
                   (R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez <> 'FO') and
                   ((R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez = Parametri.CampiRiferimento.C90_W026Spezzoni) or
                    (Parametri.CampiRiferimento.C90_W026Spezzoni = 'EU')) and
                   (R502ProDtM1.SpezzoniNonAbilitati[i].TipoAbil = 'NC') then
                begin
                  T:=R502ProDtM1.SpezzoniNonAbilitati[i].TipoSpez;

                  if (Pos(T,OldT) > 0) or (OldT = '') then
                  begin
                    // eventuale post del record precedente
                    if cdsGrid.State = dsInsert then
                      cdsGrid.Post;
                    // nuova richiesta
                    cdsGrid.Append;
                    inc(MaxIdDb);
                    // parte di t325
                    ImpostaCampiT325(MaxIdDb,D);
                  end;

                  // parte di t326
                  cdsGrid.FieldByName(Format('ECCEDENZA_%s',[T])).AsString:=R180MinutiOre(R502ProDtM1.SpezzoniNonAbilitati[i].Durata);
                  cdsGrid.FieldByName(Format('DATA_SPEZ_%s',[T])).AsDateTime:=IfThen(R502ProDtM1.SpezzoniNonAbilitati[i].Inizio >= 1440,D + 1,D);
                  cdsGrid.FieldByName(Format('SPEZ_%s',[T])).AsString:=R180MinutiOre(IniSpez) + '-' + R180MinutiOre(FineSpez);
                  OldT:=OldT + T + ',';
                  (*Dovrebbe non essere più utile
                  if (Parametri.CampiRiferimento.C90_W026Spezzoni = 'E') or
                     (Parametri.CampiRiferimento.C90_W026Spezzoni = 'U') then
                    Break;
                  *)
                end;
              end;
              if cdsGrid.State in [dsEdit,dsInsert] then
                cdsGrid.Post;
            end;
          end;
        end;
        D:=D + 1;
      end;
      W026DM.selT325Search.CloseAll;

      // determina se proseguire con il dipendente successivo oppure terminare
      if TuttiDipSelezionato then
        selAnagrafeW.Next
      else
        Break;
    end;
  finally
    try FreeAndNil(R502ProDtM1); except end;
    cdsGrid.OnCalcFields:=W026DM.cdsT325VisCalcFields;
    if cdsGrid.ChangeCount > 0 then
      cdsGrid.MergeChangeLog;
  end;
end;

procedure TW026FRichiestaStrGG.VisualizzaDipendenteCorrente;
  procedure SetDatoVisible(Dato:String);
  begin
    if grdRichieste.medpColonna(Dato) <> nil then
      grdRichieste.medpColonna(Dato).Visible:=not R180In(Dato,Parametri.CampiRiferimento.C90_W026DatiInvisibili.Split([',']));
  end;
var
  LFase, LErrMsg: String;
  LVisColonneE, LVisColonneU: Boolean;
begin
  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  ParametriForm.Dal:=C018.Periodo.Inizio;
  ParametriForm.Al:=C018.Periodo.Fine;

  grdRichieste.medpStato:=msBrowse;
  RigheBloccate:=False;

  // popolamento dataset: record presenti sul db + eventuali record calcolati
  cdsGrid.IndexName:=''; // tenta di risolvere il bug "Operation not applicable" nel ciclo di delete del clientdataset
  try
    LFase:='caricamento delle richieste';
    ApriDataset;
    if EseguiConteggi then
    begin
      // se richiesto effettua i conteggi per aggiungere i record
      // con gli spezzoni che possono essere oggetto di autorizzazione
      LFase:='calcolo delle eccedenze giornaliere';
      CaricaRecordConteggi(C018.Periodo.Inizio,C018.Periodo.Fine);
      EseguiConteggi:=False;
    end;
  except
    on E: Exception do
    begin
      Log('Errore','Errore in fase di ' + LFase,E);
      // ATTENZIONE
      //   non utilizzare MsgBox: in fase di creazione della form può sollevarsi questa eccezione
      //   e il messaggio verrebbe visualizzato sulla form chiamante (non sarebbe pertanto visibile!)
      LErrMsg:=Format('Anomalia nella fase di %s:'#13#10'%s',[LFase,E.Message]);
      // se è già attivo un messagebox genera un alert javascript
      if FMsgBox.IsActive then
        GGetWebApplicationThreadVar.ShowMessage(LErrMsg)
      else
      begin
        FMsgBox.TextIsHTML:=False;
        FMsgBox.MessageBox(LErrMsg,ESCLAMA);
      end;
      Exit;
    end;
  end;
  cdsGrid.IndexName:='idxNomeDataSpez';

  // impostazione tabella
  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
  grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
  grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
  grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
  end;
  grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
  grdRichieste.medpAggiungiColonna('TIPO_RICHIESTA','Stato','',nil);
  grdRichieste.medpAggiungiColonna('DATA','Data','',nil);
  grdRichieste.medpAggiungiColonna('TIMBRATURE','Timbrature','',nil);

  if Parametri.CampiRiferimento.C90_W026TipoStraord = 'N' then
  begin
    //Colonne relative ai dati dei conteggi giornalieri
    grdRichieste.medpAggiungiColonna('ORE_LORDE','Ore lorde','',nil);
    if not WR000DM.Responsabile then
    begin
      grdRichieste.medpAggiungiColonna('ORE_CONTEGGIATE','Ore cont.','',nil);
      grdRichieste.medpAggiungiColonna('DEBITO','Debito','',nil);
      grdRichieste.medpAggiungiColonna('DETR_MENSA','Detr. mensa','',nil);
      grdRichieste.medpAggiungiColonna('RITARDO','Ritardo','',nil);
    end;
    //Valuto se renderle visibili o invisibili in base alla regola aziendale
    SetDatoVisible('ORE_LORDE');
    SetDatoVisible('ORE_CONTEGGIATE');
    SetDatoVisible('DEBITO');
    SetDatoVisible('DETR_MENSA');
    SetDatoVisible('RITARDO');
  end;

  // colonne in base alla tipologia di spezzoni considerati
  if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    // TORINO_COMUNE
    grdRichieste.medpAggiungiColonna('SPEZ','Spezzone','',nil);
    grdRichieste.medpColonna('SPEZ').Visible:=False;
    grdRichieste.medpAggiungiColonna('C_SPEZ','Eccedenza','',nil);
    grdRichieste.medpAggiungiColonna('C_SPEZ_MIN','Minuti ecc.','',nil);
    grdRichieste.medpColonna('C_SPEZ_MIN').Visible:=False;
    grdRichieste.medpAggiungiColonna('C_SPEZ_REC','Recupero','',nil);
    grdRichieste.medpColonna('C_SPEZ_REC').Visible:=ContaRec > 0;
    grdRichieste.medpAggiungiColonna('C_SPEZ_PAG','Pagamento','',nil);
    grdRichieste.medpColonna('C_SPEZ_PAG').Visible:=ContaPag > 0;
    grdRichieste.medpAggiungiColonna('AUTORIZZAZIONE','Aut.','',nil);
    grdRichieste.medpColonna('AUTORIZZAZIONE').Visible:=False;
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Aut.','',nil);
  end
  else if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    // parte per entrata anticipata
    grdRichieste.medpAggiungiColonna('SPEZ_E','Entrata Spezzone','',nil);
    grdRichieste.medpAggiungiColonna('ECCEDENZA_E',' Ecc.','',nil);
    grdRichieste.medpAggiungiColonna('CAUS1_E',' Causale','',nil);
    grdRichieste.medpAggiungiColonna('AUTORIZZAZIONE_E',' Aut.','',nil);
    grdRichieste.medpColonna('AUTORIZZAZIONE_E').Visible:=False;
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE_E',' Aut.','',nil);

    // colonne visibili per eccedenza in entrata
    LVisColonneE:=R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E']);
    grdRichieste.medpColonna('SPEZ_E').Visible:=LVisColonneE;
    grdRichieste.medpColonna('ECCEDENZA_E').Visible:=LVisColonneE;
    grdRichieste.medpColonna('CAUS1_E').Visible:=LVisColonneE and (CausUnica = '');
    grdRichieste.medpColonna('D_AUTORIZZAZIONE_E').Visible:=LVisColonneE;

    // parte per uscita posticipata
    grdRichieste.medpAggiungiColonna('SPEZ_U','Uscita Spezzone','',nil);
    if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione <> 'T' then
      grdRichieste.medpAggiungiColonna('SPEZ_ALLE1_U',' Alle','',nil);
    grdRichieste.medpAggiungiColonna('ECCEDENZA_U',' Ecc.','',nil);
    grdRichieste.medpAggiungiColonna('CAUS1_U',' Causale','',nil);
    grdRichieste.medpAggiungiColonna('AUTORIZZAZIONE_U',' Aut.','',nil);
    grdRichieste.medpColonna('AUTORIZZAZIONE_U').Visible:=False;
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE_U',' Aut.','',nil);

    // colonne visibili per eccedenza in uscita
    LVisColonneU:=R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','U']);
    grdRichieste.medpColonna('SPEZ_U').Visible:=LVisColonneU;
    grdRichieste.medpColonna('ECCEDENZA_U').Visible:=LVisColonneU;
    grdRichieste.medpColonna('CAUS1_U').Visible:=LVisColonneU and (CausUnica = '');
    grdRichieste.medpColonna('D_AUTORIZZAZIONE_U').Visible:=LVisColonneU;
    if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione <> 'T' then
      grdRichieste.medpColonna('SPEZ_ALLE1_U').Visible:=LVisColonneU ;
  end;

  // gestione colonna descrizione motivazione in tabella
  grdRichieste.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
  grdRichieste.medpColonna('MOTIVAZIONE').Visible:=(Length(ArrMotivazioni) > 0);

  if (not WR000DM.Responsabile) and
     (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_R) then
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
  grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);

  // allegati
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);

  grdRichieste.medpBrowse:=True;
  grdRichieste.medpInizializzaCompGriglia;

  if WR000DM.Responsabile then
  begin
    // autorizzazione
    if not SolaLettura then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
    end;
  end
  else
  begin
    // richiesta
    if not SolaLettura then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','null','null','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','null','','D');
      grdRichieste.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
      grdRichieste.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','Confermare la richiesta?','D');
      //grdRichieste.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','DUPLICA','Effettua nuova richiesta','null','S')
    end;
    grdRichieste.medpColonna('DATA_RICHIESTA').Visible:=C018.TipoRichiesteSel <> [trDaEffettuare];
    if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_R then
      grdRichieste.medpColonna('D_RESPONSABILE').Visible:=C018.TipoRichiesteSel <> [trDaAutorizzare];
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');

  // allegati
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');

  grdRichieste.medpColonna('DBG_COMANDI').Visible:=(Length(grdRichieste.medpDescCompGriglia.Riga[0]) > 0);
  grdRichieste.medpColonna(DBG_ITER).Visible:=C018.TipoRichiesteSel <> [trDaEffettuare];
  if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
    grdRichieste.medpColonna('D_AUTORIZZAZIONE').Visible:=(WR000DM.Responsabile) or (C018.TipoRichiesteSel <= [trAutorizzate,trTutte]);
  grdRichieste.medpColonna('TIPO_RICHIESTA').Visible:=(C018.TipoRichiesteSel = [trAutorizzate]) or ((C018.TipoRichiesteSel = [trDaAutorizzare]) and (Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S')) or ([trTutte] <= C018.TipoRichiesteSel);
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
  grdRichieste.medpCaricaCDS;

  // TORINO_COMUNE
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
    RiepilogoTotali;
end;

procedure TW026FRichiestaStrGG.imgCancellaClick(Sender: TObject);
// cancellazione richiesta
var
  FN: String;
  i: Integer;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  Richiesta.Id:=StrToInt(grdRichieste.medpValoreColonna(i,'ID'));

  actCanRichiesta;
end;

procedure TW026FRichiestaStrGG.imgAnnullaClick(Sender: TObject);
// annullamento modifiche
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);
  grdRichieste.medpStato:=msBrowse;
  grdRichieste.medpBrowse:=True;
  TrasformaComponenti(FN,False);
end;

procedure TW026FRichiestaStrGG.imgModificaClick(Sender: TObject);
// modifica riga
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato <> msBrowse then
  begin
    MsgBox.MessageBox('E'' necessario completare oppure annullare l''operazione in corso prima di procedere!',ESCLAMA);
    Exit;
  end;
  DBGridColumnClick(Sender,FN);
  grdRichieste.medpStato:=msEdit;
  grdRichieste.medpBrowse:=False;
  TrasformaComponenti(FN,True);
end;

procedure TW026FRichiestaStrGG.imgConfermaClick(Sender: TObject);
var
  FN: String;
  LRichZeroMin,ControlliAutOKChecked: Boolean;
  LTipoElab: TTipoElab;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  DBGridColumnClick(Sender,FN);
  if grdRichieste.medpStato = msBrowse then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    if not ModificheRiga(FN) then
    begin
      grdRichieste.medpStato:=msBrowse;
      grdRichieste.medpBrowse:=True;
      TrasformaComponenti(FN,False);
      Exit;
    end;
  end;

  // inserimento / autorizzazione richiesta -----
  // conferma richiesta   (DC - chiamata <147438>: conferma richiesta sempre eseguita)
  ControlliAutOKChecked:=False;
  if (not WR000DM.Responsabile) or GetLDatiModificabiliResp(grdRichieste.medpRigaDiCompGriglia(FN)) then
  begin
    if ControlliOK(cdsGrid.FieldByName('ID').AsString) then
    begin
      if WR000DM.Responsabile then //ControlliAutOK devono essere fatti prima che i Componenti siano trasformati
        if not ControlliAutOK(FN) then // conferma autorizzazione
          exit
        else
          ControlliAutOKChecked:=True;

      // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
      // per San Giuliano è consentita la richiesta di 0 minuti
      LRichZeroMin:=IsRichiestaZeroMinuti(cdsGrid.FieldByName('ID').AsString);
      // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine

      // valuta inserimento oppure modifica richiesta
      if cdsGrid.FieldByName('TIPO_RIGA').AsString = W026_TROW_C then
      begin
        if not LRichZeroMin then
        begin
          // esegue l'inserimento della richiesta
          actInsRichiesta;
        end
        else
        begin
          // richiesta di 0 minuti: annulla inserimento
          grdRichieste.medpStato:=msBrowse;
          grdRichieste.medpBrowse:=True;
          TrasformaComponenti(FN,False);
          exit;
        end;
      end
      else
      begin
        // nel caso di richiesta di 0 minuti esegue la cancellazione stessa della richiesta
        if not LRichZeroMin then
        begin
          // esegue la modifica della richiesta
          actModRichiesta;
        end
        else
        begin
          // richiesta di 0 minuti: cancella la richiesta
          actCanRichiesta;
          exit;
        end;
      end;
    end
    else
      exit;
  end;

  if WR000DM.Responsabile then
  begin
    DBGridColumnClick(Sender,FN); //Necessario per riposizionare il cursore sulla riga corretta
    if (not ControlliAutOKChecked) and (not ControlliAutOK(FN)) then //conferma autorizzazione
      exit;
    // imposta il tipo di elaborazione:
    // - solo autorizzazione nel caso ci sia il parametro relativo al doppio passaggio
    //   e il filtro sia sulle richieste da autorizzare
    // - autorizzazione + elaborazione su cartellino nel caso normale
    if (Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S') and
       (C018.TipoRichiesteSel = [trDaAutorizzare]) then
      LTipoElab:=TTipoElab.Autorizza
    else
      LTipoElab:=TTipoElab.AutorizzaApplica;
    actAutorizzazioneOK(LTipoElab);
  end;
end;

function TW026FRichiestaStrGG.ModificheRiga(const FN: String):Boolean;
// restituisce True se sono state apportate modifiche ai dati della richiesta
// oppure False altrimenti
begin
  // per ora restituisce sempre true
  Result:=True;
end;

function TW026FRichiestaStrGG.CausaleAbilitata(PCausale,PProgressivo,PData:String):Boolean;
var Progressivo:Integer;
    Data:TDateTime;
begin
  Result:=False;
  Progressivo:=PProgressivo.ToInteger;
  Data:=StrToDate(PData);
  R180SetVariable(W026DM.selT430AbPresenza1,'CAUSALE',PCausale);
  R180SetVariable(W026DM.selT430AbPresenza1,'PROGRESSIVO',Progressivo);
  R180SetVariable(W026DM.selT430AbPresenza1,'DATA',Data);
  W026DM.selT430AbPresenza1.Open;
  Result:=not W026DM.selT430AbPresenza1.FieldByName('CAUSALE_ABILITATA').IsNull;
end;

function TW026FRichiestaStrGG.Controlli_EU(const FN: String; var RErrMsg: String):Boolean;
// effettua i controlli per gli spezzoni di entrata e/o uscita
// caso di Parametri.CampiRiferimento.C90_W026Spezzoni = 'EU'
var
  i,OraIni,OraFine,OraTemp: Integer;
  edtOra: TmeIWEdit;
  SpezE,SpezU: String;
  LivAut: Integer;
  // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini
  IWCmbCaus1E, IWCmbCaus1U: TmeIWComboBox;
  DescMotiv:String;
  c:Integer;
  // MONDOEDP - commessa MAN/07 SVILUPPO#68.fine
begin
  Result:=False;
  RErrMsg:='';
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  // per il responsabile determina se i dati sono modificabili al livello di autorizzazione
  if WR000DM.Responsabile then
  begin
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),-1);
    C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
    // se i dati non sono modificabili i controlli si intendono ok
    if not C018.ModificaValori(LivAut) then
    begin
      Result:=True;
      Exit;
    end;
  end;
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine

  Richiesta.Eliminata:=False;

  // entrata
  IWCmbCaus1E:=nil;
  SpezE:=grdRichieste.medpValoreColonna(i,'SPEZ_E');
  if SpezE = '' then
  begin
    Richiesta.Dalle1E:='';
    Richiesta.Alle1E:='';
    Richiesta.Caus1E:='';
    Richiesta.AutE:='';
  end
  else
  begin
    Richiesta.Dalle1E:=Copy(SpezE,1,5);
    Richiesta.Alle1E:=Copy(SpezE,7,5);

    // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini
    if CausUnica <> '' then
    begin
      // se è disponibile una sola causale utilizza quella
      // (in questo caso la combobox di scelta non è presente)
      Richiesta.Caus1E:=CausUnica;
    end
    else
    begin
      IWCmbCaus1E:=(grdRichieste.medpCompCella(i,'CAUS1_E',0) as TmeIWComboBox);
      Richiesta.Caus1E:=Trim(Copy(IWCmbCaus1E.Text,1,5));
    end;
    // MONDOEDP - commessa MAN/07 SVILUPPO#68.fine

    // controllo indicazione causale e autorizzazione
    if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) or
       (WR000DM.Responsabile) then
    begin
      // autorizzazione entrata (se tipo richiesta "A")
      Richiesta.AutE:=IfThen((grdRichieste.medpCompCella(i,'D_AUTORIZZAZIONE_E',0) as TmeIWCheckBox).Checked,'S','N');
      if (Richiesta.Caus1E = '') and (Richiesta.AutE = 'S') then
      begin
        RErrMsg:='Selezionare la causale da autorizzare sull''entrata!';
        if Assigned(IWCmbCaus1E) then
          IWCmbCaus1E.SetFocus;
        Exit;
      end;
    end
    else
    begin
      // richiesta spezzone entrata
      if Richiesta.Caus1E = '' then
      begin
        RErrMsg:='Selezionare la causale da richiedere sull''entrata!';
        if Assigned(IWCmbCaus1E) then
          IWCmbCaus1E.SetFocus;
        Exit;
      end;
    end;
    //Controllo se causale abilitata in anagrafico
    if (Richiesta.Caus1E <> '') and (not CausaleAbilitata(Richiesta.Caus1E,grdRichieste.medpValoreColonna(i,'PROGRESSIVO'),grdRichieste.medpValoreColonna(i,'DATA'))) then
    begin
      RErrMsg:=Format('Causale %s non abilitata in anagrafico!',[Richiesta.Caus1E]);
      if Assigned(IWCmbCaus1E) then
        IWCmbCaus1E.SetFocus;
      Exit;
    end;
  end;

  // uscita
  IWCmbCaus1U:=nil;
  SpezU:=grdRichieste.medpValoreColonna(i,'SPEZ_U');
  if SpezU = '' then
  begin
    Richiesta.Dalle1U:='';
    Richiesta.Alle1U:='';
    Richiesta.Caus1U:='';
    Richiesta.AutU:='';
  end
  else
  begin
    Richiesta.Dalle1U:=Copy(SpezU,1,5);

    // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini
    if CausUnica <> '' then
    begin
      // se è disponibile una sola causale utilizza quella
      // (in questo caso la combobox di scelta non è presente)
      Richiesta.Caus1U:=CausUnica;
    end
    else
    begin
      IWCmbCaus1U:=(grdRichieste.medpCompCella(i,'CAUS1_U',0) as TmeIWComboBox);
      Richiesta.Caus1U:=Trim(Copy(IWCmbCaus1U.Text,1,5));
    end;

    // autorizzazione uscita (se tipo richiesta "A")
    if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) or
       (WR000DM.Responsabile) then
    begin
      Richiesta.AutU:=IfThen((grdRichieste.medpCompCella(i,'D_AUTORIZZAZIONE_U',0) as TmeIWCheckBox).Checked,'S','N');
      // verifica selezione causale
      if (Richiesta.Caus1U = '') and (Richiesta.AutU = 'S') then
      begin
        RErrMsg:='Selezionare la causale da autorizzare sull''uscita!';
        if Assigned(IWCmbCaus1U) then
          IWCmbCaus1U.SetFocus;
        Exit;
      end;
    end
    else
    begin
      // richiesta
      if Richiesta.Caus1U = '' then
      begin
        RErrMsg:='Selezionare la causale da richiedere sull''uscita!';
        if Assigned(IWCmbCaus1U) then
          IWCmbCaus1U.SetFocus;
        Exit;
      end;
    end;
    //Controllo se causale abilitata in anagrafico
    if (Richiesta.Caus1U <> '') and (not CausaleAbilitata(Richiesta.Caus1U,grdRichieste.medpValoreColonna(i,'PROGRESSIVO'),grdRichieste.medpValoreColonna(i,'DATA'))) then
    begin
      RErrMsg:=Format('Causale %s non abilitata in anagrafico!',[Richiesta.Caus1U]);
      if Assigned(IWCmbCaus1U) then
        IWCmbCaus1U.SetFocus;
      Exit;
    end;

    // uscita alle
    if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione <> 'T' then
    begin
      edtOra:=(grdRichieste.medpCompCella(i,'SPEZ_ALLE1_U',0) as TmeIWEdit);
      if edtOra.Text = '' then
      begin
        RErrMsg:='Indicare l''ora dell''uscita autorizzata!';
        edtOra.SetFocus;
        Exit;
      end;
      try
        R180OraValidate(edtOra.Text);
      except
        on E:Exception do
        begin
          RErrMsg:=E.Message;
          edtOra.SetFocus;
          Exit;
        end;
      end;
      // controllo coerenza con spezzone
      OraIni:=R180OreMinutiExt(Copy(SpezU,1,5));
      OraFine:=R180OreMinutiExt(Copy(SpezU,7,5));
      OraTemp:=R180OreMinutiExt(edtOra.Text);
      if OraFine < OraIni then
      begin
        OraFine:=OraFine + 1440;
        if OraTemp < OraIni then
          OraTemp:=OraTemp + 1440;
      end;
      if (OraTemp < OraIni) or (OraTemp > OraFine) then
      begin
        RErrMsg:='L''ora dell''uscita autorizzata deve essere compresa nel periodo ' + SpezU;
        edtOra.SetFocus;
        Exit;
      end;
      Richiesta.Alle1U:=edtOra.Text;
    end
    else
      Richiesta.Alle1U:=Copy(SpezU,7,5);
  end;

  // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini
  // in base ad un parametro aziendale, valuta se è necessaria almeno un'autorizzazione
  // fra entrata e uscita se:
  //  - non ci sono motivazioni definite
  //  - ci sono motivazioni e ne è stata scelta una significativa (testo <> '')
  //  se invece è specificata un'autorizzazione, richiede anche una motivazione significativa (se ce ne sono)
  if Parametri.CampiRiferimento.C90_W026AutorizzObbl = 'S' then
  begin
    DescMotiv:='';
    if Length(ArrMotivazioni) > 0 then
    begin
      c:=grdRichieste.medpIndexColonna('MOTIVAZIONE');
      if (grdRichieste.medpCompGriglia[i].CompColonne[c] <> nil) then
        DescMotiv:=Trim((grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox).Text);
    end;
    if (Richiesta.AutE <> 'S') and (Richiesta.AutU <> 'S') then
    begin
      //Non è stata effettuata alcuna autorizzazione
      if (Length(ArrMotivazioni) = 0) or (DescMotiv <> '') then
      begin
        if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
        begin
          if Richiesta.Caus1E = '' then
            Richiesta.AutE:='';
          if Richiesta.Caus1U = '' then
            Richiesta.AutU:='';
        end;
        if (Richiesta.Caus1E <> '') and (Richiesta.Caus1U <> '') then
        begin
          if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
          begin
            Richiesta.AutE:='S';
            Richiesta.AutU:='S';
          end
          else
            RErrMsg:='Per continuare è necessario autorizzare l''entrata e/o l''uscita!'
        end
        else if (Richiesta.Caus1E <> '') then
        begin
          if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
            Richiesta.AutE:='S'
          else
            RErrMsg:='Per continuare è necessario autorizzare l''entrata!';
        end
        else if (Richiesta.Caus1U <> '') then
        begin
          if Parametri.RagioneSociale.ToUpper = TORINO_HCOTTOLENGO then
            Richiesta.AutU:='S'
          else
            RErrMsg:='Per continuare è necessario autorizzare l''uscita!';
        end;
        if RErrMsg <> '' then
          Exit;
      end;
    end
    else if (Length(ArrMotivazioni) > 0) and (DescMotiv = '') then
    begin
      //Non è stata specificata nessuna motivazione
      RErrMsg:='Per continuare è necessario specificare una motivazione!';
      Exit;
    end;
  end;
  // MONDOEDP - commessa MAN/07 SVILUPPO#68.fine

  // controlli ok
  Result:=True;
end;

// SGIULIANOMILANESE_COMUNE - Commessa: 2013/115 SVILUPPO#2.ini
function TW026FRichiestaStrGG.IsRichiestaZeroMinuti(const FN: String): Boolean;
// restituisce True nel caso in cui si tenta di inserire una richiesta completamente a 0
// (possibile solo con tipo spezzoni T se Parametri.CampiRiferimento.C90_W026EccedGGTutta = 'N')
// oppure False altrimenti
var
  i, Id, D1, D2, A1, A2: Integer;
begin
  if (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') and
     (Parametri.CampiRiferimento.C90_W026EccedGGTutta = 'N') then
  begin
    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    Id:=StrToInt(grdRichieste.medpValoreColonna(i,'ID'));
    cdsGrid.Locate('ID',Id,[]);

    // la richiesta è a 0 se il "dalle" degli spezzoni di recupero e pagamento
    // è vuoto (ovvero è 0)
    if (grdRichieste.medpStato = msEdit) or
       (cdsGrid.FieldByName('TIPO_RIGA').AsString = W026_TROW_C) then
    begin
      // in modifica i valori non sono ancora disponibili nel clientdataset
      D1:=R180OreMinutiExt(Richiesta.DalleT[1]);
      A1:=R180OreMinutiExt(Richiesta.AlleT[1]);
      D2:=R180OreMinutiExt(Richiesta.DalleT[2]);
      A2:=R180OreMinutiExt(Richiesta.AlleT[2]);
      Result:=(D1 = A1) and (D2 = A2);
    end
    else
    begin
      Result:=(R180OreMinutiExt(cdsGrid.FieldByName('SPEZ_DALLE1').AsString) = 0) and
              (R180OreMinutiExt(cdsGrid.FieldByName('SPEZ_DALLE2').AsString) = 0);
    end;
  end
  else
  begin
    Result:=False;
  end;
end;

function TW026FRichiestaStrGG._CtrlLimiteSaldoMese(const FN: String; const POreRec, POrePag: String; var ErrMsg: String): Boolean;
// determina se la richiesta corrente di ore a recupero / in pagamento è al di sotto
// della soglia rappresentata dal saldo disponibile del mese
var
  i, Id, Prog,
  TotMeseRec, TotMesePag, TotMeseAltre, TotMese, MinutiRec, MinutiPag: Integer;
  MeseCont: TDateTime;
begin
  Result:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  Id:=StrToInt(grdRichieste.medpValoreColonna(i,'ID'));
  Prog:=StrToInt(grdRichieste.medpValoreColonna(i,'PROGRESSIVO'));
  MeseCont:=R180InizioMese(StrToDate(grdRichieste.medpValoreColonna(i,'DATA')));

  // valuta se è necessario rieseguire i conteggi del cartellino mensile
  if (DatiCartellino.Prog <> Prog) or
     (DatiCartellino.DataInizioMeseCont <> MeseCont) then
  begin
    DatiCartellino:=GetDatiCartellinoMese(Prog,MeseCont);
  end;

  if not DatiCartellino.CheckSaldo then
  begin
    Result:=True;
    exit;
  end;

  // determina il totale delle ore richieste nel mese (eccetto richiesta corrente)
  W026DM.selTotMese.Close;
  W026DM.selTotMese.SetVariable('PROGRESSIVO',Prog);
  W026DM.selTotMese.SetVariable('INIZIO',MeseCont);
  W026DM.selTotMese.SetVariable('FINE',R180FineMese(MeseCont));
  W026DM.selTotMese.SetVariable('ID',Id);
  W026DM.selTotMese.Execute;
  TotMeseRec:=W026DM.selTotMese.FieldAsInteger(0);
  TotMesePag:=W026DM.selTotMese.FieldAsInteger(1);

  // determina le ore attualmente impostate per la richiesta
  MinutiRec:=R180OreMinutiExt(POreRec);
  MinutiPag:=R180OreMinutiExt(POrePag);

  // somma il totale mensile delle altre richieste alla richiesta attuale
  TotMeseAltre:=TotMeseRec + TotMesePag;
  TotMese:=TotMeseAltre + (MinutiRec + MinutiPag);

  if (TotMese > 0) and (TotMese > DatiCartellino.SaldoDisponibile) then
  begin
    ErrMsg:='La quantità di ore richieste nel mese di %s non può superare il saldo disponibile di %s.'#13#10 +
            'Totale richieste mensili: %s (%s a recupero + %s in pagamento)'#13#10 +
            'Totale richiesta corrente: %s'#13#10 +
            'Ore max richiedibili totali: %s';
    ErrMsg:=Format(ErrMsg,[FormatDateTime('mmmm yyyy',DatiCartellino.DataInizioMeseCont),
                           R180MinutiOre(DatiCartellino.SaldoDisponibile),
                           R180MinutiOre(TotMeseAltre),R180MinutiOre(TotMeseRec),R180MinutiOre(TotMesePag),
                           R180MinutiOre(MinutiRec + MinutiPag),
                           R180MinutiOre(DatiCartellino.SaldoDisponibile - TotMeseAltre)
                          ]);
    Exit;
  end;

  Result:=True;
end;

function TW026FRichiestaStrGG.CtrlLimiteSaldoMeseRich(const FN: String; const POreRec, POrePag: String; var ErrMsg: String): Boolean;
// funzione di controllo sforamento limite mensile disponibile in fase di richiesta
begin
  Result:=_CtrlLimiteSaldoMese(FN,POreRec,POrePag,ErrMsg);
end;

function TW026FRichiestaStrGG.CtrlLimiteSaldoMeseAut(const FN: String; var ErrMsg: String): Boolean;
// funzione di controllo sforamento limite mensile disponibile in fase di richiesta
var
  i: Integer;
  Rec, Pag: string;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  Rec:=Copy(grdRichieste.medpValoreColonna(i,'C_SPEZ_REC'),1,5);
  Pag:=Copy(grdRichieste.medpValoreColonna(i,'C_SPEZ_PAG'),1,5);

  Result:=_CtrlLimiteSaldoMese(FN,Rec,Pag,ErrMsg);
end;
// SGIULIANOMILANESE_COMUNE - Commessa: 2013/115 SVILUPPO#2.fine

function TW026FRichiestaStrGG.Controlli_T(const FN: String; var ErrMsg: String):Boolean;
// effettua i controlli per spezzoni di tipo T (tutti)
// caso di Parametri.CampiRiferimento.C90_W026Spezzoni = 'T'
var
  i,c,j,idx,OraIni,QtaMinuti,Arr,TotPeriodo,
  MinutiMin,MinutiMax: Integer;
  Spez,NomeSpez,Dalle,Alle,Caus,Qta,Esempio,RecStr,PagStr: String;
  LivAut: Integer;
begin
  Result:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  // per il responsabile determina se i dati sono modificabili al livello di autorizzazione
  if WR000DM.Responsabile then
  begin
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),-1);
    C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
    // se i dati non sono modificabili i controlli si intendono ok
    if not C018.ModificaValori(LivAut) then
    begin
      Result:=True;
      Exit;
    end;
  end;
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine

  Richiesta.Spez:=grdRichieste.medpValoreColonna(i,'SPEZ');
  Spez:=grdRichieste.medpValoreColonna(i,'SPEZ');
  OraIni:=R180OreMinutiExt(Copy(Spez,1,5));

  // ciclo sulle suddivisioni degli spezzoni (iniziando dall'eccedenza in pagamento)
  // 1 = recupero
  // 2 = pagamento
  for j:=2 downto 1 do
  begin
    NomeSpez:=IfThen(j = 1,'a recupero','in pagamento');
    c:=grdRichieste.medpIndexColonna(IfThen(j = 1,'C_SPEZ_REC','C_SPEZ_PAG'));
    QtaMinuti:=0;
    TotPeriodo:=0;
    if Assigned(grdRichieste.medpCompCella(i,c,0)) then
    begin
      Qta:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit).Text;
      QtaMinuti:=R180OreMinutiExt(Qta);
      TotPeriodo:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit).Tag;
    end;
    if j = 2 then
    begin
      // spezzone in pagamento
      // alle = ora fine spezzone
      // dalle = alle - quantità richiesta
      Alle:=Copy(Spez,7,5);
      //Alberto 02/08/2013: gestione dello spezzone che termina oltre mezzanotte (00.00)
      if R180OreMinutiExt(Alle) < OraIni then
        Alle:=R180MinutiOre(R180OreMinutiExt(Alle) + 1440);
      Dalle:=R180MinutiOre(R180OreMinutiExt(Alle) - QtaMinuti);
      //if CausPagUnica = '' then
      if ContaPag > 1 then
        Caus:=(grdRichieste.medpCompCella(i,c,1) as TmedpIWMultiColumnComboBox).Text
      else
        Caus:=CausPagUnica;
    end
    else
    begin
      // spezzone a recupero
      // alle = dalle spez. pag.
      // dalle = alle - quantità richiesta
      Alle:=Richiesta.DalleT[j + 1];
      //Alberto 02/08/2013: gestione dello spezzone che termina oltre mezzanotte (00.00)
      if R180OreMinutiExt(Alle) < OraIni then
        Alle:=R180MinutiOre(R180OreMinutiExt(Alle) + 1440);
      Dalle:=R180MinutiOre(R180OreMinutiExt(Alle) - QtaMinuti);
      //if CausRecUnica = '' then
      if ContaRec > 1 then
        Caus:=(grdRichieste.medpCompCella(i,c,1) as TmedpIWMultiColumnComboBox).Text
      else
        Caus:=CausRecUnica;
    end;

    if QtaMinuti > 0 then
    begin
      // verifica che quantità sia multiplo di arrotondamento giornaliero causale
      idx:=ArrCausaliGetIndex(Caus);
      if idx < 0 then
        raise Exception.Create(Format('Causale "%s" non trovata!',[Caus]));
      Arr:=ArrCausali[idx].ArrotRiepGG;
      Arr:=IfThen(Arr > 1,Arr,1);
      if QtaMinuti mod Arr <> 0 then
      begin
        Esempio:=CRLF + 'Es. ' + R180MinutiOre(Max(QtaMinuti div Arr * Arr,Arr));
        ErrMsg:=Format('La quantità richiesta per le ore %s deve essere arrotondata a %d minuti!%s',[NomeSpez,Arr,Esempio]);
        Exit;
      end;

      // verifica i limiti di minuti minimi e massimi su quantità a recupero / pagamento in base alle regole della causale
      MinutiMin:=ArrCausali[idx].MinutiMin;
      MinutiMax:=ArrCausali[idx].MinutiMax;
      if QtaMinuti < MinutiMin then
      begin
        // quantità inferiore ai minuti minimi
        ErrMsg:=Format('La quantità richiesta per le ore %s deve essere di almeno %s!',[NomeSpez,R180MinutiOre(MinutiMin)]);
        grdRichieste.medpCompCella(i,c,0).SetFocus;
        Exit;
      end;
      if QtaMinuti > MinutiMax then
      begin
        // quantità superiore ai minuti massimi
        ErrMsg:=Format('La quantità richiesta per le ore %s non può superare il limite di %s',[NomeSpez,R180MinutiOre(MinutiMax)]);
        grdRichieste.medpCompCella(i,c,0).SetFocus;
        Exit;
      end;

      // verifica indicazione causale
      if Caus = '' then
      begin
        ErrMsg:=Format('Selezionare la causale per le ore %s!',[NomeSpez]);
        grdRichieste.medpCompCella(i,c,1).SetFocus;
        Exit;
      end
      else if not CausaleAbilitata(Caus,grdRichieste.medpValoreColonna(i,'PROGRESSIVO'),grdRichieste.medpValoreColonna(i,'DATA')) then
      begin
        ErrMsg:=Format('Causale %s per le ore %s non abilitata in anagrafico!',[Caus,NomeSpez]);
        grdRichieste.medpCompCella(i,c,1).SetFocus;
        Exit;
      end;
    end;

    // calcola arrotondamento in base a causale e determina ora iniziale
    Dalle:=R180MinutiOre(R180OreMinutiExt(Alle) - GetDiffArr(Dalle,Alle,Caus));

    // impostazione variabili per richiesta
    Richiesta.Eliminata:=False;
    Richiesta.AlleT[j]:=Alle;
    Richiesta.DalleT[j]:=Dalle;
    Richiesta.OraT[j]:=R180MinutiOre(R180OreMinutiExt(Alle) - R180OreMinutiExt(Dalle));
    Richiesta.CausT[j]:=Caus;

    // salva variabili di appoggio
    // RecordRichiesta.OraT[1] = ore richieste a recupero
    // RecordRichiesta.OraT[2] = ore richieste in pagamento
    RecStr:=Richiesta.OraT[1];
    PagStr:=Richiesta.OraT[2];

    // verifica totale ore richieste
    if R180OreMinutiExt(Dalle) < OraIni then
    begin
      MsgBox.TextIsHTML:=True;
      if j = 2 then
        ErrMsg:=Format('Anomalia nella richiesta del %s:<br>' +
                       'il numero di ore richieste in pagamento supera ' +
                       'il totale disponibile dell''eccedenza oraria!<br><br>' +
                       'Ore richieste <b>[%s]</b> > Totale disponibile <b>[%s]</b><br>',
                       [grdRichieste.medpValoreColonna(i,'DATA'),
                        PagStr,
                        R180MinutiOre(TotPeriodo)])
      else
        ErrMsg:=Format('Anomalia nella richiesta del %s:<br>' +
                       'il numero totale di ore indicato (recupero + pagamento) supera ' +
                       'il totale disponibile dell''eccedenza oraria!<br><br>' +
                       'Ore richieste a recupero: <b>%s</b><br>' +
                       'Ore richieste in pagamento: <b>%s</b><br>' +
                       'Totale richiesto <b>[%s]</b> > Totale disponibile <b>[%s]</b><br>',
                       [grdRichieste.medpValoreColonna(i,'DATA'),
                        RecStr,PagStr,
                        R180MinutiOre(R180OreMinutiExt(Richiesta.OraT[1]) + R180OreMinutiExt(Richiesta.OraT[2])),
                        R180MinutiOre(TotPeriodo)]);
      grdRichieste.medpCompCella(i,c,0).SetFocus;
      Exit;
    end;
  end;

  // SGIULIANOMILANESE_COMUNE - Commessa: 2013/115 SVILUPPO#2.ini
  // limite saldo mensile
  if Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile = 'S' then
  begin
    // controllo sforamento limite saldo mensile
    if not CtrlLimiteSaldoMeseRich(FN,RecStr,PagStr,ErrMsg) then
      Exit;
  end;
  // SGIULIANOMILANESE_COMUNE - Commessa: 2013/115 SVILUPPO#2.fine

  (*Annullata la gestione della Rettifica
  // se si tratta di rettifica verifica spezzoni della richiesta originale
  if IsRettifica(RecordRichiesta.Id,IdOrig) then
  begin
    OQ:=TOracleQuery.Create(Self);
    try
      OQ.Session:=SessioneOracle;
      OQ.SQL.Add('select T326.*');
      OQ.SQL.Add('from   T326_RICHIESTESTR_SPEZ T326');
      OQ.SQL.Add('where  T326.ID = ' + IntToStr(IdOrig));
      OQ.SQL.Add('and    T326.TIPO = ''T''');
      OQ.SQL.Add('and    T326.SPEZ = ''' + RecordRichiesta.Spez + '''');
      OQ.Execute;
      Differenze:=False;
      for j:=1 to 2 do
      begin
        if (RecordRichiesta.DalleT[j] <> OQ.FieldAsString(Format('SPEZ_DALLE%d',[j]))) or
           (RecordRichiesta.AlleT[j] <> OQ.FieldAsString(Format('SPEZ_ALLE%d',[j]))) or
           (RecordRichiesta.CausT[j] <> OQ.FieldAsString(Format('CAUS%d',[j]))) then
        begin
          Differenze:=True;
          Break;
        end;
      end;
      OQ.Close;
      if not Differenze then
      begin
        MsgBox.MessageBox('Attenzione! Questa richiesta è già presente in archivio!',ESCLAMA,'Richiesta duplicata');
        Exit;
      end;
    finally
      FreeAndNil(OQ);
    end;
  end;
  *)

  // controlli ok
  ErrMsg:='';
  Result:=True;
end;

function TW026FRichiestaStrGG.ControlliOK(const FN: String):Boolean;
// Effettua i controlli e imposta i dati per l'aggiornamento
var
  LErrMsg: String;
  i, c: Integer;
  LIWCmb: TmeIWComboBox;
  LLivAut: Integer;
begin
  Result:=False;
  MsgBox.TextIsHTML:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  // per il responsabile determina se i dati sono modificabili al livello di autorizzazione
  if WR000DM.Responsabile then
  begin
    LLivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),-1);
    C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
    // se i dati non sono modificabili i controlli si intendono ok
    if not C018.ModificaValori(LLivAut) then
    begin
      Result:=True;
      Exit;
    end;
  end;
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine

  Richiesta.Id:=StrToInt(grdRichieste.medpValoreColonna(i,'ID'));

  // controlli in base alla tipologia di spezzoni
  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    if not Controlli_EU(FN,LErrMsg) then
    begin
      MsgBox.MessageBox(LErrMsg,ESCLAMA);
      Exit;
    end;
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    if not Controlli_T(FN,LErrMsg) then
    begin
      MsgBox.MessageBox(LErrMsg,ESCLAMA);
      Exit;
    end;
  end;

  if not ControlliBudget(FN,LErrMsg) then
  begin
    MsgBox.MessageBox(LErrMsg,ESCLAMA);
    Exit;
  end;

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  // verifica motivazione
  if (Length(ArrMotivazioni) > 0) then
  begin
    c:=grdRichieste.medpIndexColonna('MOTIVAZIONE');
    if (grdRichieste.medpCompGriglia[i].CompColonne[c] <> nil) then
    begin
      // verifica selezione motivazione
      LIWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
      if LIWCmb.ItemIndex < 0 then
      begin
        MsgBox.MessageBox('E'' necessario selezionare una motivazione per la richiesta!',INFORMA);
        ActiveControl:=LIWCmb;
        Exit;
      end;
      Richiesta.Motivazione:=ArrMotivazioni[LIWCmb.ItemIndex].Codice;
    end
    else
      Richiesta.Motivazione:='';
  end;
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine

  // controlli ok
  Result:=True;
end;

function TW026FRichiestaStrGG.ControlliBudget(const FN: String; var ErrMsg: String):Boolean;
var
  i,idx,r:Integer;
  CheckBudget:array of TCheckBudget;
  procedure AddCheckBudget(Causale:String; Dalle,Alle:Integer; AbbatteBudget,TipoRichiestaWeb:String);
  var i,k,NumOre:Integer;
      Trovato:Boolean;
  begin
    //Non si considerano intervalli di 24 ore
    if Dalle = Alle then
      exit;

    //Al momento uniformo tutte le tipologie di AbbatteBudget ad L
    AbbatteBudget:='L';

    Trovato:=False;
    NumOre:=Alle + IfThen(Alle > Dalle,0,1440) - Dalle;
    for i:=0 to High(CheckBudget) do
    begin
      if (CheckBudget[i].AbbatteBudget = AbbatteBudget) and (CheckBudget[i].TipoRichiestaWeb = TipoRichiestaWeb) then
      begin
        Trovato:=True;
        CheckBudget[i].Causali:=CheckBudget[i].Causali + ',' + Causale;
        inc(CheckBudget[i].NumOre,NumOre);
      end;
    end;

    if not Trovato then
    begin
      SetLength(CheckBudget,Length(CheckBudget) + 1);
      k:=High(CheckBudget);
      CheckBudget[k].Causali:=Causale;
      CheckBudget[k].AbbatteBudget:=AbbatteBudget;
      CheckBudget[k].TipoRichiestaWeb:=TipoRichiestaWeb;
      CheckBudget[k].NumOre:=NumOre;
    end;
  end;
begin
  Result:=True;
  SetLength(CheckBudget,0);

  r:=grdRichieste.medpRigaDiCompGriglia(FN);

  idx:=ArrCausaliGetIndex(Richiesta.Caus1E);
  if (idx >= 0) and (ArrCausali[idx].NoLimiteAnnualeLiq = 'N') then
    AddCheckBudget(Richiesta.Caus1E,R180OreMinuti(Richiesta.Dalle1E),R180OreMinuti(Richiesta.Alle1E),ArrCausali[idx].AbbatteBudget,ArrCausali[idx].TipoRichiestaWeb);

  idx:=ArrCausaliGetIndex(Richiesta.Caus1U);
  if (idx >= 0) and (ArrCausali[idx].NoLimiteAnnualeLiq = 'N') then
    AddCheckBudget(Richiesta.Caus1U,R180OreMinuti(Richiesta.Dalle1U),R180OreMinuti(Richiesta.Alle1U),ArrCausali[idx].AbbatteBudget,ArrCausali[idx].TipoRichiestaWeb);

  for i:=1 to High(Richiesta.CausT) do
  begin
    idx:=ArrCausaliGetIndex(Richiesta.CausT[i]);
    if (idx >= 0) and (ArrCausali[idx].NoLimiteAnnualeLiq = 'N') then
      AddCheckBudget(Richiesta.CausT[i],R180OreMinuti(Richiesta.DalleT[i]),R180OreMinuti(Richiesta.AlleT[i]),ArrCausali[idx].AbbatteBudget,ArrCausali[idx].TipoRichiestaWeb);
  end;

  for i:=0 to High(CheckBudget) do
  begin
    if CheckBudget[i].AbbatteBudget = 'L' then
    begin
      with W026DM.selTotCaus do
      begin
        //10.8(9) ASTI_ASL19 171258: DatiCartellino deve essere aggiornato
        if (DatiCartellino.DataInizioMeseCont <> R180InizioMese(StrToDate(grdRichieste.medpValoreColonna(r,'DATA')))) or
           (DatiCartellino.Prog <> StrToInt(grdRichieste.medpValoreColonna(r,'PROGRESSIVO')))
        then
          DatiCartellino:=GetDatiCartellinoMese(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(StrToDate(grdRichieste.medpValoreColonna(r,'DATA'))));

        SetVariable('INIZIO',R180InizioMese(StrToDate(grdRichieste.medpValoreColonna(r,'DATA'))));
        SetVariable('FINE',R180FineMese(StrToDate(grdRichieste.medpValoreColonna(r,'DATA'))));
        SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        SetVariable('CAUSALI','''' + CheckBudget[i].Causali.Replace(',',''',''') + '''');
        SetVariable('ID',StrToInt(grdRichieste.medpValoreColonna(r,'ID')));
        Execute;
        if CheckBudget[i].TipoRichiestaWeb = 'P' then
        begin
          if DatiCartellino.EccLiqAnno + FieldAsInteger('TOTALE') + CheckBudget[i].NumOre > DatiCartellino.EccAutAnno then
          begin
            Result:=False;
            ErrMsg:=Format('Richiesta impedita: superato il limite dell''eccedenza liquidabile annua (%s ore)',[R180MinutiOre(DatiCartellino.EccAutAnno)]);
          end;
        end
        else if CheckBudget[i].TipoRichiestaWeb = 'R' then
        begin
          if DatiCartellino.RecMatAnno + FieldAsInteger('TOTALE') + CheckBudget[i].NumOre > DatiCartellino.RecAutAnno then
          begin
            Result:=False;
            ErrMsg:=Format('Richiesta impedita: superato il limite dell''eccedenza recuperabile annua (%s ore)',[R180MinutiOre(DatiCartellino.RecAutAnno)]);
          end;
        end

      end;
    end;
  end;
end;

function TW026FRichiestaStrGG.ControlliAutOK(const FN: String):Boolean;
// Effettua i controlli per l'autorizzazione
var
  i,c: Integer;
  LErrMsg: String;
begin
  Result:=False;
  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  Richiesta.Id:=StrToInt(grdRichieste.medpValoreColonna(i,'ID'));

  // controlli in base alla tipologia di spezzoni
  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    if not Controlli_EU(FN,LErrMsg) then
    begin
      MsgBox.MessageBox(LErrMsg,ESCLAMA);
      Exit;
    end;
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    Richiesta.Spez:=grdRichieste.medpValoreColonna(i,'SPEZ');

    // controlla che sia selezionato un solo checkbox
    c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
    if ((grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox).Checked) and
       ((grdRichieste.medpCompCella(i,c,1) as TmeIWCheckBox).Checked) then
    begin
      MsgBox.MessageBox('Selezionare una sola voce per l''autorizzazione!',INFORMA);
      Exit;
    end;

    // determina stato autorizzazione
    if (grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox).Checked then
      Richiesta.AutT:='S'
    else if (grdRichieste.medpCompCella(i,c,1) as TmeIWCheckBox).Checked then
      Richiesta.AutT:='N'
    else
      Richiesta.AutT:='';

    // SGIULIANOMILANESE_COMUNE - Commessa: 2013/115 SVILUPPO#2.ini
    // limite saldo mensile ricontrollato in fase di autorizzazione positiva
    if (Richiesta.AutT = 'S') and
       (Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile = 'S') then
    begin
      if not CtrlLimiteSaldoMeseAut(FN,LErrMsg) then
      begin
        MsgBox.MessageBox(LErrMsg,ESCLAMA);
        Exit;
      end;
    end;
    // SGIULIANOMILANESE_COMUNE - Commessa: 2013/115 SVILUPPO#2.fine
  end;
  Result:=True;
end;

function TW026FRichiestaStrGG.GetDiffArr(const Dalle, Alle, Caus: String): Integer;
var
  DalleHMin, AlleHMin, Arr, idx: Integer;
begin
  // converte ore in minuti
  DalleHMin:=R180OreMinutiExt(Dalle);
  AlleHMin:=R180OreMinutiExt(Alle);

  // estrae l'arrotondamento per la causale di presenza
  // se non indicata, utilizza SPEZZONE_MINIMO
  if Caus = '' then
    Arr:=MaxArrotRiepGG
  else
  begin
    idx:=ArrCausaliGetIndex(Caus);
    if idx < 0 then
      raise Exception.Create(Format('Causale "%s" non trovata!',[Caus]));
    Arr:=ArrCausali[idx].ArrotRiepGG;
    Arr:=IfThen(Arr > 1,Arr,0);
  end;

  // corregge periodo dalle - alle
  if AlleHMin < DalleHMin then
    AlleHMin:=AlleHMin + 1440;

  // restituisce la differenza arrot.
  Result:=Trunc(R180Arrotonda(Max(AlleHMin - DalleHMin,0),Arr,'D'));
end;

procedure TW026FRichiestaStrGG.edtOraAsyncExit(Sender: TObject; EventParams: TStringList);
var
  MinutiAttuali,MinutiAltro,MinutiTotali,MinutiDiff: Integer;
  Target,OreDiff,JsCode: String;
  IWEdtTarget: TmeIWEdit;
begin
  MinutiAttuali:=R180OreMinutiExt((Sender as TmeIWEdit).Text);
  MinutiTotali:=(Sender as TmeIWEdit).Tag;

  // calcola la differenza per valutare se impostarla sul campo di input opposto
  MinutiDiff:=MinutiTotali - MinutiAttuali;

  // determina il nome del componente opposto
  Target:=IfThen(Copy((Sender as TmeIWEdit).HTMLName,1,9) = 'EDTORAREC','EDTORAPAG','EDTORAREC') +
                 Copy((Sender as TmeIWEdit).HTMLName,10,3);

  // estrae il dato orario presente nel campo di input opposto
  IWEdtTarget:=(FindComponent(Target) as TmeIWEdit);
  if Assigned(IWEdtTarget) then
  begin
    MinutiAltro:=R180OreMinutiExt(IWEdtTarget.Text);

    if MinutiDiff < 0 then
    begin
      // differenza negativa: il valore attuale è troppo alto
      // valorizza il valore attuale con il massimo possibile
      (Sender as TmeIWEdit).Text:=R180MinutiOre(MinutiTotali - MinutiAltro);
    end
    else
    begin
      // differenza positiva
      // SGIULIANOMILANESE_COMUNE - commessa 2013/115.ini
      // valuta se aggiornare il campo di input opposto
      if (Parametri.CampiRiferimento.C90_W026EccedGGTutta <> 'N') or
         ((MinutiAttuali + MinutiAltro) > MinutiTotali) then
      begin
        // differenza in valore assoluto espressa in ore.minuti
        OreDiff:=R180MinutiOre(Max(MinutiDiff,0));
        JScode:=Format('document.getElementById("%s").value = "%s"',[Target,OreDiff]);
        GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(JsCode);
      end;
      // SGIULIANOMILANESE_COMUNE - commessa 2013/115.fine
    end;
  end;
end;

procedure TW026FRichiestaStrGG.TrasformaComponenti(const FN:String; DaTestoAControlli:Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa
// per la grid di richieste straordinario
var
  i,j,c,x,Prog,IdOrig,NumRichGG,TotPeriodo,idx,NumCaus: Integer;
  CausSel,Aut,TipoRichiesta,Spez,Dalle,Alle,Caus,Ora,Elemento,CodMotivazione: String;
  DataRif,DataBlocco: TDateTime;
  ListaCaus,ListaCausRec,ListaCausPag: TStringList;
  LBloccoRiep,DataOk,VisElimina,VisModifica: Boolean;
  LIWG: TmeIWGrid;
  IWLbl: TmeIWLabel;
  IWCmb: TmeIWComboBox;
  IWEdt: TmeIWEdit;
  IWChk: TmeIWCheckBox;
  LDatiModificabiliResp: Boolean;
  LivAut: Integer;
  IWMCmb: TMedpIWMultiColumnComboBox;
begin
  // pre: not SolaLettura
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  // caso di modifica tutto con righe non modificabili
  if not Assigned(grdRichieste.medpCompGriglia[i].CompColonne[0]) then
    Exit;

  if DaTestoAControlli then
  begin
    // comandi
    LIWG:=(grdRichieste.medpCompgriglia[i].CompColonne[0] as TmeIWGrid);
    LIWG.Cell[0,0].Css:='invisibile';
    LIWG.Cell[0,1].Css:='invisibile';
    LIWG.Cell[0,2].Css:=StileCella1;
    LIWG.Cell[0,3].Css:=StileCella2;

    ListaCaus:=TStringList.Create;
    // Bugfix: Utente: TORINO_ASLCITTA Chiamata: 124097.ini
    ListaCaus.NameValueSeparator:=NAME_VALUE_SEPARATOR;
    // Bugfix: Utente: TORINO_ASLCITTA Chiamata: 124097.fine
    try
      ListaCausRec:=TStringList.Create;
      ListaCausPag:=TStringList.Create;

      // popola liste di causali di presenza
      ListaCaus.Add('');
      for x:=1 to Length(ArrCausali) - 1 do
      begin
        ListaCaus.Values[ArrCausali[x].Text]:=ArrCausali[x].Codice;
        Elemento:=Format('%s;%s',[ArrCausali[x].Codice,ArrCausali[x].Descrizione]);
        if ArrCausali[x].TipoRichiestaWeb = 'R' then
          ListaCausRec.Add(Elemento)
        else if ArrCausali[x].TipoRichiestaWeb = 'P' then
          ListaCausPag.Add(Elemento);
      end;

      // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
      // per il responsabile determina se i dati sono modificabili al livello di autorizzazione
      LDatiModificabiliResp:=GetLDatiModificabiliResp(i);
      // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine

      if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
      begin
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        // per l'autorizzatore i dati sono modificabili solo se il flag corrispondente è abilitato al proprio livello
        if not WR000DM.Responsabile or LDatiModificabiliResp then
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
        begin
          // causale entrata
          if grdRichieste.medpValoreColonna(i,'SPEZ_E') <> '' then
          begin
            // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini

            // label spezzone di entrata
            c:=grdRichieste.medpIndexColonna('SPEZ_E');
            grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'','','','','S');
            grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
            IWLbl:=(grdRichieste.medpCompCella(i,c,0) as TmeIWLabel);
            IWLbl.Caption:=grdRichieste.medpValoreColonna(i,'SPEZ_E');
            IWLbl.Css:='font_grassetto font_inheritImp';

            // combobox causale entrata
            if grdRichieste.medpColonna('CAUS1_E').Visible then
            // MONDOEDP - commessa MAN/07 SVILUPPO#68.fine
            begin
              c:=grdRichieste.medpIndexColonna('CAUS1_E');
              grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'30','','','','S');
              grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
              IWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
              IWCmb.ItemsHaveValues:=True;
              // Bugfix: Utente: TORINO_ASLCITTA Chiamata: 124097.ini
              IWCmb.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
              // Bugfix: Utente: TORINO_ASLCITTA Chiamata: 124097.fine
              IWCmb.Items.Assign(ListaCaus);
              if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = T325TR_I then
                CausSel:=Parametri.CampiRiferimento.C90_W026CausE
              else
                CausSel:=grdRichieste.medpValoreColonna(i,'CAUS1_E');
              IWCmb.ItemIndex:=Max(0,R180IndexOf(IWCmb.Items,CausSel,5));
            end;

            // autorizzazione entrata (se tipo richiesta "A")
            if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) or
               (WR000DM.Responsabile) then
            begin
              c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE_E');
              grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','',''); // Grid = False è indispensabile per evitare errori IW
              grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
              Aut:=grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE_E');
              IWChk:=(grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox);
              IWChk.Checked:=Aut = 'S';
              IWChk.Tag:=1;
            end;
          end;

          // causale uscita
          if grdRichieste.medpValoreColonna(i,'SPEZ_U') <> '' then
          begin
            // MONDOEDP - commessa MAN/07 SVILUPPO#68.ini

            // label spezzone di uscita
            c:=grdRichieste.medpIndexColonna('SPEZ_U');
            grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'','','','','S');
            grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
            IWLbl:=(grdRichieste.medpCompCella(i,c,0) as TmeIWLabel);
            IWLbl.Caption:=grdRichieste.medpValoreColonna(i,'SPEZ_U');
            IWLbl.Css:='font_grassetto font_inheritImp';

            // combobox causale entrata
            if grdRichieste.medpColonna('CAUS1_U').Visible then
            // MONDOEDP - commessa MAN/07 SVILUPPO#68.fine
            begin
              c:=grdRichieste.medpIndexColonna('CAUS1_U');
              grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'30','','','','S');
              grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
              IWCmb:=(grdRichieste.medpCompCella(i,c,0) as TmeIWComboBox);
              IWCmb.ItemsHaveValues:=True;
              // Bugfix: Utente: TORINO_ASLCITTA Chiamata: 124097.ini
              IWCmb.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
              // Bugfix: Utente: TORINO_ASLCITTA Chiamata: 124097.fine
              IWCmb.Items.Assign(ListaCaus);
              if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = T325TR_I then
                CausSel:=Parametri.CampiRiferimento.C90_W026CausU
              else
                CausSel:=grdRichieste.medpValoreColonna(i,'CAUS1_U');
              IWCmb.ItemIndex:=Max(0,R180IndexOf(IWCmb.Items,CausSel,5));
            end;

            // uscita alle
            if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione <> 'T' then
            begin
              c:=grdRichieste.medpIndexColonna('SPEZ_ALLE1_U');
              grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','','S');
              grdRichieste.medpCreaComponenteGenerico(i,C,grdRichieste.Componenti);
              IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
              if grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA') = T325TR_I then
                IWEdt.Text:=Copy(grdRichieste.medpValoreColonna(i,'SPEZ_U'),7,5)
              else
                IWEdt.Text:=grdRichieste.medpValoreColonna(i,'SPEZ_ALLE1_U');
            end;

            // autorizzazione uscita (se tipo richiesta "A")
            if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) or (WR000DM.Responsabile) then
            begin
              c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE_U');
              grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','','','',''); // Grid = False è indispensabile per evitare errori IW
              grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
              Aut:=grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE_U');
              IWChk:=(grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox);
              IWChk.Checked:=Aut = 'S';
              IWChk.Tag:=2;
            end;
          end;
        end;
      end
      else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
      begin
        if WR000DM.Responsabile then
        begin
          // autorizzazione
          c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
          grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CHK,'','Si','','','S');
          grdRichieste.medpPreparaComponenteGenerico('C',0,1,DBG_CHK,'','No','','','S');
          grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);
          Aut:=grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE');

          // checkbox di autorizzazione "Sì"
          IWChk:=(grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox);
          IWChk.Checked:=Aut = 'S';
          IWChk.OnAsyncClick:=chkAutSiNoAsyncClick;

          // checkbox di autorizzazione "No"
          IWChk:=(grdRichieste.medpCompCella(i,c,1) as TmeIWCheckBox);
          IWChk.Checked:=Aut = 'N';
          IWChk.OnAsyncClick:=chkAutSiNoAsyncClick;
        end;
        if (not WR000DM.Responsabile) or LDatiModificabiliResp then
        begin
          // richiesta
          TipoRichiesta:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
          TotPeriodo:=StrToInt(grdRichieste.medpValoreColonna(i,'C_SPEZ_MIN'));
          for j:=2 downto 1 do
          begin
            if TipoRichiesta = T325TR_I then
            begin
              // nuova richiesta: propone i dati dello spezzone orig.
              // spezzone n>1 -> dati nulli
              if j = 1 then
                Ora:=R180MinutiOre(TotPeriodo) // recupero
              else
                Ora:='00.00'; // pagamento
            end
            else
            begin
              // modifica richiesta
              Dalle:=grdRichieste.medpValoreColonna(i,Format('SPEZ_DALLE%d',[j]));
              Alle:=grdRichieste.medpValoreColonna(i,Format('SPEZ_ALLE%d',[j]));
              if Dalle = '' then
                Ora:='00.00'
              else
                Ora:=R180MinutiOre(R180OreMinutiExt(Alle) - R180OreMinutiExt(Dalle));
              Caus:=grdRichieste.medpValoreColonna(i,Format('CAUS%d',[j]));
              (*Annullata la gestione della Rettifica
              if (j = 1) and (Dalle = '') and (IsRettifica(StrToInt(grdRichieste.medpValoreColonna(i,'ID')),IdOrig)) then
              begin
                // richiesta di rettifica: propone spezzone orig. se non ci sono ancora dati
                Ora:=R180MinutiOre(TotPeriodo);
              end;
              *)
            end;

            c:=grdRichieste.medpIndexColonna(IfThen(j = 1,'C_SPEZ_REC','C_SPEZ_PAG'));
            // edit numero ore + causale (eventuale combo)
            NumCaus:=IfThen(j = 1,ContaRec,ContaPag);
            if NumCaus >= 1 then
            begin
              grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','','',IfThen(NumCaus > 1,'S','C'));
              if NumCaus > 1 then
                grdRichieste.medpPreparaComponenteGenerico('C',0,1,DBG_MECMB,'20','2','','','S');
              grdRichieste.medpCreaComponenteGenerico(i,c,grdRichieste.Componenti);

              // edit delle ore a recupero / in pagamento
              IWEdt:=(grdRichieste.medpCompCella(i,c,0) as TmeIWEdit);
              IWEdt.Name:=IfThen(j = 1,'edtOraRec','edtOraPag') + Format('%.3d',[i]);
              IWEdt.Text:=Ora;
              IWEdt.Tag:=TotPeriodo;
              IWEdt.Visible:=(Dalle <> '');
              IWEdt.OnAsyncExit:=edtOraAsyncExit;
              // focus sul campo ore a recupero nei seguenti casi:
              // - modifica tutto:    focus sul campo nella prima riga
              // - modifica puntuale: focus sul campo nella riga attuale
              if (j = 1) and ((i = 0) or (not InModificaTutti)) then
                IWEdt.SetFocus;
            end;

            // combobox per causali (solo se causale non unica)
            if NumCaus > 1 then
            begin
              IWMCmb:=(grdRichieste.medpCompCella(i,c,1) as TmedpIWMultiColumnComboBox);
              IWMCmb.LookupColumn:=1;
              IWMCmb.PopUpHeight:=10;
              if j = 1 then
              begin
                // caus. a recupero
                for x:=0 to ListaCausRec.Count - 1 do
                  IWMCmb.AddRow(ListaCausRec[x]);
              end
              else
              begin
                // caus. in pagamento
                for x:=0 to ListaCausPag.Count - 1 do
                  IWMCmb.AddRow(ListaCausPag[x]);
              end;
              IWMCmb.NonEditableAsLabel:=False;
              IWMCmb.Text:=Caus;
            end;
          end;
        end;
      end;

      // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
      // per l'autorizzatore i dati sono modificabili solo se il flag corrispondente è abilitato al proprio livello
      if (not WR000DM.Responsabile) and
         (not SolaLettura) and
         (Length(ArrMotivazioni) > 0) then
      begin
        grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'40','','Selezionare la motivazione per la richiesta','','S');
        grdRichieste.medpCreaComponenteGenerico(i,grdRichieste.medpIndexColonna('MOTIVAZIONE'),grdRichieste.Componenti);
        IWCmb:=(grdRichieste.medpCompCella(i,'MOTIVAZIONE',0) as TmeIWComboBox);
        IWCmb.NoSelectionText:='';
        IWCmb.RequireSelection:=True;
        IWCmb.ItemsHaveValues:=True;
        IWCmb.Items.BeginUpdate;
        for x:=0 to Length(ArrMotivazioni) - 1 do
          IWCmb.Items.Values[ArrMotivazioni[x].Descrizione]:=ArrMotivazioni[x].Codice;
        IWCmb.Items.EndUpdate;
        if TipoRichiesta = T325TR_I then
        begin
          // richiesta inseribile: propone motivazione di default
          IWCmb.ItemIndex:=MotivazioneDefault;
        end
        else
        begin
          // modifica: visualizza quanto già impostato
          CodMotivazione:=grdRichieste.medpValoreColonna(i,'MOTIVAZIONE');
          idx:=0;
          for i:=Low(ArrMotivazioni) to High(ArrMotivazioni) do
          begin
            if ArrMotivazioni[i].Codice = CodMotivazione then
            begin
              idx:=i;
              Break;
            end;
          end;
          IWCmb.ItemIndex:=idx;
        end;
      end;
      // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
    finally
      FreeAndNil(ListaCaus);
      FreeAndNil(ListaCausRec);
      FreeAndNil(ListaCausPag);
    end;
  end
  else
  begin
    // testo
    TipoRichiesta:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
    DataRif:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
    DataBlocco:=R180InizioMese(DataRif);
    Prog:=StrToInt(grdRichieste.medpValoreColonna(i,'PROGRESSIVO'));
    LBloccoRiep:=WR000DM.SelDatiBloccati.DatoBloccato(Prog,DataBlocco,'T070');
    if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione = 'T' then
      LBloccoRiep:=LBloccoRiep or (WR000DM.SelDatiBloccati.DatoBloccato(Prog,DataBlocco,'T100'));

    // abilitazione cancellazione / modifica
    VisElimina:=(not WR000DM.Responsabile) and
                (R180In(TipoRichiesta,[T325TR_R,T325TR_P])) and
                (not LBloccoRiep) ;
    VisModifica:=((R180In(TipoRichiesta,[T325TR_I,T325TR_R,T325TR_P])) or
                  (WR000DM.Responsabile and (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') and (TipoRichiesta = T325TR_E))) and
                 (not LBloccoRiep);

    if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
    begin
      // TORINO_COMUNE
      // in questo caso la modifica e la cancellazione sono legate al fatto che la data
      // rientri nel periodo (fisso) del mese precedente
      DataOk:=((DataRif >= DataInizioModCanc) and (DataRif <= DataFineModCanc)) or (DebugHook <> 0);
      VisModifica:=VisModifica and DataOk;
      VisElimina:=VisElimina and DataOk;
    end;

    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) and VisElimina then
    begin
      // ROMA_HSANDREA
      // Annullamento possibile solo se tutte le richieste del giorno hanno tipo richiesta uguale
      W026DM.selRichiesteGiorno.SetVariable('DATARIF',DataRif);
      W026DM.selRichiesteGiorno.SetVariable('PROGRESSIVO',Prog);
      try
        W026DM.selRichiesteGiorno.Execute;
        VisElimina:=W026DM.selRichiesteGiorno.FieldAsString(1) = 'S';
      except
        on E: Exception do
        begin
          MsgBox.MessageBox('Errore durante la visualizzazione delle richieste: ' + E.Message + CRLF + 'Tipo: ' + E.ClassName,ESCLAMA);
          Exit;
        end;
      end;
    end;

    LIWG:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
    if LIWG <> nil then
    begin
      if LBloccoRiep then
      begin
        LIWG.Cell[0,0].Css:='datiBloccati';
        LIWG.Cell[0,1].Css:='invisibile';
      end
      else
      begin
        LIWG.Cell[0,0].Css:=IfThen(VisElimina,StileCella1,'invisibile');
        LIWG.Cell[0,1].Css:=IfThen(VisModifica,StileCella2,'invisibile');
      end;
      LIWG.Cell[0,2].Css:='invisibile';
      LIWG.Cell[0,3].Css:='invisibile';
    end;

    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    begin
      // causale entrata
      if CausUnica = '' then
        FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('CAUS1_E')]);
      // autorizzazione entrata
      FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE_E')]);
      // causale uscita
      if CausUnica = '' then
        FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('CAUS1_U')]);
      // uscita alle
      FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('SPEZ_ALLE1_U')]);
      // autorizzazione uscita
      FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE_U')]);
    end
    else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
    begin
      if WR000DM.Responsabile then
      begin
        //solo autorizzazione
        FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE')]);
      end;
      //autorizzazione e richiesta: spezzoni recupero e pagamento (DC - chiamata <147438>)
      FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_SPEZ_REC')]);
      FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('C_SPEZ_PAG')]);
    end;

    // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
    // motivazione
    if (not SolaLettura) and
       (Length(ArrMotivazioni) > 0) then
    begin
      try FreeAndNil(grdRichieste.medpCompgriglia[i].CompColonne[grdRichieste.medpIndexColonna('MOTIVAZIONE')]); except end;
    end;
    // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
  end;
end;

procedure TW026FRichiestaStrGG.BloccaComponenti(const FN:String);
// blocca i componenti della riga indicata per la grid di richieste straordinario
// (utilizzata nel ciclo di conferma massiva delle autorizzazioni)
var
  i,c: Integer;
  IWC: TIWCustomControl;
begin
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    // eccedenza in entrata
    if grdRichieste.medpValoreColonna(i,'SPEZ_E') <> '' then
    begin
      // spezzone entrata
      IWC:=grdRichieste.medpCompCella(i,'SPEZ_E',0);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);

      // causale entrata
      IWC:=grdRichieste.medpCompCella(i,'CAUS1_E',0);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);

      // autorizzazione entrata (se tipo richiesta "A")
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
      begin
        AbilitazioneComponente((grdRichieste.medpCompCella(i,'D_AUTORIZZAZIONE_E',0)),False);
      end;
    end;

    // eccedenza in uscita
    if grdRichieste.medpValoreColonna(i,'SPEZ_U') <> '' then
    begin
      // spezzone entrata
      IWC:=grdRichieste.medpCompCella(i,'SPEZ_U',0);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);

      // causale uscita
      IWC:=grdRichieste.medpCompCella(i,'CAUS1_U',0);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);

      // uscita alle
      if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione <> 'T' then
      begin
        AbilitazioneComponente((grdRichieste.medpCompCella(i,'SPEZ_ALLE1_U',0)),False);
      end;

      // autorizzazione uscita (se tipo richiesta "A")
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
      begin
        AbilitazioneComponente((grdRichieste.medpCompCella(i,'D_AUTORIZZAZIONE_U',0)),False);
      end;
    end;
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    // blocca l'impostazione dell'autorizzazione / richiesta
    if WR000DM.Responsabile then
    begin
      c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
      AbilitazioneComponente((grdRichieste.medpCompCella(i,c,0) as TmeIWCheckBox),False);
      AbilitazioneComponente((grdRichieste.medpCompCella(i,c,1) as TmeIWCheckBox),False);
    end
    else
    begin
      // componenti edtOraRecnnn + eventuale combo causali recupero
      c:=grdRichieste.medpIndexColonna('C_SPEZ_REC');
      IWC:=grdRichieste.medpCompCella(i,c,0);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);
      IWC:=grdRichieste.medpCompCella(i,c,1);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);

      // componente edtOraPagnnn + eventuale combo causali pagamento
      c:=grdRichieste.medpIndexColonna('C_SPEZ_PAG');
      IWC:=grdRichieste.medpCompCella(i,c,0);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);
      IWC:=grdRichieste.medpCompCella(i,c,1);
      if Assigned(IWC) then
        AbilitazioneComponente(IWC,False);
    end;
  end;

  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
  IWC:=grdRichieste.medpCompCella(i,'MOTIVAZIONE',0);
  if Assigned(IWC) then
    AbilitazioneComponente(IWC,False);
  // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
end;

procedure TW026FRichiestaStrGG.btnConfermaAutClick(Sender: TObject);
var
  LErrModCan: Boolean;
  LField: TField;
begin
  // inizializzazione variabili
  ConfermaAutorizzazioniInCorso:=True;
  LErrModCan:=False;

  // importazione delle richieste su cartellino
  try
    cdsGrid.First;
    while not cdsGrid.Eof do
    begin
      // imposta i dati in RecordRichiesta per l'elaborazione
      Richiesta.Eliminata:=False;
      Richiesta.Id:=cdsGrid.FieldByName('ID').AsInteger;
      if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
        Richiesta.Spez:=cdsGrid.FieldByName('SPEZ').AsString;

      // imposta autorizzazione spezzone
      LField:=cdsGrid.FindField('AUTORIZZAZIONE');
      if LField <> nil then
        Richiesta.AutT:=LField.AsString
      else
        Richiesta.AutT:='';
      LField:=cdsGrid.FindField('AUTORIZZAZIONE_E');
      if LField <> nil then
        Richiesta.AutE:=LField.AsString
      else
        Richiesta.AutE:='';
      LField:=cdsGrid.FindField('AUTORIZZAZIONE_U');
      if LField <> nil then
        Richiesta.AutU:=LField.AsString
      else
        Richiesta.AutU:='';

      // elabora la richiesta sul cartellino
      try
        actAutorizzazioneOK(TTipoElab.Applica);
      except
        // errore probabilmente dovuto a record modificato / cancellato da altro utente
        on E: Exception do
          LErrModCan:=True;
      end;
      cdsGrid.Next;
    end;
  finally
    // segnala fine elaborazione
    ConfermaAutorizzazioniInCorso:=False;
  end;

  // se non ci sono errori imposta il filtro su "Richieste autorizzate"
  // solo per ROMA_HSANDREA
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'N') and
     (not LErrModCan) then
    C018.TipoRichiesteSel:=[trAutorizzate];

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  if LErrModCan then
    MsgBox.MessageBox('Alcune richieste non sono state elaborate correttamente.'#13#10 +
                      'Verificare le richieste ancora disponibili',ESCLAMA);
end;

procedure TW026FRichiestaStrGG.btnEseguiConteggiClick(Sender: TObject);
// esegue la funzione di applicafiltro
begin
  EseguiConteggi:=True;
  IterBaseApplicaFiltro(Sender);
end;

procedure TW026FRichiestaStrGG.btnRichiestaCumulativaClick(Sender: TObject);
// richiesta cumulativa (TORINO_COMUNE)
var
  LDataRich: TDateTime;
begin
  LDataRich:=Now;
  cdsGrid.First;
  while not cdsGrid.Eof do
  begin
    C018.Id:=cdsGrid.FieldByName('ID').AsInteger;
    if (cdsGrid.FieldByName('TIPO_RICHIESTA').AsString = T325TR_P) and (cdsGrid.FieldByName('COD_ITER').IsNull) then
    begin
      try
        C018.SetTipoRichiesta(T325TR_R);
        C018.SetDataRichiesta(LDataRich);
        C018.SetCodIter;
        // gestione manuale invio mail.ini
        C018.VerificaRichiestaEsistente('');
        SessioneOracle.Commit;
        // gestione manuale invio mail.fine
      except
        on E: Exception do
        begin
          SessioneOracle.Commit;
          VisualizzaDipendenteCorrente;
          MsgBox.MessageBox(Format('Si è verificato un errore durante l''inserimento della richiesta cumulativa:'#13#10'%s',[E.Message]),ERRORE);
          Exit;
        end;
      end;
    end;
    cdsGrid.Next;
  end;
  VisualizzaDipendenteCorrente;
end;

function TW026FRichiestaStrGG.IsRigaInModificaTutti(const FN:String): Boolean;
// funzione utilizzata in fase di conferma massiva delle autorizzazioni / richieste
// determina se la riga è da considerare
var
  i,c: Integer;
begin
  Result:=False;

  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    // label spezzone entrata
    if grdRichieste.medpValoreColonna(i,'SPEZ_E') <> '' then
    begin
      Result:=Assigned(grdRichieste.medpCompCella(i,'SPEZ_E',0));
      if Result then
        Exit;
    end;

    // label spezzone uscita
    if grdRichieste.medpValoreColonna(i,'SPEZ_U') <> '' then
    begin
      Result:=Assigned(grdRichieste.medpCompCella(i,'SPEZ_U',0));
      if Result then
        Exit;
    end;
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    // autorizzazione
    if WR000DM.Responsabile then
      c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE')
    else
      c:=grdRichieste.medpIndexColonna('C_SPEZ_REC');
    Result:=Assigned(grdRichieste.medpCompCella(i,c,0));
  end;
end;

function TW026FRichiestaStrGG.IsRigaBloccata(const FN:String): Boolean;
// funzione utilizzata in fase di conferma massiva delle autorizzazioni / richieste
var
  i,c: Integer;
begin
  Result:=False;

  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    // causale entrata
    if grdRichieste.medpValoreColonna(i,'SPEZ_E') <> '' then
    begin
      Result:=not (grdRichieste.medpCompCella(i,'SPEZ_E',0) as TmeIWLabel).Enabled;
      if Result then
        Exit;
    end;

    // causale uscita
    if grdRichieste.medpValoreColonna(i,'SPEZ_U') <> '' then
    begin
      Result:=not (grdRichieste.medpCompCella(i,'SPEZ_U',0) as TmeIWLabel).Enabled;
      if Result then
        Exit;
    end;
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    // autorizzazione
    if WR000DM.Responsabile then
      c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE')
    else
      c:=grdRichieste.medpIndexColonna('C_SPEZ_REC');
    Result:=not grdRichieste.medpCompCella(i,c,0).Enabled;
  end;
end;

procedure TW026FRichiestaStrGG.AllineaCdsGrid;
var
  j: Integer;
begin
  try
    cdsGrid.Edit;
    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    begin
      // entrata
      if Richiesta.Dalle1E <> '' then
      begin
        cdsGrid.FieldByName('SPEZ_DALLE1_E').AsString:=Richiesta.Dalle1E;
        cdsGrid.FieldByName('SPEZ_ALLE1_E').AsString:=Richiesta.Alle1E;
        cdsGrid.FieldByName('CAUS1_E').AsString:=Richiesta.Caus1E;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        cdsGrid.FieldByName('MOTIVAZIONE_E').AsString:=Richiesta.Motivazione;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
        (*TO2: serve per poter valutare il dato in fase di validazione richiesta
        if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
          cdsGrid.FieldByName('AUTORIZZAZIONE_E').AsString:=Richiesta.AutE;
        *)
      end;
      // uscita
      if Richiesta.Dalle1U <> '' then
      begin
        cdsGrid.FieldByName('SPEZ_DALLE1_U').AsString:=Richiesta.Dalle1U;
        cdsGrid.FieldByName('SPEZ_ALLE1_U').AsString:=Richiesta.Alle1U;
        cdsGrid.FieldByName('CAUS1_U').AsString:=Richiesta.Caus1U;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        cdsGrid.FieldByName('MOTIVAZIONE_U').AsString:=Richiesta.Motivazione;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
        (*TO2: serve per poter valutare il dato in fase di validazione richiesta
        if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
          cdsGrid.FieldByName('AUTORIZZAZIONE_U').AsString:=Richiesta.AutU;
        *)
      end;
    end
    else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
    begin
      // ciclo spezzoni
      for j:=1 to 2 do
      begin
        if Richiesta.AlleT[j] > Richiesta.DalleT[j] then
        begin
          cdsGrid.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString:=Richiesta.DalleT[j];
          cdsGrid.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString:=Richiesta.AlleT[j];
          cdsGrid.FieldByName(Format('CAUS%d',[j])).AsString:=Richiesta.CausT[j];
        end
        else
        begin
          cdsGrid.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString:='';
          cdsGrid.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString:='';
          cdsGrid.FieldByName(Format('CAUS%d',[j])).AsString:='';
        end;
      end;
      // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
      cdsGrid.FieldByName('MOTIVAZIONE').AsString:=Richiesta.Motivazione;
      // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
      (*TO2: serve per poter valutare il dato in fase di validazione richiesta
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
        cdsGrid.FieldByName('AUTORIZZAZIONE').AsString:=Richiesta.AutT;
      *)
  end;
  except
    on E: Exception do
    begin
      Log('Errore','actInsRichiesta',E);
      MsgBox.TextIsHTML:=False;
      MsgBox.MessageBox('Inserimento richiesta fallito!' + CRLF +
                        E.Message + CRLF +
                        'Tipo: ' + E.ClassName,ERRORE);
      Exit;
    end;
  end;
end;

procedure TW026FRichiestaStrGG.actInsRichiesta;
// inserimento della richiesta
begin
  AllineaCdsGrid;

  // valori ok: passa all'inserimento della richiesta
  if (not SalvataggioParziale) and // warning non gestito se salvataggio parziale
     (not C018.WarningRichiesta) then
  begin
    Messaggio('Conferma',C018.MessaggioOperazione + CRLF + 'Vuoi continuare?',ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end
  else
  begin
    ConfermaInsRichiesta;
  end;
end;

procedure TW026FRichiestaStrGG.actModRichiesta;
var
  j: Integer;
  LTipoRich: String;
  LTipoElab: TTipoElab;
begin
  LTipoRich:=cdsGrid.FieldByName('TIPO_RICHIESTA').AsString;
  try
    // apre i dataset di supporto per la modifica
    R180SetVariable(W026DM.selT325,'PROGRESSIVO',cdsGrid.FieldByName('PROGRESSIVO').AsInteger);
    W026DM.selT325.Open;
    R180SetVariable(W026DM.selT326,'PROGRESSIVO',cdsGrid.FieldByName('PROGRESSIVO').AsInteger);
    W026DM.selT326.Open;

    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    begin
      // entrata
      if W026DM.selT326.SearchRecord('ID_T850;TIPO',VarArrayOf([Richiesta.Id,'E']),[srFromBeginning]) then
      begin
        W026DM.selT326.Edit;
        W026DM.selT326.FieldByName('SPEZ_DALLE1').AsString:=Richiesta.Dalle1E;
        W026DM.selT326.FieldByName('SPEZ_ALLE1').AsString:=Richiesta.Alle1E;
        W026DM.selT326.FieldByName('CAUS1').AsString:=Richiesta.Caus1E;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        W026DM.selT326.FieldByName('MOTIVAZIONE').AsString:=Richiesta.Motivazione;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
        W026DM.selT326.Post;
        SessioneOracle.Commit;
        // autorizzazione contestuale
        if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) and
           (LTipoRich <> T325TR_P) then
        begin
          // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
          if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
            LTipoElab:=TTipoElab.Autorizza
          else
            LTipoElab:=TTipoElab.AutorizzaApplica;
          ImpostaAutorizzazione(LTipoElab,'E');
        end;
      end;
      // uscita
      if W026DM.selT326.SearchRecord('ID_T850;TIPO',VarArrayOf([Richiesta.Id,'U']),[srFromBeginning]) then
      begin
        W026DM.selT326.Edit;
        W026DM.selT326.FieldByName('SPEZ_DALLE1').AsString:=Richiesta.Dalle1U;
        W026DM.selT326.FieldByName('SPEZ_ALLE1').AsString:=Richiesta.Alle1U;
        W026DM.selT326.FieldByName('CAUS1').AsString:=Richiesta.Caus1U;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        W026DM.selT326.FieldByName('MOTIVAZIONE').AsString:=Richiesta.Motivazione;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
        W026DM.selT326.Post;
        SessioneOracle.Commit;
        // autorizzazione contestuale
        if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) and
           (LTipoRich <> T325TR_P) then
        begin
          // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
          if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
            LTipoElab:=TTipoElab.Autorizza
          else
            LTipoElab:=TTipoElab.AutorizzaApplica;
          ImpostaAutorizzazione(LTipoElab,'U');
        end;
      end;
    end
    else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
    begin
      // TORINO_COMUNE
      if W026DM.selT326.SearchRecord('ID_T850;TIPO;SPEZ',VarArrayOf([Richiesta.Id,'T',Richiesta.Spez]),[srFromBeginning]) then
      begin
        W026DM.selT326.Edit;
        for j:=1 to 2 do
        begin
          if Richiesta.AlleT[j] > Richiesta.DalleT[j] then
          begin
            W026DM.selT326.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString:=Richiesta.DalleT[j];
            W026DM.selT326.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString:=Richiesta.AlleT[j];
            W026DM.selT326.FieldByName(Format('CAUS%d',[j])).AsString:=Richiesta.CausT[j];
          end
          else
          begin
            W026DM.selT326.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString:='';
            W026DM.selT326.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString:='';
            W026DM.selT326.FieldByName(Format('CAUS%d',[j])).AsString:='';
          end;
        end;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        W026DM.selT326.FieldByName('MOTIVAZIONE').AsString:=Richiesta.Motivazione;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
        W026DM.selT326.Post;
        SessioneOracle.Commit;

        // autorizzazione contestuale
        if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) and
           (LTipoRich <> T325TR_P) then
        begin
          // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
          if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
            LTipoElab:=TTipoElab.Autorizza
          else
            LTipoElab:=TTipoElab.AutorizzaApplica;
          ImpostaAutorizzazione(LTipoElab,'T');
        end;
      end;
    end;
  finally
    // se modifica puntuale effettua alcune considerazioni
    if not InModificaTutti then
    begin
      VisualizzaDipendenteCorrente;
    end;
  end;
end;

procedure TW026FRichiestaStrGG.AggiornaConteggiT325(const PProg: Integer; const PData: TDateTime);
var
  LRitardo: Integer;
  j: Integer;
begin
  R502ProDtM1:=TR502ProDtM1.Create(Self);
  try
    R502ProDtM1.PeriodoConteggi(PData,PData);
    R502ProDtM1.ConsideraRichiesteWeb:=False;
    R502ProDtM1.Conteggi('Cartolina',PProg,PData);
    if (R502ProDtM1.Blocca = 0) then
    begin
      W026DM.selT325.Edit;
      W026DM.selT325.FieldByName('ORE_LORDE').AsString:=R180MinutiOre(R502ProDtM1.OreReseTotali + R502ProDtM1.ProlungamentoNonCausalizzato['']);
      W026DM.selT325.FieldByName('ORE_CONTEGGIATE').AsString:=R180MinutiOre(R502ProDtM1.OreReseTotali);
      W026DM.selT325.FieldByName('DEBITO').AsString:=R180MinutiOre(R502ProDtM1.debitogg);
      W026DM.selT325.FieldByName('DETR_MENSA').AsString:=R180MinutiOre(R502ProDtM1.paumendet);
      LRitardo:=0;
      for j:=1 to R502ProDtM1.n_timbrnom do
        LRitardo:=LRitardo + R502ProDtM1.ttimbraturenom[j].Ritardo;
      W026DM.selT325.FieldByName('RITARDO').AsString:=R180MinutiOre(LRitardo);
      W026DM.selT325.Post;
      SessioneOracle.Commit;
    end;
  finally
    FreeAndNil(R502ProDtM1);
  end;
end;

procedure TW026FRichiestaStrGG.ConfermaInsRichiesta;
var
  LProg,LIdIns,LIdT325,LIdOrig_T, j: Integer;
  LData: TDateTime;
  LTipo: Char;
  LErr, LTitolo: String;
  LTipoElab: TTipoElab;
  EsisteRichiesta: Boolean;
begin
  try
    EsisteRichiesta:=True;
    if SalvataggioParziale then
    begin
      // inserimento manuale della richiesta su T850
      W026DM.insT850Man.ClearVariables;
      W026DM.insT850Man.SetVariable('ITER',Iter);
      W026DM.insT850Man.SetVariable('DATA',Now);
      W026DM.insT850Man.SetVariable('TIPO_RICHIESTA',T325TR_P);
      try
        W026DM.insT850Man.Execute;
        LIdIns:=W026DM.insT850Man.GetVariable('ID');
      except
        on E:Exception do
        begin
          W026DM.cdsT325Vis.Cancel;
          raise Exception.Create(E.Message);
        end;
      end;
    end
    else
    begin
      // inserimento automatico della richiesta su T850
      C018.InsRichiesta(IfThen(InsRichFittizio,T325TR_I,T325TR_R),'','');
      if C018.MessaggioOperazione <> '' then
      begin
        W026DM.cdsT325Vis.Cancel;
        if not C018.CondizioniValiditaOk then
          raise EC018RichiestaNonValidaException.Create(C018.MessaggioOperazione)
        else
          raise Exception.Create(C018.MessaggioOperazione);
      end;
      LIdIns:=C018.Id;
      EseguitoInsRichiesta:=True;
    end;

    // apre i dataset di supporto per l'inserimento
    LProg:=cdsGrid.FieldByName('PROGRESSIVO').AsInteger;
    LData:=cdsGrid.FieldByName('DATA').AsDateTime;

    R180SetVariable(W026DM.selT325,'PROGRESSIVO',LProg);
    W026DM.selT325.Open;
    R180SetVariable(W026DM.selT326,'PROGRESSIVO',LProg);
    W026DM.selT326.Open;

    // inserimento record di testata su T325
    W026DM.selT325.Append;
    W026DM.selT325.FieldByName('PROGRESSIVO').AsInteger:=LProg;
    W026DM.selT325.FieldByName('DATA').AsDateTime:=cdsGrid.FieldByName('DATA').AsDateTime;
    W026DM.selT325.FieldByName('TIMBRATURE').AsString:=cdsGrid.FieldByName('TIMBRATURE').AsString;
    W026DM.selT325.FieldByName('ORE_LORDE').AsString:=cdsGrid.FieldByName('ORE_LORDE').AsString;
    W026DM.selT325.FieldByName('ORE_CONTEGGIATE').AsString:=cdsGrid.FieldByName('ORE_CONTEGGIATE').AsString;
    W026DM.selT325.FieldByName('DEBITO').AsString:=cdsGrid.FieldByName('DEBITO').AsString;
    W026DM.selT325.FieldByName('DETR_MENSA').AsString:=cdsGrid.FieldByName('DETR_MENSA').AsString;
    W026DM.selT325.FieldByName('RITARDO').AsString:=cdsGrid.FieldByName('RITARDO').AsString;
    W026DM.selT325.Post;
    LIdT325:=W026DM.selT325.FieldByName('ID').AsInteger;

    // inserimento spezzoni di dettaglio su T326
    if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
    begin
      // spezzoni abilitati (TORINO_COMUNE)
      W026DM.selT326.Append;
      W026DM.selT326.FieldByName('ID').AsInteger:=LIdT325;
      W026DM.selT326.FieldByName('ID_T850').AsInteger:=LIdIns;
      W026DM.selT326.FieldByName('TIPO').AsString:='T'; // tipologia fissa = T
      W026DM.selT326.FieldByName('SPEZ').AsString:=cdsGrid.FieldByName('SPEZ').AsString;
      W026DM.selT326.FieldByName('DATA_SPEZ').AsDateTime:=cdsGrid.FieldByName('DATA_SPEZ').AsDateTime;
      W026DM.selT326.FieldByName('CAUS_ORIG').AsString:=cdsGrid.FieldByName('CAUS_ORIG').AsString;
      for j:=1 to 2 do
      begin
        W026DM.selT326.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString:=cdsGrid.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString;
        W026DM.selT326.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString:=cdsGrid.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString;
        W026DM.selT326.FieldByName(Format('CAUS%d',[j])).AsString:=cdsGrid.FieldByName(Format('CAUS%d',[j])).AsString;
      end;
      W026DM.selT326.FieldByName('MOTIVAZIONE').AsString:=cdsGrid.FieldByName('MOTIVAZIONE').AsString;
      W026DM.selT326.Post;
      SessioneOracle.Commit;

      // se necessario effettua autorizzazione contestuale
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
      begin
        // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
        if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
          LTipoElab:=TTipoElab.Autorizza
        else
          LTipoElab:=TTipoElab.AutorizzaApplica;
        ImpostaAutorizzazione(LTipoElab,'T');
      end;
    end
    else if Parametri.CampiRiferimento.C90_W026TipoStraord = 'N' then
    begin
      // spezzoni non abilitati (ROMA_HSANDREA, GENOVA_HSMARTINO)

      //Se prevista autorizzazione contestuale, verifica che ci sia almeno una richiesta valida
      if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) and (not InsRichFittizio) then
        EsisteRichiesta:=False
      else
        EsisteRichiesta:=True;

      for LTipo in ['E','U'] do
      begin
        if (not cdsGrid.FieldByName(Format('SPEZ_DALLE1_%s',[LTipo])).IsNull) or
           ((InsRichFittizio) and (not cdsGrid.FieldByName(Format('SPEZ_%s',[LTipo])).IsNull)) then
        begin
          W026DM.selT326.Append;
          W026DM.selT326.FieldByName('ID').AsInteger:=LIdT325;
          W026DM.selT326.FieldByName('ID_T850').AsInteger:=LIdIns; //C018.Id;
          W026DM.selT326.FieldByName('TIPO').AsString:=LTipo;
          W026DM.selT326.FieldByName('SPEZ').AsString:=cdsGrid.FieldByName(Format('SPEZ_%s',[LTipo])).AsString;
          W026DM.selT326.FieldByName('DATA_SPEZ').AsDateTime:=cdsGrid.FieldByName(Format('DATA_SPEZ_%s',[LTipo])).AsDateTime;
          W026DM.selT326.FieldByName('CAUS_ORIG').AsString:=cdsGrid.FieldByName('CAUS_ORIG').AsString;
          W026DM.selT326.FieldByName('SPEZ_DALLE1').AsString:=cdsGrid.FieldByName(Format('SPEZ_DALLE1_%s',[LTipo])).AsString;
          W026DM.selT326.FieldByName('SPEZ_ALLE1').AsString:=cdsGrid.FieldByName(Format('SPEZ_ALLE1_%s',[LTipo])).AsString;
          W026DM.selT326.FieldByName('CAUS1').AsString:=cdsGrid.FieldByName(Format('CAUS1_%s',[LTipo])).AsString;
          W026DM.selT326.FieldByName('MOTIVAZIONE').AsString:=cdsGrid.FieldByName(Format('MOTIVAZIONE_%s',[LTipo])).AsString;
          W026DM.selT326.Post;
          SessioneOracle.Commit;

          // se necessario effettua autorizzazione contestuale
          if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A) and
             (not InsRichFittizio) then
          begin
            // imposta il tipo di elaborazione (solo autorizzazione / anche elaborazione su cartellino)
            if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
              LTipoElab:=TTipoElab.Autorizza
            else
              LTipoElab:=TTipoElab.AutorizzaApplica;
            ImpostaAutorizzazione(LTipoElab,LTipo);
            if not Richiesta.Eliminata then
              EsisteRichiesta:=True;
          end;
        end;
      end;
    end;
    EseguitoInsRichiesta:=False;

    if InsRichFittizio then
      exit
    else if not EsisteRichiesta then
    begin
      //Elimino tutte le richiesta del gg (basta passare uno degli ID del gg)
      C018.Id:=LIdIns;
      C018.EliminaIter('T325_RICHIESTESTR_GG');
      SessioneOracle.Commit;
      if not InModificaTutti then
      begin
        EseguiConteggi:=False;
        VisualizzaDipendenteCorrente;
      end;
      exit;
    end;

    // se tipo richiesta = 'A' (autorizzazione contestuale)
    // aggiorna i conteggi e scrive le nuove informazioni sulla tabella T325
    if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
    begin
      AggiornaConteggiT325(LProg,LData);
    end;

    // imposta tipo richiesta 'R' su tutte le richieste del giorno
    if ((Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T')) and
       (not SalvataggioParziale) then
    begin
      // utilizza dataset di supporto per la ricerca delle richieste da considerare
      W026DM.selT325Search.Close;
      W026DM.selT325Search.SetVariable('PROGRESSIVO',LProg);
      W026DM.selT325Search.SetVariable('DATA1',LData);
      W026DM.selT325Search.SetVariable('DATA2',LData);
      W026DM.selT325Search.Open;
      while not W026DM.selT325Search.Eof do
      begin
        C018.Id:=W026DM.selT325Search.FieldByName('ID').AsInteger;
        C018.SetTipoRichiesta(T325TR_R);
        W026DM.selT325Search.Next;
      end;
      SessioneOracle.Commit;
    end;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      W026DM.cdsT325Vis.Cancel;
      LErr:=Format('Errore durante l''inserimento della richiesta:'#13#10'%s',[E.Message]) +
            IfThen(E.ClassName <> 'Exception',#13#10'Tipo: ' + E.ClassName);
      if InModificaTutti then
      begin
        // rilancia lo stesso tipo di eccezione intercettato (non la generica Exception)
        raise ExceptClass(E.ClassType).Create(LErr);
      end
      else
      begin
        LTitolo:=IfThen(E is EC018RichiestaNonValidaException,'Errore di validità richiesta','Errore richiesta');
        MsgBox.TextIsHTML:=False;
        MsgBox.MessageBox(LErr,ESCLAMA,LTitolo);
        Exit;
      end;
    end;
  end;

  // se inserimento puntuale effettua alcune considerazioni
  if not InModificaTutti then
  begin
    if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
    begin
      // inserisce una richiesta fittizia per tutte le righe conteggiate del giorno
      InsRichFittizio:=True;
      try
        cdsGrid.First;
        while not cdsGrid.Eof do
        begin
          if (cdsGrid.FieldByName('ID').AsInteger <> LIdIns) and
             (cdsGrid.FieldByName('TIPO_RICHIESTA').AsString = 'I') and
             (cdsGrid.FieldByName('DATA').AsDateTime = LData) and
             (cdsGrid.FieldByName('PROGRESSIVO').AsInteger = LProg) then
          begin
            cdsGrid.Edit;
            cdsGrid.FieldByName('CAUS1_E').AsString:='';
            cdsGrid.FieldByName('CAUS1_U').AsString:='';
            ConfermaInsRichiesta;
          end;
          cdsGrid.Next;
        end;
      finally
        InsRichFittizio:=False;
      end;
    end
    else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
    begin
      // inserisce una richiesta fittizia per tutte le righe conteggiate del giorno
      LIdOrig_T:=cdsGrid.FieldByName('ID').AsInteger;
      InsRichFittizio:=True;
      try
        cdsGrid.First;
        while not cdsGrid.Eof do
        begin
          if (cdsGrid.FieldByName('ID').AsInteger <> LIdOrig_T) and
             (cdsGrid.FieldByName('TIPO_RICHIESTA').AsString = T325TR_I) and
             (cdsGrid.FieldByName('DATA').AsDateTime = LData) and
             (cdsGrid.FieldByName('PROGRESSIVO').AsInteger = LProg) then
          begin
            cdsGrid.Edit;
            for j:=1 to 2 do
            begin
              //selT326.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString:=cdsGrid.FieldByName(Format('SPEZ_DALLE%d',[j])).AsString;
              //selT326.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString:=cdsGrid.FieldByName(Format('SPEZ_ALLE%d',[j])).AsString;
              cdsGrid.FieldByName(Format('CAUS%d',[j])).AsString:='';
            end;
            ConfermaInsRichiesta;
          end;
          cdsGrid.Next;
        end;
      finally
        InsRichFittizio:=False;
      end;
    end;

    // corregge filtri visualizzazione al fine di includere la richiesta appena inserita
    if (not TuttiDipSelezionato) and
       (not ((trDaAutorizzare in C018.TipoRichiesteSel) or
             (trTutte in C018.TipoRichiesteSel))) then
    begin
      C018.Periodo.Estendi(LData,LData);
      if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
      begin
        if Parametri.RagioneSociale = 'Azienda Ospedaliera Sant''Andrea' then
          C018.IncludiTipoRichieste(trAutorizzate);
      end
      else
      begin
        if WR000DM.Responsabile then
          C018.IncludiTipoRichieste(trDaAutorizzare);
      end;
      C018.StrutturaSel:=C018STRUTTURA_TUTTE;
    end;

    EseguiConteggi:=True;
    VisualizzaDipendenteCorrente;

    // posizionamento sulla riga della richiesta appena inserita
    if (LIdIns > 0) and (C018.TipoRichiesteSel <> [trDaEffettuare]) then
      DBGridColumnClick(nil,IntToStr(LIdIns));
  end;
end;

procedure TW026FRichiestaStrGG.actCanRichiesta;
var
  LIdOrig: Integer;
  LDaCancellare: Boolean;
  LDataRich: TDateTime;
begin
  // PRE: i dataset sono posizionati sul record corretto
  // verifica presenza richiesta
  if not cdsGrid.Locate('ID',Richiesta.Id,[]) then
  begin
    VisualizzaDipendenteCorrente;
    Exit;
  end;
  LDataRich:=cdsGrid.FieldByName('DATA').AsDateTime;

  // se tipo rich. "R" (richiesta da autorizzare) elimina direttamente,
  // se tipo rich. "E" (richiesta elaborata) imposta invece il tipo richiesta "A" (annullata)
  LDaCancellare:=cdsGrid.FieldByName('TIPO_RICHIESTA').AsString <> T325TR_E;
  C018.CodIter:=cdsGrid.FieldByName('COD_ITER').AsString;
  C018.Id:=cdsGrid.FieldByName('ID').AsInteger;
  LIdOrig:=C018.Id;
  try
    if LDaCancellare then
    begin
      // se la richiesta è da cancellare la elimina fisicamente dal db
      C018.EliminaIter('T325_RICHIESTESTR_GG');
    end
    else
    begin
      // se la richiesta non può essere cancellata, imposta il flag "annullata"
      C018.SetTipoRichiesta(T325TR_A);
    end;
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      VisualizzaDipendenteCorrente;
      MsgBox.TextIsHTML:=False;
      MsgBox.MessageBox('Errore in fase di ' + IfThen(LDaCancellare,'cancellazione','annullamento') +
                        ' della richiesta:' + CRLF +
                        E.Message + CRLF +
                        'Tipo: ' + E.ClassName,ESCLAMA);
      Exit;
    end;
  end;

  // elaborazione annullamento richiesta (singolo spezzone T326)
  if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
    ElaboraAnnullamento(cdsGrid.FieldByName('SPEZ').AsString)
  else
    ElaboraAnnullamento;

  (*Annullata la gestione della Rettifica
  // se la richiesta in cancellazione rettifica un'altra richiesta,
  // - 1. riporta quest'ultima al tipo richiesta E = elaborata
  // - 2. rimuove il riferimento di ID_RETTIFICA
  if IsRettifica(RecordRichiesta.Id,IdOrig) then
  begin
    W026DM.updT325Orig.SetVariable('ID_ORIG',IdOrig);
    W026DM.updT325Orig.SetVariable('STATO','E');
    W026DM.updT325Orig.Execute;
    SessioneOracle.Commit;
  end;
  *)

  // annulla tutte le richieste del giorno
  if (not LDaCancellare) or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
  begin
    cdsGrid.First;
    while not cdsGrid.Eof do
    begin
      if (cdsGrid.FieldByName('ID').AsInteger <> LIdOrig) and
         (cdsGrid.FieldByName('TIPO_RICHIESTA').AsString <> 'A') and
         (cdsGrid.FieldByName('DATA').AsDateTime = LDataRich) and
         (cdsGrid.FieldByName('PROGRESSIVO').AsInteger = selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) then
      begin
        C018.Id:=cdsGrid.FieldByName('ID').AsInteger;
        try
          if cdsGrid.FieldByName('TIPO_RICHIESTA').AsString = T325TR_E then
          begin
            // se la richiesta non può essere cancellata, imposta il flag "annullata"
            C018.SetTipoRichiesta(T325TR_A);
          end
          else
          begin
           // se la richiesta è da cancellare la elimina fisicamente dal db
           C018.EliminaIter('T325_RICHIESTESTR_GG');
          end;
          SessioneOracle.Commit;

          if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
            ElaboraAnnullamento(cdsGrid.FieldByName('SPEZ').AsString)
          else
            ElaboraAnnullamento;
        except
          on E: Exception do
          begin
            SessioneOracle.Commit;
            MsgBox.TextIsHTML:=False;
            MsgBox.MessageBox(Format('Errore in fase di annullamento della richiesta %d'#13#10'%s'#13#10'Tipo: %s',[C018.Id,E.Message,E.ClassName]),ESCLAMA);
            VisualizzaDipendenteCorrente;
            Exit;
          end;
        end;
      end;
      cdsGrid.Next;
    end;
  end;

  // indica alla procedura di rieffettuare i conteggi per il giorno della richiesta
  // eliminata, in modo da importare gli spezzoni di eccedenza
  cdsGrid.IndexName:=''; // tenta di risolvere il bug "Operation not applicable"
  CaricaRecordConteggi(LDataRich,LDataRich);

  // daniloc.ini - 26.07.2012
  // comportamento annullato in base a richiesta dell'ente
  {
  // daniloc.ini - 08.06.2012
  // ROMA_HSANDREA
  // corregge filtro visualizzazione al fine di mostrare la richiesta annullata
  // come nuovamente disponibile
  if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = TIPO_RICHIESTA_A) and
     (not TuttiDipSelezionato) and
     (not (trDaEffettuare in C018.TipoRichiesteSel) or
      not (trTutte in C018.TipoRichiesteSel)) then
    C018.IncludiTipoRichieste(trDaEffettuare);
  // daniloc.fine
  }
  // daniloc.fine

  // aggiorna visualizzazione
  VisualizzaDipendenteCorrente;

  // posizionamento su riga di richiesta annullata / cancellata e reinserita
  if LDaCancellare then
    DBGridColumnClick(nil,IntToStr(MaxIdDb)) // tenta di riposizionarsi sulla riga appena inserita dopo i conteggi
  else
    DBGridColumnClick(nil,IntToStr(Richiesta.Id));
end;

procedure TW026FRichiestaStrGG.AnnullaInsRichiesta;
begin
  W026DM.selT325Vis.Cancel;
  VisualizzaDipendenteCorrente;
end;

procedure TW026FRichiestaStrGG.actAutorizzazioneOK(const PTipoElab: TTipoElab);
var
  LTipo: Char;
  LData: TDateTime;
  LProg: Integer;
begin
  // apre i dataset di supporto per la modifica
  LProg:=cdsGrid.FieldByName('PROGRESSIVO').AsInteger;
  LData:=cdsGrid.FieldByName('DATA').AsDateTime;

  R180SetVariable(W026DM.selT325,'PROGRESSIVO',LProg);
  W026DM.selT325.Open;
  R180SetVariable(W026DM.selT326,'PROGRESSIVO',LProg);
  W026DM.selT326.Close;
  W026DM.selT326.Open;

  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    AllineaCdsGrid;

    // gestione richiesta / autorizzazione in fasi distinte, non prevista al momento per tipo EU
    for LTipo in ['E','U'] do
    begin
      if W026DM.selT326.SearchRecord('ID_T850;TIPO',VarArrayOf([Richiesta.Id,LTipo]),[srFromBeginning]) then
      begin
        W026DM.selT326.Edit;
        W026DM.selT326.FieldByName('SPEZ_DALLE1').AsString:=cdsGrid.FieldByName(Format('SPEZ_DALLE1_%s',[LTipo])).AsString;
        W026DM.selT326.FieldByName('SPEZ_ALLE1').AsString:=cdsGrid.FieldByName(Format('SPEZ_ALLE1_%s',[LTipo])).AsString;
        W026DM.selT326.FieldByName('CAUS1').AsString:=cdsGrid.FieldByName(Format('CAUS1_%s',[LTipo])).AsString;
        W026DM.selT326.Post;
        ImpostaAutorizzazione(PTipoElab,LTipo);
      end;
    end;

    if InsRichFittizio or Richiesta.Eliminata then
      Exit;

    // aggiorna i conteggi e scrive le nuove informazioni sulla tabella T325
    AggiornaConteggiT325(LProg,LData);
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    // TORINO_COMUNE
    if W026DM.selT326.SearchRecord('ID_T850;TIPO;SPEZ',VarArrayOf([Richiesta.Id,'T',Richiesta.Spez]),[srFromBeginning]) then
      ImpostaAutorizzazione(PTipoElab,'T');
  end;

  // se autorizzazione puntuale effettua alcune considerazioni
  if (not InModificaTutti) and (not InAutorizzaTutti) and (not ConfermaAutorizzazioniInCorso) then
    VisualizzaDipendenteCorrente;
end;

procedure TW026FRichiestaStrGG.ImportaSuT100(const PTipo, PAut, PResp: String);
{ TODO : Questo metodo è da verificare in quanto sicuramente non allineato }
var
  LProg: Integer;
  LData: TDateTime;
  Ora,Verso,Causale,CausaleOrig,FlagOrig,IdRichiestaOrig: String;
begin
  // imposta variabili per aggiornamento dati
  LProg:=cdsGrid.FieldByName('PROGRESSIVO').AsInteger;
  LData:=W026DM.selT326.FieldByName('DATA_SPEZ').AsDateTime;
  if PTipo = 'E' then
  begin
    Verso:='E';
    Ora:=W026DM.selT326.FieldByName('SPEZ_DALLE1').AsString;
  end
  else if PTipo = 'U' then
  begin
    Verso:='U';
    Ora:=W026DM.selT326.FieldByName('SPEZ_ALLE1').AsString;
  end;
  Causale:=IfThen(PAut = 'S',W026DM.selT326.FieldByName('CAUS1').AsString,'');

  // estrae dati timbratura originale
  W026DM.selT100B.Close;
  W026DM.selT100B.SetVariable('PROGRESSIVO',LProg);
  W026DM.selT100B.SetVariable('DATA',LData);
  W026DM.selT100B.SetVariable('ORA',Ora);
  W026DM.selT100B.SetVariable('VERSO',Verso);
  W026DM.selT100B.Open;
  if W026DM.selT100B.RecordCount > 0 then
  begin
    FlagOrig:=W026DM.selT100B.FieldByName('FLAG').AsString;
    CausaleOrig:=W026DM.selT100B.FieldByName('CAUSALE').AsString;
    IdRichiestaOrig:=W026DM.selT100B.FieldByName('ID_RICHIESTA').AsString;
    if FlagOrig = 'I' then
    begin
      // si tratta di timbratura manuale
      //   -> modifica diretta
      if Causale <> CausaleOrig then
      begin
        W026DM.updT100.SetVariable('PROGRESSIVO',LProg);
        W026DM.updT100.SetVariable('DATA',LData);
        W026DM.updT100.SetVariable('VERSO',Verso);
        W026DM.updT100.SetVariable('ORA',Ora);
        W026DM.updT100.SetVariable('CAUSALE',Causale);
        try
          W026DM.updT100.Execute;
          // log della modifica
          RegistraLog.SettaProprieta('M','T100_TIMBRATURE','W026',nil,True);
          RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(LProg),'');
          RegistraLog.InserisciDato('DATA',FormatDateTime('dd/mm/yyyy',LData),'');
          RegistraLog.InserisciDato('ORA',Ora,'');
          RegistraLog.InserisciDato('VERSO',Verso,'');
          RegistraLog.InserisciDato('CAUSALE',CausaleOrig,Causale);
          RegistraLog.InserisciDato('FLAG',FlagOrig,'');
          RegistraLog.InserisciDato('ID_RICHIESTA',IdRichiestaOrig,''); // MONDOEDP - commessa MAN/02 - SVILUPPO 92
          RegistraLog.RegistraOperazione;
          SessioneOracle.Commit;
        except
          on E: Exception do
          begin
            RegistraLog.AnnullaOperazione;
            SessioneOracle.Commit;
            Log('Errore','ElaboraT100;Tipo:' + PTipo + ',FlagOrig:' + FlagOrig,E);
            raise Exception.Create('Errore durante l''impostazione della causale sulla timbratura:' + CRLF + E.Message);
          end;
        end;
      end;
    end
    else if FlagOrig = 'O' then
    begin
      // si tratta di timbratura originale
      //   -> update flag + inserimento timbratura modificata
      if Causale <> CausaleOrig then
      begin
        W026DM.insUpdT100.SetVariable('PROGRESSIVO',LProg);
        W026DM.insUpdT100.SetVariable('DATA',LData);
        W026DM.insUpdT100.SetVariable('ORA',Ora);
        W026DM.insUpdT100.SetVariable('VERSO',Verso);
        W026DM.insUpdT100.SetVariable('CAUSALE',Causale);
        W026DM.insUpdT100.SetVariable('VERSO_ORIG',Verso);

        // log modifica
        RegistraLog.SettaProprieta('M','T100_TIMBRATURE','A023',nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(LProg),'');
        RegistraLog.InserisciDato('DATA',FormatDateTime('dd/mm/yyyy',LData),'');
        RegistraLog.InserisciDato('ORA',Ora,'');
        RegistraLog.InserisciDato('VERSO',Verso,'');
        RegistraLog.InserisciDato('CAUSALE',CausaleOrig,'');
        RegistraLog.InserisciDato('FLAG','O','M');

        // log inserimento
        RegistraLog.SettaProprieta('I','T100_TIMBRATURE','A023',nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(LProg));
        RegistraLog.InserisciDato('DATA','',FormatDateTime('dd/mm/yyyy',LData));
        RegistraLog.InserisciDato('ORA','',Ora);
        RegistraLog.InserisciDato('VERSO','',Verso);
        RegistraLog.InserisciDato('CAUSALE','',Causale);
        RegistraLog.InserisciDato('FLAG','','I');
        RegistraLog.InserisciDato('ID_RICHIESTA',IdRichiestaOrig,''); // MONDOEDP - commessa MAN/02 - SVILUPPO 92

        // esecuzione inserimento + update
        try
          W026DM.insUpdT100.Execute;
          RegistraLog.RegistraOperazione;
          SessioneOracle.Commit;
        except
          on E: Exception do
          begin
            RegistraLog.AnnullaOperazione;
            SessioneOracle.Commit;
            Log('Errore','ElaboraT100;Tipo:' + PTipo + ',FlagOrig:' + FlagOrig,E);
            raise Exception.Create('Errore durante l''impostazione della causale sulla timbratura:' + CRLF + E.Message);
          end;
        end;
      end;
    end;
  end;
end;

procedure TW026FRichiestaStrGG.ImportaSuT320(const PTipo, PAut, PResp: String);
var
  i,LProg: Integer;
  MinutiDalle,MinutiAlle,MinutiSpezAlle: Integer;
  LData: TDateTime;
  CampoDalle,CampoAlle,CampoCaus,ValoreDalle,ValoreAlle,ValoreCaus,ValoreSpezAlle: String;
begin
  LProg:=cdsGrid.FieldByName('PROGRESSIVO').AsInteger;
  LData:=W026DM.selT326.FieldByName('DATA_SPEZ').AsDateTime;
  for i:=1 to MAX_SPEZZONI do
  begin
    // per spezzoni E/U si considera solo il primo spezzone
    if (i > 1) and ((PTipo = 'E') or (PTipo = 'U')) then
      Break;

    CampoDalle:=Format('SPEZ_DALLE%d',[i]);
    CampoAlle:=Format('SPEZ_ALLE%d',[i]);
    CampoCaus:=Format('CAUS%d',[i]);

    // se lo spezzone orario è nullo non viene considerato
    if W026DM.selT326.FieldByName(CampoDalle).IsNull then
      Continue;
    try
      // salva i valori in variabili di appoggio
      ValoreDalle:=W026DM.selT326.FieldByName(CampoDalle).AsString;
      ValoreAlle:=W026DM.selT326.FieldByName(CampoAlle).AsString;
      ValoreCaus:=W026DM.selT326.FieldByName(CampoCaus).AsString;
      ValoreSpezAlle:=Copy(W026DM.selT326.FieldByName('SPEZ').AsString,7,5);

      // ROMA_HSANTANDREA - chiamata 75633.ini
      // gestione degli eventuali spezzoni di uscita da autorizzare
      // a cavallo di mezzanotte (es. spezzone 22.00 - 07.15)
      MinutiDalle:=R180OreMinutiExt(ValoreDalle);
      MinutiAlle:=R180OreMinutiExt(ValoreAlle);
      MinutiSpezAlle:=R180OreMinutiExt(ValoreSpezAlle);
      if MinutiAlle < MinutiDalle then
        MinutiAlle:=MinutiAlle + 1440;
      if MinutiSpezAlle < MinutiDalle then
        MinutiSpezAlle:=MinutiSpezAlle + 1440;
      // ROMA_HSANTANDREA - chiamata 75633.fine

      if PAut = 'S' then
      begin
        // inserimento record di pianificazione
        W026DM.insT320.SetVariable('TIPOAUTORIZZAZIONE',Parametri.CampiRiferimento.C90_W026TipoAutorizzazione);
        W026DM.insT320.SetVariable('ID_RICHIESTA',W026DM.selT326.FieldByName('ID_T850').AsInteger);
        W026DM.insT320.SetVariable('PROGRESSIVO',LProg);
        W026DM.insT320.SetVariable('DATA',LData);
        W026DM.insT320.SetVariable('DALLE',ValoreDalle);
        W026DM.insT320.SetVariable('ALLE',ValoreAlle);
        W026DM.insT320.SetVariable('CAUSALE',ValoreCaus);
        W026DM.insT320.Execute;

        // crea una riga fittizia di eccedenza per coprire la parte di spezzone
        // eventualmente non causalizzata
        // questo accorgimento serve per mantenere corretti i conteggi ed evitare
        // che venga sbloccato l'intero spezzone
        if (PTipo = 'U') and
           (MinutiAlle < MinutiSpezAlle) then
        begin
          // gestione spezzoni di uscita da autorizzare a cavallo di mezzanotte
          W026DM.insT320.SetVariable('DATA',LData + IfThen(MinutiAlle >= 1440,1));
          W026DM.insT320.SetVariable('DALLE',ValoreAlle);
          W026DM.insT320.SetVariable('ALLE',ValoreSpezAlle);
          W026DM.insT320.SetVariable('CAUSALE','nulla');
          W026DM.insT320.Execute;
        end;
      end
      else
      begin
        // cancellazione record di pianificazione
        W026DM.delT320.SetVariable('TIPOAUTORIZZAZIONE',Parametri.CampiRiferimento.C90_W026TipoAutorizzazione);
        W026DM.delT320.SetVariable('ID_RICHIESTA',W026DM.selT326.FieldByName('ID_T850').AsInteger);
        W026DM.delT320.SetVariable('CAUSALE',W026DM.selT326.FieldByName(CampoCaus).AsString);
        W026DM.delT320.SetVariable('PROGRESSIVO',LProg);
        W026DM.delT320.SetVariable('DATA',LData);
        W026DM.delT320.SetVariable('DALLE',ValoreDalle);
        W026DM.delT320.Execute;

        // cancella l'eventuale riga fittizia di eccedenza inserita per coprire
        // la parte di spezzone non causalizzata
        if PTipo = 'U' then
        begin
          // gestione spezzoni di uscita da autorizzare a cavallo di mezzanotte
          W026DM.delT320.SetVariable('CAUSALE','nulla');
          W026DM.delT320.SetVariable('DATA',LData + IfThen(MinutiAlle >= 1440,1));
          W026DM.delT320.SetVariable('DALLE',ValoreAlle);
          W026DM.delT320.Execute;
        end;
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        Log('Errore','ElaboraT320;Autorizzazione:' + PAut,E);
        raise Exception.Create(Format('Errore durante %s della pianificazione del %s (spezzone %d)%s%s',
                                      [IfThen(PAut = 'S','l''inserimento','la cancellazione'),DateTostr(LData),i,CRLF,E.Message]));
      end;
    end;
    SessioneOracle.Commit;
  end;
end;

procedure TW026FRichiestaStrGG.ImpostaAutorizzazione(const PTipoElab: TTipoElab; const PTipoSpezzone: String);
// elabora l'autorizzazione della richiesta
// PRE:
//   cdsGrid posizionato sul record corretto
//   dataset selT326 posizionato sul record corretto
// Parametri
//   PTipoSpezzone:
//     E = entrata
//     U = uscita
//     T = tutti
var
  LAut, LResp: String;
  LAutModif: Boolean;
  LNewTipoRich: String;
begin
  // impostazione parametri per autorizzazione
  if PTipoSpezzone = 'E' then
  begin
    LAut:=Richiesta.AutE;
    LAutModif:=LAut <> cdsGrid.FieldByName('AUTORIZZAZIONE_E').AsString;
  end
  else if PTipoSpezzone = 'U' then
  begin
    LAut:=Richiesta.AutU;
    LAutModif:=LAut <> cdsGrid.FieldByName('AUTORIZZAZIONE_U').AsString;
  end
  else if PTipoSpezzone = 'T' then
  begin
    LAut:=Richiesta.AutT;
    LAutModif:=LAut <> cdsGrid.FieldByName('AUTORIZZAZIONE').AsString;
  end
  else
    raise Exception.CreateFmt('Errore durante l''impostazione dell''autorizzazione: tipologia di spezzone non prevista: %s',[PTipoSpezzone]);

  // variabili di appoggio per il metodo

  LResp:=Parametri.Operatore;

  // imposta parametri per il datamodule degli iter
  C018.CodIter:=cdsGrid.FieldByName('COD_ITER').AsString;
  C018.Id:=cdsGrid.FieldByName('ID').AsInteger;

  // imposta il tipo richiesta
  LNewTipoRich:='';
  if Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni = 'S' then
  begin
    if (PTipoElab = TTipoElab.AutorizzaApplica) or (PTipoElab = TTipoElab.Applica) then
      LNewTipoRich:=IfThen(LAut <> '',T325TR_E,T325TR_R);
  end
  else
  begin
    if LAutModif then
      LNewTipoRich:=IfThen(LAut <> '',T325TR_E,T325TR_R);
  end;

  if (Parametri.CampiRiferimento.C90_W026AutorizzObbl = 'S') and
     (Richiesta.AutE <> 'S') and
     (Richiesta.AutU <> 'S') and
     (Richiesta.AutT <> 'S') then
  begin
    Richiesta.Eliminata:=True;
    exit;
  end;

  // autorizzazione
  if (PTipoElab = TTipoElab.AutorizzaApplica) or (PTipoElab = TTipoElab.Autorizza) then
  begin
    // autorizzazione della richiesta a livello globale
    //   per tipo spezzoni = EU -> sempre positiva (l'autorizzazione viene salvata su T326)
    //   altrimenti             -> comportamento normale
    try
      C018.InsAutorizzazione(cdsGrid.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,
                             IfThen(R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) and (Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A),C018SI,LAut),
                             LResp,'','');
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        Log('Errore',Format('ElaboraAut;Autorizzazione:%s,Tipo:%s,Passaggio:%d;%s/%s',[LAut,PTipoSpezzone,1,E.ClassName,E.Message]));
        MsgBox.TextIsHTML:=False;
        MsgBox.MessageBox(Format('Impostazione dell''autorizzazione fallita:'#13#10'%s',[E.Message]),ERRORE);
        Exit;
      end;
    end;

    // autorizzazione della richiesta gestita su T326
    //   per tipo spezzoni EU
    if (LAutModif) and
       (R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U'])) then
    begin
      try
        R180SetVariable(W026DM.selT326,'PROGRESSIVO',cdsGrid.FieldByName('PROGRESSIVO').AsInteger);
        W026DM.selT326.Open;
        if W026DM.selT326.SearchRecord('ID_T850;TIPO',VarArrayOf([C018.Id,PTipoSpezzone]),[srFromBeginning]) then
        begin
          W026DM.selT326.Edit;
          W026DM.selT326.FieldByName('AUTORIZZAZIONE').AsString:=LAut;
          W026DM.selT326.Post;
          SessioneOracle.Commit;
        end;
      except
        on E: Exception do
        begin
          SessioneOracle.Commit;
          Log('Errore',Format('ElaboraAut;Tipo:%s,Passaggio:%d',[PTipoSpezzone,2]),E);
          MsgBox.TextIsHTML:=False;
          MsgBox.MessageBox(Format('Impostazione dell''autorizzazione fallita:'#13#10'%s',[E.Message]),ERRORE);
        end;
      end;
    end;
  end;

  // elaborazione della richiesta (singolo spezzone T326)
  //   aggiornamento su tabelle effettive
  if (PTipoElab = TTipoElab.AutorizzaApplica) or (PTipoElab = TTipoElab.Applica) then
  begin
    // applica la modifica sul cartellino
    try
      ImportaSuCartellino(PTipoSpezzone,LAut,LResp);
    except
      on E: Exception do
      begin
        Log('Errore',Format('ElaboraAut;Tipo:%s,Passaggio:%d',[PTipoSpezzone,3]),E);
        MsgBox.TextIsHTML:=False;
        MsgBox.MessageBox(Format('Elaborazione dell''autorizzazione su cartellino (modalità %s) fallita:'#13#10'%s',[Parametri.CampiRiferimento.C90_W026TipoAutorizzazione,E.Message]),ERRORE);
      end;
    end;
  end;

  // se necessario imposta il nuovo tipo richiesta
  if LNewTipoRich <> '' then
  begin
    C018.SetTipoRichiesta(LNewTipoRich);
    SessioneOracle.Commit;
  end;
end;

procedure TW026FRichiestaStrGG.ImportaSuCartellino(const PTipo, PAut, PResp: String);
// rende definitiva la richiesta sul cartellino
begin
  // se tipo autorizzazione
  // - T -> causalizza su T100
  // - P -> inserisce pianificazione su T320
  if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione = 'T' then
    ImportaSuT100(PTipo,PAut,PResp)
  else
    ImportaSuT320(PTipo,PAut,PResp);
end;

procedure TW026FRichiestaStrGG.ElaboraAnnullamento(const PSpez: String = '');
// elabora l'annullamento della richiesta sul cartellino
// parametro PSpez: lo spezzone orario per la tipologia di spezzone "T" (TORINO_COMUNE)
begin
  R180SetVariable(W026DM.selT326,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W026DM.selT326.Open;

  if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
  begin
    // entrata: applica su cartellino
    if W026DM.selT326.SearchRecord('ID_T850;TIPO',VarArrayOf([C018.Id,'E']),[srFromBeginning]) then
    begin
      ImportaSuCartellino('E','','');
    end;
    // uscita: applica su cartellino
    if W026DM.selT326.SearchRecord('ID_T850;TIPO',VarArrayOf([C018.Id,'U']),[srFromBeginning]) then
    begin
      ImportaSuCartellino('U','','');
    end;
  end
  else if Parametri.CampiRiferimento.C90_W026Spezzoni = 'T' then
  begin
    // TORINO_COMUNE
    // applica su cartellino
    if W026DM.selT326.SearchRecord('ID_T850;TIPO;SPEZ',VarArrayOf([C018.Id,'T',PSpez]),[srFromBeginning]) then
    begin
      ImportaSuCartellino('T','','');
    end;
  end;
end;

// SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
function TW026FRichiestaStrGG.GetDatiCartellinoMese(const PProg: Integer; const PDataMese: TDateTime): TDatiCartellino;
// restituisce i dati estratti dal cartellino mensile della data indicata
// per il progressivo specificato
var
  R450DtM1: TR450DtM1;
  i,k:Integer;
begin
  // imposta i dati dei conteggi del cartellino mensile
  Result.Prog:=PProg;
  Result.DataInizioMeseCont:=R180InizioMese(PDataMese);

  // azzera i dati
  Result.SaldoDisponibile:=0;
  Result.EccAutAnno:=999999;
  Result.EccLiqAnno:=0;
  Result.RecAutAnno:=999999;
  Result.RecMatAnno:=0;

  if (Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile = 'S') and
     (not WR000DM.selDatiBloccati.DatoBloccato(Result.Prog,Result.DataInizioMeseCont,'T070')) then
  begin
    AggiornamentoSchedaRiepilogativa(Result);
  end
  else
  begin
    // crea oggetto per conteggi cartellino ed esegue conteggi
    R450DtM1:=TR450DtM1.Create(nil);
    try
      R450DtM1.ConteggiMese('Generico',R180Anno(Result.DataInizioMeseCont),R180Mese(Result.DataInizioMeseCont),Result.Prog);
      Result.SaldoDisponibile:=R450DtM1.salmeseatt;
      Result.CheckSaldo:=R450DtM1.IterEccGGCheckSaldo;
      //Aggiunta delle causali eslcuse dalle normali richiedibili nell'iter
      for i:=0 to High(ArrCausali) do
        if (ArrCausali[i].InclusioneOre = 'A') and R180In(ArrCausali[i].TipoRichiestaWeb,['P','R']) then
        begin
          k:=R450DtM1.IndiceRiepPres(ArrCausali[i].Codice);
          if k >= 0 then
            Result.SaldoDisponibile:=Result.SaldoDisponibile + R180SommaArray(R450DtM1.RiepPres[k].OreReseMese);
        end;
      //Lettura situazione ecedenza annuale (autorizzata / liquidata)
      GetDatiAnnualiEccedenza(Result,R450DtM1);
    finally
      FreeAndNil(R450DtM1);
    end;
  end;
end;
// SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine

procedure TW026FRichiestaStrGG.GetDatiAnnualiEccedenza(var DC:TDatiCartellino; R450:TR450DtM1);
var A029FLiquidazione:TA029FLiquidazione;
    i,k:Integer;
begin
  //dati standard dell'eccedenza annuale
  A029FLiquidazione:=TA029FLiquidazione.Create(nil);
  try
    A029FLiquidazione.R450DtM:=R450;
    A029FLiquidazione.GetOreLiquidate(DC.Prog,DC.DataInizioMeseCont);
    DC.EccAutAnno:=R450.EccAutAnno['LIQUIDABILE'] + R450.EccAutAnno['CAUSALIZZATO'] + A029FLiquidazione.LiqT075Anno;
    DC.EccLiqAnno:=A029FLiquidazione.LiqT071Anno + A029FLiquidazione.LiqT070 + A029FLiquidazione.LiqT074Anno + A029FLiquidazione.AssT071Anno - (A029FLiquidazione.LiqT074Mese);
    DC.RecAutAnno:=R450.EccAutAnno['RESIDUABILE'] (*+ R450.EccAutAnno['CAUSALIZZATO'] +*) (*A029FLiquidazione.LiqT075Anno*);
    DC.RecMatAnno:=0;
    for i:=0 to High(ArrCausali) do
      if R180In(ArrCausali[i].TipoRichiestaWeb,['R']) then
      begin
        k:=R450.IndiceRiepPres(ArrCausali[i].Codice);
        if k >= 0 then
          DC.RecMatAnno:=DC.RecMatAnno + R180SommaArray(R450.RiepPres[k].OreReseMese);
      end;
  finally
    FreeAndNil(A029FLiquidazione);
  end;
end;

procedure TW026FRichiestaStrGG.AggiornamentoSchedaRiepilogativa(var DatiCartellino:TDatiCartellino);
{Aggiornamento scheda riepilogativa prima di visualizzare i saldi aggiornati}
var
  A,M,G,A2,M2,G2:Word;
  i,k,iSQL: Integer;
  MsgErr: String;
  S,URL_Stampa,SQLText,AnomalieBloccantiDesc:String;
  //AnomalieBloccanti:Boolean;
  DataI,DataF:TDateTime;
  W009FStampaCartellinoDtm:TW009FStampaCartellinoDtm;
begin
  Log('Traccia','EseguiCartellini: inizio');
  // inizializzazione variabili
  S:='';
  URL_Stampa:='';
  SQLText:='';
  DataI:=R180InizioMese(DatiCartellino.DataInizioMeseCont);
  DataF:=R180FineMese(DatiCartellino.DataInizioMeseCont);
  W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(Self);
  try //except
    try  //finally
      Log('Traccia','Datamodulo W009dtm creato');
      W009FStampaCartellinoDtm.selAnagrafeW:=selAnagrafeW;
      W009FStampaCartellinoDtm.CartelliniChiusi:=False;
      W009FStampaCartellinoDtm.Stampa:=False;
      W009FStampaCartellinoDtm.RegLog:=True;
      MsgErr:='';
      SQLText:=selAnagrafeW.SQL.Text;
      DecodeDate(DataI,A,M,G);
      DecodeDate(DataF,A2,M2,G2);
      // creazione datamodulo conteggi
      try
        W009FStampaCartellinoDtm.CreazioneR400(Self);
        Log('Traccia','R400 creato');
      except
        on E: Exception do
        begin
          Log('Errore','R400 non creato: ' + E.ClassName + '/' + E.Message);
          raise;
        end;
      end;
      with W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int do
      begin
        Close;
        SetVariable('Codice',W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Lista.FieldByName('CODICE').AsString);
        Open;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=True; //Sender = btnAggiornamento;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.IgnoraAnomalie:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=True;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=True;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione:='T430INIZIO,T430FINE';
      selAnagrafeW.SetVariable('DATALAVORO',DataF);
      selAnagrafeW.Close;
      if (Pos(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione,SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',SelAnagrafeW.SQL.Text) = 0)) and
         (Trim(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione) <> '') then // daniloc. 23.12.2010
      begin
        S:=SelAnagrafeW.SQL.Text;
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
        if iSQL > 0 then
          Insert(',' + W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
        Log('Traccia','Campi intestazione aggiunti: ' + W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione);
        selAnagrafeW.SQL.Text:=S;
      end;
      try
        selAnagrafeW.Open;
      except
        on E:Exception do
        begin
          Log('Errore','Apertura selAnagrafeW: campo intestazione non valido;Elenco campi intestazione: ' + W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione);
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_W009_ERR_CAMPI_NON_VALIDI));
        end;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;
      begin
        if selAnagrafeW.SearchRecord('PROGRESSIVO',DatiCartellino.Prog,[srFromBeginning]) then
        begin
          Log('Traccia','Calcolo cartellini matr. ' + selAnagrafeW.FieldByName('MATRICOLA').AsString + ', dal ' + DateToStr(DataI) + ' al ' + DateToStr(DataF));
          MsgErr:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2);
          DatiCartellino.SaldoDisponibile:=W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1.salmeseatt;
          DatiCartellino.CheckSaldo:=W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1.IterEccGGCheckSaldo;
          //AnomalieBloccanti:=W009FStampaCartellinoDtM.R400FCartellinoDtM.AnomaliaBloccante;
          AnomalieBloccantiDesc:=W009FStampaCartellinoDtM.R400FCartellinoDtM.lstAnomalie.Text;
          //Aggiunta delle causali eslcuse dalle normali richiedibili nell'iter
          for i:=0 to High(ArrCausali) do
            if (ArrCausali[i].InclusioneOre = 'A') and R180In(ArrCausali[i].TipoRichiestaWeb,['P','R']) then
            begin
              k:=W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1.IndiceRiepPres(ArrCausali[i].Codice);
              if k >= 0 then
                DatiCartellino.SaldoDisponibile:=DatiCartellino.SaldoDisponibile + R180SommaArray(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1.RiepPres[k].OreReseMese);
            end;
          GetDatiAnnualiEccedenza(DatiCartellino,W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
        end
        else
        begin
          Log('Errore','Progressivo non trovato: ' + IntToStr(DatiCartellino.Prog));
          Abort;
        end;
      end;
      if MsgErr <> '' then
        MessaggioStatus(ERRORE,MsgErr);
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      Log('Traccia','Aggiornamento: R400 Chiusura query completata');
      with W009FStampaCartellinoDtM.R400FCartellinoDtM do
      begin
        W009FStampaCartellinoDtM.ChiusuraQuery(R450DtM1);
        Log('Traccia','Aggiornamento: R450 Chiusura query completata');
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R600DtM1);
      end;
      Log('Traccia','EseguiCartellini: fine');
    finally
      Log('Traccia','EseguiCartellini: chiusura stampa cartellini');
      // distruzione R400
      if W009FStampaCartellinoDtM.R400FCartellinoDtM <> nil then
      begin
        with W009FStampaCartellinoDtM.R400FCartellinoDtM do
        begin
          cdsRiepilogo.Close;
          cdsDettaglio.Close;
          cdsSettimana.Close;
          cdsAssenze.Close;
          cdsPresenze.Close;
          Q950Int.CloseAll;
          A027SelAnagrafe:=nil;
        end;
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      end;
      // riapre selezione anagrafica
      selAnagrafeW.CloseAll;
      selAnagrafeW.SQL.Text:=SQLText;
      selAnagrafeW.Open;
      selAnagrafeW.SearchRecord('PROGRESSIVO',DatiCartellino.Prog,[srFromBeginning]);
      try W009FStampaCartellinoDtM.DistruggiLstRaveComp; except end;
      FreeAndNil(W009FStampaCartellinoDtm);
    end;
  except
    on E:Exception do
    begin
      Log('Errore','EseguiCartellini: ' + E.ClassName + '/' + E.Message);
      MessaggioStatus(ERRORE,Format(A000TraduzioneStringhe(A000MSG_W009_ERR_FMT_STAMPA_CARTELLINO),[E.Message]));
    end;
  end;
end;

procedure TW026FRichiestaStrGG.RiepilogoTotali;
var
  LFiltroAnag,LTotAnnoRec,LTotAnnoPag: String;
  LAnnoCorr: Word;
begin
  // determina filtro anagrafe
  // 01.06.2012 (richiesta di CSI - Toscano)
  // il totale devo considerare sempre tutti i dipendenti selezionati
  //FiltroAnag:=WR000DM.FiltroRicerca;
  // 24.07.2012 (richiesta di CSI - De Castelli)
  LFiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,FiltroSingoloAnagrafico);

  // totale anno in corso fino al periodo attuale delle richieste (incluso)
  LAnnoCorr:=R180Anno(Date);

  W026DM.selTotAnno.Close;
  W026DM.selTotAnno.SetVariable('QVISTAORACLE',QVistaOracle);
  W026DM.selTotAnno.SetVariable('DATALAVORO',Parametri.DataLavoro);
  W026DM.selTotAnno.SetVariable('FILTRO_ANAG',LFiltroAnag);
  W026DM.selTotAnno.SetVariable('INIZIO',EncodeDate(LAnnoCorr,1,1));
  W026DM.selTotAnno.SetVariable('FINE',EncodeDate(LAnnoCorr,12,31));
  W026DM.selTotAnno.Execute;
  LTotAnnoRec:=W026DM.selTotAnno.FieldAsString(0);
  if LTotAnnoRec = '' then
    LTotAnnoRec:='0.00';
  LTotAnnoPag:=W026DM.selTotAnno.FieldAsString(1);
  if LTotAnnoPag = '' then
    LTotAnnoPag:='0.00';

  // imposta la grid di riepilogo
  edtRiepilogo.Visible:=True;
  grdRiepilogo.Visible:=True;
  grdRiepilogo.Cell[0,0].Text:='Ore di recupero';
  grdRiepilogo.Cell[0,0].Css:='align_center';
  grdRiepilogo.Cell[0,1].Text:='Ore in pagamento';
  grdRiepilogo.Cell[0,1].Css:='align_center';
  grdRiepilogo.Cell[1,0].Text:=LTotAnnoRec;
  grdRiepilogo.Cell[1,0].Css:='align_center';
  grdRiepilogo.Cell[1,1].Text:=LTotAnnoPag;
  grdRiepilogo.Cell[1,1].Css:='align_center';

  // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.ini
  // estrae il saldo disponibile del mese e lo visualizza nella form
  // salvandolo per successivi controlli in fase di richiesta
  if not WR000DM.Responsabile then
  begin
    DatiCartellino:=GetDatiCartellinoMese(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,C018.Periodo.Fine);
    lblSaldoMese.Visible:=True;
    lblSaldoMeseDisp.Visible:=True;
    lblSaldoMeseDisp.Caption:=R180MinutiOre(DatiCartellino.SaldoDisponibile);
  end;
  // SGIULIANOMILANESE_COMUNE - commessa: 2013/115 SVILUPPO#2.fine
end;

procedure TW026FRichiestaStrGG.grdRiepilogoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not RenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;
end;

procedure TW026FRichiestaStrGG.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,Prog,IdIni,Spez,Rec,Pag,TotRec,TotPag,TotSpez,NumRichGG: Integer;
  LTipoRichiesta: String;
  DataRif,DataBlocco: TDateTime;
  BloccoRiep,DataOk,VisElimina,VisModifica,VisAutorizza: Boolean;
  LIWG: TmeIWGrid;
  IWImg: TmeIWImageFile;
begin
  // TORINO_COMUNE
  if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
  begin
    // calcolo dei totali recupero e pagamento del periodo attuale
    TotSpez:=0;
    TotRec:=0;
    TotPag:=0;
    if grdRichieste.medpDataSet.RecordCount > 0 then
    begin
      IdIni:=grdRichieste.medpDataSet.FieldByName('ID').AsInteger;
      grdRichieste.medpDataSet.First;
      while not grdRichieste.medpDataSet.Eof do
      begin
        Spez:=R180OreMinutiExt(Copy(grdRichieste.medpDataSet.FieldByName('C_SPEZ').AsString,1,5));
        Rec:=R180OreMinutiExt(Copy(grdRichieste.medpDataSet.FieldByName('C_SPEZ_REC').AsString,1,5));
        Pag:=R180OreMinutiExt(Copy(grdRichieste.medpDataSet.FieldByName('C_SPEZ_PAG').AsString,1,5));
        TotSpez:=TotSpez + Spez;
        TotRec:=TotRec + Rec;
        TotPag:=TotPag + Pag;
        grdRichieste.medpDataSet.Next;
      end;
      grdRichieste.medpDataSet.Locate('ID',IdIni,[]);
    end;
    grdRichieste.medpColonna('C_SPEZ').Title.Text:=Format('Eccedenza (tot.&nbsp;%s)',[R180MinutiOre(TotSpez)]);
    grdRichieste.medpColonna('C_SPEZ_REC').Title.Text:=Format('Recupero (tot.&nbsp;%s)',[R180MinutiOre(TotRec)]);
    grdRichieste.medpColonna('C_SPEZ_PAG').Title.Text:=Format('Pagamento (tot.&nbsp;%s)',[R180MinutiOre(TotPag)]);
  end;

  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    if (grdRichieste.medpValoreColonna(i,'TIPO_RIGA') = W026_TROW_D) { and
       (C018.CodIter <> '') then // coditer non impostati -> salvataggi parziali
    } then
    begin
      // dettaglio iter
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile);
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
    end
    else
    begin
      FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna(DBG_ITER)]);
      if C018.EsisteGestioneAllegati then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[grdRichieste.medpIndexColonna(DBG_ITER)]);
    end;

    DataRif:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
    DataBlocco:=R180InizioMese(DataRif);
    Prog:=StrToInt(grdRichieste.medpValoreColonna(i,'PROGRESSIVO'));
    LTipoRichiesta:=grdRichieste.medpValoreColonna(i,'TIPO_RICHIESTA');
    BloccoRiep:=WR000DM.SelDatiBloccati.DatoBloccato(Prog,DataBlocco,'T070');
    if Parametri.CampiRiferimento.C90_W026TipoAutorizzazione = 'T' then
      BloccoRiep:=BloccoRiep or (WR000DM.selDatiBloccati.DatoBloccato(Prog,DataBlocco,'T100'));
    if BloccoRiep then
    begin
      // blocco riepiloghi attivo
      if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        LIWG:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
        LIWG.Cell[0,0].Css:='datiBloccati';
        LIWG.Cell[0,1].Css:='invisibile';
        LIWG.Cell[0,2].Css:='invisibile';
        LIWG.Cell[0,3].Css:='invisibile';
      end;
      Continue;
    end
    else
    begin
      if WR000DM.Responsabile then
      begin
        // * Responsabile *
        VisAutorizza:=R180In(LTipoRichiesta,[T325TR_R,T325TR_E]) and (StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),-1) > 0);
        if not VisAutorizza then
          FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          if StileCella1 = '' then
          begin
            StileCella1:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css;
            StileCella2:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css;
          end;
          (grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgModificaClick;
          (grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
          (grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
          LIWG:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
          LIWG.Cell[0,0].Css:='invisibile';
          LIWG.Cell[0,2].Css:='invisibile';
          LIWG.Cell[0,3].Css:='invisibile';
        end;
      end
      else
      begin
        // * Dipendente *
        // abilitazione cancellazione / modifica
        if Parametri.CampiRiferimento.C90_W026TipoRichiesta = W026_PAR_TIPORICHIESTA_A then
          VisElimina:=R180In(LTipoRichiesta,[T325TR_R,T325TR_E])
        else
          VisElimina:=R180In(LTipoRichiesta,[T325TR_R,T325TR_P]);

        NumRichGG:=0;
        if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) and VisElimina then
        begin
          // ROMA_HSANDREA
          // Annullamento possibile solo se tutte le richieste del giorno hanno tipo richiesta uguale
          W026DM.selRichiesteGiorno.SetVariable('DATARIF',DataRif);
          W026DM.selRichiesteGiorno.SetVariable('PROGRESSIVO',Prog);
          try
            W026DM.selRichiesteGiorno.Execute;
            VisElimina:=W026DM.selRichiesteGiorno.FieldAsString(1) = 'S';
            NumRichGG:=W026DM.selRichiesteGiorno.FieldAsInteger(0);
          except
            on E: Exception do
            begin
              MsgBox.TextIsHTML:=False;
              MsgBox.MessageBox('Errore durante il caricamento delle richieste: ' + E.Message + CRLF + 'Tipo: ' + E.ClassName,ESCLAMA);
              Exit;
            end;
          end;
        end;

        VisModifica:=R180In(LTipoRichiesta,[T325TR_I,T325TR_R,T325TR_P]);
        if (Parametri.CampiRiferimento.C90_W026TipoStraord = 'A') {//TOHC//}or (Parametri.CampiRiferimento.C90_W026Spezzoni = 'T') then
        begin
          // TORINO_COMUNE
          // in questo caso la modifica e la cancellazione sono legate al fatto che la data
          // rientri nel periodo (fisso) del mese precedente
          DataOk:=((DataRif >= DataInizioModCanc) and (DataRif <= DataFineModCanc)) or (DebugHook <> 0);
          VisModifica:=VisModifica and DataOk;
          VisElimina:=VisElimina and DataOk;

          // debug - solo per test
          if DebugHook <> 0 then
          begin
            DebugClear;
            DebugAdd(INFORMA,Format('La modifica alle richieste è abilitata anche al di fuori del %s',
                                    [C190PeriodoStr(DataInizioModCanc,DataFineModCanc)]));
          end;
        end;

        // gestione grid comandi
        if not (VisElimina or VisModifica) then
          FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          if StileCella1 = '' then
          begin
            StileCella1:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css;
            StileCella2:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css;
          end;

          // elimina
          IWImg:=(grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile);
          IWImg.OnClick:=imgCancellaClick;
          IWImg.Hint:=IfThen(LTipoRichiesta = T325TR_E,'Annulla','Elimina') + ' la richiesta del ' + grdRichieste.medpValoreColonna(i,'DATA');
          IWImg.Confirmation:=IfThen(LTipoRichiesta = T325TR_E,'Annullare','Eliminare') + ' la richiesta selezionata?';
          if NumRichGG > 1 then
            IWImg.Confirmation:=IWImg.Confirmation + CRLF + CRLF + 'Attenzione!' + CRLF +
                                'Le eccedenze del giorno ' + grdRichieste.medpValoreColonna(i,'DATA') +
                                ' sono suddivise in ' + IntToStr(NumRichGG) + ' richieste distinte.' + CRLF +
                                'L''annullamento verrà effettuato automaticamente per tutte.';

          // modifica
          IWImg:=(grdRichieste.medpCompCella(i,0,1) as TmeIWImageFile);
          IWImg.Hint:=IfThen(LTipoRichiesta = T325TR_I,'Imposta','Modifica') + ' la richiesta del ' + grdRichieste.medpValoreColonna(i,'DATA');
          IWImg.OnClick:=imgModificaClick;

          // annulla
          IWImg:=(grdRichieste.medpCompCella(i,0,2) as TmeIWImageFile);
          IWImg.OnClick:=imgAnnullaClick;
          IWImg:=(grdRichieste.medpCompCella(i,0,3) as TmeIWImageFile);
          IWImg.OnClick:=imgConfermaClick;

          // verifica abilitazioni
          if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
          begin
            LIWG:=(grdRichieste.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
            if not VisElimina then
              LIWG.Cell[0,0].Css:='invisibile';
            if not VisModifica then
              LIWG.Cell[0,1].Css:='invisibile';
            LIWG.Cell[0,2].Css:='invisibile';
            LIWG.Cell[0,3].Css:='invisibile';
          end;
        end;
      end;
    end;
  end; // end for
end;

procedure TW026FRichiestaStrGG.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna,idx,i: Integer;
  S,Caus,NomeCampo,CodMotivazione: String;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True,not InModificaTutti) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  NomeCampo:=grdRichieste.medpColonna(NumColonna).DataField;

  if ARow = 0 then
  begin
    // sostituzione spazio -> CRLF su intestazione
    ACell.RawText:=True;
    ACell.Text:=StringReplace(ACell.Text,' ','<br/>',[]);
  end
  else
  begin
    // righe di dettaglio
    if ARow <= Length(grdRichieste.medpCompGriglia) then
    begin
      // assegnazione componenti
      if grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil then
      begin
        ACell.Text:='';
        ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
      end;

      // richieste annullate: colore font grigio
      if grdRichieste.medpValoreColonna(ARow - 1,'TIPO_RICHIESTA') = T325TR_A then
        ACell.Css:=ACell.Css + ' font_grigio';

      // nel caso di spezzoni di entrata / uscita
      if R180In(Parametri.CampiRiferimento.C90_W026Spezzoni,['EU','E','U']) then
      begin
        if NomeCampo.EndsWith('_E') then
          ACell.Css:=ACell.Css + ' w026_entrata'
        else if NomeCampo.EndsWith('_U') then
          ACell.Css:=ACell.Css + ' w026_uscita';
      end;

      if ACell.Control = nil then
      begin
        if NomeCampo = 'DATA_RICHIESTA' then
        begin
          // data della richiesta
          ACell.Css:=ACell.Css + ' align_center';
          if grdRichieste.medpValoreColonna(ARow - 1,'TIPO_RICHIESTA') = T325TR_I then
            ACell.Hint:='Id Richiesta (fittizio): ' + grdRichieste.medpValoreColonna(ARow - 1,'ID')
          else
            ACell.Hint:='ID Richiesta: ' + grdRichieste.medpValoreColonna(ARow - 1,'ID');
          ACell.ShowHint:=DebugHook <> 0;
        end
        else if NomeCampo = 'TIPO_RICHIESTA' then
        begin
          // tipo richiesta
          ACell.Css:=ACell.Css + ' align_center tooltipHtml';
          if ACell.Text = T325TR_I then
            ACell.Hint:='<b>I</b> = Richiesta inseribile' // fittizio
          else if ACell.Text = T325TR_R then
            ACell.Hint:='<b>R</b> = Richiesta effettuata'
          else if ACell.Text = T325TR_E then
            ACell.Hint:='<b>E</b> = Richiesta elaborata'
          else if ACell.Text = T325TR_A then
            ACell.Hint:='<b>A</b> = Richiesta annullata'
          else if ACell.Text = T325TR_P then
            ACell.Hint:='<b>P</b> = Salvataggio parziale';
          ACell.ShowHint:=True;
        end
        else if NomeCampo = 'DATA' then
        begin
          // data di riferimento
          ACell.Css:=ACell.Css + ' align_center';
        end
        else if (NomeCampo = 'CAUS1_E') or (NomeCampo = 'CAUS1_U') then
        begin
          // hint per le causali di presenza
          idx:=ArrCausaliGetIndex(grdRichieste.medpValoreColonna(ARow - 1,NomeCampo));
          if idx >= 0 then
            ACell.Hint:=ArrCausali[idx].Descrizione;
          ACell.ShowHint:=ACell.Hint <> '';
        end
        else if (NomeCampo = 'SPEZ_E') or (NomeCampo = 'SPEZ_U') then
        begin
          // spezzoni in evidenza per entrata / uscita
          ACell.Css:=ACell.Css + ' font_grassetto';
        end
        else if (NomeCampo = 'D_AUTORIZZAZIONE_E') or (NomeCampo = 'D_AUTORIZZAZIONE_U') then
        begin
          // autorizzazione
          ACell.Css:=ACell.Css + ' font_grassetto' +
                     IfThen(grdRichieste.medpValoreColonna(ARow - 1,NomeCampo) = 'No',' font_rosso');
        end
        else if NomeCampo = 'TIMBRATURE' then
        begin
          // timbrature
          ACell.Css:=ACell.Css + ' elencoTimb';
          ACell.RawText:=True;
          R180Tokenize(ListaTimb,ACell.Text,' ');
          S:='';
          for i:=0 to ListaTimb.Count - 1 do
            S:=S + Format('<span class="verso%s">%s</span>',[LeftStr(ListaTimb[i],1),Copy(ListaTimb[i],2,MAXINT)]);
          ACell.Text:=S;
        end
        else if NomeCampo = 'D_AUTORIZZAZIONE' then
        begin
          // timbrature
          ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                     IfThen(grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZAZIONE') = 'N',' font_rosso')
        end
        else if NomeCampo = 'C_SPEZ' then
        begin
          // spezzone orig.
          ACell.Css:=ACell.Css + ' align_center';
          if Pos('[',ACell.Text) > 0 then
          begin
            ACell.RawText:=True;
            ACell.Text:=StringReplace(ACell.Text,'[','<br><span class="font_piccolo">[',[]);
            if Pos(']',ACell.Text) > 0 then
              ACell.Text:=StringReplace(ACell.Text,']',']</span>',[]);
          end;
        end
        else if Copy(NomeCampo,1,7) = 'C_SPEZ_' then
        begin
          ACell.Css:=ACell.Css + ' align_center';
          if ACell.Text <> '' then
          begin
            if ((NomeCampo = 'C_SPEZ_REC') and (ContaRec <= 1)) or
               ((NomeCampo = 'C_SPEZ_PAG') and (ContaPag <= 1)) then
              ACell.Text:=Copy(ACell.Text,1,5)
            else
            begin
              // causali multiple: visualizza codice causale + hint con descrizione
              Caus:=Copy(ACell.Text,7,MAXINT);
              Caus:=StringReplace(Caus,'(','',[]);
              Caus:=Copy(Caus,1,Pos(')',Caus) - 1);
              // hint per descrizione causale
              if Trim(Caus) <> '' then
              begin
                idx:=ArrCausaliGetIndex(Caus);
                if idx >= 0 then
                  ACell.Hint:=Caus + ': ' + ArrCausali[idx].Descrizione;
              end;
            end;
            ACell.ShowHint:=ACell.Hint <> '';
          end;
        end
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.ini
        else if NomeCampo = 'MOTIVAZIONE' then
        begin
          CodMotivazione:=ACell.Text;
          idx:=-1;
          for i:=Low(ArrMotivazioni) to High(ArrMotivazioni) do
          begin
            if ArrMotivazioni[i].Codice = CodMotivazione then
            begin
              idx:=i;
              Break;
            end;
          end;
          if idx >= 0 then
            ACell.Text:=ArrMotivazioni[idx].Descrizione;
        end;
        // TORINO_CITTADELLASALUTE - commessa 2015/169 SVILUPPO#1.fine
      end;
    end;
  end;
end;

procedure TW026FRichiestaStrGG.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);

  if not cdsGrid.Locate('ID',FN,[]) then
  begin
    VisualizzaDipendenteCorrente;
    GGetWebApplicationThreadVar.ShowMessage('Impossibile visualizzare le note.'#13#10'La richiesta selezionata non è più disponibile!');
    Exit;
  end;
  VisualizzaDettagli(Sender);
end;

procedure TW026FRichiestaStrGG.DBGridColumnClick(ASender: TObject; const AValue: string);
var
  IdRiga: Integer;
begin
  if not cdsT325.Locate('DBG_ROWID',AValue,[]) then
  begin
    if TryStrToInt(AValue,IdRiga) then
    begin
      if not cdsT325.Locate('ID',IdRiga,[]) then
        Exit;
    end
    else
      Exit;
  end;

  cdsGrid.Locate('ID',cdsT325.FieldByName('ID').AsInteger,[]);

  // dipendente
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT325.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;
end;

procedure TW026FRichiestaStrGG.DistruggiOggetti;
begin
  SetLength(ArrCausali,0);
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT275);
    R180CloseDataSetTag0(WR000DM.selAssPres);
  end;
  if Assigned(W026DM) then
    FreeAndNil(W026DM);
  if Assigned(A023FGestMeseMW) then
    FreeAndNil(A023FGestMeseMW);
  FreeAndNil(ListaTimb);

  inherited;
end;

end.