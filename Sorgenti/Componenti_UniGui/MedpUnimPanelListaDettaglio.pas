unit MedpUnimPanelListaDettaglio;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, unimPanel,
  MedpUnimPanelListaElem, MedpUnimPanel2Labels, MedpUnimPanelDisclosure, MedpUnimTypes, MedpUnimPanelListaDisclosure,
  MedpUnimPanelIconLabel;

type
  TMedpUnimPanelListaDettaglio = class(TMedpUnimPanelListaDisclosure)
  public
    procedure Add2Labels(PCaption1,PCaption2: String; DisclVisible: Boolean; PKey: Variant; OnDisclosureClick: TOnClickEvent); overload;
    procedure AddIconLabel(PFontAwesomeIcon,PCaption: String; DisclVisible: Boolean; PKey: Variant; OnDisclosureClick: TOnClickEvent); overload;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelListaDettaglio]);
end;

{ TMedpUnimPanelListaDettaglio }

procedure TMedpUnimPanelListaDettaglio.Add2Labels(PCaption1,PCaption2: String; DisclVisible: Boolean; PKey: Variant; OnDisclosureClick: TOnClickEvent);
var LLabels: TMedpUnimPanel2Labels;
begin
  LLabels:=TMedpUnimPanel2Labels.Create(Self);

  with LLabels do
  begin
    Constraints.MinHeight:=35;

    with Label1 do
    begin
      Caption:=PCaption1;
      JustifyContent:=JustifyStart;
    end;

    with Label2 do
    begin
      BoxModel.CSSMargin.Left:='3px';
      Caption:=PCaption2;
      JustifyContent:=JustifyStart;
    end;

    BoxModel.CSSMargin.Left:='5px';
  end;

  inherited Add(LLabels, DisclVisible, PKey, OnDisclosureClick);
end;

procedure TMedpUnimPanelListaDettaglio.AddIconLabel(PFontAwesomeIcon, PCaption: String; DisclVisible: Boolean; PKey: Variant; OnDisclosureClick: TOnClickEvent);
var LIconLabel: TMedpUnimPanelIconLabel;
begin
  LIconLabel:=TMedpUnimPanelIconLabel.Create(Self);

  with LIconLabel do
  begin
    Constraints.MinHeight:=35;

    with Icon do
    begin
      Caption:=PFontAwesomeIcon;
      JustifyContent:=JustifyStart;
    end;

    with Label1 do
    begin
      Caption:=PCaption;
      JustifyContent:=JustifyStart;
    end;
  end;

  inherited Add(LIconLabel);
end;

end.
