unit AR002URichiesteFM;

interface

uses
  A000UCostanti,
  AR001UBaseFM,
  AM000UConstants,
  AM000UCommonInterface,
  AM000UMessageManager,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  B110USharedTypes,
  B110USharedUtils,
  AM000UTypes,
  AM000UUtils,
  System.Math,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Messaging,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Grid.Style, FireDAC.Stan.Intf, System.DateUtils, FMX.Fontawesome,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ScrollBox, FMX.Grid,
  FMX.Controls.Presentation, FMX.DialogService, Data.FireDACJSONReflect,
  FMX.Objects, FMX.Layouts, FMX.Ani, FMX.Effects, FMX.ListBox,
  Data.Bind.GenData, Data.Bind.ObjectScope, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.MultiView, Fmx.Bind.Navigator, FMX.Utils,
  System.StrUtils, FMX.DateTimeCtrls, FMX.Memo, FMX.TabControl, System.Actions,
  FMX.ActnList;

type
  TAR002FRichiesteFM = class(TAR001FBaseFM,IFrameView)
    pnlFiltriRichieste: TPanel;
    fmtRichieste: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    pnlTipoRichieste: TPanel;
    rbnDaAutorizzare: TRadioButton;
    rbnAutorizzate: TRadioButton;
    rbnNegate: TRadioButton;
    lytFiltroPeriodo: TFlowLayout;
    edtPeriodoDa: TDateEdit;
    Label1: TLabel;
    edtPeriodoA: TDateEdit;
    tabMain: TTabControl;
    tabElenco: TTabItem;
    tabDettaglio: TTabItem;
    tabNote: TTabItem;
    tabNoteDett: TTabItem;
    tlbDettaglio: TToolBar;
    btnGotoElenco: TSpeedButton;
    lblRichiestaNum: TLabel;
    btnRichiestaPrec: TSpeedButton;
    btnRichiestaSucc: TSpeedButton;
    lstDettaglio: TListView;
    tlbElenco: TToolBar;
    lblNumRichieste: TLabel;
    lstRichieste: TListView;
    tlbNote: TToolBar;
    btnGotoDettaglio: TSpeedButton;
    lblTabNote: TLabel;
    lstNote: TListView;
    tlbDettaglioNote: TToolBar;
    btnGotoNote: TSpeedButton;
    lblNoteInfoLivello: TLabel;
    btnSalvaNote: TSpeedButton;
    lblNoteNominativo: TLabel;
    memNoteTesto: TMemo;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    procedure rbnDaAutorizzareClick(Sender: TObject);
    procedure lstRichiestePullRefresh(Sender: TObject);
    procedure lstRichiesteItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btnRichiestaPrecClick(Sender: TObject);
    procedure btnRichiestaSuccClick(Sender: TObject);
    procedure fmtRichiesteAfterScroll(DataSet: TDataSet);
    procedure lstDettaglioItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btnSalvaNoteClick(Sender: TObject);
    procedure lstNoteItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure memNoteTestoChangeTracking(Sender: TObject);
    procedure lstDettaglioUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure lstNoteUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
    procedure tabMainChange(Sender: TObject);
    procedure edtPeriodoDaClosePicker(Sender: TObject);
    procedure edtPeriodoAClosePicker(Sender: TObject);
  private
    FRichiesteTotali: Integer;
    FC018Revocabile: Boolean;
    procedure AggiornaElencoUI;
    procedure DoAggiornaNote;
    function  GetNoteRichiestaSRV(const PId: Integer; var RNoteRichiesta: TNoteRichiesta): TResCtrl;
    procedure AggiornaNoteUI(PNoteRichiesta: TNoteRichiesta);
    procedure DoImpostaNote(const PNote: String);
    function  ImpostaNoteSRV(PId: Integer; PNoteLivello: TNoteLivello): TResCtrl;
  protected
    FIter: String;
    FFiltriRichieste: TFiltriRichieste;
    FRichiesteOnline: Boolean;
    FCurrentId: Integer;

    { IFrameView }
    procedure CreateFrame; virtual;
    procedure DestroyFrame; virtual;
    procedure ShowFrame; virtual;
    procedure HideFrame; virtual;
    procedure ResizeFrame; virtual;
    function IsBackButtonAllowed: Boolean; virtual;
    procedure OnBackButton; virtual;
    procedure PauseWork; virtual;
    procedure ResumeWork; virtual;

    procedure ApplicaTema; override;

    procedure DoAggiornaRichieste; virtual; final;
    procedure SetRichiesteTotali(const Value: Integer); virtual; final;
    procedure SetC018Revocabile(const Value: Boolean); virtual; final;

    procedure TabElencoAggiornaFiltriUI; virtual; final;
    procedure TabDettaglioAggiornaUI; virtual;

    // da ridefinire
    procedure DettaglioItemClick(const AItem: TListViewItem; var RHandled: Boolean); virtual;

    // metodi astratti da definire nella sottoclasse
    function AggiornaRichiesteSRV(PFiltri: TFiltriRichieste): TResCtrl; virtual; abstract;
    procedure TabElencoAggiornaListaUI; virtual; abstract;
    procedure TabDettaglioAggiornaRecord; virtual; abstract;

    property RichiesteTotali: Integer read FRichiesteTotali write SetRichiesteTotali;
    property C018Revocabile: Boolean read FC018Revocabile write SetC018Revocabile;
  const
    ITEM_MORE_DETAILS          = '(...)';
    ITEM_TIPO_RICHIESTA_TEXT   = 'Tipo richiesta';
    ITEM_DATA_RICHIESTA_TEXT   = 'Data richiesta';
    ITEM_NOTE_TEXT             = 'Note';
    ITEM_MOTIVAZIONE_TEXT      = 'Motivazione';
  end;

