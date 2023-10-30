inherited WA196FTipiPagamentoDM: TWA196FTipiPagamentoDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from m049_tipopagamento t'
      ':ORDERBY')
    BeforePost = selTabellaBeforePost
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
    object selTabellaSOMMA: TStringField
      DisplayLabel = 'Rimborsare al dipendente'
      FieldName = 'SOMMA'
    end
  end
end
