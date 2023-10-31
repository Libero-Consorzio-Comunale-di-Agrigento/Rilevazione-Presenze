create or replace function T012F_GGLAV_SETT(P_PROGRESSIVO in integer, P_DATA in date) return integer as
  result integer;
begin
  select decode(min(PROGRESSIVO),null,null,count(*)) into result
  from  T012_CALENDINDIVID 
  where PROGRESSIVO = P_PROGRESSIVO
  and DATA between P_DATA - (to_char(P_DATA - 1,'d') - 1) and P_DATA + (7 - to_char(P_DATA - 1,'d'))
  and LAVORATIVO = 'S';
    
  return result;
end;  
/