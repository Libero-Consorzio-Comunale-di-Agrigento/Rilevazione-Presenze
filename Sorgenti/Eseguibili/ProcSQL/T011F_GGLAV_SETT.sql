create or replace function T011F_GGLAV_SETT(P_CODICE in varchar2, P_DATA in date) return integer as
  result integer;
begin
  select decode(min(CODICE),null,null,count(*)) into result
  from  T011_CALENDARI
  where CODICE = P_CODICE
  and DATA between P_DATA - (to_char(P_DATA - 1,'d') - 1) and P_DATA + (7 - to_char(P_DATA - 1,'d'))
  and LAVORATIVO = 'S';
    
  return result;
end;  
/