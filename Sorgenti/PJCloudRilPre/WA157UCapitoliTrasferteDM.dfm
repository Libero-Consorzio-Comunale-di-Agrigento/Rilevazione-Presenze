inherited WA157FCapitoliTrasferteDM: TWA157FCapitoliTrasferteDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select M030.CODICE, M030.DESCRIZIONE, M030.DECORRENZA, M030.DECO' +
        'RRENZA_FINE, M030.FILTRO_ANAGRAFE, M030.TIPO_MISSIONE, M030.ROWI' +
        'D'
      '  from M030_CAPITOLI_TRASFERTA M030'
      ':ORDERBY')
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza fine'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaFILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 2000
    end
    object selTabellaTIPO_MISSIONE: TStringField
      DisplayLabel = 'Tipo missione'
      FieldName = 'TIPO_MISSIONE'
      Size = 5
    end
  end
end
