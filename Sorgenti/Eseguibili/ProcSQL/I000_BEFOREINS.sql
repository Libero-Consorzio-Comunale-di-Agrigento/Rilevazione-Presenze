create or replace trigger I000_BEFOREINS
  before insert 
  on I000_LOGINFO
  for each row
declare
  wAzienda       varchar2(30);    
  wHostName      varchar2(100);    
  wHostIPAddress varchar2(100);    
  wHostOsUser    varchar2(100);    
  wDbSID         varchar2(100);    
begin
  if :NEW.DATA is null then
    :NEW.DATA:=SYSDATE;
  end if;  
  --dati dell'operatore che ha eseguito l'accesso
  if :NEW.OPERAZIONE = 'A' then
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

    :NEW.HOSTOSUSER:=wHostOsUser;
    :NEW.DBSID:=wDbSID;
    
    if :NEW.MASCHERA not in ('W001','B110','WM001') then
      update MONDOEDP.I070_UTENTI set
        HOSTNAME = wHostName,
        HOSTIPADDRESS = wHostIPAddress,
        HOSTOSUSER = wHostOsUser,
        DBSID = wDbSID
      where AZIENDA = wAzienda
      and   upper(UTENTE) = upper(:NEW.OPERATORE);
    end if;   
    
    if :NEW.MASCHERA in ('W001','B110','WM001') then
      update MONDOEDP.I060_LOGIN_DIPENDENTE set
        HOSTNAME = wHostName,
        HOSTIPADDRESS = wHostIPAddress,
        HOSTOSUSER = wHostOsUser,
        DBSID = wDbSID
      where AZIENDA = wAzienda
      and   upper(NOME_UTENTE) = upper(:NEW.OPERATORE); 
    end if;  
  end if;
exception
  when others then null;
end;
/