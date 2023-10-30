inherited WA086FMotivazioniRichiesteDM: TWA086FMotivazioniRichiesteDM
  Height = 133
  Width = 397
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T106.*, ROWID'
      'from   T106_MOTIVAZIONIRICHIESTE T106'
      ':ORDERBY')
    CommitOnPost = False
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 5
    end
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaCODICE_DEFAULT: TStringField
      Alignment = taCenter
      DisplayLabel = 'Default'
      FieldName = 'CODICE_DEFAULT'
      Size = 1
    end
    object selTabellaCAUSALI: TStringField
      DisplayLabel = 'Elenco causali'
      DisplayWidth = 40
      FieldName = 'CAUSALI'
      Size = 100
    end
  end
end
