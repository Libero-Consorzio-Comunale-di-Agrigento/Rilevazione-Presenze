inherited WA014FDebitiAggiuntiviDM: TWA014FDebitiAggiuntiviDM
  Height = 231
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T061.*,T061.ROWID '
      'FROM T061_PLUSORAANNUO T061 '
      ':ORDERBY')
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaAnno: TFloatField
      FieldName = 'Anno'
      Required = True
      MaxValue = 3000.000000000000000000
      MinValue = 1000.000000000000000000
    end
    object selTabellaCodice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object selTabellaD_Codice: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_Codice'
      LookupDataSet = T060
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'Codice'
      Size = 40
      Lookup = True
    end
    object selTabellaTipoDebito: TStringField
      DisplayLabel = 'Debito'
      FieldName = 'TipoDebito'
      Required = True
      Size = 1
    end
    object selTabellaTipoPO: TStringField
      FieldName = 'TipoPO'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaOre1: TStringField
      DisplayLabel = 'Gennaio'
      DisplayWidth = 3
      FieldName = 'Ore1'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre2: TStringField
      DisplayLabel = 'Febbraio'
      DisplayWidth = 3
      FieldName = 'Ore2'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre3: TStringField
      DisplayLabel = 'Marzo'
      DisplayWidth = 3
      FieldName = 'Ore3'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre4: TStringField
      DisplayLabel = 'Aprile'
      DisplayWidth = 3
      FieldName = 'Ore4'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre5: TStringField
      DisplayLabel = 'Maggio'
      DisplayWidth = 3
      FieldName = 'Ore5'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre6: TStringField
      DisplayLabel = 'Giugno'
      DisplayWidth = 3
      FieldName = 'Ore6'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre7: TStringField
      DisplayLabel = 'Luglio'
      DisplayWidth = 3
      FieldName = 'Ore7'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre8: TStringField
      DisplayLabel = 'Agosto'
      DisplayWidth = 3
      FieldName = 'Ore8'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre9: TStringField
      DisplayLabel = 'Settembre'
      DisplayWidth = 3
      FieldName = 'Ore9'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre10: TStringField
      DisplayLabel = 'Ottobre'
      DisplayWidth = 3
      FieldName = 'Ore10'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre11: TStringField
      DisplayLabel = 'Novembre'
      DisplayWidth = 3
      FieldName = 'Ore11'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selTabellaOre12: TStringField
      DisplayLabel = 'Dicembre'
      DisplayWidth = 3
      FieldName = 'Ore12'
      Required = True
      EditMask = '!900:00;1;_'
      Size = 6
    end
  end
  object T060: TOracleDataSet
    SQL.Strings = (
      'SELECT T060.CODICE,T060.DESCRIZIONE,T060.ROWID'
      'FROM T060_PLUSORARIO T060'
      'ORDER BY CODICE')
    Optimize = False
    Left = 36
    Top = 128
    object T060CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object T060DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
end
