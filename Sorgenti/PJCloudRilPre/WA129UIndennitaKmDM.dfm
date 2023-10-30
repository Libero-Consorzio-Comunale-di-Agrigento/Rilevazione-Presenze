inherited WA129FIndennitaKmDM: TWA129FIndennitaKmDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select m021.*, m021.rowid '
      'from m021_tipiindennitakm m021'
      ':ORDERBY')
    BeforePost = BeforePost
    OnCalcFields = selTabellaCalcFields
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object selTabellaCODVOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'CODVOCEPAGHE'
      Size = 6
    end
    object selTabellaARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrotondamento'
      FieldName = 'ARROTONDAMENTO'
      Size = 5
    end
    object selTabelladescarrotondamento: TStringField
      DisplayLabel = 'Desc.arrotondamento'
      FieldKind = fkLookup
      FieldName = 'descarrotondamento'
      LookupKeyFields = 'COD_ARROTONDAMENTO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ARROTONDAMENTO'
      Size = 40
      Lookup = True
    end
    object selTabellaCATEG_RIMBORSO: TStringField
      FieldName = 'CATEG_RIMBORSO'
      Size = 10
    end
  end
end
