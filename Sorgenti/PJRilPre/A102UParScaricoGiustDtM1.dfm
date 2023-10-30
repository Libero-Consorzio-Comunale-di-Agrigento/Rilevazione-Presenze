object A102FParScaricoGiustDtM1: TA102FParScaricoGiustDtM1
  OldCreateOrder = True
  OnCreate = A031FParScaricoDtM1Create
  Height = 479
  Width = 741
  object QI150: TOracleDataSet
    SQL.Strings = (
      'SELECT I150.*,I150.ROWID FROM I150_PARSCARICOGIUST I150'
      'ORDER BY CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000150000000C00000043004F0044004900430045000100000000001000
      00004E004F004D004500460049004C004500010000000000120000004D004100
      54005200490043004F004C0041000100000000000E0000004300410055005300
      41004C004500010000000000080000005400490050004F000100000000001000
      000043004F005200520045004E00540045000100000000000A00000042004100
      4400470045000100000000000A0000004F005200410044004100010000000000
      080000004F005200410041000100000000001800000043004F00440049004300
      45005F005400490050004F0049000100000000001800000043004F0044004900
      430045005F005400490050004F004D000100000000001800000043004F004400
      4900430045005F005400490050004F0044000100000000001800000043004F00
      44004900430045005F005400490050004F004E000100000000000C0000004100
      4E004E004F00440041000100000000000C0000004D0045005300450044004100
      01000000000010000000470049004F0052004E004F0044004100010000000000
      0A00000041004E004E004F0041000100000000000A0000004D00450053004500
      41000100000000000E000000470049004F0052004E004F004100010000000000
      0A0000004D0049004E0044004100010000000000080000004D0049004E004100
      010000000000}
    BeforePost = QI150BeforePost
    AfterPost = QI150AfterPost
    AfterCancel = QI150AfterCancel
    BeforeDelete = QI150BeforeDelete
    AfterDelete = QI150AfterDelete
    OnNewRecord = QI150NewRecord
    Left = 60
    Top = 28
    object QI150CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
    end
    object QI150NOMEFILE: TStringField
      FieldName = 'NOMEFILE'
      Required = True
      Size = 100
    end
    object QI150CORRENTE: TStringField
      FieldName = 'CORRENTE'
      Required = True
      Size = 1
    end
    object QI150MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object QI150BADGE: TStringField
      FieldName = 'BADGE'
      Size = 8
    end
    object QI150ANNODA: TStringField
      FieldName = 'ANNODA'
      Size = 8
    end
    object QI150MESEDA: TStringField
      FieldName = 'MESEDA'
      Size = 8
    end
    object QI150GIORNODA: TStringField
      FieldName = 'GIORNODA'
      Size = 8
    end
    object QI150ANNOA: TStringField
      FieldName = 'ANNOA'
      Size = 8
    end
    object QI150MESEA: TStringField
      FieldName = 'MESEA'
      Size = 8
    end
    object QI150GIORNOA: TStringField
      FieldName = 'GIORNOA'
      Size = 8
    end
    object QI150ORADA: TStringField
      FieldName = 'ORADA'
      Size = 8
    end
    object QI150MINDA: TStringField
      FieldName = 'MINDA'
      Size = 8
    end
    object QI150ORAA: TStringField
      FieldName = 'ORAA'
      Size = 8
    end
    object QI150MINA: TStringField
      FieldName = 'MINA'
      Size = 8
    end
    object QI150CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Required = True
      Size = 8
    end
    object QI150TIPO: TStringField
      FieldName = 'TIPO'
      Size = 8
    end
    object QI150CODICE_TIPOI: TStringField
      FieldName = 'CODICE_TIPOI'
      Size = 5
    end
    object QI150CODICE_TIPOM: TStringField
      FieldName = 'CODICE_TIPOM'
      Size = 5
    end
    object QI150CODICE_TIPOD: TStringField
      FieldName = 'CODICE_TIPOD'
      Size = 5
    end
    object QI150CODICE_TIPON: TStringField
      FieldName = 'CODICE_TIPON'
      Size = 5
    end
  end
end
