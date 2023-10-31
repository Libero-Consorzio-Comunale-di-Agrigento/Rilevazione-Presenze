create or replace trigger T030_AFTERDELUPD
  after update or delete on T030_ANAGRAFICO
  for each row
declare
begin
  if updating then
  
    if :OLD.MATRICOLA <> :NEW.MATRICOLA then
      update MONDOEDP.I060_LOGIN_DIPENDENTE set MATRICOLA = :NEW.MATRICOLA
      where MATRICOLA = :OLD.MATRICOLA
      and AZIENDA = I090F_GETAZIENDACORRENTE;
      
      update SG101_FAMILIARI set MATRICOLA = :NEW.MATRICOLA
      where MATRICOLA = :OLD.MATRICOLA;
    end if; 
     
    if (:OLD.DATANAS <> :NEW.DATANAS) or 
       (:OLD.COGNOME <> :NEW.COGNOME) or 
       (:OLD.NOME <> :NEW.NOME) or 
       (:OLD.DATANAS <> :NEW.DATANAS) or 
       (:OLD.COMUNENAS <> :NEW.COMUNENAS) or 
       (:OLD.CAPNAS <> :NEW.CAPNAS) or 
       (:OLD.SESSO <> :NEW.SESSO) or 
       (:OLD.CODFISCALE <> :NEW.CODFISCALE) then
      update SG101_FAMILIARI set
        COGNOME = :NEW.COGNOME,
        NOME = :NEW.NOME,
        DATANAS = :NEW.DATANAS,
        COMNAS = :NEW.COMUNENAS,
        CAPNAS = :NEW.CAPNAS,
        SESSO = :NEW.SESSO,
        CODFISCALE = :NEW.CODFISCALE
      where MATRICOLA = :NEW.MATRICOLA;
    end if;    
        
  elsif deleting then
    
    delete from MONDOEDP.I061_PROFILI_DIPENDENTE
    where NOME_UTENTE in (select NOME_UTENTE from MONDOEDP.I060_LOGIN_DIPENDENTE where MATRICOLA = :OLD.MATRICOLA)
    and AZIENDA = I090F_GETAZIENDACORRENTE;
    delete from MONDOEDP.I060_LOGIN_DIPENDENTE
    where MATRICOLA = :OLD.MATRICOLA
    and AZIENDA = I090F_GETAZIENDACORRENTE;
  
  end if;
  
exception
  when others then null;
end T030_AFTERDELUPD_I060_SG101;
/