implementation

uses
  AM000UMain,
  AM000UClientModule,
  System.TypInfo;

{$R *.fmx}

procedure TAR002FRichiesteFM.CreateFrame;
begin
  // inizializza l'oggetto filtri richieste
  FFiltriRichieste:=TFiltriRichieste.Create('trDaAutorizzare',DATE_MIN,DATE_MAX,IncMonth(Date,-1),Date,0);
  FRichiesteTotali:=0;
  FRichiesteOnline:=False;
  FIter:='';

  tabMain.TabPosition:=TTabPosition.None;

  // elenco
  tlbElenco.TintColor:=BACKGROUND_COLOR;
  lblNumRichieste.TextSettings.FontColor:=FONT_COLOR_HEADER;

  // dettaglio
  tlbDettaglio.TintColor:=BACKGROUND_COLOR;
  btnGotoElenco.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnGotoElenco.Text:=fa_arrow_left;
  lblRichiestaNum.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnRichiestaPrec.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnRichiestaPrec.Text:=fa_caret_up;
  btnRichiestaSucc.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnRichiestaSucc.Text:=fa_caret_down;

  // note
  tlbNote.TintColor:=BACKGROUND_COLOR;
  btnGotoDettaglio.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnGotoDettaglio.Text:=fa_arrow_left;
  lblTabNote.TextSettings.FontColor:=FONT_COLOR_HEADER;

  // dettaglio note
  tlbDettaglioNote.TintColor:=BACKGROUND_COLOR;
  btnGotoNote.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnGotoNote.Text:=fa_arrow_left;
  lblNoteInfoLivello.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnSalvaNote.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnSalvaNote.Text:=fa_check_circle;
end;

procedure TAR002FRichiesteFM.DestroyFrame;
begin
  FreeAndNil(FFiltriRichieste);
end;

