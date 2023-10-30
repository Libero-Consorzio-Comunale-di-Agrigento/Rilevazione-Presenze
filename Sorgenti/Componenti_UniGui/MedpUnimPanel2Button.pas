unit MedpUnimPanel2Button;

interface
uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimButton;

type
  TMedpUnimPanel2Button = class(TMedpUnimPanelBase)
  private
    FButton1: TMedpUnimButton;
    FButton2: TMedpUnimButton;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Button1: TMedpUnimButton read FButton1 write FButton1;
    property Button2: TMedpUnimButton read FButton2 write FButton2;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanel2Button]);
end;

constructor TMedpUnimPanel2Button.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FButton1:=TMedpUnimButton.Create(Self);
  FButton2:=TMedpUnimButton.Create(Self);

  with FButton1 do
  begin
    Flex:=1;
    Name:='Button1';
    LayoutConfig.Height:='50';
    Caption:='Button1';
    //IconCls:='trash';
    BoxModel.CSSMargin.Right:='0px';
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FButton2 do
  begin
    Flex:=1;
    Name:='Button2';
    LayoutConfig.Height:='50';
    Caption:='Button2';
    //IconCls:='delete';
    BoxModel.CSSMargin.Left:='6px';
    Parent:=Self;
    SetSubComponent(True);
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanel2Button.SetDefaultProperties;
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
