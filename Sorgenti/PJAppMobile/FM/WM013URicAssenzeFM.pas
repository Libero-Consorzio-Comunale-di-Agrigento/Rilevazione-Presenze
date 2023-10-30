unit WM013URicAssenzeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR003UGestRichiesteFM,
  MedpUnimPanel2Button, MedpUnimPanelListaDisclosure,
  MedpUnimPanelListaDettaglio, MedpUnimPanelHeaderDett, MedpUnimPanelListaElem,
  MedpUnimPanelNumElem, MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel,
  uniPageControl, unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, unimPanel, MedpUnimPanelBase, WR004UCompetenzeMW, MedpUnimPanel4Labels,
  MedpUnimPanelDisclosure, WM000UMainModule, A000UCostanti, A000UInterfaccia, MedpUnimTypes, WM013URicAssenzeMW,
  MedpUnimPanelNota, MedpUnimPanelOraDaA, uniMultiItem, unimSelect, MedpUnimLabelIcon, MedpUnimPanel4LabelsIcon,
  MedpUnimSelect, uniLabel, unimLabel, MedpUnimLabel, MedpUnimMemo, Generics.Collections, System.StrUtils,
  uniFileUpload, unimFileUpload, MedpUnimPanel2Labels, uniCheckBox, unimCheckBox, WR006UAllegatiMW,
  uniEdit, unimEdit, MedpUnimEdit, uniButton, uniBitBtn, unimBitBtn,
  MedpUnimButton;

type
  TWM013FRicAssenzeFM = class(TWR003FGestRichiesteFM)
    tabCompetenze: TUnimTabSheet;
    pnlHeaderCompetenze: TMedpUnimPanelHeaderDett;
    pnlListaCompetenze: TMedpUnimPanelListaDettaglio;
    lblMotivazione: TMedpUnimLabel;
    cmbMotivazione: TMedpUnimSelect;
    pnlOraDaANew: TMedpUnimPanelOraDaA;
    pnlDataDaANew: TMedpUnimPanelDataDaA;
    lblNote: TMedpUnimLabel;
    cmbNote: TMedpUnimSelect;
    lblTipoFruizione: TMedpUnimLabel;
    cmbTipoFruizione: TMedpUnimSelect;
    cmbFamiliare: TMedpUnimSelect;
    lblFamiliare: TMedpUnimLabel;
    cmbCausale: TMedpUnimSelect;
    lblCausale: TMedpUnimLabel;
    cmbAccorpCausali: TMedpUnimSelect;
    lblAccorpCausali: TMedpUnimLabel;
    lblPeriodo: TMedpUnimLabel;
    memNoteRichiesta: TMedpUnimMemo;
    lblNoteRichiesta: TMedpUnimLabel;
    procedure UniFrameCreate(Sender: TObject); override;
    procedure OnDisclCompetenzeClick(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure pnlHeaderCompetenzelblBackClick(Sender: TObject);
    procedure OnNuovaRichiestaClick(Sender: TObject); override;
    procedure edtDataAChange(Sender: TObject);
    procedure edtDataDaChange(Sender: TObject);
    procedure cmbAccorpCausaliChange(Sender: TObject);
    procedure cmbCausaleChange(Sender: TObject);
    procedure cmbTipoFruizioneChange(Sender: TObject);
  private
    WR004CompetenzeMW: TWR004FCompetenzeMW;
    WM013RicAssenzeMW: TWM013FRicAssenzeMW;

    procedure ClearRichiesta;
    procedure PopolaAccorpCausali;
    procedure PopolaCausali;
    procedure PopolaFamiliari(var PGestioneFam: Boolean);
    procedure PopolaNote;
    procedure PopolaMotivazioni;
    procedure PopolaTipiFruizione;
  const
    FRUIZ_I              = 'I';
    FRUIZ_M              = 'M';
    FRUIZ_N              = 'N';
    FRUIZ_D              = 'D';

    FRUIZ_I_TEXT         = 'Giornata';
    FRUIZ_M_TEXT         = 'Mezza giornata';
    FRUIZ_N_TEXT         = 'Numero ore';
    FRUIZ_D_TEXT         = 'Da ore / a ore';
  protected
    function CreaLabelsRichiesta: TMedpUnimPanelBase; override;

    procedure AggiornaHeaderDettaglio; override;
    function AggiornaListaDettaglio: TResCtrl; override;

    procedure AggiornaHeaderCompetenze;
    function AggiornaListaCompetenze: TResCtrl;

    function ControllaEliminaRichiesta: TResCtrl; override;
    procedure EliminaRichiesta; override;

    function ControllaRevocaRichiesta: TResCtrl; override;
    procedure RevocaRichiesta; override;

    function ControllaOkRichiesta: TResCtrl; override;
    procedure OkRichiesta; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM013FRicAssenzeFM.UniFrameCreate(Sender: TObject);
begin
  WR002RichiesteMW:=TWM013FRicAssenzeMW.Create;
  WM013RicAssenzeMW:=WR002RichiesteMW as TWM013FRicAssenzeMW;

  WR004CompetenzeMW:=TWR004FCompetenzeMW.Create;

  pnlDataDaANew.DataDa.Date:=0;
  pnlDataDaANew.DataA.Date:=0;
  pnlOraDaANew.OraDa.Time:=0;
  pnlOraDaANew.OraA.Time:=0;

  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  FAutorizzatore:=False;
  inherited;
end;

procedure TWM013FRicAssenzeFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WR004CompetenzeMW);
  WM013RicAssenzeMW:=nil;
  inherited;
  SessioneOracle.LogOff;
