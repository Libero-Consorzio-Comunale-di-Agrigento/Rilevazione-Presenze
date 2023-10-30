inherited WA066FValutaStrDM: TWA066FValutaStrDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T730.*,T730.ROWID '
      'from   T730_VALUTAORE T730 '
      ':ORDERBY')
    object selTabellaLIVELLO: TStringField
      DisplayLabel = 'Livello'
      FieldName = 'LIVELLO'
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza Fine'
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaMAGGIORAZIONE: TFloatField
      DisplayLabel = 'Maggiorazione'
      FieldName = 'MAGGIORAZIONE'
    end
    object selTabellaTARIFFA_LIQ: TFloatField
      DisplayLabel = 'Tariffa Liquidazione'
      FieldName = 'TARIFFA_LIQ'
    end
    object selTabellaTARIFFA_MAT: TFloatField
      DisplayLabel = 'Tariffa Maturazione'
      FieldName = 'TARIFFA_MAT'
    end
  end
end
