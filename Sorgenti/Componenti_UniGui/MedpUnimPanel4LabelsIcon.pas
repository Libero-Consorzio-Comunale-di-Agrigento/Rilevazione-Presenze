unit MedpUnimPanel4LabelsIcon;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimLabelIcon, MedpUnimPanel4Labels;

type
  TMedpUnimPanel4LabelsIcon = class(TMedpUnimPanelBase)
  private
    FLabels: TMedpUnimPanel4Labels;
    FIcon: TMedpUnimLabelIcon;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Labels: TMedpUnimPanel4Labels read FLabels write FLabels;
    property Icon: TMedpUnimLabelIcon read FIcon write FIcon;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanel4LabelsIcon]);
end;

{ TMedpUnimPanel2LabelsIcon }

constructor TMedpUnimPanel4LabelsIcon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabels:=TMedpUnimPanel4Labels.Create(Self);
  FIcon:=TMedpUnimLabelIcon.Create(Self);

  with FLabels do
  begin
    Flex:=1;
    LayoutConfig.Height:='auto';
    OnClick:=ClickEvent;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FIcon do
  begin
    Caption:='fas fa-paperclip';
    LayoutConfig.Width:='auto';
    LayoutConfig.Margin:='0px 7px 0px 5px';
    JustifyContent:=JustifyCenter;
    OnClick:=ClickEvent;
    Parent:=Self;
    SetSubComponent(True);
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanel4LabelsIcon.SetDefaultProperties;
begin
  inherited;

  Height:=45;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
end;

end.
