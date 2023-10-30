unit MedpUnimPanelListaDisclosure;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, unimPanel, MedpUnimTypes,
  MedpUnimPanelListaElem, MedpUnimPanel2Labels, MedpUnimPanelDisclosure, MedpUnimPanelBase, MedpUnimPanelDownload, Graphics;

type

  TMedpUnimPanelListaDisclosure = class(TMedpUnimPanelListaElem)
  private

  protected
    FColorHeader: TColor;
    FBoxModelHeader: TBoxModel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddHeader(PPanelBase: TMedpUnimPanelBase);
    procedure Add(PPanelBase: TMedpUnimPanelBase; DisclVisible: Boolean; PKey: Variant; OnDisclosureClick: TOnClickEvent; IconaDownload: Boolean = False; SizeIcona: Integer = 20); overload;
    procedure Clear; override;
  published
    property ColorHeader: TColor read FColorHeader write FColorHeader default clBtnFace;
    property BoxModelHeader: TBoxModel read FBoxModelHeader;
  end;

procedure Register;

implementation

procedure TMedpUnimPanelListaDisclosure.Clear;
begin
  inherited Clear;
end;

constructor TMedpUnimPanelListaDisclosure.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBoxModelHeader:=TBoxModel.Create(Self);
  FBoxModelHeader.CSSBorder.Bottom:='1px solid black';
  FBoxModelHeader.CSSBorder.Top:='1px solid black';
  FBoxModelHeader.CSSBorder.Left:='1px solid black';
  FBoxModelHeader.CSSBorder.Right:='1px solid black';

  FColorHeader:=clBtnFace;
end;

destructor TMedpUnimPanelListaDisclosure.Destroy;
begin
  FreeAndNil(FBoxModelHeader);
  inherited;
end;

procedure TMedpUnimPanelListaDisclosure.AddHeader(PPanelBase: TMedpUnimPanelBase);
var LDisclosure: TMedpUnimPanelDisclosure;
begin
  if Assigned(PPanelBase) then
  begin

    LDisclosure:=TMedpUnimPanelDisclosure.Create(Self);

    with LDisclosure do
    begin
      InsertBasePanel(PPanelBase);
      Key:=0;
      OnClick:=nil;
      DisclosureIcon.Caption:='';
      DaContare:=False;
    end;

    inherited Add(LDisclosure);

    with LDisclosure do
    begin
      Color:=FColorHeader;

      BoxModel.CSSBorder.Bottom:=FBoxModelHeader.CSSBorder.Bottom;
      BoxModel.CSSBorder.Top:=FBoxModelHeader.CSSBorder.Top;
      BoxModel.CSSBorder.Left:=FBoxModelHeader.CSSBorder.Left;
      BoxModel.CSSBorder.Right:=FBoxModelHeader.CSSBorder.Right;
      BoxModel.CSSMargin.Bottom:=FBoxModelHeader.CSSMargin.Bottom;
      BoxModel.CSSMargin.Top:=FBoxModelHeader.CSSMargin.Top;
      BoxModel.CSSMargin.Left:=FBoxModelHeader.CSSMargin.Left;
      BoxModel.CSSMargin.Right:=FBoxModelHeader.CSSMargin.Right;
      BoxModel.CSSPadding.Bottom:=FBoxModelHeader.CSSPadding.Bottom;
      BoxModel.CSSPadding.Top:=FBoxModelHeader.CSSPadding.Top;
      BoxModel.CSSPadding.Left:=FBoxModelHeader.CSSPadding.Left;
      BoxModel.CSSPadding.Right:=FBoxModelHeader.CSSPadding.Right;
    end;

    FContatoreColore:=1;
  end;
end;

procedure TMedpUnimPanelListaDisclosure.Add(PPanelBase: TMedpUnimPanelBase; DisclVisible: Boolean; PKey: Variant; OnDisclosureClick: TOnClickEvent; IconaDownload: Boolean = False; SizeIcona: Integer = 20);
var LDisclosure: TMedpUnimPanelDisclosure;
begin
  if Assigned(PPanelBase) then
  begin
    if IconaDownload then
      LDisclosure:=TMedpUnimPanelDownload.Create(Self)
    else
      LDisclosure:=TMedpUnimPanelDisclosure.Create(Self);

    LDisclosure.DisclosureIcon.Font.Size:=SizeIcona;
    LDisclosure.DisclosureIcon.LayoutConfig.Width:=IntToStr(((SizeIcona * 2)+5)) + 'px';
    LDisclosure.DisclosureIcon.LayoutConfig.Height:=IntToStr(((SizeIcona * 2)+5)) + 'px';

    LDisclosure.ScreenMask:=ScreenMask;

    LDisclosure.InsertBasePanel(PPanelBase);
    LDisclosure.Key:=PKey;

    if DisclVisible then
    begin
      LDisclosure.JSInterface.JSCall('addCls', ['activeColor']);
      LDisclosure.OnClick:=OnDisclosureClick;
      LDisclosure.Data:=nil;
    end
    else
    begin
      LDisclosure.OnClick:=nil;
      LDisclosure.Data:=nil;
    end;

    if not DisclVisible then
      LDisclosure.DisclosureIcon.Caption:='';

    inherited Add(LDisclosure);
  end;
end;

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelListaDisclosure]);
end;

end.
