inherited A097FPianifLibProfMW: TA097FPianifLibProfMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 153
  Width = 406
  object Q310: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T310_DESCLIBPROF'
      'ORDER BY CODICE')
    Optimize = False
    Left = 12
    Top = 12
  end
  object Q311: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T311_DETTLIBPROF'
      'WHERE CODICE = :CODICE'
      'ORDER BY GIORNO,DALLE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    ReadOnly = True
    Left = 76
    Top = 12
  end
  object selaT320: TOracleDataSet
    SQL.Strings = (
      'select * from '
      '  (select data, dalle, alle,'
      
        '          decode(greatest(oreminuti(alle) - oreminuti(dalle),0),' +
        '0,minutiore(oreminuti(alle) + oreminuti('#39'24.00'#39')),alle) alle_con' +
        'tinue'
      '  from t320_pianlibprofessione'
      '  where progressivo = :progressivo'
      '  :COND_ROWID)'
      'where (    :data = data'
      '       and oreminuti(:dalle) < oreminuti(alle_continue)'
      '       and oreminuti(:alle_continue) > oreminuti(dalle))'
      'or (    oreminuti(alle_continue) > oreminuti('#39'24.00'#39')'
      '    and data = :data - 1'
      '    and oreminuti(:dalle) < oreminuti(alle))'
      'or (    oreminuti(:alle_continue) > oreminuti('#39'24.00'#39')'
      '    and data = :data + 1'
      '    and oreminuti(:alle) > oreminuti(dalle))')
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      1C0000003A0041004C004C0045005F0043004F004E00540049004E0055004500
      050000000000000000000000160000003A0043004F004E0044005F0052004F00
      570049004400010000000000000000000000}
    Left = 128
    Top = 12
  end
  object Del320: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T320_PIANLIBPROFESSIONE'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DATA = :DATA'
      'AND DALLE = :DALLE'
      'AND ALLE = :ALLE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000}
    Left = 176
    Top = 12
  end
  object Ins320: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T320_PIANLIBPROFESSIONE'
      '(PROGRESSIVO,DATA,DALLE,ALLE,CAUSALE)'
      'VALUES'
      '(:PROGRESSIVO,:DATA,:DALLE,:ALLE,:CAUSALE)')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A0041004C004C004500050000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000}
    Left = 224
    Top = 12
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE'
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 80
    Top = 60
  end
  object selData: TOracleDataSet
    SQL.Strings = (
      'select to_date(upper(:DATA),'#39'DD-MON-YY'#39') DATA from dual')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00440041005400410005000000000000000000
      0000}
    Left = 8
    Top = 60
  end
  object insT315: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T315_IMPORT_LIBPROF '
      '  (PROGRESSIVO,DATA,DALLE,NOME,VALORE)'
      'VALUES'
      '  (:PROGRESSIVO,:DATA,:DALLE,:NOME,:VALORE)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      0000000000000A0000003A004E004F004D004500050000000000000000000000
      0E0000003A00560041004C004F0052004500050000000000000000000000}
    Left = 332
    Top = 12
  end
  object delT320Key: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T320_PIANLIBPROFESSIONE'
      'WHERE  PROGRESSIVO = :PROGRESSIVO'
      'AND    DATA = :DATA'
      'AND    DALLE = :DALLE'
      'AND    ALLE IS NULL')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A00440041004C004C004500050000000000
      000000000000}
    Left = 275
    Top = 12
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'select DATA,FESTIVO '
      'from V010_CALENDARI'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and   DATA between :DAL and :AL'
      'order by DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000080000003A00440041004C000C000000
      0000000000000000060000003A0041004C000C0000000000000000000000}
    Left = 128
    Top = 60
  end
end
