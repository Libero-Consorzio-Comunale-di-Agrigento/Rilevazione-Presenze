unit MedpUnimRadioButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabelIcon, MedpUnimLabel, MedpUnimRadioIcon,
  MedpUnimTypes,

  uniGUIConst, uniGUIFont, uniGUIInterfaces,
  uniGUITypes, uniRadioButton;

type
  TMedpUnimRadioButton = class(TMedpUnimPanelBase)
  private
    FIcon: TMedpUnimRadioIcon;
    FLabel: TMedpUnimLabel;

    procedure UpdateParentItemIndex;
  protected
    procedure SetDefaultProperties; override;
    procedure SetEnabled(Value: Boolean); override;
    procedure OnClickLabel(Sender: TObject);
    procedure AdjustAllChecked;
    procedure OnCheckEvent(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property RadioIcon: TMedpUnimRadioIcon read FIcon;
    property RadioLabel: TMedpUnimLabel read FLabel;
  end;

procedure Register;

implementation

uses MedpUnimRadioGroup;

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimRadioButton]);
end;

{ TMedpUnimRadioBtn }

constructor TMedpUnimRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  FIcon:=TMedpUnimRadioIcon.Create(Self);
  FLabel:=TMedpUnimLabel.Create(Self);

  with FIcon do
  begin
    Name:='RadioIcon';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='auto';
    BoxModel.CSSMargin.Top:='2px';
    BoxModel.CSSMargin.Bottom:='2px';
    BoxModel.CSSMargin.Left:='2px';
    BoxModel.CSSMargin.Right:='2px';
    OnCheck:=OnCheckEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FLabel do
  begin
    Name:='RadioLabel';
    Flex:=1;
    Caption:='RadioButton';
    LayoutConfig.Height:='100%';
    JustifyContent:=JustifyStart;
    OnClick:=OnClickLabel;
    Parent:=Self;
    SetSubComponent(True);
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimRadioButton.OnCheckEvent(Sender: TObject);
begin
  AdjustAllChecked;
  //se il parent è un RadioGroup, aggiorno anche l'ItemIndex
  UpdateParentItemIndex;
  DoOnChange;
end;

procedure TMedpUnimRadioButton.OnClickLabel(Sender: TObject);
begin
  if not FIcon.Checked then
  begin
    FIcon.Checked:=True;
    OnCheckEvent(FIcon);
  end;
end;

procedure TMedpUnimRadioButton.AdjustAllChecked;
var
  I : Integer;
  RB : TMedpUnimRadioButton;
begin
  if Assigned(Parent) then
    for I := 0 to Parent.ControlCount - 1 do
      if Parent.Controls[I] is TMedpUnimRadioButton then
      begin
        RB := Parent.Controls[I] as TMedpUnimRadioButton;
        if (RB<>Self) {and (RB.FormControlWebName[0]=Self.FormControlWebName[0])} then
          RB.RadioIcon.Checked := False;
      end;
end;

procedure TMedpUnimRadioButton.SetDefaultProperties;
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

procedure TMedpUnimRadioButton.SetEnabled(Value: Boolean);
begin
  inherited;
  FIcon.Enabled:=Value;
  FLabel.Enabled:=Value;
end;

procedure TMedpUnimRadioButton.UpdateParentItemIndex;
begin
  if Assigned(Parent) then
    if Parent is TMedpUnimRadioGroup then
      (Parent as TMedpUnimRadioGroup).SetItemIndexOnClick(Self);
end;

end.
