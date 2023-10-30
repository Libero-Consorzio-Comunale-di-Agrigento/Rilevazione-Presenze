unit MedpUnimTypes;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, ExtPascal, Ext;

type
  TJustifyContent = (JustifyStart, JustifyEnd, JustifyCenter);
  TAlignItems = (AlignStart, AlignEnd, AlignCenter);

  TOnChangeEvent = procedure(Sender: TObject) of object;
  TOnClickEvent = procedure(Sender: TObject) of object;

  TBoxModelProperty = class(TComponent)
    private
      FTop: String;
      FBottom: String;
      FRight: String;
      FLeft: String;

      FOnChange: TOnChangeEvent;

      procedure DoOnChange; virtual;
      procedure SetBottom(const Value: String);
      procedure SetLeft(const Value: String);
      procedure SetRight(const Value: String);
      procedure SetTop(const Value: String);
    public
      constructor Create(AOwner: TComponent); override;
    published
      property Top: String read FTop write SetTop;
      property Bottom: String read FBottom write SetBottom;
      property Right: String read FRight write SetRight;
      property Left: String read FLeft write SetLeft;

      property OnChange: TOnChangeEvent read FOnChange write FOnChange;
  end;

  TBoxModel = class(TComponent)
    private
      FMargin:  TBoxModelProperty;
      FPadding: TBoxModelProperty;
      FBorder:  TBoxModelProperty;
      FBorderRadius: String;

      FOnChange: TOnChangeEvent;

      procedure SetOnChange(const Value: TOnChangeEvent);
      procedure SetBorderRadius(const Value: String);
    public
      constructor Create(AOwner: TComponent); override;

    published
      property CSSMargin:  TBoxModelProperty read FMargin;
      property CSSPadding: TBoxModelProperty read FPadding;
      property CSSBorder:  TBoxModelProperty read FBorder;
      property CSSBorderRadius: String read FBorderRadius write SetBorderRadius;
      property OnChange: TOnChangeEvent read FOnChange write SetOnChange;
  end;

implementation

{ TBoxModelProperty }

constructor TBoxModelProperty.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTop:='0px';
  FBottom:='0px';
  FRight:='0px';
  FLeft:='0px';
end;

procedure TBoxModelProperty.DoOnChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TBoxModelProperty.SetBottom(const Value: String);
begin
  FBottom := Value;
  DoOnChange;
end;

procedure TBoxModelProperty.SetLeft(const Value: String);
begin
  FLeft := Value;
  DoOnChange;
end;

procedure TBoxModelProperty.SetRight(const Value: String);
begin
  FRight := Value;
  DoOnChange;
end;

procedure TBoxModelProperty.SetTop(const Value: String);
begin
  FTop := Value;
  DoOnChange;
end;

{ TBoxModel }

constructor TBoxModel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMargin:=TBoxModelProperty.Create(Self);
  FPadding:=TBoxModelProperty.Create(Self);
  FBorder:=TBoxModelProperty.Create(Self);

  FMargin.SetSubComponent(True);
  FPadding.SetSubComponent(True);
  FBorder.SetSubComponent(True);

  FBorderRadius:='0px';
end;

procedure TBoxModel.SetBorderRadius(const Value: String);
begin
  FBorderRadius := Value;

  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TBoxModel.SetOnChange(const Value: TOnChangeEvent);
begin
  FOnChange:=Value;

  FMargin.OnChange:=Value;
  FPadding.OnChange:=Value;
  FBorder.OnChange:=Value;
end;

end.
