inherited A158FCapitoliRimborsoMW: TA158FCapitoliRimborsoMW
  OldCreateOrder = True
  Height = 177
  Width = 177
  object selM030: TOracleDataSet
    SQL.Strings = (
      
        'select M030.CODICE, M030.DESCRIZIONE, M030.DECORRENZA, M030.DECO' +
        'RRENZA_FINE'
      '  from M030_CAPITOLI_TRASFERTA M030'
      ' order by M030.CODICE, M030.DECORRENZA')
    Optimize = False
    OnFilterRecord = selM030FilterRecord
    Left = 48
    Top = 16
  end
  object selM022: TOracleDataSet
    SQL.Strings = (
      'select M022.CODICE, M022.DESCRIZIONE'
      '  from M022_CATEG_RIMBORSI M022'
      ' order by M022.CODICE')
    Optimize = False
    Left = 48
    Top = 80
  end
end
