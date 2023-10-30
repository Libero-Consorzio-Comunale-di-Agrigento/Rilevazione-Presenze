unit MedpUnimButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniButton, uniBitBtn, unimBitBtn, MedpUnimTypes;

type
  TMedpUnimButton = class(TUnimBitBtn)
  private
    //FJustifyContent: TJustifyContent;
    //FAlignItems: TAlignItems;
    FBoxModel: TBoxModel;
    //procedure SetAlignItems(const Value: TAlignItems);
    //procedure SetJustifyContent(const Value: TJustifyContent);
  protected
    procedure SetDefaultProperties; virtual;
    procedure OnBoxModelChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    //property JustifyContent: TJustifyContent read FJustifyContent write SetJustifyContent default JustifyCenter;
    //property AlignItems: TAlignItems read FAlignItems write SetAlignItems default AlignCenter;
    property BoxModel: TBoxModel read FBoxModel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimButton]);
end;

constructor TMedpUnimButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FBoxModel:=TBoxModel.Create(Self);
  FBoxModel.SetSubComponent(True);
  FBoxModel.OnChange:=OnBoxModelChange;

  SetDefaultProperties;
end;

procedure TMedpUnimButton.SetDefaultProperties;
begin
  Margins.SetBounds(0, 0, 0, 0);
  AlignWithMargins:=False;
  Anchors:=[];
  Align:=alNone;

  Height:=45;
  Width:=200;
  Caption:='';

  //AddStyle('display', 'flex');
  //SetJustifyContent(JustifyCenter);
  //SetAlignItems(AlignCenter);
end;

{procedure TMedpUnimButton.SetAlignItems(const Value: TAlignItems);
var LAlignItems: String;
begin
  FAlignItems:=Value;

  case FAlignItems of
    AlignStart:    LAlignItems:='flex-start';
    AlignEnd:      LAlignItems:='flex-end';
    AlignCenter:   LAlignItems:='center';
  end;

  if IsLoading then
    AddStyle('align-items', LAlignItems)
  else
    SetDomStyleProperty('alignItems', LAlignItems);
end;

procedure TMedpUnimButton.SetJustifyContent(const Value: TJustifyContent);
var LJustifyContent: String;
begin
  FJustifyContent:=Value;

  case FJustifyContent of
    JustifyStart:   LJustifyContent:='flex-start';
    JustifyEnd:     LJustifyContent:='flex-end';
    JustifyCenter:  LJustifyContent:='center';
  end;

  if IsLoading then
    AddStyle('justify-content', LJustifyContent)
  else
    SetDomStyleProperty('justifyContent', LJustifyContent);
end;}

procedure TMedpUnimButton.OnBoxModelChange(Sender: TObject);
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
