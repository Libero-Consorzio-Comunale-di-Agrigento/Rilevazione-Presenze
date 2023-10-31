create or replace function T425F_GGSERVIZIO(P_PROGRESSIVO in integer,
                                            P_TIPORAPPORTO in varchar2,
                                            P_VALIDAZIONE in varchar2 := 'S',
                                            P_DATA in date := null,
                                            P_GG_SERVIZIO_ASPETTATIVA in varchar2 := 'S',
                                            P_TIPO_CALCOLO in varchar2 := 'GG')
return varchar2 as

/*
P_TIPORAPPORTO: D: solo tempi determinati   (nvl(T450.TIPO,'R') in ('I','S'))
                I: solo tempi indeterminati (nvl(T450.TIPO,'R') not in ('I','S'))
                *: tutti i periodi (senza condizione su T450.TIPO)
P_VALIDAZIONE: S: validazione = 'S' (considero solo T430, 425 con Validazione = 'D' oppure 'A'),
               N: validazione = 'N' (considero solo T425),
               *: validazione in ('S','N');
P_DATA:        data max oltre la quale interrompere la considerazione dei gg servizio: default = null = '31/12/3999'
P_GG_SERVIZIO_ASPETTATIVA: indica se i gg estratti sono quelli di Servizio = S, di servizio fte(Full Time Equivalente) = E o di Aspettativa = A; default = S
P_TIPO_CALCOLO: indica il tipo di calcolo da effettuare GG = giorni Servizio o Aspettativa; 5 = Data anzianita' 5 anni; 15 = Data anzianita' 15 anni; default = GG
*/

  wData date;
  wInizio varchar2(100);  --Colonna della T430 definita su I091_DATIENTE where TIPO = C22_INIZIO_RAPGIUR
  wFine   varchar2(100);  --Colonna della T430 definita su I091_DATIENTE where TIPO = C22_FINE_RAPGIUR
  wColInizio date;
  wColFine date;
  wEspressione varchar2(2000);
  wggasp number;
  wggcalcolo number;
  wfte number;
  wggservprec number;
  wDataAnzianita5 date;
  wDataAnzianita15 date;
  cDAL date;
  cAL date;
  cGiorniAnzianita5  number := 1826; --  4 anni da 365 + 1 anno bisestile da 366
  cGiorniAnzianita15 number := 5478; -- 12 anni da 365 + 3 anni bisestili da 366
  CURSORE_DINAMICO integer;
  CURSORE integer;

cursor C425(cDAL date, cAL date) is
  select T425.INIZIO,
         NVL(T425.FINE,pck_const.DATA_INF) FINE,
         T425.TIPORAPPORTO,
         (NVL(T460.PIANTA,100)/100) PP
    from T425_RAPPORTILAVORO_ALTRIENTI T425, T450_TIPORAPPORTO T450, T460_PARTTIME T460
   where T425.PROGRESSIVO = P_PROGRESSIVO
     and T425.TIPORAPPORTO = T450.CODICE(+)
     and ((P_TIPORAPPORTO = '*') or (decode(nvl(T450.TIPO,'R'),'I','D',
                                                              'S','D',
                                                                  'I') = P_TIPORAPPORTO))
     and (T450.TIPO <> 'A' or T450.TIPO is null)
     and T425.PARTTIME = T460.CODICE
     and T425.INIZIO < wData
     and T425.FINE >= cDAL and T425.INIZIO <= cAL
     and T425.VALIDAZIONE = 'N';

cursor C425D(cDAL date, cAL date) is
  select T425.INIZIO,
         NVL(T425.FINE,pck_const.DATA_INF) FINE,
         T425.TIPORAPPORTO,
         (NVL(T460.PIANTA,100)/100) PP
    from T425_RAPPORTILAVORO_ALTRIENTI T425, T450_TIPORAPPORTO T450, T460_PARTTIME T460
   where T425.PROGRESSIVO = P_PROGRESSIVO
     and T425.TIPORAPPORTO = T450.CODICE(+)
     and ((P_TIPORAPPORTO = '*') or (decode(nvl(T450.TIPO,'R'),'I','D',
                                                              'S','D',
                                                                  'I') = P_TIPORAPPORTO))
     and (T450.TIPO <> 'A' or T450.TIPO is null)
     and T425.PARTTIME = T460.CODICE
     and T425.INIZIO < wData
     and T425.FINE >= cDAL and T425.INIZIO <= cAL
     and T425.VALIDAZIONE in ('D','A');

