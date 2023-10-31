create or replace function V430F_CHEKANAGRAFE(P_PROGRESSIVO in integer, P_DATA in date, P_FILTRO in varchar2) return varchar2 as
  result varchar2(1);
  
  w_filtro varchar2(32767);
  w_query varchar2(32767);
  w_count integer;
begin
  result:='N';
  
  w_query:='select count(*) from T030_ANAGRAFICO T030, V430_STORICO V430 where T030.PROGRESSIVO = V430.T430PROGRESSIVO';
  w_query:=w_query||' and :DATA between V430.T430DATADECORRENZA and V430.T430DATAFINE';
  if P_PROGRESSIVO > 0 then
    w_query:=w_query||' and :PROGRESSIVO = T030.PROGRESSIVO';
  end if;
  
  w_filtro:=P_FILTRO;
  if instr(upper(w_filtro),'ORDER BY') > 0 then
    w_filtro:=substr(w_filtro,1,instr(upper(w_filtro),'ORDER BY') - 1);
  end if;
    
  if trim(w_filtro) is not null then
    w_query:=w_query||' and ('||w_filtro||')';
  end if;

  begin  
    if P_PROGRESSIVO > 0 then
      execute immediate w_query into w_count using P_DATA,P_PROGRESSIVO;
    else  
      execute immediate w_query into w_count using P_DATA;
    end if;
  exception
    when others then
      result:='E';
      return result;
  end;
  
  if w_count > 0 then
    result:='S';
  else
    result:='N';
  end if;
    
  return result;
end;
/