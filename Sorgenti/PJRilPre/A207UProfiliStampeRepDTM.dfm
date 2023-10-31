inherited A207FProfiliStampeRepDTM: TA207FProfiliStampeRepDTM
  OldCreateOrder = True
  object selT355: TOracleDataSet
    SQL.Strings = (
      'select T355.*, T355.rowid'
      '  from T355_STAMPE_REPERIB T355'
      ' order by T355.CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    Left = 34
    Top = 16
  end
end
