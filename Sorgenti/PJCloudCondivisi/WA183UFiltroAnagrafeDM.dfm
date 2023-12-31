inherited WA183FFiltroAnagrafeDM: TWA183FFiltroAnagrafeDM
  Height = 289
  Width = 402
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select '
      '  AZIENDA,'
      '  PROFILO,'
      '  SELEZIONE_RICHIESTA_PORTALE,'
      
        '  substr(concatena_testo('#39'select FILTRO from MONDOEDP.I072_FILTR' +
        'OANAGRAFE where AZIENDA = '#39#39#39'||AZIENDA||'#39#39#39' and PROFILO = '#39#39#39'||r' +
        'eplace(PROFILO,'#39#39#39#39','#39#39#39#39#39#39')||'#39#39#39' order by PROGRESSIVO'#39','#39' '#39'),1,50' +
        '0) FILTRO'
      'from MONDOEDP.I072_FILTROANAGRAFE I072'
      
        'where PROGRESSIVO = (select min(PROGRESSIVO) from MONDOEDP.I072_' +
        'FILTROANAGRAFE where AZIENDA = I072.AZIENDA and PROFILO = I072.P' +
        'ROFILO)'
      ':ORDERBY'
      '')
    AfterOpen = selTabellaAfterOpen
  end
  object DbIris008B: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Preferences.TrimStringFields = False
    Preferences.ZeroDateIsNull = False
    NullValue = nvNull
    Left = 34
    Top = 226
  end
  object insI072: TOracleQuery
    SQL.Strings = (
      'INSERT INTO MONDOEDP.I072_FILTROANAGRAFE (PROFILO)'
      'SELECT '
      '  :NEW_PROFILO'
      'FROM I072 WHERE PROFILO = :OLD_PROFILO')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A004E00450057005F00500052004F0046004900
      4C004F00050000000000000000000000180000003A004F004C0044005F005000
      52004F00460049004C004F00050000000000000000000000100000003A004100
      5A00490045004E0044004100050000000000000000000000}
    Left = 208
    Top = 123
  end
  object D090: TDataSource
    AutoEdit = False
    DataSet = QI090
    Left = 33
    Top = 173
  end
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.AZIENDA,I090.UTENTE,I090.PAROLACHIAVE'
      '  FROM MONDOEDP.I090_ENTI I090'
      ' ORDER BY AZIENDA')
    ReadBuffer = 5
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
    Left = 33
    Top = 124
  end
  object dsrI072: TDataSource
    DataSet = selI072
    OnStateChange = dsrI072StateChange
    Left = 160
    Top = 167
  end
  object selI072: TOracleDataSet
    SQL.Strings = (
      'SELECT I072.*,ROWID '
      'FROM MONDOEDP.I072_FILTROANAGRAFE I072'
      'WHERE AZIENDA = :AZIENDA '
      'AND PROFILO = :PROFILO'
      'ORDER BY PROFILO,PROGRESSIVO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000000E000000500052004F00460049004C004F00010000000000
      16000000500052004F0047005200450053005300490056004F00010000000000
      0A000000430041004D0050004F00010000000000120000004F00500045005200
      410054004F00520045000100000000000C000000560041004C004F0052004500
      010000000000100000004F0050004C004F004700490043004F00010000000000}
    Filtered = True
    Left = 160
    Top = 123
  end
  object selPermessi: TOracleDataSet
    SQL.Strings = (
      'select UTENTE from MONDOEDP.I070_UTENTI'
      'where AZIENDA = :AZIENDA '
      'and FILTRO_ANAGRAFE = :PROFILO'
      'union all'
      'select NOME_UTENTE from MONDOEDP.I061_PROFILI_DIPENDENTE'
      'where AZIENDA = :AZIENDA '
      'and FILTRO_ANAGRAFE = :PROFILO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    Left = 99
    Top = 124
  end
  object testFiltroAnagrafe: TOracleDataSet
    Optimize = False
    Left = 279
    Top = 187
    object testFiltroAnagrafeMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object testFiltroAnagrafeCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 20
      FieldName = 'COGNOME'
      Size = 50
    end
    object testFiltroAnagrafeNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 50
    end
    object testFiltroAnagrafeT430INIZIO: TDateTimeField
      DisplayLabel = 'Inizio'
      FieldName = 'T430INIZIO'
    end
    object testFiltroAnagrafeT430FINE: TDateTimeField
      DisplayLabel = 'Fine'
      FieldName = 'T430FINE'
    end
  end
  object dsrTestFiltroAnagrafe: TDataSource
    DataSet = testFiltroAnagrafe
    Left = 279
    Top = 135
  end
end
