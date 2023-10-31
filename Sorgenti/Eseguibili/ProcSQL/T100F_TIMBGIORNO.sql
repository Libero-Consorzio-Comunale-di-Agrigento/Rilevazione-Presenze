create or replace function T100F_TIMBGIORNO(P_PROGRESSIVO in integer, P_DATA in date, P_CAUS in varchar2, P_RILEV in varchar2) return varchar2 as
-- Estrae la stringa delle timbrature del giorno con un formato conforme con TimbreatureEffettive del generatore di stampe
-- P_CAUS  = 'S' comporta l'aggiunta della causale
-- P_RILEV = 'S' comporta l'aggiunta del rilevatore
  result varchar2(300);
cursor c1 is
  select t100.verso, to_char(t100.ora,'hh24mi') oratimb, t100.causale, t100.rilevatore from t100_timbrature t100
    where PROGRESSIVO = P_PROGRESSIVO
    and DATA = P_DATA
    and FLAG in ('O','I')
    order by ora,verso;
begin
  for t1 in c1 loop
    if result is not null then
      result:=result||' ';
    end if;
    select result||t1.verso||t1.oratimb||decode(P_CAUS,'S','-'||t1.causale,'')||decode(P_RILEV,'S','-'||t1.RILEVATORE,'') into
      result from dual;    
  end loop;
  return result;
end;
/