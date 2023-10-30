inherited WA154FGestioneDocumentaleDM: TWA154FGestioneDocumentaleDM
  Height = 127
  Width = 392
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T960.*, T960.ROWID,'
      '       cast(null as varchar2(200)) D_CARTELLA_FILE,'
      '       I060.MATRICOLA WEB_MATRICOLA,'
      
        '       I060F_NOMINATIVO(:AZIENDA,I060.NOME_UTENTE) WEB_NOMINATIV' +
        'O,'
      '       T962.DESCRIZIONE D_TIPOLOGIA,'
      '       T963.DESCRIZIONE D_UFFICIO,'
      
        '       T960.AUTOCERTIFICAZIONE, T960.RICHIEDERE_ENTE, T960.DATA_' +
        'RICHIESTA_ENTE, T960.DATA_RICEZIONE_ENTE,       '
      '       decode(T960.PATH_STORAGE,'#39'DB'#39','#39'D'#39','#39'F'#39') D_PATH_STORAGE'
      'from   T960_DOCUMENTI_INFO T960,'
      '       MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T962_TIPO_DOCUMENTI T962,'
      '       T963_UFFICIO_DOCUMENTI T963'
      'where  T960.PROGRESSIVO = :PROGRESSIVO'
      'and    I060.AZIENDA (+) = t000f_getaziendacorrente'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO'
      ':ORDERBY')
    Variables.Data = {
      0400000003000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0041005A00490045004E00
      44004100050000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T960_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    CompressBLOBs = True
    BeforeEdit = BeforeEdit
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaD_NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_NOME_FILE'
      Size = 230
      Calculated = True
    end
    object selTabellaVERSIONE: TFloatField
      DisplayLabel = 'Versione'
      FieldName = 'VERSIONE'
    end
    object selTabellaD_DIMENSIONE: TStringField
      DisplayLabel = 'Dimensione'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_DIMENSIONE'
      Size = 50
      Calculated = True
    end
    object selTabellaPERIODO_DAL: TDateTimeField
      DisplayLabel = 'Inizio periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaPERIODO_AL: TDateTimeField
      DisplayLabel = 'Fine periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCF_FAMILIARE: TStringField
      DisplayLabel = 'CF Familiare'
      FieldName = 'CF_FAMILIARE'
      Size = 16
    end
    object selTabellaDATA_RILASCIO: TDateTimeField
      DisplayLabel = 'Data rilascio'
      DisplayWidth = 10
      FieldName = 'DATA_RILASCIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '99/!99/0000;1;_'
    end
    object selTabellaD_TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 20
      FieldName = 'D_TIPOLOGIA'
      Size = 80
    end
    object selTabellaD_UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 20
      FieldName = 'D_UFFICIO'
      Size = 80
    end
    object selTabellaAUTOCERTIFICAZIONE: TStringField
      DisplayLabel = 'Autocertificazione'
      FieldName = 'AUTOCERTIFICAZIONE'
      Size = 1
    end
    object selTabellaD_ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Vis. resp.'
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_RESPONSABILE'
      Size = 2
      Calculated = True
    end
    object selTabellaACCESSO_PORTALE: TStringField
      FieldName = 'ACCESSO_PORTALE'
      Visible = False
      Size = 1
    end
    object selTabellaD_ACCESSO_PORTALE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Vis. IrisWeb'
      DisplayWidth = 2
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_PORTALE'
      Size = 2
      Calculated = True
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object selTabellaDATA_LETTURA_PROGRESSIVO: TDateTimeField
      DisplayLabel = 'Data lettura'
      FieldName = 'DATA_LETTURA_PROGRESSIVO'
      DisplayFormat = 'dd/mm/yyyy hh.mm.ss'
    end
    object selTabellaD_DATI_ACCESSO: TStringField
      DisplayLabel = 'Accesso amministratori'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_DATI_ACCESSO'
      Size = 60
      Calculated = True
    end
    object selTabellaD_PROPRIETARIO: TStringField
      DisplayLabel = 'Utente creazione'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_PROPRIETARIO'
      Size = 120
      Calculated = True
    end
    object selTabellaDATA_CREAZIONE: TDateTimeField
      DisplayLabel = 'Data creazione'
      DisplayWidth = 18
      FieldName = 'DATA_CREAZIONE'
      DisplayFormat = 'dd/mm/yyyy hh.nn.ss'
      EditMask = '!00/00/0000 09:00:00;1;_'
    end
    object selTabellaDATA_NOTIFICA: TDateTimeField
      DisplayLabel = 'Data notifica'
      FieldName = 'DATA_NOTIFICA'
    end
    object selTabellaID: TFloatField
      FieldName = 'ID'
    end
    object selTabellaUTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
      Visible = False
      Size = 30
    end
    object selTabellaNOME_UTENTE: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'NOME_UTENTE'
      Visible = False
      Size = 30
    end
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaTIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 10
      FieldName = 'TIPOLOGIA'
      Visible = False
    end
    object selTabellaUFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 10
      FieldName = 'UFFICIO'
      Visible = False
    end
    object selTabellaNOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      FieldName = 'NOME_FILE'
      Visible = False
      Size = 200
    end
    object selTabellaEXT_FILE: TStringField
      DisplayLabel = 'Estensione file'
      FieldName = 'EXT_FILE'
      Visible = False
    end
    object selTabellaDIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      FieldName = 'DIMENSIONE'
      Visible = False
    end
    object selTabellaD_CARTELLA_FILE: TStringField
      DisplayLabel = 'Cartella file'
      DisplayWidth = 40
      FieldName = 'D_CARTELLA_FILE'
      Visible = False
      Size = 200
    end
    object selTabellaWEB_MATRICOLA: TStringField
      DisplayLabel = 'Matricola utente web'
      FieldName = 'WEB_MATRICOLA'
      Visible = False
      Size = 8
    end
    object selTabellaWEB_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo utente web'
      FieldName = 'WEB_NOMINATIVO'
      Visible = False
      Size = 100
    end
    object selTabellaACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Visualizzabile dai responsabili'
      FieldName = 'ACCESSO_RESPONSABILE'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_ACCESSO: TDateTimeField
      FieldName = 'DATA_ACCESSO'
      Visible = False
    end
    object selTabellaUTENTE_ACCESSO: TStringField
      FieldName = 'UTENTE_ACCESSO'
      Visible = False
      Size = 30
    end
    object selTabellaRICHIEDERE_ENTE: TStringField
      DisplayLabel = 'Da richiedere'
      FieldName = 'RICHIEDERE_ENTE'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_RICEHISTA_ENTE: TDateTimeField
      FieldName = 'DATA_RICHIESTA_ENTE'
      Visible = False
    end
    object selTabellaDATA_RICEZIONE_ENTE: TDateTimeField
      FieldName = 'DATA_RICEZIONE_ENTE'
      Visible = False
    end
    object selTabellaPATH_STORAGE: TStringField
      DisplayLabel = 'Registrazione'
      DisplayWidth = 10
      FieldName = 'PATH_STORAGE'
      Visible = False
      Size = 1000
    end
    object selTabellaD_PATH_STORAGE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'D_PATH_STORAGE'
      Visible = False
      Size = 1
    end
    object selTabellaPROVENIENZA: TStringField
      FieldName = 'PROVENIENZA'
      Visible = False
      Size = 1
    end
    object selTabellaHASH: TStringField
      DisplayLabel = 'Hash'
      FieldName = 'HASH'
      Size = 100
    end
  end
end
