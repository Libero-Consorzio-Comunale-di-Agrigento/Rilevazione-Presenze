inherited WA019FRaggrGiustifDM: TWA019FRaggrGiustifDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T300.*,T300.ROWID '
      'FROM T300_RAGGRGIUSTIF T300 '
      ':ORDERBY')
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
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
  end
end
