unit WM005UCedolinoFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, uniLabel, unimLabel,
  MedpUnimLabel, MedpUnimPanelDataDaA, MedpUnimPanelListaElem,
  MedpUnimPanelListaDisclosure, A000UCostanti,
  B110USharedTypes, WM005UCedolinoMW, Generics.Collections, System.Messaging, System.IOUtils,
  MedpUnimPanelNumElem, MedpUnimPanelDisclosure, MedpUnimPanel4Labels;

type
  TWM005FCedolinoFM = class(TWM000FFrameBase)
    lblPeriodo: TMedpUnimLabel;
    pnlDataDaA: TMedpUnimPanelDataDaA;
    pnlListaCedolini: TMedpUnimPanelListaDisclosure;
    pnlNumCedolini: TMedpUnimPanelNumElem;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure pnlDataDaAChange(Sender: TObject);
  private
    WM005MW: TWM005FCedolinoMW;
    MessageManager: TMessageManager;

    procedure AggiornaListaCedolini;
    function CreaPanelCedolino(PDataRetribuzione, PTipoCedolino, PImporto, PDataCedolino: String): TMedpUnimPanel4Labels;
    procedure OnDisclCedolinoClick(Sender: TObject);
    procedure StampaCedolinoPdf(PIdCedolino: Integer);
    procedure AggiornaDataConsegnaCedolino(PMeseCedolino: TDateTime; PIdCedolino: Integer);
    function InviaFile(PPathFilePdf, PNomeFile: String): TResCtrl;
    function ApriFileNelBrowser(PPathFilePdf, PRandomFolder, PNomeFilePdf: String): TResCtrl;
  public
    { Public declarations }
  end;

const
  MESI_DA_VISUALIZZARE   = 13;

implementation

uses
  WM000UMainModule,
  WM000UServerModule,
  uniGUIVars,
  uniGUIApplication;

{$R *.dfm}

procedure TWM005FCedolinoFM.UniFrameCreate(Sender: TObject);
begin
  with WM000FMainModule.InfoLogin.DatiGenerali do
  begin
    WM005MW:= TWM005FCedolinoMW.Create(Parametri.WEBCedoliniDataMin,
                                       Parametri.WEBCedoliniMMPrec);
  end;

  pnlDataDaA.DataDa.Date:=WM005MW.MeseDa;
  pnlDataDaA.DataA.Date:=WM005MW.MeseA;

  AggiornaListaCedolini;
end;

procedure TWM005FCedolinoFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM005MW);
  FreeAndNil(MessageManager);
  inherited;
end;

procedure TWM005FCedolinoFM.pnlDataDaAChange(Sender: TObject);
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:= WM005MW.ControllaDate(pnlDataDaA.DataDa.Date, pnlDataDaA.DataA.Date);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    AggiornaListaCedolini;
end;

function TWM005FCedolinoFM.InviaFile(PPathFilePdf, PNomeFile: String): TResCtrl;
begin
  if not TFile.Exists(PPathFilePdf) then
  begin
    Result.Messaggio:='Il cedolino PDF non è stato creato';
    Result.Ok:=False;
  end
  else
  begin
    UniSession.SendFile(PPathFilePdf, PNomeFile);
    TFile.Delete(PPathFilePdf);
    Result.Ok:=True;
  end;
end;

function TWM005FCedolinoFM.ApriFileNelBrowser(PPathFilePdf, PRandomFolder, PNomeFilePdf: String): TResCtrl;
begin
  if not TFile.Exists(TPath.Combine(TPath.Combine(PPathFilePdf, PRandomFolder), PNomeFilePdf)) then
  begin
    Result.Messaggio:='Il cedolino PDF non è stato creato';
    Result.Ok:=False;
  end
  else
  begin
    //UniSession.AddJS('window.open("m/files/' + PNomeFilePdf +'", "_blank")');
    UniSession.AddJS('window.open("' + WM000FServerModule.GlobalCacheURL + UniSession.SessionId + '/' + PRandomFolder + '/' + PNomeFilePdf +'", "_blank")');

    Result.Ok:=True;
  end;
end;

procedure TWM005FCedolinoFM.OnDisclCedolinoClick(Sender: TObject);   //disclosure
var LResCtrl: TResCtrl;
begin
  LResCtrl:= WM005MW.ControllaDate(pnlDataDaA.DataDa.Date, pnlDataDaA.DataA.Date);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    StampaCedolinoPdf((Sender as TMedpUnimPanelDisclosure).Key);
