inherited A208FAcquisizioneInfoEsterneMW: TA208FAcquisizioneInfoEsterneMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 156
  Width = 339
  object delT036: TOracleQuery
    SQL.Strings = (
      'delete T036_ANAGRAFICO_EXTINFO'
      'where TIPO = :Tipo and DATO = :Dato')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A005400490050004F0005000000000000000000
      00000A0000003A004400410054004F00050000000000000000000000}
    Left = 18
    Top = 13
  end
  object insT036: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO T036_ANAGRAFICO_EXTINFO(ID, PROGRESSIVO, TIPO, DATO,' +
        ' VALORE)'
      
        'SELECT T036_ID.NEXTVAL, :Progressivo, :Tipo, :Dato, :Valore FROM' +
        ' DUAL')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A005400490050004F000500
      000000000000000000000A0000003A004400410054004F000500000000000000
      000000000E0000003A00560041004C004F005200450005000000000000000000
      0000}
    Left = 75
    Top = 13
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'SELECT PROGRESSIVO FROM T030_ANAGRAFICO'
      'WHERE CODFISCALE = :CodFiscale'
      'ORDER BY PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F004400460049005300430041004C00
      4500050000000000000000000000}
    Left = 134
    Top = 13
  end
  object selT036Count: TOracleQuery
    SQL.Strings = (
      
        'select count(*) from T036_ANAGRAFICO_EXTINFO T036 where TIPO = :' +
        'Tipo and DATO = :Dato')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A005400490050004F0005000000000000000000
      00000A0000003A004400410054004F00050000000000000000000000}
    Left = 200
    Top = 13
  end
end
