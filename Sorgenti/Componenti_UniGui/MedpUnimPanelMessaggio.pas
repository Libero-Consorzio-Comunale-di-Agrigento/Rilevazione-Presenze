unit MedpUnimPanelMessaggio;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, Graphics, MedpUnimPanelIconLabel,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel, MedpUnimPanel2Labels, MedpUnimTypes, MedpUnimLabelIcon;

type
  TMedpUnimPanelMessaggio = class(TMedpUnimPanelBase)
  private
    FpnlHeader: TMedpUnimPanel2Labels;
    FpnlOggetto: TMedpUnimPanelBase;
    FlblOggetto: TMedpUnimLabel;
  protected
    procedure LoadCompleted; override;
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent; PMittente, POggetto: String; PObbligatoria, PAllegati: Boolean; PDataInvio: String);
  published
    property pnlHeader: TMedpUnimPanel2Labels read FpnlHeader write FpnlHeader;
    property pnlOggetto: TMedpUnimPanelBase read FpnlOggetto write FpnlOggetto;
    property lblOggetto: TMedpUnimLabel read FlblOggetto write FlblOggetto;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelMessaggio]);
end;

{ TMedpUnimPanelMessaggio }

constructor TMedpUnimPanelMessaggio.Create(AOwner: TComponent; PMittente, POggetto: String; PObbligatoria, PAllegati: Boolean; PDataInvio: String);
var LIconAllegati: TMedpUnimLabelIcon;
    LIconLettObbligatoria: TMedpUnimLabelIcon;
begin
  inherited Create(AOwner);

  Constraints.MinHeight:=63;

  FpnlHeader:=TMedpUnimPanel2Labels.Create(Self);
  FpnlOggetto:=TMedpUnimPanelBase.Create(Self);
  FlblOggetto:=TMedpUnimLabel.Create(Self);

  BoxModel.CSSPadding.Top:='5px';
  BoxModel.CSSPadding.Bottom:='2px';
  BoxModel.CSSPadding.Right:='2px';
  BoxModel.CSSPadding.Left:='5px';

  with FpnlHeader do
  begin
    Label1.Caption:=PMittente;
    Label1.Font.Size:=12;
    Label1.Font.Style:=[fsBold];
    Label1.JustifyContent:=TJustifyContent.JustifyStart;
    Label2.Caption:=PDataInvio;
    Label2.Font.Size:=12;
    Label2.Font.Style:=[fsBold];
    Label2.JustifyContent:=TJustifyContent.JustifyEnd;
    LayoutAttribs.Pack:='start';
    LayoutAttribs.Align:='certer';
    LayoutConfig.Height:='50%';
    //BoxModel.CSSPadding.Bottom:='3px';
    //BoxModel.CSSBorder.Bottom:='1px solid black';
    OnClick:=ClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;
  InsertComponent(FpnlHeader);

  with FpnlOggetto do
  begin
    Layout:='hbox';
    LayoutAttribs.Pack:='justify';
    LayoutAttribs.Align:='certer';
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='50%';
    SetSubComponent(True);
    OnClick:=ClickEvent;
    Parent:=Self;
  end;
  InsertComponent(FpnlOggetto);

  with FlblOggetto do
  begin
    Caption:=POggetto;
    CreateOrder:=1;
    JustifyContent:=TJustifyContent.JustifyStart;
    Flex:=1;
    LayoutConfig.Width:='';
    LayoutConfig.Height:='auto';
    Font.Size:=12;
    OnClick:=ClickEvent;
    SetSubComponent(True);
    Parent:=FpnlOggetto;
  end;
  FpnlOggetto.InsertComponent(FlblOggetto);

  if PAllegati then
  begin
    LIconAllegati:=TMedpUnimLabelIcon.Create(Self);
    with LIconAllegati do
    begin
      Caption:='fas fa-paperclip';
      CreateOrder:=2;
      Flex:=0;
      BoxModel.CSSBorderRadius:='30px';
      BoxModel.CSSPadding.Top:='6px';
      BoxModel.CSSPadding.Bottom:='6px';
      BoxModel.CSSPadding.Left:='6px';
      BoxModel.CSSPadding.Right:='6px';
      LayoutConfig.Width:='auto';
      LayoutConfig.Height:='auto';
      Font.Size:=15;
      OnClick:=ClickEvent;
      SetSubComponent(True);
      Parent:=FpnlOggetto;
    end;
    FpnlOggetto.InsertComponent(LIconAllegati);
  end;

  if PObbligatoria then
  begin
    LIconLettObbligatoria:=TMedpUnimLabelIcon.Create(Self);
    with LIconLettObbligatoria do
    begin
      Caption:='fas fa-exclamation-triangle';
      CreateOrder:=3;
      Flex:=0;
      BoxModel.CSSBorderRadius:='30px';
      BoxModel.CSSPadding.Top:='6px';
      BoxModel.CSSPadding.Bottom:='6px';
      BoxModel.CSSPadding.Left:='6px';
      BoxModel.CSSPadding.Right:='6px';
      LayoutConfig.Width:='auto';
      LayoutConfig.Height:='auto';
      Font.Size:=15;
      OnClick:=ClickEvent;
      SetSubComponent(True);
      Parent:=FpnlOggetto;
    end;
    FpnlOggetto.InsertComponent(LIconLettObbligatoria);
  end;
end;

procedure TMedpUnimPanelMessaggio.SetDefaultProperties;
begin
  inherited;
  Height:=45;
  Width:=200;

  Layout:='vbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
end;

procedure TMedpUnimPanelMessaggio.LoadCompleted;
begin
  inherited;

  FpnlHeader.Label1.JSInterface.JSCall('addCls',['text-overflow-ellipsis']);
  FlblOggetto.JSInterface.JSCall('addCls',['text-overflow-ellipsis']);
end;

end.
