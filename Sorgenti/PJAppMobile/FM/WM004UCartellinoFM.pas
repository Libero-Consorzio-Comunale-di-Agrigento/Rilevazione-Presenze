unit WM004UCartellinoFM;

interface

uses
  B110UClientModule,
  A000UCostanti,
  B110USharedTypes,
  //C200UWebServicesTypes,
  C200UWebServicesUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, uniLabel, unimLabel, MedpUnimLabel, uniMultiItem,
  unimSelect, MedpUnimSelect, MedpUnimPanelListaElem,
  MedpUnimPanelListaDisclosure, WM004UCartellinoMW, System.IOUtils, MedpUnimPanel2Labels, MedpUnimPanelDisclosure;

type
  TWM004FCartellinoFM = class(TWM000FFrameBase)
    lblPeriodo: TMedpUnimLabel;
    pnlDataDaA: TMedpUnimPanelDataDaA;
    pnlNumCartellini: TMedpUnimPanelNumElem;
    lblParametrizzazione: TMedpUnimLabel;
    cmbParamStampa: TMedpUnimSelect;
    pnlListaCartellini: TMedpUnimPanelListaDisclosure;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure OnDisclCartellinoClick(Sender: TObject);
    procedure pnlDataDaAChange(Sender: TObject);
  private
    WM004MW: TWM004FCartellinoMW;

    procedure AggiornaListaCartellini;
    function CreaPanelCartellino(PMeseCartellino: String): TMedpUnimPanel2Labels;
    procedure StampaCartellinoPdf(PMeseCartellino: String);
    function InviaFile(PPathFilePdf: String): TResCtrl;
    function ApriFileNelBrowser(PPathFilePdf, PRandomFolder, PNomeFilePdf: String): TResCtrl;
  public
    { Public declarations }
  end;

const
  MESI_DA_VISUALIZZARE   = 13;

implementation

{$R *.dfm}
uses
  WM000UMainModule,
  WM000UServerModule,
  uniGUIVars,
  uniGUIApplication;

procedure TWM004FCartellinoFM.UniFrameCreate(Sender: TObject);
var i: Integer;
begin
  with WM000FMainModule.InfoLogin.DatiGenerali do
  begin
    WM004MW:= TWM004FCartellinoMW.Create(ParametriServizi.CodiciT950,
                                         Parametri.WEBCartelliniDataMin,
                                         Parametri.WEBCartelliniMMPrec,
                                         Parametri.WEBCartelliniMMSucc);
  end;

  for i := 0 to WM004MW.Profili.Count-1 do
    cmbParamStampa.Add(WM004MW.Profili[i].Key, WM004MW.Profili[i].Value);

  if cmbParamStampa.Items.Count > 0 then
    cmbParamStampa.ItemIndex:=0;

  pnlDataDaA.DataDa.Date:=WM004MW.MeseDa;
  pnlDataDaA.DataA.Date:=WM004MW.MeseA;

  AggiornaListaCartellini;
end;

procedure TWM004FCartellinoFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM004MW);
  inherited;
end;

procedure TWM004FCartellinoFM.OnDisclCartellinoClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if cmbParamStampa.ItemIndex = -1 then
  begin
    ShowMessage('Selezionare la parametrizzazione di stampa dal menu a tendina!');
    Exit;
  end;

  LResCtrl:= WM004MW.ControllaDate(pnlDataDaA.DataDa.Date, pnlDataDaA.DataA.Date);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    StampaCartellinoPdf((Sender as TMedpUnimPanelDisclosure).Key);
end;

