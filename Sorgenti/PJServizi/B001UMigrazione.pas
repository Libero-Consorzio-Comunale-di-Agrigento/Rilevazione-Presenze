unit B001UMigrazione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, {DbTables,} ComCtrls, Grids, DBGrids, ExtCtrls, Variants;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Db1: TDatabase;
    Db2: TDatabase;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Table1: TTable;
    Table2: TTable;
    Button1: TButton;
    Query1: TQuery;
    Label5: TLabel;
    BatchMove1: TBatchMove;
    Edit1: TEdit;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Alias1,Alias2:String;
    Campi:TStringList;
    procedure Migrazione(Nome:String);
    procedure CancellaTabella(const Nome:String);
    function TipoDato(Tipo:TFieldType;Size:Word;Nome,Driver:String;Required:Boolean):String;
    procedure TrasferimentoDati(Nome:String);
    function SvuotaTabella(Nome:String):Boolean;
  public
    { Public declarations }
    //TableSpaces per Oracle
    TSLavoro,TSIndici:String;
  end;

var
  Form1: TForm1;

implementation

uses B001UTableSpace;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
 Session.GetAliasNames(ComboBox1.Items);
 ComboBox2.Items.Assign(ComboBox1.Items);
 Alias1:='';
 Alias2:='';
 Campi:=TStringList.Create;
end;

procedure TForm1.ComboBox1Exit(Sender: TObject);
begin
  if Sender = ComboBox1 then
    begin
    if Alias1 = ComboBox1.Text then exit;
    Alias1:=ComboBox1.Text;
    Db1.Close;
    Db1.AliasName:=ComboBox1.Text;
    ListBox1.Items.Clear;
    try
      Db1.Open;
    except
      raise Exception.Create('Alias inesistente! troppo difficile usare la lista?');
    end;
    Label3.Caption:=Session.GetAliasDriverName(Db1.AliasName);
    if Label3.Caption = 'STANDARD' then
      Session.GetTableNames('Db1','*.*',True,False,ListBox1.Items)
    else
      Session.GetTableNames('Db1','*.*',False,False,ListBox1.Items);
    end;
  if Sender = ComboBox2 then
    begin
    if Alias2 = ComboBox2.Text then exit;
    Alias2:=ComboBox2.Text;
    Db2.Close;
    Db2.AliasName:=ComboBox2.Text;
    ListBox2.Items.Clear;
    try
      Db2.Open;
    except
      raise Exception.Create('Alias inesistente! troppo difficile usare la lista?');
    end;
    Label4.Caption:=Session.GetAliasDriverName(Db2.AliasName);
    if Label4.Caption = 'STANDARD' then
      Session.GetTableNames('Db2','*.*',True,False,ListBox2.Items)
    else
      Session.GetTableNames('Db2','*.*',False,False,ListBox2.Items);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:Word;
begin
  if Label4.Caption = 'ORACLE' then
    begin
    TSLavoro:='LAVORO';
    TSIndici:='INDICI';
    if B001FTableSpace.ShowModal = mrOK then
      begin
      TSLavoro:=B001FTableSpace.Edit1.Text;
      TSIndici:=B001FTableSpace.Edit2.Text;
      end;
    end;
  for i:=0 to ListBox1.Items.Count - 1 do
    if ListBox1.Selected[i] then
      Migrazione(ListBox1.Items[i]);
  Label6.Caption:='Migrazione terminata';
end;