end;

procedure TWM013FRicAssenzeFM.ClearRichiesta;
// pulisce i dati della richiesta e l'interfaccia
begin
  // pulisce dati richiesta
  WM013RicAssenzeMW.DatiGiustificativo.Clear;

  // prepara interfaccia iniziale
  lblAccorpCausali.Visible:=False;
  cmbAccorpCausali.Visible:=False;
  cmbAccorpCausali.ItemIndex:=-1;

  lblCausale.Visible:=False;
  cmbCausale.Visible:=False;
  cmbCausale.ItemIndex:=-1;

  lblFamiliare.Visible:=False;
  cmbFamiliare.Visible:=False;
  cmbFamiliare.ItemIndex:=-1;

  lblTipoFruizione.Visible:=False;
  cmbTipoFruizione.Visible:=False;
  cmbTipoFruizione.ItemIndex:=-1;

  lblNote.Visible:=False;
  cmbNote.Visible:=False;
  cmbNote.Text:='';

  lblPeriodo.Visible:=False;
  pnlDataDaANew.Visible:=False;
  pnlOraDaANew.Visible:=False;

  pnlDataDaANew.DataDa.Date:=0;

  pnlDataDaANew.DataA.Date:=0;

  pnlOraDaANew.OraDa.Time:=0;
  pnlOraDaANew.OraA.Time:=0;

  // note
  memNoteRichiesta.Memo.Text:='';

  // motivazione
  cmbMotivazione.ItemIndex:=-1;
end;

procedure TWM013FRicAssenzeFM.OnNuovaRichiestaClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;
  // pulisce dati richiesta e interfaccia nuova richiesta
  ClearRichiesta;

  with WM000FMainModule do
    LResCtrl:=WM013RicAssenzeMW.AggiornaDatiNuovaRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if LResCtrl.Ok then
  begin
    // popola le note per mezza giornata se richiesto
    if WM000FMainModule.InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
      PopolaNote;

    // combobox accorpamenti
    PopolaAccorpCausali;

    if cmbAccorpCausali.Items.Count > 0 then
      cmbAccorpCausali.ItemIndex:=0;

    if cmbAccorpCausali.Items.Count > 1 then
    begin
      lblAccorpCausali.Visible:=True;
      cmbAccorpCausali.Visible:=True;
    end;

    cmbAccorpCausaliChange(cmbAccorpCausali);

    tpnlRichieste.ActivePage:=tabNuovaRichiesta;
  end
  else
    ShowMessage(LResCtrl.Messaggio);
end;

function TWM013FRicAssenzeFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
var LPanel: TMedpUnimPanel4LabelsIcon;
    LCondizioneAllegati: String;
    LNumAllegati: Integer;
