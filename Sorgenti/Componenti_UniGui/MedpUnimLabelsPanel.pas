unit MedpUnimLabelsPanel;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUIFont, uniGUImJSForm, MedpUnimTypes, MedpUnimLabel;

type
  TMedpUnimLabelsPanel = class(TUnimContainerPanel)
  private
    FConfigColonne: TConfigColonne;
    FConfigRighe: TConfigRighe;
    FFont: TUniFont;
    FNumRighe: Integer;
    FNumColonne: Integer;
    FCaption: TStringList;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateWnd; override;
  published
    property Font: TUniFont read FFont;
    property ConfigColonne: TConfigColonne read FConfigColonne;
    property ConfigRighe: TConfigRighe read FConfigRighe;
    property NumRighe: Integer read FNumRighe write FNumRighe default 1;
    property NumColonne: Integer read FNumColonne write FNumColonne default 1;
    property Caption: TStringList read FCaption write FCaption;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimLabelsPanel]);
end;

{ TMedpUnimLabelsPanel }

constructor TMedpUnimLabelsPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNumRighe:=0;
  FNumColonne:=0;
  FConfigColonne:=TConfigColonne.Create;
  FConfigRighe:=TConfigRighe.Create;
  FFont:=TUniFont.Create;
  FCaption:=TStringList.Create;
  Layout:='float';

end;

procedure TMedpUnimLabelsPanel.CreateWnd;
var i, max: integer;
begin
  inherited;

  for i:=1 to FNumRighe*FNumColonne do
  begin
    with TMedpUnimLabel.Create(Self) do
    begin
      CreateOrder:=i;
      Parent:=Self;
      Caption:=FCaption[i-1];
    end;
  end;

end;

destructor TMedpUnimLabelsPanel.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FCaption);
  FreeAndNil(FConfigColonne);
  FreeAndNil(FConfigRighe);

  inherited;
end;

end.
