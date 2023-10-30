inherited B021FRiallineamentoDM: TB021FRiallineamentoDM
  OldCreateOrder = True
  Height = 147
  Width = 370
  object selStep1: TOracleDataSet
    SQL.Strings = (
      
        '/* 1. Giustificativi (richiesti e autorizzati) presenti in Firla' +
        'b e non in IrisWIN (T040 + T050): da cancellare */ '
      
        'select PROGRESSIVO, DATA, CAUSALE, DALLE, ALLE, TIPOGIUST, to_da' +
        'te(null) FAMILIARE, null AUTORIZZATORE, RICHIESTA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,RICHIESTA) POSTDATA'
      'from'
      '('
      '  -- giustificativi a giornata intera'
      '  ('
      
        '    select T030.PROGRESSIVO, T011.DATA, T.CAUSALE, null DALLE, n' +
        'ull ALLE, '#39'I'#39' TIPOGIUST, decode(T.AUTORIZZATA,'#39'true'#39','#39'N'#39','#39'S'#39') RI' +
        'CHIESTA'
      
        '    from   USR_FIRLAB_ASSENZE T, T030_ANAGRAFICO T030, T011_CALE' +
        'NDARI T011'
      '    where  T.MATRICOLA = T030.MATRICOLA'
      '    --and    T.AUTORIZZATA = '#39'true'#39
      '    and    T.PERMESSO = '#39'false'#39
      '    and    T011.CODICE = '#39'5'#39' '
      
        '    and    T011.DATA between to_date(substr(T.INIZIO,1,10),'#39'dd-m' +
        'm-yyyy'#39') and to_date(substr(T.FINE,1,10),'#39'dd-mm-yyyy'#39') - 1'
      '    minus'
      '    ('
      
        '      select T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, null DAL' +
        'LE, null ALLE, '#39'I'#39' TIPOGIUST, '#39'N'#39' RICHIESTA'
      '      from   T040_GIUSTIFICATIVI T040'
      '      where  T040.DATA >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39')'
      '      and    T040.TIPOGIUST = '#39'I'#39
      '      union all'
      
        '      select T050.PROGRESSIVO, T011.DATA, T050.CAUSALE, null DAL' +
        'LE, null ALLE, '#39'I'#39' TIPOGIUST, '#39'S'#39' RICHIESTA'
      
        '      from   VT050_RICHIESTE_SENZAREVOCA T050, T011_CALENDARI T0' +
        '11'
      '      where  T050.DAL >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39') '
      '      and    T050.ELABORATO = '#39'N'#39
      '      and    T011.DATA between T050.DAL and T050.AL'
      '      and    T011.CODICE = '#39'5'#39' '
      '      and    T050.TIPOGIUST = '#39'I'#39
      '    )  '
      '  )'
      '  union all'
      '  -- giustificativi dalle - alle'
      '  ( '
      '    select T030.PROGRESSIVO, T011.DATA, T.CAUSALE,'
      
        '    to_date('#39'30121899 '#39' || substr(T.INIZIO,12,5),'#39'ddmmyyyy hh24:' +
        'mi'#39') DALLE,'
      
        '    to_date('#39'30121899 '#39' || substr(T.FINE,12,5),'#39'ddmmyyyy hh24:mi' +
        #39') ALLE,'
      
        '    '#39'D'#39' TIPOGIUST, decode(T.AUTORIZZATA,'#39'true'#39','#39'N'#39','#39'S'#39') RICHIEST' +
        'A'
      
        '    from   USR_FIRLAB_ASSENZE T, T030_ANAGRAFICO T030, T011_CALE' +
        'NDARI T011'
      '    where  T.MATRICOLA = T030.MATRICOLA'
      '    --and    T.AUTORIZZATA = '#39'true'#39
      '    and    T.PERMESSO = '#39'true'#39
      '    and    T011.CODICE = '#39'5'#39' '
      
        '    and    T011.DATA between to_date(substr(T.INIZIO,1,10),'#39'dd-m' +
        'm-yyyy'#39') and to_date(substr(T.FINE,1,10),'#39'dd-mm-yyyy'#39')'
      '    minus'
      '    ('
      
        '      select T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, T040.DAO' +
        'RE, T040.AORE, T040.TIPOGIUST, '#39'N'#39' RICHIESTA'
      '      from   T040_GIUSTIFICATIVI T040'
      '      where  T040.DATA >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39')'
      '      and    T040.TIPOGIUST = '#39'D'#39
      '      union all'
      '      select T050.PROGRESSIVO, T011.DATA, T050.CAUSALE, '
      
        '             to_date('#39'30121899 '#39' || T050.NUMEROORE,'#39'ddmmyyyy hh2' +
        '4.mi'#39'), '
      
        '             to_date('#39'30121899 '#39' || T050.AORE,'#39'ddmmyyyy hh24.mi'#39 +
        '), T050.TIPOGIUST, '#39'S'#39' RICHIESTA'
      
        '      from   VT050_RICHIESTE_SENZAREVOCA T050, T011_CALENDARI T0' +
        '11'
      '      where  T050.DAL >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39') '
      '      and    T050.ELABORATO = '#39'N'#39
      '      and    T011.CODICE = '#39'5'#39' '
      '      and    T011.DATA between T050.DAL and T050.AL'
      '      and    T050.TIPOGIUST = '#39'D'#39
      '    )'
      '  )  '
      ')'
      ':FILTRO'
      'order by 1, 2, 3')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 40
    Top = 80
  end
  object selStep2: TOracleDataSet
    SQL.Strings = (
      
        '/* 2. Giustificativi autorizzati presenti in IrisWIN (T040) e no' +
        'n in Firlab: da inserire con Autorizzata = true */'
      
        'select PROGRESSIVO, DATA, CAUSALE, DALLE, ALLE, TIPOGIUST, to_da' +
        'te(null) FAMILIARE, null AUTORIZZATORE, '#39'N'#39' RICHIESTA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,'#39'N'#39') POSTDATA'
      'from'
      '('
      
        '  select T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, T040.DAORE D' +
        'ALLE, T040.AORE ALLE, T040.TIPOGIUST'
      '  from   T040_GIUSTIFICATIVI T040/*, T430_STORICO T430'
      '  where  T040.PROGRESSIVO = T430.PROGRESSIVO'
      '  and    T430.ATTIVO_TURNI = '#39'S'#39
      '  and    T040.DATA between T430.DATADECORRENZA and T430.DATAFINE'
      '         */'
      
        '  where  T040.PROGRESSIVO in (select /*+ unnest*/ T030.PROGRESSI' +
        'VO '
      
        '                              from   USR_FIRLAB_ASSENZE T, T030_' +
        'ANAGRAFICO T030 '
      
        '                              where  T.MATRICOLA = T030.MATRICOL' +
        'A)  '
      '  and    T040.DATA >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39')'
      '  and    T040.TIPOGIUST in ('#39'I'#39','#39'D'#39')'
      '  minus'
      '  select T030.PROGRESSIVO, T011.DATA, T.CAUSALE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.INIZIO,12,5),'#39'ddmmyyyy hh24:mi'#39'),null) DALLE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.FINE,12,5),'#39'ddmmyyyy hh24:mi'#39'),null) ALLE,'
      '         decode(T.PERMESSO,'#39'true'#39','#39'D'#39','#39'I'#39') TIPOGIUST'
      
        '  from   USR_FIRLAB_ASSENZE T, T030_ANAGRAFICO T030, T011_CALEND' +
        'ARI T011'
      '  where  T.MATRICOLA = T030.MATRICOLA'
      '  --and    T.AUTORIZZATA = '#39'true'#39
      '  and    T011.CODICE = '#39'5'#39' '
      
        '  and    T011.DATA between to_date(substr(T.INIZIO,1,10),'#39'dd-mm-' +
        'yyyy'#39') and to_date(substr(T.FINE,1,10),'#39'dd-mm-yyyy'#39') - decode(T.' +
        'PERMESSO,'#39'false'#39',1,0)'
      ')'
      ':FILTRO'
      'order by 1, 2, 3')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 104
    Top = 80
  end
  object selStep3: TOracleDataSet
    SQL.Strings = (
      
        '/* 3. Giustificativi richiesti presenti in IrisWIN (T050 da elab' +
        'orare) e non in Firlab: da inserire con Autorizzata = false */'
      
        'select PROGRESSIVO, DATA, CAUSALE, DALLE, ALLE, TIPOGIUST, to_da' +
        'te(null) FAMILIARE, null AUTORIZZATORE, '#39'S'#39' RICHIESTA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,'#39'S'#39') POSTDATA'
      'from'
      '('
      '  select T050.PROGRESSIVO, T011.DATA, T050.CAUSALE,'
      
        '         decode(T050.TIPOGIUST,'#39'I'#39',to_date(null),to_date('#39'301218' +
        '99 '#39' || T050.NUMEROORE,'#39'ddmmyyyy hh24.mi'#39')) DALLE, '
      
        '         decode(T050.TIPOGIUST,'#39'I'#39',to_date(null),to_date('#39'301218' +
        '99 '#39' || T050.AORE,'#39'ddmmyyyy hh24.mi'#39')) ALLE, '
      '         T050.TIPOGIUST'
      
        '  from   VT050_RICHIESTE_SENZAREVOCA T050, T030_ANAGRAFICO T030,' +
        ' T011_CALENDARI T011'
      
        '  where  T050.PROGRESSIVO in (select /*+ unnest*/ T030.PROGRESSI' +
        'VO '
      
        '                              from   USR_FIRLAB_ASSENZE T, T030_' +
        'ANAGRAFICO T030'
      
        '                              where  T.MATRICOLA = T030.MATRICOL' +
        'A)'
      '  and    T050.DAL >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39')'
      '  and    T050.TIPOGIUST in ('#39'I'#39','#39'D'#39')'
      '  and    T050.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T050.ELABORATO = '#39'N'#39
      '  and    T011.CODICE = '#39'5'#39' '
      '  and    T011.DATA between T050.DAL and T050.AL'
      '  minus'
      '  select T030.PROGRESSIVO, T011.DATA, T.CAUSALE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.INIZIO,12,5),'#39'ddmmyyyy hh24:mi'#39'),to_date(null)) DALLE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.FINE,12,5),'#39'ddmmyyyy hh24:mi'#39'),to_date(null)) ALLE,'
      '         decode(T.PERMESSO,'#39'true'#39','#39'D'#39','#39'I'#39') TIPOGIUST'
      
        '  from   USR_FIRLAB_ASSENZE T, T030_ANAGRAFICO T030, T011_CALEND' +
        'ARI T011'
      '  where  T.MATRICOLA = T030.MATRICOLA'
      '  --and    T.AUTORIZZATA = '#39'false'#39
      '  and    T011.CODICE = '#39'5'#39' '
      
        '  and    T011.DATA between to_date(substr(T.INIZIO,1,10),'#39'dd-mm-' +
        'yyyy'#39') and to_date(substr(T.FINE,1,10),'#39'dd-mm-yyyy'#39') - decode(T.' +
        'PERMESSO,'#39'false'#39',1,0)'
      ')'
      ':FILTRO'
      'order by 1, 2, 3')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 168
    Top = 80
  end
  object selStep4: TOracleDataSet
    SQL.Strings = (
      
        '/* 4. Giustificativi autorizzati presenti in IrisWIN (T040) e in' +
        ' Firlab Autorizzata = false: reinserire con Autorizzata = true *' +
        '/'
      
        'select PROGRESSIVO, CAUSALE, DATA, DALLE, ALLE, TIPOGIUST, --to_' +
        'date(null) FAMILIARE, null AUTORIZZATORE, ? RICHIESTA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,'#39'S'#39') POSTDATA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,'#39'N'#39') POSTDATA_2'
      'from'
      '('
      
        '  select T040.PROGRESSIVO, T040.DATA, T040.CAUSALE, T040.DAORE D' +
        'ALLE, T040.AORE ALLE, T040.TIPOGIUST'
      '  from   T040_GIUSTIFICATIVI T040/*, V430_STORICO V430'
      '  where  T040.PROGRESSIVO = V430.T430PROGRESSIVO'
      '  and    V430.T430ATTIVO_TURNI = '#39'S'#39
      
        '  and    T040.DATA between V430.T430DATADECORRENZA and V430.T430' +
        'DATAFINE'
      '         */'
      
        '  where  T040.PROGRESSIVO in (select /*+ unnest*/ T030.PROGRESSI' +
        'VO '
      
        '                              from   USR_FIRLAB_ASSENZE T, T030_' +
        'ANAGRAFICO T030 '
      
        '                              where  T.MATRICOLA = T030.MATRICOL' +
        'A)'
      '  and    T040.DATA >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39')'
      '  and    T040.TIPOGIUST in ('#39'I'#39','#39'D'#39')'
      '  intersect'
      '  select T030.PROGRESSIVO, T011.DATA, T.CAUSALE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.INIZIO,12,5),'#39'ddmmyyyy hh24:mi'#39'),null) DALLE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.FINE,12,5),'#39'ddmmyyyy hh24:mi'#39'),null) ALLE,'
      '         decode(T.PERMESSO,'#39'true'#39','#39'D'#39','#39'I'#39') TIPOGIUST'
      
        '  from   USR_FIRLAB_ASSENZE T, T030_ANAGRAFICO T030, T011_CALEND' +
        'ARI T011'
      '  where  T.MATRICOLA = T030.MATRICOLA'
      '  and    T.AUTORIZZATA = '#39'false'#39
      '  and    T011.CODICE = '#39'5'#39' '
      
        '  and    T011.DATA between to_date(substr(T.INIZIO,1,10),'#39'dd-mm-' +
        'yyyy'#39') and to_date(substr(T.FINE,1,10),'#39'dd-mm-yyyy'#39') - decode(T.' +
        'PERMESSO,'#39'false'#39',1,0)'
      ')'
      ':FILTRO'
      'order by 1, 2, 3')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 232
    Top = 80
  end
  object selStep5: TOracleDataSet
    SQL.Strings = (
      
        '/* 5. Giustificativi richiesti presenti in IrisWIN (T050) e in F' +
        'irlab Autorizzata = true: reinserire con Autorizzata = false */'
      
        'select PROGRESSIVO, CAUSALE, DATA, DALLE, ALLE, TIPOGIUST, -- to' +
        '_date(null) FAMILIARE, null AUTORIZZATORE, '#39'N'#39' RICHIESTA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,'#39'N'#39') POSTDATA,'
      
        '       USR_A004WS_POSTDATA(PROGRESSIVO,CAUSALE,DATA,to_char(DALL' +
        'E,'#39'hh24.mi'#39'),to_char(ALLE,'#39'hh24.mi'#39'),TIPOGIUST,to_date(null),nul' +
        'l,'#39'S'#39') POSTDATA_2'
      'from'
      '('
      '  select T050.PROGRESSIVO, T011.DATA, T050.CAUSALE,'
      
        '         decode(T050.TIPOGIUST,'#39'I'#39',to_date(null),to_date('#39'301218' +
        '99 '#39' || T050.NUMEROORE,'#39'ddmmyyyy hh24.mi'#39')) DALLE, '
      
        '         decode(T050.TIPOGIUST,'#39'I'#39',to_date(null),to_date('#39'301218' +
        '99 '#39' || T050.AORE,'#39'ddmmyyyy hh24.mi'#39')) ALLE, '
      '         T050.TIPOGIUST'
      
        '  from   VT050_RICHIESTE_SENZAREVOCA T050, T030_ANAGRAFICO T030,' +
        ' T011_CALENDARI T011'
      
        '  where  T050.PROGRESSIVO in (select /*+ unnest*/ T030.PROGRESSI' +
        'VO '
      
        '                              from   USR_FIRLAB_ASSENZE T, T030_' +
        'ANAGRAFICO T030'
      
        '                              where  T.MATRICOLA = T030.MATRICOL' +
        'A)'
      '  and    T050.DAL >= to_date('#39'01012013'#39','#39'ddmmyyyy'#39')'
      '  and    T050.PROGRESSIVO = T030.PROGRESSIVO'
      '  and    T050.ELABORATO = '#39'N'#39
      '  and    T050.TIPOGIUST in ('#39'I'#39','#39'D'#39')'
      '  and    T011.CODICE = '#39'5'#39' '
      '  and    T011.DATA between T050.DAL and T050.AL'
      '  intersect'
      '  select T030.PROGRESSIVO, T011.DATA, T.CAUSALE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.INIZIO,12,5),'#39'ddmmyyyy hh24:mi'#39'),null) DALLE,'
      
        '         decode(T.PERMESSO,'#39'true'#39', to_date('#39'30121899 '#39' || substr' +
        '(T.FINE,12,5),'#39'ddmmyyyy hh24:mi'#39'),null) ALLE,'
      '         decode(T.PERMESSO,'#39'true'#39','#39'D'#39','#39'I'#39') TIPOGIUST'
      
        '  from   USR_FIRLAB_ASSENZE T, T030_ANAGRAFICO T030, T011_CALEND' +
        'ARI T011'
      '  where  T.MATRICOLA = T030.MATRICOLA'
      '  and    T.AUTORIZZATA = '#39'true'#39
      '  and    T011.CODICE = '#39'5'#39' '
      
        '  and    T011.DATA between to_date(substr(T.INIZIO,1,10),'#39'dd-mm-' +
        'yyyy'#39') and to_date(substr(T.FINE,1,10),'#39'dd-mm-yyyy'#39') - decode(T.' +
        'PERMESSO,'#39'false'#39',1,0)'
      ')'
      ':FILTRO'
      'order by 1, 2, 3')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 296
    Top = 80
  end
  object scrPrepara: TOracleScript
    Lines.Strings = (
      'drop index T040I_TMP_DATA;'
      'drop index T040I_TMP_TG;'
      'drop index T040I_TMP_TGDATA;'
      'create index T040I_TMP_DATA on T040_GIUSTIFICATIVI (DATA);'
      
        'create index T040I_TMP_TG on T040_GIUSTIFICATIVI (TIPOGIUST) tab' +
        'lespace INDICI;'
      
        'create index T040I_TMP_TGDATA on T040_GIUSTIFICATIVI (TIPOGIUST,' +
        'DATA) tablespace INDICI;')
    Left = 40
    Top = 16
  end
  object scrTermina: TOracleScript
    Lines.Strings = (
      'drop index T040I_TMP_DATA;'
      'drop index T040I_TMP_TG;'
      'drop index T040I_TMP_TGDATA;')
    Left = 104
    Top = 16
  end
end
