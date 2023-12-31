CREATE OR REPLACE TRIGGER TIMBRIDOPPIT100
BEFORE INSERT ON T100_TIMBRATURE
FOR EACH ROW
WHEN (NEW.FLAG = 'O')
DECLARE ESISTE INTEGER;
        TIMBRI_DOPPI EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO ESISTE FROM T100_TIMBRATURE WHERE
    PROGRESSIVO = :NEW.PROGRESSIVO AND 
    DATA = :NEW.DATA AND 
    TO_CHAR(ORA,'HH24.MI') = TO_CHAR(:NEW.ORA,'HH24.MI') AND
    VERSO = :NEW.VERSO AND FLAG IN ('C','M','O');
  IF ESISTE > 0 THEN
    RAISE TIMBRI_DOPPI;
  END IF;
END;
/

declare
  wconta integer;
begin
  select count(*) into wconta
 	from MONDOEDP.I100_PARSCARICO 
 	where trim(nvl(SECONDI,'0,0')) in ('0,0','99,99');
 	
  if wconta = 0 then
 	  execute immediate 'alter trigger TIMBRIDOPPIT100 disable';
 	end if;
end;
/