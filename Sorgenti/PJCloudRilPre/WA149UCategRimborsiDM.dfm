inherited WA149FCategRimborsiDM: TWA149FCategRimborsiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select M022.CODICE, M022.DESCRIZIONE, M022.ROWID'
      '  from M022_CATEG_RIMBORSI M022'
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
  end
end
