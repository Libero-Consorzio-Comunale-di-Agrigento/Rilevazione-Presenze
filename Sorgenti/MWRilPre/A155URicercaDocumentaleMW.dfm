inherited A155FRicercaDocumentaleMW: TA155FRicercaDocumentaleMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 135
  Width = 447
  object selT960ExtFile: TOracleDataSet
    SQL.Strings = (
      'select distinct lower(EXT_FILE) EXT_FILE'
      'from   T960_DOCUMENTI_INFO T960'
      'where  T960.TIPOLOGIA <> '#39'MEDP_INPS'#39
      'order by 1')
    ReadBuffer = 40
    Optimize = False
    ReadOnly = True
    Left = 32
    Top = 73
  end
  object selT960: TOracleDataSet
    SQL.Strings = (
      'select :HINTT030V430'
      
        '       T960.ID, T960.DATA_CREAZIONE, T960.NOME_UTENTE, T960.UTEN' +
        'TE, T960.PROGRESSIVO, T960.TIPOLOGIA,'
      
        '       T960.UFFICIO, T960.NOME_FILE, T960.EXT_FILE, T960.DIMENSI' +
        'ONE, T960.PERIODO_DAL, T960.PERIODO_AL, T960.DATA_RILASCIO, T960' +
        '.NOTE, '
      
        '       T960.DATA_ACCESSO, T960.UTENTE_ACCESSO, T960.ACCESSO_RESP' +
        'ONSABILE, T960.DATA_LETTURA_PROGRESSIVO, T960.CF_FAMILIARE, T960' +
        '.HASH, T960.VERSIONE,'
      '       T030.MATRICOLA,'
      '       T030.COGNOME || '#39' '#39' || T030.NOME NOMINATIVO,'
      '       I060.MATRICOLA WEB_MATRICOLA,'
      
        '       I060F_NOMINATIVO(:AZIENDA,I060.NOME_UTENTE) WEB_NOMINATIV' +
        'O,'
      '       T962.DESCRIZIONE D_TIPOLOGIA,'
      '       T963.DESCRIZIONE D_UFFICIO'
      'from   T960_DOCUMENTI_INFO T960,'
      '       MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T962_TIPO_DOCUMENTI T962,'
      '       T963_UFFICIO_DOCUMENTI T963,'
      '       :C700SELANAGRAFE'
      'and    T960.PROGRESSIVO = T030.PROGRESSIVO'
      'and    I060.AZIENDA (+) = :AZIENDA'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO'
      ':FILTRO_DOCUMENTI'
      
        'order by NOMINATIVO, T030.MATRICOLA, decode(T960.DATA_LETTURA_PR' +
        'OGRESSIVO,null,0,1), D_TIPOLOGIA, D_UFFICIO, T960.PERIODO_DAL DE' +
        'SC, T960.NOME_FILE, T960.VERSIONE ')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000040000001A0000003A00480049004E00540054003000330030005600
      340033003000010000000000000000000000200000003A004300370030003000
      530045004C0041004E0041004700520041004600450001000000000000000000
      0000220000003A00460049004C00540052004F005F0044004F00430055004D00
      45004E0054004900010000000000000000000000100000003A0041005A004900
      45004E0044004100050000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    ReadOnly = True
    UpdatingTable = 'T960_DOCUMENTI_INFO'
    OnCalcFields = selT960CalcFields
    BeforeRefresh = selT960BeforeRefresh
    AfterRefresh = selT960AfterRefresh
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
    object selT960VERSIONE: TFloatField
      DisplayLabel = 'Versione'
      FieldName = 'VERSIONE'
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
    object selT960DATA_RILASCIO: TDateTimeField
      DisplayLabel = 'Data rilascio'
      DisplayWidth = 10
      FieldName = 'DATA_RILASCIO'
      DisplayFormat = 'dd/mm/yyy'
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
      Size = 80
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
      Alignment = taCenter
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
    object selT960ID: TFloatField
      FieldName = 'ID'
    end
    object selT960ACCESSO_RESPONSABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Visualizzabile dai responsabili'
      FieldName = 'ACCESSO_RESPONSABILE'
      Visible = False
      Size = 1
    end
    object selT960DATA_ACCESSO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data accesso'
      DisplayWidth = 18
      FieldName = 'DATA_ACCESSO'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy hh.nn.ss'
    end
    object selT960UTENTE_ACCESSO: TStringField
      DisplayLabel = 'Utente accesso'
      DisplayWidth = 15
      FieldName = 'UTENTE_ACCESSO'
      Visible = False
      Size = 30
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
    object selT960HASH: TStringField
      DisplayLabel = 'Hash'
      DisplayWidth = 100
      FieldName = 'HASH'
      Size = 100
    end
  end
  object selT960Tipologie: TOracleDataSet
    SQL.Strings = (
      'select T962.CODICE, T962.DESCRIZIONE'
      'from   T962_TIPO_DOCUMENTI T962'
      'where  exists (select '#39'x'#39'  '
      '               from   T960_DOCUMENTI_INFO T960'
      '               where  T962.CODICE = T960.TIPOLOGIA)'
      'and    T962.CODICE not in ('#39'MEDP_INPS'#39', '#39'MEDP_SEPA'#39')'
      
        'order by ORDINE, decode(T962.CODICE,'#39'*'#39','#39'*'#39',T962.DESCRIZIONE) AS' +
        'C')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 116
    Top = 73
  end
  object selT960Uffici: TOracleDataSet
    SQL.Strings = (
      'select T963.CODICE, T963.DESCRIZIONE'
      'from   T963_UFFICIO_DOCUMENTI T963'
      'where  exists (select '#39'x'#39'  '
      '               from   T960_DOCUMENTI_INFO T960'
      '               where  T960.TIPOLOGIA <> '#39'MEDP_INPS'#39
      '               and    T960.UFFICIO = T963.CODICE)'
      'order by decode(T963.CODICE,'#39'*'#39','#39'*'#39',T963.DESCRIZIONE)')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 195
    Top = 73
  end
  object selT960Operatori: TOracleDataSet
    SQL.Strings = (
      'select I070.UTENTE'
      'from   MONDOEDP.I070_UTENTI I070'
      'where  I070.AZIENDA = t000f_getaziendacorrente'
      'and    exists (select '#39'x'#39
      '               from   T960_DOCUMENTI_INFO T960'
      '               where T960.UTENTE = I070.UTENTE'
      '               and T960.TIPOLOGIA <> '#39'MEDP_INPS'#39')'
      'order by I070.UTENTE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 280
    Top = 73
  end
  object selT960UtentiWeb: TOracleDataSet
    SQL.Strings = (
      'select I060.NOME_UTENTE, T030.COGNOME, T030.NOME'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '       T030_ANAGRAFICO T030'
      'where  I060.AZIENDA = t000f_getaziendacorrente'
      'and    exists (select '#39'x'#39
      '               from   T960_DOCUMENTI_INFO T960'
      '               where T960.UTENTE = I060.NOME_UTENTE'
      '               and T960.TIPOLOGIA <> '#39'MEDP_INPS'#39')'
      'and    T030.MATRICOLA (+) = I060.MATRICOLA'
      'order by I060.NOME_UTENTE')
    ReadBuffer = 500
    Optimize = False
    ReadOnly = True
    Left = 376
    Top = 73
  end
end
