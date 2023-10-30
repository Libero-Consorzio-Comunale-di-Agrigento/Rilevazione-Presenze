inherited S746FStatiAvanzamentoMW: TS746FStatiAvanzamentoMW
  OldCreateOrder = True
  Height = 303
  Width = 495
  object selSG741: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from sg741_regole_valutazioni'
      'where :data between decorrenza and decorrenza_fine'
      'order by codice')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    Left = 88
    Top = 16
  end
  object dSG741: TDataSource
    DataSet = selSG741
    Left = 88
    Top = 64
  end
  object selSG746: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione'
      'from sg746_stati_avanzamento'
      'where :data between decorrenza and decorrenza_fine'
      'and codregola = :codregola'
      'and codice < :codice'
      'union'
      'select :codice, :descrizione'
      'from dual'
      'where :codice > 0'
      'order by codice, descrizione')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000140000003A0043004F0044005200450047004F004C004100050000000000
      0000000000000E0000003A0043004F0044004900430045000300000000000000
      00000000180000003A004400450053004300520049005A0049004F004E004500
      050000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 144
    Top = 16
  end
  object dSG746: TDataSource
    DataSet = selSG746
    Left = 144
    Top = 64
  end
  object selSG746b: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE'
      'FROM SG746_STATI_AVANZAMENTO'
      'WHERE CODREGOLA = :CODREGOLA'
      'AND :DATARIF BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'AND CODICE = :CODICE'
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F0044005200450047004F004C004100
      0500000000000000000000000E0000003A0043004F0044004900430045000300
      00000000000000000000100000003A0044004100540041005200490046000C00
      00000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 256
    Top = 16
  end
  object selSG746a: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, MIN(DECORRENZA), MAX(DECORRENZA_FINE)'
      'FROM SG746_STATI_AVANZAMENTO'
      'WHERE CODREGOLA = :CODREGOLA'
      'AND DECORRENZA <= :DECORRENZA'
      'AND DECORRENZA_FINE >= :DECORRENZA_FINE'
      'AND CODICE = :CODICE'
      'GROUP BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0043004F0044005200450047004F004C004100
      0500000000000000000000000E0000003A0043004F0044004900430045000300
      00000000000000000000160000003A004400450043004F005200520045004E00
      5A0041000C0000000000000000000000200000003A004400450043004F005200
      520045004E005A0041005F00460049004E0045000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 200
    Top = 16
  end
  object selSG746c: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, MIN(DECORRENZA), MAX(DECORRENZA_FINE)'
      'FROM SG746_STATI_AVANZAMENTO'
      'WHERE CODREGOLA = :CODREGOLA'
      'AND DECORRENZA <= :DECORRENZA_FINE'
      'AND DECORRENZA_FINE >= :DECORRENZA'
      'AND CODICE = :CODICE'
      'GROUP BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0043004F0044005200450047004F004C004100
      0500000000000000000000000E0000003A0043004F0044004900430045000300
      00000000000000000000200000003A004400450043004F005200520045004E00
      5A0041005F00460049004E0045000C0000000000000000000000160000003A00
      4400450043004F005200520045004E005A0041000C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 312
    Top = 16
  end
end
