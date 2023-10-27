unit AR004UAutRichiesteFM;

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
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FMX.Layouts, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.Ani, FMX.Objects, FMX.ScrollBox, FMX.Memo, FMX.ListView, FMX.Fontawesome,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, System.StrUtils, System.Messaging,
  System.Actions, FMX.ActnList, FMX.TabControl;type
  TAR004FAutRichiesteFM = class(TAR002FRichiesteFM)
    lytAutorizzazione: TGridPanelLayout;
    btnAutorizza: TSpeedButton;
    btnNega: TSpeedButton;
    lblbtnAutorizza: TLabel;
    lblbtnNega: TLabel;
    pnlAutorizzazione: TPanel;
    lblLivello: TLabel;
    fmtI096: TFDMemTable;
    procedure btnAutorizzaClick(Sender: TObject);
    procedure tabMainChange(Sender: TObject);
  private
    procedure ImpostaPannelloAutorizzazione;
    procedure OnResultConfermaAutorizzazione(Sender: TObject; const AResult: System.UITypes.TModalResult);
    procedure ImpostaAutorizzazione(const PAutorizzazione: String);
  protected
    { IFrameView }
    procedure CreateFrame; override;
    procedure ResizeFrame; override;

    { AR002 }
    procedure TabDettaglioAggiornaUI; override;

    // metodo da sovrascrivere nelle sottoclassi
    function AutorizzaRichiestaSRV(PId: Integer; PAut: String): TResCtrl; virtual; abstract;
  end;

implementation

uses
  AM000UMain,
  AM000UClientModule;{$R *.fmx}procedure TAR004FAutRichiesteFM.CreateFrame;
begin
  inherited;  lblbtnAutorizza.Text:=fa_thumbs_up;
  lblbtnNega.Text:=fa_thumbs_down;
end;procedure TAR004FAutRichiesteFM.ResizeFrame;
begin
  inherited;
  ImpostaPannelloAutorizzazione;
end;procedure TAR004FAutRichiesteFM.TabDettaglioAggiornaUI;
var
  LIter: String;
  LCodIter: String;
  LLivello: Integer;
  LDescLivello: String;
  LResCtrlI096: TResCtrl;
begin
  inherited;  // indicazione del livello utile di autorizzazione
  if (fmtRichieste.Active) and (fmtRichieste.RecordCount > 0) then
  begin
    LIter:=FIter;
    LCodIter:=fmtRichieste.FieldByName('COD_ITER').AsString;
    LLivello:=fmtRichieste.FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;    // decodifica descrizione livello tramite servizio
    TAsync.Async(
      TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
      procedure
      begin
        LResCtrlI096:=GetTabellaDizionarioSRV(fmtI096,B110_DIZ_TAB_I096,LIter,False);
      end
    ).Await(
      // visualizza descrizione livello
      procedure
      begin
        lblLivello.Text:=Format('Livello %d',[LLivello]);
        if LResCtrlI096.Ok then
        begin
          if not fmtI096.Active then
            fmtI096.Open;
          LDescLivello:=VarToStr(fmtI096.Lookup('COD_ITER;LIVELLO',VarArrayOf([LCodIter,Abs(LLivello)]),'DESC_LIVELLO'));
          if LDescLivello <> '' then
            lblLivello.Text:=Format('%s - %s',[lblLivello.Text,LDescLivello]);
        end;
      end
    );
  end;
end;
procedure TAR004FAutRichiesteFM.ImpostaPannelloAutorizzazione;
begin
  pnlAutorizzazione.Visible:=(Abilitazione = 'S') and (FFiltriRichieste.FiltroVis = 'trDaAutorizzare');
  pnlAutorizzazione.Enabled:=(pnlAutorizzazione.Visible) and (fmtRichieste.Active) and (fmtRichieste.RecordCount > 0);
end;



// ########################################################################## //
// ###                   A U T O R I Z Z A Z I O N E                      ### //
// ########################################################################## //
procedure TAR004FAutRichiesteFM.OnResultConfermaAutorizzazione(Sender: TObject; const AResult: System.UITypes.TModalResult);
var
  LAutorizzazione: String;
