unit MedpUnimPanelNumberEdit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses, MedpUnimTypes,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimNumberEdit, MedpUnimLabel, MedpUnimEdit;

type
  //usa un edit normale, visualizza un messaggio di errore se è stato inserito un carattere non numerico
  TMedpUnimPanelNumberEdit = class(TMedpUnimPanelBase)
  private
    FLabel: TMedpUnimLabel;
    FEdit: TMedpUnimEdit;
  protected
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property PanelLabel: TMedpUnimLabel read FLabel;
    property Edit: TMedpUnimEdit read FEdit;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelNumberEdit]);
end;

{ TMedpUnimPanelNumberEdit }

constructor TMedpUnimPanelNumberEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLabel:=TMedpUnimLabel.Create(Self);
  FEdit:=TMedpUnimEdit.Create(Self);

  with FLabel do
  begin
    Name:='Label';
    Caption:='';
    Flex:=1;
    LayoutConfig.Height:='auto';
    JustifyContent:=JustifyStart;
    OnClick:=nil;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FEdit do
  begin
    Name:='Edit';
    Caption:='';
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='50%';
    OnClick:=nil;
    SetSubComponent(True);
    Parent:=Self;
    ClientEvents.ExtEvents.Append('change=function change(sender, newValue, oldValue, eOpts){ var value = newValue.replace(/[^0-9]/gi, "");' + ' if (value.length !== newValue.length) Ext.Msg.alert("Attenzione!", "Per il campo selezionato sono consentiti soltanto caratteri numerici", Ext.emptyFn);}');
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelNumberEdit.SetDefaultProperties;
begin
  inherited;

  Height:=30;
  Width:=100;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='auto';
  LayoutConfig.Height:='auto';
  OnClick:=nil;
end;

end.
