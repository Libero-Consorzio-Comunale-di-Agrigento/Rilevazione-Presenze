create or replace function T265F_INIZIOCATENA(P_CAUSALE in varchar2) return varchar2 as
 t varchar2(1000);
begin
  t:=null;
  return T265F_GETINIZIOCATENA(P_CAUSALE,t);
end;
/
