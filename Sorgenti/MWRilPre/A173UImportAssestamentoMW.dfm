inherited A173FImportAssestamentoMW: TA173FImportAssestamentoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 120
  Width = 533
  object selT030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.PROGRESSIVO FROM T030_ANAGRAFICO T030 WHERE T030.MAT' +
        'RICOLA = :MATRICOLA')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    Left = 24
    Top = 64
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      'select codice from t305_caugiustif where codice = :CAUSALE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00430041005500530041004C00450005000000
      0000000000000000}
    Left = 120
    Top = 64
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      'select t070.*, t070.rowid '
      'from t070_schedariepil t070'
      'where progressivo = :PROG'
      '  and data = :DATA')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 24
    Top = 8
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      'select t071.*, t071.rowid '
      'from t071_schedafasce t071'
      'where progressivo = :PROG'
      '  and data = :DATA'
      'order by MAGGIORAZIONE,CODFASCIA  '
      ''
      '/*select t071.*, t071.rowid '
      'from t071_schedafasce t071'
      'where progressivo = :PROG'
      '  and data = :DATA'
      '  and maggiorazione = '
      
        '      (select min(maggiorazione) from  t071_schedafasce where pr' +
        'ogressivo = :PROG and data = :DATA) '
      '  and rownum = 1*/')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 72
    Top = 8
  end
  object updT071: TOracleQuery
    SQL.Strings = (
      'UPDATE T071_SCHEDAFASCE '
      'SET LIQUIDNELMESE = MINUTIORE(:LIQUIDNELMESE)'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA AND'
      'CODFASCIA = :CODFASCIA')
    Optimize = False
    Variables.Data = {
      04000000040000001C0000003A004C00490051005500490044004E0045004C00
      4D00450053004500030000000000000000000000180000003A00500052004F00
      47005200450053005300490056004F000300000000000000000000000A000000
      3A0044004100540041000C0000000000000000000000140000003A0043004F00
      4400460041005300430049004100050000000000000000000000}
    Left = 122
    Top = 8
  end
  object selT030a: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.MATRICOLA, T430.INIZIO, T430.FINE'
      'FROM T030_ANAGRAFICO T030, '
      '     T430_STORICO T430'
      'WHERE T030.CODFISCALE = :CODFISCALE'
      'AND T430.PROGRESSIVO = T030.PROGRESSIVO'
      'AND :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE'
      'AND (   :CESSATI = '#39'S'#39' '
      
        '     OR :DATA BETWEEN TRUNC(T430.INIZIO,'#39'MM'#39') AND LAST_DAY(NVL(T' +
        '430.FINE,:DATA)))'
      'ORDER BY T430.INIZIO')
    Optimize = False
    Variables.Data = {
      0400000003000000160000003A0043004F004400460049005300430041004C00
      45000500000000000000000000000A0000003A0044004100540041000C000000
      0000000000000000100000003A00430045005300530041005400490005000000
      0000000000000000}
    Left = 72
    Top = 64
  end
end
