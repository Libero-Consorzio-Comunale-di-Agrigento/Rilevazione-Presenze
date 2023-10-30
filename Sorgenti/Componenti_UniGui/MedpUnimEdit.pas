unit MedpUnimEdit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniEdit, unimEdit, MedpUnimTypes, Graphics;

type
  TMedpUnimEdit = class(TUnimCustomEdit)
  private
    FBoxModel: TBoxModel;
  protected
    procedure SetDefaultProperties; virtual;
    procedure OnBoxModelChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BoxModel: TBoxModel read FBoxModel;
    property ClientEvents;
    property Text;
    property ClearButton;
    property CharCase;
    property PasswordChar;
    property EmptyText;
    property FieldLabel;
    property FieldLabelAlign;
    property FieldLabelWidth;
    property FieldLabelFont;
    property Color default clWindow;
    property ParentFont;
    property Font;
    property Enabled;
    property Flex;
    property ReadOnly;
    property ScreenMask;
    property LayoutConfig;
    property TabOrder;
    property TabStop;
    property InputType;
    property MaxLength;

    property OnKeyUp;
    property OnEnter;
    property OnExit;
    property OnChange;
    property OnChangeValue;
    property OnAjaxEvent;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimEdit]);
end;

{ TMedpUnimEdit }

constructor TMedpUnimEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FBoxModel:=TBoxModel.Create(Self);
  FBoxModel.SetSubComponent(True);
  FBoxModel.OnChange:=OnBoxModelChange;

  SetDefaultProperties;
end;

procedure TMedpUnimEdit.SetDefaultProperties;
begin
  Margins.SetBounds(0, 0, 0, 0);
  AlignWithMargins:=False;
  Anchors:=[];
  Align:=alNone;

  Height:=45;
  Width:=200;
end;

procedure TMedpUnimEdit.OnBoxModelChange(Sender: TObject);
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
