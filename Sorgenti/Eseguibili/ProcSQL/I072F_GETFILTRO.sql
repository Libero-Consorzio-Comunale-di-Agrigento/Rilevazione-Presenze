create or replace function I072F_GETFILTRO(P_PROFILO in varchar2) return varchar2 as
  result varchar2(32767);
begin
  result:=CONCATENA_TESTO('select FILTRO from MONDOEDP.I072_FILTROANAGRAFE where AZIENDA = '''||
          I090F_GETAZIENDACORRENTE||''' and PROFILO = '''||
          P_PROFILO||''' order by PROGRESSIVO',' ');
  return result;
end;
/