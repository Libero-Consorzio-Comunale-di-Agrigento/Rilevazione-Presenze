CREATE OR REPLACE TRIGGER TIMBRIDOPPIT370
BEFORE INSERT ON T370_TIMBMENSA
FOR EACH ROW
WHEN (NEW.FLAG = 'O')
DECLARE ESISTE INTEGER;
        TIMBRI_DOPPI EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO ESISTE FROM T370_TIMBMENSA WHERE
    PROGRESSIVO = :NEW.PROGRESSIVO AND DATA = :NEW.DATA AND ORA = :NEW.ORA AND
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
 	  execute immediate 'alter trigger TIMBRIDOPPIT370 disable';
 	end if;
end;
/