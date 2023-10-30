inherited B021FTimbratureConteggiateDM: TB021FTimbratureConteggiateDM
  OldCreateOrder = True
  Height = 78
  Width = 177
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select distinct T030.MATRICOLA, T430.PROGRESSIVO, T430.BADGE'
      'from   T030_ANAGRAFICO T030, '
      '       T430_STORICO T430'
      'where  T030.PROGRESSIVO = T430.PROGRESSIVO'
      'and    :INIZIO <= T430.DATAFINE and :FINE >= T430.DATADECORRENZA'
      
        'and    :INIZIO <= nvl(T430.FINE,:FINE + 1) and :FINE >= T430.INI' +
        'ZIO'
      'and    T430.ATTIVO_TURNI = '#39'S'#39
      ':FILTRO_ANAG')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00460049004C00540052004F005F0041004E00
      410047000100000000000000000000000E0000003A0049004E0049005A004900
      4F000C00000000000000000000000A0000003A00460049004E0045000C000000
      0000000000000000}
    Left = 112
    Top = 16
  end
end
