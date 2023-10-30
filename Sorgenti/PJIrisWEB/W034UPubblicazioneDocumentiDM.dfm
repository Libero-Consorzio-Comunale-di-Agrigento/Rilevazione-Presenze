object W034FPubblicazioneDocumentiDM: TW034FPubblicazioneDocumentiDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 80
  Width = 203
  object cdsFile: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 16
  end
  object selT960: TOracleDataSet
    SQL.Strings = (
      
        'select T960.ID, T960.DATA_CREAZIONE, T960.NOME_UTENTE, T960.UTEN' +
        'TE, T960.PROGRESSIVO, T960.TIPOLOGIA,'
      
        '       T960.UFFICIO, T960.NOME_FILE, T960.EXT_FILE, T960.DIMENSI' +
        'ONE, T960.PERIODO_DAL, T960.PERIODO_AL, T960.NOTE, '
      
        '       T960.DATA_ACCESSO, T960.UTENTE_ACCESSO, T960.ACCESSO_RESP' +
        'ONSABILE, T960.DATA_LETTURA_PROGRESSIVO, T960.PATH_STORAGE,'
      '       cast(null as varchar2(200)) D_CARTELLA_FILE,'
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
      '       T030_ANAGRAFICO T030'
      'where  T960.PROGRESSIVO = T030.PROGRESSIVO'
      'and    T960.NOME_FILE is not null'
      'and    I060.AZIENDA (+) = :AZIENDA'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO'
      'and    T030.PROGRESSIVO = :PROGRESSIVO'
      'and    T960.TIPOLOGIA = :TIPOLOGIA'
      
        'order by NOMINATIVO, T030.MATRICOLA, decode(T960.DATA_LETTURA_PR' +
        'OGRESSIVO,null,0,1), D_TIPOLOGIA, D_UFFICIO, T960.PERIODO_DAL DE' +
        'SC, T960.NOME_FILE')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A005400490050004F004C00
      4F00470049004100050000000000000000000000}
    Left = 88
    Top = 16
  end
end
