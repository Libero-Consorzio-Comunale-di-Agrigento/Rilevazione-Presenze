create or replace trigger I040_BEFOREINS
before insert on I040_NOTIFICHE_IRISWEB
for each row
begin
	if :NEW.ID is null then
    select I040_ID.nextval into :NEW.ID from dual;
  end if;  	
end;
/
