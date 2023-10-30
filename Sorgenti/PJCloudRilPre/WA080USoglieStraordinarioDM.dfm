inherited WA080FSoglieStraordinarioDM: TWA080FSoglieStraordinarioDM
  Height = 307
  Width = 524
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T027.*, T027.rowid '
      'from T027_SOGLIE_STR_INPUT T027'
      'where TIPOCARTELLINO = :TIPOCARTELLINO'
      ' :ORDERBY')
    Variables.Data = {
      04000000020000001E0000003A005400490050004F0043004100520054004500
      4C004C0049004E004F00050000000000000000000000100000003A004F005200
      44004500520042005900010000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T027_ID'
    BeforeEdit = BeforeEdit
    BeforePost = BeforePost
    AfterPost = AfterPost
    OnNewRecord = selTabellaNewRecord
    object selTabellaID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaTIPOCARTELLINO: TStringField
      DisplayLabel = 'Tipo cartellino'
      FieldName = 'TIPOCARTELLINO'
      ReadOnly = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaSELEZIONE_ANAGRAFE: TStringField
      DisplayLabel = 'Anagrafiche'
      DisplayWidth = 30
      FieldName = 'SELEZIONE_ANAGRAFE'
      Size = 2000
    end
    object selTabellaCAUSALI_GGLAV: TStringField
      DisplayLabel = 'Eccedenze gg.lav'
      DisplayWidth = 15
      FieldName = 'CAUSALI_GGLAV'
      Size = 200
    end
    object selTabellaCAUSALI_GGNONLAV: TStringField
      DisplayLabel = 'Eccedenze gg.non lav'
      DisplayWidth = 15
      FieldName = 'CAUSALI_GGNONLAV'
      Size = 200
    end
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 184
    Top = 80
  end
  object selT028: TOracleDataSet
    SQL.Strings = (
      'select T028.*, T028.rowid '
      'from T028_SOGLIE_STR_OUTPUT T028'
      'where ID = :ID'
      
        'order by oreminuti(replace(decode(SOGLIA,'#39'*'#39','#39'999'#39',SOGLIA),'#39'%'#39','#39 +
        #39'))')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selT028BeforePost
    OnNewRecord = selT028NewRecord
    Left = 24
    Top = 136
    object selT028ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT028SOGLIA: TStringField
      DisplayLabel = 'Soglia'
      FieldName = 'SOGLIA'
      Required = True
      Size = 7
    end
    object selT028ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      DisplayWidth = 20
      FieldName = 'ESPRESSIONE'
      Size = 2000
    end
    object selT028CAUSALE_GGLAV: TStringField
      DisplayLabel = 'Causale gg. lav.'
      FieldName = 'CAUSALE_GGLAV'
      Visible = False
      Size = 5
    end
    object selT028D_CAUSALE_GGLAV: TStringField
      DisplayLabel = 'Causale gg. lav.'
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_GGLAV'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CAUSALE_GGLAV'
      Size = 5
      Lookup = True
    end
    object selT028CAUSALE_GGNONLAV: TStringField
      DisplayLabel = 'Causale gg. non lav.'
      FieldName = 'CAUSALE_GGNONLAV'
      Visible = False
      Size = 5
    end
    object selT028D_CAUSALE_GGNONLAV: TStringField
      DisplayLabel = 'Causale gg. non lav.'
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_GGNONLAV'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODICE'
      KeyFields = 'CAUSALE_GGNONLAV'
      Size = 5
      Lookup = True
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,ORENORMALI FROM T275_CAUPRESENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 76
    Top = 136
  end
  object dsrT028: TDataSource
    AutoEdit = False
    DataSet = selT028
    OnStateChange = dsrTabellaStateChange
    Left = 24
    Top = 200
  end
end
