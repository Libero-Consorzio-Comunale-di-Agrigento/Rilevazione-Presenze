create or replace function V430F_GETDATO(P_PROGRESSIVO in integer, P_COLONNA in varchar2, P_DATA in date) return varchar2 as
/*restituisce il valorde della generica colonna di V430_STORICO alla data richiesta*/
  result varchar2(4000);
  wstat  varchar2(4000);
begin
  result:=null;
  wstat:='select '||P_COLONNA||' from V430_STORICO where T430PROGRESSIVO = :PROGRESSIVO and :DATA between T430DATADECORRENZA and T430DATAFINE';
  execute immediate wstat into result using in P_PROGRESSIVO,in P_DATA;
  return result;
exception
  when no_data_found then
    return null;
end;
/