inherited WA180FOperatoriDM: TWA180FOperatoriDM
  Height = 277
  Width = 404
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT I070.*,I070.ROWID '
      '  FROM MONDOEDP.I070_UTENTI I070 '
      ':ORDERBY')
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaAZIENDA: TStringField
      DisplayLabel = 'Azienda'
      DisplayWidth = 20
      FieldName = 'AZIENDA'
      Required = True
      Size = 30
    end
    object selTabellaUTENTE: TStringField
      DisplayLabel = 'Operatore'
      DisplayWidth = 20
      FieldName = 'UTENTE'
      Required = True
      Size = 30
    end
    object selTabellaPROGRESSIVO: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'PROGRESSIVO'
    end
    object selTabellaPERMESSI: TStringField
      DisplayLabel = 'Permessi'
      FieldName = 'PERMESSI'
    end
    object selTabellaFILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
    end
    object selTabellaFILTRO_FUNZIONI: TStringField
      DisplayLabel = 'Filtro funzioni'
      FieldName = 'FILTRO_FUNZIONI'
    end
    object selTabellaFILTRO_DIZIONARIO: TStringField
      DisplayLabel = 'Filtro dizionario'
      FieldName = 'FILTRO_DIZIONARIO'
    end
    object selTabellaVALIDITA_CESSATI: TIntegerField
      DisplayLabel = 'Visibilit'#224' cessati'
      FieldName = 'VALIDITA_CESSATI'
      MaxValue = 999
    end
    object selTabellaDATA_PW: TDateTimeField
      DisplayLabel = 'Inserimento password'
      FieldName = 'DATA_PW'
    end
    object selTabellaScadenzaPasswd: TDateField
      DisplayLabel = 'Scadenza password'
      FieldKind = fkCalculated
      FieldName = 'ScadenzaPasswd'
      Calculated = True
    end
    object selTabellaNUOVA_PASSWORD: TStringField
      DisplayLabel = 'Cambio password'
      FieldName = 'NUOVA_PASSWORD'
      Size = 1
    end
    object selTabellaDATA_ACCESSO: TDateTimeField
      DisplayLabel = 'Ultimo accesso'
      FieldName = 'DATA_ACCESSO'
    end
    object selTabellaScadenzaUtente: TDateField
      DisplayLabel = 'Scadenza accesso'
      FieldKind = fkCalculated
      FieldName = 'ScadenzaUtente'
      Calculated = True
    end
    object selTabellaOCCUPATO: TStringField
      DisplayLabel = 'Occupato'
      FieldName = 'OCCUPATO'
      Size = 1
    end
    object selTabellaSBLOCCO: TStringField
      DisplayLabel = 'Pu'#242' sbloccare'
      FieldName = 'SBLOCCO'
      Size = 1
    end
    object selTabellaACCESSO_NEGATO: TStringField
      DisplayLabel = 'Accesso negato'
      FieldName = 'ACCESSO_NEGATO'
      Required = True
      Size = 1
    end
    object selTabellaPASSWD: TStringField
      FieldName = 'PASSWD'
      Visible = False
      Size = 40
    end
    object selTabellaINTEGRAZIONEANAGRAFE: TStringField
      FieldName = 'INTEGRAZIONEANAGRAFE'
      Origin = 'I070_OPERATORI.INTEGRAZIONEANAGRAFE'
      Visible = False
      Size = 1
    end
    object selTabellaD_Azienda: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Azienda'
      LookupDataSet = QI090
      LookupKeyFields = 'AZIENDA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'AZIENDA'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaT030_PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo anag. riferimento'
      FieldName = 'T030_PROGRESSIVO'
      Visible = False
    end
  end
  object D090: TDataSource
    AutoEdit = False
    DataSet = QI090
    Left = 269
    Top = 164
  end
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.* '
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
    AfterScroll = QI090AfterScroll
    OnFilterRecord = QI090FilterRecord
    Left = 268
    Top = 116
  end
  object dsrI071: TDataSource
    AutoEdit = False
    DataSet = selI071
    Left = 28
    Top = 160
  end
  object selI071: TOracleDataSet
    SQL.Strings = (
      'SELECT *--AZIENDA,PROFILO'
      '  FROM MONDOEDP.I071_PERMESSI I071'
      'ORDER BY AZIENDA,PROFILO')
    ReadBuffer = 50
    Optimize = False
    OracleDictionary.DefaultValues = True
    Filtered = True
    OnFilterRecord = selI071FilterRecord
    Left = 28
    Top = 116
  end
  object selI072Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA '
      '  FROM MONDOEDP.I072_FILTROANAGRAFE'
      'ORDER BY AZIENDA,PROFILO'
      '')
    Optimize = False
    Filtered = True
    OnFilterRecord = selI072DistFilterRecord
    Left = 80
    Top = 116
  end
  object dsrI072Dist: TDataSource
    AutoEdit = False
    DataSet = selI072Dist
    Left = 80
    Top = 160
  end
  object selI073Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA '
      '  FROM MONDOEDP.I073_FILTROFUNZIONI '
      ' --WHERE APPLICAZIONE = :APPLICAZIONE'
      'ORDER BY AZIENDA,PROFILO')
    Optimize = False
    Filtered = True
    OnFilterRecord = selI073DistFilterRecord
    Left = 140
    Top = 116
  end
  object dsrI073Dist: TDataSource
    AutoEdit = False
    DataSet = selI073Dist
    Left = 140
    Top = 160
  end
  object dsrI074Dist: TDataSource
    AutoEdit = False
    DataSet = selI074Dist
    Left = 200
    Top = 160
  end
  object selI074Dist: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT PROFILO, AZIENDA'
      '  FROM MONDOEDP.I074_FILTRODIZIONARIO'
      'ORDER BY AZIENDA,PROFILO')
    Optimize = False
    Filtered = True
    OnFilterRecord = selI074DistFilterRecord
    Left = 200
    Top = 116
  end
  object T035: TOracleDataSet
    SQL.Strings = (
      
        'select max(I070.PROGRESSIVO) I070PROGRESSIVO, T035.PROPERATORI,T' +
        '035.ROWID '
      'from MONDOEDP.T035_PROGRESSIVO T035, MONDOEDP.I070_UTENTI I070'
      'group by T035.PROPERATORI,T035.ROWID ')
    ReadBuffer = 1
    Optimize = False
    Left = 105
    Top = 15
  end
  object selT030: TOracleDataSet
    SQL.Strings = (
      'select T030.MATRICOLA, T030.COGNOME, T030.NOME, T030.CODFISCALE'
      'from   T030_ANAGRAFICO T030'
      'where  T030.PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    Left = 24
    Top = 217
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      'SELECT I091.DATO'
      'FROM   MONDOEDP.I091_DATIENTE I091 '
      'WHERE  I091.AZIENDA = :AZIENDA'
      'AND    I091.TIPO = :TIPO'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E00000000000A0000003A005400490050004F000500000000
      00000000000000}
    Left = 328
    Top = 116
  end
  object selParLinkOperatori: TOracleQuery
    SQL.Strings = (
      'SELECT COUNT(I091.DATO)'
      'FROM   MONDOEDP.I091_DATIENTE I091 '
      'WHERE  I091.TIPO = '#39'C33_LINK_I070_T030'#39
      'AND    I091.DATO <> '#39'N'#39' -- se '#232' null non rientra nel conteggio'
      '')
    ReadBuffer = 2
    Optimize = False
    Left = 104
    Top = 216
  end
end
