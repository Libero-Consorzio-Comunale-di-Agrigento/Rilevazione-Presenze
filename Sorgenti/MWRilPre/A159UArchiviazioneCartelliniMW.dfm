inherited A159FArchiviazioneCartelliniMW: TA159FArchiviazioneCartelliniMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 201
  Width = 318
  object D950: TDataSource
    DataSet = Q950Lista
    Left = 89
    Top = 11
  end
  object Q950Lista: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T950_STAMPACARTELLINO '
      'ORDER BY CODICE')
    Optimize = False
    Filtered = True
    Left = 24
    Top = 11
  end
  object selT025: TOracleDataSet
    SQL.Strings = (
      'select T025.PAR_CARTELLINO'
      '  from T025_CONTMENSILI T025, T430_STORICO T430'
      ' where T430.PERSELASTICO = T025.CODICE '
      '   and T430.PROGRESSIVO = :PROGRESSIVO '
      
        '   and :DATA_CARTELLINO between T430.DATADECORRENZA and T430.DAT' +
        'AFINE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000200000003A0044004100540041005F00
      430041005200540045004C004C0049004E004F000C0000000000000000000000}
    Left = 24
    Top = 72
  end
  object selI210: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM   I210_REGOLE_ARCHIVIAZIONE'
      'WHERE  TIPO_DOCUMENTO = '#39'CAR'#39)
    Optimize = False
    Left = 88
    Top = 72
  end
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select * from T962_TIPO_DOCUMENTI where CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 152
    Top = 12
  end
  object selT960Registro: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T960.*, T961.DOCUMENTO FROM T960_DOCUMENTI_INFO T960, T96' +
        '1_DOCUMENTI_FILE T961'
      'WHERE T960.ID = T961.ID'
      'AND T960.PROGRESSIVO IS NULL'
      'AND T960.TIPOLOGIA = :TIPOLOGIA'
      'ORDER BY T960.DATA_CREAZIONE DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Left = 32
    Top = 136
  end
  object dsrT960Registro: TDataSource
    DataSet = selT960Registro
    Left = 120
    Top = 136
  end
  object selScript: TOracleQuery
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000E0000003A0052004500530055004C00540005000000
      0000000000000000060000003A0049004400030000000000000000000000}
    Left = 152
    Top = 72
  end
  object selVT860: TOracleQuery
    SQL.Strings = (
      'declare'
      'begin'
      '  select count(*) into :RESULT from VT860_ITER_STAMPACARTELLINI'
      '  where PROGRESSIVO = :PROGRESSIVO'
      '  and T860MESE_CARTELLINO = :DATA'
      '  and T850STATO is not null;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000E0000003A0052004500530055004C00540003000000
      0000000000000000}
    Left = 224
    Top = 11
  end
end
