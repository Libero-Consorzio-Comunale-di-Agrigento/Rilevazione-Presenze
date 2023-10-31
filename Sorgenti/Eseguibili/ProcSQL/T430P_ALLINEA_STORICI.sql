create or replace procedure T430P_ALLINEA_STORICI(P_PROGRESSIVO in integer) as
begin
  update T430_STORICO t set
    DATAFINE = (select min(DATADECORRENZA) - 1 from T430_STORICO where
                      PROGRESSIVO = t.PROGRESSIVO and
                       DATADECORRENZA > t.DATADECORRENZA)
  where PROGRESSIVO = P_PROGRESSIVO and
    DATADECORRENZA < (select max(DATADECORRENZA) from T430_STORICO
                      where PROGRESSIVO = t.PROGRESSIVO
                      );
  update T430_STORICO t set
    DATAFINE = TO_DATE('31123999','DDMMYYYY')
  where PROGRESSIVO = P_PROGRESSIVO and
    DATADECORRENZA = (select max(DATADECORRENZA) from T430_STORICO
                  where PROGRESSIVO = t.PROGRESSIVO
                  );
end;
/
