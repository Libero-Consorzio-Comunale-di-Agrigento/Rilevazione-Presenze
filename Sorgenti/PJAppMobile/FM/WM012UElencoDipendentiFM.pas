unit WM012UElencoDipendentiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, MedpUnimPanelNumElem,
  MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure,
  MedpUnimPanelListaDettaglio, MedpUnimPanelHeaderDett, WM012UElencoDipendentiMW,
  WM000UConstants, A000UCostanti, WM000UMainModule, MedpUnimPanel2Labels, MedpUnimTypes, MedpUnimPanelDisclosure;

type
  TWM012FElencoDipendentiFM = class(TWM000FFrameBase)
    tpnlElencoDipendenti: TMedpUnimTabPanelBase;
    tabElencoDipendenti: TUnimTabSheet;
    tabDettaglio: TUnimTabSheet;
    tabDettaglioCampo: TUnimTabSheet;
    pnlNumDipendenti: TMedpUnimPanelNumElem;
    pnlListaDipendenti: TMedpUnimPanelListaDisclosure;
    pnlHeaderDettaglio: TMedpUnimPanelHeaderDett;
    pnlListaDettaglio: TMedpUnimPanelListaDettaglio;
    pnlHeaderDettCampo: TMedpUnimPanelHeaderDett;
    pnlListaDettCampo: TMedpUnimPanelListaDettaglio;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure lblBackDettCampoClick(Sender: TObject);
    procedure lblBackDettaglioClick(Sender: TObject);
    procedure lblUpClick(Sender: TObject);
    procedure lblDownClick(Sender: TObject);

  private
    WM012MW: TWM012FElencoDipendentiMW;

    procedure AggiornaListaDipendenti;
    procedure AggiornaListaDettaglio;
    procedure AggiornaListaDettaglioCampo(PDati: String);
    procedure AggiornaHeaderDettaglio;

    function CreaPanelDipendente: TMedpUnimPanel2Labels;

    procedure OnDipendenteClick(Sender: TObject);
    procedure OnDettaglioClick(Sender: TObject);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM012FElencoDipendentiFM.UniFrameCreate(Sender: TObject);
begin
  WM012MW:=TWM012FElencoDipendentiMW.Create;

  AggiornaListaDipendenti;

  tpnlElencoDipendenti.ActivePage:=tabElencoDipendenti;
end;

procedure TWM012FElencoDipendentiFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM012MW);
  inherited;
end;

procedure TWM012FElencoDipendentiFM.AggiornaListaDipendenti;
var LResCtrl: TResCtrl;
begin
  pnlListaDipendenti.Clear;

  with WM000FMainModule do
      LResCtrl:=WM012MW.AggiornaDipendentiSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, Date);

  if LResCtrl.Ok then
  begin

    while not WM012MW.Eof do
    begin
      pnlListaDipendenti.Add(CreaPanelDipendente, True, WM012MW.Matricola, OnDipendenteClick);

      WM012MW.Next;
    end;

    // numero dipendenti
    pnlNumDipendenti.NumElementi:=pnlListaDipendenti.NumeroElementi;
  end;
end;

function TWM012FElencoDipendentiFM.CreaPanelDipendente: TMedpUnimPanel2Labels;
begin
  Result:=TMedpUnimPanel2Labels.Create(Self);

  with Result do
  begin
    with Label1 do
    begin
      Caption:=Format('%s %s',[WM012MW.Cognome, WM012MW.Nome]);
      Flex:=0;
      LayoutConfig.Width:='70%';
      LayoutConfig.Height:='auto';
      Constraints.MinHeight:=40;
      JustifyContent:=JustifyStart;
      BoxModel.CSSMargin.Left:='5px';
      Font.Color:=WM012MW.FontColor;
    end;

    with Label2 do
    begin
      Caption:=WM012MW.Matricola;
      Flex:=0;
      LayoutConfig.Width:='30%';
      LayoutConfig.Height:='auto';
      Constraints.MinHeight:=40;
      JustifyContent:=JustifyStart;
      Font.Color:=WM012MW.FontColor;
    end;
  end;
end;

