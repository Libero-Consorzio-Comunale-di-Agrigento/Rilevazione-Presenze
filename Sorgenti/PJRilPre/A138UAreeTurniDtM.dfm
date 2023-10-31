inherited A138FAreeTurniDtM: TA138FAreeTurniDtM
  OldCreateOrder = True
  Height = 81
  Width = 79
  object selT650: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from T650_AREE_TURNI t'
      'order by CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000001200000044004100540041005F0049005300430052000100
      000000001A0000004E0055004D005F00500052004F0054005F00490053004300
      52000100000000001A00000044004100540041005F004400450043005F004900
      5300430052000100000000001200000044004100540041005F00430045005300
      53000100000000001A0000004E0055004D005F00500052004F0054005F004300
      4500530053000100000000001800000044004100540041005F00440045004300
      5F004300450053000100000000001A00000043004F0044005F00530049004E00
      440041004300410054004F00010000000000}
    BeforeOpen = selT650BeforeOpen
    BeforePost = BeforePostNoStorico
    Left = 24
    Top = 16
    object selT650CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selT650DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 80
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT650SIGLA: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLA'
      Size = 2
    end
    object selT650COLORE: TStringField
      DisplayLabel = 'Colore'
      DisplayWidth = 20
      FieldName = 'COLORE'
    end
  end
end