begin
  wggcalcolo:=0;

  wData:=nvl(P_DATA,TRUNC(SYSDATE));

  --PERIODO VALIDATO --> LETTURA DA T430
  if P_VALIDAZIONE in ('S', '*') then
    wDataAnzianita5:='';
    wDataAnzianita15:='';
    wggservprec:=0;

    select nvl(i091.dato, 'INIZIO') into wInizio
      from mondoedp.i091_datiente i091
     where i091.azienda = i090f_getaziendacorrente
       and i091.tipo = 'C22_INIZIO_RAP_GIURIDICO';

    select nvl(i091.dato, 'FINE') into wFine
      from mondoedp.i091_datiente i091
     where i091.azienda = i090f_getaziendacorrente
       and i091.tipo = 'C22_FINE_RAP_GIURIDICO';

    if wInizio = 'INIZIO' then
      wEspressione:=
      'select distinct greatest(DATADECORRENZA,INIZIO) INIZIO, least(DATAFINE,NVL(T430.FINE,pck_const.DATA_INF)) FINE, T430.TIPORAPPORTO, T450.TIPO
       from T430_STORICO T430, T450_TIPORAPPORTO T450
       where T430.PROGRESSIVO = '||P_PROGRESSIVO||
      '  and T430.TIPORAPPORTO = T450.CODICE(+)
         and (T450.TIPO <> ''A'' or T450.TIPO is null)
         and (('''||P_TIPORAPPORTO||'''= ''*'') or (decode(nvl(T450.TIPO,''R''),''I'',''D'',''S'',''D'',''I'') = '''||P_TIPORAPPORTO||'''))
         and DATAFINE >= INIZIO AND DATADECORRENZA <= NVL(T430.FINE,pck_const.DATA_INF)
         and DATADECORRENZA < '''||wData||'''
         and INIZIO  < '''||wData||'''
         order by INIZIO';
    else
      wEspressione:=
      'select distinct greatest(DATADECORRENZA,INIZIO) INIZIO, least(DATAFINE,NVL(T430.FINE,pck_const.DATA_INF)) FINE, T430.TIPORAPPORTO, T450.TIPO
        from T430_STORICO T430, T450_TIPORAPPORTO T450
       where T430.PROGRESSIVO = '||P_PROGRESSIVO||
      '  and T430.TIPORAPPORTO = T450.CODICE(+)
         and (T450.TIPO <> ''A'' or T450.TIPO is null)
         and (('''||P_TIPORAPPORTO||'''= ''*'') or (decode(nvl(T450.TIPO,''R''),''I'',''D'',''S'',''D'',''I'') = '''||P_TIPORAPPORTO||'''))
         and DATAFINE >= INIZIO AND DATADECORRENZA <= NVL(T430.FINE,pck_const.DATA_INF)
         and DATADECORRENZA < '''||wData||'''
         and INIZIO  < '''||wData||'''
       union
       select distinct greatest(DATADECORRENZA,'||wInizio||') INIZIO, least(DATAFINE,NVL('||wFine||',pck_const.DATA_INF)) FINE, T430.TIPORAPPORTO, T450.TIPO
        from T430_STORICO T430, T450_TIPORAPPORTO T450
       where T430.PROGRESSIVO = '||P_PROGRESSIVO||
      '  and T430.TIPORAPPORTO = T450.CODICE(+)
         and (T450.TIPO <> ''A'' or T450.TIPO is null)
         and (('''||P_TIPORAPPORTO||'''= ''*'') or (decode(nvl(T450.TIPO,''R''),''I'',''D'',''S'',''D'',''I'') = '''||P_TIPORAPPORTO||'''))
         and DATAFINE >= '||wInizio||' AND DATADECORRENZA <= NVL(T430.'||wFine||',pck_const.DATA_INF)
         and DATADECORRENZA < '''||wData||'''
         and '||wInizio||' < '''||wData||'''
         and not exists (select 1 from t430_storico t430a
                         where t430a.progressivo = t430.progressivo
                         and t430.'||wInizio||' >= t430a.inizio and NVL(T430.'||wFine||',pck_const.DATA_INF) <= nvl(t430a.fine,pck_const.DATA_INF)
                        )
         order by INIZIO';
    end if;
