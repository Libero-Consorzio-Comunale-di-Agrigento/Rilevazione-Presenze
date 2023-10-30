inherited WA138FAreeTurniDM: TWA138FAreeTurniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from T650_AREE_TURNI t'
      ':ORDERBY')
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    object selSG221CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 8
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 80
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selTabellaSIGLA: TStringField
      DisplayLabel = 'Sigla'
      DisplayWidth = 2
      FieldName = 'SIGLA'
      Size = 2
    end
    object selTabellaCOLORE: TStringField
      DisplayLabel = 'Colore'
      FieldName = 'COLORE'
    end
  end
end
