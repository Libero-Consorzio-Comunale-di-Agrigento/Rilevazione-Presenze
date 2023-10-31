create or replace function T430F_RAPPORTI_UNIFICATI(P_PROGRESSIVO in integer, P_DATA in date, P_TIPO in varchar2) return date as
/*resituisce il minimo INIZIO e la minima FINE rispetto al periodo corrente, coerentemente col valore di RAPPORTI_UNIFICATI
  P_PROGRESSIVO_ progressivo dell'anagrafico
  P_DATA: data a cui leggere i dati iniziali da T430_STORICO
  P_TIPO: I=Inizio rapporto, F=Fine rapporto
*/
  result date;
  wRapportiUnificati varchar2(1);
  wInizio date;
  wFine   date;

  cursor c1(P_DATARIF date) is
    select INIZIO, max(nvl(RAPPORTI_UNIFICATI,'S')) RAPPORTI_UNIFICATI
    from T430_STORICO
    where PROGRESSIVO = P_PROGRESSIVO
    and INIZIO < P_DATARIF
    group by INIZIO
    order by INIZIO desc;

  cursor c2(P_DATARIF date) is
    select nvl(FINE,PCK_CONST.DATA_INF) FINE, max(nvl(RAPPORTI_UNIFICATI,'S')) RAPPORTI_UNIFICATI
    from T430_STORICO
    where PROGRESSIVO = P_PROGRESSIVO
    and INIZIO > P_DATARIF
    group by FINE
    order by FINE;

begin
  --Lettura periodo di rapporto esistente alla data corrente
  select
    max(nvl(T430.RAPPORTI_UNIFICATI,'S')),
    min(T430.INIZIO) INIZIO,
    max(nvl(T430.FINE,PCK_CONST.DATA_INF)) FINE
  into
    wRapportiUnificati,
    wInizio,
    wFine
  from T430_STORICO T430
  where T430.PROGRESSIVO = P_PROGRESSIVO
  and T430.INIZIO is not null
  and P_DATA between T430.INIZIO and nvl(T430.FINE,PCK_CONST.DATA_INF);

  if wInizio is null then
    --Se non esiste periodo di rapporto, leggo lo storico alla data corrente
    select
      max(nvl(T430.RAPPORTI_UNIFICATI,'S')),
      min(T430.INIZIO) INIZIO,
      max(nvl(T430.FINE,PCK_CONST.DATA_INF)) FINE
    into
      wRapportiUnificati,
      wInizio,
      wFine
    from T430_STORICO T430
    where T430.PROGRESSIVO = P_PROGRESSIVO
    and T430.INIZIO is not null
    and P_DATA between T430.DATADECORRENZA and T430.DATAFINE;
  end if;

  if wInizio is null then
    return null;
  end if;

  if P_TIPO = 'I' then
    result:=wInizio;
  elsif P_TIPO = 'F' then
    result:=wFine;
  end if;
  if wRapportiUnificati = 'S' then
    if P_TIPO = 'I' then
      for t1 in c1(wInizio) loop
        if t1.RAPPORTI_UNIFICATI = 'S' then
          result:=t1.INIZIO;
        else
          exit;
        end if;
      end loop;
      select max(INIZIO) into wInizio from T430_STORICO where PROGRESSIVO = P_PROGRESSIVO and INIZIO < result;
      if wInizio is null then
        result:=PCK_CONST.DATA_NUL + 2;
      else
        select max(FINE) into wFine from T430_STORICO where PROGRESSIVO = P_PROGRESSIVO and INIZIO = wInizio and FINE < result;
        if wFine is not null then
          result:=wFine + 1;
        end if;
      end if;
    elsif P_TIPO = 'F' then
      for t2 in c2(wInizio) loop
        if t2.RAPPORTI_UNIFICATI = 'S' then
          result:=t2.FINE;
        else
          exit;
        end if;
      end loop;
    end if;
  end if;

  return result;
exception
  when others then
    return null;
end;
/