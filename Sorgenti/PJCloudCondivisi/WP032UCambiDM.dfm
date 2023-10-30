inherited WP032FCambiDM: TWP032FCambiDM
  Height = 147
  Width = 337
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P032.*, ROWID FROM P032_CAMBI P032'
      ' :ORDERBY')
    BeforePost = BeforePost
    OnCalcFields = selTabellaCalcFields
    object selTabellaCOD_VALUTA1: TStringField
      DisplayLabel = 'Da valuta'
      FieldName = 'COD_VALUTA1'
      Required = True
      Size = 10
    end
    object selTabellaDesc_Valuta1: TStringField
      DisplayLabel = 'Descrizione valuta da'
      FieldKind = fkCalculated
      FieldName = 'Desc_Valuta1'
      Size = 100
      Calculated = True
    end
    object selTabellaCOD_VALUTA2: TStringField
      DisplayLabel = 'A valuta'
      FieldName = 'COD_VALUTA2'
      Required = True
      Size = 10
    end
    object selTabellaDesc_Valuta2: TStringField
      DisplayLabel = 'Descrizione valuta a'
      FieldKind = fkCalculated
      FieldName = 'Desc_Valuta2'
      Size = 100
      Calculated = True
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
    object selTabellaCOEFF_CALCOLI: TFloatField
      DisplayLabel = 'Coefficiente di cambio'
      FieldName = 'COEFF_CALCOLI'
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 136
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 136
  end
  inherited selT900: TOracleDataSet
    Left = 224
  end
  inherited selT901: TOracleDataSet
    Left = 280
  end
end
