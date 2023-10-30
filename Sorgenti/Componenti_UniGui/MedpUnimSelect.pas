unit MedpUnimSelect;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniMultiItem, unimSelect, MedpUnimTypes, Generics.Collections, Variants,
  Data.DB, FireDAC.Comp.Client, uniGUITypes;

type

  TTipoTesto = (Codice, Descrizione, CodiceDescrizione, DescrizioneCodice);

  TMedpUnimSelect = class(TUnimSelect)
  private
    FBoxModel: TBoxModel;
    FDefaultCode: String;
    FTipoTesto: TTipoTesto;
    FSeparatoreTesto: String;
    FListaCodici: TStringList;
    FListaDescrizioni: TStringList;
    FElementoVuoto: Boolean;
    procedure AddItem(PCodice, PDescrizione: String);
    procedure SetListaCodici(const Value: TStringList);
    procedure SetListaDescrizioni(const Value: TStringList);
  protected
    procedure SetDefaultProperties; virtual;
    procedure OnBoxModelChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear; override;

    function Popola(PListaElementi: TList<TPair<String,String>>; PDefaultCode: String): Boolean; overload;
    function Popola(PListaElementi: TList<String>; PDefaultCode: String): Boolean; overload;
    function Popola(PListaElementi: TStringList; PDefaultCode: String): Boolean; overload;
    function Add(PCodice, PDescrizione: String): Boolean;
    function IndexOfCode(PCodice: String): Integer;
    function IndexOfDefaultCode: Integer;
  published
    property BoxModel: TBoxModel read FBoxModel;

    property TipoTesto: TTipoTesto read FTipoTesto write FTipoTesto default CodiceDescrizione;
    property SeparatoreTesto: String read FSeparatoreTesto write FSeparatoreTesto;
    property DefaultCode: String read FDefaultCode write FDefaultCode;
    property ListaCodici: TStringList read FListaCodici write SetListaCodici;
    property ListaDescrizioni: TStringList read FListaDescrizioni write SetListaDescrizioni;
    property ElementoVuoto: Boolean read FElementoVuoto write FElementoVuoto;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimSelect]);
end;

{ TMedpUnimSelect }

constructor TMedpUnimSelect.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FBoxModel:=TBoxModel.Create(Self);
  FBoxModel.SetSubComponent(True);
  FBoxModel.OnChange:=OnBoxModelChange;

  FListaCodici:=TStringList.Create;
  FListaDescrizioni:=TStringList.Create;

  FTipoTesto:=CodiceDescrizione;
  FSeparatoreTesto:=' ';

  FDefaultCode:='';
  FElementoVuoto:=False;
  SetDefaultProperties;
end;

destructor TMedpUnimSelect.Destroy;
begin
  FreeAndNil(FListaCodici);
  FreeAndNil(FListaDescrizioni);
  inherited;
end;

procedure TMedpUnimSelect.SetDefaultProperties;
begin
  Margins.SetBounds(0, 0, 0, 0);
  AlignWithMargins:=False;
  Anchors:=[];
  Align:=alNone;

  Picker:=dptFloated;
  ClientEvents.UniEvents.Append('afterCreate=function afterCreate(sender){ sender.setEditable(false); }');

  Height:=45;
  Width:=200;
end;

procedure TMedpUnimSelect.SetListaCodici(const Value: TStringList);
begin
  SetVCLClassProperty('ListaCodici', Value);

  FListaCodici := Value;
end;

procedure TMedpUnimSelect.Clear;
begin
  inherited;
  ItemIndex:=-1;
  FListaCodici.Clear;
  FListaDescrizioni.Clear;
  FDefaultCode:='';
end;

procedure TMedpUnimSelect.SetListaDescrizioni(const Value: TStringList);
begin
  SetVCLClassProperty('ListaDescrizioni', Value);

  FListaDescrizioni:=Value;
end;

function TMedpUnimSelect.IndexOfCode(PCodice: String): Integer;
begin
  Result:=FListaCodici.IndexOf(PCodice);
end;

function TMedpUnimSelect.IndexOfDefaultCode: Integer;
begin
  Result:=FListaCodici.IndexOf(FDefaultCode);
end;

