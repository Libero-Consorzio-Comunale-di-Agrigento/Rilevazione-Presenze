inherited A163FTipoQuoteMW: TA163FTipoQuoteMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 414
  Width = 665
  object selT305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      ' FROM T305_CAUGIUSTIF'
      'ORDER BY CODICE')
    Optimize = False
    Left = 136
    Top = 24
  end
  object dsrT305: TDataSource
    DataSet = selT305
    Left = 136
    Top = 80
  end
  object selT765Acc: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione '
      'from t765_tipoquote t765'
      'where tipoquota IN (:TIPOQUOTA)'
      'and decorrenza = (select max(decorrenza) from t765_tipoquote'
      '                   where codice = t765.codice'
      '                     and decorrenza <= :DATA) '
      'order by codice')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000140000003A005400490050004F00510055004F0054004100010000000000
      000000000000}
    Left = 256
    Top = 24
  end
  object selT762: TOracleQuery
    SQL.Strings = (
      'select count(*) from T762_incentivimaturati'
      'where codtipoquota = :QUOTA')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A00510055004F00540041000500000000000000
      00000000}
    Left = 256
    Top = 80
  end
  object selT765Penalizz: TOracleQuery
    SQL.Strings = (
      'select COUNT(*) from T765_TIPOQUOTE'
      'where tipoquota = '#39'P'#39)
    Optimize = False
    Left = 256
    Top = 128
  end
  object selT765b: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE'
      'FROM T765_TIPOQUOTE'
      'WHERE TIPOQUOTA = '#39'I'#39
      'AND CODICE <> :CODICE'
      'AND INSTR('#39','#39'||ACCONTI||'#39','#39','#39','#39'||:ACCONTO||'#39','#39') > 0')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A004100430043004F004E0054004F00050000000000
      000000000000}
    Left = 360
    Top = 24
  end
end
