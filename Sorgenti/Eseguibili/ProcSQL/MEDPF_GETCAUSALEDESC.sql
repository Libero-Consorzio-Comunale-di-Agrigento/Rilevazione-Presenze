create or replace function MEDPF_GETCAUSALEDESC(P_TIPO in varchar2, P_CAUSALE in varchar2) return varchar2 as
  result varchar2(100);
  conta integer;
begin
  if P_CAUSALE is null then
    return null;
  end if;
  
  conta:=0;
  
  if instr(P_TIPO,'T265') > 0 then
    select count(*),max(DESCRIZIONE) 
    into conta,result
    from T265_CAUASSENZE
    where CODICE = P_CAUSALE;
  end if;
    
  if (conta = 0) and (instr(P_TIPO,'T275') > 0) then
    select count(*),max(DESCRIZIONE) 
    into conta,result
    from T275_CAUPRESENZE 
    where CODICE = P_CAUSALE;
  end if;


  if (conta = 0) and (instr(P_TIPO,'T305') > 0) then
    select count(*),max(DESCRIZIONE) 
    into conta,result
    from T305_CAUGIUSTIF
    where CODICE = P_CAUSALE;
  end if;

  return result;
exception
  when others then
    return null;
end;
/