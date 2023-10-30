inherited WA055FTurnazioniDM: TWA055FTurnazioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T640.*,T640.ROWID FROM T640_TURNAZIONI T640 :ORDERBY')
    CachedUpdates = True
    BeforeInsert = BeforeInsert
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T640_TURNAZIONI.CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Origin = 'T640_TURNAZIONI.DESCRIZIONE'
      Size = 40
    end
  end
end
