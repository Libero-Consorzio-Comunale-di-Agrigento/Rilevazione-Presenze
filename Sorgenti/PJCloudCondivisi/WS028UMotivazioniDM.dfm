inherited WS028FMotivazioniDM: TWS028FMotivazioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select SG104.*,SG104.ROWID '
      '  from SG104_TIPOMOTIVAZIONI SG104'
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 130
    end
    object selTabellaDESCRIZIONE_AGG: TStringField
      DisplayLabel = 'Desc. aggiuntiva'
      FieldName = 'DESCRIZIONE_AGG'
      Size = 200
    end
    object selTabellaSTAMPA_FAMILIARI: TStringField
      FieldName = 'STAMPA_FAMILIARI'
      Visible = False
      Size = 1
    end
    object selTabellaELENCO_NUMERI_PREC: TStringField
      FieldName = 'ELENCO_NUMERI_PREC'
      Visible = False
      Size = 500
    end
    object selTabellaELENCO_NUMERI_SUCC: TStringField
      FieldName = 'ELENCO_NUMERI_SUCC'
      Visible = False
      Size = 500
    end
  end
end
