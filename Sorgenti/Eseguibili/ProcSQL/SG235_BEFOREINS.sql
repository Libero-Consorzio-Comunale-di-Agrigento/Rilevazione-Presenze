CREATE OR REPLACE TRIGGER SG235_BEFOREINS
before insert on SG235_MODELLI_CERTIFICAZIONI
for each row
begin
  if :NEW.ID is null then
    select SG235_ID.nextval into :NEW.ID from dual;
  end if;
end;
/