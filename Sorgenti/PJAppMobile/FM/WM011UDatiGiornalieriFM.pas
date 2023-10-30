unit WM011UDatiGiornalieriFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, uniDateTimePicker,
  unimDatePicker, MedpUnimDatePicker, uniLabel, unimLabel, MedpUnimLabel,
  MedpUnimPanel2Labels, MedpUnimPanelListaElem, WM011UDatiGiornalieriMW, WM000UMainModule, A000UCostanti,
  Generics.Defaults,
  Generics.Collections, MedpUnimTypes;

type
  TWM011FDatiGiornalieriFM = class(TWM000FFrameBase)
    pnlData: TMedpUnimPanelBase;
    edtData: TMedpUnimDatePicker;
    lblGiorno: TMedpUnimLabel;
    pnlDati: TMedpUnimPanelBase;
    pnlDebitoOrario: TMedpUnimPanel2Labels;
    pnlOreRese: TMedpUnimPanel2Labels;
    pnlSaldo: TMedpUnimPanel2Labels;
    pnlOreEscluse: TMedpUnimPanel2Labels;
    pnlTimbNominali: TMedpUnimPanel2Labels;
    pnlReperibilita: TMedpUnimPanel2Labels;
    lblTimbEffettuate: TMedpUnimLabel;
    lblGiustificativi: TMedpUnimLabel;
    lblAnomalie: TMedpUnimLabel;
    pnlTimbrature: TMedpUnimPanelListaElem;
    pnlGiustificativi: TMedpUnimPanelListaElem;
    pnlAnomalie: TMedpUnimPanelListaElem;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure edtDataChange(Sender: TObject);
  private
    { Private declarations }
    WM011MW: TWM011FDatiGiornalieriMW;

    procedure AggiornaDati;
    procedure AggiornaTimbrature;
    procedure AggiornaGiustificativi;
    procedure AggiornaAnomalie;

    function CreaPanelLista(Caption1, Caption2: String): TMedpUnimPanel2Labels;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM011FDatiGiornalieriFM.UniFrameCreate(Sender: TObject);
begin
  edtData.Date:=Now;
  edtData.MinYear:=CurrentYear-1;
  edtData.MaxYear:=CurrentYear+1;

  WM011MW:= TWM011FDatiGiornalieriMW.Create(edtData.Date);
  AggiornaDati;
end;

procedure TWM011FDatiGiornalieriFM.UniFrameDestroy(Sender: TObject);
begin
  if Assigned(WM011MW) then
    FreeAndNil(WM011MW);
  inherited;
end;

procedure TWM011FDatiGiornalieriFM.AggiornaDati;
var LResCtrl: TResCtrl;
begin
  with WM000FMainModule do
    LResCtrl:= WM011MW.AggiornaDatiGGSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    lblGiorno.Caption:=WM011MW.GetDayOfWeek;
    pnlDebitoOrario.Label2.Caption:=WM011MW.GetDebitoOrario;
    pnlOreRese.Label2.Caption:=WM011MW.GetOreRese;
    pnlSaldo.Label2.Caption:=WM011MW.GetSaldo;
    pnlOreEscluse.Label2.Caption:=WM011MW.GetOreEscluse;
    pnlTimbNominali.Label2.Caption:=WM011MW.GetTimbNominali;
    pnlReperibilita.Label2.Caption:=WM011MW.GetReperibilitaPianificata;

    if pnlReperibilita.Label2.Caption = '' then
      pnlReperibilita.Visible:=false;

    AggiornaTimbrature;
    AggiornaGiustificativi;
    AggiornaAnomalie;
  end;
end;

procedure TWM011FDatiGiornalieriFM.AggiornaGiustificativi;
var listaGiustificativi: TStringList;
    i: Integer;
begin
  try
    pnlGiustificativi.Clear;

    listaGiustificativi:= WM011MW.GetGiustificativi;
    if listaGiustificativi.Count = 0 then
      pnlGiustificativi.Add(CreaPanelLista('', '(vuoto)'))
    else
    begin
      for i := 0 to listaGiustificativi.Count-1 do
        pnlGiustificativi.Add(CreaPanelLista('', listaGiustificativi[i]));
    end;

  finally
    FreeAndNil(listaGiustificativi);
  end;
end;

procedure TWM011FDatiGiornalieriFM.AggiornaTimbrature;
var listaTimbrature: TStringList;
    i: Integer;
begin
  try
    pnlTimbrature.Clear;

    listaTimbrature:= WM011MW.GetTimbrature;
    if listaTimbrature.Count = 0 then
      pnlTimbrature.Add(CreaPanelLista('', '(vuoto)'))
    else
    begin
      for i := 0 to listaTimbrature.Count-1 do
        pnlTimbrature.Add(CreaPanelLista('', listaTimbrature[i]));
    end;

  finally
    FreeAndNil(listaTimbrature);
  end;
end;

procedure TWM011FDatiGiornalieriFM.AggiornaAnomalie;
var listaAnomalie: TList<TPair<String, String>>;
    i: Integer;
begin
  try
    pnlAnomalie.Clear;

    listaAnomalie:= WM011MW.GetAnomalie;
    if listaAnomalie.Count = 0 then
      pnlAnomalie.Add(CreaPanelLista('', '(vuoto)'))
    else
    begin
      for i := 0 to listaAnomalie.Count-1 do
        pnlAnomalie.Add(CreaPanelLista(listaAnomalie[i].Key, listaAnomalie[i].Value));
    end;

  finally
    FreeAndNil(listaAnomalie);
  end;
end;

function TWM011FDatiGiornalieriFM.CreaPanelLista(Caption1, Caption2: String): TMedpUnimPanel2Labels;
begin
  Result:=TMedpUnimPanel2Labels.Create(Self);

  with Result do
  begin
    with Label1 do
    begin
      Caption:=Caption1;
      LayoutConfig.Width:='50%';
      LayoutConfig.Height:='auto';
      Constraints.MinHeight:=30;
      JustifyContent:=JustifyStart;
      BoxModel.CSSMargin.Left:='5px';
    end;

    with Label2 do
    begin
      Caption:=Caption2;
      LayoutConfig.Width:='50%';
      LayoutConfig.Height:='auto';
      Constraints.MinHeight:=30;
      JustifyContent:=JustifyStart;
    end;
  end;
end;

procedure TWM011FDatiGiornalieriFM.edtDataChange(Sender: TObject);
begin
  WM011MW.Data:=edtData.Date;
  AggiornaDati;
end;

initialization
  RegisterClass(TWM011FDatiGiornalieriFM);

end.
