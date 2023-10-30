inherited WA085FPartTimeDM: TWA085FPartTimeDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T460.*,ROWID '
      'FROM   T460_PARTTIME T460 '
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 150
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo part-time'
      FieldName = 'TIPO'
    end
    object selTabellaDESCRIZIONE_ESTESA: TStringField
      DisplayLabel = 'Descrizione estesa'
      FieldName = 'DESCRIZIONE_ESTESA'
      Size = 250
    end
    object selTabellaPIANTA: TFloatField
      DisplayLabel = 'Pianta organica'
      FieldName = 'PIANTA'
      OnValidate = ValidaPercentuale
    end
    object selTabellaINDPRES: TFloatField
      DisplayLabel = 'Indennit'#224' presenza'
      FieldName = 'INDPRES'
      OnValidate = ValidaPercentuale
    end
    object selTabellaINDFEST: TFloatField
      DisplayLabel = 'Indennit'#224' festiva'
      FieldName = 'INDFEST'
      OnValidate = ValidaPercentuale
    end
    object selTabellaINCENTIVI: TFloatField
      DisplayLabel = 'Incentivi'
      FieldName = 'INCENTIVI'
      OnValidate = ValidaPercentuale
    end
    object selTabellaASSENZEGG: TFloatField
      DisplayLabel = 'Assenze GG'
      FieldName = 'ASSENZEGG'
      OnValidate = ValidaPercentuale
    end
    object selTabellaASSENZEHH: TFloatField
      DisplayLabel = 'Assenze Ore'
      FieldName = 'ASSENZEHH'
      OnValidate = ValidaPercentuale
    end
    object selTabellaHHGIORNALIERE: TFloatField
      DisplayLabel = 'Valorizzazione GG'
      FieldName = 'HHGIORNALIERE'
      OnValidate = ValidaPercentuale
    end
    object selTabellaDEBITO_AGG: TFloatField
      DisplayLabel = 'Debito agg.'
      FieldName = 'DEBITO_AGG'
      OnValidate = ValidaPercentuale
    end
  end
end
