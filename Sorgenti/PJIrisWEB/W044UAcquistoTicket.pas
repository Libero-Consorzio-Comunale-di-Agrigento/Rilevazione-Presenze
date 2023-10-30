unit W044UAcquistoTicket;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  FunzioniGenerali,
  R012UWebAnagrafico,
  W000UMessaggi,
  W044UAcquistoTicketDM,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, IWCompButton, meIWButton, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWDBGrids, medpIWDBGrid, OracleData, System.Math, System.Variants,
  meIWImageFile, Vcl.Menus;

type
  TW044FAcquistoTicket = class(TR012FWebAnagrafico)
    grdAcquistoTicket: TmedpIWDBGrid;
    pmnTabella: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    mnuEsportaCsv: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdAcquistoTicketRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdAcquistoTicketAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdAcquistoTicketModifica(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure mnuEsportaCsvClick(Sender: TObject);
  private
    FW044DM: TW044FAcquistoTicketDM;
    FIsDateInRangeConsentito: Boolean;
    FNumRecordMeseSucc: Integer;
  protected
    procedure VisualizzaDipendenteCorrente; override;
  public
    function InizializzaAccesso:Boolean; override;
    procedure OnAfterInserimento;
  end;

const
  W044_MESI_PREGRESSI = 12;

implementation

uses
  IWApplication;

{$R *.dfm}

{ TW044FAcquistoTicket }

function TW044FAcquistoTicket.InizializzaAccesso: Boolean;
var
  LMeseSuccIni: TDateTime;
  LMeseSuccFine: TDateTime;
begin
  Result:=False;

  // controlla definizione parametro per regole buoni / ticket
  if Parametri.CampiRiferimento.C4_BuoniMensa = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W044_ERR_FMT_NO_PARAM_REGOLE_BUONI),[medpNomeFunzione]));
    Exit;
  end;

  // estrae i dipendenti disponibili nel mese successivo (effettua selezione periodica per l'intero mese)
  LMeseSuccIni:=Date.StartOfMonth.AddMonths(1);
  LMeseSuccFine:=LMeseSuccIni.EndOfMonth.Date;
  GetDipendentiDisponibili(LMeseSuccIni,LMeseSuccFine);

  // seleziona il progressivo dell'utente che ha eseguito l'accesso
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // visualizza i dati di acquisto ticket / buoni pasto del progressivo
  VisualizzaDipendenteCorrente;

  Result:=True;
end;

procedure TW044FAcquistoTicket.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  // inizializzazioni
  FIsDateInRangeConsentito:=False;
  FNumRecordMeseSucc:=0;
  FW044DM:=TW044FAcquistoTicketDM.Create(Self);

  // imposta la variabile mesi pregressi in fase iniziale (dato invariante)
  FW044DM.selT690.SetVariable('MESI_PREGRESSI',W044_MESI_PREGRESSI);
  
  // imposta alcune proprietà della grid
  grdAcquistoTicket.medpPaginazione:=False;
  grdAcquistoTicket.medpTestoNoRecord:='Nessun dato di acquisto ticket';
  grdAcquistoTicket.medpRowSelect:=False;
end;

procedure TW044FAcquistoTicket.mnuEsportaCsvClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdAcquistoTicket.ToCsv
  else
    InviaFile('ElencoAcquistiTicket.xls',csvDownload);
end;

procedure TW044FAcquistoTicket.mnuEsportaExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdAcquistoTicket.ToXlsx
  else
    InviaFile('ElencoAcquistiTicket.xlsx',streamDownload);
end;

procedure TW044FAcquistoTicket.VisualizzaDipendenteCorrente;
var
  LResCtrl: TResCtrl;
  LAbilIns: Boolean;
  LAbilEdit: Boolean;
  LDataAcquistoTicket: TDateTime;
  LMeseSuccIni: TDateTime;
