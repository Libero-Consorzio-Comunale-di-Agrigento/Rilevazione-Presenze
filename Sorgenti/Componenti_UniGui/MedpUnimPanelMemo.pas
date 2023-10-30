unit MedpUnimPanelMemo;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimMemo;

type
  TMedpUnimPanelMemo = class(TMedpUnimPanelBase)
  private
    FLabel: TMedpUnimLabel;
    FMemo: TMedpUnimMemo;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PanelLabel: TMedpUnimLabel read FLabel;
    property Memo: TMedpUnimMemo read FMemo;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelMemo]);
end;

{ TMedpUnimPanelMemo }

constructor TMedpUnimPanelMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel:=TMedpUnimLabel.Create(Self);
  FMemo:=TMedpUnimMemo.Create(Self);

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

  with FMemo do
  begin
    Name:='Memo';
    Caption:='';
    LayoutConfig.Height:='50px';
    LayoutConfig.Width:='50%';
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelMemo.SetDefaultProperties;
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
