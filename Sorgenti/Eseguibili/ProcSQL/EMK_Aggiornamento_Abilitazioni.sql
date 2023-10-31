-- Operazioni di inizializzazione/aggiornamento tabelle DCL
 CREATE OR REPLACE PROCEDURE EMK_AGGIORNAMENTO_ABILITAZIONI (ABMENSA IN VARCHAR2) AS
  CURSOR C1 IS 
    SELECT * FROM
    (SELECT BADGE,TERMINALI FROM T430_STORICO 
       WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE
       AND BADGE IN (SELECT BADGE FROM T430_STORICO 
         WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE
         AND BADGE BETWEEN 1 AND 100000
         GROUP BY BADGE HAVING COUNT(*) > 1)
       AND TRUNC(SYSDATE) BETWEEN INIZIO AND NVL(FINE,TO_DATE('31123999','DDMMYYYY'))
    UNION ALL
     SELECT BADGE,TERMINALI FROM T430_STORICO 
       WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE
       AND BADGE IN (SELECT BADGE FROM T430_STORICO 
         WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE
         AND BADGE BETWEEN 1 AND 100000
         GROUP BY BADGE HAVING COUNT(*) <= 1))
    ORDER BY BADGE;
  CURSOR C2 IS 
    SELECT * FROM
    (SELECT BADGE,EDBADGE,SCADENZA_BADGE FROM T430_STORICO 
       WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE 
       AND NVL(SCADENZA_BADGE,TO_DATE('31123999','DDMMYYYY')) >= TRUNC(SYSDATE) 
       AND BADGE IN (SELECT BADGE FROM T430_STORICO 
         WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE
         AND BADGE BETWEEN 1 AND 100000
         GROUP BY BADGE HAVING COUNT(*) > 1)
       AND TRUNC(SYSDATE) BETWEEN INIZIO AND NVL(FINE,TO_DATE('31123999','DDMMYYYY'))
    UNION ALL
     SELECT BADGE,EDBADGE,SCADENZA_BADGE FROM T430_STORICO 
       WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE 
       AND NVL(SCADENZA_BADGE,TO_DATE('31123999','DDMMYYYY')) >= TRUNC(SYSDATE) 
       AND BADGE IN (SELECT BADGE FROM T430_STORICO 
         WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE
         AND BADGE BETWEEN 1 AND 100000
         GROUP BY BADGE HAVING COUNT(*) <= 1))
    ORDER BY BADGE;          
  Numterm number(2);
  Numvirgole number;
  Startterm number;
  Endterm number;
  EsciCiclo boolean;
  P number; 
BEGIN
  COMMIT;
  SET TRANSACTION READ WRITE;
  -- Verifico lock per sapere se posso aggiornare le tabelle EMKDATIBADGE e EMKABILITAZIONI
  LOCK TABLE  EMKTABFLAG IN EXCLUSIVE MODE;
  -- Cancellazione tabella EMKDATIBADGE
  DELETE EMKDATIBADGE;
  -- Caricamento di tutti i badge ed edizione nella tabella EMKDATIBADGE
  FOR T2 IN C2 LOOP
    BEGIN 
     INSERT INTO EMKDATIBADGE 
       (BADGE, EDIZIONE, CLMENSA, DATASCAD)
     VALUES 
       (T2.BADGE, NVL(SUBSTR(T2.EDBADGE,1,1),'0'), ABMENSA, T2.SCADENZA_BADGE);
    EXCEPTION
      WHEN OTHERS THEN
        P:=0;
    END;
  END LOOP;
  -- Cancello le abilitazione dei terminali 
  DELETE EMKABILITAZIONI;
  -- Caricamento della tabella con le abilitazioni del badge sui terminali
  FOR T1 IN C1 LOOP
    IF LTRIM(RTRIM(T1.TERMINALI)) = '' OR T1.TERMINALI IS NULL THEN
      INSERT INTO EMKABILITAZIONI 
       (BADGE, TERMINALE)
      VALUES
       (T1.BADGE, 0);
    ELSE
      -- Ciclo sulla stringa dei terminali
      EsciCiclo:=False;
      Startterm:=1;
      Numvirgole:=1;
      LOOP
	  IF INSTR(T1.TERMINALI, ',', 1, Numvirgole) = 0 THEN
          Endterm:=LENGTH(RTRIM(T1.TERMINALI));
          EsciCiclo:=True;
        ELSE
          Endterm:=INSTR(T1.TERMINALI, ',', 1, Numvirgole) - 1;
        END IF;
        BEGIN
          Numterm:=TO_NUMBER(SUBSTR(SUBSTR(T1.TERMINALI,Startterm,Endterm - Startterm + 1),1,2));
        EXCEPTION
          WHEN OTHERS THEN
            Numterm:=-1;
        END;
        -- Inserisco il terminale sulla tabella AGGIORNA_EMKABILITAZIONI
        IF Numterm > -1 THEN
          BEGIN
            INSERT INTO EMKABILITAZIONI 
             (BADGE, TERMINALE)
            VALUES
             (T1.BADGE, Numterm);
          EXCEPTION
            WHEN OTHERS THEN
              P:=NULL;
          END; 
        END IF;
        EXIT WHEN EsciCiclo = True;
        Numvirgole:=Numvirgole + 1;
        Startterm:= Endterm + 2;
      END LOOP;
    END IF;
  END LOOP;  
  UPDATE EMKTABFLAG SET TABSTAT = 'P';
  COMMIT;
END;