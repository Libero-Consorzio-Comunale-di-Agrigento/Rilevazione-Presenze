inherited A086FMotivazioniRichiesteDtM: TA086FMotivazioniRichiesteDtM
  OldCreateOrder = True
  Height = 78
  Width = 91
  object selT106: TOracleDataSet
    SQL.Strings = (
      'select T106.*, ROWID'
      'from   T106_MOTIVAZIONIRICHIESTE T106'
      'order by TIPO, CODICE')
    ReadBuffer = 100
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePostNoStorico
    BeforeDelete = BeforeDelete
    OnNewRecord = selT106NewRecord
    Left = 24
    Top = 16
    object selT106TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 5
    end
    object selT106CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selT106DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT106CODICE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      FieldName = 'CODICE_DEFAULT'
      Size = 1
    end
    object selT106CAUSALI: TStringField
      DisplayLabel = 'Elenco causali'
      DisplayWidth = 30
      FieldName = 'CAUSALI'
      Size = 100
    end
  end
end
