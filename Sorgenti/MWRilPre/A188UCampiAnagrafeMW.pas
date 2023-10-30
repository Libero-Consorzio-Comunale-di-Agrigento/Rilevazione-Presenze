unit A188UCampiAnagrafeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Oracle, DB, OracleData, A000UInterfaccia;

type
  TA188FCampiAnagrafeMW = class(TR005FDataModuleMW)
    selColsDefs: TOracleDataSet;
    selColsT030V430: TOracleDataSet;
  private
    {private declarations}
  public
    ModificaUtente:Boolean;
    I010:TOracleDataSet;
    DefAnagrafe:TFieldDefs;
    procedure I010AfterOpen;
    procedure I010AfterScroll;
    procedure I010BeforePost;
    procedure I010BeforeInsert;
    procedure AssegnaValoriDefault;
  end;

implementation

{$R *.dfm}

procedure TA188FCampiAnagrafeMW.I010AfterOpen;
var Nome,ValDef:string;
begin
  ModificaUtente:=False;
  selColsT030V430.Open;
  while not selColsT030V430.Eof do
  begin
    Nome:=selColsT030V430.FieldByName('COLUMN_NAME').AsString;
    if not I010.Locate('Nome_Campo',Nome,[]) then
    begin
      I010.Append;
      I010.FieldByName('NOME_CAMPO').AsString:=Nome;
      I010.FieldByName('NOME_LOGICO').AsString:=Nome;
      if Parametri.Applicazione = 'PAGHE' then
        I010.FieldByName('APPLICAZIONE').AsString:=Parametri.Applicazione
      else
        I010.FieldByName('APPLICAZIONE').AsString:='*';
      I010.Post;
    end;
    selColsT030V430.Next;
  end;
  selColsT030V430.Close;

  selColsDefs.Open;
  I010.First;
  I010.DisableControls;
  while not I010.Eof do
    try
      ValDef:='';
      try
        if Copy(I010.FieldByName('Nome_Campo').AsString,1,4) = 'T430' then
          ValDef:=VarToStr(selColsDefs.Lookup('TABLE_NAME;COLUMN_NAME',VarArrayOf(['T430_STORICO',Copy(I010.FieldByName('Nome_Campo').AsString,5,100)]),'DATA_DEFAULT'))
        else if Copy(I010.FieldByName('Nome_Campo').AsString,1,4) = 'P430' then
          ValDef:=VarToStr(selColsDefs.Lookup('TABLE_NAME;COLUMN_NAME',VarArrayOf(['P430_ANAGRAFICO',Copy(I010.FieldByName('Nome_Campo').AsString,5,100)]),'DATA_DEFAULT'))
        else
          ValDef:=VarToStr(selColsDefs.Lookup('TABLE_NAME;COLUMN_NAME',VarArrayOf(['T030_ANAGRAFICO',I010.FieldByName('Nome_Campo').AsString]),'DATA_DEFAULT'));
        ValDef:=Trim(ValDef);
        if UpperCase(ValDef) = 'NULL' then
          ValDef:='';
        if (Copy(ValDef,1,1) = '''') and (Copy(ValDef,Length(ValDef),1) = '''') then
          ValDef:=Copy(ValDef,2,Length(ValDef) - 2);
        I010.Edit;
        I010.FieldByName('VAL_DEFAULT').AsString:=ValDef;
        I010.Post;
      except
      end;
      I010.Next;
    except
      I010.Delete
    end;
  selColsDefs.Close;
  I010.First;
  I010.EnableControls;
  I010.BeforePost:=nil;
  I010.Fields[0].ReadOnly:=True;
  I010.Fields[6].Visible:=Parametri.Applicazione = 'STAGIU';
  ModificaUtente:=True;
end;

procedure TA188FCampiAnagrafeMW.I010AfterScroll;
begin
  I010.FieldByName('VAL_DEFAULT').ReadOnly:=Copy(I010.FieldByName('NOME_CAMPO').AsString,1,4) = 'P430';
end;

procedure TA188FCampiAnagrafeMW.I010BeforeInsert;
begin
  if ModificaUtente then Abort;
end;

procedure TA188FCampiAnagrafeMW.I010BeforePost;
begin
  if  (Copy(I010.FieldByName('NOME_CAMPO').AsString,1,4) = 'P430')
  and (I010.FieldByName('VAL_DEFAULT').Value <> I010.FieldByName('VAL_DEFAULT').medpOldValue)
  then
    raise Exception.Create('Impossibile modificare il valore di default per l''anagrafica stipendiale');
end;

procedure TA188FCampiAnagrafeMW.AssegnaValoriDefault;
var V:String;
begin
  if I010.State in [dsInsert,dsEdit] then
    I010.Post;
  I010.DisableControls;
  I010.First;
  with TOracleQuery.Create(nil) do
  try
    Session:=I010.Session;
    while not I010.Eof do
    begin
      SQL.Clear;
      if Trim(I010.FieldByName('VAL_DEFAULT').AsString) = '' then
        V:='NULL'
      else
        V:='''' + Trim(I010.FieldByName('VAL_DEFAULT').AsString) + '''';
      if Copy(I010.FieldByName('NOME_CAMPO').AsString,1,4) = 'T430' then
      begin
        if Copy(I010.FieldByName('NOME_CAMPO').AsString,1,6) <> 'T430D_' then
          SQL.Add(Format('ALTER TABLE T430_STORICO MODIFY %s DEFAULT %s',[Copy(I010.FieldByName('NOME_CAMPO').AsString,5,40),V]));
      end
      else if Copy(I010.FieldByName('NOME_CAMPO').AsString,1,4) = 'P430' then
      begin
        (*Non si fa nulla!!!!!
        if Copy(I010.FieldByName('NOME_CAMPO').AsString,1,6) <> 'P430D_' then
          SQL.Add(Format('ALTER TABLE P430_ANAGRAFICO MODIFY %s DEFAULT %s',[Copy(I010.FieldByName('NOME_CAMPO').AsString,5,40),V]));
        *)
      end
      else
        SQL.Add(Format('ALTER TABLE T030_ANAGRAFICO MODIFY %s DEFAULT %s',[I010.FieldByName('NOME_CAMPO').AsString,V]));
      try
        if SQL.Count > 0 then
          Execute;
      except
      end;
      I010.Next;
    end;
  finally
    Free;
    I010.First;
    I010.EnableControls;
  end;
end;

end.
