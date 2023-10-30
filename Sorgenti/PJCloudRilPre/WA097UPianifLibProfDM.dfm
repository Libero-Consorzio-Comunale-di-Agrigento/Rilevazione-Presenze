inherited WA097FPianifLibProfDM: TWA097FPianifLibProfDM
  Height = 124
  Width = 388
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T320.*,T320.ROWID FROM T320_PIANLIBPROFESSIONE T320'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      '  AND DATA BETWEEN :DATA1 AND :DATA2'
      ':ORDERBY')
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    BeforePost = BeforePostNoStorico
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaD_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'D_GIORNO'
      Size = 10
      Calculated = True
    end
    object selTabellaDALLE: TStringField
      DefaultExpression = 'hh.nn'
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      OnValidate = selTabellaDALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaALLE: TStringField
      DefaultExpression = 'hh.nn'
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      OnValidate = selTabellaDALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      OnValidate = selTabellaCAUSALEValidate
      Size = 5
    end
    object selTabellaD_CAUSALE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupDataSet = A097FPianifLibProfMW.Q275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 40
      Lookup = True
    end
  end
end
