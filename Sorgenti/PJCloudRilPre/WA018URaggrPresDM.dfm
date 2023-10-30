inherited WA018FRaggrPresDM: TWA018FRaggrPresDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T270.*,T270.ROWID '
      'FROM T270_RAGGRPRESENZE T270 '
      ':ORDERBY')
    Filtered = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaCodice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object selTabellaDescrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object selTabellaCodInterno: TStringField
      DisplayLabel = 'Cod.Interno'
      FieldName = 'CodInterno'
      Size = 1
    end
    object selTabellaIndNotturna: TStringField
      DisplayLabel = 'Ind.Notturna'
      FieldName = 'IndNotturna'
      Size = 1
    end
    object selTabellaIndFestiva: TStringField
      DisplayLabel = 'Ind.Festiva'
      FieldName = 'IndFestiva'
      Size = 1
    end
    object selTabellaINDPRESENZA: TStringField
      DisplayLabel = 'Ind.Presenza'
      FieldName = 'INDPRESENZA'
      Size = 1
    end
  end
end
