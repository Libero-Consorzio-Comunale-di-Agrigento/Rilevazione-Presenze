unit W009UStampaCartellino;

interface

uses
  W009UStampaCartellinoDtm, W009UIterCartellinoDM,
  C018UIterAutDM,C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  A000UInterfaccia, A000UCostanti, A000USessione,
  Classes, SysUtils, IWTemplateProcessorHTML, IWForm, IWAppForm,
  IWCompLabel, IWHTMLControls, Controls, IWControl,
  IWCompEdit, IWCompButton, IWCompCheckbox, DB, Oracle, OracleData, Graphics,
  IWBaseControl, Variants, StrUtils,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWVCLBaseControl, IWBaseHTMLControl, IWCompListbox,
  IWVCLBaseContainer, IWContainer, Forms,
  IWVCLComponent, meIWComboBox, meIWLabel, meIWGrid,
  meIWButton, meIWEdit, meIWCheckBox, meIWImageFile, DBClient, IWDBGrids,
  medpIWMessageDlg, medpIWDBGrid, Math,
  IWCompGrids, IWCompExtCtrls, System.IOUtils,
  meIWLink, A000UMessaggi, W000UMessaggi, Menus, Datasnap.Win.MConnect, WinAPI.ActiveX,
  System.JSON, WC020UInputDataOreFM;

type
  TVettAnomalie = record
    Progressivo:String;
    Matricola:String;
    Badge:String;
    Nome:String;
    Livello:String;
    Data:String;
    Anomalia:String;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
  end;

  tRiepDati = record
    Titolo:String;
    Valore:String;
  end;

  tRiepDett = record
    Prog:Integer;
    Mese:TDateTime;
    RiepDati:array of tRiepDati;
    RiepPresTit:String;
    RiepPresVal:String;
    RiepAssTit:String;
    RiepAssVal:String;
  end;

  TW009FStampaCartellino = class(TR013FIterBase)
    lblParametrizzazione: TmeIWLabel;
    cmbParametrizzazione: TmeIWComboBox;
    lblElabDal: TmeIWLabel;
    btnAggiornamento: TmeIWButton;
    btnStampa: TmeIWButton;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    chkAutoGiustificazione: TmeIWCheckBox;
    chkAggiornamentoBuoniPasto: TmeIWCheckBox;
    chkAggiornamentoScheda: TmeIWCheckBox;
    chkAggiornamentoAccessiMensa: TmeIWCheckBox;
    dsrT860: TDataSource;
    cdsT860: TClientDataSet;
    chkVisRiepiloghi: TmeIWCheckBox;
    imgPeriodoPrec: TmeIWImageFile;
    imgPeriodoSucc: TmeIWImageFile;
    cmbNominativoDa: TmeIWComboBox;
    lblNominativoDa: TmeIWLabel;
    lblNominativoA: TmeIWLabel;
    cmbNominativoA: TmeIWComboBox;
    chkInserimentoRiposi: TmeIWCheckBox;
    DCOMConnection1: TDCOMConnection;
    grdCartellinoRiepilogo: TmedpIWDBGrid;
    grdCartellinoDettaglio: TmedpIWDBGrid;
    grdCartellinoPresenze: TmedpIWDBGrid;
    grdCartellinoAssenze: TmedpIWDBGrid;
    dsrCartellinoRiepilogo: TDataSource;
    dsrCartellinoDettaglio: TDataSource;
    dsrCartellinoPresenze: TDataSource;
    dsrCartellinoAssenze: TDataSource;
    dsrCartellinoAnagrafico: TDataSource;
    grdCartellinoAnagrafico: TmedpIWDBGrid;
    procedure btnAggiornamentoClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbParametrizzazioneChange(Sender: TObject);
    procedure chkVisRiepiloghiClick(Sender: TObject);
    procedure cmbNominativoDaChange(Sender: TObject);
    procedure cmbNominativoAChange(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure chkAggiornamentoSchedaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    W009FStampaCartellinoDtm: TW009FStampaCartellinoDtm;
    W009DM: TW009FIterCartellinoDM;
    CodiceT950,Modo: String;
    DataI,DataF:TDateTime;
    iSQL:Integer;
    ElencoMatricoleFiltro:String;
    AnomalieBloccantiDesc,SelectedSenderName :String;
    lst:TStringList;
    EseguiConteggi,AnomalieBloccanti,CtrlRichScadute,ResAutTuttoOk,AggRiep,ForzaPeriodo: Boolean;
    Autorizza: TAutorizza;
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure ApriDataset;
    procedure CaricaRecordConteggi(const PInizio, PFine: TDateTime);
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure Autorizzazione1;
    procedure AutorizzazioneOK;
    procedure imgStampaCartellinoClick(Sender: TObject);
    function  ControlliOk(var Err: String): Boolean;
    function  GetRichiestePendenti(var Elenco: String): Integer;
    function  ValidazioneCartellino(var ErrValid: String; var ErrBloccante: Boolean): Boolean;
    procedure OnConfermaValidazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure EseguiCartellini;
    procedure AvvisoValidazione;
    procedure EseguiStampa;
    procedure BloccoRiepiloghi(const PBlocca: Boolean; const PDataRiep: TDateTime);
    procedure VerificaAutorizzazioneAutomatica;
    procedure W009AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    procedure AggiornaRiepiloghi;
    procedure EliminaComponentiRiepilogo;
    procedure CreaComponentiRiepilogo;
    procedure GestioneFiltroNominativi;
    procedure FiltroSelAnagrafeW(DataSet: TDataSet; var Accept: Boolean);
    procedure EseguiStampaViaB028;
    function  CreateJsonString:String;
    function  CreateSQLSelezioneAnagrafica:String;
    procedure ResultWC020(Sender: TObject; Result: Boolean; Valore: String);
  protected
    function  GetTuttiDipSelezionato: Boolean; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure OnCambiaProgressivo; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    lstRiepDett: Array of tRiepDett;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

uses IWApplication, IWGlobal, SyncObjs, R400UCartellinoDtM;

function TW009FStampaCartellino.InizializzaAccesso:Boolean;
begin
  Result:=True;

  CambioDipendenteAsync:=False; //(Tag = 405);
  chkVisRiepiloghi.Visible:=Tag <> 405;
  if Tag <> 405 then
  begin
    Title:='(W009) Validazione cartellino';
    // funzione di validazione cartellini
    JavascriptBottom.Add('document.getElementById("iterT860").className = "";'); // rende visibile il riquadro di validazione
    if Iter = '' then
    begin
      // rilegge abilitazione maschera per tag <> 405
      SolaLettura:=A000GetInibizioni('Tag',IntToStr(Tag)) = 'R';

      Iter:=ITER_CARTELLINO;
      HelpKeyWord:='W009P1';
      C018.PreparaDataSetIter(W009DM.selT860,tiAutorizzazione);
      // imposta variabili dataset principale
      W009DM.selT860.SetVariable('AZIENDA',Parametri.Azienda);
      W009DM.selT860.SetVariable('DATALAVORO',Parametri.DataLavoro);

      // modifica caption per dipendente
      if Parametri.InibizioneIndividuale then
      begin
        C018.TipoRichiestaCaption[trDaAutorizzare]:=A000TraduzioneStringhe('da validare');
        C018.TipoRichiestaCaption[trAutorizzate]:=A000TraduzioneStringhe('validate');
        C018.TipoRichiestaCaption[trDaAutFinale]:=A000TraduzioneStringhe('da autorizzare');
        C018.TipoRichiestaCaption[trAutFinale]:=A000TraduzioneStringhe('autorizzate');
      end;

      // nasconde elementi di stampa cartellino
      lblElabDal.Visible:=False;
      imgPeriodoPrec.Visible:=False;
      edtDal.Visible:=False;
      edtAl.Visible:=False;
      imgPeriodoSucc.Visible:=False;
      chkAggiornamentoScheda.Visible:=False;
      chkAggiornamentoAccessiMensa.Visible:=False;
      chkAutoGiustificazione.Visible:=False;
      chkAggiornamentoBuoniPasto.Visible:=False;
      chkInserimentoRiposi.Visible:=False;
      btnAggiornamento.Visible:=False;
      btnStampa.Visible:=False;

      // gestione tabella
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
      grdRichieste.medpRighePagina:=GetRighePaginaTabella;
      // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
      grdRichieste.medpDataSet:=W009DM.selT860;
      grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

      if (WR000DM.Responsabile) and
         (not (Parametri.InibizioneIndividuale)) then // daniloc. 26.06.2012
      begin
        medpAutorizzaMultiplo:=True;
        OnAutorizzaTutto:=W009AutorizzaTutto;
      end;
    end;
  end;

  if Tag = 405 then
    GetDipendentiDisponibili(Parametri.DataLavoro)
  else
  begin
    GetDipendentiDisponibili(C018.Periodo.Fine);
    W009DM.selT860.ReadBuffer:=Min(1000,selAnagrafeW.RecordCount * IfThen(Parametri.WEBCartelliniMMPrec > 0,Parametri.WEBCartelliniMMPrec,12)); // default = 12 mesi max per dipendente
  end;
  if (Tag = 405) or WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
    GestioneFiltroNominativi;
  end
  else
  begin
    selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW009FStampaCartellino.IWAppFormCreate(Sender: TObject);
var
  Dal,Al:TDateTime;
begin
  inherited;
  CampiV430:='V430.T430INIZIO,V430.T430FINE';

  // abilitazione dei checkbox
  chkAggiornamentoScheda.Visible:=not SolaLettura;
  chkAutoGiustificazione.Visible:=not SolaLettura;
  btnAggiornamento.Visible:=not SolaLettura;
  chkAggiornamentoBuoniPasto.Visible:=A000GetInibizioni('Funzione','OpenA074RiepilogoBuoni') = 'S';
  chkAggiornamentoAccessiMensa.Visible:=A000GetInibizioni('Funzione','OpenA049StampaPasti') = 'S';
  //Alberto 04/04/2018: abilitazione inserimento riposi solo è definito un campo anagrafico per la regola. Se regola unica non si abilita per evitare sbagli da parte degli operatori.
  chkInserimentoRiposi.Visible:=(not SolaLettura) and (A000GetInibizioni('Funzione','OpenA041InsRiposi') = 'S') and (Parametri.CampiRiferimento.C16_INSRIPOSI <> '');
  chkInserimentoRiposi.Enabled:=False;
  ForzaPeriodo:=False;
  SelectedSenderName:='';
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtDal.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtAl.Text:=FormatDateTime('dd/mm/yyyy',Al);

  // popola elenco parametrizzazioni di stampa
  cmbParametrizzazione.Items.Clear;
  with WR000DM.Q950Lista do
  begin
    Open;
    while not Eof do
    begin
      cmbParametrizzazione.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    CloseAll;
    cmbParametrizzazione.RequireSelection:=cmbParametrizzazione.Items.Count > 0;
  end;

  // nuovo datamodulo
  W009DM:=TW009FIterCartellinoDM.Create(Self);
  CtrlRichScadute:=True;

  // imposta la gestione automatica degli spostamenti di periodo
  AssegnaGestPeriodo(edtDal,edtAl,imgPeriodoPrec,imgPeriodoSucc);
end;

procedure TW009FStampaCartellino.IWAppFormRender(Sender: TObject);
var
  JsCode: String;
  LCorrezionePxMargineR: Integer;
begin
  inherited;

  // spostamento combo nominativo da per allinearlo a combo dipendenti
  if cmbNominativoDa.Visible then
  begin
    LCorrezionePxMargineR:=-1;
    JsCode:=Format('try { '#13#10 +
                     '  var lCmbDip = $("#%s"); '#13#10 +
                     '  var lcmbNom = $("#%s")  '#13#10 +
                     '  if ((lCmbDip.length > 0) && (lcmbNom.length > 0)) { '#13#10 +
                     '    var lOffsetDip = lCmbDip.offset(); '#13#10 +
                     '    var lOffsetNom = lcmbNom.offset(); '#13#10 +
                     '    if ((lOffsetDip !== undefined) && (lOffsetNom !== undefined)) { '#13#10 +
                     '      var lMargineR = (lOffsetNom.left - lOffsetDip.left) + %d; '#13#10 +
                     '      lcmbNom.css("margin-right", lMargineR + "px"); '#13#10 +
                     '    } '#13#10 +
                     '  } '#13#10 +
                     '} '#13#10 +
                     'catch (err) { '#13#10 +
                     '  try { console.log("errore correzione margine dx combobox nominativo_da: " + err.message); } catch(err2) {} '#13#10 +
                     '} ',
                     [cmbDipendentiDisponibili.HTMLName,cmbNominativoDa.HTMLName,LCorrezionePxMargineR]);
    AddToInitProc(JsCode);
  end;
end;

procedure TW009FStampaCartellino.VisualizzaDipendenteCorrente;
var
  Fase: String;
  c: Integer;
  D,InizioCont,FineCont: TDateTime;
  LVisFiltroNominativi: Boolean;
begin
  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // visibilità filtro nominativo (solo per stampa cartellino)
  LVisFiltroNominativi:=(Tag = 405) and (TuttiDipSelezionato);
  lblNominativoDa.Visible:=LVisFiltroNominativi;
  cmbNominativoDa.Visible:=LVisFiltroNominativi;
  lblNominativoA.Visible:=LVisFiltroNominativi;
  cmbNominativoA.Visible:=LVisFiltroNominativi;

  if Tag <> 405 then
  begin
    ParametriForm.Dal:=C018.Periodo.Inizio;
    ParametriForm.Al:=C018.Periodo.Fine;

    grdRichieste.medpStato:=msBrowse;
    // popolamento dataset: record presenti sul db + eventuali record calcolati
    Fase:='caricamento delle richieste di validazione cartellino';
    ApriDataset;
    // aggiunge record dei cartellini nuovi
    EseguiConteggi:=True;
    if EseguiConteggi then
    begin
      try
        // se richiesto effettua i conteggi per aggiungere i record
        // con i cartellini che possono essere oggetto di validazione
        // periodo: ultimi 12 mesi
        Fase:='elaborazione dei cartellini da autorizzare';
        D:=R180InizioMese(Date);
        InizioCont:=R180AddMesi(D,-1 * IfThen(Parametri.WEBCartelliniMMPrec > 0,Parametri.WEBCartelliniMMPrec,12));
        InizioCont:=Max(InizioCont,Parametri.WEBCartelliniDataMin);
        FineCont:=D - 1;
        CaricaRecordConteggi(InizioCont,FineCont);
      except
        on E: Exception do
        begin
          Log('Errore','Errore in fase di ' + Fase,E);
          MsgBox.TextIsHTML:=False;
          MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W009_ERR_ANOMALIA_GENERICA),[Fase,E.Message]),ESCLAMA);
        end;
      end;
      W009DM.selT860.Refresh;
    end;

    // effettua il controllo delle richieste scadute, al fine di autorizzarle automaticamente
    if CtrlRichScadute then
    begin
      VerificaAutorizzazioneAutomatica;
      CtrlRichScadute:=False;
    end;

    grdRichieste.medpCreaCDS;
    grdRichieste.medpEliminaColonne;
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
    grdRichieste.medpAggiungiColonna('MESE_CARTELLINO','Mese cartellino','',nil);
    grdRichieste.medpAggiungiColonna('CF_RIEPILOGHI','Riepiloghi','',nil);
    grdRichieste.medpColonna('CF_RIEPILOGHI').Visible:=Tag <> 405;
    //medpAggiungiColonna('DBG_COMANDI','Stampa','',nil); // spostata su
    if Parametri.InibizioneIndividuale then
    begin
      grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Validazione','',nil);
      grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE_FINALE','Autorizzazione','',nil);
      grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    end
    else
      grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizzazione','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpInizializzaCompGriglia;
    // componenti
    if not SolaLettura then
    begin
      c:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
      grdRichieste.medpPreparaComponenteGenerico('R',c,0,DBG_CHK,'',A000TraduzioneStringhe(A000MSG_MSG_SI),'','');
      grdRichieste.medpPreparaComponenteGenerico('R',c,1,DBG_CHK,'',A000TraduzioneStringhe(A000MSG_MSG_NO),'','');
      c:=grdRichieste.medpIndexColonna('DBG_COMANDI');
      grdRichieste.medpPreparaComponenteGenerico('R',c,0,DBG_IMG,'','STAMPA',A000TraduzioneStringhe(A000MSG_W009_FMT_CARTELLINO_DI_MESE),'','');
    end;
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','','');
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','','');
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick);
    grdRichieste.medpCaricaCDS;

    EliminaComponentiRiepilogo;
    CreaComponentiRiepilogo;
    grdRichiesteAfterCaricaCDS(nil,'');
  end;
