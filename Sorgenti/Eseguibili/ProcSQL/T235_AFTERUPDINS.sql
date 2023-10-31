create or replace trigger T235_AFTERUPDINS
  after insert or update
  on T235_CAUPRESENZE_PARSTO
  for each row
begin
  --mantiene allineati i dati sulla T275 con l'ultima decorrenza di T235
  if nvl(:OLD.CAUSCOMP_DEBITOGG,'valore_nullo')       = nvl(:NEW.CAUSCOMP_DEBITOGG,'valore_nullo') and
     nvl(:OLD.MATURAMENSA,'valore_nullo')             = nvl(:NEW.MATURAMENSA,'valore_nullo') and
     nvl(:OLD.TIMB_PM_DETRAZ,'valore_nullo')          = nvl(:NEW.TIMB_PM_DETRAZ,'valore_nullo') and
     nvl(:OLD.TIMB_PM,'valore_nullo')                 = nvl(:NEW.TIMB_PM,'valore_nullo') and
     nvl(:OLD.TIMB_PM_H,'valore_nullo')               = nvl(:NEW.TIMB_PM_H,'valore_nullo') and
     nvl(:OLD.INTERSEZIONE_TIMBRATURE,'valore_nullo') = nvl(:NEW.INTERSEZIONE_TIMBRATURE,'valore_nullo') and
     nvl(:OLD.AUTOCOMPLETAMENTO_UE,'valore_nullo')    = nvl(:NEW.AUTOCOMPLETAMENTO_UE,'valore_nullo') and
     1 = 1
  then
    return;
  end if;

  if :NEW.DECORRENZA_FINE = to_date('31/12/3999','dd/mm/yyyy') then
    null;
    update T275_CAUPRESENZE set
      CAUSCOMP_DEBITOGG       = :NEW.CAUSCOMP_DEBITOGG,
      MATURAMENSA             = :NEW.MATURAMENSA,
      TIMB_PM_DETRAZ          = :NEW.TIMB_PM_DETRAZ,
      TIMB_PM                 = :NEW.TIMB_PM,
      TIMB_PM_H               = :NEW.TIMB_PM_H,
      INTERSEZIONE_TIMBRATURE = :NEW.INTERSEZIONE_TIMBRATURE,
      AUTOCOMPLETAMENTO_UE    = :NEW.AUTOCOMPLETAMENTO_UE
      /*,parametro2 = :NEW.parametro2*/
    where ID = :new.ID;
  end if;
exception
  when others then null;
end T235_AFTERUPDINS;
/
