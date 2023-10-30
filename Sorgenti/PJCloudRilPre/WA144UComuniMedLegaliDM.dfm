inherited WA144FComuniMedLegaliDM: TWA144FComuniMedLegaliDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select T486.*,T486.ROWID,T480.CITTA,T485.DESCRIZIONE DESC_MED_LE' +
        'GALE'
      
        'from   T486_COMUNI_MEDLEGALI T486, T480_COMUNI T480, T485_MEDICI' +
        'NELEGALI T485'
      'where  T486.COD_COMUNE = T480.CODICE'
      'and    T486.MED_LEGALE = T485.CODICE'
      ':ORDERBY')
    UpdatingTable = 'T486_COMUNI_MEDLEGALI'
    object selTabellaMED_LEGALE: TStringField
      DisplayLabel = 'Cod.Med.legale'
      FieldName = 'MED_LEGALE'
      Visible = False
      Size = 10
    end
    object selTabellaD_MED_LEGALE: TStringField
      DisplayLabel = 'Medicina legale'
      FieldKind = fkLookup
      FieldName = 'D_MED_LEGALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'MED_LEGALE'
      ReadOnly = True
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaDESC_MED_LEGALE: TStringField
      DisplayLabel = 'Medicina legale'
      FieldName = 'DESC_MED_LEGALE'
      ReadOnly = True
      Size = 60
    end
    object selTabellaCOD_COMUNE: TStringField
      DisplayLabel = 'Cod.Comune'
      FieldName = 'COD_COMUNE'
      Visible = False
      Size = 6
    end
    object selTabellaD_COMUNE: TStringField
      DisplayLabel = 'Comune'
      FieldKind = fkLookup
      FieldName = 'D_COMUNE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE'
      ReadOnly = True
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaCITTA: TStringField
      DisplayLabel = 'Comune'
      FieldName = 'CITTA'
      ReadOnly = True
      Size = 60
    end
  end
end
