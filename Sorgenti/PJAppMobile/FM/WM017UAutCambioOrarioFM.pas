unit WM017UAutCambioOrarioFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR004UAutRichiesteFM,
  MedpUnimPanelListaDettaglio, MedpUnimPanel2Button, uniLabel, unimLabel,
  MedpUnimLabel, MedpUnimPanelHeaderDett, MedpUnimPanelListaElem,
  MedpUnimPanelListaDisclosure, MedpUnimPanelNumElem, MedpUnimPanelDataDaA,
  MedpUnimRadioGroup, uniPanel, uniPageControl, unimTabPanel,
  MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses, uniGUImJSForm,
  MedpUnimPanelBase, WM016UCambioOrarioMW, A000UInterfaccia, MedpUnimPanel4Labels,
  StrUtils, MedpUnimTypes, A000UCostanti, C180FunzioniGenerali,
  MedpUnimPanel2Labels, MedpUnimPanelSlideUp, uniCheckBox, unimCheckBox,
  MedpUnimMemo, uniFileUpload, unimFileUpload, uniEdit, unimEdit, MedpUnimEdit;

type
  TWM017FAutCambioOrarioFM = class(TWR004FAutRichiesteFM)
    procedure UniFrameCreate(Sender: TObject); override;
    procedure UniFrameDestroy(Sender: TObject); override;
  private
    WM016MW: TWM016FCambioOrarioMW;
  protected
    function AggiornaListaDettaglio: TResCtrl; override;
    function  CreaLabelsRichiesta: TMedpUnimPanelBase; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM017FAutCambioOrarioFM.UniFrameCreate(Sender: TObject);
begin
  if Parametri.CampiRiferimento.C90_WebTipoCambioOrario = '' then
  begin
    MainPanel.Visible:=False;
    raise Exception.Create('Per accedere alla funzione Autoriz. cambio orario è necessario impostare il seguente dato aziendale del gruppo IrisWEB: "Web: Tipologia cambio orario!"');
  end;

  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  FAutorizzatore:=True;
  WR002RichiesteMW:=TWM016FCambioOrarioMW.Create(A000SessioneIrisWin, FAutorizzatore);
  WM016MW:=WR002RichiesteMW as TWM016FCambioOrarioMW;

  FAutorizzaTuttiDisponibile:=True;
  OnChangeAbilitaFunzione:=OnChangeAbilitaFunzioneProc;
  inherited;
end;

procedure TWM017FAutCambioOrarioFM.UniFrameDestroy(Sender: TObject);
begin
  WM016MW:=nil;
  inherited;
  SessioneOracle.LogOff;
end;

function TWM017FAutCambioOrarioFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
var LCambioGiorno: Boolean;
    LCambioOrario: Boolean;
begin
  LCambioGiorno:=(Trunc(WM016MW.Data) <> Trunc(WM016MW.DataInver)) or (WM016MW.SoloNote = 'S');
  LCambioOrario:=(WM016MW.Orario.Key <> WM016MW.OrarioInver.Key) or (WM016MW.SoloNote = 'S');

  Result:=TMedpUnimPanel4Labels.Create(Self);

  with Result as TMedpUnimPanel4Labels do
  begin
    Constraints.MinHeight:=40;

    LayoutConfig.Height:='auto';
    Layout:='vbox';
    LayoutAttribs.Align:='center';
    LayoutAttribs.Pack:='start';

    Label1.Caption:='CAMBIO ' + IfThen(LCambioGiorno, 'GIORNO', '') + IfThen(LCambioGiorno and LCambioOrario, '/', '') + IfThen(LCambioOrario, 'ORARIO', '');
    Label1.Font.Style:=Label1.Font.Style + [fsBold];
    Label1.LayoutConfig.Width:='98%';
    Label1.JustifyContent:=JustifyStart;
    Label1.BoxModel.CSSMargin.Top:='2px';
    Label1.BoxModel.CSSMargin.Bottom:='2px';

    Label2.Caption:='Giorno: ' + FormatDateTime('dd/mm/yyyy', WM016MW.Data) + IfThen(LCambioGiorno and not (WM016MW.SoloNote = 'S'), ' <i class="fas fa-long-arrow-alt-right"></i> ' + FormatDateTime('dd/mm/yyyy', WM016MW.DataInver), '');
    Label2.LayoutConfig.Width:='98%';
    Label2.JustifyContent:=JustifyStart;
    Label3.BoxModel.CSSMargin.Bottom:='2px';

    if WM016MW.SoloNote = 'S' then
      Label3.Caption:='(solo note)'
    else
      Label3.Caption:='Orario:  ' + WM016MW.Orario.Key + IfThen(LCambioOrario, ' <i class="fas fa-long-arrow-alt-right"></i> ' + WM016MW.OrarioInver.Key, '');

    Label3.LayoutConfig.Width:='98%';
    Label3.BoxModel.CSSMargin.Bottom:='2px';
    Label3.JustifyContent:=JustifyStart;

    Label4.Caption:='';
    Label4.LayoutConfig.Width:='0%';
  end;
