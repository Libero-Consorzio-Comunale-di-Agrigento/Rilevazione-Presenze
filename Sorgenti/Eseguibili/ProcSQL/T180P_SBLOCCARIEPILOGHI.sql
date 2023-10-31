create or replace procedure T180P_SBLOCCARIEPILOGHI(P_PROGRESSIVO IN INTEGER, P_RIEPILOGO IN VARCHAR2, P_DAL IN DATE, P_AL IN DATE) as
  Aggiorna boolean;
  d date;
  wID integer;
begin
  Aggiorna:=False;
-- Cancellazione blocchi compresi nel periodo P_DAL P_AL
  delete t180_datibloccati
   where progressivo = P_PROGRESSIVO
     and riepilogo = P_RIEPILOGO
     and dal >= P_DAL and al <= P_AL;
  if sql%rowcount >= 1 then
    Aggiorna:=True;
  end if;
-- Aggiornamento data inizio periodo (dal) su blocchi che hanno una data inizio periodo compresa nel periodo P_DAL P_AL
-- Es. P_DAL=01/07/2004 P_AL=30/09/2004    periodo interessato dal 01/08/2004 al 31/12/2004
  begin
    update t180_datibloccati set dal = add_months(P_AL,+1)
     where progressivo = P_PROGRESSIVO
       and riepilogo = P_RIEPILOGO
       and dal between P_DAL and P_AL;
    if sql%rowcount >= 1 then
      Aggiorna:=True;
    end if;
  exception
    when others then null;
  end;
-- Aggiornamento data fine periodo (al) su blocchi che hanno una data fine periodo compresa nel periodo P_DAL P_AL
-- Es. P_DAL=01/07/2004 P_AL=30/09/2004    periodo interessato dal 01/01/2004 al 31/08/2004
  update t180_datibloccati set al = add_months(P_DAL,-1)
   where progressivo = P_PROGRESSIVO
     and riepilogo = P_RIEPILOGO
     and al between P_DAL and P_AL;
  if sql%rowcount >= 1 then
    Aggiorna:=True;
  end if;

-- Scompattamento blocchi che comprendono il periodo P_DAL P_AL
-- Es. P_DAL=01/07/2004 P_AL=30/09/2004    periodo interessato dal 01/01/2004 al 31/12/2004
  if not Aggiorna then
    begin
      insert into t180_datibloccati (progressivo,dal,al,riepilogo,stato)
      select P_PROGRESSIVO,add_months(P_AL,+1),max(al),P_RIEPILOGO,'C'
        from t180_datibloccati
       where progressivo = P_PROGRESSIVO
         and riepilogo = P_RIEPILOGO
         and dal <  P_DAL and al > P_AL;
      update t180_datibloccati set al = add_months(P_DAL,-1)
       where progressivo = P_PROGRESSIVO
         and riepilogo = P_RIEPILOGO
         and dal <  P_DAL and al > P_AL;
    exception
      when others then null;
    end;
  end if;

-- Aggiorno stato delle richieste di straordinario da Richiedibile a Calcolato,
--solo per iter_autorizzativo_str = '1' (Aosta_Regione)
  if P_RIEPILOGO = 'T070' then
    update t850_iter_richieste
    set tipo_richiesta = 'C'
    where iter = 'T065'
    and tipo_richiesta = 'R'
    and id in (select /*+ UNNEST */ t065.id
               from t065_richiestestraordinari t065, t430_storico t430, t025_contmensili t025
               where t065.progressivo = P_PROGRESSIVO
               and t065.data between P_DAL and P_AL
               and t430.progressivo = t065.progressivo
               and last_day(t065.data) between t430.datadecorrenza and t430.datafine
               and t430.perselastico = t025.codice
               and t025.iter_autorizzativo_str = '1');
  end if;

-- Eliminazione traccia dell'apertura dell'iter di validazione cartellino
  if P_RIEPILOGO in ('T860') then
    d:=P_DAL;
    while d <= P_AL loop
      delete from T077_DATISCHEDA
      where PROGRESSIVO = P_PROGRESSIVO
      and DATA = d
      and DATO = PCK_CONST.I011BLOCCO_T860;
      
      select max(T860.ID) into wID
      from T860_ITER_STAMPACARTELLINI T860 
      where PROGRESSIVO = P_PROGRESSIVO 
      and MESE_CARTELLINO = d
      and T851F_MAXLIV_AUTORIZZATO('AZIN','T860',T860.ID) = -1;
      
      if wID is not null then
        delete from T860_ITER_STAMPACARTELLINI where ID = wID;
        delete from T850_ITER_RICHIESTE where ID = wID;
      end if;

      d:=add_months(d,1);
    end loop;
  end if;
end;
/