unit MedpUnimPanelListaElem;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimLabel, MedpUnimLabelIcon, uniGUITypes,
  MedpUnimTypes, MedpUnimPanelBase, Graphics;

type

  TMedpUnimPanelListaElem = class(TMedpUnimPanelBase)
  private
    FNumeroElementi: Integer;
    FCSSBordoSeparatore: String;
    function GetNumeroElementi: Integer;
  protected
    FContatoreColore: Integer;
    FColorPari: TColor;
    FColorDispari: TColor;
    procedure SetDefaultProperties; override;
  public
    property NumeroElementi: Integer read GetNumeroElementi default 0;

    constructor Create(AOwner: TComponent); override;

    procedure Add(APanel: TMedpUnimPanelBase);
    //procedure Remove(index: Integer);
    procedure Clear; virtual;
  published
    property ColorPari: TColor read FColorPari write FColorPari default clBtnFace;
    property ColorDispari: TColor read FColorDispari write FColorDispari default clBtnFace;
    property CSSBordoSeparatore: String read FCSSBordoSeparatore write FCSSBordoSeparatore;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelListaElem]);
end;

{ TMedpUnimPanelListaElem }

constructor TMedpUnimPanelListaElem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FContatoreColore:=1;
  FColorPari:=clBtnFace;
  FColorDispari:=clBtnFace;
  SetDefaultProperties;
end;

procedure TMedpUnimPanelListaElem.SetDefaultProperties;
begin
  inherited;
  FCSSBordoSeparatore:='1px solid #f0f0f0';
  Layout:='vbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  Flex:=0;
  LayoutConfig.Width:='100%';
  AutoScroll:=True;
  FNumeroElementi:=0;
end;

function TMedpUnimPanelListaElem.GetNumeroElementi: Integer;
begin
  Result:=FNumeroElementi;
end;

procedure TMedpUnimPanelListaElem.Add(APanel: TMedpUnimPanelBase);
begin
  if APanel.DaContare then
    FNumeroElementi:=FNumeroElementi+1;

  APanel.CreateOrder:=ControlCount+1;
  APanel.Parent:=Self;
  APanel.Name:='';

  if (FContatoreColore mod 2) = 0 then
    APanel.Color:=FColorPari
  else
    APanel.Color:=FColorDispari;

  if FContatoreColore = 1 then
    APanel.BoxModel.CSSBorder.Top:=FCSSBordoSeparatore;

  APanel.BoxModel.CSSBorder.Bottom:=FCSSBordoSeparatore;

  InsertComponent(APanel);
  APanel.SetSubComponent(True);

  FContatoreColore:=FContatoreColore+1;

  DoOnChange;
end;

procedure TMedpUnimPanelListaElem.Clear;
var i: Integer;
begin
  for i := (ControlCount - 1) downto 0 do
    controls[i].Free;

  FNumeroElementi:=0;
  FContatoreColore:=1;
  DoOnChange;
end;

// non aggiornato
{procedure TMedpUnimPanelListaElem.Remove(index: Integer);
begin
  if (index >= 0) and (index < ControlCount) then
  begin
    if controls[index] is TMedpUnimPanelBase then
      if (controls[index] as TMedpUnimPanelBase).DaContare then
        FNumeroElementi:=FNumeroElementi-1;

    controls[index].Free;
    DoOnChange;
  end;
end;}

end.