end;

procedure TW009FStampaCartellino.RefreshPage;
begin
  WR000DM.Responsabile:=True;
  if grdRichieste.medpStato = msBrowse then
    VisualizzaDipendenteCorrente;
end;

function TW009FStampaCartellino.GetTuttiDipSelezionato: Boolean;
var
  LRecordCountTotale: Integer;
begin
  if selAnagrafeW.Filtered then
  begin
    // se il dataset è filtrato, la property Tag contiene il RecordCount
    // totale, filtro escluso
    LRecordCountTotale:=selAnagrafeW.Tag;
    Result:=(ElementoTuttiDip) and
            (selAnagrafeW.Active) and
            (LRecordCountTotale > 1) and
            (cmbDipendentiDisponibili.ItemIndex = 0);
  end
  else
  begin
    // comportamento standard
    Result:=inherited;
  end;
end;

procedure TW009FStampaCartellino.GetDipendentiDisponibili(Data:TDateTime);
var
  LProg: Integer;
  LCodice, LDescrizione: String;
begin
  ElementoTuttiDip:=True;
  inherited;

  // nel caso di stampa cartellino popola elenco nominativi per filtro
  if Tag = 405 then
  begin
    cmbNominativoDa.Items.Clear;
    cmbNominativoA.Items.Clear;

    if not selAnagrafeW.Active then
      Exit;

    LProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    try
      cmbNominativoDa.Items.Add('=');
      selAnagrafeW.First;
      while not selAnagrafeW.Eof do
      begin
        LCodice:=selAnagrafeW.FieldByName('MATRICOLA').AsString;
        LDescrizione:=Format('%s %s',
                             [selAnagrafeW.FieldByName('COGNOME').AsString,
                              selAnagrafeW.FieldByName('NOME').AsString]);
        cmbNominativoDa.Items.Add(LDescrizione + '=' + LCodice);
        selAnagrafeW.Next;
      end;
      cmbNominativoA.Items.Assign(cmbNominativoDa.Items);
      cmbNominativoDa.RequireSelection:=cmbNominativoDa.Items.Count > 0;
      cmbNominativoA.RequireSelection:=cmbNominativoA.Items.Count > 0;

      // inizializza selezione combobox nulla
      cmbNominativoDa.ItemIndex:=0;
      cmbNominativoA.ItemIndex:=0;
      GestioneFiltroNominativi;
    finally
      // riposizionamento su selAnagrafeW
      if not selAnagrafeW.SearchRecord('PROGRESSIVO',LProg,[srFromBeginning]) then
        selAnagrafeW.First;
    end;
  end;
end;

procedure TW009FStampaCartellino.OnCambiaProgressivo;
var
  LVisFiltroNominativi: Boolean;
begin
  inherited;

  // gestione filtro nominativi solo per stampa cartellino
  LVisFiltroNominativi:=(Tag = 405) and (TuttiDipSelezionato);
  lblNominativoDa.Visible:=LVisFiltroNominativi;
  cmbNominativoDa.Visible:=LVisFiltroNominativi;
  lblNominativoA.Visible:=LVisFiltroNominativi;
  cmbNominativoA.Visible:=LVisFiltroNominativi;

  // se il filtro nominativi non è disponibile, azzera il range
  if not LVisFiltroNominativi then
  begin
    cmbNominativoDa.ItemIndex:=0;
    cmbNominativoA.ItemIndex:=0;
  end;

  // gestione filtro
  GestioneFiltroNominativi;
end;

procedure TW009FStampaCartellino.ApriDataset;
// apre il dataset delle richieste e i dataset di supporto per gli aggiornamenti
var
  FiltroAnag,FiltroPeriodo,FiltroVis: String;
  RiapriDataset: Boolean;
