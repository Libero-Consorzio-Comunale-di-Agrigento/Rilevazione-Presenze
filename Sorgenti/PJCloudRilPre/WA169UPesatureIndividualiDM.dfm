inherited WA169FPesatureIndividualiDM: TWA169FPesatureIndividualiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t773.*, t773.rowid '
      'from t773_pesaturegruppo t773'
      ':ORDERBY')
    AfterPost = AfterPost
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
    end
    object selTabellaCODGRUPPO: TStringField
      DisplayLabel = 'Cod. gruppo'
      FieldName = 'CODGRUPPO'
      Required = True
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaFILTRO_ANAGRAFE: TStringField
      FieldName = 'FILTRO_ANAGRAFE'
      Visible = False
      Size = 4000
    end
    object selTabellaCODTIPOQUOTA: TStringField
      DisplayLabel = 'Cod. tipo quota'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selTabellaPESO_TOTALE: TFloatField
      DisplayLabel = 'Peso totale'
      FieldName = 'PESO_TOTALE'
    end
    object selTabellaPESO_IND_MIN: TFloatField
      DisplayLabel = 'Peso ind. min.'
      FieldName = 'PESO_IND_MIN'
    end
    object selTabellaPESO_IND_MAX: TFloatField
      DisplayLabel = 'Peso ind. max.'
      FieldName = 'PESO_IND_MAX'
    end
    object selTabellaQUOTA_TOTALE: TFloatField
      DisplayLabel = 'Quota totale'
      FieldName = 'QUOTA_TOTALE'
      DisplayFormat = '###,###,###,##0.00'
    end
    object selTabellaDATARIF: TDateTimeField
      DisplayLabel = 'Data rif.'
      DisplayWidth = 10
      FieldName = 'DATARIF'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaCHIUSO: TStringField
      DisplayLabel = 'Chiuso'
      FieldName = 'CHIUSO'
      Size = 1
    end
    object selTabellaDESCTIPOQUOTA: TStringField
      FieldKind = fkLookup
      FieldName = 'DESCTIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 40
      Lookup = True
    end
  end
end
