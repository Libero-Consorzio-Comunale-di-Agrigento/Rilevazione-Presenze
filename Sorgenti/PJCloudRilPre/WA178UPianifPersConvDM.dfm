inherited WA178FPianifPersConvDM: TWA178FPianifPersConvDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T420.*, T420.ROWID'
      'FROM T420_PIANIF_PERSCONV T420'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T420_ID'
    AfterPost = AfterPost
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaID: TFloatField
      FieldName = 'ID'
      ReadOnly = True
    end
  end
  object selT421: TOracleDataSet
    SQL.Strings = (
      'SELECT T421.*, T421.ROWID'
      'FROM T421_PIANIF_PERSCONV_SETT T421'
      'WHERE ID = :ID'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000060000003A0049004400030000000000000000000000}
    BeforePost = selT421BeforePost
    OnCalcFields = selT421CalcFields
    OnNewRecord = selT421NewRecord
    Left = 96
    Top = 16
    object selT421ID: TFloatField
      FieldName = 'ID'
      Required = True
      Visible = False
    end
    object selT421GIORNO: TIntegerField
      DisplayLabel = 'Giorno'
      FieldName = 'GIORNO'
      Required = True
    end
    object selT421D_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      ReadOnly = True
      Size = 10
      Calculated = True
    end
    object selT421TOLL_DALLE: TStringField
      DisplayLabel = 'Toll. prima'
      FieldName = 'TOLL_DALLE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT421DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT421ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT421TOLL_ALLE: TStringField
      DisplayLabel = 'Toll. dopo'
      FieldName = 'TOLL_ALLE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT421STRUTTURA: TStringField
      DisplayLabel = 'Struttura'
      FieldName = 'STRUTTURA'
      Size = 30
    end
    object selT421RESPONSABILE: TStringField
      DisplayLabel = 'Responsabile'
      FieldName = 'RESPONSABILE'
      Required = True
      Size = 30
    end
    object selT421RESPONSABILI_CC: TStringField
      DisplayLabel = 'Responsabili CC'
      FieldName = 'RESPONSABILI_CC'
      Size = 100
    end
    object selT421NOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 2000
    end
  end
  object dsrT421: TDataSource
    DataSet = selT421
    Left = 96
    Top = 64
  end
end