begin
  // determina filtri
  FiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger.ToString);
  FiltroPeriodo:=C018.Periodo.Filtro;
  FiltroVis:=C018.FiltroRichieste;

  RiapriDataset:=(FiltroAnag <> VarToStr(W009DM.selT860.GetVariable('FILTRO_ANAG'))) or
                 (FiltroPeriodo <> VarToStr(W009DM.selT860.GetVariable('FILTRO_PERIODO'))) or
                 (FiltroVis <> VarToStr(W009DM.selT860.GetVariable('FILTRO_VISUALIZZAZIONE')));
  DebugClear;
  if (RiapriDataset) or (not W009DM.selT860.Active) then
  begin
    W009DM.selT860.Close;
    if W009DM.selT860.VariableIndex('FILTRO_ANAG') >= 0 then
      W009DM.selT860.SetVariable('FILTRO_ANAG',FiltroAnag);
    if W009DM.selT860.VariableIndex('FILTRO_PROGRESSIVI') >= 0 then
    begin
      FiltroAnag:='T030A.PROGRESSIVO in (' + ElencoProgressivi + ')';
      W009DM.selT860.SetVariable('FILTRO_PROGRESSIVI',FiltroAnag);
    end;
    W009DM.selT860.SetVariable('FILTRO_PERIODO',FiltroPeriodo);
    W009DM.selT860.SetVariable('FILTRO_VISUALIZZAZIONE',FiltroVis);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    W009DM.selT860.SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    // MONDOEDP - commessa MAN/07.ini
    W009DM.selT860.SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    // MONDOEDP - commessa MAN/07.fine
    R013Open(W009DM.selT860);
    AggRiep:=True;
    if chkVisRiepiloghi.Checked then
      AggiornaRiepiloghi;
  end
  else
  begin
    W009DM.selT860.Refresh;
  end;
end;

procedure TW009FStampaCartellino.CaricaRecordConteggi(const PInizio, PFine: TDateTime);
var
  D: TDateTime;
  Err,ErrDip, NoteFisse: String;
  LNew: Integer;
begin
  // imposta note fisse per richiesta
  NoteFisse:=A000TraduzioneStringhe(A000MSG_W009_CARTELLINO_PRONTO_VALIDAZIONE);

  WR000DM.selDatiBloccati.Close;

  // ciclo di stampa cartellini e corrispondenti inserimenti nel client dataset
  if TuttiDipSelezionato then
    selAnagrafeW.First;

  Err:='';
  W009DM.selT070.Close;
  W009DM.selT070.ClearVariables;
  W009DM.selT070.SetVariable('DATA1',PInizio);
  W009DM.selT070.SetVariable('DATA2',PFine);
  W009DM.selT860.OnCalcFields:=nil; // disattiva temporaneamente il calcfields
  while not selAnagrafeW.Eof do
  begin
    ErrDip:='';
    R180SetVariable(W009DM.selT070,'PROGRESSIVO',medpProgressivo);
    W009DM.selT070.Open;
    while not W009DM.selT070.Eof do
    begin
      D:=W009DM.selT070.FieldByName('DATA').AsDateTime;
      //if WR000DM.selDatiBloccati.DatoBloccato(medpProgressivo,D,'T860',True) then
      if W009DM.selT070.FieldByName('RIEPILOGO_T860').AsString = 'C' then
      begin
        W009DM.selT860.Append;
        W009DM.selT860.FieldByName('PROGRESSIVO').AsInteger:=medpProgressivo;
        W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime:=D;
        try
          // nota: non considera WarningRichiesta!
          LNew:=C018.InsRichiesta('',NoteFisse,'');
          if C018.MessaggioOperazione <> '' then
          begin
            W009DM.selT860.Cancel;
            raise Exception.Create(C018.MessaggioOperazione);
          end
          else
          begin
            // rende effettiva l'autorizzazione all'ultimo livello
            if LNew = C018.LivMaxObb then
              BloccoRiepiloghi(True, D);
          end;
        except
          on E:Exception do
          begin
            ErrDip:=Format('%s%s: %s%s',[ErrDip,FormatDateTime('mmmm yyyy',D),E.Message,CRLF]);
          end;
        end;
        SessioneOracle.Commit;
      end;
      W009DM.selT070.Next;
    end; // end ciclo T070

    // determina se proseguire con il dipendente successivo oppure terminare
    if TuttiDipSelezionato then
    begin
      if ErrDip <> '' then
        Err:=Format('%sNominativo: %s %s%s%s',[Err,selAnagrafeW.FieldByName('COGNOME').AsString,selAnagrafeW.FieldByName('NOME').AsString,CRLF,ErrDip]);
      selAnagrafeW.Next;
    end
    else
    begin
      Err:=ErrDip;
      Break;
    end;
  end; // end ciclo anagrafe
  W009DM.selT860.OnCalcFields:=W009DM.selT860CalcFields; // riattiva il calcfields

  // in caso di anomalie lancia un'eccezione che viene intercettata a livello superiore
  if Err <> '' then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_CARTELLINI_VALIDATI),[CRLF,Err]);
    raise Exception.Create(Err);
  end;
end;

procedure TW009FStampaCartellino.VerificaAutorizzazioneAutomatica;
// controlla le richieste attualmente visibili ed esegue un ciclo di
// autorizzazione automatica (nella condizione di aut. automatica dovrebbe esserci una scadenza)
// NOTA: le richieste nel dataset sono solo quelle "da autorizzare"
var
  Aut,MsgAut,ErrAut,Msg: String;
  LOld,LNew,ContaAut: Integer;
begin
  // inizializzazione variabili
  MsgAut:='';
  ErrAut:='';
  ContaAut:=0;
  Aut:=C018SI;

  // autorizzazione richieste scadute
  W009DM.selT860.First;
  while not W009DM.selT860.Eof do
  begin
    try
      if (W009DM.selT860.FieldByName('ID_REVOCA').IsNull) and
         (W009DM.selT860.FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') then
      begin
        try
          C018.CodIter:=W009DM.selT860.FieldByName('COD_ITER').AsString;
          C018.Id:=W009DM.selT860.FieldByName('ID').AsInteger;
          // se la richiesta non è ancora autorizzata all'ultimo livello
          // inserisce le autorizzazioni automatiche necessarie
          LOld:=C018.LivMaxAut;
          if LOld < C018.LivMaxObb then
          begin
            try
              LNew:=C018.InsAutorizzazioniAutomatiche;
              if LNew > max(0,LOld) then
              begin
                inc(ContaAut);
                MsgAut:=Format('%s%s - %s%s',[MsgAut,W009DM.selT860.FieldByName('NOMINATIVO').AsString,FormatDateTime('mmmm yyyy',W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime),CRLF]);
                // rende effettiva l'autorizzazione all'ultimo livello
                if (LNew = C018.LivMaxObb) then
                  BloccoRiepiloghi(True,W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime);
              end;
            except
              on E: Exception do
                ErrAut:=Format('%s%s - %s: %s%s',[ErrAut,W009DM.selT860.FieldByName('NOMINATIVO').AsString,FormatDateTime('mmmm yyyy',W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime),E.Message,CRLF]);
            end;
            SessioneOracle.Commit;
          end;
        except
          // errore probabilmente dovuto a record modificato / cancellato da altro utente
        end;
      end;
    finally
      W009DM.selT860.Next;
    end;
  end;
  W009DM.selT860.Refresh;

  // prepara messaggio di conferma
  Msg:='';
  if ContaAut > 0 then
  begin
    if ContaAut = 1 then
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_RICHIESTA_AUTO),[CRLF,MsgAut])
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_RICHIESTA_AUTO2),[ContaAut,CRLF,MsgAut]);
  end;
  // errori di autorizzazione
  if ErrAut <> '' then
  begin
    if Msg <> '' then
      Msg:=Msg + CRLF;
    Msg:=Msg + IfThen(Msg <> '',CRLF) + Format(A000TraduzioneStringhe(A000MSG_W009_ERR_FMT_RICHIESTA_AUTO),[ErrAut]);
  end;
  if Msg <> '' then
    MsgBox.MessageBox(Msg,IfThen(ErrAut = '',INFORMA,ESCLAMA));
end;

procedure TW009FStampaCartellino.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i, idxStampa, idxAut, LivAut, d, idxRiep, x, maxComp: Integer;
  VisAutorizza,VisStampa: Boolean;
  Data: TDateTime;
  IWImg: TmeIWImageFile;
begin
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0);
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    // dettaglio iter
    with (grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile) do
    begin
      OnClick:=imgIterClick;
      Hint:=C018.LeggiNoteComplete;
      ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      if C018.SetIconaAllegati(IWImg) then
        IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if not SolaLettura then
    begin
      // autorizzazione
      VisAutorizza:=(grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
                    (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
                    (LivAut > 0);
      idxAut:=grdRichieste.medpIndexColonna('D_AUTORIZZAZIONE');
      if not VisAutorizza then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxAut]);
      if grdRichieste.medpCompGriglia[i].CompColonne[idxAut] <> nil then
        C018.SetValoriAut(grdRichieste,i,idxAut,0,1,chkAutorizzazioneClick);

      // anteprima cartellino
      VisStampa:=True;
      idxStampa:=grdRichieste.medpIndexColonna('DBG_COMANDI');
      if not VisStampa then
        FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxStampa]);
      if grdRichieste.medpCompGriglia[i].CompColonne[idxStampa] <> nil then
      begin
        (grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).OnClick:=imgStampaCartellinoClick;
        Data:=StrToDate(grdRichieste.medpValoreColonna(i,'MESE_CARTELLINO'));
        (grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).Hint:=Format((grdRichieste.medpCompCella(i,idxStampa,0) as TmeIWImageFile).Hint,[FormatDateTime('mmmm yyyy',Data)]);
      end;
    end;

    //Componenti colonna riepiloghi
    idxRiep:=grdRichieste.medpIndexColonna('CF_RIEPILOGHI');
    if grdRichieste.medpCompGriglia[i].CompColonne[idxRiep] <> nil then
    begin
      maxComp:=(grdRichieste.medpCompGriglia[i].CompColonne[idxRiep] as TmeIWGrid).RowCount - 1;
      for d:=0 to High(lstRiepDett) do
        if (StrToIntDef(grdRichieste.medpValoreColonna(i,'PROGRESSIVO'),0) = lstRiepDett[d].Prog)
        and (StrToDateTime(grdRichieste.medpValoreColonna(i,'MESE_CARTELLINO')) = lstRiepDett[d].Mese) then
        begin
          //Dati riepilogativi
          for x:=0 to High(lstRiepDett[d].RiepDati) do
          begin
            (grdRichieste.medpCompCella(i,idxRiep,x * 2) as TmeIWLabel).Caption:=lstRiepDett[d].RiepDati[x].Titolo;
            (grdRichieste.medpCompCella(i,idxRiep,(x * 2) + 1) as TmeIWLabel).Caption:=lstRiepDett[d].RiepDati[x].Valore;
          end;
          //Riepilogo presenze
          (grdRichieste.medpCompCella(i,idxRiep,((maxComp - 1) * 2)) as TmeIWLabel).Caption:=lstRiepDett[d].RiepPresTit;
          (grdRichieste.medpCompCella(i,idxRiep,((maxComp - 1) * 2) + 1) as TmeIWLabel).Caption:=lstRiepDett[d].RiepPresVal;
          //Riepilogo assenze
          (grdRichieste.medpCompCella(i,idxRiep,maxComp * 2) as TmeIWLabel).Caption:=lstRiepDett[d].RiepAssTit;
          (grdRichieste.medpCompCella(i,idxRiep,(maxComp * 2) + 1) as TmeIWLabel).Caption:=lstRiepDett[d].RiepAssVal;
        end;
    end;
  end;
