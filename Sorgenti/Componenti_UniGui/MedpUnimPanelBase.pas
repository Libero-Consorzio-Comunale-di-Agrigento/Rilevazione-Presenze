unit MedpUnimPanelBase;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimTypes, uniGUITypes, unimPanel, Graphics;

type
  TMedpUnimPanelBase = class(TUnimContainerPanel)
  private
    FDaContare: Boolean;

    FOnClick: TOnClickEvent;
    FOnChange: TOnChangeEvent;

    FBoxModel: TBoxModel;

    FClickEnabled: Boolean;
    FChangeEnabled: Boolean;
  protected
    procedure ClickEvent(Sender: TObject);
    procedure ChangeEvent(Sender: TObject);

    procedure DoOnClick; virtual;
    procedure DoOnChange; virtual;

    procedure SetOnClick(const Value: TOnClickEvent); virtual;
    procedure SetOnChange(const Value: TOnChangeEvent); virtual;

    procedure SetDefaultProperties; virtual;
    procedure OnBoxModelChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    //procedure LoadCompleted; override;
  published
    property ScreenMask;

    property DaContare: Boolean read FDaContare write FDaContare default True;
    property OnClick: TOnClickEvent read FOnClick write SetOnClick;
    property OnChange: TOnChangeEvent read FOnChange write SetOnChange;
    property ClickEnabled: Boolean read FClickEnabled write FClickEnabled;
    property ChangeEnabled: Boolean read FChangeEnabled write FChangeEnabled;
    property BoxModel: TBoxModel read FBoxModel write FBoxModel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelBase]);
end;

constructor TMedpUnimPanelBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBoxModel:=TBoxModel.Create(Self);
  FBoxModel.SetSubComponent(True);
  FBoxModel.OnChange:=OnBoxModelChange;
  FDaContare:=True;
  SetDefaultProperties;
end;

{procedure TMedpUnimPanelBase.LoadCompleted;
var i: Integer;
begin
  inherited;
  for i := (ControlCount - 1) downto 0 do
  begin
    if (Controls[i] is TUniControl) then
      (Controls[i] as TUniControl).ScreenMask:=ScreenMask;
  end;
end;}

procedure TMedpUnimPanelBase.SetOnChange(const Value: TOnChangeEvent);
begin
  FOnChange := Value;
end;

procedure TMedpUnimPanelBase.SetOnClick(const Value: TOnClickEvent);
begin
  FOnClick := Value;
end;

procedure TMedpUnimPanelBase.DoOnClick;
begin
  if Assigned(FOnClick) and FClickEnabled then
    FOnClick(Self);
end;

procedure TMedpUnimPanelBase.DoOnChange;
begin
  if Assigned(FOnChange) and FChangeEnabled then
    FOnChange(Self);
end;

procedure TMedpUnimPanelBase.ClickEvent(Sender: TObject);
begin
  DoOnClick;
end;

procedure TMedpUnimPanelBase.ChangeEvent(Sender: TObject);
begin
  DoOnChange;
end;

procedure TMedpUnimPanelBase.SetDefaultProperties;
begin
  Margins.SetBounds(0, 0, 0, 0);
  AlignWithMargins:=False;
  Anchors:=[];
  Align:=alNone;
  AlignmentControl:=uniAlignmentClient;
  Height:=200;
  Width:=200;
  //BorderStyle:=ubsNone;
  FClickEnabled:=True;
  FChangeEnabled:=True;
end;

procedure TMedpUnimPanelBase.OnBoxModelChange(Sender: TObject);
begin
  if IsLoading then
  begin
    AddStyle('margin-top', FBoxModel.CSSMargin.Top);
    AddStyle('margin-right', FBoxModel.CSSMargin.Right);
    AddStyle('margin-bottom', FBoxModel.CSSMargin.Bottom);
    AddStyle('margin-left', FBoxModel.CSSMargin.Left);

    AddStyle('padding-top', FBoxModel.CSSPadding.Top);
    AddStyle('padding-right', FBoxModel.CSSPadding.Right);
    AddStyle('padding-bottom', FBoxModel.CSSPadding.Bottom);
    AddStyle('padding-left', FBoxModel.CSSPadding.Left);

    AddStyle('border-top', FBoxModel.CSSBorder.Top);
    AddStyle('border-right', FBoxModel.CSSBorder.Right);
    AddStyle('border-bottom', FBoxModel.CSSBorder.Bottom);
    AddStyle('border-left', FBoxModel.CSSBorder.Left);
    AddStyle('border-radius', FBoxModel.CSSBorderRadius);
  end
  else
  begin
    SetDomStyleProperty('marginTop', FBoxModel.CSSMargin.Top);
    SetDomStyleProperty('marginRight', FBoxModel.CSSMargin.Right);
    SetDomStyleProperty('marginBottom', FBoxModel.CSSMargin.Bottom);
    SetDomStyleProperty('marginLeft', FBoxModel.CSSMargin.Left);

    SetDomStyleProperty('paddingTop', FBoxModel.CSSPadding.Top);
    SetDomStyleProperty('paddingRight', FBoxModel.CSSPadding.Right);
    SetDomStyleProperty('paddingBottom', FBoxModel.CSSPadding.Bottom);
    SetDomStyleProperty('paddingLeft', FBoxModel.CSSPadding.Left);

    SetDomStyleProperty('borderTop', FBoxModel.CSSBorder.Top);
    SetDomStyleProperty('borderRight', FBoxModel.CSSBorder.Right);
    SetDomStyleProperty('borderBottom', FBoxModel.CSSBorder.Bottom);
    SetDomStyleProperty('borderLeft', FBoxModel.CSSBorder.Left);
    SetDomStyleProperty('borderRadius', FBoxModel.CSSBorderRadius);
  end;
end;

end.
