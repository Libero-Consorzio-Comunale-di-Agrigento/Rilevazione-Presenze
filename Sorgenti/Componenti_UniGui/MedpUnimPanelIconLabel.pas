unit MedpUnimPanelIconLabel;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimLabelIcon;

type
  TMedpUnimPanelIconLabel = class(TMedpUnimPanelBase)
  private
    FIcon: TMedpUnimLabelIcon;
    FLabel1: TMedpUnimLabel;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Icon: TMedpUnimLabelIcon read FIcon write FIcon;
    property Label1: TMedpUnimLabel read FLabel1 write FLabel1;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelIconLabel]);
end;

constructor TMedpUnimPanelIconLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FIcon:=TMedpUnimLabelIcon.Create(Self);
  FLabel1:=TMedpUnimLabel.Create(Self);

  with FIcon do
  begin
    Flex:=0;
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='auto';
    BoxModel.CSSMargin.Right:='8px';
    Font.Size:=18;
    OnClick:=ClickEvent;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FLabel1 do
  begin
    Flex:=1;
    LayoutConfig.Height:='auto';
    BoxModel.CSSMargin.Top:='3px';
    BoxModel.CSSMargin.Bottom:='3px';
    OnClick:=ClickEvent;
    Parent:=Self;
    SetSubComponent(True);
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelIconLabel.SetDefaultProperties;
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
