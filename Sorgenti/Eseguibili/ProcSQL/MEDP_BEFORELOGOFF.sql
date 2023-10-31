create or replace trigger MEDP_BEFORELOGOFF before logoff on schema
declare
  wAzienda       varchar2(30);
  wHostName      varchar2(100);
  wHostIPAddress varchar2(100);
  wHostOsUser    varchar2(100);
  wDbSID         varchar2(100);
  wID            integer;
  cursor c1 is
    select OPERATORE,MASCHERA
    from VI000_I001_LOG
    where DATA >= trunc(sysdate) - 3
    and   OPERAZIONE = 'A'
    and   VALORE_NEW = 'ACCESSO'
    and HOSTNAME = wHostName
    and HOSTIPADDRESS = wHostIPAddress
    and HOSTOSUSER = wHostOsUser
    and DBSID = wDbSID
    order by ID desc;
begin
  --dati dell'operatore che ha eseguito l'accesso
  select
    i090f_getaziendacorrente,
    SYS_CONTEXT('USERENV','HOST'),
    SYS_CONTEXT('USERENV','IP_ADDRESS'),
    SYS_CONTEXT('USERENV','OS_USER'),
    SYS_CONTEXT('USERENV','SID')
  into
    wAzienda,
    wHostName,
    wHostIPAddress,
    wHostOsUser,
    wDbSID
  from dual;

  --registro i dati di uscita sull'utente
  update MONDOEDP.I070_UTENTI
  set DBSID = -DBSID,
      DATA_USCITA = sysdate
  where AZIENDA = wAzienda
  and HOSTNAME = wHostName
  and HOSTIPADDRESS = wHostIPAddress
  and HOSTOSUSER = wHostOsUser
  and DBSID = wDbSID;

  if sql%rowcount > 0 then
    for t1 in c1 loop
      --registro i dati di uscita sui log di accesso (OPERAZIONE = 'A')
      wID:=I000PCK_LOG.INSERT_INFO(t1.OPERATORE,t1.MASCHERA,null,'A');
      I000PCK_LOG.INSERT_LOG(wID,'TIPO',null,'USCITA');
      exit;
    end loop;
  end if;

  commit;
exception
  when others then null;
end;
/