procedure TAR002FRichiesteFM.ShowFrame;
begin
  if FIter = '' then
    raise Exception.Create('Nell''evento CreateFrame è necessario impostare il field FIter!');

  // visualizza l'elenco delle richieste
  tabMain.ActiveTab:=tabElenco;

  // mantiene coerente l'interfaccia con l'oggetto FiltriRichieste
  TabElencoAggiornaFiltriUI;

  // aggiorna elenco richieste
  DoAggiornaRichieste;
end;

procedure TAR002FRichiesteFM.HideFrame;
begin

end;

function TAR002FRichiesteFM.IsBackButtonAllowed: Boolean;
begin
  Result:=(tabMain.TabIndex = 0);
end;

procedure TAR002FRichiesteFM.OnBackButton;
begin
  if tabMain.TabIndex > 0 then
    tabMain.Previous;
end;

procedure TAR002FRichiesteFM.PauseWork;
begin

end;

procedure TAR002FRichiesteFM.ResizeFrame;
begin

end;

procedure TAR002FRichiesteFM.ResumeWork;
begin

end;

procedure TAR002FRichiesteFM.SetRichiesteTotali(const Value: Integer);
begin
  FRichiesteTotali:=Value;
end;

procedure TAR002FRichiesteFM.SetC018Revocabile(const Value: Boolean);
begin
  FC018Revocabile:=Value;
end;


procedure TAR002FRichiesteFM.ApplicaTema;
begin
  inherited;


end;

// ########################################################################## //
// ###                        R I C H I E S T E                           ### //
// ########################################################################## //

procedure TAR002FRichiesteFM.fmtRichiesteAfterScroll(DataSet: TDataSet);
begin
  FCurrentId:=0;

  // aggiorna il pannello di dettaglio
  if not fmtRichieste.Active then
    Exit;

  TabDettaglioAggiornaUI;

  // forza impostazione tema
  ApplicaTema;
end;

procedure TAR002FRichiesteFM.DoAggiornaRichieste;
var
  LResCtrl: TResCtrl;
begin
  // azzera conteggi
  FRichiesteTotali:=0;
  if (fmtRichieste.Active) and (fmtRichieste.RecordCount > 0) then
    FCurrentId:=fmtRichieste.FieldByName('ID').AsInteger
  else
    FCurrentId:=0;

  // pulisce elenco richieste
  lblNumRichieste.Text:='';
  lstRichieste.Items.Clear;

  // disabilita interazioni ui
  fmtRichieste.DisableControls;
  fmtRichieste.AfterScroll:=nil;

  TAsync.Async(
    TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
    procedure
    begin
      // aggiornamento dataset richieste
      LResCtrl:=AggiornaRichiesteSRV(FFiltriRichieste);
      FRichiesteOnline:=LResCtrl.Ok;
    end
  ).Await(
    procedure
    begin
      // abilita interazioni ui
      fmtRichieste.EnableControls;
      fmtRichieste.AfterScroll:=fmtRichiesteAfterScroll;

      // aggiorna il tab di elenco
      if LResCtrl.Ok then
      begin
        AggiornaElencoUI;
        ApplicaTema;
      end
      else
        MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
    end
  );
end;

