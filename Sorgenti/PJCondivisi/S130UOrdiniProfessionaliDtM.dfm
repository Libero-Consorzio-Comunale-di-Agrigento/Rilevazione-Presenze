inherited S130FOrdiniProfessionaliDtM: TS130FOrdiniProfessionaliDtM
  OldCreateOrder = True
  Height = 81
  Width = 79
  object selSG221: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from SG221_ORDPROFSAN_ELENCO t'
      'order by cod_ordine')
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
    BeforeOpen = selSG221BeforeOpen
    BeforePost = BeforePostNoStorico
    Left = 24
    Top = 16
    object selSG221COD_ORDINE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 8
      FieldName = 'COD_ORDINE'
      Required = True
      Size = 10
    end
    object selSG221DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 120
      FieldName = 'DESCRIZIONE'
      Size = 160
    end
    object selSG221QUALIFICHE_COLLEGATE: TStringField
      DisplayLabel = 'Qualifiche collegate'
      DisplayWidth = 1
      FieldName = 'QUALIFICHE_COLLEGATE'
      Size = 4000
    end
  end
end