end;

function TWM017FAutCambioOrarioFM.AggiornaListaDettaglio: TResCtrl;
var LCambioGiorno: Boolean;
    LCambioOrario: Boolean;
    LValutazioneOrario: String;
    LValutazioneOrarioInver: String;
begin
  pnlListaDettaglio.Clear;

  LCambioGiorno:=Trunc(WM016MW.Data) <> Trunc(WM016MW.DataInver);
  LCambioOrario:=WM016MW.Orario.Key <> WM016MW.OrarioInver.Key;

  lblLivello.Text:=Format('Livello %d',[WM016MW.LivelloAutorizzazione]);

  if Assigned(WM016MW) then
  begin
    pnlListaDettaglio.Add2Labels('Matricola', WM016MW.Matricola, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Nominativo', WM016MW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM016MW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels(IfThen(LCambioGiorno, 'Primo giorno', 'Giorno'), R180NomeGiorno(WM016MW.Data) + ' ' + FormatDateTime('dd/mm/yyyy', WM016MW.Data) + ' (' + WM016MW.GetTipoGiornoEsteso(WM016MW.Progressivo, WM016MW.Data) + ')', False, 0, nil);

    if WM016MW.SoloNote <> 'S' then
    begin
      if LCambioGiorno then
        pnlListaDettaglio.Add2Labels('Secondo giorno', R180NomeGiorno(WM016MW.DataInver) + ' ' + FormatDateTime('dd/mm/yyyy', WM016MW.DataInver) + ' (' + WM016MW.GetTipoGiornoEsteso(WM016MW.Progressivo, WM016MW.DataInver) + ')', False, 0, nil);

      pnlListaDettaglio.Add2Labels('Orario' + IfThen(LCambioOrario, ' originale', ''), WM016MW.Orario.Key + ' - ' + WM016MW.Orario.Value, False, 0, nil);

      LValutazioneOrario:=WM016MW.ControllaOrario;
      if LValutazioneOrario <> '' then
        pnlListaDettaglio.AddIconLabel('fas fa-exclamation-triangle', LValutazioneOrario, False, 0, nil);

      if LCambioOrario then
        pnlListaDettaglio.Add2Labels('Orario richiesto', WM016MW.OrarioInver.Key + ' - ' + WM016MW.OrarioInver.Value, False, 0, nil);

      LValutazioneOrarioInver:=WM016MW.ControllaOrarioInver;
      if LValutazioneOrarioInver <> '' then
        pnlListaDettaglio.AddIconLabel('fas fa-exclamation-triangle', LValutazioneOrarioInver, False, 0, nil);
    end;

    pnlListaDettaglio.Add2Labels('Autorizzazione', IfThen(WM016MW.AutorizzUtile = 'S', 'Si', IfThen(WM016MW.AutorizzUtile = 'N', 'No', WM016MW.AutorizzUtile)), False, 0, nil);
    pnlListaDettaglio.Add2Labels('Responsabile', Trim(WM016MW.NominativoResp), False, 0, nil);

    if WM016MW.SoloNote = 'S' then
      pnlListaDettaglio.Add2Labels('Solo note', '<i class="far fa-check-square"></i>', False, 0, nil);

    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    ImpostaPannelloAutorizzazione;
    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM016CambioOrarioMW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

initialization
  RegisterClass(TWM017FAutCambioOrarioFM);

end.
