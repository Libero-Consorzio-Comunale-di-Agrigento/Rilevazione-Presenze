inherited WA163FTipoQuoteDM: TWA163FTipoQuoteDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T765.*,T765.ROWID FROM T765_TIPOQUOTE T765'
      ':ORDERBY'
      '')
    OnCalcFields = selT765CalcFields
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPOQUOTA: TStringField
      DisplayLabel = 'Tipo Quota'
      FieldName = 'TIPOQUOTA'
      Size = 1
    end
    object selTabellaD_TIPOQUOTA: TStringField
      DisplayLabel = ' '
      DisplayWidth = 21
      FieldKind = fkCalculated
      FieldName = 'D_TIPOQUOTA'
      Visible = False
      Size = 50
      Calculated = True
    end
    object selTabellaCAUSALE_ASSESTAMENTO: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE_ASSESTAMENTO'
      Size = 5
    end
    object selTabellaD_CAUSALE_ASSESTAMENTO: TStringField
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_ASSESTAMENTO'
      LookupDataSet = selT305
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE_ASSESTAMENTO'
      Visible = False
      Size = 30
      Lookup = True
    end
    object selTabellaVP_INTERA: TStringField
      DisplayLabel = 'VP Intera'
      FieldName = 'VP_INTERA'
      Size = 6
    end
    object selTabellaVP_PROPORZIONATA: TStringField
      DisplayLabel = 'VP Proporzionata'
      FieldName = 'VP_PROPORZIONATA'
      Size = 6
    end
    object selTabellaVP_NETTA: TStringField
      DisplayLabel = 'VP Netta'
      FieldName = 'VP_NETTA'
      Size = 6
    end
    object selTabellaVP_NETTARISP: TStringField
      DisplayLabel = 'VP Netta + Risp'
      FieldName = 'VP_NETTARISP'
      Size = 6
    end
    object selTabellaVP_RISPARMIO: TStringField
      DisplayLabel = 'VP Risparmio'
      FieldName = 'VP_RISPARMIO'
      Size = 6
    end
    object selTabellaVP_NORISPARMIO: TStringField
      DisplayLabel = 'VP No Risparmio'
      FieldName = 'VP_NORISPARMIO'
      Size = 6
    end
    object selTabellaVP_QUANTITATIVA: TStringField
      DisplayLabel = 'VP Quantitativa'
      FieldName = 'VP_QUANTITATIVA'
      Size = 6
    end
    object selTabellaACCONTI: TStringField
      DisplayLabel = 'Acconti'
      FieldName = 'ACCONTI'
    end
    object selTabellaIMPOSTA_MESE_COMP_MAX: TStringField
      DisplayLabel = 'Imposta mese comp. max'
      FieldName = 'IMPOSTA_MESE_COMP_MAX'
      Visible = False
      Size = 1
    end
    object selTabellaRIF_SALDO_ANNO_CORR: TStringField
      DisplayLabel = 'Rif. saldo ore anno corrente'
      FieldName = 'RIF_SALDO_ANNO_CORR'
      Visible = False
      Size = 1
    end
    object selTabellaGIORNI_MESE: TFloatField
      DisplayLabel = 'Divisore giorni del mese'
      FieldName = 'GIORNI_MESE'
    end
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE '
      ' FROM T305_CAUGIUSTIF')
    Optimize = False
    Left = 280
    Top = 72
  end
end
