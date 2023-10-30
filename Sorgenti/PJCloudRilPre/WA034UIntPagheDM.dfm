inherited WA034FIntPagheDM: TWA034FIntPagheDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T190.*,ROWID FROM T190_INTERFACCIAPAGHE T190'
      ':ORDERBY')
    Filtered = True
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaordine: TIntegerField
      DisplayLabel = 'Num.ord.'
      DisplayWidth = 8
      FieldName = 'ordine'
      ReadOnly = True
    end
    object selTabellacodice: TStringField
      FieldName = 'codice'
      Visible = False
    end
    object selTabellacodinterno: TStringField
      DisplayLabel = 'Cod. interno'
      FieldName = 'codinterno'
      ReadOnly = True
      Size = 4
    end
    object selTabelladescrizione: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'descrizione'
      ReadOnly = True
      Size = 50
      Calculated = True
    end
    object selTabellaflag: TStringField
      DisplayLabel = 'Scaricare'
      FieldName = 'flag'
      OnValidate = selTabellaflagValidate
      Size = 1
    end
    object selTabellavoce_paghe: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'voce_paghe'
      Size = 6
    end
    object selTabellaum: TStringField
      DisplayLabel = 'Misura'
      FieldName = 'um'
      Size = 4
    end
  end
  inherited dsrTabella: TDataSource
    Top = 72
  end
end
