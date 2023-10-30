object W050FRichiestaDocumentaleDM: TW050FRichiestaDocumentaleDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 166
  Width = 237
  object selT960: TOracleDataSet
    SQL.Strings = (
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C0045000100000000000000000000001E0000003A004100550054004F005200
      49005A005A0041005A0049004F004E0045000100000000000000000000001600
      00003A0044004100540041004C00410056004F0052004F000C00000000000000
      000000001E0000003A00460049004C00540052004F005F005000450052004900
      4F0044004F00010000000000000000000000100000003A0041005A0049004500
      4E0044004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    BeforeInsert = selT960BeforeInsert
    BeforeEdit = selT960BeforeEdit
    BeforePost = selT960BeforePost
    AfterPost = selT960AfterPost
    BeforeDelete = selT960BeforeDelete
    AfterScroll = selT960AfterScroll
    OnCalcFields = selT960CalcFields
    OnNewRecord = selT960NewRecord
    Left = 38
    Top = 16
    object selT960ID: TFloatField
      FieldName = 'ID'
    end
    object selT960ID_RICHIESTA: TFloatField
      FieldName = 'ID_RICHIESTA'
    end
    object selT960ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT960ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT960NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 65
    end
    object selT960PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT960MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT960SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT960COD_ITER: TStringField
      DisplayWidth = 20
      FieldName = 'COD_ITER'
      Size = 30
    end
    object selT960TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT960AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT960REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT960DATA_RICHIESTA: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
    end
    object selT960LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT960DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT960AUTORIZZAZIONE: TStringField
      FieldName = 'AUTORIZZAZIONE'
      Size = 1
    end
    object selT960NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 65
    end
    object selT960AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT960AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT960RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT960AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT960AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT960D_TIPO_RICHIESTA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT960D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT960D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT960D_CARTELLA_FILE: TStringField
      DisplayWidth = 200
      FieldKind = fkCalculated
      FieldName = 'D_CARTELLA_FILE'
      Size = 200
      Calculated = True
    end
    object selT960WEB_MATRICOLA: TStringField
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'WEB_MATRICOLA'
      Size = 8
      Calculated = True
    end
    object selT960WEB_NOMINATIVO: TStringField
      FieldKind = fkCalculated
      FieldName = 'WEB_NOMINATIVO'
      Size = 65
      Calculated = True
    end
    object selT960D_TIPOLOGIA: TStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_TIPOLOGIA'
      Size = 80
      Calculated = True
    end
    object selT960D_UFFICIO: TStringField
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_UFFICIO'
      ReadOnly = True
      Size = 80
      Calculated = True
    end
    object selT960D_NOME_FILE: TStringField
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_NOME_FILE'
      Size = 230
      Calculated = True
    end
    object selT960D_DIMENSIONE: TStringField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_DIMENSIONE'
      Size = 50
      Calculated = True
    end
    object selT960D_DATI_ACCESSO: TStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'D_DATI_ACCESSO'
      Size = 60
      Calculated = True
    end
    object selT960D_PROPRIETARIO: TStringField
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_PROPRIETARIO'
      Size = 120
      Calculated = True
    end
    object selT960D_ACCESSO_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_ACCESSO_RESPONSABILE'
      Size = 2
      Calculated = True
    end
    object selT960MSGAUTO_SI: TStringField
      FieldName = 'MSGAUT_SI'
      Size = 2000
    end
    object selT960MSGAUT_NO: TStringField
      FieldName = 'MSGAUT_NO'
      Size = 2000
    end
    object selT960DATA_CREAZIONE: TDateTimeField
      FieldName = 'DATA_CREAZIONE'
    end
    object selT960NOME_UTENTE: TStringField
      FieldName = 'NOME_UTENTE'
      Size = 30
    end
    object selT960UTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
      Visible = False
      Size = 30
    end
    object selT960TIPOLOGIA: TStringField
      DisplayWidth = 10
      FieldName = 'TIPOLOGIA'
    end
    object selT960UFFICIO: TStringField
      DisplayWidth = 10
      FieldName = 'UFFICIO'
      ReadOnly = True
    end
    object selT960NOME_FILE: TStringField
      FieldName = 'NOME_FILE'
      Size = 200
    end
    object selT960EXT_FILE: TStringField
      FieldName = 'EXT_FILE'
    end
    object selT960DIMENSIONE: TFloatField
      FieldName = 'DIMENSIONE'
    end
    object selT960PERIODO_DAL: TDateTimeField
      DisplayWidth = 10
      FieldName = 'PERIODO_DAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960PERIODO_AL: TDateTimeField
      DisplayWidth = 10
      FieldName = 'PERIODO_AL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT960NOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT960DATA_ACCESSO: TDateTimeField
      FieldName = 'DATA_ACCESSO'
    end
    object selT960UTENTE_ACCESSO: TStringField
      FieldName = 'UTENTE_ACCESSO'
      Size = 30
    end
    object selT960ACCESSO_RESPONSABILE: TStringField
      DisplayWidth = 1
      FieldName = 'ACCESSO_RESPONSABILE'
      Size = 1
    end
    object selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField
      FieldName = 'DATA_LETTURA_PROGRESSIVO'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy hh.mm.ss'
    end
    object selT960AUTOCERTIFICAZIONE: TStringField
      DisplayWidth = 1
      FieldName = 'AUTOCERTIFICAZIONE'
      Size = 1
    end
    object selT960D_AUTOCERTIFICAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTOCERTIFICAZIONE'
      Size = 2
      Calculated = True
    end
    object selT960RICHIEDERE_ENTE: TStringField
      FieldName = 'RICHIEDERE_ENTE'
    end
    object selT960PATH_STORAGE: TStringField
      FieldName = 'PATH_STORAGE'
      Size = 1000
    end
    object selT960PROVENIENZA: TStringField
      DisplayWidth = 1
      FieldName = 'PROVENIENZA'
      Size = 1
    end
    object selT960ACCESSO_PORTALE: TStringField
      FieldName = 'ACCESSO_PORTALE'
    end
    object selT960CF_FAMILIARE: TStringField
      DisplayWidth = 16
      FieldName = 'CF_FAMILIARE'
      Size = 16
    end
    object selT960DATA_RILASCIO: TDateTimeField
      FieldName = 'DATA_RILASCIO'
    end
    object selT960DATA_RICHIESTA_ENTE: TDateTimeField
      FieldName = 'DATA_RICHIESTA_ENTE'
    end
    object selT960DATA_RICEZIONE_ENTE: TDateTimeField
      FieldName = 'DATA_RICEZIONE_ENTE'
    end
    object selT960DATA_NOTIFICA: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATA_NOTIFICA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT960HASH: TStringField
      DisplayWidth = 100
      FieldName = 'HASH'
      Size = 100
    end
    object selT960VERSIONE: TFloatField
      FieldName = 'VERSIONE'
    end
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      'select '
      '  T960.ID, '
      '  I060.MATRICOLA WEB_MATRICOLA,'
      '  I060F_NOMINATIVO(:AZIENDA, I060.NOME_UTENTE) WEB_NOMINATIVO, '
      '  T962.DESCRIZIONE D_TIPOLOGIA, '
      '  T963.DESCRIZIONE D_UFFICIO  '
      'from   '
      '  T960_DOCUMENTI_INFO T960,'
      '  MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '  T962_TIPO_DOCUMENTI T962,'
      '  T963_UFFICIO_DOCUMENTI T963'
      'where'
      '       T960.ID = :ID'
      'and    I060.AZIENDA (+) = :AZIENDA'
      'and    I060.NOME_UTENTE (+) = T960.NOME_UTENTE'
      'and    T962.CODICE = T960.TIPOLOGIA'
      'and    T963.CODICE = T960.UFFICIO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000060000003A0049004400030000000000000000000000}
    Left = 135
    Top = 16
  end
  object selQueryT960: TOracleQuery
    SQL.Strings = (
      'select '
      '  T960.NOME_FILE || '#39'.'#39' || T960.EXT_FILE,'
      '  TRUNC(T960.DATA_CREAZIONE) DATA_RICHIESTA,'
      '  T960.PERIODO_DAL DAL,'
      '  T960.PERIODO_AL AL'
      'from T960_DOCUMENTI_INFO T960, T962_TIPO_DOCUMENTI T962'
      'where'
      
        '  ((greatest(NVL(T960.PERIODO_DAL,TRUNC(T960.DATA_CREAZIONE)), :' +
        'DATA_I) <= least(NVL(T960.PERIODO_AL,TRUNC(T960.DATA_CREAZIONE))' +
        ', :DATA_F))'
      
        '  or (NVL(T960.PERIODO_DAL,TRUNC(T960.DATA_CREAZIONE)) > :DATA_I' +
        'Min and NVL(T960.PERIODO_DAL,TRUNC(T960.DATA_CREAZIONE)) < :DATA' +
        '_IMax ))'
      '  and T960.TIPOLOGIA = :TIPOLOGIA'
      '  and T960.PROGRESSIVO = :PROGRESSIVO'
      '  and T962.CODICE = T960.TIPOLOGIA'
      '  :ROWID_T')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000070000000E0000003A0044004100540041005F004900010000000000
      0000000000000E0000003A0044004100540041005F0046000100000000000000
      00000000140000003A005400490050004F004C004F0047004900410005000000
      0000000000000000100000003A0052004F005700490044005F00540001000000
      0000000000000000140000003A0044004100540041005F0049004D0049004E00
      010000000000000000000000140000003A0044004100540041005F0049004D00
      41005800010000000000000000000000180000003A00500052004F0047005200
      450053005300490056004F00040000000000000000000000}
    Left = 37
    Top = 78
  end
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select * from T962_TIPO_DOCUMENTI where CODICE = :TIPOLOGIA')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Left = 136
    Top = 80
  end
end
