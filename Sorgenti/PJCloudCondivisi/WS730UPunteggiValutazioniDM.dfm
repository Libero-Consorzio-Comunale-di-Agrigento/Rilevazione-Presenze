inherited WS730FPunteggiValutazioniDM: TWS730FPunteggiValutazioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG730.*, SG730.ROWID'
      'FROM   SG730_PUNTEGGI SG730'
      ':ORDERBY')
    AfterOpen = selTabellaAfterOpen
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaDATO1: TStringField
      FieldName = 'DATO1'
    end
    object selTabellaDESC_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'DESC_DATO1'
      LookupDataSet = S730FPunteggiValutazioniMW.selDato1
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 100
      Lookup = True
    end
    object selTabellaPUNTEGGIO: TFloatField
      DisplayLabel = 'Punteggio'
      FieldName = 'PUNTEGGIO'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selTabellaCALCOLO_PFP: TStringField
      DisplayLabel = 'Calcolo Punteggio scheda'
      FieldName = 'CALCOLO_PFP'
      Size = 1
    end
    object selTabellaGIUSTIFICA: TStringField
      DisplayLabel = 'Giustifica'
      FieldName = 'GIUSTIFICA'
      Size = 1
    end
    object selTabellaITEM_GIUDICABILE: TStringField
      DisplayLabel = 'Elemento Giudicabile'
      FieldName = 'ITEM_GIUDICABILE'
      Size = 1
    end
  end
end
