create or replace function T020F_GETDATO(P_CODICE in varchar2, P_DATA in date, P_DATO in varchar2) return varchar2 as
  result varchar2(100);
  wStat varchar2(4000);
begin
  wStat:='select max('||P_DATO||') from T020_ORARI T020 ';
  wStat:=wStat||'where T020.CODICE = :CODICE and :DATA between T020.DECORRENZA and T020F_GETDECORRENZAFINE(:CODICE,T020.DECORRENZA)';
  execute immediate wStat into result using P_CODICE,P_DATA,P_CODICE;

  return result;
end;
/