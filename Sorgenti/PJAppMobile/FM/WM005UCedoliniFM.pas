unit WM005UCedoliniFM;

interface

uses
  A000UCostanti,
  B110USharedTypes,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  WM000UConstants,
  FunzioniGenerali,
  System.DateUtils,
  System.Math,
  System.IOUtils,
  System.Types,
  System.UITypes,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uniMemo, unimMemo, uniDateTimePicker, unimDatePicker, uniGUImJSForm,
  unimPanel, uniGUIBaseClasses, uniLabel, unimLabel, uniMultiItem, unimList,
  Data.FireDACJSONReflect, WM005UCedoliniMW, Generics.Collections, System.Messaging;

type

  TLabelDatoCedolino = class(TUnimLabel)
    private
    public
      constructor Create(AOwner: TComponent; PCreateOrder: Integer; PWidth: String; PCaption: String);
  end;

  TLabelDisclosure = class(TUnimLabel)
    private
      FIdCedolino: Integer;
       MessageManager: TMessageManager;
    public
      constructor Create(AOwner: TComponent; PIdCedolino: Integer; PMessageManager: TMessageManager);
      procedure lblDisclosureClick(Sender: TObject);
  end;

  TPanelDatiCedolino = class(TUnimContainerPanel)
    private
      lblDataRetribuzione : TLabelDatoCedolino;
      lblTipoCedolino : TLabelDatoCedolino;
      lblImporto : TLabelDatoCedolino;
      lblDataCedolino : TLabelDatoCedolino;
    public
      constructor Create(AOwner: TComponent; DataRetribuzione, TipoCedolino, Importo, DataCedolino: String);
  end;

  TListaCedoliniItem = class(TUnimContainerPanel)
    private
      pnlDatiCedolino: TPanelDatiCedolino;
      lblDisclosure: TLabelDisclosure;
    public
      constructor Create(AOwner: TComponent; PCreateOrder: Integer; IdCedolino: Integer; DataRetribuzione, TipoCedolino, Importo, DataCedolino: String; PMessageManager: TMessageManager);
  end;

  TWM005FCedoliniFM = class(TUniFrame)
    UnimContainerPanel2: TUnimContainerPanel;
    pnlHeader: TUnimContainerPanel;
    lblMesiRiferimento: TUnimLabel;
    pnlDate: TUnimContainerPanel;
    edtMeseDa: TUnimDatePicker;
    UnimContainerPanel4: TUnimContainerPanel;
    edtMeseA: TUnimDatePicker;
    lblNumCedolini: TUnimLabel;
    procedure UniFrameDestroy(Sender: TObject);
    procedure edtMeseChange(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
  private
    WM005MW: TWM005FCedoliniMW;
    MessageManager: TMessageManager;

    procedure AggiornaListaCedolini;
    procedure SvuotaListaCedolini;
    procedure ValutaStampaCedolinoPdf(const Sender: TObject; const M: TMessage);
    procedure StampaCedolinoPdf(PIdCedolino: Integer);
    procedure AggiornaDataConsegnaCedolino(PMeseCedolino: TDateTime; PIdCedolino: Integer);
    function InviaFile(PPathFilePdf, PNomeFile: String): TResCtrl;
    function ApriFileNelBrowser(PPathFilePdf, PNomeFilePdf: String): TResCtrl;

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

procedure TWM005FCedoliniFM.UniFrameCreate(Sender: TObject);
begin
  with WM000FMainModule.InfoLogin.DatiGenerali do
  begin
    WM005MW:= TWM005FCedoliniMW.Create(Parametri.WEBCedoliniDataMin,
                                       Parametri.WEBCedoliniMMPrec);
  end;

  edtMeseDa.Date:=WM005MW.MeseDa;
  edtMeseA.Date:=WM005MW.MeseA;

  MessageManager := TMessageManager.Create;
  MessageManager.SubscribeToMessage(TMessage<Integer>, ValutaStampaCedolinoPdf);

  AggiornaListaCedolini;
end;

procedure TWM005FCedoliniFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM005MW);
  FreeAndNil(MessageManager);
