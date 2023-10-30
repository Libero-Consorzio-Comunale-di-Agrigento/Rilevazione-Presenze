inherited WA164FQuoteIncentiviDM: TWA164FQuoteIncentiviDM
  Height = 318
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t770.*, T770.ROWID'
      ' from T770_QUOTE T770'
      ':ORDERBY')
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
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
      Size = 100
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
      Size = 100
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
      Size = 100
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
    object selTabellaCODTIPOQUOTA: TStringField
      DisplayLabel = 'Quota'
      DisplayWidth = 10
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selTabellaD_TIPOQUOTA: TStringField
      DisplayLabel = 'Desc. quota'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_TIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Assenza'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selTabellaD_CAUSALE: TStringField
      DisplayLabel = 'Desc. assenza'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 50
      Lookup = True
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object selTabellaNUM_ORE: TStringField
      DisplayLabel = 'Num.Ore'
      FieldName = 'NUM_ORE'
      Size = 6
    end
    object selTabellaPERC_INDIVIDUALE: TFloatField
      DisplayLabel = '% Individuale'
      FieldName = 'PERC_INDIVIDUALE'
      Visible = False
    end
    object selTabellaPERC_STRUTTURALE: TFloatField
      DisplayLabel = '% Strutturale'
      FieldName = 'PERC_STRUTTURALE'
      Visible = False
    end
    object selTabellaPERCENTUALE: TFloatField
      DisplayLabel = '% Prop.'
      DisplayWidth = 5
      FieldName = 'PERCENTUALE'
      Visible = False
    end
    object selTabellaCONSIDERA_SALDO: TStringField
      FieldName = 'CONSIDERA_SALDO'
      Visible = False
      Size = 1
    end
    object selTabellaSOSPENDI_PT: TStringField
      FieldName = 'SOSPENDI_PT'
      Visible = False
      Size = 1
    end
    object selTabellaPENALIZZAZIONE: TFloatField
      FieldName = 'PENALIZZAZIONE'
      Visible = False
    end
    object selTabellaVALUT_STRUTTURALE: TFloatField
      FieldName = 'VALUT_STRUTTURALE'
      Visible = False
    end
    object selTabellaTIPO_STAMPAQUANT: TStringField
      FieldName = 'TIPO_STAMPAQUANT'
      Visible = False
      Size = 1
    end
    object selTabellaTOTNETTO: TFloatField
      DisplayLabel = 'Tot. netto'
      FieldKind = fkCalculated
      FieldName = 'TOTNETTO'
      DisplayFormat = '###,###,###,##0.#####'
      Calculated = True
    end
    object selTabellaCONSIDERA_PROVA: TStringField
      DisplayLabel = 'Considera periodo di prova'
      FieldName = 'CONSIDERA_PROVA'
      Visible = False
      Size = 1
    end
    object selTabellaTIPIRAPPORTO_SOSPENSIONE: TStringField
      DisplayLabel = 'Tipi rapporto per sospensione'
      FieldName = 'TIPIRAPPORTO_SOSPENSIONE'
      Visible = False
      Size = 500
    end
    object selTabellaDURATA_SOSPENSIONE: TFloatField
      DisplayLabel = 'Durata sospensione'
      FieldName = 'DURATA_SOSPENSIONE'
      Visible = False
    end
    object selTabellaESCLUSIONE_VALORI: TStringField
      DisplayLabel = 'Valori esclusione inc.'
      FieldName = 'ESCLUSIONE_VALORI'
      Visible = False
      Size = 500
    end
  end
end
