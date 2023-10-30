unit MedpUnimTabPanelBase;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniPageControl, unimTabPanel, Generics.Collections,
  MedpUnimTypes, uniGUITypes;

type
  TMedpUnimTabPanelBase = class(TUnimTabPanel)
  private
    FBoxModel: TBoxModel;
  protected
    procedure SetDefaultProperties; virtual;
    procedure OnBoxModelChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;

    procedure Next;
    procedure Prior;
    procedure First;
    procedure Last;

  published
    property BoxModel: TBoxModel read FBoxModel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimTabPanelBase]);
end;

{ TMedpUnimTabPanel }

constructor TMedpUnimTabPanelBase.Create(AOwner: TComponent);
begin
  inherited;
  FBoxModel:=TBoxModel.Create(Self);
  FBoxModel.SetSubComponent(True);
  FBoxModel.OnChange:=OnBoxModelChange;

  ClientEvents.UniEvents.Append('afterCreate=function afterCreate(sender){ sender.getTabBar().hide(); }');

  if PageCount > 0 then
    ActivePage:=Pages[0];

  SetDefaultProperties;
end;

procedure TMedpUnimTabPanelBase.SetDefaultProperties;
begin
  inherited;

  Margins.SetBounds(0, 0, 0, 0);
  AlignWithMargins:=False;
  Anchors:=[];
  Align:=alNone;
  AlignmentControl:=uniAlignmentClient;
  Height:=200;
  Width:=200;

  Flex:=1;
  LayoutConfig.Width:='100%';
  TabBarVisible:=False;
end;

procedure TMedpUnimTabPanelBase.Next;
begin
  if ActivePageIndex < PageCount-1 then
    ActivePage:=Pages[ActivePageIndex+1];
end;

procedure TMedpUnimTabPanelBase.Prior;
begin
  if ActivePageIndex > 0 then
    ActivePage:=Pages[ActivePageIndex-1];
end;

procedure TMedpUnimTabPanelBase.First;
begin
  if PageCount > 0 then
    ActivePage:=Pages[0];
end;

procedure TMedpUnimTabPanelBase.Last;
begin
  if PageCount > 0 then
    ActivePage:=Pages[PageCount-1];
end;

procedure TMedpUnimTabPanelBase.OnBoxModelChange(Sender: TObject);
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
