unit MedpUnimPanelEditIcons;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabelIcon, MedpUnimTypes;

type
  TMedpUnimPanelEditIcons = class(TMedpUnimPanelBase)
  private
    FLabel1: TMedpUnimLabelIcon;
    FLabel2: TMedpUnimLabelIcon;
  protected
    procedure SetDefaultProperties; override;
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Label1: TMedpUnimLabelIcon read FLabel1 write FLabel1;
    property Label2: TMedpUnimLabelIcon read FLabel2 write FLabel2;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelEditIcons]);
end;

{ TMedpUnimPanelEditIcons }

constructor TMedpUnimPanelEditIcons.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel1:=TMedpUnimLabelIcon.Create(Self);
  FLabel2:=TMedpUnimLabelIcon.Create(Self);

  with FLabel1 do
  begin
    Name:='LabelEdit';
    Caption:='fas fa-edit';
    LayoutConfig.Height:='42';
    LayoutConfig.Width:='40';
    Font.Size:=17;
    CSSColor:='#ffffff';
    with BoxModel do
    begin
      CSSBorderRadius:='30px 30px 0px 0px';
      CSSBorder.Top:='0px';
      CSSBorder.Bottom:='1px solid';
      CSSBorder.Left:='0px';
      CSSBorder.Right:='0px';
      CSSPadding.Top:='6px';
      CSSPadding.Right:='4px';
      CSSPadding.Bottom:='4px';
      CSSPadding.Left:='5px';
    end;
    //OnClick:=FOnClickEdit;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FLabel2 do
  begin
    Name:='LabelDelete';
    Caption:='fas fa-trash-alt';
    LayoutConfig.Height:='42';
    LayoutConfig.Width:='40';
    Font.Size:=17;
    CSSColor:='#ffffff';
    with BoxModel do
    begin
      CSSBorderRadius:='0px 0px 30px 30px';
      CSSBorder.Top:='1px solid';
      CSSBorder.Bottom:='0px';
      CSSBorder.Left:='0px';
      CSSBorder.Right:='0px';
      CSSPadding.Top:='4px';
      CSSPadding.Right:='5px';
      CSSPadding.Bottom:='5px';
      CSSPadding.Left:='5px';
    end;
    //OnClick:=FOnClickDelete;
    Parent:=Self;
    SetSubComponent(True);
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelEditIcons.LoadCompleted;
begin
  inherited;
  FLabel1.JSInterface.JSCall('addCls',['activeClick']);
  FLabel2.JSInterface.JSCall('addCls',['activeClick']);
  FLabel1.JSInterface.JSCall('addCls',['background-blue']);
  FLabel2.JSInterface.JSCall('addCls',['background-blue']);
end;

procedure TMedpUnimPanelEditIcons.SetDefaultProperties;
begin
  inherited;

  Height:=80;
  Width:=45;

  Layout:='vbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='center';
  LayoutConfig.Width:='auto';
  LayoutConfig.Height:='auto';
end;

{procedure TMedpUnimPanelEditIcons.SetOnClickDelete(const Value: TOnClickEvent);
begin
  FOnClickDelete:=Value;
end;

procedure TMedpUnimPanelEditIcons.SetOnClickEdit(const Value: TOnClickEvent);
begin
  FOnClickEdit:=Value;
end;}

end.
