create or replace function T851F_GETNOTE(P_ID in integer, P_LIVELLO in integer) return varchar2 is
  result varchar2(2000);
begin
  select trim(T851.NOTE) into result
    from T851_ITER_AUTORIZZAZIONI T851
   where T851.ID = P_ID
     and T851.LIVELLO = P_LIVELLO;
     
  return(result);
exception
  when others then 
    return null;
end T851F_GETNOTE;
/