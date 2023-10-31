create or replace procedure GENERA_PERIODI_ASSENZA
  (PRG IN NUMBER, INZ IN DATE, FIN IN DATE, CAU IN VARCHAR2, TGI IN VARCHAR2, DAH IN VARCHAR2, ALH IN VARCHAR2, OPR IN VARCHAR2) AS
  cursor t0 is
    select
      distinct 
      greatest(T430.INIZIO,INZ) INIZIO, least(nvl(T430.FINE,PCK_CONST.DATA_INF),FIN) FINE
    from T430_STORICO T430 where
    T430.PROGRESSIVO = PRG and
    INZ <= nvl(T430.FINE,PCK_CONST.DATA_INF) and
    FIN >= T430.INIZIO
    order by INIZIO;
  
  procedure P_GENERA_PERIODO_ASSENZA 
    (P IN NUMBER, I IN DATE, F IN DATE, C IN VARCHAR2, TG IN VARCHAR2, DH IN VARCHAR2, AH IN VARCHAR2, OPER IN VARCHAR2) as
    -- internal variables here
    inizio date;
    fine date;
    dhd date;
    ahd date;
    dhd_T040 date;
    ahd_T040 date;
    ip date;
    fp date;
    dh_int varchar2(7);
    ah_int varchar2(7);
    vpaghe varchar2(10);
    cumulo varchar2(1);
    datamin date;
    datamax date;
    t430_mininizio date;
    t430_maxfine date;
    t430_varinizio date;
    esiste number;
    arrot integer;
    numore integer;
    uscita exception;
    cursor t1 is
      select data from t040_giustificativi where
        progressivo = p and
        data between inizio and fine and
        causale = c and tipogiust = tg and
        (tg = 'M' or daore = dhd_T040 or (dhd_T040 is null and daore is null)) and
        (tg = 'M' or aore = ahd_T040 or (ahd_T040 is null and aore is null))
      order by data;
  begin
    begin
      select VOCEPAGHE,TIPOCUMULO,OREMINUTI(FRUIZ_ARR)
      into VPAGHE,CUMULO,ARROT
      from T265_CAUASSENZE
      where CODICE = C
      and T230F_CHECK_SCARICOPAGHE_FRUIZ(C,F,TG) = 'S';
    exception
      when no_data_found then
        VPAGHE:=null;
    end;
    if (VPAGHE is null) or (CUMULO = 'T') then
      raise USCITA;
    end if;
    inizio:=I;
    fine:=F;
    dh_int:=dh;
    ah_int:=ah;
    /*Gestione arrotondamento della fruizione*/
    if (arrot > 1) and (dh_int is not null) then
      if ah_int is null then
        numore:=arrot - mod(oreminuti(dh_int),arrot);
        if numore < arrot then
          dh_int:=minutiore(oreminuti(dh_int) + numore);
        end if;
      else
        numore:=oreminuti(ah_int) - oreminuti(dh_int);
        numore:=arrot - mod(numore,arrot);
        if numore < arrot then
          if oreminuti(ah_int) + numore < 1440 then
            ah_int:=minutiore(oreminuti(ah_int) + numore);
          else
            ah_int:='23.59';
          end if;
        end if;
      end if;
    end if;
    /*Conversione Dalle/Alle da Stringa in Data*/
    DHD:=null;
    AHD:=null;
    if dh_int is not null then
      DHD:=to_date('30/12/1899' || dh_int,'DD/MM/YYYYHH24.MI');
    end if;
    if ah_int is not null then
      AHD:=to_date('30/12/1899' || ah_int,'DD/MM/YYYYHH24.MI');
    end if;

    if dh is not null then
      DHD_T040:=to_date('30/12/1899' || dh,'DD/MM/YYYYHH24.MI');
    end if;
    if ah is not null then
      AHD_T040:=to_date('30/12/1899' || ah,'DD/MM/YYYYHH24.MI');
    end if;

    if OPER = 'C' then
      /*Inserimento di tutti i periodi preesistenti intersecanti il periodo cancellato
        aggiornati con operazione 'C'*/
      insert into t042_periodiassenza
        (progressivo,causale,dal,al,tipogiust,daore,aore,data_agg,flag,operazione,ID)
        select progressivo,causale,dal,al,tipogiust,daore,aore,SYSDATE,flag,'C',T042_ID.nextval
          from t042_periodiassenza t042 where
          progressivo = p and
          causale = c and
          tipogiust = tg and
          (daore = dhd or (dhd is null and daore is null)) and
          (aore = ahd or (ahd is null and aore is null)) and
          dal <= fine and al >= inizio and
          operazione = 'I' and
          ID =
          (select max(ID)
             from t042_periodiassenza where
             progressivo = p and
             causale = c and
             tipogiust = tg and
             (daore = dhd or (dhd is null and daore is null)) and
             (aore = ahd or (ahd is null and aore is null)) and
             dal = t042.dal and
             al = t042.al);
      inizio:=inizio - 1;
      fine:=fine + 1;
    end if;
    
    /* determino se esiste record storico di appartenenza per la data di inizio*/
    t430_mininizio:=null;
    t430_maxfine:=null;
    t430_varinizio:=inizio;
    select min(T430.INIZIO),max(nvl(T430.FINE,PCK_CONST.DATA_INF)) into t430_mininizio,t430_maxfine from T430_STORICO T430 where 
      T430.PROGRESSIVO = p and 
      t430_varinizio between T430.INIZIO and nvl(T430.FINE,PCK_CONST.DATA_INF);

    /*Verifico se esistono giustificativi agli estremi del periodo:
      in questo caso il periodo deve essere prolungato oltre INIZIO e FINE per ricostruire correttamente il periodo*/
    select min(data),max(data) into datamin,datamax from t040_giustificativi where
      progressivo = p and
      causale = c and
      tipogiust = tg and
      (tg = 'M' or daore = dhd_T040 or (dhd_T040 is null and daore is null)) and
      (tg = 'M' or aore = ahd_T040 or (ahd_T040 is null and aore is null)) and
      data between inizio and fine;
    if datamin = inizio then
      esiste:=1;
      while esiste > 0 loop
        --INIZIO, INIZIO - 1
        select count(*) into esiste from t040_giustificativi where
          progressivo = p and
          data = inizio - 1 and
          causale = c and
          tipogiust = tg and
          (tg = 'M' or daore = dhd_T040 or (dhd_T040 is null and daore is null)) and
          (tg = 'M' or aore = ahd_T040 or (ahd_T040 is null and aore is null)) and
          data between t430_mininizio and t430_maxfine;
        if esiste > 0 then
          inizio:=inizio - 1;
        end if;
      end loop;
    else
      inizio:=datamin;
    end if;
    if datamax = fine then
      esiste:=1;
      while esiste > 0 loop
        --FINE, FINE + 1
        select count(*) into esiste from t040_giustificativi where
          progressivo = p and
          data = fine + 1 and
          causale = c and
          tipogiust = tg and
          (tg = 'M' or daore = dhd_T040 or (dhd_T040 is null and daore is null)) and
          (tg = 'M' or aore = ahd_T040 or (ahd_T040 is null and aore is null))and
          data between t430_mininizio and t430_maxfine;
        if esiste > 0 then
          fine:=fine + 1;
        end if;
      end loop;
    else
      fine:=datamax;
    end if;
    /*Scorrimento dell'intero periodo 'toccato' dall'operazione per ricreare i periodi effetivi*/
    ip:=inizio;
    fp:=inizio - 1;
    for c1 in t1 loop
      if c1.data = fp + 1 then
        fp:=c1.data;
      else
        insert into t042_periodiassenza
          (progressivo,causale,dal,al,tipogiust,daore,aore,data_agg,flag,operazione,ID)
          select progressivo,causale,dal,al,tipogiust,daore,aore,SYSDATE,flag,'C',T042_ID.nextval
            from t042_periodiassenza t042 where
            progressivo = p and
            causale = c and
            tipogiust = tg and
            (daore = dhd or (dhd is null and daore is null)) and
            (aore = ahd or (ahd is null and aore is null)) and
            dal >= ip and al <= fp and
            operazione = 'I' and
            ID =
            (select max(ID)
               from t042_periodiassenza where
               progressivo = p and
               causale = c and
               tipogiust = tg and
               (daore = dhd or (dhd is null and daore is null)) and
               (aore = ahd or (ahd is null and aore is null)) and
               dal = t042.dal and
               al = t042.al);
        insert into t042_periodiassenza
          (progressivo,causale,dal,al,tipogiust,daore,aore,data_agg,operazione,ID)
        select p,c,ip,fp,tg,dhd,ahd,SYSDATE,'I',T042_ID.nextval from dual;
        ip:=c1.data;
        fp:=c1.data;
      end if;
    end loop;
    if fp = fine then
      insert into t042_periodiassenza
        (progressivo,causale,dal,al,tipogiust,daore,aore,data_agg,flag,operazione,ID)
        select progressivo,causale,dal,al,tipogiust,daore,aore,SYSDATE,flag,'C',T042_ID.nextval
          from t042_periodiassenza t042 where
          progressivo = p and
          causale = c and
          tipogiust = tg and
          (daore = dhd or (dhd is null and daore is null)) and
          (aore = ahd or (ahd is null and aore is null)) and
          dal >= ip and al <= fp and
          operazione = 'I' and
          ID =
          (select max(ID)
             from t042_periodiassenza where
             progressivo = p and
             causale = c and
             tipogiust = tg and
             (daore = dhd or (dhd is null and daore is null)) and
             (aore = ahd or (ahd is null and aore is null)) and
             dal = t042.dal and
             al = t042.al);
      insert into t042_periodiassenza
        (progressivo,causale,dal,al,tipogiust,daore,aore,data_agg,operazione,ID)
      select p,c,ip,fp,tg,dhd,ahd,SYSDATE,'I',T042_ID.nextval from dual;
    end if;
  exception
   when uscita then
     null;
  end;
  
/* Main program -> esegue ciclo sui periodi di rapporto intersecanti il periodo INZ a FIN, e richiamando per ciascuno 
   la sottoprocedura P_GENERA_PERIODO_ASSENZA passando come parametri i periodi rilevati*/
begin     
  for c0 in t0 loop
    P_GENERA_PERIODO_ASSENZA(PRG,c0.INIZIO,c0.FINE,CAU,TGI,DAH,ALH,OPR); 
  end loop;  
end;     
/