begin
  LPanel:=TMedpUnimPanel4LabelsIcon.Create(Self);

  with LPanel do
  begin
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='100%';
    Labels.Label1.LayoutConfig.Width:='100%';
    Labels.Label1.Caption:=WM013RicAssenzeMW.Causale;
    Labels.Label1.Constraints.MinHeight:=20;
    Labels.Label1.JustifyContent:=JustifyStart;
    Labels.Label1.Font.Style:=[fsBold];
    Labels.Label1.BoxModel.CSSMargin.Top:='2px';
    Labels.Label2.LayoutConfig.Width:='100%';
    Labels.Label2.Caption:=WM013RicAssenzeMW.Periodo;
    Labels.Label2.Constraints.MinHeight:=20;
    Labels.Label2.JustifyContent:=JustifyStart;
    Labels.Label3.Visible:=False;
    Labels.Label4.Visible:=False;

    //Labels.Label1.ScreenMask.Enabled:=True;
    //Labels.Label1.ScreenMask.ShowMessage:=False;
    //Labels.Label2.ScreenMask:=Labels.Label1.ScreenMask;
    //Icon.ScreenMask:=Labels.Label1.ScreenMask;
    Icon.Visible:=False;

    if Assigned(WR006AllegatiMW) then  //se è attiva la gestione allegati
    begin
      LCondizioneAllegati:=WR006AllegatiMW.GetCondizioneAllegati;
      BoxModel.CSSMargin.Left:='5px';

      if LCondizioneAllegati <> 'N' then
      begin
        Icon.Visible:=True;

        LNumAllegati:=WR006AllegatiMW.GetNumeroAllegati(WM013RicAssenzeMW.ID);

        if LNumAllegati > 0 then
          Icon.JSInterface.JSCall('addCls', ['allegato-presente'])
        else
        begin
          if LCondizioneAllegati = 'O' then
            Icon.JSInterface.JSCall('addCls', ['allegato-obbligatorio']);
        end;

        Icon.Caption:='fas fa-paperclip';
        Icon.BoxModel.CSSBorderRadius:='30px';
        Icon.BoxModel.CSSPadding.Top:='6px';
        Icon.BoxModel.CSSPadding.Bottom:='6px';
        Icon.BoxModel.CSSPadding.Left:='6px';
        Icon.BoxModel.CSSPadding.Right:='6px';
      end;
    end;
  end;
  Result:=LPanel;
end;

procedure TWM013FRicAssenzeFM.AggiornaHeaderDettaglio;
begin
  inherited;

  if Assigned(WM013RicAssenzeMW) then
    with WM013RicAssenzeMW do
    begin
      pnlEliminaRevoca.Button1.Visible:=Revocabile = 'CANC';

      // possibilità di revocare la richiesta: rich. revocabile non elaborata
      pnlEliminaRevoca.Button2.Visible:=(C018Revocabile) and
                                        (TipoRichiestaEstesa <> 'Revoca') and
                                        (TipoRichiestaEstesa <> 'C') and
                                        (Revocabile = 'REVOC') and
                                        (Elaborato <> 'E') and
                                        (IdRevoca = 0);
    end;
end;

function TWM013FRicAssenzeFM.AggiornaListaDettaglio: TResCtrl;
begin
  pnlListaDettaglio.Clear;

  if Assigned(WM013RicAssenzeMW) then
  begin
    pnlListaDettaglio.Add2Labels('Nominativo', WM013RicAssenzeMW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_TIPO_RICHIESTA_TEXT, WM013RicAssenzeMW.TipoRichiestaModificata, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Periodo', WM013RicAssenzeMW.PeriodoOrarioRichieste, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Causale', WM013RicAssenzeMW.CausaleEstesa, False, 0, nil);

    if WM013RicAssenzeMW.Familiare <> '' then
      pnlListaDettaglio.Add2Labels('Familiare', WM013RicAssenzeMW.Familiare, False, 0, nil);

    if WM013RicAssenzeMW.TipoCausale = 'A' then
      pnlListaDettaglio.Add2Labels(ITEM_COMPETENZE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclCompetenzeClick);

    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM013RicAssenzeMW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    if WM013RicAssenzeMW.MotivazionePresente then
      pnlListaDettaglio.Add2Labels(ITEM_MOTIVAZIONE_TEXT, WM013RicAssenzeMW.Motivazione, False, 0, nil);

    Result:=AggiungiGestAllegatiDettaglio;
    if not Result.Ok then
      Exit;

    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM013RicAssenzeMW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

procedure TWM013FRicAssenzeFM.OnDisclCompetenzeClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if (Sender is TMedpUnimPanelDisclosure) and (tpnlRichieste.ActivePage = tabDettaglio) then
  begin
    AggiornaHeaderCompetenze;
    LResCtrl:=AggiornaListaCompetenze;

    if LResCtrl.Ok then
      tpnlRichieste.ActivePage:=tabCompetenze
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM013FRicAssenzeFM.pnlHeaderCompetenzelblBackClick(Sender: TObject);
begin
  inherited;
  tpnlRichieste.ActivePage:=tabDettaglio;
end;

procedure TWM013FRicAssenzeFM.PopolaAccorpCausali;
var LLista: TList<TPair<String,String>>;
begin
  with WM013RicAssenzeMW do
  begin
    try
      LLista:=GetAccorpCausali(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C90_W010CausPres);
      cmbAccorpCausali.Popola(LLista,'');
    finally
      FreeAndNil(LLista);
    end;
  end;
end;

