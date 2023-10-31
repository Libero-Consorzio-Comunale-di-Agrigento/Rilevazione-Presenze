inherited A175FRegoleOrologiMW: TA175FRegoleOrologiMW
  OldCreateOrder = True
  Height = 72
  Width = 175
  object selT361: TOracleDataSet
    SQL.Strings = (
      'select CODICE '
      'from T361_OROLOGI T361'
      'order by CODICE')
    Optimize = False
    Left = 16
    Top = 8
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE '
      'from T275_CAUPRESENZE T275'
      'order by CODICE'
      '')
    Optimize = False
    Left = 72
    Top = 8
  end
  object insT363: TOracleQuery
    SQL.Strings = (
      
        'insert into T363_REGOLE_GG T363A(ID,GG,DALLE,ALLE,CAUSALI_ABILIT' +
        'ATE)'
      '  select'
      '    :NUOVO,'
      '    T363B.GG,'
      '    T363B.DALLE,'
      '    T363B.ALLE,'
      '    T363B.CAUSALI_ABILITATE'
      '  from T363_REGOLE_GG T363B'
      '  where ID = :VECCHIO')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A004E0055004F0056004F000400000000000000
      00000000100000003A005600450043004300480049004F000400000000000000
      00000000}
    Left = 124
    Top = 8
  end
end
