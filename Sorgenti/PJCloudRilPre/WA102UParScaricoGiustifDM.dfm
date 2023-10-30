inherited WA102FParScaricoGiustifDM: TWA102FParScaricoGiustifDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I150.*,I150.ROWID '
      '  FROM MONDOEDP.I150_PARSCARICOGIUST I150 '
      ':ORDERBY')
    AfterPost = AfterPost
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
    end
    object selTabellaNOMEFILE: TStringField
      DisplayLabel = 'Nome file'
      FieldName = 'NOMEFILE'
      Required = True
      Size = 100
    end
    object selTabellaCORRENTE: TStringField
      DisplayLabel = 'Scarico automatico'
      FieldName = 'CORRENTE'
      Required = True
      Size = 1
    end
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Visible = False
      Size = 80
    end
    object selTabellaBADGE: TStringField
      DisplayLabel = 'Badge'
      FieldName = 'BADGE'
      Visible = False
      Size = 80
    end
    object selTabellaANNODA: TStringField
      DisplayLabel = 'Anno da'
      FieldName = 'ANNODA'
      Visible = False
      Size = 80
    end
    object selTabellaMESEDA: TStringField
      DisplayLabel = 'Mese da'
      FieldName = 'MESEDA'
      Visible = False
      Size = 80
    end
    object selTabellaGIORNODA: TStringField
      DisplayLabel = 'Giorno da'
      FieldName = 'GIORNODA'
      Visible = False
      Size = 80
    end
    object selTabellaANNOA: TStringField
      DisplayLabel = 'Anno a'
      FieldName = 'ANNOA'
      Visible = False
      Size = 80
    end
    object selTabellaMESEA: TStringField
      DisplayLabel = 'Mese a'
      FieldName = 'MESEA'
      Visible = False
      Size = 80
    end
    object selTabellaGIORNOA: TStringField
      DisplayLabel = 'Giorno a'
      FieldName = 'GIORNOA'
      Visible = False
      Size = 80
    end
    object selTabellaORADA: TStringField
      DisplayLabel = 'Ora da'
      FieldName = 'ORADA'
      Visible = False
      Size = 80
    end
    object selTabellaMINDA: TStringField
      DisplayLabel = 'Minuti da'
      FieldName = 'MINDA'
      Visible = False
      Size = 80
    end
    object selTabellaORAA: TStringField
      DisplayLabel = 'Ora a'
      FieldName = 'ORAA'
      Visible = False
      Size = 80
    end
    object selTabellaMINA: TStringField
      DisplayLabel = 'Minuti a'
      FieldName = 'MINA'
      Visible = False
      Size = 80
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Visible = False
      Size = 80
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 80
    end
    object selTabellaDATADA: TStringField
      DisplayLabel = 'Data da'
      FieldName = 'DATADA'
      Visible = False
      Size = 80
    end
    object selTabellaNUMGIORNI: TStringField
      DisplayLabel = 'Num.gg.'
      FieldName = 'NUMGIORNI'
      Visible = False
      Size = 80
    end
    object selTabellaCODICE_TIPOI: TStringField
      FieldName = 'CODICE_TIPOI'
      Visible = False
      Size = 5
    end
    object selTabellaCODICE_TIPOM: TStringField
      FieldName = 'CODICE_TIPOM'
      Visible = False
      Size = 5
    end
    object selTabellaCODICE_TIPOD: TStringField
      FieldName = 'CODICE_TIPOD'
      Visible = False
      Size = 5
    end
    object selTabellaCODICE_TIPON: TStringField
      FieldName = 'CODICE_TIPON'
      Visible = False
      Size = 5
    end
    object selTabellaSEPARATORE: TStringField
      FieldName = 'SEPARATORE'
      Visible = False
      Size = 1
    end
    object selTabellaFORMATODATA: TStringField
      FieldName = 'FORMATODATA'
      Visible = False
      Size = 30
    end
    object selTabellaDESCCAUSALE: TStringField
      FieldName = 'DESCCAUSALE'
      Visible = False
      Size = 1
    end
    object selTabellaAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      FieldName = 'AZIENDA'
      Size = 30
    end
    object selTabellaMATRICOLA_NUMERICA: TStringField
      FieldName = 'MATRICOLA_NUMERICA'
      Visible = False
      Size = 1
    end
    object selTabellaTIPOFILE: TStringField
      DisplayLabel = 'Tipo file'
      FieldName = 'TIPOFILE'
      Size = 1
    end
    object selTabellaID: TStringField
      DisplayLabel = 'Id'
      FieldName = 'ID'
      Visible = False
      Size = 80
    end
    object selTabellaDATAA: TStringField
      DisplayLabel = 'Data a'
      FieldName = 'DATAA'
      Visible = False
      Size = 80
    end
    object selTabellaTIPO_OPERAZIONE: TStringField
      DisplayLabel = 'Tipo operaz.'
      FieldName = 'TIPO_OPERAZIONE'
      Visible = False
      Size = 80
    end
    object selTabellaFAMILIARE: TStringField
      DisplayLabel = 'Familiare'
      FieldName = 'FAMILIARE'
      Visible = False
      Size = 80
    end
    object selTabellaMESSAGGIO: TStringField
      DisplayLabel = 'Messaggio'
      FieldName = 'MESSAGGIO'
      Visible = False
      Size = 80
    end
    object selTabellaELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'ELABORATO'
      Visible = False
      Size = 80
    end
    object selTabellaDATA_ELABORAZIONE: TStringField
      DisplayLabel = 'Data elab.'
      FieldName = 'DATA_ELABORAZIONE'
      Visible = False
      Size = 80
    end
    object selTabellaHHMMDA: TStringField
      DisplayLabel = 'HHMM da'
      FieldName = 'HHMMDA'
      Visible = False
      Size = 80
    end
    object selTabellaHHMMA: TStringField
      DisplayLabel = 'HHMM a'
      FieldName = 'HHMMA'
      Visible = False
      Size = 80
    end
    object selTabellaANOMALIE_BLOCCANTI: TStringField
      FieldName = 'ANOMALIE_BLOCCANTI'
      Visible = False
      Size = 1
    end
    object selTabellaCHIAVE: TStringField
      DisplayLabel = 'Chiave'
      FieldName = 'CHIAVE'
      Visible = False
      Size = 80
    end
    object selTabellaEXPR_CHIAVE: TStringField
      DisplayLabel = 'Espressione chiave'
      FieldName = 'EXPR_CHIAVE'
      Visible = False
      Size = 2000
    end
    object selTabellaTRIGGER_BEFORE: TStringField
      FieldName = 'TRIGGER_BEFORE'
      Size = 1
    end
    object selTabellaTRIGGER_AFTER: TStringField
      FieldName = 'TRIGGER_AFTER'
      Size = 1
    end
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA '
      '  FROM MONDOEDP.I090_ENTI'
      ' WHERE AZIENDA <> '#39'AZIN'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000000E00000041005A00490045004E0044004100010000000000}
    Left = 35
    Top = 116
  end
  object dsrI090: TDataSource
    DataSet = selI090
    Left = 80
    Top = 120
  end
end
