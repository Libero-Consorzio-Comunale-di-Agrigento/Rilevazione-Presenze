create or replace function T362F_TIMBRATURA_VALIDA(P_PROGRESSIVO IN INTEGER, P_DATA IN DATE, P_ORA IN DATE, P_VERSO IN VARCHAR2, P_RILEVATORE IN VARCHAR2, P_CAUSALE IN VARCHAR2) return varchar2 as
  cursor c1 is 
    select T362.RILEVATORE,T362.CAUSALI_ABILITATE, T362.ID
    from T362_REGOLE_ANAGRA T362
    where P_DATA between T362.DECORRENZA and T362.DECORRENZA_FINE
    and RILEVATORE = P_RILEVATORE
    and V430F_CHEKANAGRAFE(P_PROGRESSIVO, P_DATA, T362.FILTRO_ANAGRAFE) = 'S';

  cursor c2(P_ID in integer, P_GG in varchar2) is 
    select T363.*
    from T363_REGOLE_GG T363
    where ID = P_ID
    and GG = P_GG
    order by DALLE;
  
  wConto integer;
  wEsisteGG boolean;  
  wResult varchar2(1);
  result varchar2(1);
  
begin
  result:='S';
  if (P_RILEVATORE is null)
  --or (P_PROGRESSIVO <> 1073) 
  then
    return result;
  end if;
  
  for t1 in c1 loop
    result:='N';
    if P_RILEVATORE = t1.RILEVATORE then
      --valutazione dell'abilitazione alla causale
      if (P_CAUSALE is null) and INTERSEZ_LISTE('-',t1.CAUSALI_ABILITATE) is not null then
        result:='S';
      elsif (P_CAUSALE is not null) and INTERSEZ_LISTE('*',t1.CAUSALI_ABILITATE) is not null then
        result:='S';
      elsif (P_CAUSALE is not null) and INTERSEZ_LISTE(P_CAUSALE,t1.CAUSALI_ABILITATE) is not null then
        result:='S';
      end if;  
      wResult:=result;

      select count(*) into wConto from T363_REGOLE_GG where ID = t1.ID;
      if wConto > 0 then
        result:='N';
      end if;
      
      --valutazione dell'abilitazione nelle fasce giornaliere per il giorno specifico
      wEsisteGG:=false;
      for t2 in c2(t1.ID,to_char(P_DATA-1,'d')) loop
        wEsisteGG:=true;
        if trunc(to_char(P_ORA,'sssss')/60) between oreminuti(t2.DALLE) and oreminuti(t2.ALLE) then
          if t2.CAUSALI_ABILITATE is null then
            result:=wResult;
          else
            if (P_CAUSALE is null) and INTERSEZ_LISTE('-',t2.CAUSALI_ABILITATE) is not null then
              result:='S';
            elsif (P_CAUSALE is not null) and INTERSEZ_LISTE('*',t2.CAUSALI_ABILITATE) is not null then
              result:='S';
            elsif (P_CAUSALE is not null) and INTERSEZ_LISTE(P_CAUSALE,t2.CAUSALI_ABILITATE) is not null then
              result:='S';
            end if;  
          end if;
        end if;
        if result = 'S' then
          exit;
        end if;
      end loop;

      if not wEsisteGG then
        --valutazione dell'abilitazione nelle fasce giornaliere per il giorno generico 
        for t2 in c2(t1.ID,'*') loop
          if trunc(to_char(P_ORA,'sssss')/60) between oreminuti(t2.DALLE) and oreminuti(t2.ALLE) then
            if t2.CAUSALI_ABILITATE is null then
              result:=wResult;
            else
              if (P_CAUSALE is null) and INTERSEZ_LISTE('-',t2.CAUSALI_ABILITATE) is not null then
                result:='S';
              elsif (P_CAUSALE is not null) and INTERSEZ_LISTE('*',t2.CAUSALI_ABILITATE) is not null then
                result:='S';
              elsif (P_CAUSALE is not null) and INTERSEZ_LISTE(P_CAUSALE,t2.CAUSALI_ABILITATE) is not null then
                result:='S';
              end if;  
            end if;
          end if;
          if result = 'S' then
            exit;
          end if;
        end loop;
      end if;  
    end if;
    if result = 'S' then
      exit;
    end if;
  end loop;

  return result;
end;
/
