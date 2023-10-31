create or replace function P442F_GETNETTO(P_ID_CEDOLINO in integer) return varchar2 as
  result varchar2(100);
begin
  result:=null;

  select nvl(trim(to_char(sum(IMPORTO),'999G990D00')),'0') 
  into result
  from P442_CEDOLINOVOCI
  where ID_CEDOLINO = P_ID_CEDOLINO
  and COD_VOCE = '12990'
  and  COD_VOCE_SPECIALE = 'BASE'
  and TIPO_RECORD = 'M';
  
  return result;
end;
/