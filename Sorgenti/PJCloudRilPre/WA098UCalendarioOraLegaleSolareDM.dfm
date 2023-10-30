inherited WA098FCalendarioOralegaleSolareDM: TWA098FCalendarioOralegaleSolareDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T110.*, T110.ROWID'
      '  from T110_ORALEGALESOLARE T110'
      ':ORDERBY')
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object selTabellaVERSO: TStringField
      FieldName = 'VERSO'
      Visible = False
      Size = 2
    end
    object selTabellaTOraDesc: TStringField
      DisplayLabel = 'Verso'
      FieldKind = fkLookup
      FieldName = 'TOraDesc'
      LookupDataSet = cDtsT110
      LookupKeyFields = 'TORA_COD'
      LookupResultField = 'TORA_DESC'
      KeyFields = 'VERSO'
      Size = 30
      Lookup = True
    end
    object selTabellaORAVECCHIA: TStringField
      DisplayLabel = 'Ora vecchia'
      FieldName = 'ORAVECCHIA'
      ReadOnly = True
      Size = 5
    end
    object selTabellaORANUOVA: TStringField
      DisplayLabel = 'Ora nuova'
      FieldName = 'ORANUOVA'
      ReadOnly = True
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
    Left = 104
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