procedure TWM012FElencoDipendentiFM.AggiornaListaDettaglio;
var LColonna2: String;
begin
  pnlListaDettaglio.Clear;

  if WM012MW.FirstDettaglio then
  begin
    while not WM012MW.EofDettaglio do
    begin
      if WM012MW.CampoSpeciale then
        LColonna2:=ITEM_MORE_DETAILS
      else
        LColonna2:=WM012MW.FieldText;

      pnlListaDettaglio.Add2Labels(WM012MW.FieldLabel, LColonna2, WM012MW.CampoSpeciale, WM012MW.FieldText, OnDettaglioClick);
      WM012MW.NextDettaglio;
    end;
  end;
end;

procedure TWM012FElencoDipendentiFM.AggiornaListaDettaglioCampo(PDati: String);
var
  LInfo: String;
  LDatoValoreArr: TArray<String>;
  LColonna1, LColonna2: String;
begin
  pnlListaDettCampo.Clear;

  for LInfo in PDati.Split([','],'"') do
  begin
    LDatoValoreArr:=LInfo.Replace('"','').Split(['=']);

    LColonna1:=LDatoValoreArr[0].Substring(0,1).ToUpper + LDatoValoreArr[0].Substring(1).ToLower;
    if Length(LDatoValoreArr) > 1 then
      LColonna2:=LDatoValoreArr[1]
    else
      LColonna2:='';

    pnlListaDettCampo.Add2Labels(LColonna1, LColonna2, False, '', nil);
  end;
end;

procedure TWM012FElencoDipendentiFM.AggiornaHeaderDettaglio;
begin
  pnlHeaderDettaglio.LabelDettaglio.Caption:=Format('%s %s (%s)',[WM012MW.Cognome, WM012MW.Nome, WM012MW.Matricola]);

  pnlHeaderDettaglio.Up.Visible:=WM012MW.PrecEnabled;
  pnlHeaderDettaglio.Down.Visible:=WM012MW.SuccEnabled;
end;

procedure TWM012FElencoDipendentiFM.lblBackDettaglioClick(Sender: TObject);
begin
  tpnlElencoDipendenti.ActivePage:=tabElencoDipendenti;
end;

procedure TWM012FElencoDipendentiFM.lblBackDettCampoClick(Sender: TObject);
begin
  tpnlElencoDipendenti.ActivePage:=tabDettaglio;
end;

procedure TWM012FElencoDipendentiFM.lblDownClick(Sender: TObject);
begin
  if WM012MW.Next then
  begin
    AggiornaHeaderDettaglio;
    AggiornaListaDettaglio;
  end;
end;

procedure TWM012FElencoDipendentiFM.lblUpClick(Sender: TObject);
begin
  if WM012MW.Prior then
  begin
    AggiornaHeaderDettaglio;
    AggiornaListaDettaglio;
  end;
end;

procedure TWM012FElencoDipendentiFM.OnDipendenteClick(Sender: TObject);
begin
  if sender is TMedpUnimPanelDisclosure then
    if WM012MW.LocateMatricola((sender as TMedpUnimPanelDisclosure).Key)then
    begin
      AggiornaHeaderDettaglio;
      AggiornaListaDettaglio;

      tpnlElencoDipendenti.ActivePage:=tabDettaglio;
    end;
end;

procedure TWM012FElencoDipendentiFM.OnDettaglioClick(Sender: TObject);
begin
  if sender is TMedpUnimPanelDisclosure then
  begin
    pnlHeaderDettCampo.LabelDettaglio.Caption:= '';

    if (sender as TMedpUnimPanelDisclosure).BasePanel.ControlCount > 0 then
      if (sender as TMedpUnimPanelDisclosure).BasePanel.Controls[0] is TMedpUnimPanel2Labels then
        pnlHeaderDettCampo.LabelDettaglio.Caption:=((sender as TMedpUnimPanelDisclosure).BasePanel.Controls[0] as TMedpUnimPanel2Labels).Label1.Caption;

    AggiornaListaDettaglioCampo((sender as TMedpUnimPanelDisclosure).Key);

    tpnlElencoDipendenti.ActivePage:=tabDettaglioCampo;
  end;
end;

initialization
  RegisterClass(TWM012FElencoDipendentiFM);

end.
