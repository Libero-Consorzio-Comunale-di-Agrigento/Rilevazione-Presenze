inherited WA027FCarMenDM: TWA027FCarMenDM
  OldCreateOrder = True
  object Q950Lista: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T950_STAMPACARTELLINO '
      'ORDER BY CODICE')
    ReadBuffer = 5
    Optimize = False
    Filtered = True
    Left = 66
    Top = 24
  end
  object dsrQ950Lista: TDataSource
    DataSet = Q950Lista
    Left = 136
    Top = 24
  end
end
