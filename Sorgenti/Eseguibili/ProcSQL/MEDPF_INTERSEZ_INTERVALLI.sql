create or replace function MEDPF_INTERSEZ_INTERVALLI(DATA_INT_1 in DATE,
                                                     ORA_INIZIO_1 in DATE,
                                                     ORA_FINE_1 in DATE,
                                                     DATA_INT_2 in DATE,
                                                     ORA_INIZIO_2 in DATE,
                                                     ORA_FINE_2 in DATE) return VARCHAR2
is
  minuti_inizio_1 number;
  minuti_fine_1 number;
  minuti_inizio_2 number;
  minuti_fine_2 number;
begin
  if abs(trunc(DATA_INT_1) - trunc(DATA_INT_2)) > 1 then
    return 'N';
  end if;

  minuti_inizio_1:=to_char(ORA_INIZIO_1,'SSSSS')/60;
  minuti_fine_1:=to_char(ORA_FINE_1,'SSSSS')/60;
  minuti_inizio_2:=to_char(ORA_INIZIO_2,'SSSSS')/60;
  minuti_fine_2:=to_char(ORA_FINE_2,'SSSSS')/60;

  if minuti_inizio_1 >= minuti_fine_1 then
    /* turno notturno, finisce domani. aggiungo 24h */
    minuti_fine_1:=minuti_fine_1 + 1440;
  end if;

  if trunc(DATA_INT_2) < trunc(DATA_INT_1) then
    /* il turno 2 è relativo a ieri */
    if minuti_inizio_2 < minuti_fine_2 then
      /* il turno 2 è completamente contenuto in ieri. il mio deve per forza iniziare oggi, quindi di certo
         non c'è intersezione */
      return 'N';
    else
      /* il turno 2 da ieri sconfina un po' ad oggi. mi interessa solo la parte in oggi */
      minuti_inizio_2:=0;
    end if;
  elsif trunc(DATA_INT_2) > trunc(DATA_INT_1) then
    /* il turno 2 è domani, aggiungo 24 h */
    minuti_inizio_2:=minuti_inizio_2 + 1440;
    minuti_fine_2:=minuti_fine_2 + 1440;
    if minuti_inizio_2 >= minuti_fine_2 then
      /* in più se il turno 2 sconfina a dopodomani aggiungo altre 24h */
      minuti_fine_2:=minuti_fine_2 + 1440;
    end if;
  else
    /* i due turni sono lo stesso giorno */
    if minuti_inizio_2 >= minuti_fine_2 then
      /* turno notturno, finisce domani. aggiungo 24h */
      minuti_fine_2:=minuti_fine_2 + 1440;
    end if;
  end if;

  if ((minuti_inizio_2 < minuti_fine_1) and (minuti_fine_2 > minuti_inizio_1)) then
    return 'S';
  else
    return 'N';
  end if;
end;
/