procedure TWM013FRicAssenzeFM.PopolaCausali;
var LLista: TList<TPair<String,String>>;
begin
  if cmbAccorpCausali.ItemIndex >= 0 then
  begin
    with WM013RicAssenzeMW do
    begin
      try
        LLista:=GetCausali(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C23_InsNegCatena,
                           WM000FMainModule.InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C90_W010CausPres,
                           cmbAccorpCausali.ListaCodici[cmbAccorpCausali.ItemIndex],
                           cmbAccorpCausali.ListaDescrizioni[cmbAccorpCausali.ItemIndex]
                           );
        cmbCausale.Popola(LLista,'');

        cmbCausale.ItemIndex:=-1;
      finally
        lblMotivazione.Visible:=False;
        cmbMotivazione.Visible:=False;

        FreeAndNil(LLista);
      end;
    end;;
  end;
end;

procedure TWM013FRicAssenzeFM.PopolaFamiliari(var PGestioneFam: Boolean);
var LLista: TList<TPair<String,String>>;
begin
  PGestioneFam:=False;

  if cmbCausale.ItemIndex >= 0 then
  begin
    with WM013RicAssenzeMW do
    begin
      try
        LLista:=GetFamiliari(cmbCausale.ListaCodici[cmbCausale.ItemIndex], PGestioneFam);
        cmbFamiliare.Popola(LLista,'');

        cmbFamiliare.ItemIndex:=-1;
      finally
        FreeAndNil(LLista);
      end;
    end;
  end;
end;

procedure TWM013FRicAssenzeFM.PopolaNote;
var LLista: TList<TPair<String,String>>;
begin
  with WM013RicAssenzeMW do
  begin
    try
      LLista:=GetNote;
      cmbNote.Popola(LLista,'');

      cmbNote.ItemIndex:=-1;
    finally
      FreeAndNil(LLista);
    end;
  end;
end;

procedure TWM013FRicAssenzeFM.PopolaMotivazioni;
var LLista: TList<TPair<String,String>>;
    LCodMotivazioneDefault: String;
begin
  if cmbCausale.ItemIndex >= 0 then
  begin
    with WM013RicAssenzeMW do
    begin
      try
        LLista:=GetMotivazioni(cmbCausale.ListaCodici[cmbCausale.ItemIndex], LCodMotivazioneDefault) ;

        cmbMotivazione.Popola(LLista,'');

        // seleziona default
        if cmbMotivazione.Items.Count > 0 then
          if cmbMotivazione.Items.Count = 1 then
            // seleziona l'unico elemento disponibile
            cmbMotivazione.ItemIndex:=0
          else if (LCodMotivazioneDefault <> '') then
            // seleziona l'elemento di default indicato
            cmbMotivazione.ItemIndex:=cmbMotivazione.ListaCodici.IndexOf(LCodMotivazioneDefault)
          else
            // rimuove selezione
            cmbMotivazione.ItemIndex:=-1;
      finally
        FreeAndNil(LLista);
      end;
    end;
  end;
end;

procedure TWM013FRicAssenzeFM.PopolaTipiFruizione;
var LLista: TList<TPair<String,String>>;
begin
  if cmbCausale.ItemIndex >= 0 then
  begin
    with WM013RicAssenzeMW do
    begin
      try
        LLista:=GetTipiFruizione(cmbCausale.ListaCodici[cmbCausale.ItemIndex]);
        cmbTipoFruizione.Popola(LLista,'');

        cmbTipoFruizione.ItemIndex:=-1;
      finally
        FreeAndNil(LLista);
      end;
    end;
  end;
end;

procedure TWM013FRicAssenzeFM.AggiornaHeaderCompetenze;
begin
  if Assigned(WM013RicAssenzeMW) then
  begin
    pnlHeaderCompetenze.LabelDettaglio.Caption:=Format('Competenze %s al %s',[WM013RicAssenzeMW.CodCausale, FormatDateTime('dd/mm/yyyy', WM013RicAssenzeMW.DataDal)]);
  end;
end;

