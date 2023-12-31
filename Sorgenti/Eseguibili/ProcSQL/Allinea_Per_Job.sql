create or replace procedure ALLINEA_PER_JOB(P_ESECUZIONE_FORZATA in varchar2 :='N', P_PREALLINEA_INDIVIDUALE in varchar2 := 'S') as
  cursor CI020_T430 IS
    select distinct TABELLA, COLONNA, decode(VALORE,null,null,'not null') VALORE
    from   I020_DATI_ALLINEAMENTO
    where  TIPO = 'D'
    and    TABELLA = 'T430_STORICO'
    order by COLONNA,VALORE;

  cursor CI020_P430 IS
    select distinct TABELLA, COLONNA, decode(VALORE,null,null,'not null') VALORE
    from   I020_DATI_ALLINEAMENTO
    where  TIPO = 'D'
    and    TABELLA = 'P430_ANAGRAFICO'
    order by COLONNA,VALORE;

  CURSORE_DINAMICO_I030       integer;
  CURS_I030                   integer;
  WDECORRENZE   varchar2(32767);
  WCAMPINOTNULL varchar2(32767);
  WESPCURREL    varchar2(32767);
  WCAMPI_SEL    varchar2(32767);
  WTAB_FROM     varchar2(32767);
  WCOND_WHERE   varchar2(32767);
  wPREALLINEA_ESEGUITO varchar2(1);
  ERRORE        varchar2(100);
  ORA_JOB       varchar2(5);
  --
  N_STO_REL     number;
  N_STO_DAT     number;
  SN_STO_REL    varchar2(1);
  SN_STO_DAT    varchar2(1);
  ESPRESSIONE   varchar2(32767);
  WAND          varchar2(32767);
  PROG          number;
  --
  MESS          varchar2(4000);
  wI005ID       integer;