end;

procedure TWM005FCedoliniFM.edtMeseChange(Sender: TObject);
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:= WM005MW.ControllaDate(edtMeseDa.Date, edtMeseA.Date);

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    AggiornaListaCedolini;
end;

function TWM005FCedoliniFM.InviaFile(PPathFilePdf, PNomeFile: String): TResCtrl;
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

function TWM005FCedoliniFM.ApriFileNelBrowser(PPathFilePdf, PNomeFilePdf: String): TResCtrl;
begin
  if not TFile.Exists(PPathFilePdf + PNomeFilePdf) then
  begin
    Result.Messaggio:='Il cartellino PDF non è stato creato';
    Result.Ok:=False;
  end
  else
  begin
    //UniSession.AddJS('window.open("m/files/' + PNomeFilePdf +'", "_blank")');
    UniSession.AddJS('window.open("m/cache/uniguitest_exe/' + UniSession.SessionId + '/' + PNomeFilePdf +'", "_blank")');

    Result.Ok:=True;
  end;
end;

procedure TWM005FCedoliniFM.SvuotaListaCedolini;
var i: Integer;
begin
  for i := (UnimContainerPanel2.ControlCount - 1) downto 0 do
    if UnimContainerPanel2.controls[i].Name <> 'pnlHeader' then
      UnimContainerPanel2.controls[i].Free;
end;

procedure TWM005FCedoliniFM.ValutaStampaCedolinoPdf(const Sender: TObject; const M: TMessage);
var LResCtrl: TResCtrl;
begin
  if Sender is TLabelDisclosure then
  begin
    LResCtrl:= WM005MW.ControllaDate(edtMeseDa.Date, edtMeseA.Date);

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio)
    else
      StampaCedolinoPdf((M as TMessage<Integer>).Value);
  end;
end;

procedure TWM005FCedoliniFM.StampaCedolinoPdf(PIdCedolino: Integer);
var
  LPathFilePdf: String;
  LFilePdf: String;
  LNomeFile: String;
  LResCtrl: TResCtrl;
  LAzioneCedolino: TAzioneCedolino;
  LMeseCedolino: TDateTime;
begin
  LFilePdf:=Format('%d.pdf',[PIdCedolino]);
  LPathFilePdf:=TPath.Combine(WM000FServerModule.LocalCachePath,LFilePdf);
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
    LResCtrl:=ApriFileNelBrowser(WM000FServerModule.LocalCachePath, LFilePdf);

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

procedure TWM005FCedoliniFM.AggiornaDataConsegnaCedolino(PMeseCedolino: TDateTime; PIdCedolino: Integer);
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

procedure TWM005FCedoliniFM.AggiornaListaCedolini;
var
  LResCtrl: TResCtrl;
  LListaCedolini: TObjectList<TDatiCedolino>;
  i : Integer;
begin
  with WM000FMainModule do
  begin
    LResCtrl:= WM005MW.AggiornaListaCedoliniSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);
  end;

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    lblNumCedolini.Text:=WM005MW.StringaNumCedolini;
    SvuotaListaCedolini;
    try
      LListaCedolini:=WM005MW.GetListaCedolini;

      for i := 0 to LListaCedolini.Count-1 do
      begin
        with TListaCedoliniItem.Create(UnimContainerPanel2, i+1,
                                            LListaCedolini[i].ID,
                                            LListaCedolini[i].LblDataRetribuzione,
                                            LListaCedolini[i].TipoCedolino,
                                            LListaCedolini[i].LblImporto,
                                            LListaCedolini[i].LblDataCedolino,
                                            MessageManager) do
        begin
          Parent:=UnimContainerPanel2;
        end;
      end;
    finally
      FreeAndNil(LListaCedolini);
    end;
  end;
end;

//------------------------------------------------------------------------------------------------------------------------------------------------------

{ TLabelDatoCedolino }

