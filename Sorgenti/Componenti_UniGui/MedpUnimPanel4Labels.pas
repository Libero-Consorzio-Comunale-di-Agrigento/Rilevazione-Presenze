unit MedpUnimPanel4Labels;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabel;

type
  TMedpUnimPanel4Labels = class(TMedpUnimPanelBase)
  private
    FLabel1: TMedpUnimLabel;
    FLabel2: TMedpUnimLabel;
    FLabel3: TMedpUnimLabel;
    FLabel4: TMedpUnimLabel;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Label1: TMedpUnimLabel read FLabel1;
    property Label2: TMedpUnimLabel read FLabel2;
    property Label3: TMedpUnimLabel read FLabel3;
    property Label4: TMedpUnimLabel read FLabel4;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanel4Labels]);
end;

{ TMedpUnim4lblPanel }

constructor TMedpUnimPanel4Labels.Create(AOwner: TComponent);
begin
  inherited;

  FLabel1:=TMedpUnimLabel.Create(Self);

  with FLabel1 do
  begin
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=ClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  FLabel2:=TMedpUnimLabel.Create(Self);

  with FLabel2 do
  begin
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=ClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  FLabel3:=TMedpUnimLabel.Create(Self);

  with FLabel3 do
  begin
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=ClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  FLabel4:=TMedpUnimLabel.Create(Self);

  with FLabel4 do
  begin
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=ClickEvent;
    SetSubComponent(True);
    Parent:=Self;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanel4Labels.SetDefaultProperties;
begin
  inherited;

  Height:=45;
  Width:=300;

  Layout:='float';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
end;

end.
