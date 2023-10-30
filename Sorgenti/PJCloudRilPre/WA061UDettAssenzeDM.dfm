inherited WA061FDettAssenzeDM: TWA061FDettAssenzeDM
  OldCreateOrder = True
  object selT256: TOracleDataSet
    SQL.Strings = (
      'select cod_codiciaccorpcausali, descrizione'
      'from t256_codiciaccorpcausali'
      'where :tipo_acc is null or cod_tipoaccorpcausali = :tipo_acc'
      'order by cod_codiciaccorpcausali')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A005400490050004F005F004100430043000500
      00000000000000000000}
    Left = 64
    Top = 16
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,GSIGNIFIC,VALIDAZIONE '
      'FROM T265_CAUASSENZE '
      'WHERE :TIPO_ACC IS NULL '
      'OR EXISTS (SELECT 1 '
      '           FROM T257_ACCORPCAUSALI'
      '           WHERE CODICE = COD_CAUSALE'
      '           AND COD_TIPOACCORPCAUSALI = :TIPO_ACC'
      '           AND COD_CODICIACCORPCAUSALI IN (:COD_ACC))'
      'ORDER BY CODICE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A005400490050004F005F004100430043000500
      00000000000000000000100000003A0043004F0044005F004100430043000100
      00000000000000000000}
    Filtered = True
    Left = 124
    Top = 16
  end
  object selT255: TOracleDataSet
    SQL.Strings = (
      'select cod_tipoaccorpcausali, descrizione'
      'from t255_tipoaccorpcausali'
      'order by cod_tipoaccorpcausali')
    Optimize = False
    Left = 120
    Top = 120
    object selT255COD_TIPOACCORPCAUSALI: TStringField
      DisplayWidth = 7
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Size = 5
    end
    object selT255DESCRIZIONE: TStringField
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object D255: TDataSource
    DataSet = selT255
    Left = 168
    Top = 120
  end
end
