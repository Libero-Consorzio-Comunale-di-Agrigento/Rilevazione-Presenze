unit WC020UInputDataOreFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, meIWEdit,
  IWCompLabel, meIWLabel, WR010UBase, A000UInterfaccia, A000UMessaggi,
  medpIWMessageDlg, C180FunzioniGenerali;

type
  TWC020ModalResultEvents = procedure(Sender: TObject; Result: Boolean;Valore: String) of object;
  TWC020InputType = (itOre, itData, itText, itPeriodo);

  TWC020FInputDataOreFM = class(TWR200FBaseFM)
    edtOre: TmeIWEdit;
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblEtichettaOre: TmeIWLabel;
    edtData: TmeIWEdit;
    lblEtichettaData: TmeIWLabel;
    edtTextField: TmeIWEdit;
    lblEtichettaTextField: TmeIWLabel;
    lblEtichettaDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    FormatoData: String;
    InputType: TWC020InputType;
  public
    ResultEvent:TWC020ModalResultEvents;
    procedure ImpostaCampiOre(EtichettaOre, ValoreOre: String);
    procedure ImpostaCampiText(EtichettaText, ValoreText: String);
    procedure ImpostaCampiData(EtichettaData : String; ValoreData: TDateTime;Formato: String);
    procedure ImpostaCampiPeriodo(EtichettaData, EtichettaDataA: String;
      ValoreDa, Valorea: TDateTime; Formato: String);
    procedure Visualizza(Titolo: String);
  end;

implementation

{$R *.dfm}

procedure TWC020FInputDataOreFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FormatoData:='dd/mm/yyyy';
  lblEtichettaData.Caption:='';
  lblEtichettaDataA.Caption:='';
  lblEtichettaOre.Caption:='';
  lblEtichettaOre.Visible:=False;
  lblEtichettaData.Visible:=False;
  lblEtichettaDataA.Visible:=False;
  edtOre.Visible:=False;
  edtData.Visible:=False;
  edtDataA.Visible:=False;
  lblEtichettaTextField.Visible:=False;
  edtTextField.Visible:=False;
end;

procedure TWC020FInputDataOreFM.ImpostaCampiOre(EtichettaOre, ValoreOre: String);
begin
  lblEtichettaOre.Caption:=EtichettaOre;
  edtOre.Text:=ValoreOre;
  lblEtichettaOre.Visible:=True;
  edtOre.Visible:=True;
  InputType:=itOre;
end;

procedure TWC020FInputDataOreFM.ImpostaCampiText(EtichettaText, ValoreText: String);
begin
  lblEtichettaTextField.Caption:=EtichettaText;
  edtTextField.Text:=ValoreText;
  lblEtichettaTextField.Visible:=True;
  edtTextField.Visible:=True;
  InputType:=itText;
end;

procedure TWC020FInputDataOreFM.edtDataAAsyncChange(Sender: TObject;
  EventParams: TStringList);
var DataDa, DataA: TDateTime;
begin
  if InputType = itPeriodo then
  begin
    if FormatoData = 'dd/mm/yyyy' then
    begin
      if TryStrToDate(edtData.Text,DataDa) and TryStrToDate(edtDataA.Text,DataA) then
      begin
        if DataA < DataDa then
          edtData.Text:=FormatDateTime(FormatoData,DataA);
      end;
    end;
  end;
end;

procedure TWC020FInputDataOreFM.edtDataAsyncChange(Sender: TObject;
  EventParams: TStringList);
var DataDa, DataA: TDateTime;
begin
  if InputType = itPeriodo then
  begin
    if FormatoData = 'dd/mm/yyyy' then
    begin
      if TryStrToDate(edtData.Text,DataDa) and TryStrToDate(edtDataA.Text,DataA) then
      begin
        if DataA < DataDa then
          edtDataA.Text:=FormatDateTime(FormatoData,DataDa);
      end;
    end;
  end;
end;

procedure TWC020FInputDataOreFM.ImpostaCampiData(EtichettaData : String; ValoreData: TDateTime; Formato: String);
begin
  FormatoData:=Formato;
  if Formato = 'mm/yyyy' then
    edtData.Css:='input_data_my width10chr';
  lblEtichettaData.Caption:=EtichettaData;
  edtData.Text:=FormatDateTime(FormatoData,ValoreData);
  lblEtichettaData.Visible:=True;
  edtData.Visible:=True;
  InputType:=itData;
end;

procedure TWC020FInputDataOreFM.ImpostaCampiPeriodo(EtichettaData, EtichettaDataA: String;
  ValoreDa, Valorea: TDateTime; Formato: String);
begin
  FormatoData:=Formato;
  if Formato = 'mm/yyyy' then
  begin
    edtData.Css:='input_data_my width10chr';
    edtDataA.Css:=edtData.Css;
  end;
  lblEtichettaData.Caption:=EtichettaData;
  lblEtichettaDataA.Caption:=EtichettaDataA;
  if ValoreDa <> DATE_NULL then
    edtData.Text:=FormatDateTime(FormatoData,ValoreDa)
  else
    edtData.Text:='';

  if ValoreA <> DATE_NULL then
    edtDataA.Text:=FormatDateTime(FormatoData,ValoreA)
  else
    edtDataA.Text:='';

  lblEtichettaData.Visible:=True;
  lblEtichettaDataA.Visible:=True;
  edtData.Visible:=True;
  edtDataA.Visible:=True;
  InputType:=itPeriodo;
end;

procedure TWC020FInputDataOreFM.Visualizza(Titolo: String);
begin
  TWR010FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,370,150,150, Titolo,'#wc020_container',False,True);
end;

procedure TWC020FInputDataOreFM.btnChiudiClick(Sender: TObject);
var Res : Boolean;
    Valore, ValDa, ValA: String;
    locResultEvent:TWC020ModalResultEvents;
begin
  Res:=Sender = btnConferma;
  Valore:='';

  if Res then
  begin
    if InputType = itData then
    begin
      try
        if FormatoData = 'mm/yyyy' then
          Valore:='01/' + edtData.Text
        else
          Valore:=edtData.Text;

        StrToDate(Valore);
      except
        MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
        Abort;
      end;
    end;
    if InputType = itPeriodo then
    begin
      try
        if FormatoData = 'mm/yyyy' then
        begin
          ValDa:='01/' + edtData.Text;
          ValA:='01/' + edtDataA.Text;
        end
        else
        begin
          ValDa:=edtData.Text;
          ValA:=edtDataA.Text;
        end;

        StrToDate(ValDa);
        StrToDate(ValA);

        Valore:=ValDa + ',' + ValA;
      except
        MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
        Abort;
      end;
    end;
    if InputType = itOre then
      Valore:=edtOre.Text;
    if InputType = itText  then
      Valore:=edtTextField.Text;
  end;

  //Salvataggio dell'eventuale ResultEvent per anticipare il Free del componente
  locResultEvent:=ResultEvent;

  ReleaseOggetti;
  Free;

  if Assigned(locResultEvent) then
  try
    locResultEvent(Self,Res,Valore);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
end;

end.
