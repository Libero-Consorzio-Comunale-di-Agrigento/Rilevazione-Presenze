create or replace function V010F_GGLAV_MESE(P_PROGRESSIVO in integer, P_DATA in date, P_DEFAULT in integer := null) return integer as
  result integer;
  wTipoPT varchar2(1);
  wPercPT number;
  wGGLavSett integer;
begin
  begin 
    select 
      decode(min(PROGRESSIVO),null,P_DEFAULT,sum(decode(t010f_gglavorativo(PROGRESSIVO,DATA,'N','N','S'),'S',1,0))) 
      --PROGRESSIVO,trunc(DATA,'MM'),data,lavorativo,festivo,decode(LAVORATIVO,'N',0,decode(FESTIVO,'S',0,1)),t010f_gglavorativo(PROGRESSIVO,DATA)
      into result
    from V010_CALENDARI
    where PROGRESSIVO = P_PROGRESSIVO 
    and DATA between trunc(P_DATA,'MM') and last_day(P_DATA)
    group by PROGRESSIVO,trunc(DATA,'MM');
  exception 
    when no_data_found then
      result:=P_DEFAULT;
  end;      

  begin
    select 
      GetPercPart(T430.PARTTIME, 'TIPO'), 
      nvl(GetPercPart(T430.PARTTIME, 'PIANTA'),100), 
      T010F_GETDATO(P_PROGRESSIVO,P_DATA,'G')
    into wTipoPT, wPercPT, wGGLavSett
    from T430_STORICO T430
    where T430.PROGRESSIVO = P_PROGRESSIVO 
    and last_day(P_DATA) between T430.DATADECORRENZA and T430.DATAFINE
    and nvl(T430.TGESTIONE,'0') <> '1';
    
    if (wTipoPT = 'V') and (wPercPT > 0) and (wPercPT < 100) and (wGGLavSett >= 5) then
      result:=trunc(result * wPercPT / 100);
    end if;
  exception
    when no_data_found then
      null;  
  end;
    
  return result;
end;  
/