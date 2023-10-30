unit MedpUnimPanelOraDaA;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimTimePicker, MedpUnimLabel, uniGUITypes, MedpUnimTypes, MedpUnimPanelBase;

type

  TMedpUnimPanelOraDaA = class(TMedpUnimPanelBase)
  private
    FedtOraDa: TMedpUnimTimePicker;
    FlblSeparatore: TMedpUnimLabel;
    FedtOraA: TMedpUnimTimePicker;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OraDa: TMedpUnimTimePicker read FedtOraDa;
    property Separatore: TMedpUnimLabel read FlblSeparatore;
    property OraA: TMedpUnimTimePicker read FedtOraA;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelOraDaA]);
end;

constructor TMedpUnimPanelOraDaA.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FedtOraDa:=TMedpUnimTimePicker.Create(Self);
  FlblSeparatore:=TMedpUnimLabel.Create(Self);
  FedtOraA:=TMedpUnimTimePicker.Create(Self);

  with FedtOraDa do
  begin
    Flex:=1;
    Name:='edtOraDa';
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

  with FedtOraA do
  begin
    Flex:=1;
    Name:='edtOraA';
    LayoutConfig.Height:='100%';
    OnChange:=ChangeEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelOraDaA.SetDefaultProperties;
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

end.
