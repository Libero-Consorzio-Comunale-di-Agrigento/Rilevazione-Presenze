create or replace trigger MONDOEDP.I070_BEFOREUPD
  before update of OCCUPATO
  on MONDOEDP.I070_UTENTI 
  for each row
declare
  wHostName varchar2(100);    
  wHostIPAddress varchar2(100);    
  wHostOsUser varchar2(100);    
  wDbSID varchar2(100);    
begin
  --dati dell'operatore che ha eseguito l'accesso
  if :NEW.OCCUPATO = 'S' then
    select 
      SYS_CONTEXT('USERENV','HOST'), 
      SYS_CONTEXT('USERENV','IP_ADDRESS'),
      SYS_CONTEXT('USERENV','OS_USER'),
      SYS_CONTEXT('USERENV','SID') 
    into  
      wHostName,
      wHostIPAddress,
      wHostOsUser,
      wDbSID    
    from dual;
    
    :NEW.HOSTNAME:=wHostName;
    :NEW.HOSTIPADDRESS:=wHostIPAddress;
    :NEW.HOSTOSUSER:=wHostOsUser;
    :NEW.DBSID:=wDbSID;
  end if;
exception
  when others then null;
end/*--NOLOG--*/;
/