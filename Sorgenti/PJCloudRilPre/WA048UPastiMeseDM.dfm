inherited WA048FPastiMeseDM: TWA048FPastiMeseDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T410.*,T410.ROWID FROM T410_PASTI T410'
      'WHERE PROGRESSIVO =:PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00050000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterDelete
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T340_TURNIREPERIB.PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO'
      Origin = 'T340_TURNIREPERIB.ANNO'
      Required = True
    end
    object selTabellaMESE: TFloatField
      DisplayLabel = 'Mese'
      DisplayWidth = 5
      FieldName = 'MESE'
      Origin = 'T340_TURNIREPERIB.MESE'
      Required = True
      MaxValue = 12.000000000000000000
      MinValue = 1.000000000000000000
    end
    object selTabellaCALCMESE: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'CALCMESE'
      ReadOnly = True
      Calculated = True
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selTabellaPASTI: TFloatField
      DisplayLabel = 'Pasti convenzionati'
      FieldName = 'PASTI'
    end
    object selTabellaPASTI2: TIntegerField
      DisplayLabel = 'Pasti interi'
      FieldName = 'PASTI2'
    end
  end
end
