inherited WA143FMedicineLegaliDM: TWA143FMedicineLegaliDM
  Height = 239
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T485.*, T485.ROWID'
      'from   T485_MEDICINELEGALI T485'
      ':ORDERBY')
    object selT485CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selT485DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 60
    end
    object selTabellaCOD_COMUNE: TStringField
      DisplayLabel = 'Codice Comune'
      FieldName = 'COD_COMUNE'
      Visible = False
      Size = 6
    end
    object selTabellaCOMUNE: TStringField
      DisplayLabel = 'Comune'
      FieldKind = fkLookup
      FieldName = 'COMUNE'
      LookupDataSet = selT480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE'
      Size = 60
      Lookup = True
    end
    object selTabellaINDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object selTabellaCAP: TStringField
      DisplayLabel = 'Cap'
      FieldName = 'CAP'
      Size = 5
    end
    object selTabellaTELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Size = 15
    end
    object selTabellaEMAIL: TStringField
      DisplayLabel = 'EMail'
      DisplayWidth = 30
      FieldName = 'EMAIL'
      Size = 200
    end
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      'FROM T480_COMUNI'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 32
    Top = 120
    object selT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object selT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 40
      FieldName = 'CITTA'
      Size = 60
    end
    object selT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object dsrT480: TDataSource
    AutoEdit = False
    DataSet = selT480
    Left = 32
    Top = 168
  end
end
