inherited WA133FTariffeMissioniDM: TWA133FTariffeMissioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select M065.*,M065.rowid '
      'from M065_TARIFFE_INDENNITA M065'
      ':ORDERBY')
    BeforeInsert = BeforeInsert
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 80
    end
    object selTabelladesc_trasferta: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'desc_trasferta'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 40
      Lookup = True
    end
    object selTabellaCOD_TARIFFA: TStringField
      DisplayLabel = 'Cod. tariffa'
      FieldName = 'COD_TARIFFA'
      Size = 10
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Desc.tariffa'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaIND_GIORNALIERA: TFloatField
      DisplayLabel = 'Indennit'#224' giorn.'
      FieldName = 'IND_GIORNALIERA'
    end
    object selTabellaVOCEPAGHE_ESENTE: TStringField
      DisplayLabel = 'Voce paghe esente tassazione'
      FieldName = 'VOCEPAGHE_ESENTE'
      Size = 6
    end
    object selTabellaVOCEPAGHE_ASSOG: TStringField
      DisplayLabel = 'Voce paghe soggetto a tassazione'
      FieldName = 'VOCEPAGHE_ASSOG'
      Size = 6
    end
  end
end
