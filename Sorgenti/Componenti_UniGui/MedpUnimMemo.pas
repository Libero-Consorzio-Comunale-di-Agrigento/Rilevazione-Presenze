unit MedpUnimMemo;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, unimPanel, MedpUnimPanelBase, MedpUnimLabelIcon, unimMemo;

type
  TMedpUnimMemo = class(TMedpUnimPanelBase)
  private
    FlblConferma: TMedpUnimLabelIcon;
    FMemo: TUnimMemo;

    procedure OnEnterMemo(Sender: TObject);
    procedure OnExitMemo(Sender: TObject);
  protected
    procedure SetDefaultProperties; override;
    procedure SetEnabled(Value: Boolean); override;
    procedure OnClickConferma(Sender: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ConfermaIcon: TMedpUnimLabelIcon read FlblConferma;
    property Memo: TUnimMemo read FMemo;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimMemo]);
end;

{ TMedpUnimMemo }

constructor TMedpUnimMemo.Create(AOwner: TComponent);
begin
  inherited;

  FMemo:=TUnimMemo.Create(Self);
  FlblConferma:=TMedpUnimLabelIcon.Create(Self);

  with FMemo do
  begin
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='100%';
    Enabled:=True;
    OnEnter:=OnEnterMemo;
    OnExit:=OnExitMemo;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FlblConferma do
  begin
    Caption:='fas fa-check-circle';
    ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("position: absolute; bottom: 8px; right: 5px;");}');
    Font.Size:=22;
    Visible:=False;
    OnClick:=OnClickConferma;
    SetSubComponent(True);
  end;

  FlblConferma.Parent:=Self;
  SetDefaultProperties;
end;

procedure TMedpUnimMemo.SetDefaultProperties;
begin
  inherited;

  Height:=50;
  Width:=200;

  Layout:='fit';
end;

procedure TMedpUnimMemo.SetEnabled(Value: Boolean);
begin
  inherited;
  FMemo.Enabled:=Value;
end;

procedure TMedpUnimMemo.OnClickConferma(Sender: TObject);
begin
    //Self.WebFocus;
    //FlblConferma.Visible:=False;
    FlblConferma.WebFocus
end;

procedure TMedpUnimMemo.OnEnterMemo(Sender: TObject);
begin
  if not Memo.ReadOnly then
    FlblConferma.Visible:=True;
end;

procedure TMedpUnimMemo.OnExitMemo(Sender: TObject);
begin
  if FlblConferma.Visible = True then
    FlblConferma.Visible:=False;
end;

end.