procedure TAR002FRichiesteFM.AggiornaElencoUI;
begin
  // pulisce elenco richieste
  lstRichieste.Items.Clear;

  // 1a. intestazione
  if not fmtRichieste.Active then
  begin
    lblNumRichieste.Text:='Elenco non disponibile';
  end
  else if fmtRichieste.RecordCount = 0 then
  begin
    lblNumRichieste.Text:='Nessuna richiesta';
  end
  else
  begin
    lblNumRichieste.Text:=Format('%d %s',[FRichiesteTotali,IfThen(FRichiesteTotali = 1,'richiesta','richieste')]);
    if FRichiesteTotali > fmtRichieste.RecordCount then
      lblNumRichieste.Text:=lblNumRichieste.Text + Format(' (%d visualizzate)',[fmtRichieste.RecordCount]);
  end;

  // 1b. pannello filtri
  TabElencoAggiornaFiltriUI;

  // 2. elenco richieste
  fmtRichieste.DisableControls;
  fmtRichieste.AfterScroll:=nil;
  lstRichieste.BeginUpdate;
  try
    lstRichieste.Items.Clear;

    // procedure ridefinita nella sottoclasse
    if (fmtRichieste.Active) and (fmtRichieste.RecordCount > 0) then
      TabElencoAggiornaListaUI;
  finally
    lstRichieste.EndUpdate;
    fmtRichieste.EnableControls;
    fmtRichieste.AfterScroll:=fmtRichiesteAfterScroll;

    ApplicaTema;

    // se non ci sono richieste disponibili e la vista attiva è il dettaglio, torna sull'elenco
    if fmtRichieste.RecordCount = 0 then
    begin
      if tabMain.ActiveTab = tabDettaglio then
        tabMain.SetActiveTabMedp(tabElenco,TTabTransition.Slide);
    end
    else
    begin
      // riposizionamento sul record precedente all'aggiornamento
      if FCurrentId > 0 then
        fmtRichieste.Locate('ID',FCurrentId,[]);
    end;
  end;
end;

procedure TAR002FRichiesteFM.tabMainChange(Sender: TObject);
begin
  // imposta il titolo del tab corrente
  TabTitle:=tabMain.ActiveTab.Text;

  // richiesta aggiornamento ui
  MessageManager.SendMessage(nil,TAggiornaUIMessage.Create('on tabMainChange'));
end;


procedure TAR002FRichiesteFM.TabDettaglioAggiornaUI;
var
  LItem: TListViewItem;
  LDataRichiesta: TDateTime;
  LDescMotivazioneRichiesta: String;
begin
  // 1. intestazione
  btnRichiestaPrec.Visible:=False;
  btnRichiestaSucc.Visible:=False;
  if not fmtRichieste.Active then
  begin
    lblRichiestaNum.Text:='Dati non disponibili';
  end
  else if fmtRichieste.RecordCount = 0 then
  begin
    lblRichiestaNum.Text:='Nessuna richiesta';
  end
  else
  begin
    lblRichiestaNum.Text:=Format('Richiesta %d di %d',[fmtRichieste.RecNo,fmtRichieste.RecordCount]);
    btnRichiestaPrec.Visible:=(fmtRichieste.RecordCount > 1);
    btnRichiestaSucc.Visible:=(fmtRichieste.RecordCount > 1);
    btnRichiestaPrec.Enabled:=fmtRichieste.RecNo > 1;
    btnRichiestaSucc.Enabled:=fmtRichieste.RecNo < fmtRichieste.RecordCount;
  end;

  // 2. dettaglio (listview)
  lstDettaglio.BeginUpdate;
  try
    lstDettaglio.Items.Clear;

    if (fmtRichieste.Active) and
       (fmtRichieste.RecordCount > 0) then
    begin
      // elementi comuni in cima alla lista
      // nessuno

      // elementi di dettaglio specifici
      TabDettaglioAggiornaRecord;

      // elementi comuni in fondo alla lista

      // data richiesta
      LDataRichiesta:=fmtRichieste.FieldByName('DATA_RICHIESTA').AsDateTime;
      LItem:=lstDettaglio.Items.Add;
      LItem.Text:=ITEM_DATA_RICHIESTA_TEXT;
      LItem.Detail:=FormatDateTime('dd/mm/yyyy hh:mm',LDataRichiesta);

      // id richiesta
      {
      LItem:=lstDettaglio.Items.Add;
      LItem.Text:='ID richiesta';
      LItem.Detail:=LID.ToString;
      }

      // note richiesta
      LItem:=lstDettaglio.Items.Add;
      LItem.Text:=ITEM_NOTE_TEXT;
      LItem.Detail:=ITEM_MORE_DETAILS;

      // motivazione richiesta (se il dato è disponibile)
      if (fmtRichieste.FindField('MOTIVAZIONE') <> nil) and
         (fmtRichieste.FindField('D_MOTIVAZIONE') <> nil) then
      begin
        LDescMotivazioneRichiesta:=fmtRichieste.FieldByName('D_MOTIVAZIONE').AsString;
        LItem:=lstDettaglio.Items.Add;
        LItem.Text:=ITEM_MOTIVAZIONE_TEXT;
        LItem.Detail:=LDescMotivazioneRichiesta;
      end;
    end;
  finally
    lstDettaglio.EndUpdate;
    ApplicaTema;
  end;
