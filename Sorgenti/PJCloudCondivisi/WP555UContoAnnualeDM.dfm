inherited WP555FContoAnnualeDM: TWP555FContoAnnualeDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT p554.*, decode(CHIUSO,'#39'S'#39','#39'Si'#39','#39'N'#39','#39'No'#39','#39#39') DESC_CHIUSO, ' +
        'p554.rowid'
      'FROM  p554_contoanntestate p554'
      ':ORDERBY')
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    object selTabellaANNO: TIntegerField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
    end
    object selTabellaCOD_TABELLA: TStringField
      DisplayLabel = 'Codice tabella'
      FieldName = 'COD_TABELLA'
    end
    object selTabellaDESC_TABELLA: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'DESC_TABELLA'
      Size = 200
      Calculated = True
    end
    object selTabellaCHIUSO: TStringField
      DisplayLabel = 'Flag chiuso'
      FieldName = 'CHIUSO'
      Visible = False
      Size = 1
    end
    object selTabellaDESC_CHIUSO: TStringField
      DisplayLabel = 'Chiuso'
      FieldKind = fkInternalCalc
      FieldName = 'DESC_CHIUSO'
      Size = 10
    end
    object selTabellaDATA_CHIUSURA: TDateTimeField
      DisplayLabel = 'Data chiusura'
      FieldName = 'DATA_CHIUSURA'
    end
    object selTabellaID_CONTOANN: TFloatField
      DisplayLabel = 'Identificativo'
      FieldName = 'ID_CONTOANN'
    end
  end
end
