object A029FBudgetDtM1: TA029FBudgetDtM1
  OldCreateOrder = True
  OnCreate = A029FBudgetDtM1Create
  OnDestroy = A029FBudgetDtM1Destroy
  Height = 419
  Width = 475
  object QDip: TOracleDataSet
    Optimize = False
    Left = 325
    Top = 8
  end
  object upd070: TOracleQuery
    SQL.Strings = (
      'UPDATE T070_SCHEDARIEPIL '
      'SET LIQ_FUORI_BUDGET = NVL(LIQ_FUORI_BUDGET,0) + :LIQUIDATO'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND DATA = :DATA')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004C0049005100550049004400410054004F00
      030000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000}
    Left = 371
    Top = 8
  end
  object updT070a: TOracleQuery
    SQL.Strings = (
      'UPDATE T070_SCHEDARIEPIL '
      'SET LIQ_FUORI_BUDGET = :MaxLiquidato'
      
        '  WHERE PROGRESSIVO = :PROGRESSIVO AND DATA = :DATA AND LIQ_FUOR' +
        'I_BUDGET > :MaxLiquidato')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000001A0000003A004D00410058004C004900510055004900
      4400410054004F00030000000000000000000000}
    Left = 421
    Top = 8
  end
  object selT713: TOracleDataSet
    SQL.Strings = (
      'select distinct codgruppo, filtro_anagrafe'
      'from t713_budgetanno'
      'where :data between decorrenza and decorrenza_fine'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 24
    Top = 8
  end
  object Q430: TOracleQuery
    Optimize = False
    Left = 234
    Top = 8
  end
  object selT714: TOracleDataSet
    SQL.Strings = (
      'SELECT T714.*, T714.ROWID'
      'FROM T714_BUDGETMESE T714'
      'WHERE CODGRUPPO = :CODGRUPPO'
      'AND TIPO = :TIPO'
      'AND DECORRENZA = :DECORRENZA'
      'AND MESE = :MESE')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      0000000000000A0000003A004D00450053004500030000000000000000000000
      160000003A004400450043004F005200520045004E005A0041000C0000000000
      000000000000}
    Left = 162
    Top = 8
  end
  object selbT713: TOracleDataSet
    SQL.Strings = (
      'select tipo, decorrenza, descrizione'
      'from t713_budgetanno'
      'where :data between decorrenza and decorrenza_fine'
      'and codgruppo = :codgruppo'
      'and tipo = :tipo')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000140000003A0043004F004400470052005500500050004F00050000000000
      0000000000000A0000003A005400490050004F00050000000000000000000000}
    Left = 89
    Top = 8
  end
  object cdsBudget: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ORE'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 322
    Top = 112
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
    Left = 280
    Top = 8
  end
  object selBudget1: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  SELECT OREMINUTI(T714.ORE),T714.IMPORTO'
      '  INTO :ORE,:IMPORTO'
      '  FROM T714_BUDGETMESE T714,'
      '      (SELECT CODGRUPPO, DECORRENZA, TIPO, ORE'
      '       FROM T713_BUDGETANNO'
      '       WHERE :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      '       AND TIPO = '#39'#LIQ#'#39
      '       AND FILTRO_ANAGRAFE = :FILTRO_ANAGRAFE_STR) T713'
      '  WHERE T714.CODGRUPPO = T713.CODGRUPPO'
      '  AND T714.TIPO = T713.TIPO'
      '  AND T714.DECORRENZA = T713.DECORRENZA'
      '  AND T714.MESE = TO_NUMBER(TO_CHAR(:DATA,'#39'MM'#39'));'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      '    :IMPORTO:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A004F0052004500030000000000000000000000
      0A0000003A0044004100540041000C0000000000000000000000280000003A00
      460049004C00540052004F005F0041004E004100470052004100460045005F00
      530054005200050000000000000000000000100000003A0049004D0050004F00
      520054004F00040000000000000000000000}
    Left = 88
    Top = 64
  end
  object selBudget2: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/ '
      '         nvl(sum(OREMINUTI(T071.LIQUIDNELMESE)),0)'
      '  into   :ORE'
      '  from   T071_SCHEDAFASCE T071, '
      '         :QVISTAORACLE'
      '  and    T071.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T071.DATA = :DATA  '
      '  and    :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000080000003A004F00520045000300000000000000000000001A0000003A00
      5100560049005300540041004F005200410043004C0045000100000000000000
      00000000280000003A00460049004C00540052004F005F0041004E0041004700
      52004100460045005F00530055004200010000000000000000000000}
    Left = 89
    Top = 112
  end
  object selBudget3: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/ '
      '         sum(nvl(T070.LIQ_FUORI_BUDGET,0))'
      '  into   :ORE'
      '  from   T070_SCHEDARIEPIL T070, '
      '         :QVISTAORACLE'
      '  and    T070.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T070.DATA = :DATA'
      '  and    :FILTRO_ANAGRAFE_SUB ;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000080000003A004F0052004500030000000000000000000000}
    Left = 88
    Top = 160
  end
  object selBudget4: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/ '
      '         nvl(sum(OREMINUTI(T074.LIQUIDATO)),0) '
      '  into   :ORE'
      '  from   T074_CAUSPRESFASCE T074,'
      '         T275_CAUPRESENZE T275,'
      '         T430_STORICO T430,'
      '         :QVISTAORACLE'
      '  and    T074.PROGRESSIVO = T430.PROGRESSIVO  '
      '  and    T074.DATA = :DATA'
      '  and    T074.CAUSALE = T275.CODICE'
      '  and    T275.ABBATTE_BUDGET = '#39'L'#39
      '  and    T430.PROGRESSIVO = V430.T430PROGRESSIVO'
      
        '  and    last_day(:DATA) between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '  and    :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000080000003A004F0052004500030000000000000000000000}
    Left = 89
    Top = 208
  end
  object selBudget5: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/  '
      '         nvl(sum(OREMINUTI(OREPRESENZA)),0)'
      '  into   :ORE'
      '  from   T074_CAUSPRESFASCE T074,'
      '         T275_CAUPRESENZE T275,'
      '         :QVISTAORACLE'
      '  and    T074.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T074.DATA = :DATA'
      '  and    T074.CAUSALE = T275.CODICE'
      '  and    T275.ABBATTE_BUDGET = '#39'M'#39
      '  and    :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000080000003A004F0052004500030000000000000000000000}
    Left = 89
    Top = 264
  end
  object selBudget2Imp: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/ '
      
        '         nvl(sum(round(round((nvl(OREMINUTI(T071.LIQUIDNELMESE),' +
        '0) / 60),2) * nvl(T730.TARIFFA_LIQ,0),2)),0)'
      '  into   :IMPORTO'
      '  from   T071_SCHEDAFASCE T071,'
      '         T730_VALUTAORE T730,'
      '         --T430_STORICO T430,'
      '         :QVISTAORACLE'
      '  and    T071.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T071.DATA =:DATA'
      '  and    T730.LIVELLO = :LIVELLO'
      '  and    T730.CAUSALE = '#39'#LIQ#'#39
      '  and    T730.MAGGIORAZIONE = T071.MAGGIORAZIONE'
      
        '  and    last_day(:DATA) between T730.DECORRENZA and T730.DECORR' +
        'ENZA_FINE'
      '  --and    T430.PROGRESSIVO = V430.T430PROGRESSIVO'
      
        '  --and    last_day(:DATA) between T430.DATADECORRENZA and T430.' +
        'DATAFINE'
      '  and    :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :IMPORTO:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000100000003A0049004D0050004F00520054004F000400000000000000
      00000000100000003A004C004900560045004C004C004F000100000000000000
      00000000}
    Left = 162
    Top = 112
  end
  object selBudget7: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/ '
      '         nvl(sum(OREMINUTI(T071.BANCA_ORE)),0)'
      '  into   :ORE'
      '  FROM   T071_SCHEDAFASCE T071,'
      '         :QVISTAORACLE'
      '  and    T071.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T071.DATA = :DATA  '
      '  and   :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000080000003A004F0052004500030000000000000000000000}
    Left = 88
    Top = 312
  end
  object selBudget8: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select nvl(sum(OREMINUTI('
      '         DECODE(T275.VOCEPAGHELIQ1,'
      '                NULL,'
      '                DECODE(T275.VOCEPAGHELIQ2,NULL,'
      
        '                                          DECODE(T275.VOCEPAGHEL' +
        'IQ3,NULL,'
      
        '                                                                ' +
        '    DECODE(T275.VOCEPAGHELIQ4,NULL,'
      
        '                                                                ' +
        '                              OREPRESENZA,'
      
        '                                                                ' +
        '                              LIQUIDATO),'
      
        '                                                                ' +
        '    LIQUIDATO),'
      '                                          LIQUIDATO),'
      '                LIQUIDATO)'
      '         )),0) ORE'
      '  into   :ORE'
      '  from   T074_CAUSPRESFASCE T074,'
      '         T275_CAUPRESENZE T275,'
      '         T430_STORICO T430,'
      '         :QVISTAORACLE'
      '  and    T074.PROGRESSIVO = T430.PROGRESSIVO'
      '  and    T074.DATA = :DATA'
      '  and    T074.CAUSALE = T275.CODICE'
      '  and    T275.CODICE = :CAUSALE'
      '  and    T430.PROGRESSIVO = V430.T430PROGRESSIVO  '
      
        '  and    last_day(:DATA) between T430.DATADECORRENZA and T430.DA' +
        'TAFINE'
      '  and    :FILTRO_ANAGRAFE_SUB'
      '  group by T074.CAUSALE;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :ORE:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000080000003A004F005200450003000000000000000000000010000000
      3A00430041005500530041004C004500050000000000000000000000}
    Left = 89
    Top = 360
  end
  object selBudget4Imp: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ index(V430 T430_BUDGET)*/ '
      
        '         nvl(sum(round(round((nvl(OREMINUTI(T074.LIQUIDATO),0) /' +
        ' 60),2) * nvl(T730.TARIFFA_LIQ,0),2)),0)'
      '  into   :IMPORTO'
      '  from   T074_CAUSPRESFASCE T074,'
      '         T275_CAUPRESENZE T275,'
      '         T730_VALUTAORE T730,'
      '         --T430_STORICO T430,'
      '         :QVISTAORACLE'
      '  and    T074.PROGRESSIVO = T030.PROGRESSIVO  '
      '  and    T074.DATA = :DATA'
      '  and    T074.CAUSALE = T275.CODICE'
      
        '  and    T275.ABBATTE_BUDGET in ('#39'L'#39','#39'M'#39') -- modifica per REGGIO' +
        'EMILIA_COMUNE: considera anche le causali con abbattimento mat.'
      '  and    T730.LIVELLO = :LIVELLO'
      '  and    T730.CAUSALE = T074.CAUSALE'
      '  and    T730.MAGGIORAZIONE = T074.MAGGIORAZIONE'
      
        '  and    last_day(:DATA) between T730.DECORRENZA and T730.DECORR' +
        'ENZA_FINE'
      '  --and    T430.PROGRESSIVO = V430.T430PROGRESSIVO'
      
        '  --and    last_day(:DATA) between T430.DATADECORRENZA and T430.' +
        'DATAFINE'
      '  and    :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :IMPORTO:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000100000003A0049004D0050004F00520054004F000400000000000000
      00000000100000003A004C004900560045004C004C004F000100000000000000
      00000000}
    Left = 162
    Top = 208
  end
  object selBudget5Imp: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/  '
      
        '         nvl(sum(round(round((nvl(OREMINUTI(T074.OREPRESENZA),0)' +
        ' / 60),2) * nvl(T730.TARIFFA_MAT,0),2)),0)'
      '  into   :IMPORTO'
      '  from   T074_CAUSPRESFASCE T074,'
      '         T275_CAUPRESENZE T275,'
      '         T730_VALUTAORE T730,'
      '         --T430_STORICO T430,'
      '         :QVISTAORACLE'
      '  and    T074.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T074.DATA = :DATA'
      '  and    T074.CAUSALE = T275.CODICE'
      
        '  and    T275.ABBATTE_BUDGET in ('#39'M'#39','#39'L'#39') -- modifica per REGGIO' +
        'EMILIA_COMUNE: considera anche le causali con abbattimento liq.'
      '  and    T730.LIVELLO = :LIVELLO'
      '  and    T730.CAUSALE = T074.CAUSALE'
      '  and    T730.MAGGIORAZIONE = T074.MAGGIORAZIONE'
      
        '  and    last_day(:DATA) between T730.DECORRENZA and T730.DECORR' +
        'ENZA_FINE'
      '  --and    T430.PROGRESSIVO = V430.T430PROGRESSIVO'
      
        '  --and    last_day(:DATA) between T430.DATADECORRENZA and T430.' +
        'DATAFINE'
      '  and    :FILTRO_ANAGRAFE_SUB;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :IMPORTO:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000100000003A0049004D0050004F00520054004F000400000000000000
      00000000100000003A004C004900560045004C004C004F000100000000000000
      00000000}
    Left = 162
    Top = 264
  end
  object selBudget8Imp: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  select /*+ INDEX(T430_STORICO T430_BUDGET)*/ '
      
        '         nvl(sum(decode(T275.VOCEPAGHELIQ1||T275.VOCEPAGHELIQ2||' +
        'T275.VOCEPAGHELIQ3||T275.VOCEPAGHELIQ4,'
      '                        null,'
      
        '                        round(round((nvl(OREMINUTI(T074.OREPRESE' +
        'NZA),0) / 60),2) * nvl(T730.TARIFFA_MAT,0),2),'
      
        '                        round(round((nvl(OREMINUTI(T074.LIQUIDAT' +
        'O),0) / 60),2) * nvl(T730.TARIFFA_LIQ,0),2)'
      '                       )),0)'
      '  into   :IMPORTO'
      '  from   T074_CAUSPRESFASCE T074,'
      '         T275_CAUPRESENZE T275,'
      '         T730_VALUTAORE T730,'
      '         :QVISTAORACLE'
      '  and    T074.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T074.DATA = :DATA'
      '  and    T074.CAUSALE = T275.CODICE'
      '  and    T275.CODICE = :CAUSALE'
      '  and    T730.LIVELLO = :LIVELLO'
      '  and    T730.CAUSALE = T074.CAUSALE'
      '  and    T730.MAGGIORAZIONE = T074.MAGGIORAZIONE'
      
        '  and    last_day(:DATA) between T730.DECORRENZA and T730.DECORR' +
        'ENZA_FINE'
      '  and    :FILTRO_ANAGRAFE_SUB'
      '  group by T074.CAUSALE;'
      'EXCEPTION'
      '  WHEN OTHERS THEN'
      '    :IMPORTO:=0;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A0044004100540041000C000000000000000000
      00001A0000003A005100560049005300540041004F005200410043004C004500
      010000000000000000000000280000003A00460049004C00540052004F005F00
      41004E004100470052004100460045005F005300550042000100000000000000
      00000000100000003A00430041005500530041004C0045000500000000000000
      00000000100000003A0049004D0050004F00520054004F000400000000000000
      00000000100000003A004C004900560045004C004C004F000500000000000000
      00000000}
    Left = 162
    Top = 360
  end
  object selCtrlBudget: TOracleQuery
    SQL.Strings = (
      'select /*+ index(V430 T430_BUDGET)*/ '
      
        '       nvl(T730.TARIFFA_LIQ,0), round(round((:ORE / 60),2) * nvl' +
        '(T730.TARIFFA_LIQ,0),2)'
      'from   T730_VALUTAORE T730,'
      '       T430_STORICO T430'
      'where  T730.LIVELLO = :LIVELLO'
      'and    T730.CAUSALE = :CAUSALE'
      'and    T730.MAGGIORAZIONE = :MAGGIORAZIONE'
      
        'and    last_day(:DATA) between T730.DECORRENZA and T730.DECORREN' +
        'ZA_FINE'
      
        'and    :CAUSALE in (select CODICE from T275_CAUPRESENZE where AB' +
        'BATTE_BUDGET in ('#39'L'#39','#39'M'#39') union select '#39'#LIQ#'#39' from dual)'
      'and    T430.PROGRESSIVO = :PROGRESSIVO'
      
        'and    last_day(:DATA) between T430.DATADECORRENZA and T430.DATA' +
        'FINE')
    Optimize = False
    Variables.Data = {
      0400000006000000080000003A004F0052004500030000000000000000000000
      100000003A00430041005500530041004C004500050000000000000000000000
      100000003A004C004900560045004C004C004F00010000000000000000000000
      1C0000003A004D0041004700470049004F00520041005A0049004F004E004500
      0400000000000000000000000A0000003A0044004100540041000C0000000000
      000000000000180000003A00500052004F004700520045005300530049005600
      4F00030000000000000000000000}
    Left = 250
    Top = 112
  end
end