end;



// ########################################################################## //
// ###                             N O T E                                ### //
// ########################################################################## //

function TAR002FRichiesteFM.GetNoteRichiestaSRV(const PId: Integer; var RNoteRichiesta: TNoteRichiesta): TResCtrl;
var
  LRes: TRisultato;
begin
  // legge le note della richiesta corrente
  LRes:=AM000FClientModule.B110FServerMethodsDMClient
          .NoteRichiesta(AM000FMain.InfoClient.PrepareForServer,
                         AM000FMain.ParametriLogin.PrepareForServer,
                         PId,
                         '');

  Result:=LRes.Check(TNoteRichiesta);
  if not Result.Ok then
    Exit;

  // valore di output
  RNoteRichiesta:=(LRes.Output as TNoteRichiesta);

  // operazione ok
  Result.Ok:=True;
end;

procedure TAR002FRichiesteFM.AggiornaNoteUI(PNoteRichiesta: TNoteRichiesta);
var
  LLivello: Integer;
  LItem: TListViewItem;
  LNoteLivello: TNoteLivello;
  i: Integer;
begin
  LLivello:=fmtRichieste.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;

  lstNote.Tag:=LLivello;
  lstNote.BeginUpdate;
  try
    lstNote.Items.Clear;
    for i:=Low(PNoteRichiesta.NoteArr) to High(PNoteRichiesta.NoteArr) do
    begin
      LNoteLivello:=PNoteRichiesta.NoteArr[i];

      // intestazione: descrizione livello e nominativo
      LItem:=lstNote.Items.Add;
      LItem.Text:=LNoteLivello.GetIntestazione;
      LItem.Purpose:=TListItemPurpose.Header;

      // note e dettaglio di autorizzazione
      LItem:=lstNote.Items.Add;
      LItem.Text:=LNoteLivello.GetNoteVis;
      LItem.Detail:=LNoteLivello.GetAutorizzazione + '  ' +
                    IfThen((Abilitazione = 'S') and (LLivello = LNoteLivello.Livello),
                           fa_pencil_square_o,
                           fa_eye);
      LItem.Tag:=LNoteLivello.Livello;
      LItem.ButtonText:=Format('%s|%s',[LNoteLivello.GetDescLivello,LNoteLivello.Nominativo]);
    end;
  finally
    lstNote.EndUpdate;
    ApplicaTema;
  end;
end;

procedure TAR002FRichiesteFM.DoAggiornaNote;
var
  LIdRichiesta: Integer;
  LNoteRichiesta: TNoteRichiesta;
  LResCtrl: TResCtrl;
begin
  // imposta variabili
  LIdRichiesta:=fmtRichieste.FieldByName('ID').AsInteger;

  TAsync.Async(
    TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
    procedure
    begin
      // legge le note della richiesta
      LResCtrl:=GetNoteRichiestaSRV(LIdRichiesta,LNoteRichiesta);
    end
  ).Await(
    procedure
    begin
      if LResCtrl.Ok then
      begin
        AggiornaNoteUI(LNoteRichiesta);

        // visualizza il pannello note
        tabMain.SetActiveTabMedp(tabNote,TTabTransition.Slide);
      end
      else
        MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
    end
  );
end;

function TAR002FRichiesteFM.ImpostaNoteSRV(PId: Integer; PNoteLivello: TNoteLivello): TResCtrl;
var
  LRes: TRisultato;
