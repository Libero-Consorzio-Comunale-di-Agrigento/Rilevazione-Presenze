inherited A204FModelliCertificazioneDtM: TA204FModelliCertificazioneDtM
  OldCreateOrder = True
  object selSG235: TOracleDataSet
    SQL.Strings = (
      'select '
      
        '       SG235.ID, SG235.CODICE, SG235.DESCRIZIONE, SG235.AUTOCERT' +
        'IFICAZIONE, SG235.PERIODO, SG235.UM, SG235.QUANTITA,'
      
        '       SG235.SELEZIONE_ANAGRAFE, SG235.INIZIO_VALIDITA INIZIO_VA' +
        'LIDITA, SG235.FINE_VALIDITA FINE_VALIDITA,'
      '       SG235.PERIODO_MODIFICABILE, SG235.ORDINE,'
      '       SG235.ROWID'
      'from '
      '       SG235_MODELLI_CERTIFICAZIONI SG235'
      'order by '
      '       SG235.CODICE')
    ReadBuffer = 10
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = selSG235BeforePost
    AfterScroll = selSG235AfterScroll
    Left = 32
    Top = 16
    object selSG235ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selSG235CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 12
      FieldName = 'CODICE'
      Size = 10
    end
    object selSG235DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 2000
    end
    object selSG235AUTOCERTIFICAZIONE: TStringField
      DisplayLabel = 'Autocert.'
      DisplayWidth = 7
      FieldName = 'AUTOCERTIFICAZIONE'
      Size = 1
    end
    object selSG235PERIODO: TStringField
      DisplayLabel = 'Periodo'
      DisplayWidth = 50
      FieldName = 'PERIODO'
      Size = 2000
    end
    object selSG235UM: TStringField
      DisplayWidth = 6
      FieldName = 'UM'
      Size = 1
    end
    object selSG235QUANTITA: TIntegerField
      DisplayLabel = 'Quantit'#224
      DisplayWidth = 6
      FieldName = 'QUANTITA'
    end
    object selSG235SELEZIONE_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      DisplayWidth = 50
      FieldName = 'SELEZIONE_ANAGRAFE'
      Size = 2000
    end
    object selSG235INIZIO_VALIDITA: TDateTimeField
      DisplayLabel = 'Inizio validit'#224
      FieldName = 'INIZIO_VALIDITA'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selSG235FINE_VALIDITA: TDateTimeField
      DisplayLabel = 'Fine validit'#224
      FieldName = 'FINE_VALIDITA'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selSG235PERIODO_MODIFICABILE: TStringField
      DisplayLabel = 'Periodo modificabile'
      FieldName = 'PERIODO_MODIFICABILE'
      Size = 1
    end
    object selSG235ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
    end
  end
  object selSG236: TOracleDataSet
    SQL.Strings = (
      
        'select SG236.ID, SG236.CODICE, SG236.DESCRIZIONE, SG236.ORDINE, ' +
        'SG236.ROWID'
      'from SG236_CATEGORIE_CERTIFICAZIONI SG236'
      'where SG236.ID = :ID'
      'order by SG236.ORDINE, SG236.CODICE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400040000000000000000000000}
    OracleDictionary.DefaultValues = True
    BeforePost = selSG236BeforePost
    AfterScroll = selSG236AfterScroll
    OnNewRecord = selSG236NewRecord
    Left = 104
    Top = 16
    object selSG236ID: TFloatField
      FieldName = 'ID'
    end
    object selSG236CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selSG236DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 35
      FieldName = 'DESCRIZIONE'
      Size = 2000
    end
    object selSG236ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      FieldName = 'ORDINE'
    end
  end
  object dsrSG236: TDataSource
    DataSet = selSG236
    Left = 104
    Top = 72
  end
  object selSG237: TOracleDataSet
    SQL.Strings = (
      'select SG237.*, SG237.ROWID'
      'from SG237_DATI_CERTIFICAZIONI SG237'
      'where SG237.ID = :ID and SG237.CATEGORIA = :CATEGORIA'
      'order by SG237.ORDINE, SG237.CODICE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000400000000000000000000001400
      00003A00430041005400450047004F0052004900410005000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    BeforePost = selSG237BeforePost
    OnNewRecord = selSG237NewRecord
    Left = 208
    Top = 16
    object selSG237ID: TFloatField
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
      Size = 2000
    end
    object selSG237ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 3
      FieldName = 'ORDINE'
      MaxValue = 9999
    end
    object selSG237OBBLIGATORIO: TStringField
      DisplayLabel = 'Obbligatorio'
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selSG237RIGHE: TIntegerField
      DisplayLabel = 'Righe'
      DisplayWidth = 2
      FieldName = 'RIGHE'
      MaxValue = 9
      MinValue = 1
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
      MaxValue = 9999
    end
    object selSG237ELENCO_FISSO: TStringField
      DisplayLabel = 'Elenco fisso'
      FieldName = 'ELENCO_FISSO'
      Size = 1
    end
    object selSG237VALORI: TStringField
      DisplayLabel = 'Valori'
      DisplayWidth = 15
      FieldName = 'VALORI'
      Size = 2000
    end
    object selSG237DATO_ANAGRAFICO: TStringField
      DisplayLabel = 'Dato anagrafico'
      DisplayWidth = 15
      FieldName = 'DATO_ANAGRAFICO'
      Size = 30
    end
    object selSG237QUERY_VALORE: TStringField
      DisplayLabel = 'Interrog. servizio'
      DisplayWidth = 15
      FieldName = 'QUERY_VALORE'
      Size = 30
    end
    object selSG237VALORE_DEFAULT: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 10
      FieldName = 'VALORE_DEFAULT'
      Size = 2000
    end
    object selSG237VALIDAZIONE: TStringField
      DisplayLabel = 'Validazione'
      DisplayWidth = 15
      FieldName = 'VALIDAZIONE'
      Size = 2000
    end
    object selSG237HINT: TStringField
      DisplayLabel = 'Suggerimenti'
      FieldName = 'HINT'
      Size = 200
    end
  end
  object dsrSG237: TDataSource
    DataSet = selSG237
    Left = 208
    Top = 72
  end
end
