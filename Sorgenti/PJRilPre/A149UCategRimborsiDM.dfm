inherited A149FCategRimborsiDM: TA149FCategRimborsiDM
  OldCreateOrder = True
  Height = 118
  Width = 125
  object selM022: TOracleDataSet
    SQL.Strings = (
      'select M022.CODICE, M022.DESCRIZIONE, M022.ROWID'
      '  from M022_CATEG_RIMBORSI M022'
      ' order by M022.CODICE')
    Optimize = False
    Left = 24
    Top = 16
    object selM022CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selM022DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 60
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
  end
end
