inherited WA017FRaggrAsseDM: TWA017FRaggrAsseDM
  Height = 231
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T260.*,T260.ROWID '
      'FROM T260_RAGGRASSENZE T260 '
      ':ORDERBY')
    Filtered = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaCodice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object selTabellaDescrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object selTabellaCodInterno: TStringField
      DisplayLabel = 'Inquadramento'
      FieldName = 'CodInterno'
      Size = 1
    end
    object selTabellaContASolare: TStringField
      DisplayLabel = 'Cont.anno solare'
      FieldName = 'ContASolare'
      Size = 1
    end
    object selTabellaResiduabile: TStringField
      FieldName = 'Residuabile'
      Size = 1
    end
    object selTabellaMAXRESIDUO: TStringField
      DisplayLabel = 'Max residuo'
      FieldName = 'MAXRESIDUO'
      Size = 8
    end
    object selTabellaRAGGRUPPAMENTO_RESIDUO: TStringField
      DisplayLabel = 'Raggr.residuo'
      FieldName = 'RAGGRUPPAMENTO_RESIDUO'
      Size = 5
    end
    object selTabellaRAGGR_RESIDUO_PREC: TStringField
      DisplayLabel = 'Raggr.residuo prec.'
      FieldName = 'RAGGR_RESIDUO_PREC'
      Size = 5
    end
    object selTabellaMAXRESIDUO_CORR: TStringField
      DisplayLabel = 'Max residuo corr.'
      FieldName = 'MAXRESIDUO_CORR'
      EditMask = '!9999.99;1;_'
      Size = 8
    end
    object selTabellaMAXRESIDUO_PREC: TStringField
      DisplayLabel = 'Max residuo prec.'
      FieldName = 'MAXRESIDUO_PREC'
      EditMask = '!9999.99;1;_'
      Size = 8
    end
    object selTabellaCUMULA_RAGGR_BASE: TStringField
      DisplayLabel = 'Cumulabile con altri raggr.'
      FieldName = 'CUMULA_RAGGR_BASE'
      Size = 1
    end
  end
  object selT260: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE from T260_RAGGRASSENZE'
      'order by CODICE')
    Optimize = False
    Left = 36
    Top = 120
  end
  object dsrT260: TDataSource
    DataSet = selT260
    Left = 80
    Top = 120
  end
  object selTipiResiduiAC: TOracleDataSet
    SQL.Strings = (
      'SELECT 0 ORDINE, '#39'N'#39' CODICE, '#39'Nessun limite'#39' DESCRIZIONE'
      'FROM DUAL'
      'UNION'
      
        'SELECT 1 ORDINE, '#39'C'#39' CODICE, '#39'Competenze correnti / 2'#39' DESCRIZIO' +
        'NE'
      'FROM DUAL'
      'ORDER BY 1')
    Optimize = False
    Left = 403
    Top = 20
  end
end
