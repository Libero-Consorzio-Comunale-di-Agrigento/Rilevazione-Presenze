unit MedpUnimPanelDataDaA;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimLabelIcon,
  uniGUIClasses, uniGUImJSForm, MedpUnimDatePicker, MedpUnimLabel, uniGUITypes, MedpUnimTypes, MedpUnimPanelBase;

type

  TMedpUnimPanelDataDaA = class(TMedpUnimPanelBase)
  private
    FiconClear: TMedpUnimLabelIcon;
    FedtDataDa: TMedpUnimDatePicker;
    FlblSeparatore: TMedpUnimLabel;
    FedtDataA: TMedpUnimDatePicker;
    procedure OnClickClear(Sender: TObject);
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ClearIcon: TMedpUnimLabelIcon read FiconClear;
    property DataDa: TMedpUnimDatePicker read FedtDataDa;
    property Separatore: TMedpUnimLabel read FlblSeparatore;
    property DataA: TMedpUnimDatePicker read FedtDataA;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelDataDaA]);
end;

constructor TMedpUnimPanelDataDaA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FiconClear:=TMedpUnimLabelIcon.Create(Self);
  FedtDataDa:=TMedpUnimDatePicker.Create(Self);
  FlblSeparatore:=TMedpUnimLabel.Create(Self);
  FedtDataA:=TMedpUnimDatePicker.Create(Self);

  with FiconClear do
  begin
    Caption:='fas fa-times-circle';
    Name:='iconClear';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='auto';
    Font.Size:=17;
    BoxModel.CSSPadding.Top:='5px';
    BoxModel.CSSPadding.Right:='5px';
    BoxModel.CSSPadding.Bottom:='5px';
    BoxModel.CSSPadding.Left:='0px';
    CSSColor:='#b0b0b0';
    SetSubComponent(True);
    Parent:=Self;
    OnClick:=OnClickClear;
    Visible:=False;
  end;

  with FedtDataDa do
  begin
    Flex:=1;
    Name:='edtDataDa';
    LayoutConfig.Height:='100%';
    OnChange:=ChangeEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FlblSeparatore do
  begin
    Caption:='-';
    Name:='lblSeparatore';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='20';
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FedtDataA do
  begin
    Flex:=1;
    Name:='edtDataA';
    LayoutConfig.Height:='100%';
    OnChange:=ChangeEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelDataDaA.SetDefaultProperties;
begin
  inherited;

  Height:=40;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Height:='35';
  LayoutConfig.Width:='100%';
end;

procedure TMedpUnimPanelDataDaA.OnClickClear(Sender: TObject);
begin
  FedtDataDa.Text:='';
  FedtDataA.Text:='';
  OnChange(Self);
end;

end.
