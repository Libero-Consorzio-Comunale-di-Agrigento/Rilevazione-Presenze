create or replace procedure T265P_COMP_CONGPARENTALI (
/*
   Questa procedure estrae le variazioni alle competenze iniziali per le causali
   con tipo cumulo 'F' legate ai congedi parentali.

  I dati restituiti sono:
  - P_OFFSET_MAXINDIVIDUALE
      variazione per la fruizione massima individuale
      viene valorizzato solo nel caso di presenza di entrambi i coniugi / conviventi
  - P_OFFSET_MMINTERI
      variazione per i mesi interi fruiti
  - P_OFFSET_MMCONT
      variazione per la fruizione dei mesi continuativi necessari definiti sulla causale
  - P_OFFSET_GGVUOTI
      variazione per giorni vuoti nel caso di fruizione frazionata

  Concetto di "mese continuativo":
    il mese è considerato continuativo se il periodo di assenza dura almeno
    fino al giorno prima del mese successivo all¿inizio del periodo stesso)

  Concetto di "fruizione frazionata":
    Nel caso in cui il lavoratore, a seguito di un periodo di congedo parentale, fruisca, immediatamente dopo, di giorni di ferie o malattia, e successivamente non riprendendo
    l'attività lavorativa, fruisca di altro congedo parentale, le giornate festive  e i sabati (in caso di settimana corta) cadenti tra il primo periodo di congedo parentale
    e le ferie o la malattia vanno computate  in conto congedo parentale.

*/
  P_PROGRESSIVO           in  integer,   -- progressivo dipendente
  P_DATA                  in  date,      -- data di riferimento per il conteggio delle fruizioni
  P_CAUSALE               in  varchar2,  -- causale da considerare
  P_DATANAS_FAM           in  date,      -- data di nascita familiare di riferimento (oppure null)
  P_INIZIO_CUMULO         in  date,      -- data di inizio cumulo
  P_FINE_CUMULO           in  date,      -- data di fine cumulo

  P_OFFSET_MAXINDIVIDUALE out integer,   -- variazione per la fruizione massima individuale (se presenti entrambi i genitori)
  P_OFFSET_MMINTERI       out integer,   -- variazione per i mesi interi fruiti
  P_OFFSET_MMCONT         out integer,   -- variazione per la fruizione di mesi continuativi definiti su causale
  P_OFFSET_GGVUOTI        out integer    -- variazione per giorni non lavorativi buchi tra due periodi di assenza tra i quali non vi è stata ripresa dell'attività lavorativa
)
AS
  -- informazioni estratte dalla causale indicata
  wCodRaggr                     T265_CAUASSENZE.CODRAGGR%TYPE;
  wUMisura                      T265_CAUASSENZE.UMISURA%TYPE;
  wRetr1                        T265_CAUASSENZE.RETRIBUZIONE1%TYPE;
  wCumuloGlobale                T265_CAUASSENZE.CUMULOGLOBALE%TYPE;
  wCompetenza1                  T265_CAUASSENZE.COMPETENZA1%TYPE;
  wCompIndiv_Coniuge_Esistente  T265_CAUASSENZE.COMPINDIV_CONIUGE_ESISTENTE%TYPE;
  wVarComp_FruizMMInteri        T265_CAUASSENZE.VARCOMP_FRUIZMMINTERI%TYPE;     -- competenze alterate dalla fruizione di mesi interi
  wMMCont_VarComp               T265_CAUASSENZE.MMCONT_VARCOMP%TYPE;
  wVarComp_FruizMMCont          T265_CAUASSENZE.VARCOMP_FRUIZMMCONT%TYPE;
  wCopri_GGNonLav               T265_CAUASSENZE.COPRI_GGNONLAV%TYPE;
  wCausMatFac                   T265_CAUASSENZE.CODICE%TYPE;

  wAlteraCompetenze             varchar2(1);   -- determina se la causale ha i parametri che alterano le competenze
  wComp1                        integer;       -- competenza in fascia 1 calcolata
  wSesso                        varchar2(1);   -- sesso del dipendente
  wProgrConiuge                 integer;       -- progressivo del coniuge / convivente
  wSessoConiuge                 varchar2(1);   -- sesso del coniuge
  wGGFruiti                     integer;       -- tot. giorni fruiti
  wGGFruitiConiuge              integer;       -- tot. giorni continuativi fruiti dal coniuge
  wMaxMesiContConiuge           integer;       -- non utilizzato (solo per memorizzare valore di ritorno)
  wMaxMesiCont                  integer;       -- max mesi continuativi fruiti
  wOffset30                     integer;       -- tot. degli offset su 30gg
  wOffset30Coniuge              integer;       -- tot. degli offset su 30gg del coniuge
  i                             integer;       -- variabile di comodo usata come contatore
  wDataCiclo                    date;          -- data per scorrimento dei giorni vuoti tra due periodi di assenza
  wGGLav                        varchar2(1);   -- giorno lavorativo S/N
  wFinePerPrec                  date;          -- giorno successivo al precedente periodo di assenza che non ha assenze nel giorno successivo
  wInizioPerSucc                date;          -- giorno precedente all'inizio del successivo periodo di assenza
  wOffsetGGVuoti                integer;       -- contatore parziale dei giorni vuoti da consideraresolo se ci ssono almeno due periodi di maternità facolativa senza 
                                               -- ripresa lavorativa
  wStartGGVuoti                 boolean;       -- indica se inizia a contare i giorni vuoti in quanto c'è stata una prima ssenza per maternità facoltativa
  wContGGVuoti                  boolean;       -- indica se contare i giorni vuoti deve esserci maternità facoltativa come ultima assenza del periodo precedente o come prima assenza del periodo successivo
  wContaPeriodiVuoti            integer;       -- contatore dei periodi vuoti deve comparire almeno 2 volte la maternità facoltativa
  wPresLav                      integer;       -- contatore presenza giorni lavorativi tra giorni vuoti 
  -- cursore per scorrere tutte le assenze  da inizio cumulo a fine cumulo
  cursor T040Periodi is
    select (select max(T040A.DATA) from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.DATA < T040.DATA and T040A.TIPOGIUST = 'I') + 1 T040DATA_DA,
      T040.DATA - 1 T040DATA_A, T040.CAUSALE T040CAUSALE from T040_GIUSTIFICATIVI T040 where T040.PROGRESSIVO = P_PROGRESSIVO and T040.TIPOGIUST = 'I' --and T040.CAUSALE = P_CAUSALE 
      and T040.DATA between P_INIZIO_CUMULO and P_FINE_CUMULO
      -- Escludo periodo buco che ha al suo interno almeno un giorno lavorativo
      and not exists (select 'x' from V010_CALENDARI V010 where V010.PROGRESSIVO = T040.PROGRESSIVO and decode(LAVORATIVO,'S',decode(FESTIVO,'S','N','S'),'N') = 'S'
        and V010.DATA between (select max(T040A.DATA) + 1 from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.DATA < T040.DATA and T040A.TIPOGIUST = 'I') and T040.DATA - 1)
      and (select max(T040A.DATA) from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.DATA < T040.DATA and T040A.TIPOGIUST = 'I') < T040.DATA - 1
      and not exists (select 'x' from T040_GIUSTIFICATIVI T040A, T265_CAUASSENZE T265A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.CAUSALE = T265A.CODICE and T265A.ESCLUSIONE = 'S'
        and T040A.DATA between (select max(T040A.DATA) from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.DATA < T040.DATA and T040A.TIPOGIUST = 'I') and T040.DATA - 1)
      and not exists (select 'x' from T040_GIUSTIFICATIVI T040A, T275_CAUPRESENZE T275A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.CAUSALE = T275A.CODICE
        and T040A.DATA between (select max(T040A.DATA) from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.DATA < T040.DATA and T040A.TIPOGIUST = 'I') and T040.DATA - 1)
      and not exists (select 'x' from T100_TIMBRATURE T100 where T100.PROGRESSIVO = T040.PROGRESSIVO and T100.FLAG in ('O','I')
        and T100.DATA between (select max(T040A.DATA) from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = T040.PROGRESSIVO and T040A.DATA < T040.DATA and T040A.TIPOGIUST = 'I') and T040.DATA - 1)
    order by T040.DATA;
