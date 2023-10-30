inherited WP553FRisorseResidueContoAnnualeDM: TWP553FRisorseResidueContoAnnualeDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*,t.rowid from P553_CONTOANNRISORRES t'
      ':ORDERBY')
    object selTabellaANNO: TIntegerField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Required = True
    end
    object selTabellaMACRO_CATEG: TStringField
      DisplayLabel = 'Macro categoria'
      FieldName = 'MACRO_CATEG'
      Required = True
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaIMPORTO_RESIDUO: TFloatField
      DisplayLabel = 'Importo residuo'
      FieldName = 'IMPORTO_RESIDUO'
    end
    object selTabellaCOD_TABELLA: TStringField
      DisplayLabel = 'Codice tabella'
      FieldName = 'COD_TABELLA'
      Required = True
      Visible = False
      Size = 10
    end
    object selTabellaCOLONNA_RIGA: TIntegerField
      DisplayLabel = 'Riga / colonna'
      FieldName = 'COLONNA_RIGA'
      Required = True
      Visible = False
    end
    object selTabellaCOD_TABELLA_QUOTE: TStringField
      DisplayLabel = 'Codice tabella quote'
      FieldName = 'COD_TABELLA_QUOTE'
      Visible = False
      Size = 10
    end
    object selTabellaCOLONNA_QUOTE: TIntegerField
      DisplayLabel = 'Colonna quote'
      FieldName = 'COLONNA_QUOTE'
      Visible = False
    end
  end
end
