unit MedpUnimPanelSelect;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimSelect;

type
  TMedpUnimPanelSelect = class(TMedpUnimPanelBase)
  private
    FLabel: TMedpUnimLabel;
    FSelect: TMedpUnimSelect;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PanelLabel: TMedpUnimLabel read FLabel;
    property Select: TMedpUnimSelect read FSelect;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelSelect]);
end;

{ TMedpUnimPanelSelect }

constructor TMedpUnimPanelSelect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel:=TMedpUnimLabel.Create(Self);
  FSelect:=TMedpUnimSelect.Create(Self);

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

  with FSelect do
  begin
    Name:='Select';
    Caption:='';
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelSelect.SetDefaultProperties;
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
