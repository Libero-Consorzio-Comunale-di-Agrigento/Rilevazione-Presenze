unit MedpUnimPanel2Labels;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimLabel, MedpUnimTypes, MedpUnimPanelBase;

type
  TMedpUnimPanel2Labels = class(TMedpUnimPanelBase)
  private
    FLabel1: TMedpUnimLabel;
    FLabel2: TMedpUnimLabel;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Label1: TMedpUnimLabel read FLabel1 write FLabel1;
    property Label2: TMedpUnimLabel read FLabel2 write FLabel2;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanel2Labels]);
end;

{ TMedpUnim2lblPanel }

constructor TMedpUnimPanel2Labels.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel1:=TMedpUnimLabel.Create(Self);
  FLabel2:=TMedpUnimLabel.Create(Self);

  with FLabel1 do
  begin
    LayoutConfig.Width:='50%';
    LayoutConfig.Height:='auto';
    OnClick:=ClickEvent;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FLabel2 do
  begin
    LayoutConfig.Width:='50%';
    LayoutConfig.Height:='auto';
    OnClick:=ClickEvent;
    Parent:=Self;
    SetSubComponent(True);
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanel2Labels.SetDefaultProperties;
begin
  inherited;

  Height:=45;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
end;

end.
