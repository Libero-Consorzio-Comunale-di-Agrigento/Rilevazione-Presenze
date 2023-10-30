inherited WA205FSquadreDM: TWA205FSquadreDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T603.*,T603.ROWID'
      'from T603_SQUADRE T603'
      ':ORDERBY')
    BeforeEdit = BeforeEdit
    AfterPost = selTabellaAfterPost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selTabellaINIZIO_VALIDITA: TDateTimeField
      DisplayLabel = 'Inizio validit'#224
      FieldName = 'INIZIO_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaFINE_VALIDITA: TDateTimeField
      DisplayLabel = 'Fine validit'#224
      FieldName = 'FINE_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaDESCRIZIONELUNGA: TStringField
      DisplayLabel = 'Descrizione estesa'
      FieldName = 'DESCRIZIONELUNGA'
      Visible = False
      Size = 80
    end
    object selTabellaCAUS_RIPOSO: TStringField
      DisplayLabel = 'Causale per riposo'
      FieldName = 'CAUS_RIPOSO'
      Visible = False
      Size = 5
    end
    object selTabellaCODICI_TURNAZIONE: TStringField
      DisplayLabel = 'Turnazioni'
      FieldName = 'CODICI_TURNAZIONE'
      Visible = False
      Size = 2000
    end
  end
end
