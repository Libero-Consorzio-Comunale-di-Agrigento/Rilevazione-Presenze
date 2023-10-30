inherited WA082FCdcPercentDM: TWA082FCdcPercentDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T433.*,T433.ROWID '
      'FROM T433_CDC_PERCENT T433'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    AfterScroll = nil
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaD_CODICE: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'D_CODICE'
      Size = 100
      Calculated = True
    end
    object selTabellaPERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale (%)'
      FieldName = 'PERCENTUALE'
    end
  end
  object selT433Count: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUM '
      'FROM T433_CDC_PERCENT T433'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DECORRENZA <=:DATALAVORO'
      'AND DECORRENZA_FINE >=:DATALAVORO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F00BB0000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 104
    Top = 128
  end
end
