inherited WA034FParametriAvanzatiDM: TWA034FParametriAvanzatiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T193.*,ROWID '
      'FROM T193_VOCIPAGHE_PARAMETRI T193 '
      'WHERE COD_INTERFACCIA = :CODICE_INTERFACCIA'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000260000003A0043004F0044004900430045005F0049004E00
      540045005200460041004300430049004100050000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    object selTabellaCOD_INTERFACCIA: TStringField
      DisplayLabel = 'Interfaccia'
      FieldName = 'COD_INTERFACCIA'
      Visible = False
    end
    object selTabellaVOCE_PAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCE_PAGHE'
      ReadOnly = True
      Size = 10
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaVOCE_PAGHE_CEDOLINO: TStringField
      DisplayLabel = 'Voce paghe cedolino'
      FieldName = 'VOCE_PAGHE_CEDOLINO'
      Size = 10
    end
    object selTabellaDESC_VPAGHE_CEDOLINO: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'DESC_VPAGHE_CEDOLINO'
      LookupDataSet = A034FParametriAvanzatiMW.selP200
      LookupKeyFields = 'COD_VOCE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'VOCE_PAGHE_CEDOLINO'
      Size = 50
      Lookup = True
    end
    object selTabellaVOCE_PAGHE_NEGATIVA: TStringField
      DisplayLabel = 'Valore Negativo'
      FieldName = 'VOCE_PAGHE_NEGATIVA'
      Size = 10
    end
    object selTabellaDESC_VPAGHE_NEGATIVA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'DESC_VPAGHE_NEGATIVA'
      LookupDataSet = A034FParametriAvanzatiMW.selP200
      LookupKeyFields = 'COD_VOCE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'VOCE_PAGHE_NEGATIVA'
      Size = 50
      Lookup = True
    end
    object selTabellaDAL: TDateTimeField
      DisplayLabel = 'Valida dal'
      FieldName = 'DAL'
      OnGetText = selTabellaDALGetText
      OnSetText = selTabellaDALSetText
    end
    object selTabellaAL: TDateTimeField
      DisplayLabel = 'Valida al'
      FieldName = 'AL'
      OnGetText = selTabellaDALGetText
      OnSetText = selTabellaDALSetText
    end
    object selTabellaAUTOINC_DAL: TStringField
      DisplayLabel = 'Inc.aut.dal'
      FieldName = 'AUTOINC_DAL'
      Visible = False
    end
    object selTabellaAUTOINC_AL: TStringField
      DisplayLabel = 'Inc.Aut.al'
      FieldName = 'AUTOINC_AL'
      Visible = False
      Size = 1
    end
    object selTabellaARROTONDAMENTO: TFloatField
      FieldName = 'ARROTONDAMENTO'
      Visible = False
    end
    object selTabellaFORMULA: TStringField
      FieldName = 'FORMULA'
      Visible = False
      Size = 200
    end
    object selTabellaSPOSTA_VALIMP: TStringField
      FieldName = 'SPOSTA_VALIMP'
      Visible = False
    end
  end
end
