inherited WS130FOrdiniProfessionaliDM: TWS130FOrdiniProfessionaliDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from SG221_ORDPROFSAN_ELENCO t'
      ':ORDERBY')
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    object selSG221COD_ORDINE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 8
      FieldName = 'COD_ORDINE'
      Required = True
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 120
      FieldName = 'DESCRIZIONE'
      Size = 160
    end
    object selTabellaQUALIFICHE_COLLEGATE: TStringField
      DisplayLabel = 'Qualifiche collegate'
      DisplayWidth = 50
      FieldName = 'QUALIFICHE_COLLEGATE'
      Size = 4000
    end
  end
end
