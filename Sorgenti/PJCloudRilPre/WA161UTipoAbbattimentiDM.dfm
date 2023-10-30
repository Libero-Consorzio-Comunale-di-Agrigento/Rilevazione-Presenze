inherited WA161FTipoAbbattimentiDM: TWA161FTipoAbbattimentiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select T766.*, T766.rowid from T766_INCENTIVITIPOABBAT T766 :ORD' +
        'ERBY')
    OnNewRecord = selTabellaNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaRISPARMIO_BILANCIO: TStringField
      DisplayLabel = 'Risparmio su economia di bilancio'
      FieldName = 'RISPARMIO_BILANCIO'
      Size = 2
    end
  end
end