begin
  /*
  insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
  values (sysdate,'INIZIO JOB',I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
  */
  wI005ID:=I005F_REGISTRAMSG(I090F_GETAZIENDACORRENTE, 'JOB', 'ALLINEA_PER_JOB', 'I', 'INIZIO JOB', null);

  wPREALLINEA_ESEGUITO:='S';
  if nvl(P_PREALLINEA_INDIVIDUALE,'S') = 'S' then
    wPREALLINEA_ESEGUITO:='N';
  end if;
  begin
    select VALORE
    into   ORA_JOB
    from   T001_PARAMETRIFUNZIONI
    where  PROGOPERATORE = -1
    and    PROG = 'A044'
    and    NOME = 'ORA_JOB';
  exception
    when others then
      ORA_JOB:='00.00';
  end;
  -- IL JOB NON VIENE ESEGUITO SE LA DIFFERENZA DI ORARIO CON L'ORA PIANIFICATA � MAGGIORE DI MEZZ'ORA (in AVANTI O A RITROSO)
  if (nvl(P_ESECUZIONE_FORZATA,'N') = 'S') or (ABS(TRUNC(TO_CHAR(sysdate,'SSSSS')/60) - OREMINUTI(ORA_JOB)) <= 30) then
    -- GESTIONE ANAGRAFICHE T430
    select count(*)
    into   N_STO_REL
    from   I020_DATI_ALLINEAMENTO   I020,
           I030_RELAZIONI_ANAGRAFE  I030
    where  I020.TIPO = 'R'
    and    I030.TABELLA = I020.TABELLA
    and    I030.COLONNA = I020.COLONNA
    and    I020.TABELLA = 'T430_STORICO';
    select count(*)
    into   N_STO_DAT
    from   I020_DATI_ALLINEAMENTO
    where  TIPO = 'D'
    and    TABELLA = 'T430_STORICO';
    SN_STO_REL:='N';
    SN_STO_DAT:='N';
    if N_STO_REL > 0 then
      SN_STO_REL:='S';
    end if;  
    if N_STO_DAT > 0 then
      SN_STO_DAT:='S';
    end if;  
    /*
    insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
    values (sysdate,'PRESENZE - N_STO_REL: '||N_STO_REL||', N_STO_DAT: '||N_STO_DAT,I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
    */
    wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'PRESENZE - N_STO_REL: '||N_STO_REL||', N_STO_DAT: '||N_STO_DAT, null, wI005ID);
    if N_STO_REL > 0 OR N_STO_DAT > 0 then
      if nvl(P_PREALLINEA_INDIVIDUALE,'S') = 'N' then
        PRE_ALLINEA_PERIODI_STORICI(WCAMPINOTNULL,WESPCURREL,WDECORRENZE,WCAMPI_SEL,WTAB_FROM,WCOND_WHERE,'N',-1,SN_STO_REL,SN_STO_DAT);
        /*
        insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
        values (sysdate,'PRESENZE - WESPCURREL: '||SUBSTR(WESPCURREL,1,3900),I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
        */
        wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'PRESENZE - WESPCURREL: '||SUBSTR(WESPCURREL,1,3900), null, wI005ID);
      end if;
      if N_STO_REL > 0 then
        ESPRESSIONE:='select T030.PROGRESSIVO from T030_ANAGRAFICO T030, T430_STORICO T430 where T030.PROGRESSIVO = T430.PROGRESSIVO '||
                     'GROUP BY T030.PROGRESSIVO HAVING MAX(NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) > ADD_MONTHS(TRUNC(sysdate),-12)';
      else
        WAND:=null;
        for RI020_T430 in CI020_T430 loop
          if RI020_T430.VALORE IS null then
            WAND:=WAND || 'T430.' || RI020_T430.COLONNA || ' is null or ';
          else
            --WAND:=WAND || SUBSTR(RI020_T430.TABELLA,1,4) || '.' || RI020_T430.COLONNA || ' = ''' || RI020_T430.VALORE || ''' OR ';
            WAND:=WAND || 'T430.' || RI020_T430.COLONNA || ' in (select VALORE from I020_DATI_ALLINEAMENTO where TABELLA = ''T430_STORICO'' and COLONNA = '''||RI020_T430.COLONNA||''' and VALORE is not null) or ';
          end if;
        end loop;
        WAND:=RTRIM(LTRIM(SUBSTR(WAND,1,LENGTH(WAND)-3)));
        ESPRESSIONE:='select T030.PROGRESSIVO from T030_ANAGRAFICO T030, T430_STORICO T430 where T030.PROGRESSIVO = T430.PROGRESSIVO '||
                     'and (' || WAND || ') GROUP BY T030.PROGRESSIVO HAVING MAX(NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) > ADD_MONTHS(TRUNC(sysdate),-12)';
      end if;
      MESS:=SUBSTR(ESPRESSIONE,1,3900);
      /*
      insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
      values (sysdate,'PRESENZE - '||MESS,I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
      */
      wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'PRESENZE - '||MESS, null, wI005ID);
      CURSORE_DINAMICO_I030:=DBMS_SQL.OPEN_CURSOR;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_I030,ESPRESSIONE,DBMS_SQL.NATIVE);
      DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,1,PROG);
      CURS_I030:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_I030);
      loop
        if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_I030) > 0 then
          DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 1, PROG);
          ERRORE:=null;
          wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'ALLINEA_PERIODI_STORICI: INIZIO', PROG, wI005ID);
          ALLINEA_PERIODI_STORICI(PROG,1,ERRORE,'N','N',wPREALLINEA_ESEGUITO,WCAMPINOTNULL,WESPCURREL,WDECORRENZE,WCAMPI_SEL,WTAB_FROM,WCOND_WHERE);
          wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'ALLINEA_PERIODI_STORICI: FINE', PROG, wI005ID);
        else
          exit;
        end if;
      end loop; -- FINE CURSORE_DINAMICO_I030 --
      DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_I030);
      commit;
    end if;

    -- GESTIONE ANAGRAFICHE P430
    select count(*)
    into   N_STO_REL
    from   I020_DATI_ALLINEAMENTO   I020,
           I030_RELAZIONI_ANAGRAFE  I030
    where  I020.TIPO = 'R'
    and    I030.TABELLA = I020.TABELLA
    and    I030.COLONNA = I020.COLONNA
    and    I020.TABELLA = 'P430_ANAGRAFICO';
    select count(*)
    into   N_STO_DAT
    from   I020_DATI_ALLINEAMENTO
    where  TIPO = 'D'
    and    TABELLA = 'P430_ANAGRAFICO';
    SN_STO_REL:='N';
    SN_STO_DAT:='N';
    if N_STO_REL > 0 then
      SN_STO_REL:='S';
    end if;  
    if N_STO_DAT > 0 then
      SN_STO_DAT:='S';
    end if;  
    /*
    insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
    values (sysdate,'STIPENDI - N_STO_REL: '||N_STO_REL||', N_STO_DAT: '||N_STO_DAT,I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
    */
    wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'STIPENDI - N_STO_REL: '||N_STO_REL||', N_STO_DAT: '||N_STO_DAT, null, wI005ID);
    if N_STO_REL > 0 OR N_STO_DAT > 0 then
      if nvl(P_PREALLINEA_INDIVIDUALE,'S') = 'N' then
        PRE_ALLINEA_PERIODI_STIPENDI(WCAMPINOTNULL,WESPCURREL,WDECORRENZE,WCAMPI_SEL,WTAB_FROM,WCOND_WHERE,'N',-1,SN_STO_REL,SN_STO_DAT);
        /*
        insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
        values (sysdate,'STIPENDI - WESPCURREL: '||SUBSTR(WESPCURREL,1,3900),I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
        */
        wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'STIPENDI - WESPCURREL: '||SUBSTR(WESPCURREL,1,3900), null, wI005ID);
      end if;
      if N_STO_REL > 0 then
        ESPRESSIONE:='select T030.PROGRESSIVO from T030_ANAGRAFICO T030, T430_STORICO T430 where T030.PROGRESSIVO = T430.PROGRESSIVO '||
                     'GROUP BY T030.PROGRESSIVO HAVING MAX(NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) > ADD_MONTHS(TRUNC(sysdate),-12)';
      else
        WAND:='';
        FOR RI020_P430 in CI020_P430 loop
          if RI020_P430.VALORE IS null then
            WAND:=WAND || 'P430.' || RI020_P430.COLONNA || ' is null or ';
          else
            --WAND:=WAND || SUBSTR(RI020_P430.TABELLA,1,4) || '.' || RI020_P430.COLONNA || ' = ''' || RI020_P430.VALORE || ''' OR ';
            WAND:=WAND || 'P430.' || RI020_P430.COLONNA || ' in (select VALORE from I020_DATI_ALLINEAMENTO where TABELLA = ''P430_ANAGRAFICO'' and COLONNA = '''||RI020_P430.COLONNA||''' and VALORE is not null) or ';
          end if;
        end loop;
        WAND:=RTRIM(LTRIM(SUBSTR(WAND,1,LENGTH(WAND)-3)));
        ESPRESSIONE:='select T030.PROGRESSIVO from T030_ANAGRAFICO T030, T430_STORICO T430, P430_ANAGRAFICO P430 where T030.PROGRESSIVO = T430.PROGRESSIVO '||
                     'and T030.PROGRESSIVO = P430.PROGRESSIVO (+) and (' || WAND || ') GROUP BY T030.PROGRESSIVO HAVING MAX(NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))) > ADD_MONTHS(TRUNC(sysdate),-12)';
      end if;
      MESS:=SUBSTR(ESPRESSIONE,1,3900);
      /*
      insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
      values (sysdate,'STIPENDI - '||MESS,I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
      */
      wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'STIPENDI - '||MESS, null, wI005ID);
      CURSORE_DINAMICO_I030:=DBMS_SQL.OPEN_CURSOR;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_I030,ESPRESSIONE,DBMS_SQL.NATIVE);
      DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,1,PROG);
      CURS_I030:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_I030);
      loop
        if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_I030) > 0 then
          DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 1, PROG);
          ERRORE:=null;
          wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'ALLINEA_PERIODI_STIPENDI: INIZIO', PROG, wI005ID);
          ALLINEA_PERIODI_STIPENDI(PROG,ERRORE,'N','N',wPREALLINEA_ESEGUITO,WCAMPINOTNULL,WESPCURREL,WDECORRENZE,WCAMPI_SEL,WTAB_FROM,WCOND_WHERE);
          wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'ALLINEA_PERIODI_STIPENDI: FINE', PROG, wI005ID);
        else
          exit;
        end if;
      end loop; -- FINE CURSORE_DINAMICO_I030 --
      DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_I030);
      commit;
    end if;
    --
    begin
      delete I020_DATI_ALLINEAMENTO
      where TIPO in ('D','R');
      commit;
    exception
      when others then
        rollback;
    end;
  end if;
  /*
  insert into MONDOEDP.I021_LOG_JOB(DATAORA,MESSAGGIO,AZIENDA,TIPO)
  values (sysdate,'FINE JOB',I090F_GETAZIENDACORRENTE,'ALLINEA_PER_JOB');
  */
  wI005ID:=I005F_REGISTRAMSG(null, null, null, null, 'FINE JOB', null, wI005ID);
  commit;
end;
/