constructor TLabelDatoCedolino.Create(AOwner: TComponent; PCreateOrder: Integer; PWidth, PCaption: String);
begin
  inherited Create(AOwner);

  CreateOrder:=PCreateOrder;
  Caption:=PCaption;
  LayoutConfig.Height:='26';
  LayoutConfig.Width:=PWidth;
  ClientEvents.UniEvents.Append('afterCreate=function afterCreate(sender){sender.setStyle("display: flex; justify-content: flex-start; align-items: center; font-size: 15px;");}');
end;

{ TLabelDisclosure }

constructor TLabelDisclosure.Create(AOwner: TComponent; PIdCedolino: Integer; PMessageManager: TMessageManager);
begin
  inherited Create(AOwner);

  FIdCedolino:=PIdCedolino;

  CreateOrder:=2;
  Caption:='<div class="x-tool x-component x-tool-listitem x-component-listitem x-center"><div class="x-icon-el x-font-icon x-tool-type-disclosure"></div></div>';
  ClientEvents.UniEvents.Append('afterCreate=function afterCreate(sender){sender.setStyle("display: flex; justify-content: center; align-items: center;");}');
  LayoutConfig.Height:='100%';
  LayoutConfig.Width:='50';

  MessageManager:=PMessageManager;

  OnClick:=lblDisclosureClick;
end;

procedure TLabelDisclosure.lblDisclosureClick(Sender: TObject);
var Message: TMessage;
begin
  Message := TMessage<Integer>.Create(FIdCedolino);
  MessageManager.SendMessage(Sender, Message, True);
end;

{ TPanelDatiCedolino }

constructor TPanelDatiCedolino.Create(AOwner: TComponent; DataRetribuzione, TipoCedolino, Importo, DataCedolino: String);
begin
  inherited Create(AOwner);

  CreateOrder:= 1;
  Layout:='float';
  LayoutConfig.Padding:='5';
  LayoutConfig.Height:='100%';
  Flex:=1;

  lblDataRetribuzione:=TLabelDatoCedolino.Create(Self, 1, '60%', DataRetribuzione);
  lblDataRetribuzione.Parent:=Self;

  lblTipoCedolino:=TLabelDatoCedolino.Create(Self, 2, '40%', TipoCedolino);
  lblTipoCedolino.Parent:=Self;

  lblImporto:=TLabelDatoCedolino.Create(Self, 3, '60%', Importo);
  lblImporto.Parent:=Self;

  if DataRetribuzione = DataCedolino then
    lblDataCedolino:=TLabelDatoCedolino.Create(Self, 4, '40%', '')
  else
    lblDataCedolino:=TLabelDatoCedolino.Create(Self, 4, '40%', DataCedolino);

  lblDataCedolino.Parent:=Self;
end;

{ TListaCedoliniItem }

constructor TListaCedoliniItem.Create(AOwner: TComponent; PCreateOrder: Integer; IdCedolino: Integer; DataRetribuzione, TipoCedolino, Importo, DataCedolino: String; PMessageManager: TMessageManager);
begin
  inherited Create(AOwner);

  CreateOrder:=PCreateOrder;
	Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Height:='auto';
  LayoutConfig.Width:='100%';
  Constraints.MaxWidth:=400;

  if (CreateOrder mod 2) = 0  then
    Color:=StrToInt('$FAFAFA')
  else
    Color:=clBtnFace;

  ClientEvents.UniEvents.Append('afterCreate=function afterCreate(sender){sender.setStyle("border-width: 1px 0; border-style: solid; border-color: #f0f0f0; padding-left: 8px;");}');

  pnlDatiCedolino:= TPanelDatiCedolino.Create(Self, DataRetribuzione, TipoCedolino, Importo, DataCedolino);
  pnlDatiCedolino.Parent:=Self;

  lblDisclosure:= TLabelDisclosure.Create(Self, IdCedolino, PMessageManager);
  lblDisclosure.Parent:=Self;
end;

initialization
  RegisterClass(TWM005FCedoliniFM);

end.
