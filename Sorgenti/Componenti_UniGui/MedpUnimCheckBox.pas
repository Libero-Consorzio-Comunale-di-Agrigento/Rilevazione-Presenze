unit MedpUnimCheckBox;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniCheckBox, unimCheckBox, MedpUnimPanelBase, MedpUnimLabel;

type
  TMedpUnimCheckBox = class(TMedpUnimPanelBase)
  private
    FCheck: TUnimCheckBox;
    FLabel: TMedpUnimLabel;
  protected
    procedure SetDefaultProperties; override;
    procedure OnClickLabel(Sender: TObject);
    procedure OnClickEvent(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CheckIcon: TUnimCheckBox read FCheck;
    property CheckLabel: TMedpUnimLabel read FLabel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimCheckBox]);
end;

{ TMedpUnimCheckBox }

constructor TMedpUnimCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCheck:=TUnimCheckBox.Create(Self);
  FLabel:=TMedpUnimLabel.Create(Self);

  with FCheck do
  begin
    Name:='Check';
    Caption:='';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='auto';
    LayoutConfig.Margin:='3px 3px 3px 3px';
    OnClick:=OnClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FLabel do
  begin
    Name:='CheckLabel';
    Flex:=1;
    Caption:='';
    LayoutConfig.Height:='100%';
    //BoxModel.CSSMargin.Left:='5px';
    JustifyContent:=JustifyStart;
    OnClick:=OnClickLabel;
    Parent:=Self;
    SetSubComponent(True);
  end;
  SetDefaultProperties;
end;

procedure TMedpUnimCheckBox.SetDefaultProperties;
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

procedure TMedpUnimCheckBox.OnClickEvent(Sender: TObject);
begin
  DoOnClick;
end;

procedure TMedpUnimCheckBox.OnClickLabel(Sender: TObject);
begin
  if not FCheck.ReadOnly and FCheck.Enabled then
  begin
    FCheck.Checked:=not FCheck.Checked;
    OnClickEvent(FCheck);
  end;
end;

end.
