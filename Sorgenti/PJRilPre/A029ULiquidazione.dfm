object A029FLiquidazione: TA029FLiquidazione
  OldCreateOrder = True
  OnCreate = A029FLiquidazioneCreate
  OnDestroy = A029FLiquidazioneDestroy
  Height = 97
  Width = 216
  object Q071Liq: TOracleDataSet
    SQL.Strings = (
      
        'SELECT PROGRESSIVO,DATA,MAGGIORAZIONE,CODFASCIA,ORESTRAORDLIQ,LI' +
        'QUIDNELMESE,ROWID'
      '  FROM T071_SCHEDAFASCE WHERE '
      '  PROGRESSIVO = :Progressivo AND'
      '  DATA = :Data AND'
      '  MAGGIORAZIONE = :Maggiorazione AND'
      '  CODFASCIA = :CodFascia'
      '  ORDER BY MAGGIORAZIONE,CODFASCIA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000001C0000003A004D0041004700470049004F0052004100
      5A0049004F004E004500040000000000000000000000140000003A0043004F00
      4400460041005300430049004100050000000000000000000000}
    CachedUpdates = True
    Left = 16
    Top = 12
    object Q071LiqPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q071LiqDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object Q071LiqMAGGIORAZIONE: TFloatField
      DisplayLabel = '% Magg.'
      DisplayWidth = 2
      FieldName = 'MAGGIORAZIONE'
    end
    object Q071LiqCODFASCIA: TStringField
      FieldName = 'CODFASCIA'
      Size = 5
    end
    object Q071LiqORESTRAORDLIQ: TStringField
      FieldName = 'ORESTRAORDLIQ'
      Size = 6
    end
    object Q071LiqLIQUIDNELMESE: TStringField
      FieldName = 'LIQUIDNELMESE'
      Size = 6
    end
  end
  object Q130: TOracleDataSet
    SQL.Strings = (
      
        'SELECT PROGRESSIVO,ANNO,SALDOORELAV,ORECOMPENSABILI,BANCA_ORE,RO' +
        'WID '
      'FROM T130_RESIDANNOPREC '
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'ANNO = :ANNO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    CachedUpdates = True
    Left = 64
    Top = 12
  end
  object selLiquidato: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  select nvl(sum(OREMINUTI(ORECOMP_LIQUIDATE) + OREMINUTI(BANCAO' +
        'RE_LIQ_VAR)),0) '
      '  into  :COMPLIQUIDATOANNO'
      '  from  T070_SCHEDARIEPIL'
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA between :DATA1 and :DATA2;'
      ''
      
        '  select nvl(sum(OREMINUTI(LIQUIDNELMESE)),0) into :LIQUIDATOANN' +
        'O'
      '  from T071_SCHEDAFASCE'
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA between :DATA1 and :DATA2;'
      ''
      '  select nvl(sum(OREMINUTI(LIQUIDNELMESE)),0) '
      '  into  :LIQUIDATOMESE'
      '  from  T071_SCHEDAFASCE'
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA = :DATA;'
      ''
      
        '  select nvl(sum(OREMINUTI(decode(ORENORMALI||ABBATTE_BUDGET,'#39'AM' +
        #39',OREPRESENZA,LIQUIDATO))),0)'
      '  into  :CAUSLIQUIDATOANNO'
      '  from  T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  where T074.CAUSALE = T275.CODICE '
      '  and   PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA between :DATA1 and :DATA2 '
      
        '  and   NO_LIMITE_ANNUALE_LIQ = '#39'N'#39'                   --incluse ' +
        'nel controllo dell'#39'eccedenza liquidabile annua'
      
        '  and   ((ORENORMALI in ('#39'B'#39','#39'D'#39')) or                 --INCLUSE ' +
        'nelle ore normali'
      
        '         (ORENORMALI = '#39'A'#39' and ABBATTE_BUDGET <> '#39'N'#39') --ESCLUSE ' +
        'dalle ore normali MA CONSIDERATE NEL BUDGET'
      '        );'
      ''
      
        '  select nvl(sum(OREMINUTI(decode(ORENORMALI||ABBATTE_BUDGET,'#39'AM' +
        #39',OREPRESENZA,LIQUIDATO))),0)'
      '  into  :CAUSLIQUIDATOMESE'
      '  from  T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  where T074.CAUSALE = T275.CODICE '
      '  and   PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA = :DATA '
      
        '  and   NO_LIMITE_ANNUALE_LIQ = '#39'N'#39'  --incluse nel controllo del' +
        'l'#39'eccedenza liquidabile annua'
      
        '  and   ((ORENORMALI in ('#39'B'#39','#39'D'#39'))   --solo quelle INCLUSE nelle' +
        ' ore normali'
      
        '        /*or (ORENORMALI = '#39'A'#39' and ABBATTE_BUDGET in ('#39'L'#39','#39'M'#39'))*' +
        '/'
      '        );'
      ''
      '  select nvl(sum(OREMINUTI(OREPRESENZA)),0) '
      '  into  :CAUSRESOMESE'
      '  from  T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  where T074.CAUSALE = T275.CODICE '
      '  and   PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA = :DATA '
      '  and   ORENORMALI in ('#39'B'#39','#39'D'#39') '
      
        '  and   NO_LIMITE_MENSILE_LIQ = '#39'S'#39'  --escluse nel controllo del' +
        'l'#39'eccedenza liquidabile mensile'
      
        '  and   NO_LIMITE_ANNUALE_LIQ = '#39'N'#39'; --incluse nel controllo del' +
        'l'#39'eccedenza liquidabile annua'
      ''
      '  select nvl(sum(OREMINUTI(ORESTRAORD)),0) '
      '  into  :STRAORDESTERNOANNO'
      '  from  T075_STRESTERNO'
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA between :DATA1 and :DATA2;'
      ''
      '  select nvl(sum(OREMINUTI(ORESTRAORD)),0) '
      '  into  :STRAORDESTERNOMESE'
      '  from  T075_STRESTERNO'
      '  where PROGRESSIVO = :PROGRESSIVO '
      '  and   DATA = :DATA;'
      ''
      '  select nvl(sum(abs(least(OREMINUTI(MINASS),0))),0) '
      '  into :CAUSASSESTANNO '
      '  from ('
      '    select T071.ORE1ASSEST MINASS'
      
        '    from T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAU' +
        'GIUSTIF T305'
      '    where '
      '    T070.CAUSALE1MINASS = T305.CODICE and'
      '    T070.PROGRESSIVO = :PROGRESSIVO and'
      '    T070.DATA between :DATA1 and :DATA2 and'
      '    T071.PROGRESSIVO = T070.PROGRESSIVO and'
      '    T071.DATA = T070.DATA and'
      '    T305.LIMITE_LIQ = '#39'S'#39
      '    UNION ALL'
      '    select T071.ORE2ASSEST MINASS'
      
        '    from T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAU' +
        'GIUSTIF T305'
      '    where '
      '    T070.CAUSALE2MINASS = T305.CODICE and'
      '    T070.PROGRESSIVO = :PROGRESSIVO and'
      '    T070.DATA between :DATA1 and :DATA2 and'
      '    T071.PROGRESSIVO = T070.PROGRESSIVO and'
      '    T071.DATA = T070.DATA and'
      '    T305.LIMITE_LIQ = '#39'S'#39
      '  );'
      ''
      '  select nvl(sum(abs(least(OREMINUTI(MINASS),0))),0) '
      '  into :CAUSASSESTMESE '
      '  from ('
      '    select T071.ORE1ASSEST MINASS'
      
        '    from T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAU' +
        'GIUSTIF T305'
      '    where '
      '    T070.CAUSALE1MINASS = T305.CODICE and'
      '    T070.PROGRESSIVO = :PROGRESSIVO and'
      '    T070.DATA = :DATA and'
      '    T071.PROGRESSIVO = T070.PROGRESSIVO and'
      '    T071.DATA = T070.DATA and'
      '    T305.LIMITE_LIQ = '#39'S'#39
      '    UNION ALL'
      '    select T071.ORE2ASSEST MINASS'
      
        '    from T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAU' +
        'GIUSTIF T305'
      '    where '
      '    T070.CAUSALE2MINASS = T305.CODICE and'
      '    T070.PROGRESSIVO = :PROGRESSIVO and'
      '    T070.DATA = :DATA and'
      '    T071.PROGRESSIVO = T070.PROGRESSIVO and'
      '    T071.DATA = T070.DATA and'
      '    T305.LIMITE_LIQ = '#39'S'#39
      '  );'
      ''
      'end;')
    Optimize = False
    Variables.Data = {
      040000000E000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A004C0049005100550049004400410054004F00
      4D00450053004500030000000400000000000000000000000A0000003A004400
      4100540041000C0000000000000000000000240000003A0043004F004D005000
      4C0049005100550049004400410054004F0041004E004E004F00030000000400
      000000000000000000001C0000003A004C004900510055004900440041005400
      4F0041004E004E004F0003000000040000000000000000000000260000003A00
      53005400520041004F0052004400450053005400450052004E004F0041004E00
      4E004F0003000000040000000000000000000000260000003A00530054005200
      41004F0052004400450053005400450052004E004F004D004500530045000300
      0000040000000000000000000000240000003A0043004100550053004C004900
      5100550049004400410054004F004D0045005300450003000000040000000000
      000000000000240000003A0043004100550053004C0049005100550049004400
      410054004F0041004E004E004F00030000000400000000000000000000001A00
      00003A0043004100550053005200450053004F004D0045005300450003000000
      0400000000000000000000001E0000003A004300410055005300410053005300
      45005300540041004E004E004F00030000000400000000000000000000001E00
      00003A0043004100550053004100530053004500530054004D00450053004500
      03000000040000000000000000000000}
    Left = 116
    Top = 12
  end
end
