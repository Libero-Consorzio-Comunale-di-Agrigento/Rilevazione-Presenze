inherited WA190FLimitiEccedenzaResDM: TWA190FLimitiEccedenzaResDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T811.ANNO,T811.MESE,T800.NOMECAMPO1,T811.CAMPO1,T800.NOME' +
        'CAMPO2,T811.CAMPO2,T811.ROWID'
      '  FROM T811_RESIDUABILE T811, T800_CAMPILIMITI T800'
      '  WHERE T800.TIPOLIMITE = '#39'R'#39
      
        '    AND T800.DATADECORR  = (select max(DATADECORR) from T800_CAM' +
        'PILIMITI  where TIPOLIMITE = '#39'R'#39' and DATADECORR <= to_date('#39'0101' +
        #39'||T811.ANNO,'#39'ddmmyyyy'#39'))'
      '    AND T811.MESE = 1'
      ':ORDERBY')
    OnApplyRecord = selTabellaApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    object selTabellaANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      MaxValue = 3000
      MinValue = 1900
    end
    object selTabellaNOMECAMPO1: TStringField
      DisplayLabel = 'Nome campo1'
      FieldName = 'NOMECAMPO1'
      Size = 50
    end
    object selTabellaCAMPO1: TStringField
      DisplayLabel = 'Valore campo 1'
      DisplayWidth = 50
      FieldName = 'CAMPO1'
      Size = 50
    end
    object selTabellaNOMECAMPO2: TStringField
      DisplayLabel = 'Nome campo 2'
      FieldName = 'NOMECAMPO2'
      Size = 50
    end
    object selTabellaCAMPO2: TStringField
      DisplayLabel = 'Valore campo 2'
      FieldName = 'CAMPO2'
      Size = 50
    end
    object selTabellaMESE: TIntegerField
      FieldName = 'MESE'
      Visible = False
    end
  end
end
