create or replace function T100F_TIMB_CORRENTE(P_PROGRESSIVO in integer, P_DATA in date := sysdate) return varchar2 as
  wData date := trunc(P_DATA);
  wTimbratura varchar2(1000) :=null;
  result varchar2(1000) := null;

  cursor cT100 is
    select * from VT100_TIMB_DATAORA
    where PROGRESSIVO = P_PROGRESSIVO
    and DATA between wData - 1 and wData
    and DATAORA <= P_DATA
    order by DATAORA desc;

begin
  for t1 in cT100 loop
    if t1.VERSO = 'E' then
      wTimbratura:='"data='||to_char(t1.DATA,'dd-mm-yyyy')||'",'||
                   '"verso='||t1.VERSO||'",'||
                   '"ora='||to_char(t1.ORA,'hh24.mi')||'",'||
                   '"causale='||t1.CAUSALE||'",'||
                   '"rilevatore='||t1.RILEVATORE||'"';
    end if;               
    exit;
  end loop;

  result:=wTimbratura;
  return result;
end;
/