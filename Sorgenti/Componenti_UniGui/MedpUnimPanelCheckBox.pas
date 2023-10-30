unit MedpUnimPanelCheckBox;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimCheckBox;

type
  TMedpUnimPanelCheckBox = class(TMedpUnimPanelBase)
  private
    FLabel: TMedpUnimLabel;
    FCheck: TMedpUnimCheckBox;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PanelLabel: TMedpUnimLabel read FLabel;
    property CheckBox: TMedpUnimCheckBox read FCheck;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelCheckBox]);
end;

{ TMedpUnimPanelCheckBox }

constructor TMedpUnimPanelCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel:=TMedpUnimLabel.Create(Self);
  FCheck:=TMedpUnimCheckBox.Create(Self);

  with FLabel do
  begin
    Name:='Label';
    Caption:='';
    Flex:=1;
    LayoutConfig.Height:='auto';
    //LayoutConfig.Width:='50%';
    JustifyContent:=JustifyStart;
    OnClick:=nil;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FCheck do
  begin
    Name:='Check';
    Caption:='';
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelCheckBox.SetDefaultProperties;
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
