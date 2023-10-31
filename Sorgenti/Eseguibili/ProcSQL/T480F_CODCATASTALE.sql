create or replace function T480F_CODCATASTALE(PCodComune in varchar2) return varchar2 is
  CodCatastale varchar2(4);
begin
  select T480.CODCATASTALE into CodCatastale
    from T480_COMUNI T480
    where T480.CODICE=PCodComune;
  return CodCatastale;
exception
  when others then
    return '';
end;
/