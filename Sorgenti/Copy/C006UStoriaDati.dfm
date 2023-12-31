object C006FStoriaDati: TC006FStoriaDati
  OldCreateOrder = True
  OnCreate = C006FStoriaDatiCreate
  OnDestroy = C006FStoriaDatiDestroy
  Height = 93
  Width = 234
  object Q430: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T430_STORICO'
      '  WHERE PROGRESSIVO = :Progressivo'
      
        '  AND (:DATA IS NULL OR DATADECORRENZA = :DATA OR DATAFINE = :DA' +
        'TA - 1)'
      '  ORDER BY DATADECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 9
    Top = 7
  end
  object QLookup: TOracleDataSet
    Optimize = False
    Left = 84
    Top = 6
  end
  object selP430Storico: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T430.INIZIO, T430.FINE, P430.*'
      'FROM T430_STORICO T430'
      '    ,P430_ANAGRAFICO P430'
      'WHERE P430.PROGRESSIVO = T430.PROGRESSIVO'
      
        'AND   P430.DECORRENZA <= T430.DATAFINE AND P430.DECORRENZA_FINE ' +
        '>= T430.DATADECORRENZA'
      'AND   T430.PROGRESSIVO = :PROGRESSIVO'
      
        'AND (:DATA IS NULL OR DECORRENZA = :DATA OR DECORRENZA_FINE = :D' +
        'ATA - 1)'
      'ORDER BY P430.DECORRENZA, T430.INIZIO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 144
    Top = 6
  end
end
