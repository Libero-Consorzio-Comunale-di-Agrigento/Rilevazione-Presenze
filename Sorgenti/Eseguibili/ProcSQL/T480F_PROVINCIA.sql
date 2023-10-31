create or replace function T480F_PROVINCIA (PCodComune in varchar2) return varchar2 is
  SiglaProv varchar2(2);
begin
  select T480.PROVINCIA into SiglaProv
    from T480_COMUNI T480
    where T480.CODICE=PCodComune;
  return SiglaProv;
exception
  when others then
    return '';
end;
/