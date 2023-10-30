inherited WS720FProfiliAreeDM: TWS720FProfiliAreeDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select SG720.*, SG720.ROWID'
      'from   SG720_PROFILI_AREE SG720'
      ':ORDERBY'
      '--order by DATO1, DATO2, DATO3, DATO4, COD_AREA, DECORRENZA')
    BeforePost = BeforePost
    OnNewRecord = OnNewRecord
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDATO1: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 50
      FieldName = 'DATO1'
      Size = 50
    end
    object selTabellaDESC_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'DESC_DATO1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 100
      Lookup = True
    end
    object selTabellaDATO2: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO2'
      Size = 50
    end
    object selTabellaDESC_DATO2: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO2'
      Size = 100
      Lookup = True
    end
    object selTabellaDATO3: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO3'
      Size = 50
    end
    object selTabellaDESC_DATO3: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_DATO3'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO3'
      Size = 100
      Lookup = True
    end
    object selTabellaDATO4: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO4'
      Size = 50
    end
    object selTabellaDESC_DATO4: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO4'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO4'
      Size = 100
      Lookup = True
    end
    object selTabellaCOD_AREA: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'COD_AREA'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Area'
      DisplayWidth = 35
      FieldKind = fkLookup
      FieldName = 'DESCRIZIONE'
      LookupKeyFields = 'COD_AREA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_AREA'
      Size = 100
      Lookup = True
    end
  end
end