begin
  // imposta le note
  LRes:=AM000FClientModule.B110FServerMethodsDMClient
          .SetNoteRichiesta(AM000FMain.InfoClient.PrepareForServer,
                            AM000FMain.ParametriLogin.PrepareForServer,
                            PId,
                            PNoteLivello,
                            '');
  // verifica risultato
  Result:=LRes.Check(nil);
end;

procedure TAR002FRichiesteFM.DoImpostaNote(const PNote: String);
var
  LIdRichiesta: Integer;
  LResCtrl: TResCtrl;
  LLivello: Integer;
  LNoteLivello: TNoteLivello;
  LNoteRichiesta: TNoteRichiesta;
begin
  // salva dati della richiesta
  LIdRichiesta:=fmtRichieste.FieldByName('ID').AsInteger;
  LLivello:=fmtRichieste.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
  LNoteLivello:=TNoteLivello.Create;
  LNoteLivello.Livello:=LLivello;
  LNoteLivello.Note:=PNote;

  // effettua operazione
  TAsync.Async(
    TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
    procedure
    begin
      // impostazione note
      LResCtrl:=ImpostaNoteSRV(LIdRichiesta,LNoteLivello);

      // refresh note
      if LResCtrl.Ok then
        LResCtrl:=GetNoteRichiestaSRV(LIdRichiesta,LNoteRichiesta);
    end
  ).Await(
    procedure
    begin
      // visualizza le note
      if LResCtrl.Ok then
      begin
        AggiornaNoteUI(LNoteRichiesta);
        tabMain.SetActiveTabMedp(tabNote,TTabTransition.Slide);
        MessageManager.SendMessage(nil,TBannerMessage.CreateInfo('Note salvate'));
      end
      else
      begin
        MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
      end;
    end
  );
end;



// ########################################################################## //
// ###                       I N T E R F A C C I A                        ### //
// ########################################################################## //

procedure TAR002FRichiesteFM.TabElencoAggiornaFiltriUI;
var
  LOldOnPeriodoDaChange: TNotifyEvent;
  LOldOnPeriodoAChange: TNotifyEvent;
begin
  // mantiene coerente il radiobutton selezionato
  if FFiltriRichieste.FiltroVis = 'trDaAutorizzare' then
    rbnDaAutorizzare.IsChecked:=True
  else if FFiltriRichieste.FiltroVis = 'trAutorizzate' then
    rbnAutorizzate.IsChecked:=True
  else if FFiltriRichieste.FiltroVis = 'trNegate' then
    rbnNegate.IsChecked:=True;

  // periodo di ricerca
  lytFiltroPeriodo.Visible:=(FFiltriRichieste.FiltroVis <> 'trDaAutorizzare');
  pnlFiltriRichieste.Height:=pnlTipoRichieste.Height + IfThen(lytFiltroPeriodo.Visible,lytFiltroPeriodo.Height);

  LOldOnPeriodoDaChange:=edtPeriodoDa.OnChange;
  edtPeriodoDa.OnChange:=nil;
  try
    edtPeriodoDa.Date:=FFiltriRichieste.PeriodoDa;
  finally
    edtPeriodoDa.OnChange:=LOldOnPeriodoDaChange;
  end;

  LOldOnPeriodoAChange:=edtPeriodoA.OnChange;
  edtPeriodoA.OnChange:=nil;
  try
    edtPeriodoA.Date:=FFiltriRichieste.PeriodoA;
  finally
    edtPeriodoA.OnChange:=LOldOnPeriodoAChange;
  end;
end;

procedure TAR002FRichiesteFM.DettaglioItemClick(const AItem: TListViewItem; var RHandled: Boolean);
begin
  RHandled:=False;

  if AItem.Text = ITEM_NOTE_TEXT then
  begin
    RHandled:=True;

    DoAggiornaNote;
  end;
end;

procedure TAR002FRichiesteFM.rbnDaAutorizzareClick(Sender: TObject);
var
  LOldOnPeriodoDaChange: TNotifyEvent;
  LOldOnPeriodoAChange: TNotifyEvent;
