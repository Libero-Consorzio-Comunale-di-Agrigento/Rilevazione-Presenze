inherited A138FTurniApparatiDTM: TA138FTurniApparatiDTM
  OldCreateOrder = True
  Height = 121
  Width = 339
  object selT555: TOracleDataSet
    SQL.Strings = (
      'SELECT T555.*, T555.ROWID'
      '  FROM T555_TIPOAPPARATI T555'
      ' ORDER BY T555.CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    Left = 64
    Top = 8
    object selT555CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 5
      FieldName = 'CODICE'
      Size = 5
    end
    object selT555DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT555: TDataSource
    DataSet = selT555
    Left = 64
    Top = 56
  end
  object selT550: TOracleDataSet
    SQL.Strings = (
      'SELECT T550.*, T550.ROWID'
      '  FROM T550_APPARATI T550'
      ' ORDER BY T550.COD_APPARATO,T550.CODICE')
    ReadBuffer = 200
    Optimize = False
    OracleDictionary.DefaultValues = True
    AfterScroll = selT550AfterScroll
    Left = 16
    Top = 8
    object selT550COD_APPARATO: TStringField
      FieldName = 'COD_APPARATO'
      Size = 5
    end
    object selT550CODICE: TStringField
      FieldName = 'CODICE'
      Size = 10
    end
    object selT550DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
    end
    object selT550DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
    end
    object selT550DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT550STATO: TStringField
      FieldName = 'STATO'
      Size = 2000
    end
    object selT550DESCCOD_APPARATO: TStringField
      FieldKind = fkLookup
      FieldName = 'desccod_apparato'
      LookupDataSet = selT555
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_APPARATO'
      Size = 50
      Lookup = True
    end
    object selT550FILTRO1: TStringField
      FieldName = 'FILTRO1'
      Size = 2000
    end
    object selT550FILTRO2: TStringField
      FieldName = 'FILTRO2'
      Size = 2000
    end
    object selT550FILTRO_SERVIZI: TStringField
      FieldName = 'FILTRO_SERVIZI'
      Size = 2000
    end
    object selT550DOTAZ_RADIO: TStringField
      FieldName = 'DOTAZ_RADIO'
      Size = 1
    end
  end
  object selFiltro1: TOracleDataSet
    Optimize = False
    Left = 112
    Top = 8
  end
  object selFiltro2: TOracleDataSet
    Optimize = False
    Left = 168
    Top = 8
  end
  object selT540: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE FROM T540_SERVIZI ORDER BY CODICE')
    Optimize = False
    Left = 216
    Top = 8
  end
  object SelCols: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MAX(LENGTH(:CODICE)) DATA_LENGTH FROM :TABELLA WHERE :COD' +
        'ICE IS NOT NULL')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0300000002000000070000003A434F4449434501000000000000000000000008
      0000003A544142454C4C41010000000000000000000000}
    Left = 264
    Top = 8
  end
end
