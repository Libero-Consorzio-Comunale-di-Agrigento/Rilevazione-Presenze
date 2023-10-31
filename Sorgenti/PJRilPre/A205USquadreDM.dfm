inherited A205FSquadreDM: TA205FSquadreDM
  OldCreateOrder = True
  object selT603: TOracleDataSet
    SQL.Strings = (
      'SELECT T603.*,T603.ROWID FROM T603_SQUADRE T603 ORDER BY CODICE')
    Optimize = False
    OnTranslateMessage = OnTranslateMessage
    Filtered = True
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT603AfterScroll
    OnFilterRecord = selT603FilterRecord
    OnNewRecord = selT603NewRecord
    Left = 24
    Top = 8
    object selT603CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selT603INIZIO_VALIDITA: TDateTimeField
      DisplayLabel = 'Inizio validit'#224
      FieldName = 'INIZIO_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT603FINE_VALIDITA: TDateTimeField
      DisplayLabel = 'Fine validit'#224
      FieldName = 'FINE_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT603DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT603DESCRIZIONELUNGA: TStringField
      DisplayLabel = 'Descrizione estesa'
      FieldName = 'DESCRIZIONELUNGA'
      Size = 80
    end
    object selT603CAUS_RIPOSO: TStringField
      DisplayLabel = 'Causale per riposo'
      FieldName = 'CAUS_RIPOSO'
      Size = 5
    end
    object selT603CODICI_TURNAZIONE: TStringField
      DisplayLabel = 'Turnazioni'
      FieldName = 'CODICI_TURNAZIONE'
      Size = 2000
    end
  end
end
