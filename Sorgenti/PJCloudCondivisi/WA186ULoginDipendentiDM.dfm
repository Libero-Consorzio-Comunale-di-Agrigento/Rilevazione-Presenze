inherited WA186FLoginDipendentiDM: TWA186FLoginDipendentiDM
  Height = 506
  Width = 682
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT I060.AZIENDA, I060.MATRICOLA, I060.NOME_UTENTE, I060.NOME' +
        '_UTENTE2, I060.PASSWORD, I060.DATA_PW, '
      
        'I061F_ELENCO_PROFILI(I060.AZIENDA,I060.NOME_UTENTE) NOMI_PROFILI' +
        ', I060.EMAIL, I060.EMAIL_PERSONALE, I060.EMAIL_PEC, I060.CELLULA' +
        'RE, I060.CELLULARE_PERSONALE, I060.ROWID '
      'FROM   MONDOEDP.I060_LOGIN_DIPENDENTE I060 '
      'WHERE  I060.AZIENDA = :Azienda '
      
        'AND (I060.MATRICOLA IS NULL OR I060.MATRICOLA IN (SELECT MATRICO' +
        'LA FROM :C700SelAnagrafe))'
      ' :FILTRO_I061'
      ' :ORDERBY'
      ''
      '')
    ReadBuffer = 100
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000200000003A004300370030003000530045004C0041004E00
      410047005200410046004500010000000000000000000000180000003A004600
      49004C00540052004F005F004900300036003100010000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    OnPostError = selTabellaPostError
    object selTabellaAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      FieldName = 'AZIENDA'
      Required = True
      Visible = False
      Size = 30
    end
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selTabellaD_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'D_NOMINATIVO'
      LookupDataSet = selaT030
      LookupKeyFields = 'MATRICOLA'
      LookupResultField = 'NOMINATIVO'
      KeyFields = 'MATRICOLA'
      ReadOnly = True
      Size = 50
      Lookup = True
    end
    object selTabellaNOME_UTENTE: TStringField
      DisplayLabel = 'Nome utente'
      FieldName = 'NOME_UTENTE'
      Size = 40
    end
    object selTabellaNOME_UTENTE2: TStringField
      DisplayLabel = 'Alias'
      FieldName = 'NOME_UTENTE2'
      Size = 40
    end
    object selTabellaPASSWORD: TStringField
      DisplayLabel = 'Password'
      FieldName = 'PASSWORD'
      Visible = False
    end
    object selTabellaD_PASSWORD: TStringField
      DisplayLabel = 'Password'
      FieldKind = fkCalculated
      FieldName = 'D_PASSWORD'
      Calculated = True
    end
    object selTabellaDATA_PW: TDateTimeField
      FieldName = 'DATA_PW'
      Visible = False
    end
    object selTabellaEMAIL: TStringField
      DisplayLabel = 'Email'
      DisplayWidth = 20
      FieldName = 'EMAIL'
      Size = 200
    end
    object selTabellaCELLULARE: TStringField
      DisplayLabel = 'Cellulare'
      FieldName = 'CELLULARE'
      Size = 15
    end
    object selTabellaEMAIL_PERSONALE: TStringField
      DisplayLabel = 'Email personale'
      FieldName = 'EMAIL_PERSONALE'
    end
    object selTabellaEMAIL_PEC: TStringField
      DisplayLabel = 'Email PEC'
      DisplayWidth = 20
      FieldName = 'EMAIL_PEC'
      Size = 1000
    end
    object selTabellaCELLULARE_PERSONALE: TStringField
      DisplayLabel = 'Cellulare personale'
      FieldName = 'CELLULARE_PERSONALE'
    end
    object selTabellaNOMI_PROFILI: TStringField
      DisplayLabel = 'Profili disponibili'
      DisplayWidth = 20
      FieldName = 'NOMI_PROFILI'
      ReadOnly = True
      Size = 500
    end
  end
  inherited selT900: TOracleDataSet
    Left = 272
  end
  inherited selT901: TOracleDataSet
    Left = 328
  end
  object DbIris008B: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Preferences.TrimStringFields = False
    Preferences.ZeroDateIsNull = False
    NullValue = nvNull
    Left = 22
    Top = 362
  end
  object selaT030: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MATRICOLA,COGNOME||'#39' '#39'||NOME NOMINATIVO FROM T030_ANAGRAF' +
        'ICO WHERE TIPO_PERSONALE = '#39'I'#39)
    ReadBuffer = 1000
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000120000004D00410054005200490043004F004C0041000100
      00000000140000004E004F004D0049004E0041005400490056004F0001000000
      0000}
    Session = DbIris008B
    Left = 74
    Top = 362
    object selaT030MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selaT030NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 30
    end
  end
  object D090: TDataSource
    AutoEdit = False
    DataSet = QI090
    Left = 16
    Top = 172
  end
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.*'
      'FROM MONDOEDP.I090_ENTI I090'
      'ORDER BY AZIENDA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000170000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C00490041005300010000000000160000004400450053004300
      520049005A0049004F004E0045000100000000001200000049004E0044004900
      520049005A005A004F000100000000001A0000005400490050004F0043004F00
      4E00540045004700470049004F0001000000000020000000530054004F005200
      4900410049004E00540045005200560045004E0054004F000100000000002000
      000041005A005A004500520041004D0045004E0054004F00530041004C004400
      4F00010000000000160000004500430043004600410053004300450053005400
      52000100000000000C0000005500540045004E00540045000100000000001800
      00005000410052004F004C004100430048004900410056004500010000000000
      10000000540053004C00410056004F0052004F00010000000000100000005400
      530049004E0044004900430049000100000000001A0000004600520041005A00
      49004F004E0041004E004F005400540045000100000000001C00000054004900
      4D0042004F005200490047005F0056004500520053004F000100000000002000
      0000540049004D0042004F005200490047005F00430041005500530041004C00
      45000100000000001E00000052004100470049004F004E0045005F0053004F00
      4300490041004C00450001000000000014000000560045005200530049004F00
      4E004500440042000100000000002600000043004F0044004900430045005F00
      49004E00540045004700520041005A0049004F004E0045000100000000001A00
      00004C0055004E0047005F00500041005300530057004F005200440001000000
      00001C000000560041004C00490044005F00500041005300530057004F005200
      440001000000000018000000560041004C00490044005F005500540045004E00
      540045000100000000000E000000500041005400430048004400420001000000
      0000180000005400530041005500530049004C0049004100520049004F000100
      00000000}
    Left = 20
    Top = 124
  end
  object insI060: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I060_LOGIN_DIPENDENTE '
      
        '(AZIENDA,MATRICOLA,NOME_UTENTE,PASSWORD,FILTRO_FUNZIONI,FILTRO_A' +
        'NAGRAFE,DATA_PW,PERMESSI,FILTRO_DIZIONARIO)'
      'VALUES '
      
        '(:Azienda,:Matricola,:NomeUtente,:Password,:FiltroFunzioni,:Filt' +
        'roAnagrafe,:DataPw,:Permessi,:FiltroDizionario)'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000009000000100000003A0041005A00490045004E004400410005000000
      0000000000000000120000003A00500041005300530057004F00520044000500
      000000000000000000001E0000003A00460049004C00540052004F0046005500
      4E005A0049004F004E004900050000000000000000000000140000003A004D00
      410054005200490043004F004C00410005000000000000000000000016000000
      3A004E004F004D0045005500540045004E005400450005000000000000000000
      00001E0000003A00460049004C00540052004F0041004E004100470052004100
      46004500050000000000000000000000120000003A005000450052004D004500
      530053004900050000000000000000000000220000003A00460049004C005400
      52004F00440049005A0049004F004E004100520049004F000500000000000000
      000000000E0000003A004400410054004100500057000C000000000000000000
      0000}
    AfterQuery = insI060AfterQuery
    Left = 115
    Top = 125
  end
  object delI060: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      ''
      'DELETE'
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE IN (SELECT I060.NOME_UTENTE'
      '                             FROM I060_LOGIN_DIPENDENTE I060'
      '                            WHERE I060.MATRICOLA = :MATRICOLA'
      '                              AND I060.AZIENDA = I061.AZIENDA);'
      ''
      'DELETE MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      ' WHERE I060.AZIENDA = :Azienda '
      '   AND I060.MATRICOLA = :Matricola;'
      ''
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    AfterQuery = delI060AfterQuery
    Left = 163
    Top = 125
  end
  object delI060Filtri: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  CURSOR C1 IS'
      
        '    SELECT I060.AZIENDA, I060.NOME_UTENTE, I061.NOME_PROFILO, I0' +
        '61.FILTRO_FUNZIONI'
      
        '      FROM MONDOEDP.I060_LOGIN_DIPENDENTE I060, MONDOEDP.I061_PR' +
        'OFILI_DIPENDENTE I061'
      '     WHERE I060.AZIENDA = :AZIENDA '
      '       AND I060.MATRICOLA = :MATRICOLA '
      '       AND I060.AZIENDA = I061.AZIENDA '
      '       AND I060.NOME_UTENTE = I061.NOME_UTENTE '
      '       AND (NVL(I061.NOME_PROFILO,'#39' '#39') = NVL(:NOMEPROFILO,'#39' '#39')) '
      
        '       AND (NVL(I061.FILTRO_FUNZIONI,'#39' '#39') = NVL(:FILTROFUNZIONI,' +
        'NVL(I061.FILTRO_FUNZIONI,'#39' '#39'))) '
      
        '       AND (NVL(I061.FILTRO_ANAGRAFE,'#39' '#39') = NVL(:FILTROANAGRAFE,' +
        'NVL(I061.FILTRO_ANAGRAFE,'#39' '#39'))) '
      
        '       AND (NVL(I061.PERMESSI,'#39' '#39') = NVL(:PERMESSI,NVL(I061.PERM' +
        'ESSI,'#39' '#39'))) '
      
        '       AND (NVL(I061.FILTRO_DIZIONARIO,'#39' '#39') = NVL(:FILTRODIZIONA' +
        'RIO,NVL(I061.FILTRO_DIZIONARIO,'#39' '#39')))'
      
        '       AND (NVL(I061.ITER_AUTORIZZATIVI,'#39' '#39') = NVL(:ITER_AUTORIZ' +
        'ZATIVI,NVL(I061.ITER_AUTORIZZATIVI,'#39' '#39')));'
      'BEGIN'
      '  FOR T1 IN C1 LOOP'
      '    DELETE '
      '      FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      '     WHERE I061.AZIENDA = T1.AZIENDA '
      '       AND I061.NOME_UTENTE = T1.NOME_UTENTE'
      '       AND I061.NOME_PROFILO = T1.NOME_PROFILO;'
      '  END LOOP;'
      '  COMMIT;'
      '  DELETE '
      '    FROM MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      '   WHERE I060.AZIENDA = :AZIENDA '
      '     AND I060.MATRICOLA = :MATRICOLA '
      '     AND NOT EXISTS(SELECT '#39'X'#39' '
      '                      FROM MONDOEDP.I061_PROFILI_DIPENDENTE '
      '                     WHERE AZIENDA = I060.AZIENDA '
      '                       AND NOME_UTENTE = I060.NOME_UTENTE);'
      '  :RECORD_ELIMINATI:=sql%rowcount;'
      '  COMMIT;'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000009000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000140000003A004D00410054005200490043004F
      004C004100050000000700000042454C454D4100000000001E0000003A004600
      49004C00540052004F00460055004E005A0049004F004E004900050000000800
      0000414C424552544F00000000001E0000003A00460049004C00540052004F00
      41004E0041004700520041004600450005000000000000000000000012000000
      3A005000450052004D004500530053004900050000000A000000414C42455254
      4F31310000000000220000003A00460049004C00540052004F00440049005A00
      49004F004E004100520049004F00050000000000000000000000180000003A00
      4E004F004D004500500052004F00460049004C004F0005000000000000000000
      0000260000003A0049005400450052005F004100550054004F00520049005A00
      5A0041005400490056004900050000000000000000000000220000003A005200
      450043004F00520044005F0045004C0049004D0049004E004100540049000300
      00000000000000000000}
    AfterQuery = delI060FiltriAfterQuery
    Left = 267
    Top = 125
  end
  object InsI061: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I061_PROFILI_DIPENDENTE'
      
        '  (AZIENDA, NOME_UTENTE, NOME_PROFILO, PERMESSI, FILTRO_FUNZIONI' +
        ', FILTRO_ANAGRAFE, '
      
        '   FILTRO_DIZIONARIO, ITER_AUTORIZZATIVI, INIZIO_VALIDITA, FINE_' +
        'VALIDITA)'
      'VALUES'
      
        '  (:AZIENDA, :NOME_UTENTE, :NOME_PROFILO, :PERMESSI, :FILTRO_FUN' +
        'ZIONI, :FILTRO_ANAGRAFE, '
      
        '   :FILTRO_DIZIONARIO, :ITER_AUTORIZZATIVI, :INIZIO_VALIDITA, :F' +
        'INE_VALIDITA)')
    Optimize = False
    Variables.Data = {
      040000000A000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      540045000500000000000000000000001A0000003A004E004F004D0045005F00
      500052004F00460049004C004F00050000000000000000000000120000003A00
      5000450052004D00450053005300490005000000000000000000000020000000
      3A00460049004C00540052004F005F00460055004E005A0049004F004E004900
      050000000000000000000000200000003A00460049004C00540052004F005F00
      41004E0041004700520041004600450005000000000000000000000024000000
      3A00460049004C00540052004F005F00440049005A0049004F004E0041005200
      49004F00050000000000000000000000200000003A0049004E0049005A004900
      4F005F00560041004C00490044004900540041000C0000000000000000000000
      1C0000003A00460049004E0045005F00560041004C0049004400490054004100
      0C0000000000000000000000260000003A0049005400450052005F0041005500
      54004F00520049005A005A004100540049005600490005000000000000000000
      0000}
    AfterQuery = InsI061AfterQuery
    Left = 327
    Top = 125
  end
  object delI061: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE = :NOME_UTENTE')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 375
    Top = 125
  end
  object UpdI061: TOracleQuery
    SQL.Strings = (
      'UPDATE MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      '   SET I061.NOME_UTENTE = :NOME_UTENTENEW'
      ' WHERE I061.NOME_UTENTE = :NOME_UTENTEOLD')
    Optimize = False
    Variables.Data = {
      04000000020000001E0000003A004E004F004D0045005F005500540045004E00
      540045004E00450057000500000000000000000000001E0000003A004E004F00
      4D0045005F005500540045004E00540045004F004C0044000500000000000000
      00000000}
    Left = 423
    Top = 124
  end
  object selI061Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT I061.NOME_PROFILO '
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061 '
      ' WHERE I061.AZIENDA = :AZIENDA'
      ' ORDER BY I061.NOME_PROFILO')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 478
    Top = 124
  end
  object selI061: TOracleDataSet
    SQL.Strings = (
      'SELECT I061.*, I061.ROWID'
      '  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE = :NOME_UTENTE'
      '   :ORDERBY')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    OnApplyRecord = selI061ApplyRecord
    BeforeInsert = selI061BeforeInsert
    BeforeEdit = selI061BeforeEdit
    BeforePost = selI061BeforePost
    OnFilterRecord = selI061FilterRecord
    Left = 14
    Top = 228
    object selI061AZIENDA: TStringField
      DisplayLabel = 'Azienda'
      FieldName = 'AZIENDA'
      Visible = False
      Size = 30
    end
    object selI061NOME_UTENTE: TStringField
      FieldName = 'NOME_UTENTE'
      Visible = False
      Size = 40
    end
    object selI061NOME_PROFILO: TStringField
      DisplayLabel = 'Nome profilo'
      DisplayWidth = 20
      FieldName = 'NOME_PROFILO'
      Size = 30
    end
    object selI061LOGIN_DEFAULT: TStringField
      DisplayLabel = 'Default'
      FieldName = 'LOGIN_DEFAULT'
      Size = 1
    end
    object selI061PERMESSI: TStringField
      DisplayLabel = 'Permessi'
      DisplayWidth = 18
      FieldName = 'PERMESSI'
    end
    object selI061FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      DisplayWidth = 18
      FieldName = 'FILTRO_ANAGRAFE'
    end
    object selI061FILTRO_FUNZIONI: TStringField
      DisplayLabel = 'Filtro funzioni'
      DisplayWidth = 18
      FieldName = 'FILTRO_FUNZIONI'
    end
    object selI061ITER_AUTORIZZATIVI: TStringField
      DisplayLabel = 'Iter autorizzativo'
      DisplayWidth = 18
      FieldName = 'ITER_AUTORIZZATIVI'
      Size = 30
    end
    object selI061FILTRO_DIZIONARIO: TStringField
      DisplayLabel = 'Filtro dizionario'
      DisplayWidth = 18
      FieldName = 'FILTRO_DIZIONARIO'
    end
    object selI061INIZIO_VALIDITA: TDateTimeField
      DisplayLabel = 'Inizio Validit'#224
      DisplayWidth = 10
      FieldName = 'INIZIO_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI061FINE_VALIDITA: TDateTimeField
      DisplayLabel = 'Fine Validit'#224
      DisplayWidth = 10
      FieldName = 'FINE_VALIDITA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selI061DELEGATO_DA: TStringField
      DisplayLabel = 'Delegato da'
      FieldName = 'DELEGATO_DA'
    end
    object selI061FINE_VALIDITA2: TDateTimeField
      DisplayLabel = 'Ultimo accesso'
      DisplayWidth = 10
      FieldName = 'ULTIMO_ACCESSO'
      ReadOnly = True
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selI061RICEZIONE_MAIL: TStringField
      DisplayLabel = 'Ricezione E-Mail'
      FieldName = 'RICEZIONE_MAIL'
      Size = 1
    end
    object selI061AUTO_ESCLUSIONE: TStringField
      DisplayLabel = 'Autoesclusione'
      FieldName = 'AUTO_ESCLUSIONE'
      Size = 1
    end
  end
  object selUser_Triggers: TOracleDataSet
    SQL.Strings = (
      
        'SELECT STATUS FROM USER_TRIGGERS WHERE TRIGGER_NAME = '#39'T030_AFTE' +
        'RINS_I060'#39)
    Optimize = False
    Session = DbIris008B
    BeforeInsert = selUser_TriggersBeforeInsert
    BeforeDelete = selUser_TriggersBeforeDelete
    Left = 142
    Top = 363
  end
  object dsrTI071: TDataSource
    AutoEdit = False
    DataSet = selI071
    Left = 60
    Top = 272
  end
  object selI071: TOracleDataSet
    SQL.Strings = (
      'SELECT *--AZIENDA,PROFILO'
      '  FROM MONDOEDP.I071_PERMESSI I071'
      'ORDER BY AZIENDA,PROFILO')
    ReadBuffer = 100
    Optimize = False
    OracleDictionary.DefaultValues = True
    Filtered = True
    OnFilterRecord = selI071FilterRecord
    Left = 60
    Top = 228
  end
  object selI072Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA '
      '  FROM MONDOEDP.I072_FILTROANAGRAFE'
      'ORDER BY AZIENDA,PROFILO'
      '')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selI071FilterRecord
    Left = 112
    Top = 228
  end
  object dsrI072Dist: TDataSource
    AutoEdit = False
    DataSet = selI072Dist
    Left = 112
    Top = 272
  end
  object selI073Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA '
      '  FROM MONDOEDP.I073_FILTROFUNZIONI '
      ' --WHERE APPLICAZIONE = :APPLICAZIONE'
      'ORDER BY AZIENDA,PROFILO')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selI071FilterRecord
    Left = 172
    Top = 228
  end
  object dsrI073Dist: TDataSource
    AutoEdit = False
    DataSet = selI073Dist
    Left = 172
    Top = 272
  end
  object dsrI074Dist: TDataSource
    AutoEdit = False
    DataSet = selI074Dist
    Left = 232
    Top = 272
  end
  object selI074Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA'
      '  FROM MONDOEDP.I074_FILTRODIZIONARIO'
      'ORDER BY AZIENDA,PROFILO')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selI071FilterRecord
    Left = 232
    Top = 228
  end
  object selI065: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID from MONDOEDP.I065_EXPR_ACCOUNT T'
      'order by T.TIPO,T.CODICE')
    Optimize = False
    BeforePost = selI065BeforePost
    AfterPost = selI065AfterPost
    OnCalcFields = selI065CalcFields
    Left = 387
    Top = 349
    object selI065C_TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'C_TIPO'
      Size = 10
      Calculated = True
    end
    object selI065TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selI065CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 25
      FieldName = 'CODICE'
    end
    object selI065ESPRESSIONE: TStringField
      DisplayLabel = 'Espressione'
      DisplayWidth = 85
      FieldName = 'ESPRESSIONE'
      Size = 2000
    end
  end
  object selI065P: TOracleDataSet
    SQL.Strings = (
      'select T.* from MONDOEDP.I065_EXPR_ACCOUNT T'
      'where T.TIPO = '#39'P'#39
      'order by CODICE')
    Optimize = False
    CommitOnPost = False
    Left = 438
    Top = 349
  end
  object dsrI065P: TDataSource
    DataSet = selI065P
    Left = 438
    Top = 401
  end
  object selI065U: TOracleDataSet
    SQL.Strings = (
      'select T.* from MONDOEDP.I065_EXPR_ACCOUNT T'
      'where T.TIPO = '#39'U'#39
      'order by CODICE')
    Optimize = False
    CommitOnPost = False
    Left = 494
    Top = 349
  end
  object dsrI065U: TDataSource
    DataSet = selI065U
    Left = 497
    Top = 400
  end
  object dsrI065: TDataSource
    DataSet = selI065
    Left = 390
    Top = 401
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.*,I090.ROWID '
      '  FROM MONDOEDP.I090_ENTI I090'
      ' ORDER BY AZIENDA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000150000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C00490041005300010000000000160000004400450053004300
      520049005A0049004F004E0045000100000000001200000049004E0044004900
      520049005A005A004F000100000000001A0000005400490050004F0043004F00
      4E00540045004700470049004F0001000000000020000000530054004F005200
      4900410049004E00540045005200560045004E0054004F000100000000002000
      000041005A005A004500520041004D0045004E0054004F00530041004C004400
      4F00010000000000160000004500430043004600410053004300450053005400
      52000100000000000C0000005500540045004E00540045000100000000001800
      00005000410052004F004C004100430048004900410056004500010000000000
      10000000540053004C00410056004F0052004F00010000000000100000005400
      530049004E0044004900430049000100000000001A0000004600520041005A00
      49004F004E0041004E004F005400540045000100000000001C00000054004900
      4D0042004F005200490047005F0056004500520053004F000100000000002000
      0000540049004D0042004F005200490047005F00430041005500530041004C00
      45000100000000001E00000052004100470049004F004E0045005F0053004F00
      4300490041004C00450001000000000014000000560045005200530049004F00
      4E004500440042000100000000002600000043004F0044004900430045005F00
      49004E00540045004700520041005A0049004F004E0045000100000000001A00
      00004C0055004E0047005F00500041005300530057004F005200440001000000
      00001C000000560041004C00490044005F00500041005300530057004F005200
      440001000000000018000000560041004C00490044005F005500540045004E00
      54004500010000000000}
    CachedUpdates = True
    Left = 60
    Top = 124
    object selI090AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object selI090ALIAS: TStringField
      FieldName = 'ALIAS'
      Size = 30
    end
    object selI090DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 150
    end
    object selI090INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 40
    end
    object selI090TIPOCONTEGGIO: TStringField
      FieldName = 'TIPOCONTEGGIO'
      Size = 1
    end
    object selI090STORIAINTERVENTO: TStringField
      FieldName = 'STORIAINTERVENTO'
      Size = 1
    end
    object selI090AZZERAMENTOSALDO: TStringField
      FieldName = 'AZZERAMENTOSALDO'
      Size = 1
    end
    object selI090ECCFASCESTR: TStringField
      FieldName = 'ECCFASCESTR'
      Size = 1
    end
    object selI090UTENTE: TStringField
      FieldName = 'UTENTE'
    end
    object selI090PAROLACHIAVE: TStringField
      FieldName = 'PAROLACHIAVE'
    end
    object selI090TSLAVORO: TStringField
      FieldName = 'TSLAVORO'
    end
    object selI090TSINDICI: TStringField
      FieldName = 'TSINDICI'
    end
    object selI090FRAZIONANOTTE: TStringField
      FieldName = 'FRAZIONANOTTE'
      Size = 1
    end
    object selI090TSAUSILIARIO: TStringField
      FieldName = 'TSAUSILIARIO'
    end
    object selI090TIMBORIG_VERSO: TStringField
      FieldName = 'TIMBORIG_VERSO'
      Size = 1
    end
    object selI090TIMBORIG_CAUSALE: TStringField
      FieldName = 'TIMBORIG_CAUSALE'
      Size = 1
    end
    object selI090RAGIONE_SOCIALE: TStringField
      FieldName = 'RAGIONE_SOCIALE'
      Size = 200
    end
    object selI090VERSIONEDB: TStringField
      FieldName = 'VERSIONEDB'
      Size = 10
    end
    object selI090CODICE_INTEGRAZIONE: TStringField
      FieldName = 'CODICE_INTEGRAZIONE'
      Size = 30
    end
    object selI090VALID_UTENTE: TIntegerField
      FieldName = 'VALID_UTENTE'
    end
  end
  object selI075Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT I075.AZIENDA, I075.PROFILO'
      '  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075'
      ' ORDER BY I075.AZIENDA, I075.PROFILO')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selI071FilterRecord
    Left = 292
    Top = 229
  end
  object dsrI061: TDataSource
    DataSet = selI061
    Left = 18
    Top = 272
  end
  object OperSQL: TOracleQuery
    SQL.Strings = (
      '')
    Optimize = False
    Left = 383
    Top = 16
  end
  object UpdI060: TOracleQuery
    SQL.Strings = (
      'UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE I060'
      ' SET I060.PASSWORD = :PASSWORD_NEW, '
      '     I060.DATA_PW = :DATAPW'
      ' WHERE I060.AZIENDA = :AZIENDA'
      ' AND I060.NOME_UTENTE = :NOME_UTENTE'
      '')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      00000000000000001A0000003A00500041005300530057004F00520044005F00
      4E00450057000500000000000000000000000E0000003A004400410054004100
      500057000C0000000000000000000000180000003A004E004F004D0045005F00
      5500540045004E0054004500050000000000000000000000}
    AfterQuery = UpdI060AfterQuery
    Left = 207
    Top = 124
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      'select distinct I060.NOME_UTENTE'
      'from MONDOEDP.I060_LOGIN_DIPENDENTE I060,'
      '     MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      'where I060.AZIENDA = :AZIENDA '
      '--and   I060.NOME_UTENTE <> :NOME_UTENTE'
      'and   I060.AZIENDA = I061.AZIENDA'
      'and   I060.NOME_UTENTE = I061.NOME_UTENTE'
      
        'and  trunc(sysdate) between add_months(I061.INIZIO_VALIDITA,-1) ' +
        'and add_months(I061.FINE_VALIDITA,1)'
      'order by I060.NOME_UTENTE')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000001000000120000004D00410054005200490043004F004C0041000100
      00000000}
    Left = 355
    Top = 229
  end
  object selI060NomeUtente: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060 '
      'where  I060.AZIENDA = :AZIENDA '
      'and    I060.NOME_UTENTE = :NOME_UTENTE')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 464
    Top = 232
  end
  object selI060NomeUtenteUnivoco: TOracleQuery
    SQL.Strings = (
      'select count(*)'
      
        'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, MONDOEDP.I090_ENTI I' +
        '090'
      'where  I060.AZIENDA = :AZIENDA '
      'and    I090.AZIENDA = :AZIENDA'
      'and    (:ID_RIGA is null or (I060.ROWID <> :ID_RIGA))'
      'and '
      '(  '
      
        '  replace(upper(:NOME_UTENTE), upper(decode(I090.DOMINIO_DIP_TIP' +
        'O,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)'
      '  in'
      '  ('
      
        '   replace(upper(I060.NOME_UTENTE), upper(decode(I090.DOMINIO_DI' +
        'P_TIPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null),'
      
        '   replace(upper(I060.NOME_UTENTE2), upper(decode(I090.DOMINIO_D' +
        'IP_TIPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null),'
      
        '   replace(upper(:NOME_UTENTE2), upper(decode(I090.DOMINIO_DIP_T' +
        'IPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)'
      '  )'
      '  or'
      
        '  replace(upper(:NOME_UTENTE2), upper(decode(I090.DOMINIO_DIP_TI' +
        'PO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)'
      '  in'
      '  ('
      
        '   replace(upper(I060.NOME_UTENTE), upper(decode(I090.DOMINIO_DI' +
        'P_TIPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null),'
      
        '   replace(upper(I060.NOME_UTENTE2), upper(decode(I090.DOMINIO_D' +
        'IP_TIPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null),'
      
        '   replace(upper(:NOME_UTENTE), upper(decode(I090.DOMINIO_DIP_TI' +
        'PO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)'
      '  )'
      ')')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000100000003A00490044005F0052004900
      470041000500000000000000000000001A0000003A004E004F004D0045005F00
      5500540045004E00540045003200050000000000000000000000}
    Left = 461
    Top = 280
  end
end
