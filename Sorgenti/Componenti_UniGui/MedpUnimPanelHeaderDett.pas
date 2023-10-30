unit MedpUnimPanelHeaderDett;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimLabelIcon,
  MedpUnimTypes;

type
  TMedpUnimPanelHeaderDett = class(TMedpUnimPanelBase)
  private
    FlblBack: TMedpUnimLabelIcon;
    FlblHeaderDettaglio: TMedpUnimLabel;
    FlblUp: TMedpUnimLabelIcon;
    FlblDown: TMedpUnimLabelIcon;

    FOnClickBack: TOnClickEvent;
    FOnClickUp: TOnClickEvent;
    FOnClickDown: TOnClickEvent;

    procedure DoOnClickBack;
    procedure DoOnClickUp;
    procedure DoOnClickDown;
  protected
    procedure ClickBackEvent(Sender: TObject);
    procedure ClickUpEvent(Sender: TObject);
    procedure ClickDownEvent(Sender: TObject);

    procedure SetDefaultProperties; override;
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Back: TMedpUnimLabelIcon read FlblBack;
    property LabelDettaglio: TMedpUnimLabel read FlblHeaderDettaglio;
    property Up: TMedpUnimLabelIcon read FlblUp;
    property Down: TMedpUnimLabelIcon read FlblDown;

    property OnClickBack: TOnClickEvent read FOnClickBack write FOnClickBack;
    property OnClickUp: TOnClickEvent read FOnClickUp write FOnClickUp;
    property OnClickDown: TOnClickEvent read FOnClickDown write FOnClickDown;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelHeaderDett]);
end;

{ TMedpUnimHeaderDettaglio }

constructor TMedpUnimPanelHeaderDett.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FlblBack:=TMedpUnimLabelIcon.Create(Self);
  FlblHeaderDettaglio:=TMedpUnimLabel.Create(Self);
  FlblUp:=TMedpUnimLabelIcon.Create(Self);
  FlblDown:=TMedpUnimLabelIcon.Create(Self);

  with FlblBack do
  begin
    Caption:='fas fa-arrow-circle-left';
    Name:='lblBack';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='45';
    Font.Size:=20;
    OnClick:=ClickBackEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FlblHeaderDettaglio do
  begin
    Flex:=1;
    LayoutConfig.Height:='auto';
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FlblUp do
  begin
    Caption:='fas fa-arrow-circle-up';
    Name:='lblUp';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='45';
    Font.Size:=20;
    OnClick:=ClickUpEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FlblDown do
  begin
    Caption:='fas fa-arrow-circle-down';
    Name:='lblDown';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='45';
    Font.Size:=20;
    OnClick:=ClickDownEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelHeaderDett.SetDefaultProperties;
begin
  inherited;

  Height:=40;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Height:='45';
  LayoutConfig.Width:='100%';
end;

procedure TMedpUnimPanelHeaderDett.DoOnClickBack;
begin
  if Assigned(FOnClickBack) then
    FOnClickBack(Self);
end;

procedure TMedpUnimPanelHeaderDett.DoOnClickUp;
begin
  if Assigned(FOnClickUp) then
    FOnClickUp(Self);
end;

procedure TMedpUnimPanelHeaderDett.LoadCompleted;
begin
  inherited;
  FlblBack.JSInterface.JSCall('addCls',['activeClick']);
  FlblUp.JSInterface.JSCall('addCls',['activeClick']);
  FlblDown.JSInterface.JSCall('addCls',['activeClick']);
end;

procedure TMedpUnimPanelHeaderDett.DoOnClickDown;
begin
  if Assigned(FOnClickDown) then
    FOnClickDown(Self);
end;

procedure TMedpUnimPanelHeaderDett.ClickBackEvent(Sender: TObject);
begin
  DoOnClickBack;
end;

procedure TMedpUnimPanelHeaderDett.ClickDownEvent(Sender: TObject);
begin
  DoOnClickDown;
end;

procedure TMedpUnimPanelHeaderDett.ClickUpEvent(Sender: TObject);
begin
  DoOnClickUp;
end;

end.
