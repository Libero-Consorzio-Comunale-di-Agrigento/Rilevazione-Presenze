create or replace procedure I000P_IMPOSTAPROGRESSIVO as
  cursor c1 is
    select i000.id, nvl(i001.valore_old, i001.valore_new) progressivo, rownum
    from   i000_loginfo i000,
           i001_logdati i001
    where  i000.tabella not in ('I070_UTENTI','I072_FILTROANAGRAFE','I500_DATILIBERI','T221_PROFILISETTIMANA')
    and    i000.progressivo is null
    and    i001.colonna = 'PROGRESSIVO'
    and    i001.id = i000.id;

   wCommitEvery integer := 1000;
   wProgressivo integer;
begin
  -- log di inizio elaborazione
  i005p_registramsg(null, null, 'JOB', 'I', 'Inizio impostazione progressivo su tabella I000_LOGINFO',null);
  commit;

  for t1 in c1 loop

    -- conversione progressivo string in valore numerico
    begin
      wProgressivo:=to_number(t1.progressivo);
    exception
      when VALUE_ERROR then
        wProgressivo:=null;
    end;

    -- impostazione del progressivo su i000
    update i000_loginfo set progressivo = wProgressivo where id = t1.id;

    -- commit periodica
    if t1.rownum mod wCommitEvery = 0 then
      commit;
    end if;
  end loop;

  -- commit finale
  commit;

   -- log di fine elaborazione
  i005p_registramsg(null, null, 'JOB', 'I', 'Fine impostazione progressivo su tabella I000_LOGINFO',null);
  commit;
end;
/
