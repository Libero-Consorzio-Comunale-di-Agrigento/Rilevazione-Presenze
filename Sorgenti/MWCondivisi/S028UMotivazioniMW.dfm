inherited S028FmotivazioniMW: TS028FmotivazioniMW
  OldCreateOrder = True
  object selP660: TOracleDataSet
    SQL.Strings = (
      'select distinct numero, descrizione '
      '  from P660_flussiregole p660'
      ' where nome_flusso = '#39'NPA'#39
      ' order by numero')
    Optimize = False
    Left = 32
    Top = 16
  end
end
