unit WM014URicTimbratureFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR002URichiesteFM,
  MedpUnimPanelHeaderDett, MedpUnimPanelListaElem, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses,
  uniGUImJSForm, MedpUnimPanelBase, MedpUnimPanel4Labels, MedpUnimPanelDisclosure,
  MedpUnimTypes, WR003UGestRichiesteFM, WR002URichiesteMW, WM000UMainModule,
  unimPanel, MedpUnimPanel2Button, uniButton, uniBitBtn, unimBitBtn,
  MedpUnimButton, uniDateTimePicker, unimDatePicker, MedpUnimDatePicker, A000UCostanti,
  WR005UTimbratureModificabiliMW, MedpUnimPanel2Labels, System.StrUtils, WM000UConstants,
  uniLabel, unimLabel, MedpUnimLabel, unimTimePicker, MedpUnimTimePicker,
  uniEdit, unimEdit, MedpUnimEdit, uniMultiItem, unimSelect, MedpUnimSelect,
  uniMemo, unimMemo, MedpUnimMemo, FunzioniGenerali, FireDAC.Comp.Client, Data.DB, B110USharedTypes, C200UWebServicesTypes,
  WM014URicTimbratureMW, MedpUnimPanelListaDisclosure,
  MedpUnimPanelListaDettaglio, Generics.Collections, uniFileUpload,
  unimFileUpload, uniCheckBox, unimCheckBox;

type
  TWM014FRicTimbratureFM = class(TWR003FGestRichiesteFM)
    tabTimbrature: TUnimTabSheet;
    btnNuovaTimbratura: TMedpUnimButton;
    pnlHeaderTimbrature: TMedpUnimPanelHeaderDett;
    edtDataTimbrature: TMedpUnimDatePicker;
    pnlListaTimbrature: TMedpUnimPanelListaElem;
    rgpVersoTimbratura: TMedpUnimRadioGroup;
    lblGiorno: TMedpUnimLabel;
    edtOra: TMedpUnimTimePicker;
    lblCausale: TMedpUnimLabel;
    cmbCausale: TMedpUnimSelect;
    lblRilevatore: TMedpUnimLabel;
    cmbRilevatore: TMedpUnimSelect;
    lblNote: TMedpUnimLabel;
    lblMotivazione: TMedpUnimLabel;
    cmbMotivazione: TMedpUnimSelect;
    memNote: TMedpUnimMemo;
    btnEliminaTimbratura: TMedpUnimButton;

    procedure UniFrameCreate(Sender: TObject); override;
    procedure UniFrameDestroy(Sender: TObject); override;

    procedure OnNuovaRichiestaClick(Sender: TObject); override;
    procedure OnBackTimbratureClick(Sender: TObject);
    procedure OnDataTimbratureChange(Sender: TObject);
    procedure OnNuovaTimbraturaClick(Sender: TObject);
    procedure OnModificaTimbraturaClick(Sender: TObject);
    procedure OnEliminaTimbraturaClick(Sender: TObject);
    procedure OnDatiTimbraturaChange(Sender: TObject);
  private
    WR005TimbratureMW: TWR005FTimbratureModificabiliMW;
    WM014RicTimbratureMW: TWM014FRicTimbratureMW;
    function ModelToUI: TResCtrl;

    function PopolaCombobox: TResCtrl;

    procedure CreaPanelTimbratura(PID, PDescVerso, POra, PRilevatore: String);
  protected
    function AggiornaListaTimbrature: TResCtrl;

    procedure AggiornaHeaderDettaglio; override;
    function AggiornaListaDettaglio: TResCtrl; override;
    function  CreaLabelsRichiesta: TMedpUnimPanelBase; override;

    function ControllaEliminaRichiesta: TResCtrl; override;
    procedure EliminaRichiesta; override;

    function ControllaRevocaRichiesta: TResCtrl; override;
    procedure RevocaRichiesta; override;

    function ControllaOkRichiesta: TResCtrl; override;
    procedure OkRichiesta; override;
    function GetMsgOkRichiesta: String; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TWM014FRichiestaTimbratureFM }