BEGIN
  -- inizializza variabili di ritorno
  P_OFFSET_MAXINDIVIDUALE :=0;
  P_OFFSET_MMINTERI       :=0;
  P_OFFSET_MMCONT         :=0;
  P_OFFSET_GGVUOTI        :=0;

  -- estrae info sulla causale indicata
  begin
    select codraggr, umisura, competenza1, retribuzione1, nvl(compindiv_coniuge_esistente,competenza1),
           cumuloglobale,
           varcomp_fruizmminteri, mmcont_varcomp,varcomp_fruizmmcont,COPRI_GGNONLAV
    into   wCodRaggr, wUMisura, wCompetenza1, wRetr1, wCompIndiv_Coniuge_Esistente,
           wCumuloGlobale, wVarComp_FruizMMInteri, wMMCont_VarComp, wVarComp_FruizMMCont, wCopri_GGNonLav

    from   t265_cauassenze
    where  codice = P_CAUSALE;
  exception
    when NO_DATA_FOUND THEN
      raise_application_error (-20001,'La causale ' || P_CAUSALE || ' è inesistente!');
  end;

  if wUMisura = 'G' then
    -- competenza in giorni
    begin
      wComp1:=to_number(replace(wCompetenza1,' ',''));
    exception
      when others then
        raise_application_error (-20010,'La competenza in fascia 1 della causale ' || P_CAUSALE || ' non è valida: ' || wCompetenza1);
    end;
  else
    -- competenza in ore non valutata -> termina subito
    return;
  end if;

  -- imposta variabile che indica se sono attivi i parametri che possono alterare le competenze
  if ((wVarComp_FruizMMInteri = 'S') or (wMMCont_VarComp > 0 and wVarComp_FruizMMCont > 0)) then
    wAlteraCompetenze:='S';
  else
    wAlteraCompetenze:='N';
  end if;

  /*
     1. ricerca coniuge / convivente e sesso (solo se sono attivi i parametri che possono alterare le competenze)
  */
  wProgrConiuge:=null;
  wSessoConiuge:=null;
  if (wCumuloGlobale = 'C') and (wAlteraCompetenze = 'S') then
    -- 1a. coniuge presente in anagrafico
    select max(t030.progressivo), max(t030.sesso)
    into   wProgrConiuge, wSessoConiuge
    from   sg101_familiari sg101,
           t030_anagrafico t030,
           sg101_familiari sg101cg
    where  sg101.progressivo = P_PROGRESSIVO
    and    sg101.gradopar in ('CG','AL','UC','CF')
    and    sg101.matricola = t030.matricola
    and    sg101cg.progressivo = t030.progressivo
    and    nvl(sg101cg.dataadoz,sg101cg.datanas) = P_DATANAS_FAM;

    if wProgrConiuge is null then
      -- 1b. coniuge esterno
      select max(sg101.sesso)
      into   wSessoConiuge
      from   sg101_familiari sg101
      where  sg101.progressivo = P_PROGRESSIVO
      and    sg101.gradopar in ('CG','UC','CF'); --AL dovrebbe considerarsi come query sopra, ma storicamente era stato ignorato. Per prudenza si mantiene ignorato.

      -- coniuge presente
      if wSessoConiuge is not null then
        wProgrConiuge:=-1;
      end if;
    end if;

    if wProgrConiuge is not null then
      -- coniuge / convivente presente
      -- sesso del dipendente determinato in base al sesso del coniuge
      if wSessoConiuge is null then
        raise_application_error (-20015,'Il sesso del coniuge non è indicato!');
      elsif wSessoConiuge = 'M' then
        wSesso:='F';
      else
        wSesso:='M';
      end if;
    end if;
  end if;

  /*
     2. Determina le variazioni da applicare alle competenze indicate sulla causale
  */
  wGGFruiti:=0;
  wOffset30:=0;
  wMaxMesiCont:=0;
  wGGFruitiConiuge:=0;
  wOffset30Coniuge:=0;
  wMaxMesiContConiuge:=0;

  -- calcolo periodi se sono indicati i parametri che alterano le competenze
  if wAlteraCompetenze = 'S' then
    t040p_periodi_continuativi('N',p_progressivo,wProgrConiuge,p_data,p_causale,p_datanas_fam,p_inizio_cumulo,p_fine_cumulo,
      wGGFruiti,wOffset30,wMaxMesiCont);
    if wVarComp_FruizMMInteri = 'N' then
      wOffset30:=0;
    end if;
  end if;

  -- gestione cumulo con il coniuge / convivente
  if wProgrConiuge is not null then
    -- calcolo periodi coniuge
    t040p_periodi_continuativi('S',p_progressivo,wProgrConiuge,p_data,p_causale,p_datanas_fam,p_inizio_cumulo,p_fine_cumulo,
      wGGFruitiConiuge,wOffset30Coniuge,wMaxMesiContConiuge);
    if wVarComp_FruizMMInteri = 'N' then
      wOffset30Coniuge:=0;
    end if;
  end if;

  if not wProgrConiuge is null then
    -- entrambi i genitori: 6 mesi ciascuno (wGMaxUnitario) fino a un massimo di 10 complessivi (Competenza1)
    wComp1:=least(wCompIndiv_Coniuge_Esistente + wGGFruitiConiuge - wOffset30Coniuge,wComp1);
  end if;

  P_OFFSET_MMINTERI:=wOffset30 + wOffset30Coniuge;
  P_OFFSET_MAXINDIVIDUALE:=wComp1 - wCompetenza1;

  /*
     3. causale per il padre (solo in presenza di entrambi i genitori)
        30 giorni se sono stati fruiti almeno 3 mesi continuativi
  */
  if (wProgrConiuge is not null) and
     (wSesso = 'M') and
     --(wMaxMesiCont >= wMMCont_VarComp) and
     (wGGFruiti >= wMMCont_VarComp * 30) and
     (wVarComp_FruizMMCont > 0) then
    P_OFFSET_MMCONT:=wVarComp_FruizMMCont;
  end if;

  /*
     4. Determina gli abbattimenti dovuti ai giorni vuoti tra due periodi di assenza senza ripresa di attività lavorativa
  */
  wFinePerPrec:='';
  wInizioPerSucc:='';
  P_OFFSET_GGVUOTI:=0;
  wContaPeriodiVuoti:=0;
  wOffsetGGVuoti:=0;
  wStartGGVuoti:=False;

  if wCopri_GGNonLav in ('S','E') then
    -- Scorro il cursore dei giorni buchi tra due assenze dove non c'è ripresa di attività lavorativa
    for T040c in T040Periodi loop
      --Se esistono almeno due fruizioni di maternità calcolo P_OFFSET_GGVUOTI
      if wContaPeriodiVuoti >= 2 then
        P_OFFSET_GGVUOTI:=P_OFFSET_GGVUOTI + wOffsetGGVuoti;
        wOffsetGGVuoti:=0;
      end if;  
      select sum(pres_lav) into wPresLav from 
      (
      select count(*) pres_lav from T040_GIUSTIFICATIVI T040A, T265_CAUASSENZE T265A where T040A.PROGRESSIVO = P_PROGRESSIVO 
        and T040A.DATA between wInizioPerSucc and T040c.T040DATA_DA
        and T040A.CAUSALE = T265A.CODICE and T265A.ESCLUSIONE = 'S'
      union all 
      select count(*) pres_lav from T040_GIUSTIFICATIVI T040A, T275_CAUPRESENZE T275A where T040A.PROGRESSIVO = P_PROGRESSIVO 
        and T040A.DATA between wInizioPerSucc and T040c.T040DATA_DA
        and T040A.CAUSALE = T275A.CODICE
      union all 
      select count(*) pres_lav from T100_TIMBRATURE T100 where T100.PROGRESSIVO = P_PROGRESSIVO and T100.FLAG in ('O','I') 
        and T100.DATA between wInizioPerSucc and T040c.T040DATA_DA
      );
      if wPresLav > 0 then
         wContaPeriodiVuoti:=0;
         wStartGGVuoti:=False;
      end if;
      --La causale di maternità facoltativa determina l'inizio del controllo dei periodi buchi
      select max(T040A.CAUSALE) into wCausMatFac from T040_GIUSTIFICATIVI T040A where T040A.PROGRESSIVO = P_PROGRESSIVO and T040A.DATA = T040c.T040DATA_DA - 1;
      if wCausMatFac = P_CAUSALE then
        wStartGGVuoti:=True;
      end if;
      --La causale di maternità facoltativa su periodo di assenza precedente o successivo determina il conteggio del periodo buco
      if wCausMatFac = P_CAUSALE or T040c.T040causale = P_CAUSALE then
        wContaPeriodiVuoti:=wContaPeriodiVuoti + 1;
      end if;
      --Per contare i giorni vuoti deve esserci la causale di maternità facoltativa su periodo di assenza precedente o successivo 
      if wCausMatFac = P_CAUSALE or T040c.T040causale = P_CAUSALE then
        wContGGVuoti:=True;
      else
        wContGGVuoti:=False;
      end if;
      wFinePerPrec:=T040c.T040DATA_DA;
      wInizioPerSucc:=T040c.T040DATA_A;
      -- Conto i giorni non lavorativi del periodo buco per detrminare i giorni di OFFSET da sottrarre alle competenze 
      wGGLav:='N';
      wDataCiclo:=wFinePerPrec;
      while wDataCiclo <= wInizioPerSucc and wStartGGVuoti and wContGGVuoti loop
        begin
          --verifico se non lavorativo da calendario
          select decode(LAVORATIVO,'S',decode(FESTIVO,'S','N','S'),'N')
          into wGGLav
          from V010_CALENDARI
          where PROGRESSIVO = P_PROGRESSIVO and DATA = wDataCiclo;
        exception
          when others then
            exit;
        end;
        if wGGLav = 'S' then
          --verifico se turnista, e se pianificato o giustificato un riposo (o rip.comp.)
          select decode(max(nvl(T080.TURNO1,NVL(T260.CODINTERNO,T260B.CODINTERNO))),null,'S','N') into wGGLav
            from T430_STORICO T430, T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260, T260_RAGGRASSENZE T260B, T080_PIANIFORARI T080
          where T430.PROGRESSIVO = P_PROGRESSIVO
            and   wDataCiclo between T430.DATADECORRENZA and T430.DATAFINE
            and   T430.TGESTIONE = '1'
            and   T430.PROGRESSIVO = T040.PROGRESSIVO(+)
            and   wDataCiclo = T040.DATA(+)
            and   T040.CAUSALE = T265.CODICE(+)
            and   T265.CODRAGGR = T260.CODICE(+)
            and   T260.CODINTERNO(+) = 'E'
            and   T265.CODRAGGR = T260B.CODICE(+)
            and   T260B.CODINTERNO(+) = 'H'
            and   T430.PROGRESSIVO = T080.PROGRESSIVO(+)
            and   wDataCiclo = T080.DATA(+)
            and   T080.TURNO1(+) = '0';
          if wGGLav = 'S' then
            exit;
          end if;
        end if;
        select count(*) into i from T100_TIMBRATURE
        where PROGRESSIVO = P_PROGRESSIVO and DATA = wDataCiclo and FLAG in ('O','I');
        if i = 0 then
          select count(*) into i from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265
            where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA = wDataCiclo and T040.CAUSALE = T265.CODICE and T265.ESCLUSIONE = 'S';
        end if;
        if i = 0 then
          select count(*) into i from T040_GIUSTIFICATIVI T040, T275_CAUPRESENZE T275
            where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA = wDataCiclo and T040.CAUSALE = T275.CODICE;
        end if;
        if i = 0 then
          select count(*) into i from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
          where T040.PROGRESSIVO = P_PROGRESSIVO
          and   T040.DATA = wDataCiclo
          and   T040.CAUSALE = T265.CODICE
          and   T265.CODRAGGR = T260.CODICE
          and   T260.CODINTERNO not in ('E','H')
          --and   T265.CODICE not in ('RPA','RPP')
          and   T265.CODICE not in
                 (select NVL(RICALCOLO_CAUS_NEG, '      ') from T020_ORARI
                  union
                  select NVL(RICALCOLO_CAUS_POS, '      ') from T020_ORARI);
        end if;
        if i > 0 then
          exit;
        end if;
        wOffsetGGVuoti:=wOffsetGGVuoti + 1;
        wDataCiclo:=wDataCiclo + 1;
      end loop;
    end loop;
    if wContaPeriodiVuoti >= 2 then
      P_OFFSET_GGVUOTI:=P_OFFSET_GGVUOTI + wOffsetGGVuoti;
    end if;  
  end if;
END;
/