function TWM013FRicAssenzeFM.AggiornaListaCompetenze: TResCtrl;
begin
  pnlListaCompetenze.Clear;

  if Assigned(WM013RicAssenzeMW) then
  begin
    with WM000FMainModule do
        Result:=WR004CompetenzeMW.GetCompetenzeSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin,
                                                     WM013RicAssenzeMW.Progressivo, WM013RicAssenzeMW.CodCausale,
                                                     WM013RicAssenzeMW.DataDal, WM013RicAssenzeMW.DataNascitaFamiliare);
    if Result.Ok then
      if WR004CompetenzeMW.Competenze = '' then
      begin
        pnlListaCompetenze.Add2Labels('Competenze', 'non previste', False, 0, nil);
      end
      else
      begin
        pnlListaCompetenze.Add2Labels('Competenze', Format('%s %s',[WR004CompetenzeMW.Competenze, WR004CompetenzeMW.UnitaDiMisura]), False, 0, nil);
        pnlListaCompetenze.Add2Labels('Fruito', Format('%s %s',[WR004CompetenzeMW.Fruito, WR004CompetenzeMW.UnitaDiMisura]), False, 0, nil);
        pnlListaCompetenze.Add2Labels('Residuo', Format('%s %s',[WR004CompetenzeMW.Residuo, WR004CompetenzeMW.UnitaDiMisura]), False, 0, nil);
      end
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM003AutAssenzeMW non inizializzato, impossibile aggiornare la lista delle competenze';
  end;
end;

function TWM013FRicAssenzeFM.ControllaOkRichiesta: TResCtrl;
var LRes: TResCtrl;
begin
  Result.Clear;

  with WM013RicAssenzeMW do
  begin
    DatiGiustificativo.Clear;

    // progressivo
    DatiGiustificativo.Progressivo:=WM000FMainModule.InfoLogin.DatiGenerali.DatiAnagraficiUtente.Progressivo;

    // causale
    if cmbCausale.ItemIndex = -1 then
    begin
      Result.Messaggio:='Selezionare la causale';
      Exit;
    end;

    DatiGiustificativo.Causale:=cmbCausale.ListaCodici[cmbCausale.ItemIndex];
    //se il codice selezionato si trova tra quelli di assenza o presenza, allora imposto tipocausale
    if IsCausaleAssenza(DatiGiustificativo.Causale) then
      DatiGiustificativo.TipoCausale:=TTipoCausaleRec.Assenza
    else if IsCausalePresenza(DatiGiustificativo.Causale) then
      DatiGiustificativo.TipoCausale:=TTipoCausaleRec.Presenza;

    // familiare
    if cmbFamiliare.Visible then
    begin
      if cmbFamiliare.ItemIndex = -1 then
      begin
        Result.Messaggio:='Selezionare il familiare di riferimento';
        Exit;
      end;

      if not TryStrToDateTime(cmbFamiliare.ListaCodici[cmbFamiliare.ItemIndex], DatiGiustificativo.Datanas) then
      begin
        Result.Messaggio:=Format('La data di nascita o adozione del familiare di riferimento non è valida: %s',[cmbFamiliare.ListaCodici[cmbFamiliare.ItemIndex]]);
        Exit;
      end;
    end;

    // tipo fruizione
    if cmbTipoFruizione.ItemIndex = -1 then
    begin
      Result.Messaggio:='Selezionare la tipologia di fruizione';
      Exit;
    end;

    DatiGiustificativo.TipoGiust:=cmbTipoFruizione.ListaCodici[cmbTipoFruizione.ItemIndex];

    // note mezza giornata
    DatiGiustificativo.NoteGiustificativo:=Trim(cmbNote.Text); //ho solo il codice

    // periodo dal / al
    if DatiGiustificativo.TipoCausale = TTipoCausaleRec.Assenza then
    begin
      // causale di assenza: periodo dal - al
      if pnlDataDaANew.DataDa.Date = 0 then
      begin
        Result.Messaggio:='Indicare la data di inizio periodo';
        Exit;
      end;

      if pnlDataDaANew.DataA.Date = 0 then
      begin
        Result.Messaggio:='Indicare la data di fine periodo';
        Exit;
      end;

      if pnlDataDaANew.DataA.Date < pnlDataDaANew.DataDa.Date then
      begin
        Result.Messaggio:='Il periodo di fruizione indicato non è valido';
        Exit;
      end;

      // controlli ok
      DatiGiustificativo.Dal:=pnlDataDaANew.DataDa.Date;
      DatiGiustificativo.Al:=pnlDataDaANew.DataA.Date;
    end
    else
    begin
      // causale di presenza: giorno singolo indicato nella data iniziale
      if pnlDataDaANew.DataDa.Date = 0 then
      begin
        Result.Messaggio:='Indicare la data di fruizione';
        Exit;
      end;

      // controlli ok
      DatiGiustificativo.Dal:=pnlDataDaANew.DataDa.Date;
      DatiGiustificativo.Al:=pnlDataDaANew.DataDa.Date;
    end;

    // periodo orario
    DatiGiustificativo.Minuti:=0;
    DatiGiustificativo.AMinuti:=0;
    if DatiGiustificativo.TipoGiust = 'N' then
    begin
      // numero ore
      if pnlOraDaANew.OraDa.Time = 0 then
      begin
        Result.Messaggio:='Indicare il numero di ore di fruizione';
        Exit;
      end;
    end
    else if DatiGiustificativo.TipoGiust = 'D' then
    begin
      if pnlOraDaANew.OraDa.Time = 0 then
      begin
        Result.Messaggio:='Indicare l''ora di inizio periodo';
        Exit;
      end;

      if pnlOraDaANew.OraA.Time = 0 then
      begin
        Result.Messaggio:='Indicare l''ora di fine periodo';
        Exit;
      end;
    end;
    if pnlOraDaANew.OraDa.Time = 0 then
      DatiGiustificativo.NumeroOre:=''
    else
      DatiGiustificativo.NumeroOre:=pnlOraDaANew.OraDa.Text;

    if pnlOraDaANew.OraA.Time = 0 then
      DatiGiustificativo.AOre:=''
    else
      DatiGiustificativo.AOre:=pnlOraDaANew.OraA.Text;

    // validazione orario
    LRes:=DatiGiustificativo.ValidaPeriodoOrario;
    if not LRes.Ok then
    begin
      Result.Messaggio:=LRes.Messaggio;
      Exit;
    end;

    // note
    DatiGiustificativo.NoteIns:=Trim(memNoteRichiesta.Memo.Text);

    // motivazione
    if cmbMotivazione.Items.Count > 0 then
    begin
      if cmbMotivazione.ItemIndex = -1 then
      begin
        Result.Messaggio:='Indicare la motivazione della richiesta';
        Exit;
      end;
      DatiGiustificativo.Motivazione:=cmbMotivazione.ListaCodici[cmbMotivazione.ItemIndex];
    end;

    // controlli ok
    Result.Ok:=True;
  end;
