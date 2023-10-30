object A001FPassWordDtM1: TA001FPassWordDtM1
  OldCreateOrder = True
  OnCreate = A001FPassWordDtM1Create
  OnDestroy = A001FPassWordDtM1Destroy
  Height = 228
  Width = 518
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I090_ENTI '
      ' WHERE UPPER(AZIENDA) = UPPER(:AZIENDA)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 13
    Top = 24
  end
  object QI091: TOracleDataSet
    SQL.Strings = (
      'SELECT TIPO,DATO '
      '  FROM I091_DATIENTE '
      ' WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 150
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000}
    Left = 53
    Top = 24
  end
  object QI092: TOracleDataSet
    SQL.Strings = (
      'SELECT SCHEDA FROM I092_LOGTABELLE'
      'WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 93
    Top = 24
  end
  object QI070: TOracleDataSet
    SQL.Strings = (
      
        'SELECT * FROM I070_UTENTI WHERE AZIENDA = :AZIENDA AND :CAMPOUTE' +
        'NTE = :UTENTE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000180000003A00430041004D0050004F005500540045004E005400
      4500010000000000000000000000}
    Left = 141
    Top = 24
  end
  object QI071: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I071_PERMESSI '
      ' WHERE PROFILO = :PROFILO'
      '   AND AZIENDA = :AZIENDA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 185
    Top = 24
  end
  object QI072: TOracleDataSet
    SQL.Strings = (
      'SELECT FILTRO,SELEZIONE_RICHIESTA_PORTALE '
      '  FROM I072_FILTROANAGRAFE '
      ' WHERE PROFILO = :PROFILO'
      '   AND AZIENDA = :AZIENDA'
      ' ORDER BY PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 233
    Top = 24
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 13
    Top = 72
  end
  object I070Count: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM I070_UTENTI,I071_PERMESSI WHERE'
      'PERMESSI = PROFILO AND ABILITA_SCHEDE_CHIUSE <> '#39'S'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 73
    Top = 72
  end
  object QI073: TOracleDataSet
    SQL.Strings = (
      
        'SELECT GRUPPO,TAG,FUNZIONE,DESCRIZIONE,INIBIZIONE,ACCESSO_BROWSE' +
        ',RIGHE_PAGINA'
      '  FROM I073_FILTROFUNZIONI'
      ' WHERE PROFILO = :PROFILO '
      '   AND (APPLICAZIONE = :APPLICAZIONE OR GRUPPO = '#39'Funzioni WEB'#39')'
      '   AND AZIENDA = :AZIENDA')
    ReadBuffer = 300
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A00500052004F00460049004C004F0005000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000100000003A0041005A0049004500
      4E0044004100050000000000000000000000}
    AfterOpen = QI073AfterOpen
    Left = 284
    Top = 24
  end
  object QI074: TOracleDataSet
    SQL.Strings = (
      'SELECT TABELLA,CODICE,ABILITATO '
      '  FROM I074_FILTRODIZIONARIO'
      ' WHERE PROFILO = :PROFILO'
      '   AND AZIENDA = :AZIENDA'
      ' ORDER BY TABELLA,CODICE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    AfterOpen = QI074AfterOpen
    Left = 332
    Top = 24
  end
  object selI070Utenti: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUM FROM TABS WHERE TABLE_NAME = '#39'I070_UTENTI'#39)
    Optimize = False
    Left = 387
    Top = 24
  end
  object scrAllineamentoVersione: TOracleScript
    AutoCommit = True
    OutputOptions = []
    Left = 160
    Top = 72
  end
  object selI080: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I080_MODULI'
      ' WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 40
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 240
    Top = 72
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME FROM T033_LAYOUT')
    Optimize = False
    Left = 373
    Top = 71
  end
  object QI060: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from I060_LOGIN_DIPENDENTE'
      ' where AZIENDA = :AZIENDA'
      
        '   and upper(:UTENTE) in (upper(NOME_UTENTE), upper(NOME_UTENTE2' +
        '))')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 421
    Top = 72
  end
  object selI061: TOracleDataSet
    SQL.Strings = (
      'SELECT I061.*'
      '  FROM I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE = :NOME_UTENTE'
      '   AND TRUNC(SYSDATE) BETWEEN INIZIO_VALIDITA AND FINE_VALIDITA'
      ' ORDER BY I061.NOME_PROFILO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 13
    Top = 120
  end
  object selTablespace: TOracleDataSet
    SQL.Strings = (
      'select * from MONDOEDP.I300_TABLESPACE_FREESPACE I300'
      'where TABLESPACE in (:TABLESPACE)'
      'order by I300.tablespace')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400410042004C0045005300500041004300
      4500010000000000000000000000}
    Left = 136
    Top = 120
  end
  object selDistAzienda: TOracleDataSet
    SQL.Strings = (
      'select I090.AZIENDA '
      'from   I090_ENTI I090, '
      '       I060_LOGIN_DIPENDENTE I060'
      'where  I090.AZIENDA = I060.AZIENDA '
      'and    I090.LOGIN_DIP_ABILITATO = '#39'S'#39
      'and    :I060 = '#39'S'#39
      
        '--ricerca utente senza considerare la parte di I090.DOMINIO_LDAP' +
        '_SUFFISSO'
      
        'and replace(upper(:UTENTE), upper(decode(I090.DOMINIO_DIP_TIPO,'#39 +
        'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)'
      '  in'
      '  ('
      
        '   replace(upper(I060.NOME_UTENTE), upper(decode(I090.DOMINIO_DI' +
        'P_TIPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null),'
      
        '   replace(upper(I060.NOME_UTENTE2), upper(decode(I090.DOMINIO_D' +
        'IP_TIPO,'#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)'
      '  ) '
      'union'
      'select I090.AZIENDA'
      'from   I090_ENTI I090, '
      '       I070_UTENTI I070'
      'where  I090.AZIENDA = I070.AZIENDA '
      'and    I090.LOGIN_USR_ABILITATO = '#39'S'#39
      'and    UPPER(I070.UTENTE) = UPPER(:UTENTE)'
      'order by 1'
      ''
      
        '/* se si vuole estendere l'#39'applicazione del suffisso LDAP sostit' +
        'uire in questo modo la union su I070:'
      'select I090.AZIENDA'
      'from   I090_ENTI I090, '
      '       I070_UTENTI I070'
      'where  I090.AZIENDA = I070.AZIENDA '
      'and    I090.LOGIN_USR_ABILITATO = '#39'S'#39
      
        '--ricerca utente senza considerare la parte di I090.DOMINIO_LDAP' +
        '_SUFFISSO'
      
        'and replace(upper(:UTENTE), upper(decode(I090.DOMINIO_USR_TIPO,'#39 +
        'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null) = '
      
        '  replace(upper(I070.UTENTE), upper(decode(I090.DOMINIO_USR_TIPO' +
        ','#39'LDAP'#39',I090.DOMINIO_LDAP_SUFFISSO,null)), null)*/')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A005500540045004E0054004500050000000000
      0000000000000A0000003A004900300036003000050000000000000000000000}
    Left = 29
    Top = 176
  end
  object selP210: TOracleDataSet
    SQL.Strings = (
      'select distinct COD_CONTRATTO from :SCHEMA.P210_CONTRATTI')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0053004300480045004D004100010000000000
      000000000000}
    Left = 200
    Top = 120
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      'select RIGA from T002_QUERYPERSONALIZZATE '
      'where upper(nome) = '#39'MEDP_SELTABLESPACE'#39' '
      'and POSIZ >= 0'
      'order by POSIZ')
    Optimize = False
    Left = 72
    Top = 120
  end
  object selI070Doppi: TOracleDataSet
    SQL.Strings = (
      'select I070.AZIENDA,upper(I070.UTENTE),count(*) '
      'from MONDOEDP.I070_UTENTI I070, MONDOEDP.I090_ENTI I090 '
      'where I070.AZIENDA = I090.AZIENDA'
      'and I090.AGGIORNAMENTO_ABILITATO = '#39'S'#39
      'and upper(I090.AZIENDA) = upper(:AZIENDA)'
      'and upper(I070.UTENTE) = upper(:UTENTE)'
      'group by I070.AZIENDA,upper(I070.UTENTE) '
      'having count(*) > 1')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 453
    Top = 24
  end
  object selI081: TOracleDataSet
    SQL.Strings = (
      'select TAG '
      'from MONDOEDP.I081_FUNZIONI_ABILITATE'
      'where APPLICAZIONE = :APPLICAZIONE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    Left = 296
    Top = 72
  end
  object selAziendaUtente: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.AZIENDA, I060.NOME_UTENTE'
      'FROM   I090_ENTI I090, '
      '       I060_LOGIN_DIPENDENTE I060'
      'WHERE  UPPER(I090.AZIENDA) = UPPER(:AZIENDA)'
      'AND    UPPER(I060.NOME_UTENTE) = UPPER(:UTENTE)'
      'AND    I060.AZIENDA = I090.AZIENDA'
      'AND    :I060 = '#39'S'#39
      'UNION'
      'SELECT I090.AZIENDA, I070.UTENTE'
      'FROM   I090_ENTI I090,'
      '       I070_UTENTI I070'
      'WHERE  UPPER(I090.AZIENDA) = UPPER(:AZIENDA)'
      'AND    UPPER(I070.UTENTE) = UPPER(:UTENTE)'
      'AND    I070.AZIENDA = I090.AZIENDA')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      0000000000000A0000003A004900300036003000050000000000000000000000}
    ReadOnly = True
    Left = 120
    Top = 176
  end
  object updI061UltimoAccesso: TOracleQuery
    SQL.Strings = (
      'update MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      'set    ULTIMO_ACCESSO = sysdate'
      'where  I061.AZIENDA = :AZIENDA'
      'and    I061.NOME_UTENTE = :NOME_UTENTE'
      'and    I061.NOME_PROFILO = :NOME_PROFILO'
      'and    trunc(sysdate) between INIZIO_VALIDITA and FINE_VALIDITA')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      540045000500000000000000000000001A0000003A004E004F004D0045005F00
      500052004F00460049004C004F00050000000000000000000000}
    Left = 286
    Top = 124
  end
  object scrI091ParametriAvanzatiB000: TOracleQuery
    SQL.Strings = (
      'declare'
      '  wDato varchar2(100);'
      'begin  '
      
        '  select max(DATO) into wDato from MONDOEDP.I091_DATIENTE where ' +
        'AZIENDA = :AZIENDA and TIPO = '#39'C90_EMAIL_DATIP430'#39';'
      '  if wDato is null then'
      
        '    select decode(instr(:ParametriAvanzati,'#39'C017_V430=P430'#39'),0,'#39 +
        'N'#39','#39'S'#39') into wDato from dual;'
      
        '    update MONDOEDP.I091_DATIENTE set DATO = wDato where AZIENDA' +
        ' = :AZIENDA and TIPO = '#39'C90_EMAIL_DATIP430'#39';'
      '    if sql%rowcount = 0 then'
      
        '      insert into I091_DATIENTE (AZIENDA,TIPO,DATO) values (:AZI' +
        'ENDA,'#39'C90_EMAIL_DATIP430'#39',wDato);'
      '    end if;'
      '  end if;  '
      ''
      
        '  select max(DATO) into wDato from MONDOEDP.I091_DATIENTE where ' +
        'AZIENDA = :AZIENDA and TIPO = '#39'C90_W010CANCELLAZIONE'#39';'
      '  if wDato is null then'
      
        '    select decode(instr(:ParametriAvanzati,'#39'T050_CANCELLAZIONE'#39')' +
        ',0,'#39'N'#39','#39'S'#39') into wDato from dual;'
      
        '    update MONDOEDP.I091_DATIENTE set DATO = wDato where AZIENDA' +
        ' = :AZIENDA and TIPO = '#39'C90_W010CANCELLAZIONE'#39';'
      '    if sql%rowcount = 0 then'
      
        '      insert into I091_DATIENTE (AZIENDA,TIPO,DATO) values (:AZI' +
        'ENDA,'#39'C90_W010CANCELLAZIONE'#39',wDato);'
      '    end if;'
      '  end if;  '
      ''
      
        '  select max(DATO) into wDato from MONDOEDP.I091_DATIENTE where ' +
        'AZIENDA = :AZIENDA and TIPO = '#39'C26_C018_UNNEST'#39';'
      '  if wDato is null then'
      
        '    select decode(instr(:ParametriAvanzati,'#39'C018_UNNEST'#39'),0,null' +
        ','#39'S'#39') into wDato from dual;'
      '    if wDato is null then'
      
        '      select decode(instr(:ParametriAvanzati,'#39'C018_NO_UNNEST'#39'),0' +
        ',null,'#39'N'#39') into wDato from dual;'
      '    end if;  '
      '    if wDato is null then'
      '      if :VERDB >= 10 then'
      '        wDato:='#39'S'#39';'
      '      else'
      '        wDato:='#39'N'#39';'
      '      end if;  '
      '    end if;  '
      
        '    update MONDOEDP.I091_DATIENTE set DATO = wDato where AZIENDA' +
        ' = :AZIENDA and TIPO = '#39'C26_C018_UNNEST'#39';'
      '    if sql%rowcount = 0 then'
      
        '      insert into I091_DATIENTE (AZIENDA,TIPO,DATO) values (:AZI' +
        'ENDA,'#39'C26_C018_UNNEST'#39',wDato);'
      '    end if;'
      '  end if;  '
      ''
      
        '  select max(DATO) into wDato from MONDOEDP.I091_DATIENTE where ' +
        'AZIENDA = :AZIENDA and TIPO = '#39'C26_C018_HINT'#39';'
      '  if wDato is null then'
      
        '    select decode(instr(:ParametriAvanzati,'#39'C018_LEADING_T030'#39'),' +
        '0,null,'#39'LEADING'#39') into wDato from dual;'
      '    if wDato is null then'
      
        '      select decode(instr(:ParametriAvanzati,'#39'C018_NO_LEADING_T0' +
        '30'#39'),0,null,'#39'N'#39') into wDato from dual;'
      '    end if;  '
      '    if wDato is null then'
      '      if :VERDB >= 10 then'
      '        wDato:='#39'LEADING'#39';'
      '      else'
      '        wDato:='#39'N'#39';'
      '      end if;  '
      '    end if;  '
      
        '    update MONDOEDP.I091_DATIENTE set DATO = wDato where AZIENDA' +
        ' = :AZIENDA and TIPO = '#39'C26_C018_HINT'#39';'
      '    if sql%rowcount = 0 then'
      
        '      insert into I091_DATIENTE (AZIENDA,TIPO,DATO) values (:AZI' +
        'ENDA,'#39'C26_C018_HINT'#39',wDato);'
      '    end if;'
      '  end if;  '
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000240000003A0050004100520041004D004500540052004900
      4100560041004E005A004100540049000500000000000000000000000C000000
      3A0056004500520044004200030000000000000000000000}
    Left = 288
    Top = 176
  end
end
