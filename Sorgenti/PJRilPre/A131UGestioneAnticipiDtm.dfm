inherited A131FGestioneAnticipiDtm: TA131FGestioneAnticipiDtm
  OldCreateOrder = True
  Height = 258
  Width = 267
  object selM060: TOracleDataSet
    SQL.Strings = (
      'SELECT M060.*,ROWID'
      'FROM M060_ANTICIPI M060 '
      'WHERE M060.PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    AfterScroll = selM060AfterScroll
    OnNewRecord = selM060NewRecord
    Left = 16
    Top = 10
    object selM060CASSA: TStringField
      FieldName = 'CASSA'
      Size = 10
    end
    object selM060NUM_MOVIMENTO: TFloatField
      FieldName = 'NUM_MOVIMENTO'
    end
    object selM060ANNO_MOVIMENTO: TStringField
      FieldName = 'ANNO_MOVIMENTO'
      Size = 4
    end
    object selM060DATA_MOVIMENTO: TDateTimeField
      FieldName = 'DATA_MOVIMENTO'
      EditMask = '!00/00/0000;1;_'
    end
    object selM060COD_VOCE: TStringField
      FieldName = 'COD_VOCE'
    end
    object selM060DATA_MISSIONE: TDateTimeField
      FieldName = 'DATA_MISSIONE'
      EditMask = '!00/00/0000;1;_'
    end
    object selM060QUANTITA: TFloatField
      FieldName = 'QUANTITA'
    end
    object selM060IMPORTO: TFloatField
      FieldName = 'IMPORTO'
    end
    object selM060FLAG_TOTALIZZATORE: TStringField
      FieldName = 'FLAG_TOTALIZZATORE'
    end
    object selM060STATO: TStringField
      FieldName = 'STATO'
    end
    object selM060DATA_IMPOSTAZIONE: TDateTimeField
      FieldName = 'DATA_IMPOSTAZIONE_STATO'
      EditMask = '!00/00/0000;1;_'
    end
    object selM060NOTE: TStringField
      FieldName = 'NOTE'
      Size = 500
    end
    object selM060PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selM060ITA_EST: TStringField
      FieldName = 'ITA_EST'
      Size = 1
    end
    object selM060ID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
    end
    object selM060NROSOSP: TFloatField
      FieldName = 'NROSOSP'
    end
    object selM060DESC_CODVOCE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_CODVOCE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VOCE'
      Size = 100
      Lookup = True
    end
  end
  object dscM060: TDataSource
    Left = 16
    Top = 56
  end
  object dscM040: TDataSource
    OnDataChange = dscM040DataChange
    Left = 73
    Top = 52
  end
end
