/* Procedure per scarico timbrature di presenza e mensa da MICRONTEL */
CREATE OR REPLACE PROCEDURE MICR_SCARICO_TIMBRATURE(BADGEC IN NUMBER, DATAC IN DATE, ORAC IN DATE, SENSOC IN VARCHAR2, TERMINALEC IN NUMBER, CAUSALEC IN NUMBER, INSERIMENTO IN OUT VARCHAR2) AS
  CAUSALEC1 VARCHAR2(2);
  P NUMBER;
  SECONDI NUMBER;
  TR VARCHAR2(1);
  CM VARCHAR2(5);
BEGIN
  INSERIMENTO:='S';
  SELECT PROGRESSIVO INTO P FROM MEDPT430_STORICO WHERE
    BADGEC = BADGE AND
    DATAC BETWEEN DATADECORRENZA AND DATAFINE AND
    INIZIO<=DATAC AND (FINE IS NULL OR FINE>=DATAC) AND
    ROWNUM = 1;
    BEGIN
      IF CAUSALEC = 0 THEN
        CAUSALEC1:=NULL;
      ELSE
        CAUSALEC1:=LPAD(TO_CHAR(CAUSALEC),2,'0');
      END IF;
      BEGIN
        SELECT FUNZIONE,CAUSMENSA INTO TR,CM FROM MEDPT361_OROLOGI WHERE CODICE = LPAD(TO_CHAR(TERMINALEC),2,'0');
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          TR:='P';
      END;
      IF TR = 'E' AND (CM IS NOT NULL) THEN
        IF CM = CAUSALEC THEN
          TR:='M';
        ELSE
          TR:='P';
        END IF;
      END IF;
      IF TR IN ('M','E') THEN
        /*Timbrature mensa*/
        SECONDI:=0;
        WHILE SECONDI <= 59 LOOP
          BEGIN
            INSERT INTO MEDPT370_TIMBMENSA
               (PROGRESSIVO,DATA,ORA,VERSO,RILEVATORE,FLAG)
            VALUES
               (P,DATAC,TO_DATE('01011900'||TO_CHAR(ORAC,'HH24MI')||LPAD(TO_CHAR(SECONDI),2,'0'),'DDMMYYYYHH24MISS'),
                SENSOC,LPAD(TO_CHAR(TERMINALEC),2,'0'),'O');
            EXIT;
          EXCEPTION
            WHEN OTHERS THEN
              SECONDI:=SECONDI + 1;
          END;
        END LOOP;
      END IF;
      IF TR IN ('P','E') THEN
        /*Timbrature presenza*/
        INSERT INTO MEDPT100_TIMBRATURE
          (PROGRESSIVO,DATA,ORA,VERSO,CAUSALE,RILEVATORE,FLAG)
        VALUES
          (P,DATAC,TO_DATE('01011900'||TO_CHAR(ORAC,'HH24MI'),'DDMMYYYYHH24MI'),
           SENSOC,CAUSALEC1,LPAD(TO_CHAR(TERMINALEC),2,'0'),'O');
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        P:=0;
    END;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        INSERT INTO MEDPI101_TIMBIRREGOLARI
          (DATA,BADGE,ORA,VERSO,RILEV,CAUSALE)
        VALUES
          (DATAC,BADGEC,TO_DATE('01011900'||TO_CHAR(ORAC,'HH24MI'),'DDMMYYYYHH24MI'),SENSOC,
           LPAD(TO_CHAR(TERMINALEC),2,'0'),CAUSALEC1);
END;
