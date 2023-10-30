inherited WA150FCodiciAccorpamentoCausaliDM: TWA150FCodiciAccorpamentoCausaliDM
  Height = 127
  Width = 332
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T257.*, T257.ROWID'
      '  FROM T257_ACCORPCAUSALI T257'
      ' WHERE T257.COD_TIPOACCORPCAUSALI = :CodTipoAccorpCausali '
      '   AND T257.COD_CODICIACCORPCAUSALI = :CodCodiciAccorpCausali'
      ' :ORDERBY')
    Variables.Data = {
      04000000030000002A0000003A0043004F0044005400490050004F0041004300
      43004F0052005000430041005500530041004C00490005000000000000000000
      00002E0000003A0043004F00440043004F004400490043004900410043004300
      4F0052005000430041005500530041004C004900050000000000000000000000
      100000003A004F00520044004500520042005900010000000000000000000000}
    BeforeEdit = BeforeEdit
    AfterPost = AfterPost
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaCOD_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Tipo accorpamento'
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Visible = False
      Size = 5
    end
    object selTabellaCOD_CODICIACCORPCAUSALI: TStringField
      DisplayLabel = 'Codice accorpamento'
      FieldName = 'COD_CODICIACCORPCAUSALI'
      Required = True
      Visible = False
      Size = 5
    end
    object selTabellaCOD_CAUSALE: TStringField
      DisplayLabel = 'Causale di assenza'
      FieldName = 'COD_CAUSALE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCRIZIONE'
      Size = 50
      Calculated = True
    end
    object selTabellaPERCENTUALE: TFloatField
      DisplayLabel = 'Percentuale cumulo'
      FieldName = 'PERCENTUALE'
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 104
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 104
  end
  inherited selT900: TOracleDataSet
    Left = 192
  end
  inherited selT901: TOracleDataSet
    Left = 248
  end
end