end;

procedure TW009FStampaCartellino.imgIterClick(Sender: TObject);
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);
  with W009DM.selT860 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE),INFORMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW009FStampaCartellino.imgAllegClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAllegClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdRichieste.medpStato = msBrowse then
    DBGridColumnClick(Sender,FN);

  if not W009DM.selT860.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    VisualizzaDipendenteCorrente;
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE),INFORMA);
    Exit;
  end;
  VisualizzaAllegati(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

procedure TW009FStampaCartellino.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  NomeCampo: String;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True,not InModificaTutti) then
    Exit;

  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  NomeCampo:=grdRichieste.medpColonna(NumColonna).DataField;

  if (NomeCampo = 'CF_RIEPILOGHI') and not chkVisRiepiloghi.Checked then
    ACell.Css:='invisibile';

  if ARow = 0 then
  begin
    // nessuna operazione
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

      if ACell.Control = nil then
      begin
        ACell.Css:=ACell.Css + IfThen(NomeCampo <> 'CF_RIEPILOGHI',' align_center');
        if NomeCampo = 'D_AUTORIZZAZIONE' then
        begin
          // autorizzazione
          ACell.Css:=ACell.Css + ' font_grassetto';
        end;
      end;
    end;
  end;
end;

procedure TW009FStampaCartellino.DBGridColumnClick(ASender: TObject; const AValue: String);
var
  D: TDateTime;
begin
  if cdsT860.RecordCount = 0 then
    Exit;
  cdsT860.Locate('DBG_ROWID',AValue,[]);

  // posizionamento dataset
  W009DM.selT860.SearchRecord('ROWID',cdsT860.FieldByName('DBG_ROWID').AsString,[srFromBeginning]);

  // imposta le date di riferimento per il cartellino
  D:=cdsT860.FieldByName('MESE_CARTELLINO').AsDateTime;
  edtDal.Text:=DateToStr(D);
  edtAl.Text:=DateToStr(R180FineMese(D));

  // dipendente
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT860.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;
end;

procedure TW009FStampaCartellino.chkAggiornamentoSchedaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  chkInserimentoRiposi.Enabled:=chkAggiornamentoScheda.Checked;
  if not chkInserimentoRiposi.Enabled then
    chkInserimentoRiposi.Checked:=False;
end;

procedure TW009FStampaCartellino.chkAutorizzazioneClick(Sender: TObject);
begin
  Autorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  Autorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  Autorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  DBGridColumnClick(Sender,Autorizza.Rowid);

  if Autorizza.Checked and (Autorizza.Caption = A000TraduzioneStringhe(A000MSG_MSG_SI)) then
  begin
    // autorizzazione positiva: effettua validazione
    Autorizzazione1;
  end
  else
    AutorizzazioneOK;
end;

procedure TW009FStampaCartellino.chkVisRiepiloghiClick(Sender: TObject);
begin
  if chkVisRiepiloghi.Checked and AggRiep then
    AggiornaRiepiloghi;
end;

procedure TW009FStampaCartellino.cmbNominativoDaChange(Sender: TObject);
begin
  {
  if cmbNominativoDa.ItemIndex > 0 then
  begin
    // verifica che il range di nominativi sia coerente
    if cmbNominativoDa.ItemIndex > cmbNominativoA.ItemIndex then
      cmbNominativoA.ItemIndex:=cmbNominativoDa.ItemIndex;
  end
  else
  begin
    // selezione vuota
    cmbNominativoA.ItemIndex:=0;
  end;
  }
  GestioneFiltroNominativi;
end;

procedure TW009FStampaCartellino.cmbNominativoAChange(Sender: TObject);
begin
  {
  if cmbNominativoA.ItemIndex > 0 then
  begin
    // verifica che il range di nominativi sia coerente
    if cmbNominativoA.ItemIndex < cmbNominativoDa.ItemIndex then
      cmbNominativoDa.ItemIndex:=cmbNominativoA.ItemIndex;

    // se il nominativo da è vuoto, seleziona il primo
    if cmbNominativoDa.ItemIndex = 0 then
      cmbNominativoDa.ItemIndex:=1;
  end
  else
  begin
    // selezione vuota
    cmbNominativoDa.ItemIndex:=0;
  end;
  }
  GestioneFiltroNominativi;
end;

procedure TW009FStampaCartellino.GestioneFiltroNominativi;
var
  i, LNumDip, LIdxFrom, LIdxTo: Integer;
begin
  // determina elenco anagrafiche filtrate (tramite matricola)
  ElencoMatricoleFiltro:='';
  btnAggiornamento.Confirmation:='';
  btnStampa.Confirmation:='';

  if (Tag = 405) and TuttiDipSelezionato then
  begin
    if (cmbNominativoDa.ItemIndex > 0) or
       (cmbNominativoA.ItemIndex > 0) then
    begin
      // il primo elemento (vuoto) viene scartato
      LIdxFrom:=max(cmbNominativoDa.ItemIndex,1);
      // se il "nominativo a" è vuoto, considera tutte le matricole da "nominativo da" in avanti
      LIdxTo:=IfThen(cmbNominativoA.ItemIndex = 0,cmbNominativoA.Items.Count - 1,cmbNominativoA.ItemIndex);
      LNumDip:=LIdxTo - LIdxFrom + 1;
      if LNumDip < selAnagrafeW.RecordCount then
      begin
        // alcune matricole sono escluse: imposta l'elenco di quelle da considerare
        for i:=LIdxFrom to LIdxTo do
        begin
          ElencoMatricoleFiltro:=ElencoMatricoleFiltro + cmbNominativoDa.Items.ValueFromIndex[i] + ',';
        end;
      end;
    end
    else
    begin
      // filtro nominativi non indicato -> tutti i dipendenti
      LNumDip:=selAnagrafeW.RecordCount;
    end;

    // richiede conferma se l'operazione coinvolge n>1 dipendenti
    if LNumDip = 0 then
    begin
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_NO_DIP));
    end
    else if LNumDip = 1 then
    begin
      // no conferma per un solo dipendente
      btnAggiornamento.Confirmation:='';
      btnStampa.Confirmation:='';
    end
    else
    begin
      // per n>1 dipendenti chiede conferma
      btnAggiornamento.Confirmation:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_CONFERMA_AGGIORNAMENTO),[LNumDip]);
      btnStampa.Confirmation:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_CONFERMA_STAMPA),[LNumDip]);
    end;
  end;
end;

procedure TW009FStampaCartellino.cmbParametrizzazioneChange(Sender: TObject);
begin
  AggRiep:=True;
  if chkVisRiepiloghi.Checked then
    AggiornaRiepiloghi;
end;

procedure TW009FStampaCartellino.AggiornaRiepiloghi;
var d,i,n,xx,yy:Integer;
    ListaSettaggi:TStringlist;
    sTit:String;
