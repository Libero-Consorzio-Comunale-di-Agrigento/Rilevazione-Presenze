unit AR003UGestRichiesteFM;

interface

uses
  A000UCostanti,
  AR001UBaseFM,
  AR002URichiesteFM,
  AM000UConstants,
  AM000UCommonInterface,
  AM000UMessageManager,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  B110USharedTypes,
  B110USharedUtils,
  AM000UTypes,
  AM000UUtils,
  FMX.FontAwesome,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Ani, FMX.Objects, FMX.Layouts,
  FMX.ScrollBox, FMX.Memo, FMX.ListView, FMX.DateTimeCtrls,
  FMX.Controls.Presentation, System.Messaging, System.Actions, FMX.ActnList,
  FMX.TabControl;

type
  TAR003FGestRichiesteFM = class(TAR002FRichiesteFM,IFrameView)
    tabNuovaRichiesta: TTabItem;
    btnNuovaRichiesta: TSpeedButton;
    lytGestRichiesta: TGridPanelLayout;
    btnSalvaRichiesta: TSpeedButton;
    btnAnnullaRichiesta: TSpeedButton;
    btnEliminaRichiesta: TSpeedButton;
    btnRevocaRichiesta: TSpeedButton;
    lblbtnEliminaRichiesta: TLabel;
    lblbtnRevocaRichiesta: TLabel;
    lblbtnSalvaRichiesta: TLabel;
    lblbtnAnnullaRichiesta: TLabel;
    procedure btnSalvaRichiestaClick(Sender: TObject);
    procedure btnAnnullaRichiestaClick(Sender: TObject);
    procedure btnNuovaRichiestaClick(Sender: TObject);
    procedure btnEliminaRichiestaClick(Sender: TObject);
    procedure btnRevocaRichiestaClick(Sender: TObject);
  private
    FDirtyFlagNuovaRichiesta: Boolean;
    procedure SetDirtyFlagNuovaRichiesta(Value: Boolean);
    procedure OnConfermaSalvaRichiesta(const AResult: System.UITypes.TModalResult);
    procedure OnConfermaEliminaRichiesta(const AResult: System.UITypes.TModalResult);
    procedure OnConfermaRevocaRichiesta(const AResult: System.UITypes.TModalResult);
  protected
    { IFrameView }
    procedure CreateFrame; override;
    procedure DestroyFrame; override;
    procedure ShowFrame; override;
    procedure HideFrame; override;
    procedure ResizeFrame; override;
    function IsBackButtonAllowed: Boolean; override;
    procedure OnBackButton; override;
    procedure PauseWork; override;
    procedure ResumeWork; override;

    procedure TabDettaglioAggiornaUI; override;

    // metodi da ridefinire
    procedure OnNuovaRichiesta; virtual; abstract;
    procedure OnDirtyFlagNuovaRichiestaChanged; virtual; abstract;
    procedure OnGetMsgConfermaRichiesta(var RMsgConferma: String); virtual;
    function ControllaRichiesta: TResCtrl; virtual; abstract;
    procedure DoSalvaRichiesta; virtual; abstract;
    procedure DoAnnullaSalvaRichiesta; virtual;
    function ControllaEliminaRichiesta: TResCtrl; virtual; abstract;
    procedure DoEliminaRichiesta; virtual; abstract;
    function ControllaRevocaRichiesta: TResCtrl; virtual; abstract;
    procedure DoRevocaRichiesta; virtual; abstract;

    property DirtyFlagNuovaRichiesta: Boolean read FDirtyFlagNuovaRichiesta write SetDirtyFlagNuovaRichiesta;
  end;

implementation

{$R *.fmx}

uses
  AM000UMain,
  AM000UClientModule;