end;

procedure TWM013FRicAssenzeFM.OkRichiesta;
var
  LResCtrl: TResCtrl;
  LRisposteMsg: TRisposteMsg;
  LRisposta: String;
  LModalResult: Integer;
begin
  try
    with WM000FMainModule do
      LResCtrl:=WM013RicAssenzeMW.InserisciRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

    if LResCtrl.Ok then
    begin
      if LRisposteMsg.Bloccante then
      begin
        // messaggio bloccante
        ShowMessage(LRisposteMsg.ErrMsg);
        Exit;
      end;

      if LRisposteMsg.ErrMsg = '' then
      begin
        // inserimento effettuato
        ShowMessage('Inserimento effettuato');

        LResCtrl:=AggiornaListaRichieste;
        if not LResCtrl.Ok then
          ShowMessage(LResCtrl.Messaggio);

        tpnlRichieste.First;
      end
      else
      begin
        LModalResult:=MessageDlg(LRisposteMsg.ErrMsg, TMsgDlgType.mtConfirmation, mbYesNo);

        if LModalResult = mrYes then
          LRisposta:='SI'
        else
          LRisposta:='NO';

        LRisposteMsg.AddRisposta(LRisposteMsg.ErrCod,LRisposta);
        LRisposteMsg.AddMsg('','');

        with WM013RicAssenzeMW do
        begin
          if Assigned(DatiGiustificativo.RisposteMsg) then
            FreeAndNil(DatiGiustificativo.RisposteMsg);
          DatiGiustificativo.RisposteMsg:=LRisposteMsg.Clone;
        end;

        // gestione ricorsione
        if LModalResult = mrYes then
          OkRichiesta;
      end;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  finally
    FreeAndNil(LRisposteMsg);
  end;
end;

function TWM013FRicAssenzeFM.ControllaRevocaRichiesta: TResCtrl;
begin
  Result.Clear;
  Result.Ok:=True;
end;

procedure TWM013FRicAssenzeFM.RevocaRichiesta;
var
  LResCtrl: TResCtrl;
  LRisposteMsg: TRisposteMsg;
  LRisposta: String;
  LModalResult: Integer;
begin
  try
    with WM000FMainModule do
      LResCtrl:=WM013RicAssenzeMW.RevocaRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

    if LResCtrl.Ok then
    begin
      if LRisposteMsg.Bloccante then
      begin
        // messaggio bloccante
        ShowMessage(LRisposteMsg.ErrMsg);
        Exit;
      end;

      if LRisposteMsg.ErrMsg = '' then
      begin
        // inserimento effettuato
        ShowMessage('Richiesta revocata');

        LResCtrl:=AggiornaListaRichieste;
        if not LResCtrl.Ok then
          ShowMessage(LResCtrl.Messaggio);

        tpnlRichieste.First;
      end
      else
      begin
        LModalResult:=MessageDlg(LRisposteMsg.ErrMsg, TMsgDlgType.mtConfirmation, mbYesNo);

        if LModalResult = mrYes then
          LRisposta:='SI'
        else
          LRisposta:='NO';

        LRisposteMsg.AddRisposta(LRisposteMsg.ErrCod,LRisposta);
        LRisposteMsg.AddMsg('','');

        with WM013RicAssenzeMW do
        begin
          if Assigned(DatiGiustificativo.RisposteMsg) then
            FreeAndNil(DatiGiustificativo.RisposteMsg);
          DatiGiustificativo.RisposteMsg:=LRisposteMsg.Clone;
        end;

        // gestione ricorsione
        if LModalResult = mrYes then
          RevocaRichiesta;
      end;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  finally
    FreeAndNil(LRisposteMsg);
  end;
