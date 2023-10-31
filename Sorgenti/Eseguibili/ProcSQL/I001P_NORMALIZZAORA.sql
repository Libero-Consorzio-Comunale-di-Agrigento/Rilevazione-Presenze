create or replace procedure I001P_NORMALIZZAORA as
  cursor c1 is
    select i001.rowid, i001.valore_old, i001.valore_new
    from   i000_loginfo i000,
           i001_logdati i001
    where  i001.id = i000.id
    and    i000.tabella = 'T100_TIMBRATURE'
    and    i001.colonna = 'ORA'
    and    ((length(i001.valore_old) between 4 and 5) or
            (length(i001.valore_new) between 4 and 5));

  wCommitEvery integer := 1000;
  wOldLen      integer;
  wNewLen      integer;
  wSql         varchar2(2000);
  wSql2        varchar2(1000);
  wCount       integer := 0;

begin
  -- log di inizio elaborazione
  i005p_registramsg(null, null, 'JOB', 'I', 'Inizio normalizzazione ora su tabella I001_LOGDATI',null);

  for t1 in c1 loop
    wOldLen:=length(t1.valore_old);
    wNewLen:=length(t1.valore_new);

    -- update valore old
    if wOldLen = 4 then
      wSql:='valore_old = ''01/01/1900 '' || substr(valore_old,1,2) || ''.'' || substr(valore_old,3,2) || ''.00''';
    elsif wOldLen = 5 then
      wSql:='valore_old = ''01/01/1900 '' || replace(valore_old,'':'',''.'') || ''.00''';
    else
      wSql:=null;
    end if;

    -- update valore new
    if wNewLen = 4 then
      wSql2:='valore_new = ''01/01/1900 '' || substr(valore_new,1,2) || ''.'' || substr(valore_new,3,2) || ''.00''';
    elsif wNewLen = 5 then
      wSql2:='valore_new = ''01/01/1900 '' || replace(valore_new,'':'',''.'') || ''.00''';
    else
      wSql2:=null;
    end if;

    -- compone sql per update
    if (wSql is not null) or (wSql2 is not null) then
      if (wSql is not null) and (wSql2 is not null) then
        wSql:=wSql || ', ' || wSql2;
      elsif wSql2 is not null then
        wSql:=wSql2;
      end if;

      wCount:=wCount + 1;
      wSql:='update i001_logdati set ' || wSql || ' where rowid = :myrowid';
      execute immediate wSql using t1.rowid;

      if wCount mod wCommitEvery = 0 then
        commit;
      end if;
    end if;
  end loop;

  -- commit finale delle update
  commit;
  
   -- log di fine elaborazione
  i005p_registramsg(null, null, 'JOB', 'I', 'Fine normalizzazione ora su tabella I001_LOGDATI',null);
end;
/