begin
  if W009DM.selT860.RecordCount = 0 then
    exit;
  W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(Self);
  try
    CodiceT950:=Trim(Copy(cmbParametrizzazione.Text,1,5));
    // creazione datamodulo conteggi
    try
      W009FStampaCartellinoDtm.CreazioneR400(Self);
      Log('Traccia','R400 creato');
    except
      on E: Exception do
      begin
        Log('Errore','R400 non creato',E);
        raise;
      end;
    end;
    with W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int do
    begin
      Close;
      SetVariable('Codice',CodiceT950);
      Open;
    end;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=True;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.IgnoraAnomalie:=False;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=chkAggiornamentoScheda.Checked;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
    W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
    W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;

    ListaSettaggi:=TStringList.Create;
    with W009FStampaCartellinoDtM,R400FCartellinoDtM do
    begin
      try
        SetLength(VetDatiLiberiSQL,0);
        ListaSettaggi.Clear;
        R180SetVariable(selT951,'Codice',Q950Int.FieldByName('CODICE').AsString);
        selT951.Open;
        selT951.First;
        while not selT951.Eof do
        begin
          ListaSettaggi.Add(Trim(selT951.FieldByName('RIGA').AsString));
          selT951.Next;
        end;
        selT951.Close;

        cdsRiep.EmptyDataSet;
        //configurazione Riepilogo
        GetLabels(ListaSettaggi,'Riepilogo',nil,False);
      finally
        ListaSettaggi.Free;
      end;

      for i:=0 to High(lstRiepDett) do
        SetLength(lstRiepDett[i].RiepDati,0);
      SetLength(lstRiepDett,0);
      W009DM.selT860.First;
      while not W009DM.selT860.Eof do
      begin
        SetLength(lstRiepDett,Length(lstRiepDett) + 1);
        d:=High(lstRiepDett);
        lstRiepDett[d].Prog:=W009DM.selT860.FieldByName('PROGRESSIVO').AsInteger;
        lstRiepDett[d].Mese:=W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime;

        for xx:=1 to MaxRighe do for yy:=1 to MaxColonne do MatDettStampa[xx,yy]:='';
        for i:=1 to High(VetDomenica) do VetDomenica[i]:= -1;
        for xx:=Low(TotSett) to High(TotSett) do
        begin
          TotSett[xx].Data:=0;
          TotSett[xx].Debito:='';
          TotSett[xx].OreRese:='';
          TotSett[xx].Saldo:='';
        end;
        NumGiorniCartolina:=0;
        DipInser1:='si';
        if Parametri.WEBCartelliniChiusi = 'S' then
        begin
          selT070.Close;
          selT070.SetVariable('PROGRESSIVO',lstRiepDett[d].Prog);
          selT070.SetVariable('DATA',lstRiepDett[d].Mese);
          selT070.Open;
          if selT070.FieldByName('NUM').AsInteger = 0 then
            DipInser1:='no';
          selT070.Close;
        end;
        CreaClientDataSet(selAnagrafeW);
        if DipInser1 = 'si' then
        begin
          CartolinaDipendente(lstRiepDett[d].Prog,R180Anno(lstRiepDett[d].Mese),R180Mese(lstRiepDett[d].Mese),1,R180Giorno(R180FineMese(lstRiepDett[d].Mese)));
          if DipInser1 = 'si' then
          begin
            CaricaClientDataSet(lstRiepDett[d].Mese,R180FineMese(lstRiepDett[d].Mese));
            //Dati riepilogativi + Dato libero SQL (il 2000 Dato libero 2 è escluso)
            cdsRiep.First;
            while not cdsRiep.Eof do
            begin
              case cdsRiep.FieldByName('TAG').AsInteger of
                0..899,2001..2999://Dati riepilogativi + Dato libero SQL (il 2000 Dato libero 2 è escluso)
                begin
                  SetLength(lstRiepDett[d].RiepDati,Length(lstRiepDett[d].RiepDati) + 1);
                  n:=High(lstRiepDett[d].RiepDati);
                  if cdsRiep.FieldByName('TAG').AsInteger >= 2001 then
                  begin
                    sTit:=VetDatiLiberiSQL[cdsRiep.FieldByName('TAG').AsInteger - 2001].Dato;
                    sTit:=sTit + IfThen((Pos(': ',sTit) = 0) and (Copy(sTit,Length(sTit)) = ':'),' ');//Aggiungo la stringa " " se manca
                    sTit:=sTit + IfThen(Pos(': ',sTit) = 0,': ');//Aggiungo la stringa ": " se manca
                    lstRiepDett[d].RiepDati[n].Titolo:=Copy(sTit,1,Pos(': ',sTit) + 1);
                    lstRiepDett[d].RiepDati[n].Valore:=Copy(sTit,Pos(': ',sTit) + 2);
                  end
                  else
                  begin
                    sTit:=cdsRiep.FieldByName('CAPTION').AsString;
                    sTit:=sTit + IfThen(Copy(sTit,Length(sTit)) = ':',' ');//Aggiungo la stringa " " se manca
                    sTit:=sTit + IfThen(Copy(sTit,Length(sTit) - 1) <> ': ',': ');//Aggiungo la stringa ": " se manca
                    lstRiepDett[d].RiepDati[n].Titolo:=sTit;
                    lstRiepDett[d].RiepDati[n].Valore:=VetRiepStampa[cdsRiep.FieldByName('TAG').AsInteger];
                  end;
                  lstRiepDett[d].RiepDati[n].Titolo:=Copy(lstRiepDett[d].RiepDati[n].Titolo,1,Length(lstRiepDett[d].RiepDati[n].Titolo) - 2);
                end;
              end;
              cdsRiep.Next;
            end;
            //Riepilogo presenze
            cdsPresenze.First;
            while not cdsPresenze.Eof do
            begin
              lstRiepDett[d].RiepPresTit:=lstRiepDett[d].RiepPresTit + IfThen(lstRiepDett[d].RiepPresTit <> '',CRLF);
              lstRiepDett[d].RiepPresVal:=lstRiepDett[d].RiepPresVal + IfThen(lstRiepDett[d].RiepPresVal <> '',CRLF);
              cdsRiep.First;
              while not cdsRiep.Eof do
              begin
                case cdsRiep.FieldByName('TAG').AsInteger of
                  951..952://Codice, Descrizione presenze
                  begin
                    lstRiepDett[d].RiepPresTit:=lstRiepDett[d].RiepPresTit + cdsRiep.FieldByName('CAPTION').AsString + ' ' + cdsPresenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                  953..999://altri dati presenze
                  begin
                    lstRiepDett[d].RiepPresVal:=lstRiepDett[d].RiepPresVal + cdsRiep.FieldByName('CAPTION').AsString + ' ' + cdsPresenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                end;
                cdsRiep.Next;
              end;
              cdsPresenze.Next;
            end;
            lstRiepDett[d].RiepPresTit:=Trim(lstRiepDett[d].RiepPresTit);
            lstRiepDett[d].RiepPresVal:=Trim(lstRiepDett[d].RiepPresVal);
            //Riepilogo assenze
            cdsAssenze.First;
            while not cdsAssenze.Eof do
            begin
              lstRiepDett[d].RiepAssTit:=lstRiepDett[d].RiepAssTit + IfThen(lstRiepDett[d].RiepAssTit <> '',CRLF);
              lstRiepDett[d].RiepAssVal:=lstRiepDett[d].RiepAssVal + IfThen(lstRiepDett[d].RiepAssVal <> '',CRLF);
              cdsRiep.First;
              while not cdsRiep.Eof do
              begin
                case cdsRiep.FieldByName('TAG').AsInteger of
                  901,908://Codice, Descrizione assenze
                  begin
                    lstRiepDett[d].RiepAssTit:=lstRiepDett[d].RiepAssTit + cdsRiep.FieldByName('CAPTION').AsString + ' ' + cdsAssenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                  902..907,909..949://altri dati assenze
                  begin
                    lstRiepDett[d].RiepAssVal:=lstRiepDett[d].RiepAssVal + cdsRiep.FieldByName('CAPTION').AsString + ' ' + cdsAssenze.FieldByName('CAMPO' + IntToStr(cdsRiep.FieldByName('TAG').AsInteger)).AsString + ' ';
                  end;
                end;
                cdsRiep.Next;
              end;
              cdsAssenze.Next;
            end;
            lstRiepDett[d].RiepAssTit:=Trim(lstRiepDett[d].RiepAssTit);
            lstRiepDett[d].RiepAssVal:=Trim(lstRiepDett[d].RiepAssVal);
          end;
        end;
        W009DM.selT860.Next;
      end;
    end;

    W009DM.selT860.Refresh;
    grdRichieste.medpCaricaCDS;

    EliminaComponentiRiepilogo;
    CreaComponentiRiepilogo;
    grdRichiesteAfterCaricaCDS(nil,'');
  finally
    // distruzione R400
    W009FStampaCartellinoDtm.DistruzioneR400;
    try W009FStampaCartellinoDtM.DistruggiLstRaveComp; except end;
    FreeAndNil(W009FStampaCartellinoDtm);
  end;
  AggRiep:=False;
end;

procedure TW009FStampaCartellino.EliminaComponentiRiepilogo;
var i,j,x:Integer;
    IWC:TIWCustomControl;
begin
  x:=grdRichieste.medpIndexColonna('CF_RIEPILOGHI');
  with grdRichieste do
    for i:=0 to High(medpCompGriglia) do
    begin
      for j:=0 to High(medpCompGriglia[i].CompColonne) do
      begin
        if j <> x then //Cancello solo i componenti della colonna dei riepiloghi
          Continue;
        if medpCompGriglia[i].CompColonne[j] = nil then
          Continue;
        if medpCompGriglia[i].CompColonne[j] is TmeIWGrid then
          C190PulisciIWGrid((medpCompGriglia[i].CompColonne[j] as TmeIWGrid));
        IWC:=medpCompGriglia[i].CompColonne[j];
        medpCompGriglia[i].CompColonne[j]:=nil;
        FreeAndNil(IWC);
      end;
    end;
end;

procedure TW009FStampaCartellino.CreaComponentiRiepilogo;
var i,r,c,hDati:Integer;
begin
  if High(lstRiepDett) = -1 then
    exit;
  c:=grdRichieste.medpIndexColonna('CF_RIEPILOGHI');
  with grdRichieste do
  begin
    //Dati riepilogativi
    hDati:=High(lstRiepDett[0].RiepDati);
    for i:=0 to hDati do
    begin
      medpPreparaComponenteGenerico('C',0,i*2,DBG_LBL,'','','Nome dato','','S');
      medpPreparaComponenteGenerico('C',0,i*2 + 1,DBG_LBL,'','','Valore dato','','S');
    end;
    //Riepilogo presenze
    inc(hdati);
    medpPreparaComponenteGenerico('C',0,hdati*2,DBG_LBL,'','','Codice presenze','','S');
    medpPreparaComponenteGenerico('C',0,hdati*2 + 1,DBG_LBL,'','','Riepilogo presenze','','S');
    //Riepilogo assenze
    inc(hdati);
    medpPreparaComponenteGenerico('C',0,hdati*2,DBG_LBL,'','','Codice assenze','','S');
    medpPreparaComponenteGenerico('C',0,hdati*2 + 1,DBG_LBL,'','','Riepilogo assenze','','S');
    //Posizionamento
    for i:=0 to hDati do
    begin
      Componenti[i*2].Riga:=i;
      Componenti[i*2 + 1].Riga:=i;
    end;
    //La proprietà .GridInRiga va settata sull'ultima colonna della cella(altrimenti viene sovrascritta)
    Componenti[High(Componenti)].GridInRiga:=False;
    for r:=0 to High(grdRichieste.medpCompGriglia) do
      medpCreaComponenteGenerico(r,c,Componenti);
  end;
end;

procedure TW009FStampaCartellino.Autorizzazione1;
var
  ErrValid: String;
  ErrBloccante,
  BloccaAut: Boolean;
