inherited WA117FOreLiquidateAnniPrecDM: TWA117FOreLiquidateAnniPrecDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T134.*,T134.ROWID FROM T134_ORELIQUIDATEANNIPREC T134'
      'WHERE PROGRESSIVO = :Progressivo'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00080000000000000000000000}
    CommitOnPost = False
    AfterOpen = selTabellaAfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    Left = 40
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno ore residue'
      FieldName = 'ANNO'
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Mese liq.'
      DisplayWidth = 10
      FieldName = 'DATA'
    end
    object selTabellaORE_LIQUIDATE: TStringField
      DisplayLabel = 'Ore liquidate'
      FieldName = 'ORE_LIQUIDATE'
      EditMask = '!9900:00;1;_'
    end
    object selTabellaVARIAZIONE_ORE: TStringField
      DisplayLabel = 'Variazione saldo'
      FieldName = 'VARIAZIONE_ORE'
      EditMask = '!###00:00;1;_'
    end
    object selTabellaOREPERSE: TStringField
      DisplayLabel = 'Ore perse'
      FieldName = 'OREPERSE'
    end
    object selTabellaOREPERSE_TOT: TStringField
      DisplayLabel = 'Totale ore perse'
      FieldKind = fkCalculated
      FieldName = 'OREPERSE_TOT'
      ReadOnly = True
      Calculated = True
    end
    object selTabellaOREPERSE_RES: TStringField
      DisplayLabel = 'Residuo ore perse'
      FieldKind = fkCalculated
      FieldName = 'OREPERSE_RES'
      ReadOnly = True
      Calculated = True
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 30
      FieldName = 'NOTE'
      Size = 100
    end
  end
end
