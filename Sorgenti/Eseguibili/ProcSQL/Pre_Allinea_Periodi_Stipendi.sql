create or replace procedure PRE_ALLINEA_PERIODI_STIPENDI (
  sCAMPI_NOT_NULL            in out varchar2            ,     -- contiene l'elenco dei valori di default dei campi not null
  sESP_CUR_REL               in out varchar2            ,     -- contiene la condizione per ricalcolare solo le relazioni modificate oppure solo quelle pilotate da altra tabella
  sDECORRENZE                in out varchar2            ,     -- contiene il dettaglio delle decorrenze per creare i periodi storici
  CAMPI_SEL                  in out varchar2            ,     -- contiene l'elenco dei campi da estrarre per l'appiattimento dei record
  TAB_FROM                   in out varchar2            ,     -- contiene l'elenco delle tabelle per l'appiattimento dei record
  COND_WHERE                 in out varchar2            ,     -- contiene l'elenco delle condizioni per l'appiattimento dei record
  CONSIDERA_REL_ALTRA_TAB    in     varchar2 default 'N',     -- specifica cosa restituire in sESP_CUR_REL (S=solo relazioni pilotate da altra tabella, N=solo relazioni eventualmente modificate)
  P_PROGRESSIVO              in     integer  default -1,
  P_RELAZIONI                in     varchar2 default 'S',
  P_DATISTORICI              in     varchar2 default 'S'
) as  
-- Questa procedura richiamata per ogni dipendente verifica
-- se i dati del periodo successivo sono uguali a quelli del
-- precedente unificando in questo caso i due periodi

  cursor CI030_DEC is
    select distinct DECORRENZA
    from   I030_RELAZIONI_ANAGRAFE
    where  TABELLA = 'P430_ANAGRAFICO'
    and    TIPO in ('L','S');
  cursor CI030_NULL is
    select distinct TABELLA, COLONNA
    from   I030_RELAZIONI_ANAGRAFE
    where  TABELLA = 'P430_ANAGRAFICO'
    and    TIPO in ('L','S');
  cursor CI030_ALTRA_TAB is
    select distinct COLONNA
    from   I030_RELAZIONI_ANAGRAFE
    where  TABELLA = 'P430_ANAGRAFICO'
    and    TIPO in ('L','S')
    and    TAB_ORIGINE <> TABELLA;
  cursor CI020 is
    select I020.COLONNA
    from   I020_DATI_ALLINEAMENTO   I020,
           I030_RELAZIONI_ANAGRAFE  I030
    where  I020.TIPO = 'R'
    and    I020.TABELLA = 'P430_ANAGRAFICO'
    and    I030.TABELLA = I020.TABELLA
    and    I030.COLONNA = I020.COLONNA
    order by I020.COLONNA;
  cursor CCOLS is
    select COLUMN_NAME NOMEDATO
    from   COLS
    where  TABLE_NAME = 'P430_ANAGRAFICO'
    and    COLUMN_NAME not in ('DECORRENZA','DECORRENZA_FINE');
  CURSORE_DINAMICO_NON_LIBERI integer;
  CURS_NON_LIBERI             integer;
  --
  -- DICHIARAZIONE ARRAY
  TYPE DATI_STORICI_NON_LIBERI_TYPE is record
    (X430_COLONNA   varchar2(100),
     TABELLA        varchar2(30),
     COD_COLONNA    varchar2(100));
  TYPE ARRAY_DATI_STORICI_NON_LIBERI is table of DATI_STORICI_NON_LIBERI_TYPE index by binary_integer;
  NON_LIBERI_ARR ARRAY_DATI_STORICI_NON_LIBERI;
  --
  TYPE DATI_STORICI_TYPE is record
    (X430_COLONNA   varchar2(100),
     TABELLA        varchar2(30),
     COD_COLONNA    varchar2(100));
  TYPE ARRAY_DATI_STORICI is table of DATI_STORICI_TYPE index by binary_integer;
  STORICI_ARR ARRAY_DATI_STORICI;
  --
  --
  -- DICHIARAZIONE VARIABILI
  I                           number          :=0 ;
  J                           number          :=0 ;
  ESPRESSIONE                 varchar2(32767) :='';
  sCOD_COLONNA                varchar2(100)   :='';
  sX430_COLONNA               varchar2(100)   :='';
  dDEC_REC                    date                ;   -- inizio decorrenza ricavata dai cursori da usare con la CREAZIONE_STORICO_STIPENDI
  NULLABLE                    varchar2(1)     :='';
  DATA_DEFAULT                varchar2(100)   :='';
