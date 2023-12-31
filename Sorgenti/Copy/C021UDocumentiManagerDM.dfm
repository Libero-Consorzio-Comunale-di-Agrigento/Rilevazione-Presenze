object C021FDocumentiManagerDM: TC021FDocumentiManagerDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 236
  Width = 531
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select T960.*, ROWID'
      'from   T960_DOCUMENTI_INFO T960'
      'where  ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    AutoCalcFields = False
    CommitOnPost = False
    Left = 24
    Top = 16
  end
  object selT961: TOracleQuery
    SQL.Strings = (
      'select DOCUMENTO'
      'from   T961_DOCUMENTI_FILE'
      'where  ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 24
    Top = 80
  end
  object insT961: TOracleQuery
    SQL.Strings = (
      'insert into T961_DOCUMENTI_FILE (ID, DOCUMENTO)'
      'values (:ID, :DOCUMENTO)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001400
      00003A0044004F00430055004D0045004E0054004F0071000000000000000000
      0000}
    Left = 88
    Top = 80
  end
  object selT960Count: TOracleQuery
    SQL.Strings = (
      'select count(ID)'
      'from   T960_DOCUMENTI_INFO'
      'where  ID = :ID'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 152
    Top = 16
  end
  object delT960: TOracleQuery
    SQL.Strings = (
      'delete from T960_DOCUMENTI_INFO'
      'where  ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 88
    Top = 16
  end
  object delT961: TOracleQuery
    SQL.Strings = (
      'delete from T961_DOCUMENTI_FILE'
      'where  ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 144
    Top = 80
  end
  object updT960SetAccesso: TOracleQuery
    SQL.Strings = (
      'update T960_DOCUMENTI_INFO'
      'set    DATA_ACCESSO = :DATA_ACCESSO,'
      '       UTENTE_ACCESSO = :UTENTE_ACCESSO'
      'where  ID = :ID'
      'and    ((UTENTE is null) or (:UTENTE_ACCESSO <> UTENTE))')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000001E0000003A005500540045004E00540045005F0041004300
      43004500530053004F00050000000000000000000000060000003A0049004400
      0300000000000000000000001A0000003A0044004100540041005F0041004300
      43004500530053004F000C0000000000000000000000}
    Left = 49
    Top = 144
  end
  object updT960ResetAccesso: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :UTENTE_ACCESSO:=null;'
      '  :DATA_ACCESSO:=null;'
      '  begin  '
      '    select UTENTE_ACCESSO, DATA_ACCESSO'
      '    into   :UTENTE_ACCESSO, :DATA_ACCESSO'
      '    from   T960_DOCUMENTI_INFO T960'
      '    where  T960.ID = :ID;'
      '  exception'
      '    when NO_DATA_FOUND then'
      '      null;'
      '  end;'
      ''
      '  if :UTENTE_ACCESSO is not null then'
      '    update T960_DOCUMENTI_INFO'
      '    set    DATA_ACCESSO = null,'
      '           UTENTE_ACCESSO = null'
      '    where  ID = :ID;'
      '  end if;'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001E00
      00003A005500540045004E00540045005F004100430043004500530053004F00
      0500000000000000000000001A0000003A0044004100540041005F0041004300
      43004500530053004F000C0000000000000000000000}
    Left = 164
    Top = 144
  end
  object updT960SetLettura: TOracleQuery
    SQL.Strings = (
      'update T960_DOCUMENTI_INFO'
      'set    DATA_LETTURA_PROGRESSIVO = :DATA_LETTURA'
      'where  ID = :ID'
      'and    PROGRESSIVO = :PROGRESSIVO'
      'and    DATA_LETTURA_PROGRESSIVO is null')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001A00
      00003A0044004100540041005F004C004500540054005500520041000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 273
    Top = 144
  end
  object selT960MaxVersione: TOracleQuery
    SQL.Strings = (
      
        'SELECT NVL(MAX(VERSIONE), 0) AS MAX_VERSIONE FROM T960_DOCUMENTI' +
        '_INFO '
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND NOME_FILE = :NOME_FILE '
      'AND EXT_FILE = :EXT_FILE '
      'AND TIPOLOGIA = :TIPOLOGIA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00040000000000000000000000140000003A004E004F004D0045005F00
      460049004C004500050000000000000000000000120000003A00450058005400
      5F00460049004C004500050000000000000000000000140000003A0054004900
      50004F004C004F00470049004100050000000000000000000000}
    Left = 354
    Top = 80
  end
  object delT960Sovrascrivi: TOracleQuery
    SQL.Strings = (
      'delete from T960_DOCUMENTI_INFO'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    NOME_FILE = :NOME_FILE'
      'and    EXT_FILE = :EXT_FILE'
      'and    TIPOLOGIA = :TIPOLOGIA'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A004E004F004D0045005F00
      460049004C004500050000000000000000000000120000003A00450058005400
      5F00460049004C004500050000000000000000000000140000003A0054004900
      50004F004C004F00470049004100050000000000000000000000}
    Left = 352
    Top = 24
  end
  object selT960DocPresente: TOracleQuery
    SQL.Strings = (
      'SELECT '#39'x'#39' FROM T960_DOCUMENTI_INFO '
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND NOME_FILE = :NOME_FILE '
      'AND EXT_FILE = :EXT_FILE '
      'AND TIPOLOGIA = :TIPOLOGIA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00040000000000000000000000140000003A004E004F004D0045005F00
      460049004C004500050000000000000000000000120000003A00450058005400
      5F00460049004C004500050000000000000000000000140000003A0054004900
      50004F004C004F00470049004100050000000000000000000000}
    Left = 458
    Top = 24
  end
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select * from T962_TIPO_DOCUMENTI where CODICE = :CODICE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    AutoCalcFields = False
    CommitOnPost = False
    Left = 224
    Top = 16
  end
  object selScript: TOracleQuery
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0052004500530055004C005400050000000000
      000000000000180000003A00500052004F004700520045005300530049005600
      4F000400000000000000000000000A0000003A0044004100540041000C000000
      0000000000000000060000003A0049004400030000000000000000000000}
    Left = 224
    Top = 83
  end
end