procedure TWM014FRicTimbratureFM.UniFrameCreate(Sender: TObject);
begin
  WR002RichiesteMW:=TWM014FRicTimbratureMW.Create;
  WM014RicTimbratureMW:=WR002RichiesteMW as TWM014FRicTimbratureMW;

  WR005TimbratureMW:=TWR005FTimbratureModificabiliMW.Create;

  edtDataTimbrature.Date:=Now;
  FAutorizzatore:=False;
  inherited;
end;

procedure TWM014FRicTimbratureFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WR005TimbratureMW);
  WM014RicTimbratureMW:=nil;
  inherited;
end;

function TWM014FRicTimbratureFM.AggiornaListaTimbrature: TResCtrl;
begin
  pnlListaTimbrature.Clear;

  if Assigned(WR005TimbratureMW) then
  begin
    with WM000FMainModule do
      Result:=WR005TimbratureMW.AggiornaTimbratureModifSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, edtDataTimbrature.Date);

    if Result.Ok then
      while not WR005TimbratureMW.Eof do
      begin
        CreaPanelTimbratura(WR005TimbratureMW.Id,
                            WR005TimbratureMW.DescVerso,
                            WR005TimbratureMW.Ora,
                            WR005TimbratureMW.Rilevatore
                            );

        WR005TimbratureMW.Next;
      end;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WR005TimbratureMW non inizializzato, impossibile aggiornare la lista delle timbrature';
  end;
end;

function TWM014FRicTimbratureFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
var LLabels: TMedpUnimPanel4Labels;
begin
  LLabels:=TMedpUnimPanel4Labels.Create(Self);

  with LLabels do
  begin
    Constraints.MinHeight:=40;

    with Label1 do
    begin
      Caption:=WM014RicTimbratureMW.Operazione;
      LayoutConfig.Height:='100%';//'35';
      LayoutConfig.Width:='30%';
      Font.Style:=Label1.Font.Style + [fsBold];
    end;

    with Label2 do
    begin
      Caption:=WM014RicTimbratureMW.Timbratura;
      LayoutConfig.Height:='50%';//'auto';
      LayoutConfig.Width:='70%';
      JustifyContent:=JustifyStart;
    end;

    with Label3 do
    begin
      Caption:=FormatDateTime('dd/mm/yyyy',WM014RicTimbratureMW.Data);
      LayoutConfig.Height:='50%';//'auto';
      LayoutConfig.Width:='70%';
      JustifyContent:=JustifyStart;
    end;

    Label4.Visible:=False;
  end;

  Result:=LLabels;
end;

procedure TWM014FRicTimbratureFM.AggiornaHeaderDettaglio;
begin
  inherited;

  if Assigned(WM014RicTimbratureMW) then
  begin
    // attiva possibilità di eliminare o revocare la richiesta
    pnlEliminaRevoca.Button1.Visible:=(AbilitazioneFunzione = 'S') and (WM014RicTimbratureMW.Revocabile = 'CANC');
    pnlEliminaRevoca.Button2.Visible:=(AbilitazioneFunzione = 'S') and False; // sempre false!!!
  end;
end;

