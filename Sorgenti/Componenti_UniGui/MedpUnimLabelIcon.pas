unit MedpUnimLabelIcon;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniLabel, unimLabel, MedpUnimLabel;

type
  TMedpUnimLabelIcon = class(TMedpUnimLabel)
  private
    FCSSColor: String;
    procedure SetCSSColor(const Value: String);
  protected
    procedure SetJSCaption(const Value: string); override;
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CSSColor: String read FCSSColor write SetCSSColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimLabelIcon]);
end;

{ TMedpUnimIconLabel }

// usare caption, color e font size per gestire l'icona
constructor TMedpUnimLabelIcon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetDefaultProperties;
end;

procedure TMedpUnimLabelIcon.SetDefaultProperties;
begin
  inherited;

  LayoutConfig.Height:='auto';
  LayoutConfig.Width:='auto';
end;

procedure TMedpUnimLabelIcon.SetCSSColor(const Value: String);
begin
  FCSSColor:=Value;

  if IsLoading then
    AddStyle('color', FCSSColor)
  else
    SetDomStyleProperty('color', FCSSColor);
end;

procedure TMedpUnimLabelIcon.SetJSCaption(const Value: string);
begin
  JSInterface.JSCall('addCls', [Caption]);
end;

end.
