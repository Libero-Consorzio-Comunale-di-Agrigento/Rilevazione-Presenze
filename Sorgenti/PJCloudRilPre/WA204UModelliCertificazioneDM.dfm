inherited WA204FModelliCertificazioneDM: TWA204FModelliCertificazioneDM
  Height = 280
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '       SG235.ID, SG235.CODICE, SG235.DESCRIZIONE, SG235.AUTOCERT' +
        'IFICAZIONE, SG235.PERIODO, SG235.UM, SG235.QUANTITA,'
      
        '       SG235.SELEZIONE_ANAGRAFE, SG235.INIZIO_VALIDITA INIZIO_VA' +
        'LIDITA, SG235.FINE_VALIDITA FINE_VALIDITA,'
      '       SG235.PERIODO_MODIFICABILE,'
      '       SG235.ROWID'
      'from '
      '       SG235_MODELLI_CERTIFICAZIONI SG235'
      'order by '
      '       SG235.CODICE')
    object selTabellaID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 2000
    end
    object selTabellaINIZIO_VALIDITA: TDateTimeField
      DisplayLabel = 'Inizio validit'#224
      FieldName = 'INIZIO_VALIDITA'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selTabellaFINE_VALIDITA: TDateTimeField
      DisplayLabel = 'Fine validit'#224
      FieldName = 'FINE_VALIDITA'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selTabellaAUTOCERTIFICAZIONE: TStringField
      DisplayLabel = 'Autocert.'
      FieldName = 'AUTOCERTIFICAZIONE'
      Size = 1
    end
    object selTabellaPERIODO: TStringField
      DisplayLabel = 'Periodo'
      FieldName = 'PERIODO'
      Size = 2000
    end
    object selTabellaPERIODO_MODIFICABILE: TStringField
      DisplayLabel = 'Periodo modificabile'
      FieldName = 'PERIODO_MODIFICABILE'
      Size = 1
    end
    object selTabellaUM: TStringField
      FieldName = 'UM'
      Size = 1
    end
    object selTabellaQUANTITA: TIntegerField
      DisplayLabel = 'Quantit'#224
      FieldName = 'QUANTITA'
    end
    object selTabellaSELEZIONE_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'SELEZIONE_ANAGRAFE'
      Size = 2000
    end
  end
  object dsrSG236: TDataSource
    DataSet = selSG236
    Left = 32
    Top = 200
  end
  object selSG236: TOracleDataSet
    SQL.Strings = (
      
        'select SG236.ID, SG236.CODICE, SG236.DESCRIZIONE, SG236.ORDINE, ' +
        'SG236.ROWID'
      'from SG236_CATEGORIE_CERTIFICAZIONI SG236'
      'where SG236.ID = :ID'
      'order by SG236.ORDINE, SG236.CODICE')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400040000000000000000000000}
    OracleDictionary.DefaultValues = True
    OracleDictionary.FieldKinds = True
    AfterOpen = selSG236AfterOpen
    BeforePost = selSG236BeforePost
    AfterScroll = selSG236AfterScroll
    OnCalcFields = selSG236CalcFields
    OnNewRecord = selSG236NewRecord
    Left = 32
    Top = 152
    object selSG236ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selSG236CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selSG236DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 2000
    end
    object selSG236DESCRIZIONE_CALC: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCRIZIONE_CALC'
      Size = 2000
      Calculated = True
    end
    object selSG236ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
    end
  end
  object dsrSG237: TDataSource
    DataSet = selSG237
    Left = 136
    Top = 208
  end
  object selSG237: TOracleDataSet
    SQL.Strings = (
      'select SG237.*, SG237.ROWID'
      'from SG237_DATI_CERTIFICAZIONI SG237'
      'where SG237.ID = :ID and SG237.CATEGORIA = :CATEGORIA'
      'order by SG237.ORDINE, SG237.CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000400000000000000000000001400
      00003A00430041005400450047004F0052004900410005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    OracleDictionary.FieldKinds = True
    BeforePost = selSG237BeforePost
    OnCalcFields = selSG237CalcFields
    OnNewRecord = selSG237NewRecord
    Left = 136
    Top = 160
    object selSG237ID: TFloatField
      DisplayLabel = 'Id'
      FieldName = 'ID'
      Visible = False
    end
    object selSG237CATEGORIA: TStringField
      DisplayLabel = 'Categoria'
      FieldName = 'CATEGORIA'
      Visible = False
      Size = 10
    end
    object selSG237CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selSG237DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 35
      FieldName = 'DESCRIZIONE'
      Visible = False
      Size = 2000
    end
    object selSG237DESCRIZIONE_CALC: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'DESCRIZIONE_CALC'
      Size = 2000
      Calculated = True
    end
    object selSG237HINT: TStringField
      DisplayLabel = 'Suggerimenti'
      DisplayWidth = 15
      FieldName = 'HINT'
      Visible = False
      Size = 200
    end
    object selSG237HINT_CALC: TStringField
      DisplayLabel = 'Suggerimenti'
      FieldKind = fkCalculated
      FieldName = 'HINT_CALC'
      Size = 200
      Calculated = True
    end
    object selSG237ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORDINE'
    end
    object selSG237OBBLIGATORIO: TStringField
      DisplayLabel = 'Obbligatorio'
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selSG237FORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Size = 1
    end
    object selSG237LUNG_MAX: TIntegerField
      DisplayLabel = 'Lung. max'
      DisplayWidth = 4
      FieldName = 'LUNG_MAX'
    end
    object selSG237RIGHE: TIntegerField
      DisplayLabel = 'Righe'
      DisplayWidth = 2
      FieldName = 'RIGHE'
    end
    object selSG237VALORI: TStringField
      DisplayLabel = 'Valori'
      DisplayWidth = 15
      FieldName = 'VALORI'
      Visible = False
      Size = 2000
    end
    object selSG237VALORI_CALC: TStringField
      DisplayLabel = 'Valori'
      FieldKind = fkCalculated
      FieldName = 'VALORI_CALC'
      Size = 2000
      Calculated = True
    end
    object selSG237DATO_ANAGRAFICO: TStringField
      DisplayLabel = 'Dato anagrafico'
      DisplayWidth = 15
      FieldName = 'DATO_ANAGRAFICO'
      Size = 2000
    end
    object selSG237QUERY_VALORE: TStringField
      DisplayLabel = 'Interrog. servizio'
      DisplayWidth = 15
      FieldName = 'QUERY_VALORE'
      Size = 2000
    end
    object selSG237VALORE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 10
      FieldName = 'VALORE_DEFAULT'
      Size = 2000
    end
    object selSG237ELENCO_FISSO: TStringField
      DisplayLabel = 'Elenco fisso'
      FieldName = 'ELENCO_FISSO'
      Size = 1
    end
    object selSG237VALIDAZIONE: TStringField
      DisplayLabel = 'Validazione'
      DisplayWidth = 15
      FieldName = 'VALIDAZIONE'
      Visible = False
      Size = 2000
    end
    object selSG237VALIDAZIONE_CALC: TStringField
      DisplayLabel = 'Validazione'
      FieldKind = fkCalculated
      FieldName = 'VALIDAZIONE_CALC'
      Size = 2000
      Calculated = True
    end
  end
end