function TWM014FRicTimbratureFM.AggiornaListaDettaglio: TResCtrl;
begin
  inherited;

  pnlListaDettaglio.Clear;

  if Assigned(WM014RicTimbratureMW) then
  begin
    pnlListaDettaglio.Add2Labels('Nominativo', WM014RicTimbratureMW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Data', FormatDateTime('dd/mm/yyyy',WM014RicTimbratureMW.Data), False, 0, nil);
    pnlListaDettaglio.Add2Labels('Operazione', WM014RicTimbratureMW.OperazioneEstesa, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Timbratura', WM014RicTimbratureMW.Timbratura, False, 0, nil);

    if WM014RicTimbratureMW.Operazione = 'M' then
      pnlListaDettaglio.Add2Labels('Timbratura orig.', WM014RicTimbratureMW.TimbraturaOrig, False, 0, nil);
    ;
    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM014RicTimbratureMW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    if WM014RicTimbratureMW.MotivazionePresente then
      pnlListaDettaglio.Add2Labels(ITEM_MOTIVAZIONE_TEXT, WM014RicTimbratureMW.Motivazione, False, 0, nil);

    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM014RicTimbratureMW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

procedure TWM014FRicTimbratureFM.CreaPanelTimbratura(PID, PDescVerso, POra, PRilevatore: String);
var LLabels: TMedpUnimPanel2Labels;
    LDisclosure: TMedpUnimPanelDisclosure;
begin
  LLabels:=TMedpUnimPanel2Labels.Create(Self);
  LDisclosure:=TMedpUnimPanelDisclosure.Create(Self);

  with LLabels do
  begin
    LayoutConfig.Height:='35';

    with Label1 do
    begin
      Caption:=Format('%s %s',[PDescVerso, POra]) + IfThen(PRilevatore <> '',Format(' (%s)',[PRilevatore]));
      LayoutConfig.Height:='100%';
      LayoutConfig.Width:='100%';

      if WR005TimbratureMW.Verso = 'E' then
        Font.Color:=FONT_COLOR_TIMB_ENTRATA
      else
        Font.Color:=FONT_COLOR_TIMB_USCITA;
    end;

    Label2.Visible:=False;
  end;

  LDisclosure.ScreenMask:=pnlListaTimbrature.ScreenMask;
  LDisclosure.InsertBasePanel(LLabels);
  LDisclosure.Key:=PID;
  LDisclosure.Constraints.MinHeight:=45;
  LDisclosure.Data:=nil;
  LDisclosure.OnClick:=OnModificaTimbraturaClick;
  LDisclosure.JSInterface.JSCall('addCls', ['activeColor']);

  pnlListaTimbrature.Add(LDisclosure);
end;

procedure TWM014FRicTimbratureFM.OnNuovaRichiestaClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;
  edtDataTimbrature.Date:=Now;

  btnNuovaTimbratura.Visible:=WM000FMainModule.InfoLogin.DatiGenerali.Parametri.InserisciTimbrature = 'S';

  LResCtrl:=AggiornaListaTimbrature;

  if LResCtrl.Ok then
    tpnlRichieste.Last
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM014FRicTimbratureFM.OnBackTimbratureClick(Sender: TObject);
begin
  inherited;
  tpnlRichieste.First;
end;

procedure TWM014FRicTimbratureFM.OnDataTimbratureChange(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  LResCtrl:=AggiornaListaTimbrature;

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM014FRicTimbratureFM.OnDatiTimbraturaChange(Sender: TObject);
var LVerso: String;
    LCodCausale: String;
    LCodRilevatore: String;
begin
  if rgpVersoTimbratura.ItemIndex = 0 then
    LVerso:='E'
  else if rgpVersoTimbratura.ItemIndex = 1 then
    LVerso:='U'
  else
    LVerso:='';

  if cmbCausale.ItemIndex >= 0 then
    LCodCausale:=cmbCausale.ListaCodici[cmbCausale.ItemIndex]
  else
    LCodCausale:='';

  if cmbRilevatore.ItemIndex >= 0 then
    LCodRilevatore:=cmbRilevatore.ListaCodici[cmbRilevatore.ItemIndex]
  else
    LCodRilevatore:='';

  pnlOkAnnulla.Button1.Enabled:=WR005TimbratureMW.DatiTimbraturaChanged(edtOra.Text, LVerso, LCodCausale, LCodRilevatore);
end;

procedure TWM014FRicTimbratureFM.OnNuovaTimbraturaClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;

  with WM000FMainModule do
    WM014RicTimbratureMW.ResetOperazioneTimbratura(Nuova,
                                                   InfoLogin.DatiGenerali.DatiAnagraficiUtente.Progressivo,
                                                   edtDataTimbrature.Date, '', '', '', '');
  LResCtrl:=ModelToUI;
  if LResCtrl.Ok then
    tpnlRichieste.Prior
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM014FRicTimbratureFM.OnModificaTimbraturaClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;

  if (Sender is TMedpUnimPanelDisclosure) and Assigned(WR005TimbratureMW) then
    if WR005TimbratureMW.Locate('ID',(Sender as TMedpUnimPanelDisclosure).Key,[]) then
    begin
      with WM000FMainModule do
        WM014RicTimbratureMW.ResetOperazioneTimbratura(Modifica,
                                                       InfoLogin.DatiGenerali.DatiAnagraficiUtente.Progressivo,
                                                       WR005TimbratureMW.Data,
                                                       WR005TimbratureMW.Ora,
                                                       WR005TimbratureMW.Verso,
                                                       WR005TimbratureMW.Rilevatore,
                                                       WR005TimbratureMW.Causale);
      LResCtrl:=ModelToUI;
      if LResCtrl.Ok then
      begin
        pnlOkAnnulla.Button1.Enabled:=False;
        tpnlRichieste.Prior;
      end
      else
        ShowMessage(LResCtrl.Messaggio);
    end;
end;

procedure TWM014FRicTimbratureFM.OnEliminaTimbraturaClick(Sender: TObject);
begin
  inherited;
  with WM000FMainModule do
    WM014RicTimbratureMW.ResetOperazioneTimbratura(Elimina,
                                                   InfoLogin.DatiGenerali.DatiAnagraficiUtente.Progressivo,
                                                   WR005TimbratureMW.Data,
                                                   WR005TimbratureMW.Ora,
                                                   WR005TimbratureMW.Verso,
                                                   WR005TimbratureMW.Rilevatore,
                                                   WR005TimbratureMW.Causale);

  OnOkRichiestaClick(Sender);   //INSERISCE UNA RICHIESTA DI CANCELLAZIONE DELLA TIMBRATURA!!!!!!!!!!!!
end;

function TWM014FRicTimbratureFM.PopolaCombobox: TResCtrl;
var LLista: TList<TPair<String, String>>;
    LPair: TPair<String, String>;
    LDefaultCode: String;
begin
  cmbCausale.Clear;
  cmbRilevatore.Clear;
  cmbMotivazione.Clear;

  LLista:=nil;

  with WM000FMainModule do
  begin
    try
      Result:=WM014RicTimbratureMW.GetCausaliTimbraturaRichiedibiliSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LLista);
      if Result.Ok then
        cmbCausale.Popola(LLista, '')
      else
        exit;

      Result:=WM014RicTimbratureMW.GetRilevatoriRichiedibiliSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LLista);
      if Result.Ok then
        cmbRilevatore.Popola(LLista, '')
      else
        exit;

      Result:=WM014RicTimbratureMW.GetMotivazioniTimbraturaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LLista, LDefaultCode);
      if Result.Ok then
        cmbMotivazione.Popola(LLista, LDefaultCode)
      else
        exit;

      //aggiunta rilevatore e causale se non presenti nella lista dei richiedibili
      if Assigned(WM014RicTimbratureMW.DatiTimbratura) then
      begin
        if (WM014RicTimbratureMW.DatiTimbratura.Rilevatore <> '') and (cmbRilevatore.IndexOfCode(WM014RicTimbratureMW.DatiTimbratura.Rilevatore) = -1) then
        begin
          Result:=WM014RicTimbratureMW.GetRilevatoriSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LLista);

          if Result.Ok then
            for LPair in LLista do
              if Lpair.Key = WM014RicTimbratureMW.DatiTimbratura.Rilevatore then
              begin
                cmbRilevatore.Add(Lpair.Key, Lpair.Value);
                break;
              end
          else
            exit;
        end;

        if (WM014RicTimbratureMW.DatiTimbratura.Causale <> '') and (cmbCausale.IndexOfCode(WM014RicTimbratureMW.DatiTimbratura.Causale) = -1) then
        begin
          Result:=WM014RicTimbratureMW.GetCausaliTimbraturaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LLista);

          if Result.Ok then
            for LPair in LLista do
              if Lpair.Key = WM014RicTimbratureMW.DatiTimbratura.Causale then
              begin
                cmbCausale.Add(Lpair.Key, Lpair.Value);
                break;
              end
          else
            Exit;
        end;
      end;
    finally
      FreeAndNil(LLista);
    end;
  end;
