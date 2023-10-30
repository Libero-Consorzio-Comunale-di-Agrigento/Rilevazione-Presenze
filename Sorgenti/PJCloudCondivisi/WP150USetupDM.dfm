inherited WP150FSetupDM: TWP150FSetupDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P150.*,P150.ROWID FROM P150_SETUP P150'
      ':ORDERBY')
    OnCalcFields = selTabellaCalcFields
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
    object selTabellaCOD_PAGAMENTO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo pagamento cedolino'
      DisplayWidth = 5
      FieldName = 'COD_PAGAMENTO'
      Size = 5
    end
    object selTabellaDES_PAGAM: TStringField
      DisplayLabel = 'Descrizione tipo pagamento'
      FieldKind = fkCalculated
      FieldName = 'DES_PAGAM'
      Calculated = True
    end
    object selTabellaCOD_VALUTA_BASE: TStringField
      DisplayLabel = 'Valuta calcoli cedolino'
      FieldName = 'COD_VALUTA_BASE'
      Size = 10
    end
    object selTabellaDES_BASE: TStringField
      DisplayLabel = 'Descrizione valuta calcoli'
      FieldKind = fkCalculated
      FieldName = 'DES_BASE'
      Visible = False
      Calculated = True
    end
    object selTabellaCOD_VALUTA_STAMPA: TStringField
      DisplayLabel = 'Valuta netto cedolino'
      FieldName = 'COD_VALUTA_STAMPA'
      Size = 10
    end
    object selTabellaDES_STAMPA: TStringField
      DisplayLabel = 'Descrizione valuta netto'
      FieldKind = fkCalculated
      FieldName = 'DES_STAMPA'
      Visible = False
      Calculated = True
    end
    object selTabellaCOD_VALUTA_CONT: TStringField
      DisplayLabel = 'Valuta contabilit'#224
      FieldName = 'COD_VALUTA_CONT'
      Size = 10
    end
    object selTabellaDES_CONT: TStringField
      DisplayLabel = 'Descrizione valuta contabilit'#224
      FieldKind = fkCalculated
      FieldName = 'DES_CONT'
      Visible = False
      Calculated = True
    end
    object selTabellaCOD_COMUNE_INAIL: TStringField
      DisplayLabel = 'Comune sede lavoro'
      FieldName = 'COD_COMUNE_INAIL'
      Size = 4
    end
    object selTabellaC_Desc_Comune: TStringField
      DisplayLabel = 'Descrizione comune'
      DisplayWidth = 40
      FieldKind = fkCalculated
      FieldName = 'C_Desc_Comune'
      Size = 200
      Calculated = True
    end
    object selTabellaNUM_DEC_PERC: TIntegerField
      DisplayLabel = 'Num. decimali percentuale'
      FieldName = 'NUM_DEC_PERC'
      Visible = False
    end
    object selTabellaNUM_DEC_QUANTITA: TIntegerField
      DisplayLabel = 'Num. decimali quantit'#224
      FieldName = 'NUM_DEC_QUANTITA'
      Visible = False
    end
    object selTabellaTIPO_ORE: TStringField
      DisplayLabel = 'Formato ore'
      FieldName = 'TIPO_ORE'
      Visible = False
      Size = 2
    end
    object selTabellaBLOCCO_DETR_IRPEF: TStringField
      DisplayLabel = 'Blocco detrazioni IRPEF'
      FieldName = 'BLOCCO_DETR_IRPEF'
      Visible = False
      Size = 1
    end
    object selTabellaULTIMO_ANNO_RECUP: TIntegerField
      DisplayLabel = 'Ultimo anno recuperato'
      FieldName = 'ULTIMO_ANNO_RECUP'
      Visible = False
    end
  end
end