begin
  if Sender = rbnDaAutorizzare then
    FFiltriRichieste.FiltroVis:='trDaAutorizzare'
  else if Sender = rbnAutorizzate then
    FFiltriRichieste.FiltroVis:='trAutorizzate'
  else if Sender = rbnNegate then
    FFiltriRichieste.FiltroVis:='trNegate';

  // periodo
  if FFiltriRichieste.FiltroVis = 'trDaAutorizzare' then
  begin
    // le richieste da autorizzare non prevedono restrizioni sul periodo o sul numero di record
    if FFiltriRichieste.PeriodoDa > DATE_MIN then
      FFiltriRichieste.PeriodoDaOriginale:=FFiltriRichieste.PeriodoDa;
    if FFiltriRichieste.PeriodoA < DATE_MAX then
      FFiltriRichieste.PeriodoAOriginale:=FFiltriRichieste.PeriodoA;
    FFiltriRichieste.PeriodoDa:=DATE_MIN;
    FFiltriRichieste.PeriodoA:=DATE_MAX;
    FFiltriRichieste.LimiteRecord:=0;
  end
  else
  begin
    if FFiltriRichieste.PeriodoDa = DATE_MIN then
      FFiltriRichieste.PeriodoDa:=FFiltriRichieste.PeriodoDaOriginale;
    if FFiltriRichieste.PeriodoA = DATE_MAX then
      FFiltriRichieste.PeriodoA:=FFiltriRichieste.PeriodoAOriginale;
    FFiltriRichieste.LimiteRecord:=LIMITE_RICHIESTE_VISUALIZZATE;
  end;

  lytFiltroPeriodo.Visible:=(FFiltriRichieste.FiltroVis <> 'trDaAutorizzare');
  pnlFiltriRichieste.Height:=pnlTipoRichieste.Height + IfThen(lytFiltroPeriodo.Visible,lytFiltroPeriodo.Height);

  // se il layout periodo è visibile mantiene coerenti le date visualizzate con le relative variabili
  if lytFiltroPeriodo.Visible then
  begin
    LOldOnPeriodoDaChange:=edtPeriodoDa.OnChange;
    edtPeriodoDa.OnChange:=nil;
    try
      edtPeriodoDa.Date:=FFiltriRichieste.PeriodoDa;
    finally
      edtPeriodoDa.OnChange:=LOldOnPeriodoDaChange;
    end;

    LOldOnPeriodoAChange:=edtPeriodoA.OnChange;
    edtPeriodoA.OnChange:=nil;
    try
      edtPeriodoA.Date:=FFiltriRichieste.PeriodoA;
    finally
      edtPeriodoA.OnChange:=LOldOnPeriodoAChange;
    end;
  end;

  DoAggiornaRichieste;
end;

procedure TAR002FRichiesteFM.edtPeriodoDaClosePicker(Sender: TObject);
begin
  FFiltriRichieste.PeriodoDa:=edtPeriodoDa.Date;
  FFiltriRichieste.PeriodoDaOriginale:=FFiltriRichieste.PeriodoDa;

  DoAggiornaRichieste;
end;

procedure TAR002FRichiesteFM.edtPeriodoAClosePicker(Sender: TObject);
begin
  FFiltriRichieste.PeriodoA:=edtPeriodoA.Date;
  FFiltriRichieste.PeriodoAOriginale:=FFiltriRichieste.PeriodoA;

  DoAggiornaRichieste;
end;

procedure TAR002FRichiesteFM.lstDettaglioItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LHandled: Boolean;
begin
  DettaglioItemClick(AItem,LHandled);
end;

procedure TAR002FRichiesteFM.lstDettaglioUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
begin
  AItem.Objects.TextObject.Height:=AItem.Height;
  AItem.Objects.DetailObject.Height:=AItem.Height;
  AItem.Objects.AccessoryObject.Height:=AItem.Height;
  AItem.Objects.AccessoryObject.Visible:=AItem.Detail = ITEM_MORE_DETAILS;
