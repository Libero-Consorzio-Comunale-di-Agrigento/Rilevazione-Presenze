inherited WA057FSpostSquadraDM: TWA057FSpostSquadraDM
  Height = 125
  Width = 384
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T630.*,T630.ROWID FROM T630_SPOSTSQUADRA T630'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    AfterPost = AfterPost
    AfterDelete = AfterDelete
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
      FieldName = 'DATA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaSQUADRA: TStringField
      DisplayLabel = 'Cod. Squadra'
      FieldName = 'SQUADRA'
      Required = True
      Size = 10
    end
    object selTabellaDESC_SQUADRA: TStringField
      DisplayLabel = 'Desc. squadra'
      FieldKind = fkCalculated
      FieldName = 'DESC_SQUADRA'
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_TIPOOPE: TStringField
      DisplayLabel = 'Tipo operatore'
      FieldName = 'COD_TIPOOPE'
      Size = 5
    end
    object selTabellaORARIO: TStringField
      DisplayLabel = 'Cod. orario'
      FieldName = 'ORARIO'
      Size = 5
    end
    object selTabellaDESC_ORARIO: TStringField
      DisplayLabel = 'Desc. orario'
      FieldKind = fkCalculated
      FieldName = 'DESC_ORARIO'
      Size = 40
      Calculated = True
    end
    object selTabellaTURNO1: TStringField
      DisplayLabel = 'Sigla turno 1'
      DisplayWidth = 2
      FieldName = 'TURNO1'
      Size = 2
    end
    object selTabellaTURNO2: TStringField
      DisplayLabel = 'Sigla turno 2'
      DisplayWidth = 2
      FieldName = 'TURNO2'
      Size = 2
    end
  end
end
