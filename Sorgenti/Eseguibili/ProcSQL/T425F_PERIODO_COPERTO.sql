create or replace function T425F_PERIODO_COPERTO(P_PROGRESSIVO in integer,
                                                 P_DAL in date, P_AL in date,
                                                 P_INIZIOG IN varchar2, P_FINEG in varchar2)
return boolean as
/*
Controlla se l'intervallo P_DAL - P_AL è completamente coperto dai periodi in T425, T430 inizio-fine o T430 inizio_giur-fine_giur
TRUE: solo se l'intervallo è interamente coperto
*/  
  result boolean:=false;
  dataI date;
  C integer;
  wEspressione varchar2(2000);
  TYPE cur_typ IS REF CURSOR;
  myCur cur_typ;
begin
  
  dataI:=P_DAL;
  
  loop
    c:=0;
    
    select count(*) into C
      from t425_rapportilavoro_altrienti t425 
      where t425.progressivo = P_PROGRESSIVO 
      and dataI between greatest(t425.INIZIO) and least(t425.FINE) 
      and t425.validazione='N';

    if c = 0 then       
      select count(*) into C
        from t430_storico t430 
        where t430.progressivo = P_PROGRESSIVO 
        and dataI between greatest(t430.INIZIO) and least(t430.FINE);
  
      if c = 0 then       
        wEspressione:= 
        'select count(*) '||
        ' from t430_storico t430 '||
        ' where t430.progressivo = '||P_PROGRESSIVO||
        ' and '''||dataI||''' between t430.'||P_INIZIOG||' and t430.'||P_FINEG;
        EXECUTE IMMEDIATE wEspressione
        INTO c;
                
      end if;            
  
    end if;
    
    if c = 0 then
      exit;
    else
      if dataI = P_AL then
        result := True;
        exit;
      else
          dataI:=dataI+1;    
      end if;               
    end if;
      
  end loop;
    
  return result;
end;    
/