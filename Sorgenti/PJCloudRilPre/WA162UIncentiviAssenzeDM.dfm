inherited WA162FIncentiviAssenzeDM: TWA162FIncentiviAssenzeDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T769.*, t769.rowid'
      'from t769_incentiviassenze t769'
      ':ORDERBY'
      '')
    BeforePost = BeforePost
    object selTabellaDATO1: TStringField
      DisplayLabel = 'Dato1'
      DisplayWidth = 10
      FieldName = 'DATO1'
      Required = True
    end
    object selTabellaD_DATO1: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 40
      Lookup = True
    end
    object selTabellaDATO2: TStringField
      DisplayLabel = 'Dato2'
      DisplayWidth = 10
      FieldName = 'DATO2'
      Required = True
    end
    object selTabellaD_DATO2: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO2'
      Size = 40
      Lookup = True
    end
    object selTabellaDATO3: TStringField
      DisplayLabel = 'Dato3'
      DisplayWidth = 10
      FieldName = 'DATO3'
      Required = True
    end
    object selTabellaD_DATO3: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO3'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO3'
      Size = 40
      Lookup = True
    end
    object selTabellaCODTIPOQUOTA: TStringField
      DisplayLabel = 'Cod. quota'
      FieldName = 'CODTIPOQUOTA'
      Size = 5
    end
    object selTabellaD_TIPOQUOTA: TStringField
      DisplayLabel = 'Desc. quota'
      FieldKind = fkLookup
      FieldName = 'D_TIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 40
      Lookup = True
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selTabellaD_CAUSALE: TStringField
      DisplayLabel = 'Desc. causale'
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 100
      Lookup = True
    end
    object selTabellaCOD_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Tipo accorp.'
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selTabellaD_TIPOACCORP: TStringField
      DisplayLabel = 'Desc. Tipo accorp.'
      FieldKind = fkLookup
      FieldName = 'D_TIPOACCORP'
      LookupKeyFields = 'COD_TIPOACCORPCAUSALI'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_TIPOACCORPCAUSALI'
      Size = 100
      Lookup = True
    end
    object selTabellaCOD_CODICIACCORPCAUSALI: TStringField
      DisplayLabel = 'Codice accorp.'
      FieldName = 'COD_CODICIACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selTabellaD_CODICIACCORPCAUSALI: TStringField
      DisplayLabel = 'Desc. codice accorp.'
      FieldKind = fkLookup
      FieldName = 'D_CODICIACCORPCAUSALI'
      LookupKeyFields = 'COD_CODICIACCORPCAUSALI'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_CODICIACCORPCAUSALI'
      Size = 200
      Lookup = True
    end
    object selTabellaTIPO_ABBATTIMENTO: TStringField
      FieldName = 'TIPO_ABBATTIMENTO'
      Visible = False
      Size = 5
    end
    object selTabellaD_TIPOABBAT: TStringField
      FieldKind = fkLookup
      FieldName = 'D_TIPOABBAT'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO_ABBATTIMENTO'
      Visible = False
      Size = 100
      Lookup = True
    end
    object selTabellaD_RISPARMIO: TStringField
      FieldKind = fkLookup
      FieldName = 'D_RISPARMIO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'RISPARMIO_BILANCIO'
      KeyFields = 'TIPO_ABBATTIMENTO'
      Visible = False
      Size = 1
      Lookup = True
    end
    object selTabellaGESTIONE_FRANCHIGIA: TStringField
      FieldName = 'GESTIONE_FRANCHIGIA'
      Visible = False
      Size = 1
    end
    object selTabellaFRANCHIGIA_ASSENZE: TIntegerField
      DisplayLabel = 'Franchigia'
      FieldName = 'FRANCHIGIA_ASSENZE'
    end
    object selTabellaCONTA_FRUITO_ORE: TStringField
      FieldName = 'CONTA_FRUITO_ORE'
      Visible = False
      Size = 1
    end
    object selTabellaFORZA_ABB_GGINT: TStringField
      FieldName = 'FORZA_ABB_GGINT'
      Visible = False
      Size = 1
    end
    object selTabellaPERC_ABB_FRANCHIGIA: TFloatField
      DisplayLabel = '% abb. franch.'
      FieldName = 'PERC_ABB_FRANCHIGIA'
      Required = True
    end
    object selTabellaPERC_ABBATTIMENTO: TFloatField
      DisplayLabel = '% abb. supero franch.'
      FieldName = 'PERC_ABBATTIMENTO'
      Required = True
    end
    object selTabellaASSENZE_AGGIUNTIVE: TStringField
      FieldName = 'ASSENZE_AGGIUNTIVE'
      Visible = False
      Size = 100
    end
    object selTabellaPROPORZIONE_FRANCHIGIA: TStringField
      FieldName = 'PROPORZIONE_FRANCHIGIA'
      Visible = False
      Size = 1
    end
    object selTabellaCONTA_SOLO_GGINT: TStringField
      FieldName = 'CONTA_SOLO_GGINT'
      Visible = False
      Size = 1
    end
  end
end
