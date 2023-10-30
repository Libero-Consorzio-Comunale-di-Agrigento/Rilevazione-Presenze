unit MedpUnimPanelDisclosure;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, unimPanel, MedpUnimLabelIcon, MedpUnimPanelBase;

type
  TMedpUnimPanelDisclosure = class(TMedpUnimPanelBase)
  private
    FKey: Variant;
    FData: TObject;
  protected
    FlblDisclosureIcon: TMedpUnimLabelIcon;
    FpnlBase: TMedpUnimPanelBase;

    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure InsertBasePanel(Value: TMedpUnimPanelBase);
    //procedure LoadCompleted; override;
  published
    property BasePanel: TMedpUnimPanelBase read FpnlBase;
    property DisclosureIcon: TMedpUnimLabelIcon read FlblDisclosureIcon;
    property Key: Variant read FKey write FKey;
    property Data: TObject read FData write FData;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelDisclosure]);
end;

{ TMedpUnimDisclosurePanel }

constructor TMedpUnimPanelDisclosure.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FpnlBase:=TMedpUnimPanelBase.Create(Self);

  with FpnlBase do
  begin
    Layout:='fit';
    Flex:=1;
    LayoutConfig.Height:='auto';
    SetSubComponent(True);
    Parent:=Self;
  end;

  FlblDisclosureIcon:=TMedpUnimLabelIcon.Create(Self);

  with FlblDisclosureIcon do
  begin
    Caption:='fas fa-arrow-circle-right';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='40';
    Font.Size:=20;
    OnClick:=Self.ClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

{procedure TMedpUnimPanelDisclosure.LoadCompleted;
begin
  inherited;
  //FpnlBase.ScreenMask:=ScreenMask;
  FlblDisclosureIcon.ScreenMask:=ScreenMask;
end;}

procedure TMedpUnimPanelDisclosure.SetDefaultProperties;
begin
  inherited;

  Height:=45;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
  Constraints.MinHeight:=30;
end;

procedure TMedpUnimPanelDisclosure.InsertBasePanel(Value: TMedpUnimPanelBase);
var i: Integer;
begin
  for i := (FpnlBase.ControlCount - 1) downto 0 do
    FpnlBase.controls[i].Free;

  FlblDisclosureIcon.ScreenMask:=ScreenMask;

  for i := (Value.ControlCount - 1) downto 0 do
    if Value.controls[i] is TUniControl then
      (Value.controls[i] as TUniControl).ScreenMask:=ScreenMask;

  Value.OnClick:=Self.ClickEvent;
  Value.SetSubComponent(True);
  Value.Parent:=FpnlBase;
  FpnlBase.InsertComponent(Value);
end;



end.
