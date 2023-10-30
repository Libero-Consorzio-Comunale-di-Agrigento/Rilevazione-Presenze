inherited WA026FDatiLiberiDM: TWA026FDatiLiberiDM
  Height = 179
  Width = 384
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I500.*,I500.ROWID FROM I500_DATILIBERI I500 '
      ' :ORDERBY')
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaProgressivo: TFloatField
      FieldName = 'Progressivo'
    end
    object selTabellaNomeCampo: TStringField
      DisplayLabel = 'Nome dato'
      FieldName = 'NomeCampo'
      Required = True
      Size = 15
    end
    object selTabellaFORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Size = 1
    end
    object selTabellaLUNGHEZZA: TFloatField
      DisplayLabel = 'Dim. del dato'
      FieldName = 'LUNGHEZZA'
      Required = True
      MaxValue = 100.000000000000000000
      MinValue = 1.000000000000000000
    end
    object selTabellaSTORICIZZABILE: TStringField
      DisplayLabel = 'Storicizzabile'
      FieldName = 'STORICIZZABILE'
      Size = 1
    end
    object selTabellaTABELLA: TStringField
      DisplayLabel = 'Dato tabellare'
      FieldName = 'TABELLA'
      Size = 1
    end
    object selTabellaLUNG_DESC: TFloatField
      DisplayLabel = 'Dim. descrizione'
      FieldName = 'LUNG_DESC'
    end
    object selTabellaSTORICO: TStringField
      DisplayLabel = 'Tabella storicizzata'
      FieldName = 'STORICO'
      Size = 1
    end
    object selTabellaSCADENZA: TStringField
      DisplayLabel = 'Gest. manuale scadenza'
      FieldName = 'SCADENZA'
      Size = 1
    end
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOMEPAGINA FROM T033_LAYOUT'
      '  ORDER BY NOMEPAGINA')
    Optimize = False
    Left = 35
    Top = 116
  end
end
