inherited A124FPermessiSindacaliDtM: TA124FPermessiSindacaliDtM
  OldCreateOrder = True
  Height = 73
  Width = 85
  object selT248: TOracleDataSet
    SQL.Strings = (
      'select T248.*, T248.ROWID'
      'from T248_PERMESSISINDACALI T248'
      'where progressivo = :PROGRESSIVO'
      'order by data desc, data_da desc, cod_sindacato, cod_organismo')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001400000016000000500052004F004700520045005300530049005600
      4F000100000000001A00000043004F0044005F00530049004E00440041004300
      410054004F000100000000000800000044004100540041000100000000001600
      00004E0055004D00450052004F005F00500052004F0054000100000000001200
      000044004100540041005F00500052004F0054000100000000000A0000004400
      41004C004C0045000100000000000800000041004C004C004500010000000000
      060000004F005200450001000000000024000000410042004200410054005400
      45005F0043004F004D0050004500540045004E005A0045000100000000001A00
      000043004F0044005F004F005200470041004E00490053004D004F0001000000
      00000A00000053005400410054004F000100000000001A000000500052004F00
      54005F004D004F004400490046004900430041000100000000001A0000004400
      4100540041005F004D004F004400490046004900430041000100000000001200
      0000530049004E00440041004300410054004F00010000000000060000005200
      530055000100000000001C000000520041004700470052005500500050004100
      4D0045004E0054004F000100000000002A000000530049004E00440041004300
      4100540049005F00520041004700470052005500500050004100540049000100
      00000000120000004F005200470041004E00490053004D004F00010000000000
      1A0000005400490050004F005F005000450052004D004500530053004F000100
      000000001A000000500052004F0047005F005000450052004D00450053005300
      4F00010000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT248AfterScroll
    OnCalcFields = selT248CalcFields
    OnNewRecord = selT248NewRecord
    Left = 24
    Top = 16
    object selT248PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT248TIPO_PERMESSO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_PERMESSO'
      Size = 1
    end
    object selT248DATA_DA: TDateTimeField
      DisplayLabel = 'da Data'
      DisplayWidth = 10
      FieldName = 'DATA_DA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248DATA: TDateTimeField
      DisplayLabel = 'a Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248NUMERO_PROT: TStringField
      DisplayLabel = 'N.Prot.'
      DisplayWidth = 5
      FieldName = 'NUMERO_PROT'
      Size = 10
    end
    object selT248DATA_PROT: TDateTimeField
      DisplayLabel = 'Data Prot.'
      DisplayWidth = 10
      FieldName = 'DATA_PROT'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248DALLE: TStringField
      DisplayLabel = 'da Ore'
      FieldName = 'DALLE'
      OnValidate = selT248DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248ALLE: TStringField
      DisplayLabel = 'a Ore'
      FieldName = 'ALLE'
      OnValidate = selT248DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248ORE: TStringField
      DisplayLabel = 'Ore tot.'
      FieldName = 'ORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT248ABBATTE_COMPETENZE: TStringField
      DisplayLabel = 'Abbat.'
      FieldName = 'ABBATTE_COMPETENZE'
      Visible = False
      Size = 1
    end
    object selT248ABBATTE_COMPETENZE_ORG: TStringField
      DisplayLabel = 'Abbat.'
      FieldKind = fkCalculated
      FieldName = 'ABBATTE_COMPETENZE_ORG'
      Size = 1
      Calculated = True
    end
    object selT248COD_ORGANISMO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'COD_ORGANISMO'
      Required = True
      Size = 5
    end
    object selT248D_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_ORGANISMO'
      Size = 80
      Calculated = True
    end
    object selT248COD_SINDACATO: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 5
      FieldName = 'COD_SINDACATO'
      Required = True
      Size = 10
    end
    object selT248D_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_SINDACATO'
      Size = 40
      Calculated = True
    end
    object selT248COD_MINISTERIALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'COD_MINISTERIALE'
      Visible = False
      Size = 11
      Calculated = True
    end
    object selT248STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Required = True
      Size = 1
    end
    object selT248PROT_MODIFICA: TStringField
      DisplayLabel = 'Prot.Mod.'
      DisplayWidth = 5
      FieldName = 'PROT_MODIFICA'
      Size = 10
    end
    object selT248DATA_MODIFICA: TDateTimeField
      DisplayLabel = 'Data Mod.'
      DisplayWidth = 10
      FieldName = 'DATA_MODIFICA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT248INSERITO_GEDAP: TStringField
      DisplayLabel = 'Inserito su GEDAP'
      FieldName = 'INSERITO_GEDAP'
      Required = True
      Visible = False
      Size = 1
    end
    object selT248PROG_PERMESSO: TFloatField
      DisplayLabel = 'Prog. permesso'
      FieldName = 'PROG_PERMESSO'
      Required = True
      Visible = False
    end
    object selT248RSU: TStringField
      FieldKind = fkCalculated
      FieldName = 'RSU'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248RAGGRUPPAMENTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'RAGGRUPPAMENTO'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248RETRIBUITO: TStringField
      FieldKind = fkCalculated
      FieldName = 'RETRIBUITO'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248STATUTARIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'STATUTARIO'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selT248SIGLA_GEDAP: TStringField
      FieldKind = fkCalculated
      FieldName = 'SIGLA_GEDAP'
      Visible = False
      Size = 15
      Calculated = True
    end
  end
end