procedure TAR003FGestRichiesteFM.CreateFrame;
begin
  inherited;

  FDirtyFlagNuovaRichiesta:=False;

  btnNuovaRichiesta.TextSettings.FontColor:=FONT_COLOR_HEADER;
  btnNuovaRichiesta.Text:=fa_plus_circle;

  lblbtnEliminaRichiesta.Text:=fa_trash;
  lblbtnRevocaRichiesta.Text:=fa_times_circle;

  lblbtnSalvaRichiesta.Text:=fa_check_circle;
  lblbtnAnnullaRichiesta.Text:=fa_times_circle;
end;

procedure TAR003FGestRichiesteFM.DestroyFrame;
begin
  inherited;

end;

procedure TAR003FGestRichiesteFM.ShowFrame;
begin
  inherited;

  // gestione abilitazione componenti
  btnNuovaRichiesta.Visible:=Abilitazione = 'S';
  btnEliminaRichiesta.Visible:=False;
  btnRevocaRichiesta.Visible:=False;
end;

procedure TAR003FGestRichiesteFM.HideFrame;
begin
  inherited;

end;

function TAR003FGestRichiesteFM.IsBackButtonAllowed: Boolean;
begin
  if tabMain.ActiveTab = tabNuovaRichiesta then
    Result:=False
  else
    Result:=inherited;
end;

procedure TAR003FGestRichiesteFM.OnBackButton;
begin
  if tabMain.ActiveTab = tabNuovaRichiesta then
  begin
    if not DirtyFlagNuovaRichiesta then
      tabMain.SetActiveTabMedp(tabElenco,TTabTransition.Slide,TTabTransitionDirection.Reversed);
  end
  else
    inherited;
end;

procedure TAR003FGestRichiesteFM.PauseWork;
begin
  inherited;

end;

procedure TAR003FGestRichiesteFM.ResizeFrame;
begin
  inherited;
end;

procedure TAR003FGestRichiesteFM.ResumeWork;
begin
  inherited;

end;

procedure TAR003FGestRichiesteFM.SetDirtyFlagNuovaRichiesta(Value: Boolean);
var
  LSignal: Boolean;
begin
  LSignal:=(Value <> FDirtyFlagNuovaRichiesta);
  FDirtyFlagNuovaRichiesta:=Value;
  if LSignal then
    OnDirtyFlagNuovaRichiestaChanged;
end;

procedure TAR003FGestRichiesteFM.TabDettaglioAggiornaUI;
begin
  inherited;

  if not fmtRichieste.Active then
    Exit;

  if fmtRichieste.RecordCount = 0 then
    Exit;

  // attiva possibilità di eliminare o revocare la richiesta
  btnEliminaRichiesta.Visible:=(Abilitazione = 'S') and (fmtRichieste.FieldByName('REVOCABILE').AsString = 'CANC');
  btnRevocaRichiesta.Visible:=(Abilitazione = 'S') and False;//fmtRichieste.FieldByName('REVOCABILE').AsString <> 'CANC';
end;

procedure TAR003FGestRichiesteFM.btnNuovaRichiestaClick(Sender: TObject);
begin
  if not FRichiesteOnline then
  begin
    MessageManager.SendMessage(nil,TBannerMessage.CreateWarning('Aggiornare l''elenco delle richieste prima di procedere'));
    Exit;
  end;

  // esegue operazioni per preparare la maschera di nuova richiesta
  OnNuovaRichiesta;

  // attiva il tab "nuova richiesta"
  tabMain.SetActiveTabMedp(tabNuovaRichiesta,TTabTransition.Slide);
  DirtyFlagNuovaRichiesta:=False;
end;

procedure TAR003FGestRichiesteFM.btnAnnullaRichiestaClick(Sender: TObject);
var
  LMsgConferma: String;
begin
  if DirtyFlagNuovaRichiesta then
  begin
    LMsgConferma:='Annullare la richiesta in fase di inserimento?';
    TAM000FUtils.MessageDialog(
      LMsgConferma,
      TMsgDlgTypeRec.Confirm,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        if AResult = mrYes then
        begin
          tabMain.SetActiveTabMedp(tabElenco,TTabTransition.Slide,TTabTransitionDirection.Reversed);
        end;
      end
    );
  end
  else
  begin
    tabMain.SetActiveTabMedp(tabElenco,TTabTransition.Slide,TTabTransitionDirection.Reversed);
  end;
