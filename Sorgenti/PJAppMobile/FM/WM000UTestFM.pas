unit WM000UTestFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, A000UInterfaccia, WM016UCambioOrarioMW, WM000UMainModule,
  uniLabel, unimLabel, MedpUnimLabel, MedpUnimMemo, Data.DB, uniBasicGrid, WM000UServerModule,
  uniDBGrid, unimDBListGrid, unimDBGrid, System.Generics.Collections, WR002URichiesteMW,
  uniButton, uniBitBtn, unimBitBtn, MedpUnimButton, MedpUnimLabelIcon,
  MedpUnimPanelSlideUp, uniFileUpload, unimFileUpload, unimButton,
  MedpUnimPanel2Button, MedpUnimPanelEditIcons, uniGUITypes, IOUtils, IdSSLOpenSSLHeaders,
  MedpUnimPanelAllegato, uniCheckBox, unimCheckBox, uniPageControl, WM019UModelloCertificazioneMW,
  unimTabPanel, MedpUnimTabPanelBase, uniPanel, WM018UMessaggisticaDM, OracleMonitor,
  MedpUnimPanelMessaggio, MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure,
  MedpUnimPanelDisclosure, uniDateTimePicker, unimDatePicker, MedpUnimDatePicker, {C024UNotifichePushDM,}
  uniEdit, unimEdit, MedpUnimEdit, uniMultiItem, unimSelect, MedpUnimSelect,
  MedpUnimCheckBox, MedpUnimPanelCheckBox, MedpUnimPanelSelect,
  MedpUnimPanelEdit, MedpUnimPanelMemo, MedpUnimPanelDataDaA,
  MedpUnimPanelNumberEdit, unimTimePicker, MedpUnimTimePicker, WM000UMessageDlg,
  MedpUnimMainMenu;

type
  TWM000FTestFM = class(TWM000FFrameBase)
    procedure MedpUnimEdit1AjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure MedpUnimButton1Click(Sender: TObject);
    procedure MedpUnimButton2Click(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
    procedure MedpUnimCheckBox1Click(Sender: TObject);
    procedure MedpUnimCheckBox1Change(Sender: TObject);
    procedure MedpUnimEdit1Change(Sender: TObject);
    procedure MedpUnimEdit1ChangeValue(Sender: TObject);
    procedure MedpUnimEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UniFrameCreate(Sender: TObject);
    procedure MedpUnimMainMenu1ClickItem(Sender: TObject);
  private
    //FUrl, Fp256dh, FAuth: String;
    //C024DM: TC024FNotifichePushDM;
    //WM019ModMW: TWM019FModelloCertificazioneMW;
  public

  end;

implementation

{$R *.dfm}

procedure TWM000FTestFM.MedpUnimButton1Click(Sender: TObject);
begin
  inherited;
  //WM019ModMW.AggiornaPanelModello;
  //TC024FNotifichePushDM.IscrizioneNotifiche(WM000FServerModule.StartPath + 'ec_public.dem', 'inviaDatiAIrisAPP', UniSession.AddJS);
end;

procedure TWM000FTestFM.MedpUnimButton2Click(Sender: TObject);
begin
  inherited;

  //C024DM:=TC024FNotifichePushDM.Create(Self);
  //C024DM.Inizializza(WM000FServerModule.StartPath + 'ec_public.pem', WM000FServerModule.StartPath + 'ec_private.pem', WM000FServerModule.StartPath + 'ec_public.dem', 'IrisAPP', 'a.franco@mondoedp.com', '/');
  //C024DM.InviaNotifica(Fp256dh, FAuth, FUrl, MedpUnimEdit1.Text, '4545');
end;

procedure TWM000FTestFM.MedpUnimCheckBox1Change(Sender: TObject);
begin
  inherited;
  ShowMessage('Change');
end;

procedure TWM000FTestFM.MedpUnimCheckBox1Click(Sender: TObject);
begin
  inherited;
  ShowMessage('Click');
end;

procedure TWM000FTestFM.MedpUnimEdit1AjaxEvent(Sender: TComponent;EventName: string; Params: TUniStrings);
begin
  inherited;

  //FUrl:=Params.Values['url'];
  //Fp256dh:=Params.Values['p256dh'];
  //FAuth:=Params.Values['auth'];
  //TFile.AppendAllText(WM000FServerModule.StartPath + 'url_notifiche.txt', FormatDateTime('yyyy/MM/dd hh:mm:ss', Now) + ' - ' + A000SessioneIrisWIN.Parametri.Operatore + ' - ' + Params.Values['url'] + ' - ' + Params.Values['p256dh'] + ' - ' + Params.Values['auth'] + sLineBreak);
end;

procedure TWM000FTestFM.MedpUnimEdit1Change(Sender: TObject);
begin
  inherited;
  ShowMessage('Change');
end;

procedure TWM000FTestFM.MedpUnimEdit1ChangeValue(Sender: TObject);
begin
  inherited;
  ShowMessage('ChangeValue');
end;

procedure TWM000FTestFM.MedpUnimEdit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  //MedpUnimEdit1.Text:='Prova';
end;

procedure TWM000FTestFM.MedpUnimMainMenu1ClickItem(Sender: TObject);
begin
  inherited;

  if Sender is TComponent then
    ShowMessage((Sender as TComponent).Tag.ToString);
end;

procedure TWM000FTestFM.UniFrameCreate(Sender: TObject);
begin
  inherited;
  //MedpUnimMainMenu1.Add('Testo di prova1', 0, 1);
  //MedpUnimMainMenu1.Add('Testo di prova2', 0, 2);
  //MedpUnimMainMenu1.Add('Testo di prova3', 0, 3);
end;

procedure TWM000FTestFM.UniFrameReady(Sender: TObject);
begin
  inherited;
  //TC024FNotifichePushDM.IscrizioneNotifiche(WM000FServerModule.StartPath + 'ec_public.dem', 'inviaDatiAIrisAPP', UniSession.AddJS);

  //WM019ModMW:=TWM019FModelloCertificazioneMW.Create(MedpUnimPanelBase1, A000SessioneIrisWin);
  //UnimSelect1.JSInterface.JSCall('setEditable', ['true']);
end;

initialization
  RegisterClass(TWM000FTestFM);

end.
