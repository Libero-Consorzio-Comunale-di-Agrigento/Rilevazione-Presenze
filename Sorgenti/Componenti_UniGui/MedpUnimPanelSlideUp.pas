unit MedpUnimPanelSlideUp;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimButton, MedpUnimLabel, Vcl.Graphics;

type
  TMedpUnimPanelSlideUp = class(TMedpUnimPanelBase)
  private
    FlblSlide: TMedpUnimLabel;
    FAperto: Boolean;
    FHeightAperto: Integer;
  protected
    procedure SetDefaultProperties;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property HeightAperto: Integer read FHeightAperto write FHeightAperto default 75;
    procedure OnClickSlide(Sender: TObject);
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelSlideUp]);
end;

{ TMedpUnimPanelSlideUp }

constructor TMedpUnimPanelSlideUp.Create(AOwner: TComponent);
begin
  inherited;
  FAperto:=False;
  FlblSlide:=TMedpUnimLabel.Create(Self);

  with FlblSlide do
  begin
    Caption:='<i class="fas fa-angle-up"></i>';
    ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("background-color: #157fcc");}');
    LayoutConfig.Height:='30';
    LayoutConfig.Width:='100%';
    Font.Size:=21;
    Font.Color:=clWhite;
    OnClick:=OnClickSlide;
    SetSubComponent(True);
  end;

  FlblSlide.Parent:=Self;
  SetDefaultProperties;
end;

procedure TMedpUnimPanelSlideUp.SetDefaultProperties;
begin
  inherited;

  Height:=150;
  Width:=200;
  Layout:='vbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  Flex:=0;
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='30';
  BoxModel.CSSBorderRadius:='15px 15px 0px 0px';

  ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("transition: width 500ms, height 500ms");}');
end;

procedure TMedpUnimPanelSlideUp.OnClickSlide(Sender: TObject);
begin
  if FAperto then
  begin
    FlblSlide.Caption:='<i class="fas fa-angle-up"></i>';
    JSInterface.JSCall('setHeight', [30]);
  end
  else
  begin
    FlblSlide.Caption:='<i class="fas fa-angle-down"></i>';
    JSInterface.JSCall('setHeight', [FHeightAperto]);
  end;
  FAperto:=not FAperto;
end;

end.
