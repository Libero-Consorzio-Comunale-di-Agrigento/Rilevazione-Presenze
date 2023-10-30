inherited WA166FQuoteIndividualiDM: TWA166FQuoteIndividualiDM
  Height = 227
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T775.*,T775.rowid '
      'from T775_QUOTEINDIVIDUALI T775'
      'where PROGRESSIVO =:PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00080000000000000000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      DisplayWidth = 5
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaSCADENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'SCADENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCODTIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selTabellaD_TIPOQUOTA: TStringField
      DisplayLabel = 'Desc. tipo quota'
      FieldKind = fkLookup
      FieldName = 'D_TIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object selTabellaPENALIZZAZIONE: TFloatField
      DisplayLabel = 'Penalizzazione'
      DisplayWidth = 20
      FieldName = 'PENALIZZAZIONE'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaSALTAPROVA: TStringField
      DisplayLabel = 'Forza calcolo in prova'
      FieldName = 'SALTAPROVA'
      Visible = False
      Size = 1
    end
    object selTabellaIMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '###,###,###,##0.#####'
    end
    object selTabellaNUM_ORE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Numero ore'
      FieldName = 'NUM_ORE'
      Size = 6
    end
    object selTabellaPERC_INDIVIDUALE: TFloatField
      DisplayLabel = '% Valutaz. individuale'
      FieldName = 'PERC_INDIVIDUALE'
      Visible = False
    end
    object selTabellaPERC_STRUTTURALE: TFloatField
      DisplayLabel = '% Valutaz. strutturale'
      FieldName = 'PERC_STRUTTURALE'
      Visible = False
    end
    object selTabellaCONSIDERA_SALDO: TStringField
      DisplayLabel = 'Considera nel saldo'
      FieldName = 'CONSIDERA_SALDO'
      Visible = False
      Size = 1
    end
    object selTabellaPERCENTUALE: TFloatField
      DisplayLabel = '% Proporzionamento'
      FieldName = 'PERCENTUALE'
      Visible = False
    end
    object selTabellaSOSPENDI_PT: TStringField
      DisplayLabel = 'Sospendi PT'
      FieldName = 'SOSPENDI_PT'
      Visible = False
      Size = 1
    end
    object selTabellaSOSPENDI_QUOTE: TStringField
      DisplayLabel = 'Sospendi quote'
      FieldName = 'SOSPENDI_QUOTE'
      Visible = False
      Size = 1
    end
  end
end
