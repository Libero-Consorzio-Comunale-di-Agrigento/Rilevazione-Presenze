inherited WA056FTurnazIndDM: TWA056FTurnazIndDM
  Height = 151
  Width = 437
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T620.*,T620.ROWID '
      '  FROM T620_TURNAZIND T620'
      ' WHERE PROGRESSIVO = :PROGRESSIVO'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00080000000000000000000000}
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T620_TURNAZIND.PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = 'T620_TURNAZIND.DATA'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaTURNAZIONE: TStringField
      DisplayLabel = 'Turnazione'
      FieldName = 'TURNAZIONE'
      Origin = 'T620_TURNAZIND.TURNAZIONE'
      ReadOnly = True
      Size = 5
    end
    object selTabellaPARTENZA: TFloatField
      DisplayLabel = 'Partenza'
      FieldName = 'PARTENZA'
      Origin = 'T620_TURNAZIND.PARTENZA'
    end
    object selTabellaPIANIF_DA_CALENDARIO: TStringField
      DisplayLabel = 'Pianificazione da calendario'
      FieldName = 'PIANIF_DA_CALENDARIO'
      OnValidate = selTabellaPIANIF_DA_CALENDARIOValidate
      Size = 1
    end
    object selTabellaVERIFICA_TURNI: TStringField
      DisplayLabel = 'Verifica su gg lav.'
      DisplayWidth = 5
      FieldName = 'VERIFICA_TURNI'
      Size = 1
    end
    object selTabellaVERIFICA_RIPOSI: TStringField
      DisplayLabel = 'Verifica riposi'
      DisplayWidth = 5
      FieldName = 'VERIFICA_RIPOSI'
      Size = 1
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 224
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 224
  end
  inherited selT900: TOracleDataSet
    Left = 312
  end
  inherited selT901: TOracleDataSet
    Left = 368
  end
  object cdsSviluppoTurnaz: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 16
    object cdsSviluppoTurnazNUM_GIORNO: TStringField
      DisplayLabel = 'N.Giorno'
      FieldName = 'NUM_GIORNO'
      Size = 10
    end
    object cdsSviluppoTurnazTURNO1: TStringField
      DisplayLabel = 'Turno1'
      FieldName = 'TURNO1'
      Size = 10
    end
    object cdsSviluppoTurnazTURNO2: TStringField
      DisplayLabel = 'Turno2'
      FieldName = 'TURNO2'
      Size = 10
    end
    object cdsSviluppoTurnazORARIO: TStringField
      DisplayLabel = 'Orario'
      FieldName = 'ORARIO'
      Size = 10
    end
    object cdsSviluppoTurnazASSENZA: TStringField
      DisplayLabel = 'Assenza'
      FieldName = 'ASSENZA'
      Size = 10
    end
  end
  object dsrSviluppoTurnaz: TDataSource
    AutoEdit = False
    DataSet = cdsSviluppoTurnaz
    OnStateChange = dsrTabellaStateChange
    Left = 120
    Top = 72
  end
end
