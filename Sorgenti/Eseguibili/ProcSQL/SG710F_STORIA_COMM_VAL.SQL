create or replace function SG710F_STORIA_COMM_VAL(DATA in date, PROGRESSIVO in number, TIPO in varchar2, STATO in number) return varchar2 is
  cursor C1(P_DATA in date, P_PROGRESSIVO in number, P_TIPO in varchar2, P_STATO in number) is
    select decode(SG710.CHIUSO,'S','Scheda definitiva',SG746.DESCRIZIONE) DESC_STATO,
           decode(SG710.ACCETTAZIONE_VALUTATO,'S','Accettata','N','Non accettata') ESITO,
           trim(SG710.COMMENTI_VALUTATO) TESTO,
           to_char(SG710.DATA_ACCETTAZIONE_VALUTATO,'dd/mm/yyyy hh24.mi') DATA
    from SG710_TESTATA_VALUTAZIONI SG710,
         SG746_STATI_AVANZAMENTO SG746,
         T430_STORICO T430
    where (SG710.COMMENTI_VALUTATO is not null or SG710.ACCETTAZIONE_VALUTATO is not null)
    and SG710.DATA = P_DATA
    and SG710.PROGRESSIVO = P_PROGRESSIVO
    and SG710.TIPO_VALUTAZIONE = P_TIPO
    and SG710.STATO_AVANZAMENTO < P_STATO
    and SG710.PROGRESSIVO = T430.PROGRESSIVO
    and SG710.DATA between T430.DATADECORRENZA and T430.DATAFINE
    and least(nvl(T430.FINE,SG710.DATA),SG710.DATA) between SG746.DECORRENZA and SG746.DECORRENZA_FINE
    and SG710.CODREGOLA = SG746.CODREGOLA
    and SG710.STATO_AVANZAMENTO = SG746.CODICE
    order by STATO_AVANZAMENTO;
  Result varchar2(4000) := '';
begin
  Result:=null;
  for R1 in C1(DATA, PROGRESSIVO, TIPO, STATO) loop
    if Result is not null then
      Result:=Result || chr(13) || chr(10);
    end if;
    if R1.DATA is not null then
      Result:=Result || '(' || R1.DATA ||') ';
    end if;
    Result:=Result || R1.DESC_STATO || ': ';
    if R1.ESITO is not null then
      Result:=Result || R1.ESITO || '. ';
    end if;
    if R1.TESTO is not null then
      Result:=Result || R1.TESTO;
    end if;
  end loop;
  Result:=trim(Result);
  return(Result);
end;
/
