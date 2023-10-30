inherited WP682FRaggruppamentiFondiDM: TWP682FRaggruppamentiFondiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P682.*,P682.ROWID '
      'FROM P682_FONDIRAGGR P682 '
      ':ORDERBY')
    object selTabellaCOD_RAGGR: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 15
      FieldName = 'COD_RAGGR'
      Required = True
      Size = 15
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
  end
end