begin
  if not ValidazioneCartellino(ErrValid,ErrBloccante) then
  begin
    BloccaAut:=ErrBloccante or (not InAutorizzaTutti);
    if InAutorizzaTutti then
    begin
      ResAutTuttoOk:=False;
    end
    else
    begin
      if ErrBloccante then
      begin
        MsgBox.MessageBox(ErrValid,ESCLAMA);
        // refresh visualizzazione
        W009DM.selT860.Refresh;
        grdRichieste.medpCaricaCDS;

        EliminaComponentiRiepilogo;
        CreaComponentiRiepilogo;
        grdRichiesteAfterCaricaCDS(nil,'');
      end
      else
        MsgBox.WebMessageDlg(ErrValid,mtConfirmation,[mbYes,mbNo],OnConfermaValidazione,'');
    end;
  end
  else
    BloccaAut:=False;

  if not BloccaAut then
    AutorizzazioneOK;
end;

procedure TW009FStampaCartellino.AutorizzazioneOK;
var
  Aut,Resp: String;
begin
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W009DM.selT860 do
  begin
    // verifica presenza record
    if not SearchRecord('ROWID',Autorizza.RowId,[srFromBeginning]) then
    begin
      if InAutorizzaTutti then
      begin
        ResAutTuttoOk:=False;
      end
      else
      begin
        VisualizzaDipendenteCorrente;
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2),INFORMA);
        Exit;
      end;
    end;
    // imposta i dati di autorizzazione
    Resp:=Parametri.Operatore;
    if Autorizza.Checked and (Autorizza.Caption = A000TraduzioneStringhe(A000MSG_MSG_SI)) then
      // autorizzazione SI
      Aut:=C018SI
    else if Autorizza.Checked and (Autorizza.Caption = A000TraduzioneStringhe(A000MSG_MSG_NO)) then
      // autorizzazione NO
      Aut:=C018NO
    else if not Autorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
      SessioneOracle.Commit;
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione)
      else
      begin
        // rende effettiva l'autorizzazione all'ultimo livello
        if FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger = C018.LivMaxObb then
          BloccoRiepiloghi(Aut = C018SI,FieldByName('MESE_CARTELLINO').AsDateTime);
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        if InAutorizzaTutti then
          ResAutTuttoOk:=False
        else
          MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W009_FMT_IMP_AUTORIZ_FALLITE),[E.Message]),ESCLAMA);
      end;
    end;
    if not InAutorizzaTutti then
      VisualizzaDipendenteCorrente;
  end;
end;

procedure TW009FStampaCartellino.W009AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione di tutte le richieste
// ancora da autorizzare visibili a video.
var
  D: TDateTime;
begin
  Log('Traccia','W009AutorizzaTutto - inizio');

  // inizializzazione variabili
  ResAutTuttoOk:=True;

  // autorizzazione richieste
  with W009DM.selT860 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        try
          // validazione
          Autorizza.Rowid:=W009DM.selT860.RowId;
          Autorizza.Checked:=True;
          Autorizza.Caption:=A000TraduzioneStringhe(A000MSG_MSG_SI);

          // imposta date cartellino
          D:=W009DM.selT860.FieldByName('MESE_CARTELLINO').AsDateTime;
          edtDal.Text:=DateToStr(D);
          edtAl.Text:=DateToStr(R180FineMese(D));

          Autorizzazione1;
        except
          // errore probabilmente dovuto a record modificato / cancellato da altro utente
          on E:Exception do
            ResAutTuttoOk:=False;
        end;
      finally
        Next;
      end;
    end;
  end;

  if not ResAutTuttoOk then
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_W009_ERR_RICH_NO_AUTORIZZATE);
  Log('Traccia','W009AutorizzaTutto - fine');
  Ok:=True;
end;

procedure TW009FStampaCartellino.imgStampaCartellinoClick(Sender: TObject);
// simula un click su "Stampa" per visualizzare anteprima del mese
// attualmente selezionato nella griglia
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  DBGridColumnClick(Sender,FN);
  btnAggiornamentoClick(btnStampa);
end;

function TW009FStampaCartellino.GetRichiestePendenti(var Elenco: String): Integer;
// verifica richieste web pendenti (non ancora autorizzate) per il mese in oggetto
var
  NumRich: Integer;
  DescIter: String;
  function GetDescIter(const PIter: String): String;
  var
    i: Integer;
  begin
    Result:=PIter;
    for i:=0 to High(A000IterAutorizzativi) do
    begin
      if PIter = A000IterAutorizzativi[i].Cod then
      begin
        Result:=A000IterAutorizzativi[i].Desc;
        Break;
      end;
    end;
  end;
begin
  Result:=0;
  Elenco:='';
  R180SetVariable(W009DM.selRichiestePendenti,'VISTAT325',IfThen(Parametri.CampiRiferimento.C90_W026Spezzoni = 'EU','VT325_RICHIESTESTR_GG_EU','VT325_RICHIESTESTR_GG'));
  R180SetVariable(W009DM.selRichiestePendenti,'PROGRESSIVO',medpProgressivo);
  R180SetVariable(W009DM.selRichiestePendenti,'DATA1',DataI);
  R180SetVariable(W009DM.selRichiestePendenti,'DATA2',DataF);
  W009DM.selRichiestePendenti.Open;
  W009DM.selRichiestePendenti.First;
  while not W009DM.selRichiestePendenti.Eof do
  begin
    NumRich:=W009DM.selRichiestePendenti.FieldByName('NUM_RICHIESTE').AsInteger;
    if NumRich > 0 then
    begin
      DescIter:=GetDescIter(W009DM.selRichiestePendenti.FieldByName('ITER').AsString);
      Elenco:=Elenco + Format('%s- %d richieste di %s',[CRLF,NumRich,DescIter]);
      Result:=Result + NumRich;
    end;
    W009DM.selRichiestePendenti.Next;
  end;
end;

function TW009FStampaCartellino.ValidazioneCartellino(var ErrValid: String; var ErrBloccante: Boolean): Boolean;
// effettua la validazione del cartellino del dipendente selezionato
var
  ElencoRich: String;
begin
  Result:=False;
  ErrValid:='';
  ErrBloccante:=False;

  // cartellino in modalità validazione
  Modo:='V';
  AnomalieBloccanti:=False;
  if not ControlliOk(ErrValid) then
    Exit;

  // effettua una stampa cartellino per estrarre eventuali anomalie
  // se ci sono anomalie bloccanti non valida il cartellino
  EseguiCartellini;
  if AnomalieBloccanti then
  begin
    ErrValid:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_ANOMALIE_CARTELLINO),[FormatDateTime('mmmm yyyy',DataI),AnomalieBloccantiDesc]);
    ErrBloccante:=True;
    Exit;
  end;

  // verifica se ci sono richieste pendenti da segnalare
  ElencoRich:='';
  if GetRichiestePendenti(ElencoRich) > 0 then
  begin
    ErrValid:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_RICH_WEB_PENDENTI),[FormatDateTime('mmmm yyyy',DataI),ElencoRich]);
    ErrBloccante:=False;
    Exit;
  end;

  Result:=True;
end;

procedure TW009FStampaCartellino.OnConfermaValidazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
// risposta del messaggio modale di conferma validazione
begin
  if Res = mrYes then
    AutorizzazioneOK
  else
  begin
    W009DM.selT860.Refresh;
    grdRichieste.medpCaricaCDS;

    EliminaComponentiRiepilogo;
    CreaComponentiRiepilogo;
    grdRichiesteAfterCaricaCDS(nil,'');
  end;
end;

function TW009FStampaCartellino.ControlliOk(var Err: String): Boolean;
// verifica dei dati prima della stampa
begin
  Result:=False;
  if (Modo = 'A') and (not chkAggiornamentoScheda.Checked) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_W009_MSG_AGG_NON_ABILITATO);
    Exit;
  end;
  if not TryStrToDate(edtDal.Text,DataI) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
    ActiveControl:=edtDal;
    Exit;
  end;
  if not TryStrToDate(edtAl.Text,DataF) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO);
    ActiveControl:=edtAl;
    Exit;
  end;
  if DataF < DataI then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO);
    Exit;
  end;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Err:=A000TraduzioneStringhe(A000MSG_ERR_DATE_STESSO_ANNO);
    Exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_STOP_CART_PRIMA_DEL),[DateToStr(Parametri.WEBCartelliniDataMin)]);
    Exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_STOP_CART_PRIMA_MESI),[Parametri.WEBCartelliniMMPrec]);
    Exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Err:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_STOP_CART_SUCC_MESI),[Parametri.WEBCartelliniMMSucc]);
    Exit;
  end;
  // controlli ok
  Err:='';
  Result:=True;
end;

procedure TW009FStampaCartellino.FiltroSelAnagrafeW(DataSet: TDataSet; var Accept: Boolean);
begin
  // PRE
  //   ElencoMatricoleFiltro <> ''
  Accept:=R180InConcat(DataSet.FieldByName('MATRICOLA').AsString,ElencoMatricoleFiltro);
end;

procedure TW009FStampaCartellino.EseguiCartellini;
var
  A,M,G,A2,M2,G2: Word;
  S,SQLText,Mat,MsgErr: String;