end;

procedure TAR003FGestRichiesteFM.btnSalvaRichiestaClick(Sender: TObject);
var
  LMsgConferma: String;
begin
  // chiede conferma per l'operazione
  OnGetMsgConfermaRichiesta(LMsgConferma);

  // message dialog di conferma
  TAM000FUtils.MessageDialog(
    LMsgConferma,
    TMsgDlgTypeRec.Confirm,
    OnConfermaSalvaRichiesta
  );
end;

procedure TAR003FGestRichiesteFM.OnGetMsgConfermaRichiesta(var RMsgConferma: String);
begin
  RMsgConferma:='Confermare l''inserimento della richiesta?';
end;

procedure TAR003FGestRichiesteFM.OnConfermaSalvaRichiesta(const AResult: System.UITypes.TModalResult);
var
  LResCtrl: TResCtrl;
begin
  case AResult of
    mrYes:
      begin
        TAsync.Async(
          TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
          // controlli per inserimento richiesta
          procedure
          begin
            LResCtrl:=ControllaRichiesta;
          end
        ).Await(
          // inserimento richiesta
          procedure
          begin
            // verifica errori in fase di controllo
            if not LResCtrl.Ok then
            begin
              MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
              Exit;
            end;

            // inserimento richiesta
            DoSalvaRichiesta;
          end
        );
      end;
    mrNo:
      begin
        DoAnnullaSalvaRichiesta;
      end;
  end;
end;

procedure TAR003FGestRichiesteFM.DoAnnullaSalvaRichiesta;
begin
  // nessuna operazione in condizioni normali
  // ridefinire se necessario
end;

procedure TAR003FGestRichiesteFM.btnEliminaRichiestaClick(Sender: TObject);
var
  LMsgConferma: String;
begin
  // chiede conferma per l'operazione
  LMsgConferma:='Confermare l''eliminazione della richiesta visualizzata?';
  TAM000FUtils.MessageDialog(
    LMsgConferma,
    TMsgDlgTypeRec.Confirm,
    OnConfermaEliminaRichiesta
  );
end;

procedure TAR003FGestRichiesteFM.OnConfermaEliminaRichiesta(const AResult: System.UITypes.TModalResult);
var
  LResCtrl: TResCtrl;
begin
  if AResult = mrNo then
    Exit;

  TAsync.Async(
    TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
    // controlli per eliminazione
    procedure
    begin
      LResCtrl:=ControllaEliminaRichiesta;
    end
  ).Await(
    // eliminazione richiesta
    procedure
    begin
      // verifica risultato controlli
      if not LResCtrl.Ok then
      begin
        MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
        Exit;
      end;

      // eliminazione richiesta
      DoEliminaRichiesta;
    end
  );
end;

procedure TAR003FGestRichiesteFM.btnRevocaRichiestaClick(Sender: TObject);
var
  LMsgConferma: String;
begin
  // chiede conferma per l'operazione
  LMsgConferma:='Confermare la revoca della richiesta visualizzata?';
  TAM000FUtils.MessageDialog(
    LMsgConferma,
    TMsgDlgTypeRec.Confirm,
    OnConfermaRevocaRichiesta
  );
end;

procedure TAR003FGestRichiesteFM.OnConfermaRevocaRichiesta(const AResult: System.UITypes.TModalResult);
var
  LResCtrl: TResCtrl;
begin
  if AResult = mrNo then
    Exit;

  TAsync.Async(
    TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
    // controlli per revoca
    procedure
    begin
      LResCtrl:=ControllaRevocaRichiesta;
    end
  ).Await(
    // revoca richiesta
    procedure
    begin
      // verifica risultato controlli
      if not LResCtrl.Ok then
      begin
        MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
        Exit;
      end;

      // eliminazione richiesta
      DoRevocaRichiesta;
    end
  );
end;

end.
