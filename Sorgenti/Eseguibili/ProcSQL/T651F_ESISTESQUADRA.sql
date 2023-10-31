create or replace function T651F_ESISTESQUADRA
 (P_SQUADRA in varchar2, P_TIPOOPE in varchar2, P_AREA in varchar2) 
  return varchar2 is
  result varchar2(1);

  OPERATORE varchar2(5);
  CENSITO varchar2(1);
  MYSQL varchar2(500);
  MYCOUNT number;
  
begin
  result:='N';

  if (P_TIPOOPE is null) then
    OPERATORE:='<*>';
  else
    OPERATORE:=P_TIPOOPE;
  end if;

  -- determino se tipo operatore censito nell'associazione squadra/area
  CENSITO:='N';
  MYSQL:='select count(*) from T651_AREE_SQUADRA where CODICE_SQUADRA = :P_SQUADRA and CODICE_OPERATORE = :OPERATORE';
  execute immediate MYSQL into MYCOUNT using P_SQUADRA, OPERATORE;
  if MYCOUNT > 0 then
    CENSITO:='S';
  end if;
    
  -- ricerco associazione "Squadra / Operatore / Area"
  MYSQL:='select count(*) from T651_AREE_SQUADRA where CODICE_SQUADRA = :P_SQUADRA and CODICE_OPERATORE = :OPERATORE and CODICE_AREA = :P_AREA';
  execute immediate MYSQL into MYCOUNT using P_SQUADRA, OPERATORE, P_AREA;
  if MYCOUNT > 0 then
   result:='S';
  else 
    -- solo se tipo operatore NON censito: Ricerco associazione "Squadra / <*> / Area"
    if CENSITO = 'N' then
      MYSQL:='select count(*) from T651_AREE_SQUADRA where CODICE_SQUADRA = :P_SQUADRA and CODICE_OPERATORE = ''<*>'' and CODICE_AREA = :P_AREA';
      execute immediate MYSQL into MYCOUNT using P_SQUADRA, P_AREA;
      if MYCOUNT > 0 then
       result:='S';
      end if;
    end if;  
  end if;
   
  return(RESULT);
end T651F_ESISTESQUADRA;
/