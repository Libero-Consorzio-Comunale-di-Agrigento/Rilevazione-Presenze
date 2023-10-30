unit WM003UAutAssenzeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR004UAutRichiesteFM,
  MedpUnimPanel2Button, uniLabel, unimLabel, MedpUnimLabel,
  MedpUnimPanelHeaderDett, MedpUnimPanelListaElem, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses,
  uniGUImJSForm, unimPanel, MedpUnimPanelBase, WM003UAutAssenzeMW, MedpUnimPanel4Labels, MedpUnimTypes,
  MedpUnimPanelDisclosure, WR004UCompetenzeMW, A000UCostanti, WM000UMainModule, MedpUnimPanel2Labels,
  MedpUnimPanelListaDettaglio, MedpUnimPanelListaDisclosure, MedpUnimPanel4LabelsIcon,
  MedpUnimPanelSlideUp, WR006UAllegatiMW, uniCheckBox, unimCheckBox,
  MedpUnimMemo, uniFileUpload, unimFileUpload, A000UInterfaccia, uniEdit,
  unimEdit, MedpUnimEdit;

type
  TWM003FAutAssenzeFM = class(TWR004FAutRichiesteFM)
    tabCompetenze: TUnimTabSheet;
    pnlHeaderCompetenze: TMedpUnimPanelHeaderDett;
    pnlListaCompetenze: TMedpUnimPanelListaDettaglio;
    procedure UniFrameCreate(Sender: TObject); override;
    procedure OnDisclCompetenzeClick(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure pnlHeaderCompetenzelblBackClick(Sender: TObject);
  private
    WR004CompetenzeMW: TWR004FCompetenzeMW;
    WM003AutAssenzeMW: TWM003FAutAssenzeMW;
  protected
    function CreaLabelsRichiesta: TMedpUnimPanelBase; override;
    function AggiornaListaDettaglio: TResCtrl; override;
    procedure AggiornaHeaderCompetenze;
    function AggiornaListaCompetenze: TResCtrl;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM003FAutAssenzeFM.UniFrameCreate(Sender: TObject);
begin
  WR002RichiesteMW:=TWM003FAutAssenzeMW.Create;
  WM003AutAssenzeMW:=WR002RichiesteMW as TWM003FAutAssenzeMW;

  WR004CompetenzeMW:=TWR004FCompetenzeMW.Create;
  FAutorizzaTuttiDisponibile:=True;
  OnChangeAbilitaFunzione:=OnChangeAbilitaFunzioneProc;

  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  FAutorizzatore:=True;
  inherited;
end;

procedure TWM003FAutAssenzeFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WR004CompetenzeMW);
  WM003AutAssenzeMW:=nil;
  inherited;
  SessioneOracle.LogOff;
end;

function TWM003FAutAssenzeFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
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
    Labels.Label1.Caption:=WM003AutAssenzeMW.Causale;
    Labels.Label1.Constraints.MinHeight:=20;
    Labels.Label1.JustifyContent:=JustifyStart;
    Labels.Label1.Font.Style:=[fsBold];
    Labels.Label1.BoxModel.CSSMargin.Top:='2px';
    Labels.Label2.LayoutConfig.Width:='100%';
    Labels.Label2.Caption:=WM003AutAssenzeMW.Periodo;
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

        LNumAllegati:=WR006AllegatiMW.GetNumeroAllegati(WM003AutAssenzeMW.ID);

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

function TWM003FAutAssenzeFM.AggiornaListaDettaglio: TResCtrl;
var LDescLivello: String;
begin
  pnlListaDettaglio.Clear;

  if Assigned(WM003AutAssenzeMW) then
  begin
    lblLivello.Text:=Format('Livello %d',[WM003AutAssenzeMW.LivelloAutorizzazione]);

    LDescLivello:=WM003AutAssenzeMW.DescLivelloAutorizzazione;
    if LDescLivello <> '' then
      lblLivello.Text:=Format('%s - %s',[lblLivello.Text,LDescLivello]);

    pnlListaDettaglio.Add2Labels('Nominativo', WM003AutAssenzeMW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_TIPO_RICHIESTA_TEXT, WM003AutAssenzeMW.TipoRichiestaEstesa, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Periodo', WM003AutAssenzeMW.PeriodoOrario, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Causale', WM003AutAssenzeMW.CausaleEstesa, False, 0, nil);

    if WM003AutAssenzeMW.Familiare <> '' then
      pnlListaDettaglio.Add2Labels('Familiare', WM003AutAssenzeMW.Familiare, False, 0, nil);

    pnlListaDettaglio.Add2Labels(ITEM_COMPETENZE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclCompetenzeClick);

    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM003AutAssenzeMW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    if WM003AutAssenzeMW.MotivazionePresente then
      pnlListaDettaglio.Add2Labels(ITEM_MOTIVAZIONE_TEXT, WM003AutAssenzeMW.Motivazione, False, 0, nil);

    Result:=AggiungiGestAllegatiDettaglio;
    if not Result.Ok then
      Exit;

    ImpostaPannelloAutorizzazione;

    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM003AutAssenzeMW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

procedure TWM003FAutAssenzeFM.OnDisclCompetenzeClick(Sender: TObject);
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

procedure TWM003FAutAssenzeFM.pnlHeaderCompetenzelblBackClick(Sender: TObject);
begin
  inherited;
  tpnlRichieste.ActivePage:=tabDettaglio;
end;

procedure TWM003FAutAssenzeFM.AggiornaHeaderCompetenze;
begin
  if Assigned(WM003AutAssenzeMW) then
  begin
    pnlHeaderCompetenze.LabelDettaglio.Caption:=Format('Competenze %s al %s',[WM003AutAssenzeMW.CodCausale, FormatDateTime('dd/mm/yyyy', WM003AutAssenzeMW.DataDal)]);
  end;
end;

function TWM003FAutAssenzeFM.AggiornaListaCompetenze: TResCtrl;
begin
  pnlListaCompetenze.Clear;

  if Assigned(WM003AutAssenzeMW) then
  begin
    with WM000FMainModule do
        Result:=WR004CompetenzeMW.GetCompetenzeSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin,
                                                     WM003AutAssenzeMW.Progressivo, WM003AutAssenzeMW.CodCausale,
                                                     WM003AutAssenzeMW.DataDal, WM003AutAssenzeMW.DataNascitaFamiliare);
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

initialization
  RegisterClass(TWM003FAutAssenzeFM);
end.
