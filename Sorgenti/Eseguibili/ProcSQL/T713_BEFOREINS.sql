create or replace trigger T713_BEFOREINS
before insert on T713_BUDGETANNO
for each row
when (NEW.ID is null)
begin
  select T713_ID.nextval into :NEW.ID from dual;
end;
/
