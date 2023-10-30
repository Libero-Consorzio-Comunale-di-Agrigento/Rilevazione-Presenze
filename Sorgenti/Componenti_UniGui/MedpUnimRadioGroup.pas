unit MedpUnimRadioGroup;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimRadioButton, Generics.Collections;

type
  TMedpUnimRadioGroup = class(TMedpUnimPanelBase)
  private
    FItems: TStringList;
    FItemIndex: Integer;
    FListRadioButton: TObjectList<TMedpUnimRadioButton>;
    procedure SetItems(Value: TStringList);
    procedure SetItemIndex(const Value: Integer);
  protected
    procedure SetEnabled(Value: Boolean); override;
    procedure SetDefaultProperties; override;
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetItemIndexOnClick(Sender: TMedpUnimRadioButton);
  published
    property Items: TStringList read FItems write SetItems;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimRadioGroup]);
end;

{ TMedpUnimRadioGroup }

constructor TMedpUnimRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
  FItems:=TStringList.Create;
  FListRadioButton:=TObjectList<TMedpUnimRadioButton>.Create(True);

  FItemIndex:=-1;
end;

destructor TMedpUnimRadioGroup.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FListRadioButton);
  inherited;
end;

procedure TMedpUnimRadioGroup.SetDefaultProperties;
begin
  inherited;
  Height:=200;
  Width:=150;

  Layout:='vbox';
  LayoutAttribs.Align:='start';
  LayoutAttribs.Pack:='justify';
  LayoutConfig.Height:='auto';
  LayoutConfig.Width:='auto';
end;

procedure TMedpUnimRadioGroup.SetEnabled(Value: Boolean);
var i: Integer;
begin
  inherited;
  if Assigned(FListRadioButton) then
  begin
    for i := 0 to FListRadioButton.Count-1 do
      FListRadioButton[i].Enabled:=Value;
  end;
end;

procedure TMedpUnimRadioGroup.LoadCompleted;
var i: Integer;
begin
  inherited;

  if Assigned(FItems) then
  begin
    for i := 0 to FItems.Count-1 do
    begin

      FListRadioButton.Add(TMedpUnimRadioButton.Create(Self));

      with FListRadioButton[i] do
      begin
        RadioLabel.ScreenMask:=Self.ScreenMask;
        RadioIcon.ScreenMask:=Self.ScreenMask;
        RadioLabel.Caption:=FItems[i];
        Parent:=Self;
        OnChange:=ChangeEvent;
        SetSubComponent(True);
        RadioIcon.WebName:=Self.Name; //usato lato client per gestire i radio button con esclusione
        if i = ItemIndex then
        begin
          RadioIcon.Checked:=True;
          RadioIcon.JSInterface.JSCall('check', [True]);
        end;
      end;
    end;
  end;
end;

procedure TMedpUnimRadioGroup.SetItemIndex(const Value: Integer);
begin
  if (Value >= -1) then
  begin
    FItemIndex:=Value;

    if (Value >= 0) and (Value < FListRadioButton.Count) then
      FListRadioButton[Value].RadioIcon.Checked:=True
  end;
end;

procedure TMedpUnimRadioGroup.SetItemIndexOnClick(Sender: TMedpUnimRadioButton);
var i: Integer;
begin
  for i := 0 to FListRadioButton.Count-1 do
  begin
    if Sender = FListRadioButton[i] then
    begin
      FItemIndex:=i;
      break;
    end;
  end;
end;

procedure TMedpUnimRadioGroup.SetItems(Value: TStringList);
begin
  SetVCLClassProperty('Items', Value);

  FItems.Assign(Value);
end;



end.