begin
  Log('Traccia','EseguiCartellini: inizio');
  // inizializzazione variabili
  S:='';
  Mat:='';
  SQLText:='';
  selAnagrafeW.Tag:=0;
  selAnagrafeW.Filtered:=False;
  selAnagrafeW.OnFilterRecord:=nil;
  W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(Self);
  try //except
    try  //finally
      Log('Traccia','Datamodulo W009dtm creato');
      if ElencoMatricoleFiltro <> '' then
      begin
        selAnagrafeW.Tag:=selAnagrafeW.RecordCount;
        selAnagrafeW.OnFilterRecord:=FiltroSelAnagrafeW;
        selAnagrafeW.Filtered:=True;
      end;
      W009FStampaCartellinoDtm.selAnagrafeW:=selAnagrafeW;
      W009FStampaCartellinoDtm.CartelliniChiusi:=Parametri.WEBCartelliniChiusi = 'S';
      W009FStampaCartellinoDtm.Stampa:=Modo = 'S';
      W009FStampaCartellinoDtm.RegLog:=True;
      W009FStampaCartellinoDtm.RaveProjectFile:=gSC.ContentPath + 'report\' + RAVE_MODEL_CARTELLINO;
      W009FStampaCartellinoDtm.NomeFile:=GetNomeFile('pdf');
      W009FStampaCartellinoDtm.RaveOutputFileName:=W009FStampaCartellinoDtm.NomeFile;
      MsgErr:='';
      SQLText:=selAnagrafeW.SQL.Text;
      CodiceT950:=Trim(Copy(cmbParametrizzazione.Text,1,5));
      DecodeDate(DataI,A,M,G);
      DecodeDate(DataF,A2,M2,G2);
      //Se le date differiscono di mese o di anno, allora i giorni vanno
      //da 1 all'ultimo del mese
      if (M <> M2) or (A <> A2) then
      begin
        G:=1;
        G2:=R180GiorniMese(DataF);
        DataI:=EncodeDate(A,M,G);
        DataF:=EncodeDate(A2,M2,G2);
        edtDal.Text:=DateToStr(DataI);
        edtAl.Text:=DateToStr(DataF);
      end;
      W009FStampaCartellinoDtm.DataF:=DataF;
      // creazione datamodulo conteggi
      try
        W009FStampaCartellinoDtm.CreazioneR400(Self);
        Log('Traccia','R400 creato');
      except
        on E: Exception do
        begin
          Log('Errore','R400 non creato',E);
          raise;
        end;
      end;
      // aggiornamento dei buoni pasto
      if chkAggiornamentoBuoniPasto.Checked then
      begin
        try
          W009FStampaCartellinoDtM.CreazioneR350;
          Log('Traccia','R350 creato');
        except
          on E: Exception do
          begin
            Log('Errore','R350 non creato',E);
            raise;
          end;
        end;
      end;
      if chkAggiornamentoAccessiMensa.Checked then
      begin
        try
          W009FStampaCartellinoDtM.CreazioneR300(DataI,DataF);
          Log('Traccia','R300 creato');
        except
          on E: Exception do
          begin
            Log('Errore','R300 non creato',E);
            raise;
          end;
        end;
      end;
      if chkInserimentoRiposi.Checked then
      begin
        try
          W009FStampaCartellinoDtM.CreazioneA041(DataI,DataF);
          Log('Traccia','A041MW creato');
        except
          on E: Exception do
          begin
            Log('Errore','A041MW non creato',E);
            raise;
          end;
        end;
      end;
      with W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int do
      begin
        Close;
        SetVariable('Codice',CodiceT950);
        Open;
      end;
      if (Modo = 'S') and (WR000DM.TipoUtente = 'Dipendente') then
      begin
        if TuttiDipSelezionato then
          selAnagrafeW.First
        else
        begin
          if Self.Tag = 405 then
            Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex]
          else
            Mat:=cdsT860.FieldByName('MATRICOLA').AsString;
          selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]);
        end;
        S:=W009FStampaCartellinoDtM.R400FCartellinoDtM.CheckValidazione2Parametrizzazione(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,DataI,DataF);
        if S <> '' then
        begin
          raise Exception.Create(S);
        end;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=Modo = 'A'; //Sender = btnAggiornamento;
      if Modo = 'V' then
        W009FStampaCartellinoDtM.R400FCartellinoDtM.AnomalieBloccantiExtra:=Parametri.CampiRiferimento.C90_W009AnomBloccanti;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.IgnoraAnomalie:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=chkAggiornamentoScheda.Checked;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');
      selAnagrafeW.SetVariable('DATALAVORO',DataF);
      selAnagrafeW.Close;
      if (Modo = 'S') and (Pos(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione,SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',SelAnagrafeW.SQL.Text) = 0)) and
         (Trim(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione) <> '') then
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
      if Modo = 'S' then //Sender = btnStampa then
      begin
        Log('Traccia','Impostazione stampa');
        lst:=TStringList.Create;
        with W009FStampaCartellinoDtM.R400FCartellinoDtM do
        try
          SetLength(VetDatiLiberiSQL,0);
          R180SetVariable(selT951,'Codice',Q950Int.FieldByName('CODICE').AsString);
          selT951.Open;
          selT951.First;
          while not selT951.Eof do
          begin
            lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
            selT951.Next;
          end;
          selT951.Close;
          W009FStampaCartellinoDtM.GetLabels(lst,'Riepilogo2001',nil);
          //Devo già avere l'elenco dei dati liberi 2001
          CreaClientDataSet(selAnagrafeW);
        finally
          lst.Free;
        end;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=selAnagrafeW;
      // Gestione Stampa singola o per tutti i dipendenti
      if (Tag = 405) and TuttiDipSelezionato then
      begin
        selAnagrafeW.First;
        while not selAnagrafeW.Eof do
        begin
          Log('Traccia','Calcolo cartellini matr. ' + selAnagrafeW.FieldByName('MATRICOLA').AsString + ', dal ' + DateToStr(DataI) + ' al ' + DateToStr(DataF) + ', param. ' + CodiceT950);
          MsgErr:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2);
          selAnagrafeW.Next;
        end;
      end
      else
      begin
        //Posizionamento sulla matricola correntemente selezionata
        if Tag = 405 then
        begin
          // 12.2.6
          Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
        end
        else
          Mat:=cdsT860.FieldByName('MATRICOLA').AsString;
        if selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
        begin
          Log('Traccia','Calcolo cartellini matr. ' + selAnagrafeW.FieldByName('MATRICOLA').AsString + ', dal ' + DateToStr(DataI) + ' al ' + DateToStr(DataF) + ', param. ' + CodiceT950);
          MsgErr:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2);
          //AnomalieBloccanti:=W009FStampaCartellinoDtM.R400FCartellinoDtM.AnomaliaBloccante;
          AnomalieBloccanti:=W009FStampaCartellinoDtM.R400FCartellinoDtM.EsisteAnomBloccante;
          AnomalieBloccantiDesc:=W009FStampaCartellinoDtM.R400FCartellinoDtM.lstAnomalie.Text;
        end
        else
        begin
          if Tag = 405 then
          begin
            GetDipendentiDisponibili(DataF);
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_ANAGRA_NON_DISPONIBILE));
            Abort;
          end
          else
          begin  //se sono in validazione cartellino, ritorno sulla data lavoro e riseleziono il dipendente
            GetDipendentiDisponibili(Parametri.DataLavoro);
            cmbDipendentiDisponibili.ItemIndex:=R180IndexOf(cmbDipendentiDisponibili.Items,Mat,8);
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_ANAGRA_NON_DISPONIBILE));
          end;
        end;
      end;
      if MsgErr <> '' then
        MsgBox.MessageBox(MsgErr,ERRORE);
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      Log('Traccia','Aggiornamento: R400 Chiusura query completata');
      //Chiudo subito le query e le unit dei conteggi, salvo Q950Int e selT004 che serve in stampa
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Open;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selT004.Open;
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
      Log('Traccia','Aggiornamento: R450 Chiusura query completata');
      FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
      FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R600DtM1);
      // se richiesto produce l'anteprima pdf
      if (Modo = 'S') and ((W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0) or (MsgErr = '')) then
      begin
        EseguiStampa;
        if Parametri.AccessibilitaNonVedenti = 'S' then
        begin
          //Cartellino per non vedenti su pagina html
          grdCartellinoAnagrafico.medpAttivaGrid(W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsAnagrafico,False,False,False);
          grdCartellinoRiepilogo.medpAttivaGrid(W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo,False,False,False);
          grdCartellinoDettaglio.medpAttivaGrid(W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsDettaglio,False,False,False);
          grdCartellinoPresenze.medpAttivaGrid(W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsPresenze,False,False,False);
          grdCartellinoAssenze.medpAttivaGrid(W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsAssenze,False,False,False);
          grdCartellinoAnagrafico.Visible:=True;
          grdCartellinoRiepilogo.Visible:=True;
          grdCartellinoDettaglio.Visible:=True;
          grdCartellinoPresenze.Visible:=W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsPresenze.RecordCount > 0;
          grdCartellinoAssenze.Visible:=W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsAssenze.RecordCount > 0;
        end;
      end;
    finally
      Log('Traccia','EseguiCartellini: chiusura stampa cartellini');
      // distruzione R400
      W009FStampaCartellinoDtm.DistruzioneR400;
      // riapre selezione anagrafica
      selAnagrafeW.Tag:=0;
      selAnagrafeW.Filtered:=False;
      selAnagrafeW.OnFilterRecord:=nil;
      selAnagrafeW.CloseAll;
      selAnagrafeW.SQL.Text:=SQLText;
      selAnagrafeW.Open;
      // riposizionamento sulla matricola correntemente selezionata
      if Tag = 405 then
      begin
        // 12.2.6
        //Mat:=Trim(Copy(cmbDipendentiDisponibili.Text,1,8))
        Mat:=cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex];
      end
      else
        Mat:=cdsT860.FieldByName('MATRICOLA').AsString;
      if not selAnagrafeW.SearchRecord('MATRICOLA',Mat,[srFromBeginning]) then
        selAnagrafeW.First;
      try W009FStampaCartellinoDtM.DistruggiLstRaveComp; except end;
      FreeAndNil(W009FStampaCartellinoDtm);
      Log('Traccia','EseguiCartellini: fine');
    end;
  except
    on E:Exception do
    begin
      Log('Errore','EseguiCartellini',E);
      if Modo = 'V' then
      begin
        AnomalieBloccanti:=True;
        AnomalieBloccantiDesc:=E.Message;
      end
      else
        MsgBox.MessageBox(Format(A000TraduzioneStringhe(A000MSG_W009_ERR_FMT_STAMPA_CARTELLINO),[E.Message]),ERRORE);
    end;
  end;
end;

procedure TW009FStampaCartellino.AvvisoValidazione;
var
  Err,ElencoRich: String;
