create or replace procedure M060P_CARICA_ANTICIPI_DAITER(pID in integer) as
  cursor c1 is
    select M140.PROGRESSIVO, '01' CASSA, to_char(sysdate,'yyyy') ANNO, M160.CODICE COD_VOCE, M140.DATADA DATA_MISSIONE, M140.DATADA DATA_MOVIMENTO, M160.QUANTITA, M160.QUANTITA IMPORTO, decode(M140.FLAG_DESTINAZIONE,'E','E','I') ITA_EST, M140.ID ID_MISSIONE
    from   M140_RICHIESTE_MISSIONI M140, M160_RICHIESTE_ANTICIPI M160, T850_ITER_RICHIESTE T850
    where  M140.ID = pID
    and    M140.ID = M160.ID
    and    T850.ITER = 'M140'
    and    T850.ID = M140.ID
    and    nvl(T850.TIPO_RICHIESTA,'0') <> 'A';
  wNUM_MOVIMENTO integer;
begin
  for t1 in c1 loop
    select nvl(max(NUM_MOVIMENTO),0) into wNUM_MOVIMENTO from M060_ANTICIPI
    where PROGRESSIVO = T1.PROGRESSIVO
    and CASSA = T1.CASSA
    and ANNO_MOVIMENTO = T1.ANNO
    and COD_VOCE = T1.COD_VOCE;
    
    insert into M060_ANTICIPI 
      (PROGRESSIVO, CASSA, ANNO_MOVIMENTO, NUM_MOVIMENTO, COD_VOCE, DATA_MISSIONE, DATA_MOVIMENTO, QUANTITA, IMPORTO, FLAG_TOTALIZZATORE, STATO, DATA_IMPOSTAZIONE_STATO, ITA_EST, ID_MISSIONE)
    values 
      (T1.PROGRESSIVO, T1.CASSA, T1.ANNO, wNUM_MOVIMENTO + 1, T1.COD_VOCE, T1.DATA_MISSIONE, T1.DATA_MOVIMENTO, T1.QUANTITA, T1.IMPORTO, 'S', 'P', trunc(sysdate), T1.ITA_EST, T1.ID_MISSIONE);
  end loop;
end;
/