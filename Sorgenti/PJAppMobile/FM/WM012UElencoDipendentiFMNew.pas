unit WM012UElencoDipendentiFMNew;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, MedpUnimPanelNumElem,
  MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure,
  MedpUnimPanelListaDettaglio, MedpUnimPanelHeaderDett, WM012UElencoDipendentiMW,
  WM000UConstants, A000UCostanti, WM000UMainModule, MedpUnimPanel2Labels, MedpUnimTypes;

type
  TWM012FElencoDipendentiFMNew = class(TWM000FFrameBase)
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
    procedure UniFrameDestroy(Sender: TObject);
    procedure lblBackDettCampoClick(Sender: TObject);
    procedure lblBackDettaglioClick(Sender: TObject);
    procedure lblUpClick(Sender: TObject);
    procedure lblDownClick(Sender: TObject);
    procedure OnDipendenteClick(Sender: TObject);
  private
    WM012MW: TWM012FElencoDipendentiMW;

    procedure AggiornaListaDipendenti;
    procedure AggiornaListaDettaglio;
    procedure AggiornaListaDettaglioCampo(PDati: String);
    procedure AggiornaHeaderDettaglio;

    function CreaPanelDipendente: TMedpUnimPanel2Labels;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM012FElencoDipendentiFMNew.UniFrameCreate(Sender: TObject);
begin
  WM012MW:=TWM012FElencoDipendentiMW.Create;

  AggiornaListaDipendenti;

  tpnlElencoDipendenti.ActivePage:=tabElencoDipendenti;
end;

procedure TWM012FElencoDipendentiFMNew.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM012MW);
end;

procedure TWM012FElencoDipendentiFMNew.AggiornaListaDipendenti;
var LResCtrl: TResCtrl;
    LNominativo: String;
begin
  pnlListaDipendenti.Clear;

  with WM000FMainModule do
      LResCtrl:=WM012MW.AggiornaDipendentiSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, Date);

  if LResCtrl.Ok then
  begin

    while not WM012MW.Eof do
    begin
      {LNominativo:=Format('%s %s',[WM012MW.Cognome, WM012MW.Nome]);

      with TPanelDipendente.Create(pnlElencoDipendenti, WM012MW.RecNo, LNominativo, WM012MW.Matricola, 3, 1, WM012MW.FontColor, True, MessageManager, MESSAGGIO_DETTAGLIO + WM012MW.Matricola) do
        Parent:=pnlElencoDipendenti;}

      pnlListaDipendenti.Add(CreaPanelDipendente, True, WM012MW.Matricola, OnDipendenteClick);

      WM012MW.Next;
    end;

    // numero dipendenti
    pnlNumDipendenti.NumElementi:=pnlListaDipendenti.NumeroElementi;
  end;
end;

function TWM012FElencoDipendentiFMNew.CreaPanelDipendente: TMedpUnimPanel2Labels;
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

procedure TWM012FElencoDipendentiFMNew.AggiornaListaDettaglio;
var i: Integer;
    LColonna2: String;
begin
  pnlListaDettaglio.Clear;

  i:=1;

  if WM012MW.FirstDettaglio then
  begin
    while not WM012MW.EofDettaglio do
    begin
      {if WM012MW.CampoSpeciale then
        LColonna2:=ITEM_MORE_DETAILS
      else
        LColonna2:=WM012MW.FieldText;

      with TPanelDipendente.Create(pnlDettaglio, i, WM012MW.FieldLabel, LColonna2, 1, 1, FONT_COLOR_DEFAULT, WM012MW.CampoSpeciale, MessageManager, MESSAGGIO_DETTCAMPO + WM012MW.FieldText) do
        Parent:=pnlDettaglio;

      i:=i+1;}

      WM012MW.NextDettaglio;
    end;
  end;
end;

procedure TWM012FElencoDipendentiFMNew.AggiornaListaDettaglioCampo(PDati: String);
var
  LInfo: String;
  LDatoValoreArr: TArray<String>;
  LColonna1, LColonna2: String;
  i: Integer;
begin
  pnlListaDettCampo.Clear;

  i:=1;
  for LInfo in PDati.Split([','],'"') do
  begin
    {LDatoValoreArr:=LInfo.Replace('"','').Split(['=']);

    LColonna1:=LDatoValoreArr[0].Substring(0,1).ToUpper + LDatoValoreArr[0].Substring(1).ToLower;
    if Length(LDatoValoreArr) > 1 then
      LColonna2:=LDatoValoreArr[1]
    else
      LColonna2:='';

    with TPanelDipendente.Create(pnlDettaglioCampo, i, LColonna1, LColonna2, 1, 1, FONT_COLOR_DEFAULT, False, MessageManager, '') do
        Parent:=pnlDettaglioCampo;

    i:=i+1;}
  end;
end;

procedure TWM012FElencoDipendentiFMNew.AggiornaHeaderDettaglio;
begin
  pnlHeaderDettaglio.LabelDettaglio.Caption:=Format('%s %s (%s)',[WM012MW.Cognome, WM012MW.Nome, WM012MW.Matricola]);

  pnlHeaderDettaglio.Up.Visible:=WM012MW.PrecEnabled;
  pnlHeaderDettaglio.Down.Visible:=WM012MW.SuccEnabled;
end;

procedure TWM012FElencoDipendentiFMNew.lblBackDettaglioClick(Sender: TObject);
begin
  tpnlElencoDipendenti.ActivePage:=tabElencoDipendenti;
end;

procedure TWM012FElencoDipendentiFMNew.lblBackDettCampoClick(Sender: TObject);
begin
  tpnlElencoDipendenti.ActivePage:=tabDettaglio;
end;

procedure TWM012FElencoDipendentiFMNew.lblDownClick(Sender: TObject);
begin
  if WM012MW.Next then
  begin
    AggiornaHeaderDettaglio;
    AggiornaListaDettaglio;
  end;
end;

procedure TWM012FElencoDipendentiFMNew.lblUpClick(Sender: TObject);
begin
  if WM012MW.Prior then
  begin
    AggiornaHeaderDettaglio;
    AggiornaListaDettaglio;
  end;
end;

procedure TWM012FElencoDipendentiFMNew.OnDipendenteClick(Sender: TObject);
begin
   // vai a dettaglio
end;

initialization
  RegisterClass(TWM012FElencoDipendentiFMNew);

end.
