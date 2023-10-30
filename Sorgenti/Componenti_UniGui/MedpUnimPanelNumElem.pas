unit MedpUnimPanelNumElem;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimLabelIcon;

type
  TMedpUnimPanelNumElem = class(TMedpUnimPanelBase)
  private
    FLabel: TMedpUnimLabel;
    FIcona: TMedpUnimLabelIcon;
    FCaptionZero: String;
    FCaptionPlurale: String;
    FCaptionSingolare: String;
    FNumElementi: Integer;
    procedure SetNumElementi(const Value: Integer);
    procedure SetCaptionPlurale(const Value: String);
    procedure SetCaptionSingolare(const Value: String);
    procedure SetCaptionZero(const Value: String);
    procedure SetLabelCaption;
  protected
    procedure SetDefaultProperties; override;
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelNumElementi: TMedpUnimLabel read FLabel;
    property Icona: TMedpUnimLabelIcon read FIcona;
    property CaptionZero: String read FCaptionZero write SetCaptionZero;
    property CaptionSingolare: String read FCaptionSingolare write SetCaptionSingolare;
    property CaptionPlurale: String read FCaptionPlurale write SetCaptionPlurale;
    property NumElementi: Integer read FNumElementi write SetNumElementi default 0;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelNumElem]);
end;

{ TMedpUnimPanelNumElem }

constructor TMedpUnimPanelNumElem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel:=TMedpUnimLabel.Create(Self);

  with FLabel do
  begin
    Flex:=1;
    Name:='lblNumElementi';
    Caption:=FCaptionZero;
    LayoutConfig.Height:='auto';
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
  end;

  FIcona:=TMedpUnimLabelIcon.Create(Self);

  with FIcona do
  begin
    Name:='lblIcona';
    Caption:='fas fa-plus-circle';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='40';
    Font.Size:=20;
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelNumElem.SetDefaultProperties;
begin
  inherited;
  Height:=45;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='35';

  FCaptionZero:='Nessun elemento';
  FCaptionPlurale:='elementi';
  FCaptionSingolare:='elemento';

  FNumElementi:=0;
end;

procedure TMedpUnimPanelNumElem.SetLabelCaption;
begin
  if FNumElementi <= 0 then
    FLabel.Caption:=CaptionZero
  else if FNumElementi = 1 then
    FLabel.Caption:='1 ' + CaptionSingolare
  else
    FLabel.Caption:=FNumElementi.ToString + ' ' + CaptionPlurale;
end;

procedure TMedpUnimPanelNumElem.LoadCompleted;
begin
  inherited;
  FIcona.JSInterface.JSCall('addCls',['activeClick']);
end;

procedure TMedpUnimPanelNumElem.SetCaptionPlurale(const Value: String);
begin
  FCaptionPlurale := Value;

  SetLabelCaption;
end;

procedure TMedpUnimPanelNumElem.SetCaptionSingolare(const Value: String);
begin
  FCaptionSingolare := Value;

  SetLabelCaption;
end;

procedure TMedpUnimPanelNumElem.SetCaptionZero(const Value: String);
begin
  FCaptionZero := Value;

  SetLabelCaption;
end;

procedure TMedpUnimPanelNumElem.SetNumElementi(const Value: Integer);
begin
  FNumElementi:=Value;

  SetLabelCaption;
end;

end.
