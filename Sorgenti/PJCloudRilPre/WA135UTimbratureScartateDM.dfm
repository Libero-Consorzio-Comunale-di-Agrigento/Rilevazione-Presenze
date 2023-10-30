inherited WA135FTimbratureScartateDM: TWA135FTimbratureScartateDM
  Height = 151
  Width = 349
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t103.*, rowid'
      'from   t103_timbrature_scartate t103'
      'where'#9't103.progressivo = :progressivo'
      'and'#9't103.data between :datainizio and :datafine'
      ' :ORDERBY')
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    BeforeInsert = BeforeInsert
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
    end
    object selTabellaORA: TDateTimeField
      DisplayLabel = 'Ora'
      DisplayWidth = 8
      FieldName = 'ORA'
      ReadOnly = True
      Required = True
      OnGetText = selT103ORAGetText
      DisplayFormat = 'hh.mm'
    end
    object selTabellaVERSO: TStringField
      DisplayLabel = 'Verso'
      DisplayWidth = 3
      FieldName = 'VERSO'
      Required = True
      Size = 1
    end
    object selTabellaFLAG: TStringField
      DisplayWidth = 1
      FieldName = 'FLAG'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaRILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      DisplayWidth = 10
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 8
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 184
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 184
  end
  inherited selT900: TOracleDataSet
    Left = 256
  end
  inherited selT901: TOracleDataSet
    Left = 312
  end
  object selT100: TOracleDataSet
    SQL.Strings = (
      'select t100.*, rowid'
      'from   t100_timbrature t100'
      'where'#9't100.progressivo = :progressivo'
      'and'#9't100.data = :datagiorno'
      'and'#9'flag in ('#39'O'#39','#39'I'#39')'
      ' :ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004700
      49004F0052004E004F000C0000000000000000000000100000003A004F005200
      44004500520042005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000700000016000000500052004F004700520045005300530049005600
      4F00010000000000080000004400410054004100010000000000060000004F00
      520041000100000000000A00000056004500520053004F000100000000000800
      000046004C004100470001000000000014000000520049004C00450056004100
      54004F00520045000100000000000E000000430041005500530041004C004500
      010000000000}
    ReadOnly = True
    Left = 96
    Top = 16
    object FloatField1: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = 'Ora'
      DisplayWidth = 8
      FieldName = 'ORA'
      Required = True
      OnGetText = DateTimeField2GetText
      DisplayFormat = 'hh.mm'
    end
    object StringField1: TStringField
      DisplayLabel = 'Verso'
      DisplayWidth = 3
      FieldName = 'VERSO'
      Required = True
      Size = 1
    end
    object StringField2: TStringField
      FieldName = 'FLAG'
      Required = True
      Visible = False
      Size = 1
    end
    object StringField3: TStringField
      DisplayLabel = 'Rilevatore'
      DisplayWidth = 10
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object StringField4: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 8
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  object dsrT100: TDataSource
    DataSet = selT100
    Left = 96
    Top = 64
  end
end
