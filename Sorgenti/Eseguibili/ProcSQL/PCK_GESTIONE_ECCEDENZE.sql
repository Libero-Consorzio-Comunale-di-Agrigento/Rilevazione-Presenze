create or replace package PCK_GESTIONE_ECCEDENZE is
  procedure GET_LIMITI_TEORICI_PT(P_PROGRESSIVO in integer, P_DATA in date, P_PERCPT out number, P_MAXSUPPLANNO_PT out integer, P_MAXSTRANNO_PT out integer);
  procedure GET_LIMITI_ANNUALI(P_PROGRESSIVO in integer, P_DATA in date, P_PERCPT out number, P_MAXSTRANNOCAUS out integer, P_MAXSTRANNO out integer, P_MAXRESANNO out integer, P_MAXSTRANNO_TEORICO out integer, P_MAXRESANNO_TEORICO out integer, P_MAXSUPPLANNO_PT out integer, P_MAXSTRANNO_PT out integer);
  procedure GET_RESIDUOMESE_PT(P_PROGRESSIVO in integer, P_DATA in date, P_DEBITO in integer, P_ECCEDENZA in integer, P_STRRESIDUO out integer, P_SUPPLRESIDUO out integer);
end PCK_GESTIONE_ECCEDENZE;
/

create or replace package body PCK_GESTIONE_ECCEDENZE is

  /*Private*/

  procedure GET_DATIANAGRAFICI(P_PROGRESSIVO in integer, P_DATA in date, P_FINE out date, P_PERCPT out number, P_CONTRATTO out varchar2) is
  /*lettura percentuale di part-time a fine mese*/
  begin
    P_FINE:=null;
    P_PERCPT:=0;
    P_CONTRATTO:=null;

    select max(nvl(FINE,to_date('31123999','ddmmyyyy'))) into P_FINE
    from   T430_STORICO T430
    where  PROGRESSIVO = P_PROGRESSIVO
    and    trunc(P_DATA,'mm') <= nvl(FINE,to_date('31123999','ddmmyyyy'))
    and    last_day(P_DATA) >= INIZIO;

    if P_FINE is null then
      return;
    end if;

    P_FINE:=least(P_FINE,last_day(P_DATA));

    select CONTRATTO,nvl(T460.PERCPT_CALC,100) into P_CONTRATTO, P_PERCPT
    from   T430_STORICO T430, VT460_PARTTIME T460
    where  T430.PROGRESSIVO = P_PROGRESSIVO
    and    P_FINE between T430.DATADECORRENZA and T430.DATAFINE
    and    T430.PARTTIME = T460.CODICE(+);

    --leggo massima %PT assegnata nel mese
    if P_PERCPT < 100 then
      select max(T460.PERCPT_CALC) into P_PERCPT
      from   T430_STORICO T430, VT460_PARTTIME T460
      where  T430.PROGRESSIVO = P_PROGRESSIVO
      and    T430.DATADECORRENZA <= P_FINE
      and    T430.DATAFINE >= trunc(P_DATA,'mm')
      and    T430.PARTTIME = T460.CODICE
      and    nvl(T460.PERCPT_CALC,100) < 100;
    end if;
  end;

  procedure GET_STRANNUO(P_PROGRESSIVO in integer, P_DATA in date, P_MAXSTRANNOCAUS out integer, P_MAXSTRANNO out integer, P_MAXRESANNO out integer, P_MAXSTRANNO_TEORICO out integer, P_MAXRESANNO_TEORICO out integer) is
  /*limiti annuali da contratto + limiti individuali*/
    liq varchar2(7);
    res varchar2(7);
    liq_teorico varchar2(7);
    res_teorico varchar2(7);
  begin
    begin
      liq:=null;
      res:=null;
      liq_teorico:=null;
      res_teorico:=null;
      p_maxresanno_teorico:=0;
      p_maxstranno_teorico:=0;
      select liquidabile, residuabile, liquidabile_teorico, residuabile_teorico
      into liq, res, liq_teorico, res_teorico from t825_liquidindannuo where
      progressivo = p_progressivo and anno = to_char(p_data,'yyyy');
      p_maxresanno_teorico:=oreminuti(res_teorico);
      p_maxstranno_teorico:=oreminuti(liq_teorico);
      if res is null or liq is null then
        raise no_data_found;
      end if;
      p_maxresanno:=oreminuti(res);
      p_maxstranno:=oreminuti(liq);
    exception
      when no_data_found then
        begin
          select oreminuti(maxstraord),oreminuti(maxresiduabile) into p_maxstranno,p_maxresanno from t200_contratti where codice =
          (select contratto from t430_storico where
             progressivo = p_progressivo and
             last_day(p_data) between datadecorrenza and datafine);
          if liq is not null then
            p_maxstranno:=oreminuti(liq);
          end if;
          if res is not null then
            p_maxresanno:=oreminuti(res);
          end if;
        exception
          when no_data_found then
            if liq is null then
              p_maxstranno:=0;
            end if;
            if res is null then
              p_maxresanno:=0;
            end if;
        end;
    end;
    --Aggiunti i limiti mensili causalizzati, che non devono rientrare nei limiti annuali
    select nvl(sum(oreminuti(nvl(ore,'0'))),0) into p_maxstrannocaus
    from
      t820_limitiind t820, t275_caupresenze t275
    where
      progressivo = p_progressivo and
      anno = to_char(p_data,'yyyy') and
      mese between 1 and to_char(p_data,'mm') and
      t820.causale = t275.codice and
      t275.orenormali in ('B','D') and
      t275.no_limite_mensile_liq = 'S' and
      t820.liquidabile = 'S';
  end;

  procedure GET_FRUITO_PT(P_PROGRESSIVO in integer, P_DATA in date, P_STRFRUITO out integer, P_SUPPLFRUITO out integer) is
  /*ore supplementari e di straordinario già fruite nei mesi precedenti*/
    wSUPPLFRUITO integer;
    wSTRFRUITO integer;
    cursor c1 is
      select nvl(T077_SUPPL.VALORE_MAN,T077_SUPPL.VALORE_AUT) SUPPLFRUITO,
             nvl(T077_STR.VALORE_MAN,T077_STR.VALORE_AUT) STRFRUITO,
             T065.ORE_ECCEDENTI_RICH,
             T065.ORE_ECCEDENTI_AUT
      from   T077_DATISCHEDA T077_SUPPL,
             T077_DATISCHEDA T077_STR,
             (select 
               PROGRESSIVO,DATA,
               sum(oreminuti(ORE_ECCEDENTI)) ORE_ECCEDENTI_RICH, --Letto direttamente da T065
               sum(oreminuti(nvl(T852F_GETVALORE(ID,-1,'ORE_ECCEDENTI'),ORE_ECCEDENTI))) ORE_ECCEDENTI_AUT --Letto da T852: sono le ore confermate dall'autorizzatore
              from VT065_RICHIESTESTRAORDINARI
              where PROGRESSIVO = P_PROGRESSIVO
              and nvl(STATO,'S') = 'S'
              group by PROGRESSIVO,DATA) T065
      where  T077_SUPPL.PROGRESSIVO = P_PROGRESSIVO
      and    T077_SUPPL.DATA between trunc(P_DATA,'yyyy') and add_months(trunc(P_DATA,'yyyy'),11)
      and    T077_SUPPL.DATA <> trunc(P_DATA,'dd')
      and    T077_SUPPL.DATO = PCK_CONST.I011PT_ORE_SUPPL
      and    T077_STR.PROGRESSIVO = T077_SUPPL.PROGRESSIVO
      and    T077_STR.DATA = T077_SUPPL.DATA
      and    T077_STR.DATO = PCK_CONST.I011PT_ORE_STR
      and    T065.PROGRESSIVO(+) = T077_STR.PROGRESSIVO
      and    T065.DATA(+) = T077_STR.DATA;
  begin
    /*
    select nvl(sum(nvl(T077.VALORE_MAN,T077.VALORE_AUT)),0) into P_SUPPLFRUITO
    from   T077_DATISCHEDA T077
    where  T077.PROGRESSIVO = P_PROGRESSIVO
    and    T077.DATA between trunc(P_DATA,'yyyy') and add_months(trunc(P_DATA,'dd'),-1)
    and    T077.DATO = PCK_CONST.I011PT_ORE_SUPPL;

    select nvl(sum(nvl(T077.VALORE_MAN,T077.VALORE_AUT)),0) into P_STRFRUITO
    from   T077_DATISCHEDA T077
    where  T077.PROGRESSIVO = P_PROGRESSIVO
    and    T077.DATA between trunc(P_DATA,'yyyy') and add_months(trunc(P_DATA,'dd'),-1)
    and    T077.DATO = PCK_CONST.I011PT_ORE_STR;
    */
    P_SUPPLFRUITO:=0;
    P_STRFRUITO:=0;
    for t1 in c1 loop
      wSUPPLFRUITO:=t1.SUPPLFRUITO;
      wSTRFRUITO:=t1.STRFRUITO;
      --Si considerano le ore effettivamente autorizzate
      if (t1.ORE_ECCEDENTI_AUT is not null) and (t1.ORE_ECCEDENTI_AUT < t1.SUPPLFRUITO + t1.STRFRUITO) then
        wSTRFRUITO:=wSTRFRUITO - (t1.SUPPLFRUITO + t1.STRFRUITO - t1.ORE_ECCEDENTI_AUT);
        if wSTRFRUITO < 0 then
          wSUPPLFRUITO:=wSUPPLFRUITO + wSTRFRUITO;
          wSTRFRUITO:=0;
        end if;
      end if;
      P_SUPPLFRUITO:=P_SUPPLFRUITO + wSUPPLFRUITO;
      P_STRFRUITO:=P_STRFRUITO + wSTRFRUITO;
    end loop;
  end;

  procedure GET_SCAGLIONE_PT(P_PROGRESSIVO in integer, P_DATA in date, P_PERCPT out number, P_ORESUPPL_PT out integer, P_ORESTR_PT out integer) is
    wFINE date;
    wCONTRATTO varchar2(5);
  begin
    P_ORESUPPL_PT:=0;
    P_ORESTR_PT:=0;

    GET_DATIANAGRAFICI(P_PROGRESSIVO,P_DATA,wFINE,P_PERCPT,wCONTRATTO);
    if P_PERCPT in (0,100) then
      return;
    end if;

    --lettura scaglione per le ore supplementari e straordinario da contratto
    begin
      select oreminuti(T200.MAXSTRAORD)*(P_PERCPT/100),oreminuti(T203.ORE_SUPPL)
      into   P_ORESTR_PT, P_ORESUPPL_PT
      from   T200_CONTRATTI T200, T203_ORESUPPLEMENTARI_PT T203
      where  T200.CODICE = wCONTRATTO
      and    T203.CODICE = T200.CODICE
      and    last_day(wFINE) between T203.DECORRENZA and T203.DECORRENZA_FINE
      and    P_PERCPT between T203.PT_DAL and T203.PT_AL;
    exception
      when no_data_found then
        P_PERCPT:=100; --annullo la percentuale di part-time per evitare la gestione delle ore supplementari
        return;
    end;
  end;

  /*Public*/

  procedure GET_LIMITI_TEORICI_PT(P_PROGRESSIVO in integer, P_DATA in date, P_PERCPT out number, P_MAXSUPPLANNO_PT out integer, P_MAXSTRANNO_PT out integer) is
  /*Lettura limiti teorici sullo straordinario e ore suppementari per part-time, se esiste la gestione delle ore supplementari*/
    wPercPT number;
    wSUPPL_MESE number;
    wSTRAO_MESE number;
    wSUPPL_MESE_TOT number;
    wSTRAO_MESE_TOT number;
    wDataCorr date;
  begin
    P_MAXSUPPLANNO_PT:=0;
    P_MAXSTRANNO_PT:=0;
    wSUPPL_MESE_TOT:=0;
    wSTRAO_MESE_TOT:=0;
    --lettura dati anagrafici utili per il reperimento dei limiti annuali
    GET_SCAGLIONE_PT(P_PROGRESSIVO, P_DATA, P_PERCPT, wSUPPL_MESE, wSTRAO_MESE);
    if P_PERCPT in (0,100) then
      return;
    end if;

    wSUPPL_MESE_TOT:=wSUPPL_MESE_TOT + wSUPPL_MESE/12;
    wSTRAO_MESE_TOT:=wSTRAO_MESE_TOT + wSTRAO_MESE/12;

    --da rifare per n mesi indietro fintanto che non sono a tempo pieno
    wDataCorr:=add_months(P_DATA,-1);
    while trunc(wDataCorr,'yyyy') = trunc(P_DATA,'yyyy') loop
      GET_SCAGLIONE_PT(P_PROGRESSIVO, wDataCorr, wPercPT, wSUPPL_MESE, wSTRAO_MESE);
      if wPercPT in (0,100) then
        exit;
      end if;
      wSUPPL_MESE_TOT:=wSUPPL_MESE_TOT + wSUPPL_MESE/12;
      wSTRAO_MESE_TOT:=wSTRAO_MESE_TOT + wSTRAO_MESE/12;
      wDataCorr:=add_months(wDataCorr,-1);
    end loop;
    --da rifare per n mesi avanti fintanto che non sono a tempo pieno
    wDataCorr:=add_months(P_DATA,1);
    while trunc(wDataCorr,'yyyy') = trunc(P_DATA,'yyyy') loop
      GET_SCAGLIONE_PT(P_PROGRESSIVO, wDataCorr, wPercPT, wSUPPL_MESE, wSTRAO_MESE);
      if wPercPT in (0,100) then
        exit;
      end if;
      wSUPPL_MESE_TOT:=wSUPPL_MESE_TOT + wSUPPL_MESE/12;
      wSTRAO_MESE_TOT:=wSTRAO_MESE_TOT + wSTRAO_MESE/12;
      wDataCorr:=add_months(wDataCorr,1);
    end loop;

    P_MAXSUPPLANNO_PT:=trunc(wSUPPL_MESE_TOT);
    P_MAXSTRANNO_PT:=trunc(wSTRAO_MESE_TOT);
  end;

  procedure GET_LIMITI_ANNUALI(P_PROGRESSIVO in integer, P_DATA in date, P_PERCPT out number, P_MAXSTRANNOCAUS out integer, P_MAXSTRANNO out integer, P_MAXRESANNO out integer, P_MAXSTRANNO_TEORICO out integer, P_MAXRESANNO_TEORICO out integer, P_MAXSUPPLANNO_PT out integer, P_MAXSTRANNO_PT out integer) is
  /*Lettura limiti effettivi sullo straordinario, residuabile, ore suppementari*/
    wSUPPL_MESE integer;
    wSTRAO_MESE integer;
    wORE_SUPPL integer;
    wORE_STRAO integer;
    wSTRAO_FATTO_TP integer;
  begin
    P_MAXSTRANNOCAUS:=0;
    P_MAXSTRANNO:=0;
    P_MAXRESANNO:=0;
    P_MAXSTRANNO_TEORICO:=0;
    P_MAXRESANNO_TEORICO:=0;
    P_MAXSUPPLANNO_PT:=0;
    P_MAXSTRANNO_PT:=0;

    --lettura esistenza scaglioni part-time
    GET_SCAGLIONE_PT(P_PROGRESSIVO, P_DATA, P_PERCPT, wSUPPL_MESE, wSTRAO_MESE);
    /*
    if P_PERCPT = 0 then
      return;
    end if;
    */

    --lettura limiti standard da contratto
    GET_STRANNUO(P_PROGRESSIVO,P_DATA,P_MAXSTRANNOCAUS,P_MAXSTRANNO,P_MAXRESANNO,P_MAXSTRANNO_TEORICO,P_MAXRESANNO_TEORICO);
    if P_PERCPT in (0,100) then
      return;
    end if;
    -------------------------
    --fine calcolo standard--
    -------------------------

    ------------------------------------
    --esiste scaglione ore supplementari
    ------------------------------------
    --si procede col calcolo delle ore supplementari e straordinarie per il part-time

    --variazioni individuali da T830: sono da considerarsi come delle assegnazioni assolute: se non esistono, il limite è = 0
    select nvl(max(oreminuti(nvl(T830.VARIAZ_ORE_SUPPL,'00.00'))),0),nvl(max(oreminuti(nvl(T830.VARIAZ_ORE_STRAORD,'-0.01'))),-1)
    into   P_MAXSUPPLANNO_PT,P_MAXSTRANNO_PT--wVARIAZ_ORE_SUPPL,wVARIAZ_ORE_STRAORD
    from   T830_VARIAZ_STRAORD_PT_IND T830
    where  T830.PROGRESSIVO = P_PROGRESSIVO
    and    T830.DATA = (
      select max(DATA)
      from   T830_VARIAZ_STRAORD_PT_IND T830
      where  T830.PROGRESSIVO= P_PROGRESSIVO
      and    T830.DATA between trunc(P_DATA,'yyyy') and P_DATA
      );

    --se lo straordinario nn è specificato, si legge il massimale annuale.
    --Inoltre si controlla che la somma tra supplementare e straordinario così ricavato, non superi il massimale annuale
    if P_MAXSTRANNO_PT = -1 then
      GET_LIMITI_TEORICI_PT(P_PROGRESSIVO, P_DATA, P_PERCPT, wORE_SUPPL, wORE_STRAO);
      P_MAXSTRANNO_PT:=wORE_STRAO;
      if P_MAXSUPPLANNO_PT + P_MAXSTRANNO_PT > wORE_SUPPL + wORE_STRAO then
        P_MAXSTRANNO_PT:=P_MAXSTRANNO_PT - ((P_MAXSUPPLANNO_PT + P_MAXSTRANNO_PT) - (wORE_SUPPL + wORE_STRAO));
        if P_MAXSTRANNO_PT < 0 then
          P_MAXSUPPLANNO_PT:=greatest(0,P_MAXSUPPLANNO_PT + P_MAXSTRANNO_PT);
          P_MAXSTRANNO_PT:=0;
        end if;
      end if;
    end if;

    --Calcolo straordinario già fatto nei mesi a tempo pieno
    wSTRAO_FATTO_TP:=0;
    select nvl(sum(oreminuti(T071.banca_ore)),0) 
    into   wSTRAO_FATTO_TP
    from   T071_SCHEDAFASCE T071, T430_STORICO T430, VT460_PARTTIME VT460
    where  T071.PROGRESSIVO = T430.PROGRESSIVO and last_day(T071.DATA) between T430.DATADECORRENZA and T430.DATAFINE
    and    T430.PARTTIME = VT460.CODICE(+)
    and    nvl(VT460.PERCPT_CALC,100) = 100
    and    T071.PROGRESSIVO = P_PROGRESSIVO and trunc(T071.DATA,'yyyy') = trunc(P_DATA,'yyyy') order by data;

    P_MAXSTRANNO:=P_MAXSUPPLANNO_PT + P_MAXSTRANNO_PT + wSTRAO_FATTO_TP;
  end;

  procedure GET_RESIDUOMESE_PT(P_PROGRESSIVO in integer, P_DATA in date, P_DEBITO in integer, P_ECCEDENZA in integer, P_STRRESIDUO out integer, P_SUPPLRESIDUO out integer) is
  /*ore supplementari e di straodinario utilizzabili nel mese corrente*/
    wDEBITO integer;
    wPERCPT number;
    wMAXSTRANNOCAUS integer;
    wMAXSTRANNO integer;
    wMAXRESANNO integer;
    wMAXSTRANNO_TEORICO integer;
    wMAXRESANNO_TEORICO integer;
    wMAXSUPPLANNO_PT integer;
    wMAXSTRANNO_PT integer;
    wSTRFRUITO integer;
    wSUPPLFRUITO integer;
    wSUPPLRESIDUO integer;
    wSTRRESIDUO integer;
  begin
    P_STRRESIDUO:=0;
    P_SUPPLRESIDUO:=0;

    --lettura limiti annuali
    GET_LIMITI_ANNUALI(P_PROGRESSIVO, P_DATA, wPERCPT, wMAXSTRANNOCAUS, wMAXSTRANNO, wMAXRESANNO, wMAXSTRANNO_TEORICO, wMAXRESANNO_TEORICO, wMAXSUPPLANNO_PT, wMAXSTRANNO_PT);
    GET_FRUITO_PT(P_PROGRESSIVO, P_DATA, wSTRFRUITO, wSUPPLFRUITO);

    wSUPPLRESIDUO:=greatest(0,wMAXSUPPLANNO_PT - wSUPPLFRUITO);
    wSTRRESIDUO:=wMAXSTRANNO_PT - wSTRFRUITO;

    --calcolo debito tempo pieno
    wDEBITO:=P_DEBITO*100/wPERCPT;
    /*query per leggere debito tempo pieno da calendario
    select
      --to_char(V010.DATA,'MM'),
      minutiore(sum(decode(1 + trunc(V010.DATA) - trunc(V010.DATA,'IW'),'6',0,'7',0,1) * decode(festivo, 'S', 0, 1)) * (oreminuti('36.00')/5 ))
    into result
    from  V010_CALENDARI V010
    where V010.PROGRESSIVO = P_PROGRESSIVO and to_char(V010.DATA,'mm') = trunc(P_DATA) --2015 --to_char(:P_DATA,'MM/YYYY')
    --GROUP BY to_char(V010.DATA,'YYYY'),to_char(V010.DATA,'MM')
    ;
    */

    --ore eccedenti fatte entro il debito a tempo pieno, da considerare come supplementari
    P_SUPPLRESIDUO:=least(P_ECCEDENZA,greatest(0,wDEBITO - P_DEBITO));
    --ore eccedenti fatte oltre il debito a tempo pieno, da considerarsi come straordinario normale
    P_STRRESIDUO:=P_ECCEDENZA - P_SUPPLRESIDUO;

    --limitazioni entro i limiti annuali
    P_SUPPLRESIDUO:=least(P_SUPPLRESIDUO,wSUPPLRESIDUO);
    P_STRRESIDUO:=least(P_STRRESIDUO,wSTRRESIDUO);
  end;

begin
  -- Initialization
  null;
end PCK_GESTIONE_ECCEDENZE;
/