procedure TMedpUnimSelect.OnBoxModelChange(Sender: TObject);
begin
  if IsLoading then
  begin
    AddStyle('margin-top', FBoxModel.CSSMargin.Top);
    AddStyle('margin-right', FBoxModel.CSSMargin.Right);
    AddStyle('margin-bottom', FBoxModel.CSSMargin.Bottom);
    AddStyle('margin-left', FBoxModel.CSSMargin.Left);

    AddStyle('padding-top', FBoxModel.CSSPadding.Top);
    AddStyle('padding-right', FBoxModel.CSSPadding.Right);
    AddStyle('padding-bottom', FBoxModel.CSSPadding.Bottom);
    AddStyle('padding-left', FBoxModel.CSSPadding.Left);

    AddStyle('border-top', FBoxModel.CSSBorder.Top);
    AddStyle('border-right', FBoxModel.CSSBorder.Right);
    AddStyle('border-bottom', FBoxModel.CSSBorder.Bottom);
    AddStyle('border-left', FBoxModel.CSSBorder.Left);
    AddStyle('border-radius', FBoxModel.CSSBorderRadius);
  end
  else
  begin
    SetDomStyleProperty('marginTop', FBoxModel.CSSMargin.Top);
    SetDomStyleProperty('marginRight', FBoxModel.CSSMargin.Right);
    SetDomStyleProperty('marginBottom', FBoxModel.CSSMargin.Bottom);
    SetDomStyleProperty('marginLeft', FBoxModel.CSSMargin.Left);

    SetDomStyleProperty('paddingTop', FBoxModel.CSSPadding.Top);
    SetDomStyleProperty('paddingRight', FBoxModel.CSSPadding.Right);
    SetDomStyleProperty('paddingBottom', FBoxModel.CSSPadding.Bottom);
    SetDomStyleProperty('paddingLeft', FBoxModel.CSSPadding.Left);

    SetDomStyleProperty('borderTop', FBoxModel.CSSBorder.Top);
    SetDomStyleProperty('borderRight', FBoxModel.CSSBorder.Right);
    SetDomStyleProperty('borderBottom', FBoxModel.CSSBorder.Bottom);
    SetDomStyleProperty('borderLeft', FBoxModel.CSSBorder.Left);
    SetDomStyleProperty('borderRadius', FBoxModel.CSSBorderRadius);
  end;
end;

procedure TMedpUnimSelect.AddItem(PCodice, PDescrizione: String);
begin

  if (PCodice = '') and (PDescrizione = '') then  // se sto gestendo l'elemento vuoto
    Items.Add(' ')  // ASCII #255 - non funziona copia-incolla del codice!!!!
  else
    case FTipoTesto of
      Codice: Items.Add(PCodice);
      Descrizione: Items.Add(PDescrizione);
      CodiceDescrizione: Items.Add(Trim(PCodice + FSeparatoreTesto + PDescrizione));
      DescrizioneCodice: Items.Add(Trim(PDescrizione + FSeparatoreTesto + PCodice));
    end;
end;

function TMedpUnimSelect.Add(PCodice, PDescrizione: String): Boolean;
begin
  if Assigned(FListaCodici) and Assigned(FListaDescrizioni) then
  begin
    FListaCodici.Add(PCodice);
    FListaDescrizioni.Add(PDescrizione);
    AddItem(PCodice, PDescrizione);
    Result:=True;
  end
  else
    Result:=False;
end;

function TMedpUnimSelect.Popola(PListaElementi: TList<TPair<String,String>>; PDefaultCode: String): Boolean;
var i: Integer;
begin
  Clear;

  if FElementoVuoto then
    Add('', '');

  if Assigned(PListaElementi) then
  begin
    FDefaultCode:=PDefaultCode;

    for i:=0 to PListaElementi.Count-1 do
    begin
      Add(PListaElementi[i].Key, PListaElementi[i].Value);

      if (FDefaultCode <> '') and (PListaElementi[i].Key = FDefaultCode) then
        ItemIndex:=i;
    end;

    Result:=True;
  end
  else
    Result:=False;
end;

function TMedpUnimSelect.Popola(PListaElementi: TList<String>; PDefaultCode: String): Boolean;
var LListaPair: TList<TPair<String,String>>;
    i: Integer;
begin
  LListaPair:=TList<TPair<String,String>>.Create;
  try
    for i:=0 to PListaElementi.Count-1 do
    begin
      LListaPair.Add(TPair<String,String>.Create(PListaElementi[i], PListaElementi[i]));
    end;

    Result:=Popola(LListaPair, PDefaultCode);
  finally
    FreeAndNil(LListaPair);
  end;
end;

function TMedpUnimSelect.Popola(PListaElementi: TStringList; PDefaultCode: String): Boolean;
var LListaPair: TList<TPair<String,String>>;
    i: Integer;
begin
  LListaPair:=TList<TPair<String,String>>.Create;
  try
    for i:=0 to PListaElementi.Count-1 do
    begin
      LListaPair.Add(TPair<String,String>.Create(PListaElementi[i], PListaElementi[i]));
    end;

    Result:=Popola(LListaPair, PDefaultCode);
  finally
    FreeAndNil(LListaPair);
  end;
end;

end.