begin
  if AResult = mrYes then
  begin
    // determina il valore dell'autorizzazione
    if Sender = btnAutorizza then
      LAutorizzazione:='S'
    else if Sender = btnNega then
      LAutorizzazione:='N'
    else
      raise Exception.CreateFmt('Parametro Sender non valido: [%s]',[Sender.ToString]);
    // imposta l'autorizzazione scelta
    ImpostaAutorizzazione(LAutorizzazione);
    // segnala aggiornamento notifiche
    MessageManager.SendMessage(nil,TNotificheMessage.Create(TNotificheMessage.COUNT));
  end;
end;
procedure TAR004FAutRichiesteFM.ImpostaAutorizzazione(const PAutorizzazione: String);
var
  LResCtrl: TResCtrl;
  LTitolo: String;
  LMessaggio: String;
  LIdRichiesta: Integer;
begin
  if not((PAutorizzazione = 'S') or (PAutorizzazione = 'N')) then
    raise Exception.CreateFmt('Valore di autorizzazione non valido: [%s]',[PAutorizzazione]);
  // PRE:
  //  PAutorizzazione in  ['S','N']  LIdRichiesta:=fmtRichieste.FieldByName('ID').AsInteger;

  // determina il valore dell'autorizzazione
  if PAutorizzazione = 'S' then
  begin
    LTitolo:='Autorizzazione';
    LMessaggio:='Autorizzazione richiesta in corso...';
  end
  else
  begin
    LTitolo:='Negazione';
    LMessaggio:='Negazione richiesta in corso...';
  end;
  // effettua operazione
  TAsync.Async(
    TAsyncOptions.Create(TFeedbackType.FeedbackDisable),
    procedure
    begin
      // autorizzazione richiesta
      LResCtrl:=AutorizzaRichiestaSRV(LIdRichiesta,PAutorizzazione);
      // refresh richieste da autorizzare
      if LResCtrl.Ok then
      begin
        // disabilita interazioni ui
        fmtRichieste.DisableControls;
        fmtRichieste.AfterScroll:=nil;
        LResCtrl:=AggiornaRichiesteSRV(FFiltriRichieste);
      end;
    end
  ).Await(
    procedure
    begin
      // abilita interazioni ui
      fmtRichieste.EnableControls;
      fmtRichieste.AfterScroll:=fmtRichiesteAfterScroll;
      if LResCtrl.Ok then
      begin
        DoAggiornaRichieste;
        MessageManager.SendMessage(nil,TBannerMessage.CreateInfo(IfThen(PAutorizzazione = 'S','Richiesta autorizzata','Richiesta negata')));
        if fmtRichieste.RecordCount = 0 then
          MessageManager.SendMessage(nil,TBannerMessage.CreateInfo('Non ci sono altre richieste da autorizzare!'));
      end
      else
        MessageManager.SendMessage(nil,TBannerMessage.CreateError(LResCtrl.Messaggio));
    end
  );
end;


// ########################################################################## //
// ###                      I N T E R F A C C I A                         ### //
// ########################################################################## //

procedure TAR004FAutRichiesteFM.tabMainChange(Sender: TObject);
begin
  inherited;
  if tabMain.ActiveTab = tabDettaglio then
    ImpostaPannelloAutorizzazione;
end;procedure TAR004FAutRichiesteFM.btnAutorizzaClick(Sender: TObject);
var
  LMsgConferma: String;
begin
  if Sender = btnAutorizza then
    LMsgConferma:='Vuoi autorizzare questa richiesta?'
  else if Sender = btnNega then
    LMsgConferma:='Vuoi negare questa richiesta?'
  else
    raise Exception.CreateFmt('Parametro Sender non valido: [%s]',[Sender.ToString]);
  TAM000FUtils.MessageDialog(
    LMsgConferma,
    TMsgDlgTypeRec.Confirm,
    OnResultConfermaAutorizzazione,
    Sender
  );
end;end.