end;

procedure TWM005FCedolinoFM.StampaCedolinoPdf(PIdCedolino: Integer);
var
  LPathFilePdf: String;
  LFilePdf: String;
  LResCtrl: TResCtrl;
  LAzioneCedolino: TAzioneCedolino;
  LMeseCedolino: TDateTime;
  LRandomFolder: String;
begin
  LFilePdf:=Format('%d.pdf',[PIdCedolino]);

  repeat
    LRandomFolder:=IntToStr(Random(1000));
    LPathFilePdf:=TPath.Combine(WM000FServerModule.LocalCachePath,LRandomFolder);
  until not DirectoryExists(LPathFilePdf);

  CreateDir(LPathFilePdf);
  LPathFilePdf:=TPath.Combine(LPathFilePdf,LFilePdf);

  with WM000FMainModule do
  begin
    LResCtrl:= WM005MW.StampaCedolinoPdf(B110ClientModule,
                                         InfoClient,
                                         InfoLogin.ParametriLogin,
                                         PIdCedolino,
                                         LPathFilePdf,
                                         LAzioneCedolino,
                                         LMeseCedolino);
  end;

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    LResCtrl:=ApriFileNelBrowser(WM000FServerModule.LocalCachePath, LRandomFolder, LFilePdf);

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio)
    else
    begin
      case LAzioneCedolino of
        acImpostaConsegna:
          AggiornaListaCedolini;
        acRichiediImpostazioneConsegna:
          AggiornaDataConsegnaCedolino(LMeseCedolino, PIdCedolino);
      end;
    end;
  end;
end;

procedure TWM005FCedolinoFM.AggiornaDataConsegnaCedolino(PMeseCedolino: TDateTime; PIdCedolino: Integer);
var LMsgConferma: String;
    LResCtrl: TResCtrl;
begin
  LMsgConferma:=Format('Si conferma l''avvenuta ricezione del cedolino di %s?',
                                            [FormatDateTime('mmmm yyyy',PMeseCedolino)]);

  if MessageDlg(LMsgConferma,TMsgDlgType.mtConfirmation,mbYesNo) = mrYes then
  begin
    with WM000FMainModule do
    begin
      LResCtrl:= WM005MW.ImpostaDataConsegnaCedolinoSRV(B110ClientModule,
                                                     InfoClient,
                                                     InfoLogin.ParametriLogin,
                                                     PIdCedolino);
    end;
    if LResCtrl.Ok then
    begin
      ShowMessage('Data di consegna impostata');
      AggiornaListaCedolini;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM005FCedolinoFM.AggiornaListaCedolini;
var
  LResCtrl: TResCtrl;
  LListaCedolini: TObjectList<TDatiCedolino>;
  i : Integer;
begin
  pnlListaCedolini.Clear;

  with WM000FMainModule do
    LResCtrl:= WM005MW.AggiornaListaCedoliniSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    try
      LListaCedolini:=WM005MW.GetListaCedolini;

      for i := 0 to LListaCedolini.Count-1 do
      begin
        pnlListaCedolini.Add(CreaPanelCedolino(LListaCedolini[i].LblDataRetribuzione,
                                               LListaCedolini[i].TipoCedolino,
                                               LListaCedolini[i].LblImporto,
                                               LListaCedolini[i].LblDataCedolino), True, LListaCedolini[i].ID, OnDisclCedolinoClick, True);
      end;


    finally
      FreeAndNil(LListaCedolini);
    end;

    pnlNumCedolini.NumElementi:=pnlListaCedolini.NumeroElementi;
  end;
end;

function TWM005FCedolinoFM.CreaPanelCedolino(PDataRetribuzione, PTipoCedolino, PImporto, PDataCedolino: String): TMedpUnimPanel4Labels;
begin
  Result:=TMedpUnimPanel4Labels.Create(Self);

  with Result do
  begin
    Label1.Caption:=PDataRetribuzione;
    Label1.LayoutConfig.Width:='60%';
    Label2.Caption:=PTipoCedolino;
    Label2.LayoutConfig.Width:='40%';
    Label3.Caption:=PImporto;
    Label3.LayoutConfig.Width:='60%';
    if PDataRetribuzione <> PDataCedolino then
      Label4.Caption:=PDataCedolino
    else
      Label4.Caption:='';
    Label4.LayoutConfig.Width:='40%';
  end;
end;

initialization
  RegisterClass(TWM005FCedolinoFM);

end.
