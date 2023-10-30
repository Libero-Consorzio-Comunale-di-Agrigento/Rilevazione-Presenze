unit MedpUnimMainMenu;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Graphics, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimPanelListaElem, MedpUnimLabelIcon,
  MedpUnimLabel, MedpUnimPanelIconLabel, MedpUnimTypes, Generics.Collections;

type
  TMedpUnimMainMenu = class(TMedpUnimPanelBase)
  private
    FHeaderPanel: TMedpUnimPanelBase;
    FMenuPanel: TMedpUnimPanelListaElem;
    //FMenuIcon: TMedpUnimLabelIcon;
    FHeaderLabel: TMedpUnimLabel;
    FLabelsNotifiche: TObjectDictionary<Integer, TMedpUnimPanelIconLabel>;

    function CreaPanelMenu(PTesto: String; PNotifiche, PTag: Integer; POnClick: TOnClickEvent): TMedpUnimPanelBase;
    function GetTitle: String;
    procedure SetTitle(const Value: String);
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(Testo: String; PNotifiche, PTag: Integer; POnClick: TOnClickEvent);
    procedure Clear;
    procedure UpdateNotifica(PTag, PValore: Integer);
  published
    property Title: String read GetTitle write SetTitle;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimMainMenu]);
end;

{ TMedpUnimMainMenu }

constructor TMedpUnimMainMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabelsNotifiche:=TObjectDictionary<Integer, TMedpUnimPanelIconLabel>.Create;

  FHeaderPanel:=TMedpUnimPanelBase.Create(Self);
  FMenuPanel:=TMedpUnimPanelListaElem.Create(Self);
  //FMenuIcon:=TMedpUnimLabelIcon.Create(Self);
  FHeaderLabel:=TMedpUnimLabel.Create(Self);

  with FHeaderPanel do
  begin
    Layout:='hbox';
    ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("background-color: #157fcc");}');
    LayoutAttribs.Align:='center';
    LayoutAttribs.Pack:='start';
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='auto';
    Constraints.MinHeight:=36;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FMenuPanel do
  begin
    Layout:='vbox';
    LayoutAttribs.Align:='center';
    LayoutAttribs.Pack:='start';
    LayoutConfig.Width:='100%';
    Flex:=1;
    Parent:=Self;
    SetSubComponent(True);
  end;

  {with FMenuIcon do
  begin
    Caption:='fas fa-bars';
    Font.Color:=clWhite;
    LayoutConfig.Height:='35';
    LayoutConfig.Width:='35';
    BoxModel.CSSBorder.Top:='1px solid white';
    BoxModel.CSSBorder.Right:='1px solid white';
    BoxModel.CSSBorder.Bottom:='1px solid white';
    BoxModel.CSSBorder.Left:='1px solid white';
    BoxModel.CSSBorderRadius:='7px';
    BoxModel.CSSMargin.Top:='5px';
    BoxModel.CSSMargin.Right:='5px';
    BoxModel.CSSMargin.Bottom:='5px';
    BoxModel.CSSMargin.Left:='5px';
    Font.Size:=15;
    SetSubComponent(True);
    Parent:=FHeaderPanel;
  end;}

  with FHeaderLabel do
  begin
    Flex:=1;
    Font.Color:=clWhite;
    Font.Style:=[fsBold];
    ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("text-align:center");}');
    Caption:='Testo di prova';
    LayoutConfig.Height:='auto';
    BoxModel.CSSMargin.Top:='6px';
    BoxModel.CSSMargin.Bottom:='6px';
    Parent:=FHeaderPanel;
    SetSubComponent(True);
  end;
end;

destructor TMedpUnimMainMenu.Destroy;
begin
  FreeAndNil(FLabelsNotifiche);
  inherited;
end;

function TMedpUnimMainMenu.GetTitle: String;
begin
  Result:=FHeaderLabel.Caption;
end;

procedure TMedpUnimMainMenu.SetDefaultProperties;
begin
  inherited;
  Layout:='vbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  Flex:=0;
  LayoutConfig.Width:='100%';
  AutoScroll:=False;
end;

procedure TMedpUnimMainMenu.SetTitle(const Value: String);
begin
  FHeaderLabel.Caption:=Value;
end;

procedure TMedpUnimMainMenu.UpdateNotifica(PTag, PValore: Integer);
var LPanel: TMedpUnimPanelIconLabel;
begin
  if FLabelsNotifiche.TryGetValue(PTag, LPanel) then
  begin
    LPanel.Visible:=PValore <> 0;
    LPanel.Label1.Caption:=PValore.ToString;
  end;
end;

