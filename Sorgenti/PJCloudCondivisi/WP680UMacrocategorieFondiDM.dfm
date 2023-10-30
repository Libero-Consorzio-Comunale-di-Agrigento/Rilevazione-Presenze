inherited WP680FMacrocategorieFondiDM: TWP680FMacrocategorieFondiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P680.*,P680.ROWID '
      'FROM P680_FONDIMACROCATEG P680 '
      ':ORDERBY')
    object selTabellaCOD_MACROCATEG: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_MACROCATEG'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
  end
end
