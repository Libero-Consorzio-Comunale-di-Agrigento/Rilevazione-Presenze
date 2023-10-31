create or replace trigger T362_BEFOREINS
before insert on T362_REGOLE_ANAGRA
for each row
begin
	if :NEW.ID is null then
    select T362_ID.NEXTVAL into :NEW.ID from dual;
  END IF;  	
end;
/
