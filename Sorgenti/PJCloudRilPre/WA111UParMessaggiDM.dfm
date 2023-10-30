inherited WA111FParMessaggiDM: TWA111FParMessaggiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T291.*, T291.rowid from T291_PARMESSAGGI T291'
      ':ORDERBY')
    CachedUpdates = True
    AfterInsert = AfterInsert
    AfterEdit = AfterEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeCancel = BeforeCancel
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      OnChange = selTabellaCODICEChange
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaDEFAULT_FILE: TStringField
      DisplayLabel = 'Funzione batch'
      FieldName = 'DEFAULT_FILE'
      Size = 1
    end
    object selTabellaTIPO_FILE: TStringField
      DisplayLabel = 'Tipo supporto'
      FieldName = 'TIPO_FILE'
      Size = 1
    end
    object selTabellaNOME_FILE: TStringField
      DisplayLabel = 'Nome file/tabella'
      FieldName = 'NOME_FILE'
      Size = 80
    end
    object selTabellaDATA_FILE: TStringField
      DisplayLabel = 'Formato data'
      FieldName = 'DATA_FILE'
      Size = 10
    end
    object selTabellaTIPO_REGISTRAZIONE: TStringField
      DisplayLabel = 'Tipo reg.'
      FieldName = 'TIPO_REGISTRAZIONE'
      Size = 1
    end
    object selTabellaREGISTRA_MSG: TStringField
      DisplayLabel = 'Registra'
      FieldName = 'REGISTRA_MSG'
      Size = 1
    end
    object selTabellaNUM_RIPET_MSG: TFloatField
      DisplayLabel = 'Ripetizioni'
      FieldName = 'NUM_RIPET_MSG'
    end
    object selTabellaNUM_GGVAL_MSG: TFloatField
      DisplayLabel = 'GG validit'#224
      FieldName = 'NUM_GGVAL_MSG'
    end
    object selTabellaNUM_MMIND_CONS: TFloatField
      DisplayLabel = 'Mesi consuntivo'
      FieldName = 'NUM_MMIND_CONS'
    end
    object selTabellaNUM_MMIND_VALID: TIntegerField
      DisplayLabel = 'Mesi validit'#224
      FieldName = 'NUM_MMIND_VALID'
    end
    object selTabellaTIPO_FILTRO: TStringField
      DisplayLabel = 'Tipo filtro'
      FieldName = 'TIPO_FILTRO'
      Size = 1
    end
    object selTabellaFILTRO_ANAGR: TStringField
      DisplayLabel = 'Filtro'
      FieldName = 'FILTRO_ANAGR'
    end
  end
end
