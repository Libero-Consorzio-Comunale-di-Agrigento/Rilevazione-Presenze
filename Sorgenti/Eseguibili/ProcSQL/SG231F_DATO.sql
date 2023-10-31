create or replace function SG231F_DATO(pID in number, pCODICE in varchar2) return varchar2 is
  result varchar2(1000) := null;
begin
  select min(VALORE) into result 
  from SG231_VALORI_CERTIFICAZIONI
  where ID = pID 
  and CODICE = pCODICE;
  
  return(result);
end;
/