object R003FGeneratoreStampeDtM: TR003FGeneratoreStampeDtM
  OldCreateOrder = True
  OnCreate = R003FGeneratoreStampeDtMCreate
  OnDestroy = R003FGeneratoreStampeDtMDestroy
  Height = 291
  Width = 837
  object Q910: TOracleDataSet
    SQL.Strings = (
      'SELECT T910.*,T910.ROWID FROM T910_RIEPILOGO T910 '
      'WHERE APPLICAZIONE = :APPLICAZIONE'
      'AND nvl(TEMP_B028,'#39'N'#39') = nvl(:TEMP_B028,nvl(TEMP_B028,'#39'N'#39'))'
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000140000003A00540045004D005000
      5F004200300032003800050000000000000000000000}
    OracleDictionary.DefaultValues = True
    RefreshOptions = [roBeforeEdit]
    Filtered = True
    AfterOpen = Q910AfterOpen
    AfterInsert = Q910AfterInsert
    AfterEdit = Q910AfterEdit
    BeforePost = Q910BeforePost
    AfterPost = Q910AfterPost
    AfterCancel = Q910AfterCancel
    BeforeDelete = Q910BeforeDelete
    AfterDelete = Q910AfterDelete
    OnFilterRecord = FiltroDizionario
    OnNewRecord = Q910NewRecord
    Left = 56
    Top = 8
  end
  object CD920: TOracleQuery
    Optimize = False
    Left = 12
    Top = 144
  end
  object Q275U305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,SIGLA FROM T275_CAUPRESENZE'
      'UNION'
      'SELECT CODICE,SIGLA FROM T305_CAUGIUSTIF')
    ReadBuffer = 100
    Optimize = False
    Left = 116
    Top = 100
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT '
      '  NVL(INIZIO,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) INIZIO,'
      '  NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) FINE'
      'FROM T430_STORICO '
      'WHERE PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 176
    Top = 148
  end
  object cds920: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterPost = cds920AfterPost
    Left = 237
    Top = 148
  end
  object selT920Stampa: TOracleDataSet
    ReadBuffer = 1000
    Optimize = False
    CachedUpdates = True
    Left = 297
    Top = 148
  end
  object updT920DataDecorrenza: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor c1 is '
      
        '    select rowid,progressivo,t430datadecorrenza,t430datafine,:cd' +
        'cperc_codice cdcperc_codice, substr(:campi,1,2000) campi '
      '    from :tabella order by progressivo,t430datadecorrenza;'
      '  cursor c2 is'
      
        '    select table_name,replace(table_name,:tabellastr) num from c' +
        'ols where table_name like :tabellastr||'#39'%'#39' and column_name = '#39'CD' +
        'CPERC_DECOR'#39' and replace(table_name,:tabellastr) is not null;  '
      '  p integer;'
      '  d date;'
      '  dd date;'
      '  s varchar2(2000);'
      '  rid varchar2(20);'
      '  i integer;'
      'begin'
      '  p:=-1;'
      '  d:=null;'
      '  s:='#39'*'#39';'
      '  for t1 in c1 loop'
      '    if (p <> t1.progressivo) or (s <> nvl(t1.campi,'#39' '#39')) then'
      '      p:=t1.progressivo;'
      '      s:=nvl(t1.campi,'#39' '#39');'
      '      d:=t1.t430datadecorrenza;'
      '      rid:=t1.rowid;'
      '    else'
      '      dd:=t1.t430datadecorrenza;'
      
        '      update :tabella set t430datadecorrenza = d where rowid = t' +
        '1.rowid;'
      '      delete from :tabella where rowid = rid;'
      '      rid:=t1.rowid;'
      '      for t2 in c2 loop'
      '        begin'
      '          if t1.cdcperc_codice is null then'
      
        '            execute immediate '#39'update '#39'||t2.table_name||'#39' set cd' +
        'cperc_decor = '#39#39#39'||to_char(d,'#39'dd/mm/yyyy'#39')||'#39#39#39' where progressiv' +
        'o'#39'||t2.num||'#39' = '#39'||t1.progressivo||'#39' and cdcperc_codice is null ' +
        'and cdcperc_decor = '#39#39#39'||to_char(dd,'#39'dd/mm/yyyy'#39')||'#39#39#39#39';'
      '          else'
      
        '            execute immediate '#39'update '#39'||t2.table_name||'#39' set cd' +
        'cperc_decor = '#39#39#39'||to_char(d,'#39'dd/mm/yyyy'#39')||'#39#39#39' where progressiv' +
        'o'#39'||t2.num||'#39' = '#39'||t1.progressivo||'#39' and cdcperc_codice = '#39#39#39'||t' +
        '1.cdcperc_codice||'#39#39#39' and cdcperc_decor = '#39#39#39'||to_char(dd,'#39'dd/mm' +
        '/yyyy'#39')||'#39#39#39#39';'
      '          end if;'
      '        exception when others then null; '
      '        end;'
      '      end loop;'
      '      commit;'
      '    end if;'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000040000000C0000003A00430041004D0050004900010000000C000000
      54343330504F524152494F0000000000100000003A0054004100420045004C00
      4C004100010000000C000000543932305F5359534D414E000000000016000000
      3A0054004100420045004C004C00410053005400520005000000000000000000
      00001E0000003A0043004400430050004500520043005F0043004F0044004900
      43004500010000000000000000000000}
    Left = 353
    Top = 56
  end
  object selTestoLog: TOracleDataSet
    SQL.Strings = (
      'select :RIGA from T030_ANAGRAFICO T030, V430_STORICO V430 '
      'where T030.PROGRESSIVO = V430.T430PROGRESSIVO '
      '  and :AL between T430DATADECORRENZA and T430DATAFINE'
      '  and T030.PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00520049004700410001000000000000000000
      0000060000003A0041004C000C0000000000000000000000180000003A005000
      52004F0047005200450053005300490056004F00030000000000000000000000}
    Left = 525
    Top = 102
  end
  object selT919: TOracleDataSet
    SQL.Strings = (
      
        'select T919.*,rowid from T919_SEMAFORO T919 where OPERATORE = :O' +
        'PERATORE')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000}
    Left = 525
    Top = 145
  end
  object updT920Stampa: TOracleQuery
    Optimize = False
    Left = 375
    Top = 149
  end
  object selDropTabs: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'DROP TABLE '#39'||OBJECT_NAME||'#39';'#39' AS DROPTAB'
      '  FROM USER_OBJECTS '
      ' WHERE OBJECT_TYPE='#39'TABLE'#39' '
      '   AND OBJECT_NAME LIKE '#39'T920\_%'#39' escape '#39'\'#39
      '   AND LAST_DDL_TIME < ADD_MONTHS(SYSDATE,-12)')
    Optimize = False
    Left = 621
    Top = 8
  end
  object exeDropTabs: TOracleScript
    Left = 712
    Top = 8
  end
  object selDropUserTabs: TOracleDataSet
    SQL.Strings = (
      'SELECT TABELLA_GENERATA'
      '  FROM T910_RIEPILOGO T910'
      
        'WHERE NVL(T910.DATA_ACCESSO,SYSDATE) < ADD_MONTHS(SYSDATE,decode' +
        '(TABELLA_GENERATA_DROP,'#39'S'#39',-12,-24))'
      'AND TABELLA_GENERATA IS NOT NULL'
      'MINUS'
      'SELECT TABELLA_GENERATA'
      '  FROM T910_RIEPILOGO T910'
      
        'WHERE NVL(T910.DATA_ACCESSO,SYSDATE) >= ADD_MONTHS(SYSDATE,decod' +
        'e(TABELLA_GENERATA_DROP,'#39'S'#39',-12,-24))'
      'AND TABELLA_GENERATA IS NOT NULL'
      '')
    Optimize = False
    Left = 712
    Top = 56
  end
  object selChiave: TOracleDataSet
    SQL.Strings = (
      'SELECT UPPER(COLUMN_NAME) AS COLUMN_NAME'
      '  FROM USER_IND_COLUMNS '
      ' WHERE TABLE_NAME = :TNAME'
      '   AND INDEX_NAME = :INAME')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A0054004E0041004D0045000500000000000000
      000000000C0000003A0049004E0041004D004500050000000000000000000000}
    Left = 456
    Top = 104
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      
        'select MATRICOLA from MONDOEDP.I060_LOGIN_DIPENDENTE where upper' +
        '(NOME_UTENTE) = upper(:NOME_UTENTE)')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 621
    Top = 102
  end
  object selT002Riga: TOracleDataSet
    SQL.Strings = (
      'select RIGA from T002_QUERYPERSONALIZZATE '
      'where NOME = :NOME '
      'and APPLICAZIONE = :APPLICAZIONE '
      'and POSIZ >= 0'
      'order by POSIZ')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A004E004F004D00450005000000000000000000
      00001A0000003A004100500050004C004900430041005A0049004F004E004500
      050000000000000000000000}
    Left = 773
    Top = 104
  end
  object selVSG101: TOracleDataSet
    SQL.Strings = (
      'select VSG101.*'
      '  from VSG101_FAMILIARI VSG101'
      ' where VSG101.PROGRESSIVO26 = :PROGRESSIVO'
      '   and :DATA2 between FM_DECORRENZA and FM_DECORRENZA_FINE'
      ' order by VSG101.FM_NUMORD,VSG101.FM_DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003200
      0C0000000000000000000000}
    Left = 181
    Top = 104
  end
  object selT919TG: TOracleDataSet
    SQL.Strings = (
      'select T919.* from T919_SEMAFORO T919 '
      'where OPERATORE <> :OPERATORE'
      'and TABELLA_GENERATA = :TABELLA_GENERATA')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000220000003A0054004100420045004C004C004100
      5F00470045004E0045005200410054004100050000000000000000000000}
    Left = 573
    Top = 146
  end
end
