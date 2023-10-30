inherited WA096FProfiliLibProfDM: TWA096FProfiliLibProfDM
  Height = 126
  Width = 380
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T310.*, T310.ROWID'
      'FROM T310_DESCLIBPROF T310'
      ':ORDERBY')
    BeforeDelete = BeforeDelete
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object Q311: TOracleDataSet
    SQL.Strings = (
      'SELECT T311.*, T311.ROWID'
      'FROM T311_DETTLIBPROF T311'
      'WHERE CODICE = :CODICE'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A004F00520044004500520042005900010000000000
      000000000000}
    BeforePost = Q311BeforePost
    OnCalcFields = Q311CalcFields
    OnNewRecord = Q311NewRecord
    Left = 96
    Top = 16
    object Q311CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object Q311GIORNO: TStringField
      DisplayLabel = 'Giorno'
      DisplayWidth = 10
      FieldName = 'GIORNO'
      Size = 2
    end
    object Q311D_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      Size = 12
      Calculated = True
    end
    object Q311DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      OnValidate = Q311DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q311ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      OnValidate = Q311DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object Q311CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      OnValidate = Q311CAUSALEValidate
      Size = 5
    end
    object Q311D_CAUSALE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupDataSet = A096FProfiliLibProfMW.Q275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 40
      Lookup = True
    end
  end
  object D311: TDataSource
    AutoEdit = False
    DataSet = Q311
    Left = 96
    Top = 64
  end
end
