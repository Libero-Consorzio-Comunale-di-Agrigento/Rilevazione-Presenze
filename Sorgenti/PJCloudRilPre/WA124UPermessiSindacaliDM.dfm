inherited WA124FPermessiSindacaliDM: TWA124FPermessiSindacaliDM
  Height = 121
  Width = 310
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T248.*, T248.ROWID'
      'from T248_PERMESSISINDACALI T248'
      'where progressivo = :PROGRESSIVO'
      ':ORDERBY'
      '')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaTIPO_PERMESSO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_PERMESSO'
      Size = 1
    end
    object selTabellaDATA_DA: TDateTimeField
      DisplayLabel = 'da Data'
      FieldName = 'DATA_DA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'a Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaNUMERO_PROT: TStringField
      DisplayLabel = 'N.Prot.'
      DisplayWidth = 5
      FieldName = 'NUMERO_PROT'
      Size = 10
    end
    object selTabellaDATA_PROT: TDateTimeField
      DisplayLabel = 'Data Prot.'
      DisplayWidth = 10
      FieldName = 'DATA_PROT'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDALLE: TStringField
      DisplayLabel = 'da Ore'
      FieldName = 'DALLE'
      OnValidate = selTabellaDALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaALLE: TStringField
      DisplayLabel = 'a Ore'
      FieldName = 'ALLE'
      OnValidate = selTabellaDALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaORE: TStringField
      DisplayLabel = 'Ore tot.'
      FieldName = 'ORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaABBATTE_COMPETENZE: TStringField
      DisplayLabel = 'Abbat.'
      FieldName = 'ABBATTE_COMPETENZE'
      Visible = False
      Size = 1
    end
    object selTabellaABBATTE_COMPETENZE_ORG: TStringField
      DisplayLabel = 'Abbat.'
      FieldKind = fkCalculated
      FieldName = 'ABBATTE_COMPETENZE_ORG'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selTabellaD_ABBATTE_COMPETENZE_ORG: TStringField
      DisplayLabel = 'Abbatte competenze'
      FieldKind = fkCalculated
      FieldName = 'D_ABBATTE_COMPETENZE_ORG'
      Size = 2
      Calculated = True
    end
    object selTabellaCOD_ORGANISMO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'COD_ORGANISMO'
      Required = True
      Size = 5
    end
    object selTabellaD_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_ORGANISMO'
      Size = 80
      Calculated = True
    end
    object selTabellaCOD_SINDACATO: TStringField
      DisplayLabel = 'Cod.'
      DisplayWidth = 5
      FieldName = 'COD_SINDACATO'
      Required = True
      Size = 10
    end
    object selTabellaD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_SINDACATO'
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_MINISTERIALE: TStringField
      FieldKind = fkCalculated
      FieldName = 'COD_MINISTERIALE'
      Visible = False
      Size = 11
      Calculated = True
    end
    object selTabellaSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Required = True
      Size = 1
    end
    object selTabellaPROT_MODIFICA: TStringField
      DisplayLabel = 'Prot.Mod.'
      DisplayWidth = 5
      FieldName = 'PROT_MODIFICA'
      Size = 10
    end
    object selTabellaDATA_MODIFICA: TDateTimeField
      DisplayLabel = 'Data Mod.'
      DisplayWidth = 10
      FieldName = 'DATA_MODIFICA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaINSERITO_GEDAP: TStringField
      DisplayLabel = 'Inserito su GEDAP'
      FieldName = 'INSERITO_GEDAP'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaPROG_PERMESSO: TFloatField
      DisplayLabel = 'Prog. permesso'
      FieldName = 'PROG_PERMESSO'
      Required = True
      Visible = False
    end
    object selTabellaRSU: TStringField
      FieldKind = fkCalculated
      FieldName = 'RSU'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selTabellaRAGGRUPPAMENTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'RAGGRUPPAMENTO'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selTabellaRETRIBUITO: TStringField
      FieldKind = fkCalculated
      FieldName = 'RETRIBUITO'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selTabellaSTATUTARIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'STATUTARIO'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selTabellaSIGLA_GEDAP: TStringField
      FieldKind = fkCalculated
      FieldName = 'SIGLA_GEDAP'
      Visible = False
      Size = 15
      Calculated = True
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
