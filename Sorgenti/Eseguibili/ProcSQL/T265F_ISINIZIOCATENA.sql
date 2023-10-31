create or replace function T265F_ISINIZIOCATENA(P_CAUSALE in varchar2) return varchar2 is
  result varchar2(1);
  wElencoCausali varchar2(2000);
begin
  wElencoCausali:='';
  
  if P_CAUSALE = T265F_GETINIZIOCATENA(P_CAUSALE,wElencoCausali) then
    result:='S';
  else
    result:='N';
  end if;
  
  return result;
end T265F_ISINIZIOCATENA;
/
