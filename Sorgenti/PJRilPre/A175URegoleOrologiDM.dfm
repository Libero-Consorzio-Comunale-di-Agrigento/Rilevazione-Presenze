inherited A175FRegoleOrologiDM: TA175FRegoleOrologiDM
  OldCreateOrder = True
  Height = 76
  Width = 307
  object selT362: TOracleDataSet
    SQL.Strings = (
      'select T362.*, rowid '
      'from T362_REGOLE_ANAGRA T362'
      'order by RILEVATORE,FILTRO_ANAGRAFE,DECORRENZA')
    Optimize = False
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T362_ID'
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterScroll = selT362AfterScroll
    Left = 24
    Top = 16
    object selT362ID: TFloatField
      DisplayWidth = 5
      FieldName = 'ID'
    end
    object selT362RILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE'
      KeyFields = 'ID'
      Size = 2
    end
    object selT362FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      DisplayWidth = 40
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 2000
    end
    object selT362DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT362DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT362DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT362CAUSALI_ABILITATE: TStringField
      DisplayLabel = 'Causali abilitate'
      DisplayWidth = 30
      FieldName = 'CAUSALI_ABILITATE'
      Size = 2000
    end
  end
  object selT363: TOracleDataSet
    SQL.Strings = (
      'select T363.*, rowid '
      'from T363_REGOLE_GG T363'
      'where :ID = ID'
      'order by ID, GG, DALLE')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforePost = selT363BeforePost
    OnNewRecord = selT363NewRecord
    Left = 88
    Top = 16
    object selT363ID: TFloatField
      DisplayWidth = 5
      FieldName = 'ID'
    end
    object selT363GG: TStringField
      DisplayWidth = 5
      FieldName = 'GG'
      Size = 1
    end
    object selT363DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selT363ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selT363CAUSALI_ABILITATE: TStringField
      DisplayLabel = 'Causali abilitate'
      DisplayWidth = 30
      FieldName = 'CAUSALI_ABILITATE'
      Size = 2000
    end
  end
  object dsrSelT363: TDataSource
    DataSet = selT363
    Left = 152
    Top = 16
  end
end
