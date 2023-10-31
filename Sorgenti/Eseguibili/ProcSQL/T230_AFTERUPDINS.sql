create or replace trigger T230_AFTERUPDINS
  after insert or update
  on T230_CAUASSENZE_PARSTO
  for each row
begin
  --mantiene allineati i dati sulla T265 con l'ultima decorrenza di T230
  if :OLD.HMASSENZA = :NEW.HMASSENZA and
     :OLD.VALORGIOR = :NEW.VALORGIOR and
     :OLD.TIMB_PM   = :NEW.TIMB_PM and
     :OLD.TIMB_PM_DETRAZ = :NEW.TIMB_PM_DETRAZ and
     :OLD.ABBATTE_STRIND = :NEW.ABBATTE_STRIND and
     :OLD.INTERSEZIONE_TIMBRATURE = :NEW.INTERSEZIONE_TIMBRATURE and
     :OLD.INDPRES = :NEW.INDPRES and
     :OLD.COMPETENZE_PERSONALIZZATE = :NEW.COMPETENZE_PERSONALIZZATE and
     :OLD.ARROT_COMPETENZE = :NEW.ARROT_COMPETENZE and
     1 = 1
  then
    return;
  end if;

  if :NEW.DECORRENZA_FINE = to_date('31/12/3999','dd/mm/yyyy') then
    update T265_CAUASSENZE set
      HMASSENZA = :NEW.HMASSENZA,
      VALORGIOR = :NEW.VALORGIOR,
      TIMB_PM   = :NEW.TIMB_PM,
      TIMB_PM_DETRAZ = :NEW.TIMB_PM_DETRAZ,
      ABBATTE_STRIND = :NEW.ABBATTE_STRIND,
      INTERSEZIONE_TIMBRATURE = :NEW.INTERSEZIONE_TIMBRATURE,
      INDPRES = decode(:NEW.INDPRES,'S','A','N','B'),
      COMPETENZE_PERSONALIZZATE = :NEW.COMPETENZE_PERSONALIZZATE,
      ARROT_COMPETENZE = :NEW.ARROT_COMPETENZE
    where ID = :new.ID;
  end if;
exception
  when others then null;
end T230_AFTERUPDINS;
/
