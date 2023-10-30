unit meIWDBGrid;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,Db, OracleData, Oracle,
  IWBaseHTMLControl, IWControl, IWCompGrids, Generics.Collections, C180FunzioniGenerali,
  IWDBGrids, IWCompGridCommon, Menus, A000UInterfaccia, StrUtils, Math;

type
  TmeIWDBGrid = class(TIWDBGrid)
  private
    FContextMenu: TPopupMenu;
    FFixedColumns: Integer;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function medpIndexColonna(Campo:String):Integer;
    function medpColonna(const Campo:String):TIWDBGridColumn; overload;
    function medpColonna(const Index:Integer):TIWDBGridColumn; overload;
    procedure CreateImplicitColumns;
    function ToCsv: String;
    function ToXlsx: TStream;
  published
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
    property medpFixedColumns: Integer read FFixedColumns write FFixedColumns;
  end;

implementation

constructor TmeIWDBGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderSize:=0;
  BorderStyle:=tfVoid;
  Caption:='';
  CellPadding:=0;
  CellRenderOptions:=[];
  CellSpacing:=0;
  Css:='grid';
  Font.Enabled:=False;
  Lines:=tlNone;
  RenderSize:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderStatus:=True;
    RenderVisibility:=True;
    RenderZIndex:=False;
    RenderPadding:=False;
    { DONE : TEST IW 14 OK }
    RenderBorder:=False;
  end;
  UseSize:=False;
  medpFixedColumns:=0;
  FContextMenu:=nil;
  { DONE : TEST IW 14 OK }
  HeaderRowCount:=0;
end;

//bug 12.2.6. se cambia datasource non rilegge il campo ma tiene il puntatore al vecchio campo
procedure TmeIWDBGrid.CreateImplicitColumns;
var i :Integer;
fieldName : String;
begin
  if Columns.Count = 0 then
    inherited
  else
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      fieldName:=TIWDBGridColumn(Columns.Items[i]).DataField;
      TIWDBGridColumn(Columns.Items[i]).DataField:='';
      TIWDBGridColumn(Columns.Items[i]).DataField:=fieldName;
      fieldName:=TIWDBGridColumn(Columns.Items[i]).LinkField;
      TIWDBGridColumn(Columns.Items[i]).LinkField:='';
      TIWDBGridColumn(Columns.Items[i]).LinkField:=fieldName;
    end;
  end;
end;

function TmeIWDBGrid.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;


procedure TmeIWDBGrid.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TmeIWDBGrid.medpIndexColonna(Campo:String):Integer;
var i:Integer;
begin
  Result:=-1;
  Campo:=UpperCase(Campo);
  for i:=0 to Columns.Count - 1 do
    if UpperCase((Columns.Items[i] as TIWDBGridColumn).DataField) = Campo then
    begin
      Result:=i;
      Break;
    end;
end;

function TmeIWDBGrid.medpColonna(const Campo:String):TIWDBGridColumn;
var i:Integer;
begin
  Result:=nil;
  i:=medpIndexColonna(Campo);
  if i >= 0 then
    Result:=(Columns.Items[i] as TIWDBGridColumn);
end;

function TmeIWDBGrid.medpColonna(const Index:Integer):TIWDBGridColumn;
begin
  if (Index < 0) or (Index >= Columns.Count) then
    Result:=nil
  else
    Result:=(Columns.Items[Index] as TIWDBGridColumn);
end;

function TmeIWDBGrid.ToCsv: String;
var
  DS: TDataSet;
  Riga: String;
  BM: TBookMark;
  i: Integer;
begin
  Result:='';

  // utilizza il dataset collegato via datasource alla grid
  DS:=DataSource.DataSet;
  if not Assigned(DS) then
    raise Exception.Create(Format('dataset della tabella %s non assegnato',[Name]));

  // intestazione
  Riga:='';
  for i:=0 to DS.FieldCount - 1 do
    if DS.Fields[i].Visible then
      Riga:=Riga + Format('"%s"',[Trim(Uppercase(DS.Fields[i].FieldName))]) + #9;
  Result:=Result + Riga + #13#10;

  // dettaglio
  BM:=DS.Bookmark;
  try
    DS.First;
    while not DS.Eof do
    begin
      Riga:='';
      for i:=0 to DS.FieldCount - 1 do
        if DS.Fields[i].Visible then
          Riga:=Riga + Format('"%s"',[Trim(DS.Fields[i].AsString)]) + #9;

      Result:=Result + Riga + #13#10;
      DS.Next;
    end;

    // riposizionamento cursore
    if DS.BookmarkValid(BM) then
      DS.GotoBookmark(BM);
  finally
    DS.FreeBookmark(BM);
  end;
end;

function TmeIWDBGrid.ToXlsx: TStream;
var
  Campo: String;
  i: Integer;
  Col: TIWDBGridColumn;
  ListaColonne: TList<TPair<String,String>>;
begin
  ListaColonne:=TList<TPair<String,String>>.Create;
  for i:=0 to Columns.Count - 1 do
  begin
    Campo:=UpperCase((Columns.Items[i] as TIWDBGridColumn).DataField);
    Col:=medpColonna(Campo);
    if (Copy(Campo,1,4) <> 'DBG_') and Col.Visible then
      ListaColonne.Add(TPair<String,String>.Create(Campo, Col.Title.Text.Trim))
  end;
  Result:=R180DatasetToXlsx(SessioneOracle,True,DataSource.DataSet,ListaColonne);
end;

end.