begin
  if (Tag <> 405) and (Modo = 'S') then
  begin
    // avvisa se ci sono anomalie bloccanti
    if AnomalieBloccanti then
    begin
      Err:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_ANOM_VALIDAZIONE),[FormatDateTime('mmmm yyyy',DataI),AnomalieBloccantiDesc]);
      GGetWebApplicationThreadVar.ShowMessage(Err);
      Exit;
    end;

    // verifica se ci sono richieste pendenti da segnalare
    ElencoRich:='';
    if GetRichiestePendenti(ElencoRich) > 0 then
    begin
      Err:=Format(A000TraduzioneStringhe(A000MSG_W009_FMT_RICH_PENDENTI),[FormatDateTime('mmmm yyyy',DataI),ElencoRich]);
      GGetWebApplicationThreadVar.ShowMessage(Err);
      Exit;
    end;
  end;
end;

procedure TW009FStampaCartellino.EseguiStampa;
// effettua l'anteprima pdf del cartellino a conteggi avvenuti
var
  S: String;
begin
  try
    if W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
    begin
      if Pos(INI_PAR_NO_STAMPACARTELLINO,W000ParConfig.ParametriAvanzati) = 0 then
      begin
        W009FStampaCartellinoDtM.W009CSStampa:=CSStampa;
        Log('Traccia','EseguiCartellini: inizio stampa');
        S:=W009FStampaCartellinoDtM.EsecuzioneStampa;
        if S <> '' then
          raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W009_FMT_FILE_PDF_FALLITO),[S]));
        Log('Traccia','EseguiCartellini: fine stampa');
        // visualizza pdf
        if (Parametri.AccessibilitaNonVedenti <> 'S') and (Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0) then
        begin
          Log('Traccia','EseguiCartellini: Apertura file pdf ''/Files/W009/' + W009FStampaCartellinoDtm.NomeFile + '''');
          VisualizzaFile(W009FStampaCartellinoDtm.NomeFile, Format(A000TraduzioneStringhe(A000MSG_W009_FMT_TITOLO_ANTEPRIMA),[Copy(cmbParametrizzazione.Text,7,MAXINT)]),AvvisoValidazione,nil);
        end;
      end;
    end
    else
      MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_NO_CART_DISPONIBILI),INFORMA);
  except
    on E:Exception do
    begin
      MsgBox.MessageBox(E.Message,ESCLAMA);
      Log('Errore','Errore in fase di stampa',E);
    end;
  end;
end;

procedure TW009FStampaCartellino.BloccoRiepiloghi(const PBlocca: Boolean; const PDataRiep: TDateTime);
// effettua il blocco / sblocco dei riepiloghi per il dipendente e il mese indicati
// PBlocca:   true per bloccare, False per sbloccare
// PDataRiep: data del mese da bloccare / sbloccare
var
  i: Integer;
  Riep: String;
  OQ: TOracleQuery;
  function ConsideraRiepilogo(const S: String): Boolean;
  begin
    //riepiloghi da NON considerare:
    Result:=(Riep = 'T077') or
            (Riep = 'T071A') or
            (Riep = 'T071S') or
            (Riep = 'T074') or
            (Riep = 'T130') or
            (Riep = 'T131') or
            (Riep = 'T134') or
            (Riep = 'T264') or
            (Riep = 'T692') or
            (Riep = 'T762') or
            (Riep = 'T820') or
            (Riep = 'T825') or
            (Riep = 'T860') or
            (Riep = 'M040');
    Result:=not Result;
  end;
begin
  if PBlocca then
    OQ:=W009DM.scrBloccaRiep
  else
    OQ:=W009DM.scrSbloccaRiep;
  with OQ do
  begin
    SetVariable('PROGRESSIVO',medpProgressivo);
    SetVariable('DAL',PDataRiep);
    SetVariable('AL',PDataRiep);

    // blocco dei riepiloghi
    for i:=0 to High(lstRiepiloghi) do
    begin
      Riep:=Trim(Copy(lstRiepiloghi[i],1,5));
      if ConsideraRiepilogo(Riep) then
      begin
        SetVariable('RIEPILOGO',Riep);
        Execute;
      end;
    end;
    // commit immediatamente dopo il richiamo a questa procedura
  end;
end;

procedure TW009FStampaCartellino.btnAggiornamentoClick(Sender: TObject);
var
  Err: String;
  WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  // determina modalità
  if Sender = btnAggiornamento then
    Modo:='A'  // A = aggiornamento
  else if Sender = btnStampa then
    Modo:='S'  // S = stampa
  else
    Modo:='V'; // V = validazione

  // effettua controlli bloccanti
  if not ControlliOk(Err) then
  begin
    MsgBox.MessageBox(Err,INFORMA);
    Exit;
  end;

  if (Sender = btnStampa) then
      SelectedSenderName:=btnStampa.HTMLName
  else if (Sender = btnAggiornamento) then
      SelectedSenderName:=btnAggiornamento.HTMLName;

  if (not ForzaPeriodo) and (DataF > R180FineMese(Now)) then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self.Parent);
    WC020FInputDataOreFM.ImpostaCampiData(A000MSG_A027_ERR_CONFERMA_PERIODO,Now,'dd/mm/yyyy');
    WC020FInputDataOreFM.ResultEvent:=ResultWC020;
    WC020FInputDataOreFM.Visualizza(A000MSG_A027_ERR_CONFERMA_PERIODO_TITOLO);
    Exit;
  end
  else
    ForzaPeriodo:=False;

  // effettua l'operazione richiesta per i cartellini
  A000SessioneWEB.AnnullaTimeOut;
  try
    if (Parametri.CampiRiferimento.C90_W009_WA027_UsaB028 = 'S') and (Modo = 'S') then
      EseguiStampaViaB028
    else
      EseguiCartellini;
  finally
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TW009FStampaCartellino.ResultWC020(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    if edtAl.Text = Valore then
    begin
      ForzaPeriodo:=True;
      if SelectedSenderName = btnStampa.HTMLName then
        btnAggiornamentoClick(btnStampa)
      else if SelectedSenderName = btnAggiornamento.HTMLName then
        btnAggiornamentoClick(btnAggiornamento);
    end
    else
    begin
      MsgBox.WebMessageDlg(A000MSG_A027_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
      Exit;
    end;
  end;
end;

procedure TW009FStampaCartellino.EseguiStampaViaB028;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  try
    //Chiamo Servizio COM B028 per creare il pdf su server
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=CreateJsonString;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection1.Connected then
      DCOMConnection1.Connected:=True;
    try
      DCOMConnection1.AppServer.PrintA027(CreateSQLSelezioneAnagrafica,
                                          DCOMNomeFile,
                                          Parametri.Operatore,
                                          Parametri.Azienda,
                                          WR000DM.selAnagrafe.Session.LogonDataBase,
                                          DatiUtente,
                                          DettaglioLog);
    finally
      DCOMConnection1.Connected:=False;
    end;
    if FileExists(DCOMNomeFile) then
      VisualizzaFile(DCOMNomeFile,DCOMNomeFile,nil,nil)
    else
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W009_ERR_NO_FILE_PDF));
  except
    on E:Exception do
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W009_ERR_FMT_STAMPA_CARTELLINO_B028),[E.message]));
  end;
end;

function TW009FStampaCartellino.CreateJsonString:String;
var
  JSONObject:TJSONObject;
begin
  JSONObject:=TJSONObject.Create;
  try
    JSONObject.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    JSONObject.AddPair('NomeStampa',Trim(Copy(cmbParametrizzazione.Text,1,5)));
    C190Comp2JsonString(edtDal,JSONObject,'EDaData');
    C190Comp2JsonString(edtAl,JSONObject,'EAData');
    C190Comp2JsonString(chkAutoGiustificazione,JSONObject,'chkAutoGiustificazione');
    C190Comp2JsonString(chkAggiornamentoScheda,JSONObject,'CAggiornamento');
    C190Comp2JsonString(chkAggiornamentoAccessiMensa,JSONObject,'chkAccessiMensa');
    C190Comp2JsonString(chkAggiornamentoBuoniPasto,JSONObject,'chkBuoniPasto');
    C190Comp2JsonString(chkInserimentoRiposi,JSONObject,'chkInserimentoRiposi');
    Result:=JSONObject.ToString;
  finally
    JSONObject.Free;
  end;
end;

function TW009FStampaCartellino.CreateSQLSelezioneAnagrafica:String;
var
  Condizione:String;
  ListaMatricoleSel:TStringList;
  i,OrderBy:Integer;
begin
  //selAnagrafeW.Tag:=0;
  selAnagrafeW.Filtered:=False;
  selAnagrafeW.OnFilterRecord:=nil;

  ListaMatricoleSel:=TStringList.Create;
  try
    if TuttiDipSelezionato then
    begin
      if ElencoMatricoleFiltro <> '' then
      begin
        //selAnagrafeW.Tag:=selAnagrafeW.RecordCount;
        selAnagrafeW.OnFilterRecord:=FiltroSelAnagrafeW;
        selAnagrafeW.Filtered:=True;
        selAnagrafeW.First;
        while not selAnagrafeW.Eof do
        begin
          ListaMatricoleSel.Add(selAnagrafeW.FieldByName('MATRICOLA').AsString);
          selAnagrafeW.Next;
        end;
      end
      else
      begin
        Result:=selAnagrafeW.SubstitutedSQL;
        Exit;
      end;
    end
    else
    begin
      ListaMatricoleSel.Add(cmbDipendentiDisponibili.Items.ValueFromIndex[cmbDipendentiDisponibili.ItemIndex]);
    end;

    if ListaMatricoleSel.Count > 0 then
    begin
      Result:=selAnagrafeW.SubstitutedSQL;
      Condizione:=' and T030.MATRICOLA in (';
      for i:=0 to ListaMatricoleSel.Count - 1 do
      begin
        if i > 0 then
          Condizione:=Condizione + ',';
        Condizione:=Condizione + '''' + ListaMatricoleSel[i] + '''';
      end;
      Condizione:=Condizione + ') ';

      OrderBy:=Pos('ORDER BY',UpperCase(Result));
      if OrderBy = 0 then
        Result:=Result + Condizione
      else
        Insert(Condizione,Result,OrderBy);
    end;
  finally
    //selAnagrafeW.Tag:=0;
    selAnagrafeW.Filtered:=False;
    selAnagrafeW.OnFilterRecord:=nil;
  end;
end;

procedure TW009FStampaCartellino.DistruggiOggetti;
begin
  try FreeAndNil(W009DM); except end;
  inherited;
end;

end.