procedure TMedpUnimMainMenu.Add(Testo: String; PNotifiche, PTag: Integer; POnClick: TOnClickEvent);
begin
  FMenuPanel.Add(CreaPanelMenu(Testo, PNotifiche, PTag, POnClick));
end;

procedure TMedpUnimMainMenu.Clear;
begin
  FLabelsNotifiche.Clear;
  FMenuPanel.Clear;
end;

function TMedpUnimMainMenu.CreaPanelMenu(PTesto: String; PNotifiche, PTag: Integer; POnClick: TOnClickEvent): TMedpUnimPanelBase;
var IconLabel: TMedpUnimPanelIconLabel;
    IconNotifiche: TMedpUnimPanelIconLabel;
begin
  Result:=TMedpUnimPanelBase.Create(Self);
  with Result do
  begin
    Layout:='hbox';
    JSInterface.JSCall('addCls', ['activeColor']);
    LayoutAttribs.Pack:='start';
    LayoutAttribs.Align:='certer';
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='auto';
    SetSubComponent(True);
    Parent:=FMenuPanel;
    ScreenMask:=Self.ScreenMask;
    OnClick:=POnClick;
    Tag:=PTag;
  end;

  IconLabel:=TMedpUnimPanelIconLabel.Create(Self);
  with IconLabel do
  begin
    Icon.Caption:='fas fa-caret-right';
    Icon.BoxModel.CSSPadding.Top:='3px';
    Icon.BoxModel.CSSPadding.Bottom:='3px';
    Icon.BoxModel.CSSPadding.Left:='16px';
    Icon.BoxModel.CSSPadding.Right:='16px';
    Icon.BoxModel.CSSMargin.Right:='0px';
    CreateOrder:=1;
    Flex:=1;
    Icon.Font.Size:=25;
    Icon.CSSColor:='#157fcc';
    LayoutConfig.Height:='40px';
    Label1.Caption:=PTesto;
    Label1.JustifyContent:=TJustifyContent.JustifyStart;
    Label1.LayoutConfig.Height:='100%';
    Label1.BoxModel.CSSMargin.Top:='0px';
    Label1.BoxModel.CSSMargin.Bottom:='0px';
    OnClick:=POnClick;
    Tag:=PTag;
    SetSubComponent(True);
    Parent:=Result;
    ScreenMask:=Self.ScreenMask;
    Icon.ScreenMask:=ScreenMask;
    Label1.ScreenMask:=ScreenMask;
  end;


  IconNotifiche:=TMedpUnimPanelIconLabel.Create(Self);
  with IconNotifiche do
  begin
    Visible:=PNotifiche > 0;
    Icon.Caption:='far fa-bell';
    Icon.BoxModel.CSSPadding.Top:='3px';
    Icon.BoxModel.CSSPadding.Bottom:='3px';
    Icon.BoxModel.CSSPadding.Left:='4px';
    Icon.BoxModel.CSSPadding.Right:='0px';
    Icon.BoxModel.CSSMargin.Right:='0px';
    Icon.BoxModel.CSSBorderRadius:='10px 0px 0px 10px';
    Icon.ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("background-color: #cc0000");}');
    CreateOrder:=2;
    Icon.Font.Size:=15;
    Icon.CSSColor:='#ffffff';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='auto';
    Label1.Caption:=PNotifiche.ToString;
    Label1.BoxModel.CSSPadding.Top:='2px';
    Label1.BoxModel.CSSPadding.Right:='2px';
    Label1.BoxModel.CSSPadding.Bottom:='2px';
    Label1.BoxModel.CSSPadding.Left:='0px';
    Label1.BoxModel.CSSBorderRadius:='0px 10px 10px 0px';
    Label1.BoxModel.CSSMargin.Right:='10px';
    Label1.JustifyContent:=TJustifyContent.JustifyCenter;
    Label1.LayoutConfig.Height:='26px';
    Label1.LayoutConfig.Width:='23.5px';
    Label1.Font.Color:=clWhite;
    Label1.Font.Style:=[fsBold];
    Label1.ClientEvents.UniEvents.Append('afterCreate= function afterCreate(sender) { sender.setStyle("background-color: #cc0000");}');
    OnClick:=POnClick;
    Tag:=PTag;
    SetSubComponent(True);
    Parent:=Result;
    ScreenMask:=Self.ScreenMask;
    Icon.ScreenMask:=ScreenMask;
    Label1.ScreenMask:=ScreenMask;
  end;

  //salvo il riferimento per l'aggiornamento delle notifiche
  FLabelsNotifiche.AddOrSetValue(Ptag, IconNotifiche);
end;

end.