end;

function TWM014FRicTimbratureFM.ModelToUI: TResCtrl;
var LAbilModifica: Boolean;
begin
  Result:=PopolaCombobox;

  if not Result.Ok then
    Exit;

  lblGiorno.Caption:=Formatdatetime('dddd d mmmm yyyy', edtDataTimbrature.Date);

  // ora
  edtOra.OnChange:=nil;

  if WM014RicTimbratureMW.DatiTimbratura.Ora = '' then
    edtOra.Time:=Now
  else
  begin
    //edtOra.Time:=StrToTime(StringReplace(WM014RicTimbratureMW.DatiTimbratura.Ora, '.', ':', []));
    edtOra.Time:=StrToTime(WM014RicTimbratureMW.DatiTimbratura.Ora);;
  end;

  edtOra.OnChange:=OnDatiTimbraturaChange;

  // verso
  rgpVersoTimbratura.OnChange:=nil;

  if WM014RicTimbratureMW.DatiTimbratura.Verso = 'E' then
    rgpVersoTimbratura.ItemIndex:=0
  else if WM014RicTimbratureMW.DatiTimbratura.Verso = 'U' then
    rgpVersoTimbratura.ItemIndex:=1;

  rgpVersoTimbratura.OnChange:=OnDatiTimbraturaChange;
  // causale
  //   abilitata in base al parametro dei permessi, solo se la funzione è abilitata in scrittura

  // se è presente la causale associata alla timbratura
  // e questa non si trova nella lista di quelle disponibili da filtro dizionario
  // la aggiunge agli item in modo da visualizzarla

  cmbCausale.OnChange:=nil;
  cmbCausale.ItemIndex:=cmbCausale.IndexOfCode(WM014RicTimbratureMW.DatiTimbratura.Causale);
  cmbCausale.OnChange:=OnDatiTimbraturaChange;
  cmbCausale.Enabled:=(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Causale = 'S') and (AbilitazioneFunzione = 'S');

  // rilevatore
  // - inserimento
  //   abilitato in base al parametro dei permessi, solo se la funzione è abilitata in scrittura
  // - modifica
  //   sempre disabilitato
  // se è presente un rilevatore associato alla timbratura
  // e questo non si trova nella lista di quelli disponibili da filtro dizionario
  // lo aggiunge agli item in modo da visualizzarlo

  cmbRilevatore.OnChange:=nil;
  cmbRilevatore.ItemIndex:=cmbRilevatore.IndexOfCode(WM014RicTimbratureMW.DatiTimbratura.Rilevatore);
  cmbRilevatore.OnChange:=OnDatiTimbraturaChange;

  if WM014RicTimbratureMW.DatiTimbratura.Operazione = 'I' then
  begin
    btnEliminaTimbratura.Visible:=False;
    edtOra.Enabled:=True;
    cmbRilevatore.Enabled:=(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Rilevatore = 'S') and (AbilitazioneFunzione = 'S');
    rgpVersoTimbratura.Enabled:=True;
  end
  else
  begin
    btnEliminaTimbratura.Visible:=((WR005TimbratureMW.Flag = 'O') and (WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_CancTimbOrig = 'S')) or
                                  ((WR005TimbratureMW.Flag = 'I') and (WM000FMainModule.InfoLogin.DatiGenerali.Parametri.CancellaTimbrature = 'S'));
    edtOra.Enabled:=False;
    cmbRilevatore.Enabled:=False;
    rgpVersoTimbratura.Enabled:=WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Ora = 'S';
  end;

  if WM014RicTimbratureMW.DatiTimbratura.Operazione = 'I' then
    LAbilModifica:=True
  else
    LAbilModifica:=(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Causale = 'S') or
                   (WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Ora = 'S');

  // note (inizialmente vuote)
  memNote.OnChange:=nil;
  memNote.Memo.Text:='';
  memNote.OnChange:=OnDatiTimbraturaChange;
  memNote.Enabled:=LAbilModifica;

  // motivazione (valore di default se presente)
  //   abilitato se la funzione è abilitata in scrittura
  if cmbMotivazione.Items.Count > 0 then
  begin
    cmbMotivazione.Visible:=True;
    lblMotivazione.Visible:=True;

    cmbMotivazione.OnChange:=nil;
    cmbMotivazione.ItemIndex:=cmbMotivazione.IndexOfDefaultCode;
    cmbMotivazione.OnChange:=OnDatiTimbraturaChange;
    cmbMotivazione.Enabled:=LAbilModifica and (AbilitazioneFunzione = 'S');
  end
  else
  begin
    cmbMotivazione.Visible:=False;
    lblMotivazione.Visible:=False;
  end;
