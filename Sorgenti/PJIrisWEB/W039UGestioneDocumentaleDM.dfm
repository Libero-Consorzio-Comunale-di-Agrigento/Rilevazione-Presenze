object W039FGestioneDocumentaleDM: TW039FGestioneDocumentaleDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 79
  Width = 312
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select :HINTT030V430'
      
        '       T960.ID, T960.DATA_CREAZIONE, T960.NOME_UTENTE, T960.UTEN' +
        'TE, T960.PROGRESSIVO, T960.TIPOLOGIA,'
      
        '       T960.UFFICIO, T960.NOME_FILE, T960.EXT_FILE, T960.DIMENSI' +
        'ONE, T960.PERIODO_DAL, T960.PERIODO_AL, T960.NOTE, '
      
        '       T960.DATA_ACCESSO, T960.UTENTE_ACCESSO, T960.ACCESSO_RESP' +
        'ONSABILE, T960.DATA_LETTURA_PROGRESSIVO, T960.PATH_STORAGE, T960' +
        '.PROVENIENZA,'
      
        '       cast(null as varchar2(200)) D_CARTELLA_FILE, T960.CF_FAMI' +
        'LIARE, T960.HASH, T960.VERSIONE, T960.ROWID,'
      '       T030.MATRICOLA,'
      '       T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO,'
      '       I060.MATRICOLA WEB_MATRICOLA,'
      
        '       I060F_NOMINATIVO(:AZIENDA,I060.NOME_UTENTE) WEB_NOMINATIV' +
        'O,'
      '       T962.DESCRIZIONE D_TIPOLOGIA,'
      '       T963.DESCRIZIONE D_UFFICIO,'
      '       T960.AUTOCERTIFICAZIONE, '
      '       T960.DATA_RILASCIO, '
      '       T960.DATA_RICHIESTA_ENTE, '
      '       T960.DATA_RICEZIONE_ENTE,'
      '       T960.DATA_NOTIFICA'
      'from   T960_DOCUMENTI_INFO T960,'
      '       MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T962_TIPO_DOCUMENTI T962,'
      '       T963_UFFICIO_DOCUMENTI T963,'
      '      :QVISTAORACLE'
      'and    T960.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T960.NOME_FILE is not null'
      'and    I060.AZIENDA (+) = :AZIENDA'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO'
      'and    T960.ACCESSO_PORTALE = '#39'S'#39
      
        'and    (T960.ID_RICHIESTA is null or exists (select '#39'X'#39' from T85' +
        '0_ITER_RICHIESTE T850 where T850.ID = T960.ID_RICHIESTA and T850' +
        '.STATO = '#39'S'#39'))'
      'and    not exists '
      '('
      '       SELECT '#39'x'#39' FROM T960_DOCUMENTI_INFO T960B'
      '       WHERE T960B.PROGRESSIVO = T960.PROGRESSIVO '
      '       AND T960B.NOME_FILE = T960.NOME_FILE '
      '       AND T960B.EXT_FILE = T960.EXT_FILE '
      '       AND T960B.TIPOLOGIA = T960.TIPOLOGIA'
      '       AND T960B.VERSIONE > T960.VERSIONE '
      ')'
      ':FILTRO_ANAG'
      ':FILTRO_DOCUMENTI'
      
        'order by NOMINATIVO, T030.MATRICOLA, decode(T960.DATA_LETTURA_PR' +
        'OGRESSIVO,null,0,1), D_TIPOLOGIA, D_UFFICIO, T960.PERIODO_DAL DE' +
        'SC, T960.NOME_FILE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000060000001A0000003A00480049004E00540054003000330030005600
      340033003000010000000000000000000000220000003A00460049004C005400
      52004F005F0044004F00430055004D0045004E00540049000100000000000000
      00000000100000003A0041005A00490045004E00440041000500000000000000
      000000001A0000003A005100560049005300540041004F005200410043004C00
      4500010000000000000000000000180000003A00460049004C00540052004F00
      5F0041004E0041004700010000000000000000000000160000003A0044004100
      540041004C00410056004F0052004F000C0000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T960_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    UpdatingTable = 'T960_DOCUMENTI_INFO'
    AfterScroll = selT960AfterScroll
    OnCalcFields = selT960CalcFields
    Left = 32
    Top = 16
    object selT960NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 20
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT960MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT960D_NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_NOME_FILE'
      Size = 230
      Calculated = True
    end
    object selT960D_DIMENSIONE: TStringField
      DisplayLabel = 'Dimensione'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_DIMENSIONE'
      Size = 50
      Calculated = True
    end
    object selT960PERIODO_DAL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Inizio periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960PERIODO_AL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Fine periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960CF_FAMILIARE: TStringField
      DisplayLabel = 'CF Familiare'
      FieldName = 'CF_FAMILIARE'
      Size = 16
    end
    object selT960D_TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 30
      FieldName = 'D_TIPOLOGIA'
      Size = 80
    end
    object selT960D_UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 25
      FieldName = 'D_UFFICIO'
      ReadOnly = True
      Size = 80
    end
    object selT960ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Visualizzabile dai resp.'
      FieldName = 'ACCESSO_RESPONSABILE'
      Size = 1
    end
    object selT960NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data lettura'
      DisplayWidth = 18
      FieldName = 'DATA_LETTURA_PROGRESSIVO'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy hh.mm.ss'
    end
    object selT960D_DATI_ACCESSO: TStringField
      DisplayLabel = 'Accesso amministratori'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_DATI_ACCESSO'
      Size = 60
      Calculated = True
    end
    object selT960D_PROPRIETARIO: TStringField
      DisplayLabel = 'Utente creazione'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_PROPRIETARIO'
      Size = 120
      Calculated = True
    end
    object selT960DATA_CREAZIONE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data creazione'
      DisplayWidth = 18
      FieldName = 'DATA_CREAZIONE'
      DisplayFormat = 'dd/mm/yyyy hh.nn.ss'
      EditMask = '!00/00/0000 09:00:00;1;_'
    end
    object selT960ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT960TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 10
      FieldName = 'TIPOLOGIA'
      Visible = False
    end
    object selT960DIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      FieldName = 'DIMENSIONE'
      Visible = False
    end
    object selT960UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 10
      FieldName = 'UFFICIO'
      ReadOnly = True
      Visible = False
    end
    object selT960UTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
      Visible = False
      Size = 30
    end
    object selT960NOME_UTENTE: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'NOME_UTENTE'
      Visible = False
      Size = 30
    end
    object selT960PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT960NOME_FILE: TStringField
      DisplayLabel = 'Nome file'
      FieldName = 'NOME_FILE'
      Visible = False
      Size = 200
    end
    object selT960EXT_FILE: TStringField
      DisplayLabel = 'Estensione file'
      FieldName = 'EXT_FILE'
      Visible = False
    end
    object selT960WEB_MATRICOLA: TStringField
      DisplayLabel = 'Matricola utente web'
      FieldName = 'WEB_MATRICOLA'
      Visible = False
      Size = 8
    end
    object selT960WEB_NOMINATIVO: TStringField
      FieldName = 'WEB_NOMINATIVO'
      Visible = False
      Size = 65
    end
    object selT960D_CARTELLA_FILE: TStringField
      FieldName = 'D_CARTELLA_FILE'
      Visible = False
      Size = 200
    end
    object selT960DATA_ACCESSO: TDateTimeField
      FieldName = 'DATA_ACCESSO'
      Visible = False
    end
    object selT960UTENTE_ACCESSO: TStringField
      FieldName = 'UTENTE_ACCESSO'
      Visible = False
      Size = 30
    end
    object selT960D_ACCESSO_RESPONSABILE: TStringField
      DisplayLabel = 'Visualizzabile dai responsabili'
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_RESPONSABILE'
      Visible = False
      Size = 2
      Calculated = True
    end
    object selT960AUTOCERTIFICAZIONE: TStringField
      DisplayLabel = 'Autocertificazione'
      FieldName = 'AUTOCERTIFICAZIONE'
      Size = 1
    end
    object selT960D_AUTOCERTIFICAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTOCERTIFICAZIONE'
      Visible = False
      Size = 2
      Calculated = True
    end
    object selT960DATA_RILASCIO: TDateTimeField
      DisplayLabel = 'Data rilascio'
      FieldName = 'DATA_RILASCIO'
    end
    object selT960DATA_RICHIESTA_ENTE: TDateTimeField
      FieldName = 'DATA_RICHIESTA_ENTE'
      Visible = False
    end
    object selT960DATA_RICEZIONE_ENTE: TDateTimeField
      FieldName = 'DATA_RICEZIONE_ENTE'
      Visible = False
    end
    object selT960PATH_STORAGE: TStringField
      DisplayLabel = 'Storage'
      DisplayWidth = 50
      FieldName = 'PATH_STORAGE'
      Visible = False
      Size = 1000
    end
    object selT960PROVENIENZA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Provenienza'
      FieldName = 'PROVENIENZA'
      Visible = False
      Size = 1
    end
    object selT960DATA_NOTIFICA: TDateTimeField
      DisplayLabel = 'Data notifica'
      DisplayWidth = 10
      FieldName = 'DATA_NOTIFICA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT960HASH: TStringField
      DisplayLabel = 'Hash'
      FieldName = 'HASH'
      Visible = False
      Size = 100
    end
    object selT960VERSIONE: TFloatField
      FieldName = 'VERSIONE'
      Visible = False
    end
  end
end
