create or replace function V010F_GETCALENDTEORICO(P_PROGRESSIVO in integer,P_DATA in date, P_COL in varchar2 := 'LF') return varchar2 is
/*
  L=giorno lavorativo S/N da calendario
  F=giorno festivo S/N da calendario
  LF=concatenazione dei 2 valori precedenti
*/
  result varchar2(2) :=null;
  wLav varchar2(1);
  wFes varchar2(1);
begin
  select decode(upper(nvl(P_COL,'LF')),
                'L',nvl(max(LAVORATIVO),'N'),
                'F',nvl(max(FESTIVO),'N'),
                'LF',nvl(max(LAVORATIVO),'N')||nvl(max(FESTIVO),'N'),
                'er')
  into result
  from V010_CALENDARI 
  where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA;
  
  return(result);
end V010F_GETCALENDTEORICO;
/