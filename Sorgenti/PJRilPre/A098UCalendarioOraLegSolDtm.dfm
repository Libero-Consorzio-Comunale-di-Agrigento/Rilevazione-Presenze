inherited A098FCalendarioOraLegSolDtm: TA098FCalendarioOraLegSolDtm
  OldCreateOrder = True
  Height = 152
  Width = 250
  object selT110: TOracleDataSet
    SQL.Strings = (
      'select T110.*, T110.ROWID'
      '  from T110_ORALEGALESOLARE T110'
      ' order by T110.DATA desc')
    Optimize = False
    BeforePost = selT110BeforePost
    OnNewRecord = selT110NewRecord
    Left = 48
    Top = 16
    object selT110DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 11
      FieldName = 'DATA'
      EditMask = '!00/00/0000;1;_'
    end
    object selT110VERSO: TStringField
      DisplayLabel = 'Verso'
      FieldName = 'VERSO'
      Visible = False
      Size = 2
    end
    object selT110TOraDesc: TStringField
      DisplayLabel = 'Verso'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'TOraDesc'
      LookupDataSet = cDtsT110
      LookupKeyFields = 'TORA_COD'
      LookupResultField = 'TORA_DESC'
      KeyFields = 'VERSO'
      Size = 30
      Lookup = True
    end
    object selT110ORAVECCHIA: TStringField
      DisplayLabel = 'Ora vecchia'
      FieldName = 'ORAVECCHIA'
      ReadOnly = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT110ORANUOVA: TStringField
      DisplayLabel = 'Ora nuova'
      FieldName = 'ORANUOVA'
      ReadOnly = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
  end
  object cDtsT110: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TORA_DESC'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'TORA_COD'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 144
    Top = 16
    object cDtsT110TORA_COD: TStringField
      FieldName = 'TORA_COD'
      Size = 2
    end
    object cDtsT110TORA_DESC: TStringField
      FieldName = 'TORA_DESC'
      Size = 30
    end
  end
end