end;

function TWM013FRicAssenzeFM.ControllaEliminaRichiesta: TResCtrl;
begin
  Result.Clear;
  Result.Ok:=True;
end;

procedure TWM013FRicAssenzeFM.EliminaRichiesta;
var
  LResCtrl: TResCtrl;
  LRisposteMsg: TRisposteMsg;
  LRisposta: String;
  LModalResult: Integer;
begin
  try
    with WM000FMainModule do
      LResCtrl:=WM013RicAssenzeMW.EliminaRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

    if LResCtrl.Ok then
    begin
      if LRisposteMsg.Bloccante then
      begin
        // messaggio bloccante
        ShowMessage(LRisposteMsg.ErrMsg);
        Exit;
      end;

      if LRisposteMsg.ErrMsg = '' then
      begin
        // inserimento effettuato
        ShowMessage('Richiesta eliminata');

        LResCtrl:=AggiornaListaRichieste;
        if not LResCtrl.Ok then
          ShowMessage(LResCtrl.Messaggio);

        tpnlRichieste.First;
      end
      else
      begin
        LModalResult:=MessageDlg(LRisposteMsg.ErrMsg, TMsgDlgType.mtConfirmation, mbYesNo);

        if LModalResult = mrYes then
          LRisposta:='SI'
        else
          LRisposta:='NO';

        LRisposteMsg.AddRisposta(LRisposteMsg.ErrCod,LRisposta);
        LRisposteMsg.AddMsg('','');

        with WM013RicAssenzeMW do
        begin
          if Assigned(DatiGiustificativo.RisposteMsg) then
            FreeAndNil(DatiGiustificativo.RisposteMsg);
          DatiGiustificativo.RisposteMsg:=LRisposteMsg.Clone;
        end;

        // gestione ricorsione
        if LModalResult = mrYes then
          EliminaRichiesta;
      end;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  finally
    FreeAndNil(LRisposteMsg);
  end;
end;

procedure TWM013FRicAssenzeFM.cmbAccorpCausaliChange(Sender: TObject);
begin
  inherited;
  // popola elenco causali
  PopolaCausali;

  // selezione causale disponibile oppure gestione pannelli
  lblCausale.Visible:=True;
  cmbCausale.Visible:=True;

  if cmbCausale.Items.Count = 1 then
  begin
    cmbCausale.ItemIndex:=0;
    cmbCausaleChange(cmbCausale);
  end
  else
  begin
    // se non ci sono causali disponibili avvisa
    if cmbCausale.Items.Count = 0 then
      ShowMessage('Nessuna causale disponibile nell''accorpamento selezionato!');

    // gestione pannelli
    lblFamiliare.Visible:=False;
    cmbFamiliare.Visible:=False;

    lblTipoFruizione.Visible:=False;
    cmbTipoFruizione.Visible:=False;

    lblNote.Visible:=False;
    cmbNote.Visible:=False;

    lblPeriodo.Visible:=False;
    pnlDataDaANew.Visible:=False;
    pnlOraDaANew.Visible:=False;
  end;
end;

procedure TWM013FRicAssenzeFM.cmbCausaleChange(Sender: TObject);
var
  LGestFam: Boolean;
