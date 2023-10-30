inherited A062FQueryServizioMW: TA062FQueryServizioMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 183
  Width = 583
  object cdsValori: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VARIABILE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'VALORE'
        DataType = ftString
        Size = 1000
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
        Fields = 'VARIABILE'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'VARIABILE'
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsValoriBeforeInsert
    BeforeDelete = cdsValoriBeforeDelete
    Left = 249
    Top = 13
    object cdsValoriVARIABILE: TStringField
      DisplayLabel = 'Variabile'
      DisplayWidth = 15
      FieldName = 'VARIABILE'
      ReadOnly = True
    end
    object cdsValoriTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
    end
    object cdsValoriVALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 15
      FieldName = 'VALORE'
      Size = 1000
    end
  end
  object selT002Riga: TOracleDataSet
    SQL.Strings = (
      'select RIGA, POSIZ'
      '  from T002_QUERYPERSONALIZZATE       '
      ' where NOME = :nome '
      '   and APPLICAZIONE = :applicazione'
      ' order by POSIZ')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A004E004F004D00450005000000000000000000
      00001A0000003A004100500050004C004900430041005A0049004F004E004500
      050000000000000000000000}
    Left = 124
    Top = 12
  end
  object S1: TOracleScript
    AutoCommit = True
    OutputOptions = [ooFeedback, ooError]
    Left = 128
    Top = 64
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA, UTENTE, PAROLACHIAVE'
      'FROM MONDOEDP.I090_ENTI'
      'WHERE UTENTE = :UTENTE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 72
    Top = 63
  end
  object CreateTab: TOracleDataSet
    Optimize = False
    Left = 15
    Top = 63
  end
  object delT002: TOracleQuery
    SQL.Strings = (
      'delete'
      '  from t002_querypersonalizzate'
      '  where nome=:nome '
      '  and applicazione = :applicazione'
      ':FILTRO')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A004E004F004D00450005000000000000000000
      00001A0000003A004100500050004C004900430041005A0049004F004E004500
      0500000000000000000000000E0000003A00460049004C00540052004F000100
      00000000000000000000}
    BeforeQuery = delT002BeforeQuery
    Left = 20
    Top = 12
  end
  object insT002: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  INSERT INTO T002_QUERYPERSONALIZZATE (APPLICAZIONE,NOME,POSIZ,' +
        'RIGA)'
      '  VALUES (:APPLICAZIONE,:NOME,:POSIZ,:RIGA);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A004E004F004D00450005000000000000000000
      00000C0000003A0050004F00530049005A000300000000000000000000000A00
      00003A0052004900470041000500000000000000000000001A0000003A004100
      500050004C004900430041005A0049004F004E00450005000000000000000000
      0000}
    AfterQuery = insT002AfterQuery
    Left = 68
    Top = 12
  end
  object Q1: TOracleDataSet
    ReadBuffer = 2000
    Optimize = False
    QueryAllRecords = False
    CountAllRecords = True
    Left = 188
    Top = 17
  end
  object DS1: TDataSource
    DataSet = Q1
    Left = 184
    Top = 68
  end
  object dsrValori: TDataSource
    DataSet = cdsValori
    Left = 249
    Top = 67
  end
  object selT002TrovaQuery: TOracleQuery
    SQL.Strings = (
      'select count(distinct T002.NOME) as NUM_REC'
      '  from T002_QUERYPERSONALIZZATE T002'
      ' where T002.APPLICAZIONE = :APPLICAZIONE'
      '   and trim(T002.NOME) = trim(:QRY_NOME)')
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000120000003A005100520059005F00
      4E004F004D004500050000000000000000000000}
    Left = 38
    Top = 120
  end
  object selT005: TOracleDataSet
    SQL.Strings = (
      'select T005.ID, T005.DESCRIZIONE, count(*)'
      
        '  from T005_RAGGRQUERYPERS T005, T006_ASSOCIA_QUERYPERS_RAGGR T0' +
        '06'
      ' where T005.ID = T006.ID'
      '   and exists (select 1 '
      '                 from T002_QUERYPERSONALIZZATE T002 '
      '                where T002.NOME = T006.COD_QUERY '
      '                  and T002.APPLICAZIONE = :APPLICAZIONE)'
      ' group by T005.ID, T005.DESCRIZIONE'
      'having count(*) > 0'
      ' order by T005.DESCRIZIONE')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    Left = 110
    Top = 121
  end
  object delT006: TOracleQuery
    SQL.Strings = (
      
        'delete from T006_ASSOCIA_QUERYPERS_RAGGR where COD_QUERY = :COD_' +
        'QUERY')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A0043004F0044005F0051005500450052005900
      050000000000000000000000}
    Left = 170
    Top = 121
  end
  object selQ104: TOracleDataSet
    SQL.Strings = (
      'select Q104.* '
      '  from Q104_CONTATTI Q104'
      ' where Q104.CLIENTE = :CLIENTE'
      '   and Q104.MAILING_LIST like '#39'%'#39'||:MAILING_LIST||'#39'%'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0043004C00490045004E005400450005000000
      00000000000000001A0000003A004D00410049004C0049004E0047005F004C00
      490053005400050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D0000000E00000043004C00490045004E0054004500010000000000
      080000005300450044004500010000000000140000004E004F004D0049004E00
      41005400490056004F000100000000000E00000043004F004400510055004100
      4C000100000000000E0000005500460046004900430049004F00010000000000
      0C0000004E0055004D00540045004C000100000000000C0000004E0055004D00
      4600410058000100000000000A00000045004D00410049004C00010000000000
      1400000046004C0041004700410054005400490056004F000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000001200
      000046004C00410047004A004F004C004C005900010000000000160000004600
      4C0041004700440045004600410055004C005400010000000000180000004600
      4C004100470045004D00410049004C00410047004700010000000000}
    Left = 480
    Top = 12
    object selQ104CLIENTE: TStringField
      FieldName = 'CLIENTE'
      Required = True
      Size = 50
    end
    object selQ104SEDE: TStringField
      FieldName = 'SEDE'
      Required = True
      Size = 5
    end
    object selQ104NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Required = True
      Size = 100
    end
    object selQ104CODQUAL: TStringField
      FieldName = 'CODQUAL'
      Size = 5
    end
    object selQ104UFFICIO: TStringField
      FieldName = 'UFFICIO'
      Size = 50
    end
    object selQ104NUMTEL: TStringField
      FieldName = 'NUMTEL'
      Size = 80
    end
    object selQ104NUMFAX: TStringField
      FieldName = 'NUMFAX'
      Size = 80
    end
    object selQ104EMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object selQ104FLAGATTIVO: TStringField
      FieldName = 'FLAGATTIVO'
      Required = True
      Size = 1
    end
    object selQ104PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selQ104FLAGJOLLY: TStringField
      FieldName = 'FLAGJOLLY'
      Required = True
      Size = 1
    end
    object selQ104FLAGDEFAULT: TStringField
      FieldName = 'FLAGDEFAULT'
      Required = True
      Size = 1
    end
    object selQ104FLAGEMAILAGG: TStringField
      FieldName = 'FLAGEMAILAGG'
      Required = True
      Size = 1
    end
  end
  object selQ104Esterni: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from q104_contatti'
      'where progressivo = :PROGRESSIVO'
      '  and email is not null')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D0000000E00000043004C00490045004E0054004500010000000000
      080000005300450044004500010000000000140000004E004F004D0049004E00
      41005400490056004F000100000000000E00000043004F004400510055004100
      4C000100000000000E0000005500460046004900430049004F00010000000000
      0C0000004E0055004D00540045004C000100000000000C0000004E0055004D00
      4600410058000100000000000A00000045004D00410049004C00010000000000
      1400000046004C0041004700410054005400490056004F000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000001200
      000046004C00410047004A004F004C004C005900010000000000160000004600
      4C0041004700440045004600410055004C005400010000000000180000004600
      4C004100470045004D00410049004C00410047004700010000000000}
    Left = 483
    Top = 67
    object selQ104EsterniCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Required = True
      Size = 50
    end
    object selQ104EsterniSEDE: TStringField
      FieldName = 'SEDE'
      Required = True
      Size = 5
    end
    object selQ104EsterniNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Required = True
      Size = 100
    end
    object selQ104EsterniCODQUAL: TStringField
      FieldName = 'CODQUAL'
      Size = 5
    end
    object selQ104EsterniUFFICIO: TStringField
      FieldName = 'UFFICIO'
      Size = 50
    end
    object selQ104EsterniNUMTEL: TStringField
      FieldName = 'NUMTEL'
      Size = 80
    end
    object selQ104EsterniNUMFAX: TStringField
      FieldName = 'NUMFAX'
      Size = 80
    end
    object selQ104EsterniEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object selQ104EsterniFLAGATTIVO: TStringField
      FieldName = 'FLAGATTIVO'
      Required = True
      Size = 1
    end
    object selQ104EsterniPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selQ104EsterniFLAGJOLLY: TStringField
      FieldName = 'FLAGJOLLY'
      Required = True
      Size = 1
    end
    object selQ104EsterniFLAGDEFAULT: TStringField
      FieldName = 'FLAGDEFAULT'
      Required = True
      Size = 1
    end
    object selQ104EsterniFLAGEMAILAGG: TStringField
      FieldName = 'FLAGEMAILAGG'
      Required = True
      Size = 1
    end
  end
  object selT002RigaProtetta: TOracleDataSet
    SQL.Strings = (
      'select T002.*, T002.ROWID'
      '  from T002_QUERYPERSONALIZZATE T002'
      ' where NOME=:NOME'
      '   and NOME not in (select NOME'
      '                      from T002_QUERYPERSONALIZZATE'
      '                     where POSIZ=:POSIZ_PROTETTA'
      '                       and RIGA = '#39'S'#39')'
      'order by POSIZ')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A004E004F004D00450005000000000000000000
      00001E0000003A0050004F00530049005A005F00500052004F00540045005400
      54004100030000000000000000000000}
    Left = 420
    Top = 132
  end
  object selQ003: TOracleDataSet
    SQL.Strings = (
      'select Q003.*, Q003.ROWID'
      '  from Q003_TESTOMESSAGGIO Q003'
      ' where NOMEQUERY = :NOMEQUERY')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004E004F004D00450051005500450052005900
      050000000000000000000000}
    Left = 496
    Top = 132
  end
end
