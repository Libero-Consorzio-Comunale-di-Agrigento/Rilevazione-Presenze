unit MedpUnimPanelDatePicker;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimDatePicker;

type
  TMedpUnimPanelDatePicker = class(TMedpUnimPanelBase)
  private
    FLabel: TMedpUnimLabel;
    FDatePicker: TMedpUnimDatePicker;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PanelLabel: TMedpUnimLabel read FLabel;
    property DatePicker: TMedpUnimDatePicker read FDatePicker;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelDatePicker]);
end;

{ TMedpUnimPanelDatePicker }

constructor TMedpUnimPanelDatePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel:=TMedpUnimLabel.Create(Self);
  FDatePicker:=TMedpUnimDatePicker.Create(Self);

  with FLabel do
  begin
    Name:='Label';
    Caption:='';
    Flex:=1;
    LayoutConfig.Height:='auto';
    JustifyContent:=JustifyStart;
    OnClick:=nil;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FDatePicker do
  begin
    Name:='Edit';
    Caption:='';
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelDatePicker.SetDefaultProperties;
begin
  inherited;

  Height:=30;
  Width:=100;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='auto';
  LayoutConfig.Height:='auto';
  OnClick:=nil;
end;

end.
