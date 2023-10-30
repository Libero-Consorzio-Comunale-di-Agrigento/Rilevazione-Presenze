unit WM010UAutTimbratureFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR004UAutRichiesteFM,
  MedpUnimPanel2Button, uniLabel, unimLabel, MedpUnimLabel,
  MedpUnimPanelHeaderDett, MedpUnimPanelListaElem, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses,
  uniGUImJSForm, unimPanel, MedpUnimPanelBase, WM010UAutTimbratureMW, A000UCostanti,
  MedpUnimPanel4Labels, MedpUnimPanelDisclosure, MedpUnimTypes,
  MedpUnimPanelListaDisclosure, MedpUnimPanelListaDettaglio, WM014URicTimbratureMW,
  MedpUnimPanelSlideUp, uniCheckBox, unimCheckBox, MedpUnimMemo,
  MedpUnimPanel2Labels, uniFileUpload, unimFileUpload, uniEdit, unimEdit,
  MedpUnimEdit;

type
  TWM010FAutTimbratureFM = class(TWR004FAutRichiesteFM)
    procedure UniFrameCreate(Sender: TObject); override;
    procedure UniFrameDestroy(Sender: TObject); override;
  private
    WM010AutTimbratureMW: TWM010FAutTimbratureMW;
  protected
    function CreaLabelsRichiesta: TMedpUnimPanelBase; override;
    function AggiornaListaDettaglio: TResCtrl; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM010FAutTimbratureFM.UniFrameCreate(Sender: TObject);
begin
  WR002RichiesteMW:=TWM010FAutTimbratureMW.Create;
  WM010AutTimbratureMW:=WR002RichiesteMW as TWM010FAutTimbratureMW;
  FAutorizzaTuttiDisponibile:=True;
  OnChangeAbilitaFunzione:=OnChangeAbilitaFunzioneProc;
  FAutorizzatore:=True;
  inherited;
end;

procedure TWM010FAutTimbratureFM.UniFrameDestroy(Sender: TObject);
begin
  WM010AutTimbratureMW:=nil;
  inherited;
end;

function TWM010FAutTimbratureFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
var LLabels: TMedpUnimPanel4Labels;
begin
  LLabels:=TMedpUnimPanel4Labels.Create(Self);

  with LLabels do
  begin
    Constraints.MinHeight:=40;

    with Label1 do
    begin
      Caption:=WM010AutTimbratureMW.Operazione;
      LayoutConfig.Height:='100%';//'40';
      LayoutConfig.Width:='30%';
      Font.Style:=Label1.Font.Style + [fsBold];
    end;

    with Label2 do
    begin
      Caption:=WM010AutTimbratureMW.Timbratura;
      LayoutConfig.Height:='50%';//'auto';
      LayoutConfig.Width:='70%';
      JustifyContent:=JustifyStart;
    end;

    with Label3 do
    begin
      Caption:=FormatDateTime('dd/mm/yyyy',WM010AutTimbratureMW.Data);
      LayoutConfig.Height:='50%';//'auto';
      LayoutConfig.Width:='70%';
      JustifyContent:=JustifyStart;
    end;

    Label4.Visible:=False;
  end;

  Result:=LLabels;
end;

function TWM010FAutTimbratureFM.AggiornaListaDettaglio: TResCtrl;
var LDescLivello: String;
begin
  pnlListaDettaglio.Clear;

  if Assigned(WM010AutTimbratureMW) then
  begin
    lblLivello.Text:=Format('Livello %d',[WM010AutTimbratureMW.LivelloAutorizzazione]);

    LDescLivello:=WM010AutTimbratureMW.DescLivelloAutorizzazione;
    if LDescLivello <> '' then
      lblLivello.Text:=Format('%s - %s',[lblLivello.Text,LDescLivello]);

    pnlListaDettaglio.Add2Labels('Nominativo', WM010AutTimbratureMW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Data', FormatDateTime('dd/mm/yyyy',WM010AutTimbratureMW.Data), False, 0, nil);
    pnlListaDettaglio.Add2Labels('Operazione', WM010AutTimbratureMW.OperazioneEstesa, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Timbratura', WM010AutTimbratureMW.Timbratura, False, 0, nil);

    if WM010AutTimbratureMW.Operazione = 'M' then
      pnlListaDettaglio.Add2Labels('Timbratura orig.', WM010AutTimbratureMW.TimbraturaOrig, False, 0, nil);

    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM010AutTimbratureMW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    if WM010AutTimbratureMW.MotivazionePresente then
      pnlListaDettaglio.Add2Labels(ITEM_MOTIVAZIONE_TEXT, WM010AutTimbratureMW.Motivazione, False, 0, nil);

    ImpostaPannelloAutorizzazione;

    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM010AutTimbratureMW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

initialization
  RegisterClass(TWM010FAutTimbratureFM);

end.
