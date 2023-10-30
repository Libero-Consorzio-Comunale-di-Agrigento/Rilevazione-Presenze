inherited WA150FAccorpamentoCausaliDM: TWA150FAccorpamentoCausaliDM
  Height = 138
  Width = 430
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T255.*,T255.ROWID '
      '  FROM T255_TIPOACCORPCAUSALI T255'
      ' :ORDERBY')
    AfterScroll = nil
    OnCalcFields = selTabellaCalcFields
    object selTabellaCOD_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 8
      FieldName = 'TIPO'
      Size = 5
    end
    object selTabellaD_TIPO: TStringField
      DisplayLabel = 'Descrizione tipo'
      FieldKind = fkCalculated
      FieldName = 'D_TIPO'
      Size = 100
      Calculated = True
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 240
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 240
  end
  inherited selT900: TOracleDataSet
    Left = 328
  end
  inherited selT901: TOracleDataSet
    Left = 384
  end
  object selT256: TOracleDataSet
    SQL.Strings = (
      'SELECT T256.*,T256.ROWID'
      'FROM T256_CODICIACCORPCAUSALI T256'
      ' WHERE T256.COD_TIPOACCORPCAUSALI = :CodTipoAccorpCausali'
      ' :ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000020000002A0000003A0043004F0044005400490050004F0041004300
      43004F0052005000430041005500530041004C00490005000000000000000000
      0000100000003A004F0052004400450052004200590001000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000003000000160000004400450053004300520049005A0049004F004E00
      45000100000000002A00000043004F0044005F005400490050004F0041004300
      43004F0052005000430041005500530041004C0049000100000000002E000000
      43004F0044005F0043004F0044004900430049004100430043004F0052005000
      430041005500530041004C004900010000000000}
    BeforeInsert = selT256BeforeInsert
    AfterPost = selT256AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = selT256AfterScroll
    OnNewRecord = selT256NewRecord
    Left = 93
    Top = 17
    object selT256COD_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Tipo accorpamento'
      FieldName = 'COD_TIPOACCORPCAUSALI'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 5
    end
    object selT256D_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Descr. tipo accorpamento'
      FieldKind = fkLookup
      FieldName = 'D_TIPOACCORPCAUSALI'
      LookupDataSet = selTabella
      LookupKeyFields = 'COD_TIPOACCORPCAUSALI'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_TIPOACCORPCAUSALI'
      ReadOnly = True
      Visible = False
      Size = 500
      Lookup = True
    end
    object selT256COD_CODICIACCORPCAUSALI: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_CODICIACCORPCAUSALI'
      ReadOnly = True
      Required = True
      Size = 5
    end
    object selT256DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
  end
  object dsrT256: TDataSource
    AutoEdit = False
    DataSet = selT256
    Left = 94
    Top = 64
  end
  object selT257: TOracleDataSet
    SQL.Strings = (
      'SELECT T257.*, T265.DESCRIZIONE'
      '  FROM T257_ACCORPCAUSALI T257, T265_CAUASSENZE T265'
      ' WHERE T257.COD_TIPOACCORPCAUSALI = :CodTipoAccorpCausali '
      '   AND T257.COD_CODICIACCORPCAUSALI = :CodCodiciAccorpCausali'
      '   AND T257.COD_CAUSALE = T265.CODICE'
      ' ORDER BY T257.DECORRENZA,T257.COD_CAUSALE ')
    Optimize = False
    Variables.Data = {
      04000000020000002A0000003A0043004F0044005400490050004F0041004300
      43004F0052005000430041005500530041004C00490005000000000000000000
      00002E0000003A0043004F00440043004F004400490043004900410043004300
      4F0052005000430041005500530041004C004900050000000000000000000000}
    Left = 152
    Top = 16
    object selT257DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT257DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selT257COD_TIPOACCORPCAUSALI: TStringField
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Visible = False
      Size = 5
    end
    object selT257COD_CODICIACCORPCAUSALI: TStringField
      FieldName = 'COD_CODICIACCORPCAUSALI'
      Required = True
      Visible = False
      Size = 5
    end
    object selT257COD_CAUSALE: TStringField
      DisplayLabel = 'Causale assenza'
      FieldName = 'COD_CAUSALE'
      Required = True
      Size = 5
    end
    object selT257DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT257PERCENTUALE: TFloatField
      DisplayLabel = '% Cumulo'
      FieldName = 'PERCENTUALE'
    end
  end
end