procedure TForm1.Migrazione(Nome:String);
{Converto le tabelle da un driver all'altro}
var Esiste:Boolean;
    Attrib,Primary:String;
    i:Integer;
//Sostituisco il ; con la ,
function comma(Stringa:String):String;
var j:Word;
begin
  for j:=1 to Length(Stringa) do
    if Stringa[j] = ';' then
      Stringa[j]:=',';
  Result:=Stringa;
end;
FUNCTION ExtLess(S:String):String;
begin
  Result:=S;
  if Pos('.',S) > 0 then
    Result:=Copy(S,1,Pos('.',S) - 1);
end;
begin
 if RadioGroup1.ItemIndex = 2 then
   begin
   if SvuotaTabella(Nome) then
     TrasferimentoDati(Nome);
   exit;
   end;
 Label6.Caption:='Creazione struttura tabella ' + Nome;
 Esiste:=True;
 with Table2 do
   begin
   Close;
   TableName:=Nome;
   try
     Open;
   except;
     Esiste:=False;
   end;
   Close;
   //Tabella già esistente
   if Esiste then
     begin
     //if MessageDlg('Tabella esistente:sovrascrivere?',
     //   mtInformation, [mbYes, mbNo], 0) = mrNo then
     //  exit;
     Label6.Caption:='Cancellazione tabella ' + Nome;
     Label6.RePaint;
     CancellaTabella(Nome);
     Label6.Caption:='Creazione struttura tabella ' + Nome;
     Label6.RePaint;
     end;
   end;
 Campi.Clear;
 with Table1 do
   begin
   Close;
   TableName:=Nome;
   Open;
   FieldDefs.Update;
   IndexDefs.Update;
   for i:=0 to FieldDefs.Count - 1 do
     with FieldDefs[i] do
       begin
       if i > 0 then Attrib:=','
       else Attrib:='';
       Attrib:=Attrib + Name + TipoDato(DataType,Size,Name,Label4.Caption,Required);
       Campi.Add(Attrib);
       end;
   for i:=0 to IndexDefs.Count - 1 do
     with IndexDefs[i] do
       begin
       if ixPrimary in Options then
         begin
         Primary:=',PRIMARY KEY (' + Comma(Fields) + ')';
         if (Label4.Caption = 'ORACLE') and (TSIndici <> '') then
           Primary:=Primary + ' USING INDEX TABLESPACE ' + TSIndici;
         end;
       end;
   with Query1 do
     begin
     Sql.Clear;
     Sql.Add('CREATE TABLE ' + ExtLess(Nome) + '(');
     for i:=0 to Campi.Count - 1 do
       Sql.Add(Campi[i]);
     Sql.Add(Primary);
     Sql.Add(')');
     if (Label4.Caption = 'ORACLE') and (TSLavoro <> '') then
       Sql.Add('TABLESPACE ' + TSLavoro);
     ExecSql;
     end;
   for i:=0 to IndexDefs.Count - 1 do
     with IndexDefs[i],Query1 do
       begin
       Sql.Clear;
       if not(ixPrimary in Options) then
         begin
         Sql.Add('CREATE ');
         if ixUnique in Options then
           Sql.Add('UNIQUE ');
         Sql.Add('INDEX ' + IndexDefs[i].Name + ' ON ' + ExtLess(Nome) + ' (' + Comma(IndexDefs[i].Fields) + ')');
         if (Label4.Caption = 'ORACLE') and (TSIndici <> '') then
           Sql.Add('TABLESPACE ' + TSIndici);
         try
           ExecSql;
         except
           Continue;
         end;
         end;
       end;
   end;
 ListBox2.Items.Add(Nome);
 with Query1 do
   begin
   Sql.Clear;
   Sql.Add('COMMIT');
   ExecSql;
   end;
 //Migrazione dati//
 if RadioGroup1.ItemIndex = 1 then
   TrasferimentoDati(Nome);
end;

function TForm1.SvuotaTabella(Nome:String):Boolean;
begin
  Result:=True;
  with Query1 do
    begin
    SQL.Clear;
    SQL.Add('DELETE FROM ' + Nome);
    try
      ExecSQL;
    except
      Result:=False;
    end;
    end;
end;

procedure TForm1.TrasferimentoDati(Nome:String);
FUNCTION ExtLess(S:String):String;
begin
  Result:=S;
  if Pos('.',S) > 0 then
    Result:=Copy(S,1,Pos('.',S) - 1);
end;
begin
 Label6.Caption:='Trasferimento dati tabella ' + Nome;
 Label6.RePaint;
 with Query1 do
   begin
   DataBaseName:=Edit1.Text;
   SQL.Clear;
   SQL.Add(Format('INSERT INTO ":%s:%s" SELECT * FROM ":%s:%s"',[ComboBox2.Text,ExtLess(Nome),ComboBox1.Text,Nome]));
   ExecSQL;
   DataBaseName:='Db2';
   end;
end;

procedure TForm1.CancellaTabella(const Nome:String);
{Cancello la tabella se già esistente}
begin
  with Query1 do
    begin
    Sql.Clear;
    Sql.Add('DROP TABLE ' + Nome);
    ExecSql;
    end;
end;

function TForm1.TipoDato(Tipo:TFieldType;Size:Word;Nome,Driver:String;Required:Boolean):String;
{Costruisco il campo in base al suo tipo}
var i:byte;
begin
  case Tipo of
    ftSmallint:Result:=' NUMERIC(4)';
    ftInteger,ftWord:Result:=' NUMERIC(9)';
    ftFloat:Result:=' NUMERIC(38,2)';
    ftDate,ftTime,ftDateTime:Result:=' DATE';
    ftString:if Driver = 'INTRBASE' then Result:=' VARCHAR (' + IntToStr(Size) + ')'
             else if Driver = 'ORACLE' then Result:=' VARCHAR2 (' + IntToStr(Size) + ')';
    ftMemo:if Driver = 'INTRBASE' then Result:=' BLOB'
           else if Driver = 'ORACLE' then Result:=' LONG';
  end;
  with Table1 do
    if FieldByName(Nome).IsIndexField then
      for i:=0 to IndexDefs.Count - 1 do
        if ixPrimary in IndexDefs[i].Options then
          if Pos(Nome,IndexDefs[i].Fields) > 0 then
            begin
            Required:=True;
            Break;
            end;
  if Required then
    begin
    Result:=Result + ' NOT NULL';
    exit;
    end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Campi.Free;
end;

end.
