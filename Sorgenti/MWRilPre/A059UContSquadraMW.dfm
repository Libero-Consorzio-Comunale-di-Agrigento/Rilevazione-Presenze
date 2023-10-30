inherited A059FContSquadraMW: TA059FContSquadraMW
  OldCreateOrder = True
  Height = 108
  Width = 267
  object dsrT603b: TDataSource
    DataSet = selT603b
    Left = 208
    Top = 20
  end
  object selT603a: TOracleDataSet
    SQL.Strings = (
      
        'select INIZIO_VALIDITA, FINE_VALIDITA, T603.CODICE, T603.DESCRIZ' +
        'IONE'
      'from T603_SQUADRE T603'
      'where T603.INIZIO_VALIDITA <= :DATAA'
      'and T603.FINE_VALIDITA >= :DATADA'
      'and :DATAA >= :DATADA'
      'order by T603.CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000}
    Filtered = True
    OnFilterRecord = selT603FilterRecord
    Left = 24
    Top = 20
    object selT603aCODICE: TStringField
      DisplayWidth = 13
      FieldName = 'CODICE'
      Size = 10
    end
    object selT603aDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT603a: TDataSource
    DataSet = selT603a
    Left = 76
    Top = 20
  end
  object selT603b: TOracleDataSet
    SQL.Strings = (
      
        'select INIZIO_VALIDITA, FINE_VALIDITA, T603.CODICE, T603.DESCRIZ' +
        'IONE'
      'from T603_SQUADRE T603'
      'where T603.INIZIO_VALIDITA <= :DATAA'
      'and T603.FINE_VALIDITA >= :DATADA'
      'and :DATAA >= :DATADA'
      'order by T603.CODICE')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A00440041005400410041000C00000000000000
      000000000E0000003A004400410054004100440041000C000000000000000000
      0000}
    Filtered = True
    OnFilterRecord = selT603FilterRecord
    Left = 156
    Top = 20
    object selT603bCODICE: TStringField
      DisplayWidth = 13
      FieldName = 'CODICE'
      Size = 10
    end
    object selT603bDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
end
