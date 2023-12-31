inherited A065FStampaBudgetMW: TA065FStampaBudgetMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 218
  Width = 405
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'#LIQ#'#39' codice, '#39'Ore liquidabili'#39' descrizione, '#39'A'#39' ordine'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'#B.O#'#39' codice, '#39'Banca ore'#39' descrizione, '#39'B'#39' ordine'
      'FROM DUAL'
      'UNION'
      
        'SELECT '#39'#ECC#'#39' codice, '#39'Saldo positivo anno corrente'#39' descrizion' +
        'e, '#39'C'#39' ordine'
      'FROM DUAL'
      'UNION'
      'select t.codice, t.descrizione, '#39'D'#39' ordine'
      'from t275_caupresenze t'
      'order by 3,1')
    Optimize = False
    BeforeOpen = selT275BeforeOpen
    Left = 104
    Top = 16
    object selT275CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT275DESCRIZIONE: TStringField
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT275ORDINE: TStringField
      FieldName = 'ORDINE'
      Size = 1
    end
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MAGGIORAZIONE, MINUTIORE(SUM(ORE)) LIQUIDNELMESE, MINUTIO' +
        'RE(SUM(BANCA_ORE)) BANCA_ORE FROM ('
      
        'SELECT MAGGIORAZIONE,OREMINUTI(LIQUIDNELMESE) ORE,OREMINUTI(BANC' +
        'A_ORE) BANCA_ORE'
      'FROM T071_SCHEDAFASCE'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND DATA = :DATA'
      'UNION ALL'
      
        'SELECT MAGGIORAZIONE,NVL(OREMINUTI(DECODE(T275.ABBATTE_BUDGET,'#39'L' +
        #39',LIQUIDATO,OREPRESENZA)),0) ORE, 0 BANCA_ORE'
      'FROM T074_CAUSPRESFASCE T074,T275_CAUPRESENZE T275'
      'WHERE T074.DATA = :DATA'
      'AND T074.CAUSALE = T275.CODICE '
      'AND T275.ABBATTE_BUDGET IN ('#39'L'#39','#39'M'#39')'
      'AND T074.PROGRESSIVO = :PROGRESSIVO '
      'AND T074.CAUSALE = T275.CODICE'
      ')'
      'GROUP BY MAGGIORAZIONE'
      'ORDER BY MAGGIORAZIONE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 268
    Top = 16
  end
  object Q730: TOracleDataSet
    SQL.Strings = (
      'SELECT MAGGIORAZIONE,TARIFFA_LIQ FROM T730_VALUTAORE'
      'WHERE'
      'LIVELLO = :LIVELLO AND'
      ':DATA BETWEEN DECORRENZA AND NVL(DECORRENZA_FINE,:DATA)'
      '')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A004C004900560045004C004C004F0005000000
      00000000000000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 351
    Top = 16
  end
  object selT713: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM T713_BUDGETANNO'
      'WHERE ANNO = :ANNO'
      'AND (TIPO = :TIPO OR :TIPO IS NULL)'
      'AND DECORRENZA <= :ADATA AND DECORRENZA_FINE >= :DADATA'
      'ORDER BY CODGRUPPO, TIPO, DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A005400490050004F000500000000000000000000000C000000
      3A00410044004100540041000C00000000000000000000000E0000003A004400
      410044004100540041000C0000000000000000000000}
    Left = 8
    Top = 16
  end
  object selT714: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM T714_BUDGETMESE'
      'WHERE CODGRUPPO = :CODGRUPPO'
      'AND TIPO = :TIPO'
      'AND DECORRENZA = :DECORRENZA'
      'AND MESE BETWEEN :MESEDA AND :MESEA'
      'ORDER BY CODGRUPPO, DECORRENZA, MESE')
    Optimize = False
    Variables.Data = {
      0400000005000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C00000000000000000000000E0000003A004D00450053004500440041000300
      000000000000000000000C0000003A004D004500530045004100030000000000
      000000000000}
    Left = 56
    Top = 16
  end
  object dsrT275: TDataSource
    DataSet = selT275
    Left = 104
    Top = 64
  end
  object cdsApp: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 104
    Top = 112
  end
  object dsrApp: TDataSource
    DataSet = cdsApp
    OnDataChange = dsrAppDataChange
    Left = 104
    Top = 160
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t030.progressivo'
      'from :QVistaOracle'
      'and :filtro')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000180000003A0043003700
      300030004400410054004100440041004C000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 152
    Top = 16
  end
  object selaV430: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t030.progressivo'
      'from :QVistaOracle'
      'and :filtro')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000180000003A0043003700
      300030004400410054004100440041004C000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 152
    Top = 64
  end
  object cdsStampa: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODGRUPPO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DECORRENZA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'MESE'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'ORE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ORE_FRUITO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ORE_RESIDUO'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 216
    Top = 16
  end
  object selbV430: TOracleDataSet
    SQL.Strings = (
      
        'select t030.progressivo, t030.cognome, t030.nome, t430badge, t07' +
        '0.liq_fuori_budget :livello'
      'from t070_schedariepil t070, :QVistaOracle'
      'and :filtro'
      'and t030.progressivo = t070.progressivo (+)'
      'and t070.data (+) = :DATA_SCHEDA'
      'order by t030.cognome, t030.nome, t430badge')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C0000000000000000000000100000003A004C004900
      560045004C004C004F00010000000000000000000000180000003A0044004100
      540041005F005300430048004500440041000C00000000000000000000001800
      00003A0043003700300030004400410054004100440041004C000C0000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 152
    Top = 112
  end
  object selT074: TOracleDataSet
    SQL.Strings = (
      'SELECT MAGGIORAZIONE,'
      'DECODE(T275.VOCEPAGHELIQ1,'
      '       NULL,'
      '       DECODE(T275.VOCEPAGHELIQ2,NULL,'
      '                                 DECODE(T275.VOCEPAGHELIQ3,NULL,'
      
        '                                                           DECOD' +
        'E(T275.VOCEPAGHELIQ4,NULL,'
      
        '                                                                ' +
        '                     OREPRESENZA,'
      
        '                                                                ' +
        '                     LIQUIDATO),'
      
        '                                                           LIQUI' +
        'DATO),'
      '                                 LIQUIDATO),'
      '       LIQUIDATO) ORE'
      'FROM T074_CAUSPRESFASCE T074,T275_CAUPRESENZE T275'
      'WHERE T074.DATA = :DATA'
      'AND T275.CODICE = :CAUSALE'
      'AND T074.PROGRESSIVO = :PROGRESSIVO '
      'AND T074.CAUSALE = T275.CODICE'
      'ORDER BY MAGGIORAZIONE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000}
    Left = 308
    Top = 16
  end
  object updT714: TOracleQuery
    SQL.Strings = (
      'update t714_budgetmese'
      'set ore = :ORE,'
      '    importo = :IMPORTO'
      'where codgruppo = :CODGRUPPO'
      'and tipo = :TIPO'
      'and decorrenza = :DECORRENZA'
      'and mese = :MESE')
    Optimize = False
    Variables.Data = {
      0400000006000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C00000000000000000000000A0000003A004D00450053004500030000000000
      000000000000080000003A004F00520045000100000000000000000000001000
      00003A0049004D0050004F00520054004F00010000000000000000000000}
    Left = 56
    Top = 64
  end
end