begin
  inherited;

  // salva il progressivo corrente
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // nasconde la grid (in caso di errori rimarrà nascosta)
  grdAcquistoTicket.Visible:=False;

  // estrae il codice regola ticket da applicare associato al progressivo
  LResCtrl:=FW044DM.LeggiRegolaTicket(ParametriForm.Progressivo);
  if not LResCtrl.Ok then
    raise Exception.Create(LResCtrl.Messaggio);

  // verifica l'accesso alla funzione
  LResCtrl:=FW044DM.RegolaTicket.ControllaAccessoFunzione(ParametriForm.Progressivo,LDataAcquistoTicket);
  if not LResCtrl.Ok then
    raise Exception.Create(LResCtrl.Messaggio);

  // determina il primo giorno del mese successivo
  LMeseSuccIni:=Date.StartOfMonth.AddMonths(1);

  // verifica che la data corrente rientri nel range di modifica consentita
  FIsDateInRangeConsentito:=FW044DM.RegolaTicket.IsDateInRangeConsentito;

  // se la funzione è in scrittura e la data non è nel periodo consentito dà una notifica al dipendente
  if (not SolaLettura) and (not FIsDateInRangeConsentito) then
  begin
    Notifica('Attenzione',Format(A000MSG_W044_ERR_FMT_FUORI_PERIODO_INS,[FW044DM.RegolaTicket.GetDescPastoTicket]),'../img/calendar.png',False,True,5000);
  end;

  // imposta alcuni dati del record di acquisto ticket
  // 1. progressivo
  FW044DM.ProgressivoIns:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  // 2. data di inserimento acquisto
  //    prima data del mese successivo in cui è disponibile l'accesso alla funzione (da regola ticket)
  FW044DM.DataIns:=Max(LMeseSuccIni,LDataAcquistoTicket);

  // estrae i dati di acquisto dei ticket nei [W044_MESI_PREGRESSI] mesi pregressi
  R180SetVariable(FW044DM.selT690,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  FW044DM.selT690.Open;

  // verifica se è già presente un acquisto per il mese successivo:
  //   nel caso l'abilitazione all'inserimento non sarà attiva
  FNumRecordMeseSucc:=0;
  FW044DM.selT690.Last;
  while not FW044DM.selT690.Bof do
  begin
    // verifica la presenza di un acquisto per il mese successivo
    if FW044DM.selT690.FieldByName('DATA').AsDateTime.StartOfMonth = LMeseSuccIni then
      FNumRecordMeseSucc:=FNumRecordMeseSucc + 1;

    FW044DM.selT690.Prior;
  end;

  // imposta possibilità di edit griglia
  LAbilEdit:=(not SolaLettura) and
             (FIsDateInRangeConsentito);

  // imposta abilitazione all'inserimento di un nuovo record
  LAbilIns:=(not SolaLettura) and
            (FIsDateInRangeConsentito) and
            (FNumRecordMeseSucc = 0);

  // attiva e visualizza grid
  grdAcquistoTicket.medpAttivaGrid(FW044DM.selT690,LAbilEdit,LAbilIns,False);
  grdAcquistoTicket.Visible:=True;
end;

procedure TW044FAcquistoTicket.grdAcquistoTicketAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  LData: TDateTime;
  LAbil: Boolean;
  LIWG: TmeIWGrid;
  LEsisteRecordDataAcquisto: Boolean;
begin
  inherited;

  // verifica se esiste già un record con data = data acquisto calcolata
  LEsisteRecordDataAcquisto:=not VarIsNull(FW044DM.selT690.Lookup('DATA',FW044DM.DataIns,'DATA'));

  for i:=IfThen(grdAcquistoTicket.medpComandiInsert,1,0) to High(grdAcquistoTicket.medpCompGriglia) do
  begin
    LData:=StrToDate(grdAcquistoTicket.medpValoreColonna(i,'DATA'));

    // la modifica del record è consentita se e solo se:
    // - la funzione è in scrittura
    // - la data corrente è nel range di periodo consentito dalla regola
    // - la data di acquisto rientra nel mese successivo al corrente
    LAbil:=(not SolaLettura) and
           (FIsDateInRangeConsentito) and
           (LData.StartOfMonth = Date.StartOfMonth.AddMonths(1));

    // IMPORTANTE
    //   potrebbe verificarsi la situazione in cui la data di acquisto viene modificata automaticamente
    //   (es. abilitazione accesso alla funzione a metà mese)
    //   nel caso in cui siano già presenti N>1 record di acquisto nel mese successivo,
    //   ed esista già un record con data = data acquisto calcolata,
    //   solo quest'ultimo viene abilitato alla modifica
    //   per prevenire errori di duplicazione di chiave indesiderati (e non facilmente evitabili dall'utente)
    if (FNumRecordMeseSucc > 1) and (LEsisteRecordDataAcquisto) then
      LAbil:=LAbil and (LData = FW044DM.DataIns);

    // se la gestione non è abilitata nasconde l'icona di modifica
    if not LAbil then
    begin
      LIWG:=(grdAcquistoTicket.medpCompGriglia[i].CompColonne[0] as TmeIWGrid);
      if LIWG <> nil then
        LIWG.Cell[0,0].Css:='invisibile';
    end;
  end;
end;

procedure TW044FAcquistoTicket.grdAcquistoTicketModifica(Sender: TObject);
begin
  // forza allineamento client dataset a seguito di possibile modifica del record
  // nell'evento OnBeforeEdit del dataset selT690)
  grdAcquistoTicket.medpAllineaRecordCDS;
end;

procedure TW044FAcquistoTicket.grdAcquistoTicketRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna: Integer;
  LNomeCampo: String;
begin
  if not grdAcquistoTicket.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  LNumColonna:=grdAcquistoTicket.medpNumColonna(AColumn);
  LNomeCampo:=grdAcquistoTicket.medpColonna(LNumColonna).DataField.ToUpper;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdAcquistoTicket.medpCompGriglia)) and (grdAcquistoTicket.medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Control:=grdAcquistoTicket.medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
    ACell.Text:='';
  end;
end;

procedure TW044FAcquistoTicket.OnAfterInserimento;
// metodo richiamato dopo la conferma di inserimento del mese successivo
begin
  // dopo l'inserimento del record per il mese successivo disabilita la gestione dell'inserimento da grid
  grdAcquistoTicket.medpAttivaGrid(FW044DM.selT690,not SolaLettura,False,False);
end;

end.
