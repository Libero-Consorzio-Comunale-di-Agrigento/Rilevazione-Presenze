create or replace function T040F_GIUSTIF_CORRENTE(P_PROGRESSIVO in integer, P_DATA in date := sysdate) return varchar2 as
  wData date := trunc(P_DATA);
  wGiustificativo varchar2(1000) := null;
  wFruizione varchar2(100);
  result varchar2(1000) := null;

  cursor cT040 is
    select T040.*,T265.DESCRIZIONE from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265
    where T040.PROGRESSIVO = P_PROGRESSIVO  
    and T040.DATA = wData
    and T040.TIPOGIUST in ('I','M')
    and T040.CAUSALE = T265.CODICE
    union
    select T040.*,T265.DESCRIZIONE from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265
    where T040.PROGRESSIVO = P_PROGRESSIVO  
    and T040.DATA = wData
    and T040.TIPOGIUST = 'D'
    and to_char(P_DATA,'sssss') between to_char(T040.DAORE,'sssss') and decode(to_char(T040.AORE,'sssss'),0,1440*60,to_char(T040.AORE,'sssss'))
    and T040.CAUSALE = T265.CODICE;

  cursor cT050 is
    select T050.*,T265.DESCRIZIONE from VT050_RICHIESTE_SENZAREVOCA T050, T265_CAUASSENZE T265
    where T050.PROGRESSIVO = P_PROGRESSIVO  
    and wData between T050.DAL and T050.AL
    and T050.ELABORATO = 'N'
    and nvl(T050.STATO,'S') = 'S'
    and T050.TIPOGIUST in ('I','M')
    and T050.CAUSALE = T265.CODICE
    union
    select T050.*,T265.DESCRIZIONE from VT050_RICHIESTE_SENZAREVOCA T050, T265_CAUASSENZE T265
    where T050.PROGRESSIVO = P_PROGRESSIVO  
    and wData between T050.DAL and T050.AL
    and T050.ELABORATO = 'N'
    and nvl(T050.STATO,'S') = 'S'
    and T050.CAUSALE = T265.CODICE
    and T050.TIPOGIUST = 'D'
    and to_char(P_DATA,'sssss')/60 between oreminuti(T050.NUMEROORE) and decode(oreminuti(T050.AORE),0,1440,oreminuti(T050.AORE))
    ;

begin
  for t1 in cT040 loop
    wFruizione:=null;
    if t1.TIPOGIUST = 'I' then
      wFruizione:='Giornata';
    elsif t1.TIPOGIUST = 'M' then
      wFruizione:='Mezza giornata';
    elsif t1.TIPOGIUST = 'D' then
      wFruizione:='dalle '||to_char(t1.DAORE,'hh24.mi')||' alle '||to_char(t1.AORE,'hh24.mi');
    end if; 
    wGiustificativo:='"causale='||t1.CAUSALE||'('||t1.DESCRIZIONE||')",'||
                     '"fruizione='||wFruizione||'"';
    exit;
  end loop;
  if wGiustificativo is null then
    for t1 in cT050 loop
      wFruizione:=null;
      if t1.TIPOGIUST = 'I' then
        wFruizione:='Giornata';
      elsif t1.TIPOGIUST = 'M' then
        wFruizione:='Mezza giornata';
      elsif t1.TIPOGIUST = 'D' then
        wFruizione:='dalle '||t1.NUMEROORE||' alle '||t1.AORE;
      end if; 
      wGiustificativo:='"causale='||t1.CAUSALE||'('||t1.DESCRIZIONE||')",'||
                       '"fruizione='||wFruizione||'"';
      exit;
    end loop;
  end if;

  result:=wGiustificativo;
  return result;
end;
/