end;

function TWM014FRicTimbratureFM.ControllaOkRichiesta: TResCtrl;
begin
  Result.Clear;

  with WM014RicTimbratureMW do
  begin
    if (OperazioneTimbratura = Nuova) or (OperazioneTimbratura = Modifica)  then
    begin
      //verso
      if rgpVersoTimbratura.ItemIndex = 0 then
        DatiTimbratura.Verso:='E'
      else
        DatiTimbratura.Verso:='U';
      //ora
      DatiTimbratura.Ora:=edtOra.Text;
      //note
      DatiTimbratura.NoteIns:=Trim(memNote.Memo.Text);

      //causale
      if WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Causale = 'S' then
      begin
        if cmbCausale.ItemIndex < 0 then
        begin
          Result.Messaggio:='Selezionare la causale';
          Exit;
        end;

        DatiTimbratura.Causale:=cmbCausale.ListaCodici[cmbCausale.ItemIndex];
      end;

      //rilevatore
      if (OperazioneTimbratura = Nuova)
         and (WM000FMainModule.InfoLogin.DatiGenerali.Parametri.T100_Rilevatore = 'S') then
      begin
        if cmbRilevatore.ItemIndex < 0 then
        begin
          Result.Messaggio:='Selezionare il rilevatore';
          Exit;
        end;

        DatiTimbratura.Rilevatore:=cmbRilevatore.ListaCodici[cmbRilevatore.ItemIndex];
      end;

      // motivazione
      if cmbMotivazione.Items.Count > 0 then
      begin
        if cmbMotivazione.ItemIndex = -1 then
        begin
          Result.Messaggio:='Indicare la motivazione della richiesta';
          Exit;
        end;

        DatiTimbratura.Motivazione:=cmbMotivazione.ListaCodici[cmbMotivazione.ItemIndex];
      end;
    end;
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TWM014FRicTimbratureFM.OkRichiesta;
var
  LResCtrl: TResCtrl;
  LRisposteMsg: TRisposteMsg;
  LRisposta: String;
  LModalResult: Integer;