end;

procedure TAR002FRichiesteFM.lstRichiesteItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if not fmtRichieste.Active then
  begin
    // segnalazione problema
    MessageManager.SendMessage(nil,TBannerMessage.CreateWarning('Aggiornare l''elenco delle richieste prima di procedere'));
    Exit;
  end;

  // posizionamento del dataset sulla richiesta selezionata
  fmtRichieste.Locate('ID',AItem.Detail.ToInteger,[]);

  // visualizza il pannello dettaglio
  tabMain.SetActiveTabMedp(tabDettaglio,TTabTransition.Slide);
end;

procedure TAR002FRichiesteFM.lstRichiestePullRefresh(Sender: TObject);
begin
  DoAggiornaRichieste;
end;

procedure TAR002FRichiesteFM.memNoteTestoChangeTracking(Sender: TObject);
begin
  btnSalvaNote.Enabled:=memNoteTesto.Text <> memNoteTesto.Hint;
end;

procedure TAR002FRichiesteFM.btnRichiestaPrecClick(Sender: TObject);
begin
  fmtRichieste.Prior;
end;

procedure TAR002FRichiesteFM.btnRichiestaSuccClick(Sender: TObject);
begin
  fmtRichieste.Next;
end;

procedure TAR002FRichiesteFM.btnSalvaNoteClick(Sender: TObject);
var
  LNoteLivello: String;
begin
  LNoteLivello:=memNoteTesto.Text.Trim;
  DoImpostaNote(LNoteLivello);
end;

procedure TAR002FRichiesteFM.lstNoteItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LNoteModificabili: Boolean;
  LNoteOrig: String;
  LInfo: String;
  LArrInfo: TArray<String>;
begin
  // note modificabili solo se si dispone dell'abilitazione in scrittura e si sta operando al proprio livello
  LNoteModificabili:=(Abilitazione = 'S') and (lstNote.Tag = AItem.Tag);

  // informazioni sulle note
  LInfo:=AItem.ButtonText;
  LArrInfo:=LInfo.Split(['|']);
  if Length(LArrInfo) > 0 then
  begin
    // livello
    lblNoteInfoLivello.Text:=LArrInfo[0];

    // nominativo
    if Length(LArrInfo) > 1 then
      lblNoteNominativo.Text:=Format('Note di %s',[LArrInfo[1]])
    else
      lblNoteNominativo.Text:='Note';
  end;

  // testo delle note
  LNoteOrig:=IfThen(AItem.Text = '(nessuna nota)','',AItem.Text);
  memNoteTesto.Text:=LNoteOrig;
  memNoteTesto.Hint:=LNoteOrig;
  memNoteTesto.ShowHint:=False;
  memNoteTesto.ReadOnly:=not LNoteModificabili;
  memNoteTesto.Repaint;

  // pulsante di salvataggio note (si abilita solo nel momento in cui l'utente modifica il testo nel memo)
  btnSalvaNote.Visible:=LNoteModificabili;
  btnSalvaNote.Enabled:=False;

  tabMain.SetActiveTabMedp(tabNoteDett,TTabTransition.Slide);
end;

procedure TAR002FRichiesteFM.lstNoteUpdateObjects(const Sender: TObject; const AItem: TListViewItem);
begin
  // label del dettaglio (text object)
  AItem.Objects.TextObject.Height:=AItem.Height;
  if AItem.Purpose = TListItemPurpose.Header then
  begin
    AItem.Objects.TextObject.TextColor:=FONT_COLOR_LABEL;
  end
  else
  begin
    // testo della nota
    AItem.Objects.TextObject.TextColor:=FONT_COLOR_DEFAULT;

    // dettaglio
    AItem.Objects.DetailObject.Height:=AItem.Height;
  end;
end;

end.