begin
  inherited;

  // elenco familiari
  PopolaFamiliari(LGestFam);
  lblFamiliare.Visible:=LGestFam;
  cmbFamiliare.Visible:=LGestFam;

  // selezione familiare o gestione pannelli
  if cmbFamiliare.Items.Count = 1 then
    cmbFamiliare.ItemIndex:=0
  else
  begin
    // gestione pannelli successivi
    lblTipoFruizione.Visible:=True;
    cmbTipoFruizione.Visible:=True;

    lblNote.Visible:=False;
    cmbNote.Visible:=False;

    lblPeriodo.Visible:=False;
    pnlDataDaANew.Visible:=False;
    pnlOraDaANew.Visible:=False;
  end;

  // elenco tipi fruizione
  PopolaTipiFruizione;
  lblTipoFruizione.Visible:=True;
  cmbTipoFruizione.Visible:=True;

  if cmbTipoFruizione.Items.Count = 1 then
  begin
    cmbTipoFruizione.ItemIndex:=0;
    cmbTipoFruizioneChange(cmbTipoFruizione);
  end
  else
  begin
    // gestione pannelli successivi
    lblNote.Visible:=False;
    cmbNote.Visible:=False;

    lblPeriodo.Visible:=False;
    pnlDataDaANew.Visible:=False;
    pnlOraDaANew.Visible:=False;
  end;

  // pannello motivazioni
  PopolaMotivazioni;
  lblMotivazione.Visible:=cmbMotivazione.Items.Count > 0;
  cmbMotivazione.Visible:=cmbMotivazione.Items.Count > 0;
end;

procedure TWM013FRicAssenzeFM.cmbTipoFruizioneChange(Sender: TObject);
var
  LNoteVis: Boolean;
  LCodTipoFruizione: String;
  LCodCausale: String;
  LCausPres: Boolean;
begin
  inherited;

  LCodTipoFruizione:=cmbTipoFruizione.ListaCodici[cmbTipoFruizione.ItemIndex];
  LCodCausale:=cmbCausale.ListaCodici[cmbCausale.ItemIndex];
  LCausPres:=WM013RicAssenzeMW.IsCausalePresenza(LCodCausale); //verifico se è una causale di presenza

  // impostazioni periodo dal / al
  lblPeriodo.Visible:=True;
  pnlDataDaANew.Visible:=True;
  pnlOraDaANew.Visible:=True;

  if LCausPres then
  begin
    pnlDataDaANew.DataDa.FieldLabel:='Data';
    pnlDataDaANew.DataDa.FieldLabelWidth:=35;
    pnlDataDaANew.DataA.Visible:=False;
  end
  else
  begin
    pnlDataDaANew.DataDa.FieldLabel:='Da';
    pnlDataDaANew.DataDa.FieldLabelWidth:=20;
    pnlDataDaANew.DataA.Visible:=True;
  end;

  pnlDataDaANew.DataDa.Date:=0;

  pnlDataDaANew.DataA.Date:=0;

  // impostazioni periodo orario
  pnlOraDaANew.Visible:=((LCodTipoFruizione = FRUIZ_N) or (LCodTipoFruizione = FRUIZ_D));
  pnlOraDaANew.OraA.Visible:=LCodTipoFruizione = FRUIZ_D;

  if LCodTipoFruizione = FRUIZ_N then
  begin
    pnlOraDaANew.OraDa.FieldLabel:='Numero ore';
    pnlOraDaANew.OraDa.FieldLabelWidth:=50;
  end
  else if LCodTipoFruizione = FRUIZ_D then
  begin
    pnlOraDaANew.OraDa.FieldLabel:='Da';
    pnlOraDaANew.OraDa.FieldLabelWidth:=20;
  end;

  pnlOraDaANew.OraDa.Time:=0;
  pnlOraDaANew.OraA.Time:=0;

  // pannello note mezza gg.
  LNoteVis:=(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S') and
            (cmbTipoFruizione.ItemIndex > -1) and
            (cmbTipoFruizione.ListaCodici[cmbTipoFruizione.ItemIndex] = FRUIZ_M);

  lblNote.Visible:=LNoteVis;
  cmbNote.Visible:=LNoteVis;
end;

procedure TWM013FRicAssenzeFM.edtDataDaChange(Sender: TObject);
begin
  inherited;

  if not pnlDataDaANew.DataA.Visible then
    Exit;

  // automatismi sul periodo
  // se la data finale non è indicata la valorizza uguale alla data iniziale e assicura che la data finale sia >= alla data iniziale
  if (pnlDataDaANew.DataA.Date = 0) or (pnlDataDaANew.DataA.Date < pnlDataDaANew.DataDa.Date) then
    pnlDataDaANew.DataA.Date:=pnlDataDaANew.DataDa.Date;
end;

procedure TWM013FRicAssenzeFM.edtDataAChange(Sender: TObject);
begin
  inherited;

  // automatismi sul periodo
  // se la data iniziale non è indicata la valorizza uguale alla data finale e assicura che la data iniziale sia <= alla data finale
  if (pnlDataDaANew.DataDa.Date = 0) or (pnlDataDaANew.DataDa.Date > pnlDataDaANew.DataA.Date)  then
    pnlDataDaANew.DataDa.Date:=pnlDataDaANew.DataA.Date;
end;

initialization
  RegisterClass(TWM013FRicAssenzeFM);

end.
