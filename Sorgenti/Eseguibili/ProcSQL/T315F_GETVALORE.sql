create or replace function T315F_GETVALORE(pPROGRESSIVO integer, pDATA date, pDALLE varchar2, pNOME varchar2) return varchar2 is
  result   T315_IMPORT_LIBPROF.VALORE%TYPE;
begin
  begin
    select T315.VALORE
    into   result
    from   T315_IMPORT_LIBPROF T315
    where  T315.PROGRESSIVO = pPROGRESSIVO
    and    T315.DATA = pDATA
    and    T315.DALLE = pDALLE
    and    T315.NOME = pNOME;
  exception
    when NO_DATA_FOUND then
      result:=null;
    when OTHERS then
      raise;
  end;

  return result;
end;
/
