inherited A178FPianifPersConvDtM: TA178FPianifPersConvDtM
  OldCreateOrder = True
  Height = 178
  Width = 231
  object selT420: TOracleDataSet
    SQL.Strings = (
      'SELECT T420.*, T420.ROWID'
      'FROM T420_PIANIF_PERSCONV T420'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T420_ID'
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000004000000140000004400450043004F005200520045004E005A004100
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E00450001000000000016000000500052004F004700520045005300
      5300490056004F000100000000000400000049004400010000000000}
    AfterPost = AfterPost
    AfterScroll = selT420AfterScroll
    OnNewRecord = OnNewRecord
    Left = 16
    Top = 8
    object selT420PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT420DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT420DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT420ID: TFloatField
      FieldName = 'ID'
    end
  end
  object selT421: TOracleDataSet
    SQL.Strings = (
      'SELECT T421.*, T421.ROWID'
      'FROM T421_PIANIF_PERSCONV_SETT T421'
      'WHERE ID = :ID'
      'ORDER BY GIORNO, DALLE')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000800000004000000490044000100000000000C000000470049004F00
      52004E004F000100000000000A000000440041004C004C004500010000000000
      0800000041004C004C0045000100000000001200000053005400520055005400
      54005500520041000100000000001800000052004500530050004F004E005300
      4100420049004C0045000100000000001E00000052004500530050004F004E00
      53004100420049004C0049005F0043004300010000000000080000004E004F00
      54004500010000000000}
    BeforeInsert = selT421BeforeInsert
    BeforePost = selT421BeforePost
    OnCalcFields = selT421CalcFields
    OnNewRecord = selT421NewRecord
    Left = 88
    Top = 8
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
      Size = 10
      Calculated = True
    end
    object selT421DALLE: TStringField
      DefaultExpression = 'hh.mm'
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selT421ALLE: TStringField
      DefaultExpression = 'hh.mm'
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      EditMask = '!00.00;1;_'
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
    object selT421TOLL_DALLE: TStringField
      DisplayLabel = 'Toll. prima'
      FieldName = 'TOLL_DALLE'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selT421TOLL_ALLE: TStringField
      DisplayLabel = 'Toll. dopo'
      FieldName = 'TOLL_ALLE'
      EditMask = '!00.00;1;_'
      Size = 5
    end
  end
  object dsrT421: TDataSource
    DataSet = selT421
    Left = 88
    Top = 64
  end
end
