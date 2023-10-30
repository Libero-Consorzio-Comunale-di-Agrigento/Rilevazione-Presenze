inherited WP030FValuteDM: TWP030FValuteDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P030.*,P030.ROWID FROM P030_VALUTE P030'
      ':ORDERBY')
    object selTabellaCOD_VALUTA: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
    end
    object selTabellaABBREVIAZIONE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Abbreviazione'
      FieldName = 'ABBREVIAZIONE'
      Size = 3
    end
    object selTabellaNUM_DEC_IMP_VOCE: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Nr. dec. min. imp. voce'
      FieldName = 'NUM_DEC_IMP_VOCE'
    end
    object selTabellaNUM_DEC_IMP_UNIT: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Nr. dec. min. imp. unitario'
      FieldName = 'NUM_DEC_IMP_UNIT'
    end
  end
end
