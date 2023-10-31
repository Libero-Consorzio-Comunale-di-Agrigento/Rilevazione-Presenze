inherited A154FGestioneDocumentaleDtM: TA154FGestioneDocumentaleDtM
  OldCreateOrder = True
  Height = 81
  Width = 129
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select T960.*,T960.ROWID,'
      '       decode(T960.PATH_STORAGE,'#39'DB'#39','#39'D'#39','#39'F'#39') D_PATH_STORAGE, '
      '       cast(null as varchar2(200)) D_CARTELLA_FILE, '
      '       I060.MATRICOLA WEB_MATRICOLA,'
      
        '       I060F_NOMINATIVO(:AZIENDA,I060.NOME_UTENTE) WEB_NOMINATIV' +
        'O,'
      '       T962.DESCRIZIONE D_TIPOLOGIA,'
      '       T963.DESCRIZIONE D_UFFICIO'
      'from   T960_DOCUMENTI_INFO T960,'
      '       MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T962_TIPO_DOCUMENTI T962,'
      '       T963_UFFICIO_DOCUMENTI T963'
      'where  T960.PROGRESSIVO = :PROGRESSIVO'
      'and    I060.AZIENDA (+) = :AZIENDA'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO'
      
        'order by decode(T960.DATA_LETTURA_PROGRESSIVO,null,0,1), D_TIPOL' +
        'OGIA, D_UFFICIO, T960.PERIODO_DAL DESC, T960.NOME_FILE, T960.VER' +
        'SIONE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0041005A00490045004E00
      44004100050000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T960_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT960AfterScroll
    OnCalcFields = selT960CalcFields
    OnNewRecord = OnNewRecord
    BeforeRefresh = selT960BeforeRefresh
    AfterRefresh = selT960AfterRefresh
    Left = 24
    Top = 16
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
      DisplayLabel = 'Inizio periodo'
      DisplayWidth = 10
      FieldName = 'PERIODO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960PERIODO_AL: TDateTimeField
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
      DisplayWidth = 20
      FieldName = 'D_TIPOLOGIA'
      Size = 80
    end
    object selT960D_UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 20
      FieldName = 'D_UFFICIO'
      Size = 80
    end
    object selT960AUTOCERTIFICAZIONE: TStringField
      DisplayLabel = 'Autocertificazione'
      FieldName = 'AUTOCERTIFICAZIONE'
      Size = 1
    end
    object selT960D_ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Vis. resp.'
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_RESPONSABILE'
      Size = 2
      Calculated = True
    end
    object selT960NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField
      DisplayLabel = 'Data lettura'
      FieldName = 'DATA_LETTURA_PROGRESSIVO'
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
    object selT960DATA_NOTIFICA: TDateTimeField
      DisplayLabel = 'Data notifica'
      FieldName = 'DATA_NOTIFICA'
    end
    object selT960ID: TFloatField
      FieldName = 'ID'
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
    object selT960TIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia'
      DisplayWidth = 10
      FieldName = 'TIPOLOGIA'
      Visible = False
    end
    object selT960UFFICIO: TStringField
      DisplayLabel = 'Ufficio'
      DisplayWidth = 10
      FieldName = 'UFFICIO'
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
    object selT960DIMENSIONE: TFloatField
      DisplayLabel = 'Dimensione'
      FieldName = 'DIMENSIONE'
      Visible = False
    end
    object selT960ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Visualizzabile dai responsabili'
      FieldName = 'ACCESSO_RESPONSABILE'
      Visible = False
      Size = 1
    end
    object selT960D_CARTELLA_FILE: TStringField
      DisplayLabel = 'Cartella file'
      DisplayWidth = 40
      FieldKind = fkInternalCalc
      FieldName = 'D_CARTELLA_FILE'
      Visible = False
      Size = 200
    end
    object selT960WEB_MATRICOLA: TStringField
      DisplayLabel = 'Matricola utente web'
      FieldName = 'WEB_MATRICOLA'
      Visible = False
      Size = 8
    end
    object selT960WEB_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo utente web'
      FieldName = 'WEB_NOMINATIVO'
      Visible = False
      Size = 100
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
    object selT960DATA_RILASCIO: TDateTimeField
      DisplayLabel = 'Data rilascio'
      DisplayWidth = 10
      FieldName = 'DATA_RILASCIO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '99/!99/0000;1;_'
    end
    object selT960RICHIEDERE_ENTE: TStringField
      FieldName = 'RICHIEDERE_ENTE'
      Size = 1
    end
    object selT960DATA_RICHIESTA_ENTE: TDateTimeField
      FieldName = 'DATA_RICHIESTA_ENTE'
      EditMask = '99/!99/0000;1;_'
    end
    object selT960DATA_RICEZIONE_ENTE: TDateTimeField
      FieldName = 'DATA_RICEZIONE_ENTE'
      EditMask = '99/!99/0000;1;_'
    end
    object selT960PATH_STORAGE: TStringField
      FieldName = 'PATH_STORAGE'
      Size = 1000
    end
    object selT960D_PATH_STORAGE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'D_PATH_STORAGE'
      Size = 1
    end
    object selT960ACCESSO_PORTALE: TStringField
      FieldName = 'ACCESSO_PORTALE'
      Visible = False
      Size = 1
    end
    object selT960D_ACCESSO_PORTALE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Vis. IrisWeb'
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_PORTALE'
      Size = 2
      Calculated = True
    end
    object selT960PROVENIENZA: TStringField
      FieldName = 'PROVENIENZA'
      Size = 1
    end
    object selT960VERSIONE: TFloatField
      DisplayLabel = 'Versione'
      DisplayWidth = 7
      FieldName = 'VERSIONE'
    end
    object selT960HASH: TStringField
      DisplayLabel = 'Hash'
      FieldName = 'HASH'
      Size = 100
    end
  end
end