-- INIZIO ELABORAZIONE
begin
  -- CARICO L'ELENCO DEI DATI STORICI NON LIBERI (CHE HANNO LA DECORRENZA_FINE!!!!!)
  NON_LIBERI_ARR(1).X430_COLONNA:= 'COD_VALUTA_STAMPA';                       NON_LIBERI_ARR(1).TABELLA:= 'P030_VALUTE';              NON_LIBERI_ARR(1).COD_COLONNA:= 'COD_VALUTA';
  NON_LIBERI_ARR(2).X430_COLONNA:= 'COD_CODICEINPS';                          NON_LIBERI_ARR(2).TABELLA:= 'P090_CODICIINPS';          NON_LIBERI_ARR(2).COD_COLONNA:= 'COD_CODICEINPS';
  NON_LIBERI_ARR(3).X430_COLONNA:= 'COD_CODICEINAIL';                         NON_LIBERI_ARR(3).TABELLA:= 'P092_CODICIINAIL';         NON_LIBERI_ARR(3).COD_COLONNA:= 'COD_CODICEINAIL';
  NON_LIBERI_ARR(4).X430_COLONNA:= 'COD_INQUADRINPDAP';                       NON_LIBERI_ARR(4).TABELLA:= 'P094_INQUADRINPDAP';       NON_LIBERI_ARR(4).COD_COLONNA:= 'COD_INQUADRINPDAP';
  NON_LIBERI_ARR(5).X430_COLONNA:= 'COD_INQUADRINPS';                         NON_LIBERI_ARR(5).TABELLA:= 'P096_INQUADRINPS';         NON_LIBERI_ARR(5).COD_COLONNA:= 'COD_INQUADRINPS';
  NON_LIBERI_ARR(6).X430_COLONNA:= 'COD_PARAMETRISTIPENDI';                   NON_LIBERI_ARR(6).TABELLA:= 'P212_PARAMETRISTIPENDI';   NON_LIBERI_ARR(6).COD_COLONNA:= 'COD_PARAMETRISTIPENDI';
  NON_LIBERI_ARR(7).X430_COLONNA:= 'COD_POSIZIONE_ECONOMICA||COD_CONTRATTO';  NON_LIBERI_ARR(7).TABELLA:= 'P220_LIVELLI';             NON_LIBERI_ARR(7).COD_COLONNA:= 'COD_POSIZIONE_ECONOMICA||COD_CONTRATTO';
  NON_LIBERI_ARR(8).X430_COLONNA:= 'COD_TABELLAANF';                          NON_LIBERI_ARR(8).TABELLA:= 'P236_TABELLEANF';          NON_LIBERI_ARR(8).COD_COLONNA:= 'COD_TABELLAANF';
  NON_LIBERI_ARR(9).X430_COLONNA:= 'COD_TIPOASSOGGETTAMENTO||COD_CONTRATTO';  NON_LIBERI_ARR(9).TABELLA:= 'P240_TIPIASSOGGETTAMENTI'; NON_LIBERI_ARR(9).COD_COLONNA:= 'COD_TIPOASSOGGETTAMENTO||COD_CONTRATTO';

  if P_DATISTORICI = 'S' then
    -- CICLO SUI DATI STORICI NON LIBERI
    J:=0;
    for I in 1..NON_LIBERI_ARR.COUNT loop
      -- AGGIUNGO COLONNA.TABELLA.CODICE AL VETTORE DEI DATI STORICI
      J:=J+1;
      STORICI_ARR(J).X430_COLONNA:=NON_LIBERI_ARR(I).X430_COLONNA;
      STORICI_ARR(J).TABELLA:=NON_LIBERI_ARR(I).TABELLA;
      STORICI_ARR(J).COD_COLONNA:=NON_LIBERI_ARR(I).COD_COLONNA;
      -- ESTRAGGO LE DECORRENZE DEI DATI NON LIBERI STORICI
      ESPRESSIONE:='select distinct DECORRENZA from '||NON_LIBERI_ARR(I).TABELLA||' T';
      if P_PROGRESSIVO > -1 then
        --ESPRESSIONE:=ESPRESSIONE||' where '||NON_LIBERI_ARR(I).COD_COLONNA||' in (select distinct '||NON_LIBERI_ARR(I).X430_COLONNA||' from P430_ANAGRAFICO where PROGRESSIVO = '||P_PROGRESSIVO||')';
        ESPRESSIONE:=ESPRESSIONE||' where exists(select 1 from P430_ANAGRAFICO P430 where P430.PROGRESSIVO = '||P_PROGRESSIVO||' and P430.'||NON_LIBERI_ARR(I).X430_COLONNA||' = T.'||NON_LIBERI_ARR(I).COD_COLONNA||')';
      end if;
      ESPRESSIONE:=ESPRESSIONE||' order by DECORRENZA';
      CURSORE_DINAMICO_NON_LIBERI:=DBMS_SQL.OPEN_CURSOR;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_NON_LIBERI,ESPRESSIONE,DBMS_SQL.NATIVE);
      DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_NON_LIBERI,1,dDEC_REC);
      CURS_NON_LIBERI:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_NON_LIBERI);
      loop
        if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_NON_LIBERI)>0 then
          DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_NON_LIBERI, 1, dDEC_REC);
          -- CREO UNO STORICO PER OGNI STORICIZZAZIONE DEL DATO NON LIBERO
          if NVL(INSTR(sDECORRENZE,TO_CHAR(dDEC_REC,'DDMMYYYY') || ','),0) = 0 then
            sDECORRENZE:=sDECORRENZE || TO_CHAR(dDEC_REC,'DDMMYYYY') || ',';
          end if;
        else
          exit;
        end if;
      end loop; -- FINE CURSORE_DINAMICO_NON_LIBERI --
      DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_NON_LIBERI);
    end loop; -- FINE NON_LIBERI_ARR --
  end if;

  if P_RELAZIONI = 'S' then   
    -- CICLO SULLE DECORRENZE RELAZIONI DI TIPO VINCOLATO E/O LIBERO
    for RI030_DEC in CI030_DEC loop
      dDEC_REC:=RI030_DEC.DECORRENZA;
      -- CREO UNO STORICO PER OGNI DECORRENZA DELLE RELAZIONI DI TIPO VINCOLATO
      if NVL(INSTR(sDECORRENZE,TO_CHAR(dDEC_REC,'DDMMYYYY') || ','),0) = 0 then
        sDECORRENZE:=sDECORRENZE || TO_CHAR(dDEC_REC,'DDMMYYYY') || ',';
      end if;
    end loop; -- FINE CI030_DEC --
    -- SALVO I VALORI DI DEFAULT DEI CAMPI DELLE RELAZIONI CHE NON POSSONO ESSERE NULL
    for RI030_NULL in CI030_NULL loop
      begin
        select NULLABLE, DATA_DEFAULT
        INTO   NULLABLE, DATA_DEFAULT
        from   COLS
        where  TABLE_NAME = RI030_NULL.TABELLA
        and    COLUMN_NAME = RI030_NULL.COLONNA;
      exception
        when NO_DATA_FOUND then
          NULLABLE:='Y';
          DATA_DEFAULT:='';
      end;
      if NULLABLE = 'N' then
        sCAMPI_NOT_NULL:=sCAMPI_NOT_NULL || RI030_NULL.COLONNA || '-' || DATA_DEFAULT || ',';
      end if;
    end loop; -- FINE CI030_NULL --
    -- CREO L'ESPRESSIONE SQL DEL CURSORE SULLE DECORRENZE
    sESP_CUR_REL:=NULL;
    if CONSIDERA_REL_ALTRA_TAB = 'S' then
      for RI030_ALTRA_TAB in CI030_ALTRA_TAB loop
        I030P_GETCATENA('P430_ANAGRAFICO',RI030_ALTRA_TAB.COLONNA,sESP_CUR_REL);
      end loop; -- FINE CI030_ALTRA_TAB --
    else
      for RI020 in CI020 loop
        I030P_GETCATENA('P430_ANAGRAFICO',RI020.COLONNA,sESP_CUR_REL);
      end loop; -- FINE CI020 --
    end if;
    if sESP_CUR_REL is not null then
      sESP_CUR_REL:=RTRIM(LTRIM(SUBSTR(sESP_CUR_REL,1,LENGTH(sESP_CUR_REL)-1)));
      sESP_CUR_REL:=' and I030.COLONNA in (' || sESP_CUR_REL || ')';
    else
      sESP_CUR_REL:=' and 1 = 2 ';
    end if;
  end if;
  
  if P_DATISTORICI = 'S' then
    -- CREO LA select PER L'APPIATTIMENTO DEI record
    CAMPI_SEL:=''' ''';
    for RCOLS in CCOLS loop
      if CAMPI_SEL = ''' ''' then
        CAMPI_SEL:= 'nvl(to_char(P430.' || RCOLS.NOMEDATO ||'),'' '')';
      else
        CAMPI_SEL:=CAMPI_SEL || '||nvl(to_char(P430.' || RCOLS.NOMEDATO||'),'' '')';
      end if;
    end loop;
    TAB_FROM:='';
    COND_WHERE:='';
    for I in 1..STORICI_ARR.COUNT loop
      -- AGGIUNGO LA DESCRIZIONE TRA I DATI DA ESTRARRE
      CAMPI_SEL:=CAMPI_SEL || ' || T' || I || '.DESCRIZIONE';
      -- AGGIUNGO LA TABELLA NELL'ELENCO DELLA from
      TAB_FROM:=TAB_FROM || ', ' || STORICI_ARR(I).TABELLA || ' T' || I;
      -- AGGIUNGO LE CONDIZIONI DI ACCESSO
      sCOD_COLONNA:=STORICI_ARR(I).COD_COLONNA;
      sX430_COLONNA:=STORICI_ARR(I).X430_COLONNA;
      while INSTR(sCOD_COLONNA,'||') > 0 loop
        COND_WHERE:=COND_WHERE || ' and T' || I || '.' || SUBSTR(sCOD_COLONNA,1,INSTR(sCOD_COLONNA,'||')-1) || ' (+) = P430.' || SUBSTR(sX430_COLONNA,1,INSTR(sX430_COLONNA,'||')-1);
        sCOD_COLONNA:=SUBSTR(sCOD_COLONNA,INSTR(sCOD_COLONNA,'||')+2);
        sX430_COLONNA:=SUBSTR(sX430_COLONNA,INSTR(sX430_COLONNA,'||')+2);
      end loop;
      COND_WHERE:=COND_WHERE || ' and T' || I || '.' || sCOD_COLONNA || ' (+) = P430.' || sX430_COLONNA ||
                                ' and P430.DECORRENZA_FINE BETWEEN T' || I || '.DECORRENZA (+) and T' || I || '.DECORRENZA_FINE (+)';
    end loop;
  end if;  
end;
/
