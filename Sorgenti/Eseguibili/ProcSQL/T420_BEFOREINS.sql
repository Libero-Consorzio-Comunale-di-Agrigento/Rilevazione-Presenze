create or replace trigger T420_BEFOREINS
before insert on T420_PIANIF_PERSCONV
for each row
begin
  if :NEW.ID is null then
    select T420_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end;
/