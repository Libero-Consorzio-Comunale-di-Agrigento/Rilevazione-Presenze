create or replace trigger MONDOEDP.T941_BEFOREINS
before insert on MONDOEDP.T941_SCHEDULAZIONI_B026
for each row
begin
  if :NEW.ID is null then
    select MONDOEDP.T941_ID.nextval into :NEW.ID from dual;
  end if;
end;
/