--    dbms_output.put_line(wEspressione);
    CURSORE_DINAMICO:=dbms_sql.open_cursor;
    dbms_sql.parse(CURSORE_DINAMICO,wEspressione,dbms_sql.native);
    dbms_sql.define_column(CURSORE_DINAMICO,1,wColInizio);
    dbms_sql.define_column(CURSORE_DINAMICO,2,wColFine);
    CURSORE:=dbms_sql.execute(CURSORE_DINAMICO);
    loop
      if dbms_sql.fetch_rows(CURSORE_DINAMICO) > 0 then
        dbms_sql.column_value(CURSORE_DINAMICO, 1, wColInizio);
        dbms_sql.column_value(CURSORE_DINAMICO, 2, wColFine);
        -- Calcolo il coefficiente FTE Full Time Equivalente
        if P_GG_SERVIZIO_ASPETTATIVA = 'E' then
          select sum((least(T430.DATAFINE,least(wColFine, wData)) - greatest(T430.DATADECORRENZA,wColInizio) + 1) / (least(wColFine, wData) - wColInizio + 1)
                      * nvl(T460.PIANTA,100) / 100) into wfte
          from T430_STORICO T430, T460_PARTTIME T460 WHERE T430.PROGRESSIVO = P_PROGRESSIVO AND T430.DATADECORRENZA <= least(wColFine, wData) AND T430.DATAFINE >= wColInizio
          and  T430.PARTTIME = T460.CODICE(+);
        else
          wfte:=1;
        end if;
        if P_GG_SERVIZIO_ASPETTATIVA in ('S','E') then
          wggcalcolo:=wggcalcolo + (least(wColFine, wData) - wColInizio + 1)*wfte;
        end if;

        -- Sottraggo aspettative dal conteggio dei giorni utili considerando i singoli periodi di servizio
        select sum(
        -- ASPETTATIVE DA T055 solo validate ed escludendo giorni gia' contati da T040
        nvl((select greatest(least(T055.AL,wColFine) - greatest(T055.DAL,wColInizio),-1) + 1
          from T055_PERIODI_ASPETTATIVA T055, T430_STORICO T430, T450_TIPORAPPORTO T450
         where T055.PROGRESSIVO = P_PROGRESSIVO
           and T055.VALIDAZIONE = 'S'
           and T055.DAL <= wColFine
           and T055.AL >= wColInizio
           and T055.PROGRESSIVO = T430.PROGRESSIVO and T055.AL between T430.DATADECORRENZA and T430.DATAFINE
           and T430.TIPORAPPORTO = T450.CODICE(+) and ((P_TIPORAPPORTO = '*') or (decode(nvl(T450.TIPO,'R'),'I','D','S','D','I') = P_TIPORAPPORTO))
           and (T450.TIPO <> 'A' or T450.TIPO is null)
        ),0) +
        -- ASPETTATIVE DA T040 escludendo giorni validati gia' contati da T055
        nvl((select count(t040.data)
          from T040_GIUSTIFICATIVI T040, T257_ACCORPCAUSALI T257, T255_TIPOACCORPCAUSALI T255, T430_STORICO T430, T450_TIPORAPPORTO T450
         where T040.PROGRESSIVO = P_PROGRESSIVO
           and T257.COD_CAUSALE = T040.CAUSALE
           and T040.DATA between T257.DECORRENZA and T257.DECORRENZA_FINE
           and T040.DATA between wColInizio and least(wColFine, wData)
           and T040.PROGRESSIVO = T430.PROGRESSIVO and T040.DATA between T430.DATADECORRENZA and T430.DATAFINE
           and T430.TIPORAPPORTO = T450.CODICE(+) and ((P_TIPORAPPORTO = '*') or (decode(nvl(T450.TIPO,'R'),'I','D','S','D','I') = P_TIPORAPPORTO))
           and (T450.TIPO <> 'A' or T450.TIPO is null)
           and T257.COD_TIPOACCORPCAUSALI = T255.COD_TIPOACCORPCAUSALI and T255.TIPO = 'ASP'
           and not exists (select 'x' from T055_PERIODI_ASPETTATIVA T055
                            where T055.PROGRESSIVO = T040.PROGRESSIVO and T040.DATA between T055.DAL and T055.AL
                              and T055.VALIDAZIONE = 'S'
                              and T257.COD_CAUSALE = T040.CAUSALE
                              and T040.DATA between T257.DECORRENZA and T257.DECORRENZA_FINE
                              and T257.COD_TIPOACCORPCAUSALI = T255.COD_TIPOACCORPCAUSALI and T255.TIPO = 'ASP'
                          )
        ),0))*wfte into wggasp
        from dual;
        --PERIODO LAVORATO PRESSO ALTRO ENTE DURANTE ASPETTIVA PRESSO ENTE CORRENTE o durante rapporto di lavoro Altro
        --VALIDAZIONE: D = record sovrapposto a periodo di aspettativa validato;  A = record sovrapposto a un periodo di lavoro di T450.Tipo='A'
        if P_VALIDAZIONE in ('S', '*') then --> conta i periodi da T425 con validazione = 'A' o 'D'
          for T425 in C425D(wColInizio, least(wColFine, wData)) loop
            if P_GG_SERVIZIO_ASPETTATIVA = 'E' then
              wggcalcolo:=wggcalcolo + (least(T425.FINE, least(wColFine, wData)) - greatest(T425.INIZIO,wColInizio) + 1) * T425.PP;
            else
              wggcalcolo:=wggcalcolo + (least(T425.FINE, least(wColFine, wData)) - greatest(T425.INIZIO,wColInizio) + 1);
            end if;
          end loop;
        end if;
        --PERIODO DA VALIDARE --> LETTURA DA T425 se richiesto esplicitamente
        if (P_GG_SERVIZIO_ASPETTATIVA IN ('S','E')) and (P_VALIDAZIONE in ('N', '*')) then --> conta i periodi da T425 con validazione = 'N'
          for T425 in C425(wColInizio, least(wColFine, wData)) loop
            if P_GG_SERVIZIO_ASPETTATIVA = 'E' then
              wggcalcolo:=wggcalcolo + (least(T425.FINE, least(wColFine, wData)) - greatest(T425.INIZIO,wColInizio) + 1) * T425.PP;
            else
              wggcalcolo:=wggcalcolo + (least(T425.FINE, least(wColFine, wData)) - greatest(T425.INIZIO,wColInizio) + 1);
            end if;
          end loop;
        end if;

        if P_GG_SERVIZIO_ASPETTATIVA in('S','E') then
          wggcalcolo:=wggcalcolo - wggasp;
          if P_TIPO_CALCOLO = '5' and wDataAnzianita5 is null and wggcalcolo >= cGiorniAnzianita5 then
              wDataAnzianita5:=wColInizio + cGiorniAnzianita5 - wggservprec;
          elsif P_TIPO_CALCOLO = '15' and wDataAnzianita15 is null and wggcalcolo >= cGiorniAnzianita15 then
            wDataAnzianita15:=wColInizio + cGiorniAnzianita15 - wggservprec;
          end if;
          if wggservprec >= 0 then
            wggservprec:=wggcalcolo;
          end if;
        elsif P_GG_SERVIZIO_ASPETTATIVA = 'A' then
          wggcalcolo:=wggcalcolo + wggasp;
        end if;
      else
        exit;
      end if;
    end loop;
    dbms_sql.close_cursor(CURSORE_DINAMICO);

  end if;

  if P_TIPO_CALCOLO = 'GG' then
    return trunc(wggcalcolo);
  elsif P_TIPO_CALCOLO = '5' then
    return wDataAnzianita5;
  elsif P_TIPO_CALCOLO = '15' then
    return wDataAnzianita15;
  end if;
end;
/