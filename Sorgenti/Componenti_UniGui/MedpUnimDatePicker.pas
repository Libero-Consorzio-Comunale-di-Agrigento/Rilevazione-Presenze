unit MedpUnimDatePicker;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniDateTimePicker, unimDatePicker, Graphics, MedpUnimTypes, uniGUITypes;

type
  TMedpUnimDatePicker = class(TUnimCustomDatePicker)
  private
    FBoxModel: TBoxModel;

  protected
    procedure SetDefaultProperties; virtual;
    procedure OnBoxModelChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property FieldLabel;
    property FieldLabelAlign;
    property FieldLabelWidth;
    property FieldLabelFont;
    property ClientEvents;

    property ReadOnly;
    property Enabled;
    property Flex;
    property DateFormat;
    property ShowBlankDate;
    property LayoutConfig;

    property SlotOrder;
    property Date;
    property MinYear;
    property MaxYear;
    property Picker;
    property ScreenMask;
    property Color default clWindow;
    property Font;

    property OnKeyUp;
    property OnEnter;
    property OnExit;
    property OnAjaxEvent;
    property OnChange;
    property OnChangeValue;

    property BoxModel: TBoxModel read FBoxModel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimDatePicker]);
end;

{ TMedpUnimDatePicker }

constructor TMedpUnimDatePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FBoxModel:=TBoxModel.Create(Self);
  FBoxModel.SetSubComponent(True);
  FBoxModel.OnChange:=OnBoxModelChange;

  SetDefaultProperties;
end;

procedure TMedpUnimDatePicker.SetDefaultProperties;
begin
  Margins.SetBounds(0, 0, 0, 0);
  AlignWithMargins:=False;
  Anchors:=[];
  Align:=alNone;
  SlotOrder:='d/m/y';

  Picker:=dptFloated;
  ClientEvents.UniEvents.Append('afterCreate=function afterCreate(sender){ sender.originalValue=null; sender.setEditable(false); }');

  Height:=45;
  Width:=200;
end;

procedure TMedpUnimDatePicker.OnBoxModelChange(Sender: TObject);
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
