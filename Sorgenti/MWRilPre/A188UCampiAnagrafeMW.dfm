inherited A188FCampiAnagrafeMW: TA188FCampiAnagrafeMW
  OldCreateOrder = True
  Height = 86
  Width = 243
  object selColsDefs: TOracleDataSet
    SQL.Strings = (
      'SELECT TABLE_NAME,COLUMN_NAME,DATA_DEFAULT FROM COLS'
      
        'WHERE TABLE_NAME IN ('#39'T030_ANAGRAFICO'#39','#39'T430_STORICO'#39','#39'P430_ANAG' +
        'RAFICO'#39')'
      
        'AND (TABLE_NAME,COLUMN_NAME) NOT IN (select '#39'T030_ANAGRAFICO'#39','#39'R' +
        'APPORTI_UNITI'#39' from dual)'
      'AND DATA_DEFAULT is not null'
      '--AND LOWER(DATA_DEFAULT) <> '#39'null'#39)
    ReadBuffer = 100
    Optimize = False
    Left = 120
    Top = 12
  end
  object selColsT030V430: TOracleDataSet
    SQL.Strings = (
      'SELECT TABLE_NAME,COLUMN_NAME FROM COLS'
      'WHERE TABLE_NAME IN ('#39'T030_ANAGRAFICO'#39','#39'V430_STORICO'#39')'
      'AND COLUMN_NAME <> '#39'RAPPORTI_UNITI'#39
      
        'OR (TABLE_NAME = '#39'T480_COMUNI'#39' AND COLUMN_NAME IN ('#39'CITTA'#39','#39'PROV' +
        'INCIA'#39'))'
      'ORDER BY 1,2')
    ReadBuffer = 100
    Optimize = False
    Left = 40
    Top = 12
  end
end