procedure TWM004FCartellinoFM.pnlDataDaAChange(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  LResCtrl:= WM004MW.ControllaDate(pnlDataDaA.DataDa.Date, pnlDataDaA.DataA.Date);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    AggiornaListaCartellini;
end;

function TWM004FCartellinoFM.InviaFile(PPathFilePdf: String): TResCtrl;
begin
  if not TFile.Exists(PPathFilePdf) then
  begin
    Result.Messaggio:='Il cartellino PDF non è stato creato';
    Result.Ok:=False;
  end
  else
  begin
    UniSession.SendFile(PPathFilePdf);
    TFile.Delete(PPathFilePdf);
    Result.Ok:=True;
  end;
end;

function TWM004FCartellinoFM.ApriFileNelBrowser(PPathFilePdf, PRandomFolder, PNomeFilePdf: String): TResCtrl;
begin
  if not TFile.Exists(TPath.Combine(TPath.Combine(PPathFilePdf, PRandomFolder), PNomeFilePdf)) then
  begin
    Result.Messaggio:='Il cartellino PDF non è stato creato';
    Result.Ok:=False;
  end
  else
  begin
    //UniSession.AddJS('window.open("m/files/' + PNomeFilePdf +'", "_blank")');
    UniSession.AddJS('window.open("' + WM000FServerModule.GlobalCacheURL + UniSession.SessionId + '/' + PRandomFolder + '/' + PNomeFilePdf +'", "_blank")');

    Result.Ok:=True;
  end;
end;

procedure TWM004FCartellinoFM.AggiornaListaCartellini;
var
  LResCtrl: TResCtrl;
  LListaCartellini: TStringList;
  i : Integer;
begin
  pnlListaCartellini.Clear;

  with WM000FMainModule do
    LResCtrl:= WM004MW.AggiornaListaCartelliniSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    try
      LListaCartellini:=WM004MW.GetListaCartellini;

      for i := 0 to LListaCartellini.Count-1 do
        pnlListaCartellini.Add(CreaPanelCartellino(LListaCartellini[i]), True, LListaCartellini[i], OnDisclCartellinoClick, True);

    finally
      FreeAndNil(LListaCartellini);
    end;

    pnlNumCartellini.NumElementi:=pnlListaCartellini.NumeroElementi;
  end;
end;

procedure TWM004FCartellinoFM.StampaCartellinoPdf(PMeseCartellino: String);
var
  LPathFilePdf: String;
  LFilePdf: String;
  LResCtrl: TResCtrl;
  LCodParStampa: String;
  LRandomFolder: String;
begin

  if cmbParamStampa.ItemIndex <> -1 then
  begin
    LCodParStampa:=cmbParamStampa.ListaCodici[cmbParamStampa.ItemIndex];

    LFilePdf:=Format('cartellino_%s_%s_%s.pdf',[WM000FMainModule.InfoLogin.ParametriLogin.Utente.ToLower, StringReplace(PMeseCartellino, ' ', '_',[rfReplaceAll, rfIgnoreCase]), LCodParStampa] );

    repeat
      LRandomFolder:=IntToStr(Random(1000));
      LPathFilePdf:=TPath.Combine(WM000FServerModule.LocalCachePath,LRandomFolder);
    until not DirectoryExists(LPathFilePdf);

    CreateDir(LPathFilePdf);

    LPathFilePdf:=TPath.Combine(LPathFilePdf,LFilePdf);

    with WM000FMainModule do
    begin
      LResCtrl:= WM004MW.StampaCartellinoPdf(B110ClientModule,
                                             InfoClient,
                                             InfoLogin.ParametriLogin,
                                             PMeseCartellino,
                                             LCodParStampa,
                                             LPathFilePdf);
    end;

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio)
    else
    begin
      LResCtrl:=ApriFileNelBrowser(WM000FServerModule.LocalCachePath, LRandomFolder, LFilePdf);
      if not LResCtrl.Ok then
        ShowMessage(LResCtrl.Messaggio);
    end;
  end;
end;

function TWM004FCartellinoFM.CreaPanelCartellino(PMeseCartellino: String): TMedpUnimPanel2Labels;
begin
  Result:=TMedpUnimPanel2Labels.Create(Self);

  with Result do
  begin
    LayoutConfig.Height:='40';
    Label1.Caption:=PMeseCartellino;
    Label1.LayoutConfig.Width:='100%';
    Label2.Visible:=False;
  end;
end;


initialization
  RegisterClass(TWM004FCartellinoFM);
end.