begin
  try
    with WM000FMainModule do
      LResCtrl:=WM014RicTimbratureMW.InserisciRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

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

        with WM014RicTimbratureMW do
        begin
          if Assigned(DatiTimbratura.RisposteMsg) then
            FreeAndNil(DatiTimbratura.RisposteMsg);
          DatiTimbratura.RisposteMsg:=LRisposteMsg.Clone;
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

function TWM014FRicTimbratureFM.ControllaEliminaRichiesta: TResCtrl;
begin
  Result.Clear;
  Result.Ok:=True;
end;

procedure TWM014FRicTimbratureFM.EliminaRichiesta;
var LResCtrl: TResCtrl;
    LRisposteMsg: TRisposteMsg;
begin

  with WM000FMainModule do
    LResCtrl:=WM014RicTimbratureMW.EliminaRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

  if LResCtrl.Ok then
  begin
    ShowMessage('Richiesta eliminata');

    LResCtrl:=AggiornaListaRichieste;
    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);

    tpnlRichieste.First;
  end
  else
    ShowMessage(LResCtrl.Messaggio);
end;

function TWM014FRicTimbratureFM.ControllaRevocaRichiesta: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='Operazione non ancora disponibile';
end;

procedure TWM014FRicTimbratureFM.RevocaRichiesta;
begin
  inherited;
  // funzionalità non richiesta
end;

function TWM014FRicTimbratureFM.GetMsgOkRichiesta: String;
begin
  if WM014RicTimbratureMW.OperazioneTimbratura = Elimina then
    Result:='Confermare l''inserimento della richiesta di eliminazione?'
  else
    Result:=inherited;
end;

initialization
  RegisterClass(TWM014FRicTimbratureFM);

end.
