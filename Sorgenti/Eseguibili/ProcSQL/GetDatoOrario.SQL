create or replace function GetDatoOrario(Cod in varchar2, Data in date, Fascia in Varchar2, Pos in integer, Dato in varchar2) return varchar2 is
begin
  return T021F_GETDATO(Cod,Data,Fascia,Pos,Dato);
end GetDatoOrario;
/
