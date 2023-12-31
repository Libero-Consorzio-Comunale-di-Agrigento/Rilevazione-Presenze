inherited A063FBudgetGenerazioneMW: TA063FBudgetGenerazioneMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 224
  Width = 326
  object selT713: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM T713_BUDGETANNO'
      'WHERE ANNO = :ANNO'
      'AND (TIPO = :TIPO OR :TIPO IS NULL)'
      'ORDER BY CODGRUPPO, TIPO, DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      00000A0000003A005400490050004F00050000000000000000000000}
    Left = 16
    Top = 16
  end
  object delT714: TOracleQuery
    SQL.Strings = (
      'delete t714_budgetmese'
      'where codgruppo = :CODGRUPPO'
      'and tipo = :TIPO'
      'and decorrenza = :DECORRENZA'
      'and mese = :MESE')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C00000000000000000000000A0000003A004D00450053004500030000000000
      000000000000}
    Left = 80
    Top = 64
  end
  object insT714: TOracleQuery
    SQL.Strings = (
      'insert into t714_budgetmese'
      '(codgruppo,'
      ' tipo,'
      ' decorrenza,'
      ' mese,'
      ' ore,'
      ' importo,'
      ' ore_fruito,'
      ' importo_fruito)'
      'values'
      '(:CODGRUPPO,'
      ' :TIPO,'
      ' :DECORRENZA,'
      ' :MESE,'
      ' :ORE,'
      ' :IMPORTO,'
      ' :ORE_FRUITO,'
      ' :IMPORTO_FRUITO)'
      '')
    Optimize = False
    Variables.Data = {
      0400000008000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C00000000000000000000000A0000003A004D00450053004500030000000000
      000000000000080000003A004F00520045000500000000000000000000001000
      00003A0049004D0050004F00520054004F000400000000000000000000001600
      00003A004F00520045005F00460052005500490054004F000500000000000000
      000000001E0000003A0049004D0050004F00520054004F005F00460052005500
      490054004F00040000000000000000000000}
    Left = 80
    Top = 160
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
    Left = 80
    Top = 112
  end
  object selT714: TOracleDataSet
    SQL.Strings = (
      'select t714.*, t714.rowid'
      'from t714_budgetmese t714'
      'where codgruppo = :CODGRUPPO'
      'and tipo = :TIPO'
      'and decorrenza = :DECORRENZA'
      'order by mese')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    Left = 80
    Top = 16
  end
  object cdsDip: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'CODGRUPPO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DA'
        DataType = ftDateTime
      end
      item
        Name = 'A'
        DataType = ftDateTime
      end>
    IndexDefs = <
      item
        Name = 'INDICE'
        Expression = 'PROGRESSIVO,DA,A,CODGRUPPO'
        Options = [ixExpression]
      end>
    Params = <>
    StoreDefs = True
    Left = 144
    Top = 112
  end
  object cdsAnom: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'CODGRUPPO1'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'CODGRUPPO2'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DA'
        DataType = ftDateTime
      end
      item
        Name = 'A'
        DataType = ftDateTime
      end>
    IndexDefs = <
      item
        Name = 'INDICE'
        Expression = 'PROGRESSIVO,CODGRUPPO1,CODGRUPPO2,DA,A'
        Options = [ixExpression]
      end>
    Params = <>
    StoreDefs = True
    Left = 144
    Top = 160
  end
  object selaT713: TOracleDataSet
    SQL.Strings = (
      
        'select distinct codgruppo, decorrenza, decorrenza_fine, filtro_a' +
        'nagrafe'
      'from t713_budgetanno'
      'where anno = :ANNO'
      'order by codgruppo, decorrenza')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    Left = 16
    Top = 64
  end
  object selbV430: TOracleDataSet
    SQL.Strings = (
      'select t030.progressivo,'
      '       greatest(t430datadecorrenza,t430inizio,:C700DATADAL) da, '
      
        '       least(t430datafine,nvl(t430fine,:DATALAVORO),:DATALAVORO)' +
        ' a'
      'from :QVistaOracle'
      'and :filtro'
      'order by 1,2,3')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00460049004C00540052004F00010000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C004500010000000000000000000000180000003A0043003700300030004400
      410054004100440041004C000C0000000000000000000000160000003A004400
      4100540041004C00410056004F0052004F000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 144
    Top = 64
  end
  object selT071: TOracleDataSet
    SQL.Strings = (
      'SELECT MAGGIORAZIONE,LIQUIDNELMESE,BANCA_ORE'
      'FROM T071_SCHEDAFASCE'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      'AND DATA = :DATA'
      'ORDER BY MAGGIORAZIONE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000500000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 144
    Top = 16
  end
  object insT713: TOracleQuery
    SQL.Strings = (
      'insert into t713_budgetanno'
      '(codgruppo, '
      ' tipo, '
      ' decorrenza, '
      ' decorrenza_fine, '
      ' anno, '
      ' descrizione, '
      ' filtro_anagrafe, '
      ' ore, '
      ' importo)'
      'values'
      '(:CODGRUPPO,'
      ' :TIPO,'
      ' :DECORRENZA,'
      ' :DECORRENZA_FINE, '
      ' :ANNO, '
      ' :DESCRIZIONE, '
      ' :FILTRO_ANAGRAFE, '
      ' :ORE, '
      ' :IMPORTO)')
    Optimize = False
    Variables.Data = {
      0400000009000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000080000003A004F00520045000500000000000000
      00000000100000003A0049004D0050004F00520054004F000400000000000000
      00000000200000003A004400450043004F005200520045004E005A0041005F00
      460049004E0045000C00000000000000000000000A0000003A0041004E004E00
      4F00030000000000000000000000180000003A00440045005300430052004900
      5A0049004F004E004500050000000000000000000000200000003A0046004900
      4C00540052004F005F0041004E00410047005200410046004500050000000000
      000000000000}
    Left = 16
    Top = 160
  end
  object selbT713: TOracleDataSet
    SQL.Strings = (
      'SELECT TIPO, DECORRENZA, DECORRENZA_FINE'
      'FROM T713_BUDGETANNO'
      'WHERE CODGRUPPO = :CODGRUPPO'
      'AND DECORRENZA <= :DECORRENZA_FINE'
      'AND DECORRENZA_FINE >= :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F004400470052005500500050004F00
      050000000000000000000000200000003A004400450043004F00520052004500
      4E005A0041005F00460049004E0045000C000000000000000000000016000000
      3A004400450043004F005200520045004E005A0041000C000000000000000000
      0000}
    Left = 16
    Top = 112
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t030.progressivo'
      'from :QVistaOracle'
      'and :filtro')
    ReadBuffer = 5000
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
    Left = 208
    Top = 16
  end
  object selaV430: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT t030.progressivo'
      'from :QVistaOracle'
      'and :filtro')
    ReadBuffer = 5000
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
    Left = 208
    Top = 64
  end
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
    Left = 264
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
end
