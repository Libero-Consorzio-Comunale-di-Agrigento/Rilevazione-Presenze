inherited WP050FCodArrotondamentiDM: TWP050FCodArrotondamentiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P050.*, P050.ROWID FROM P050_KARROTONDAMENTI P050 '
      ' :ORDERBY')
    object selTabellaCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod. arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
  end
end
