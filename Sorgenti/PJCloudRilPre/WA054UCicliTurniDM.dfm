inherited WA054FCicliTurniDM: TWA054FCicliTurniDM
  Height = 155
  Width = 392
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T610.*, T610.ROWID '
      '  from T610_CICLI T610 '
      ' :ORDERBY')
    CachedUpdates = True
    BeforeInsert = BeforeInsert
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T610_CICLI.CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Origin = 'T610_CICLI.DESCRIZIONE'
      Size = 40
    end
  end
end
