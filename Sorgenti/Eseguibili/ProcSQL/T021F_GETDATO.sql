create or replace function T021F_GETDATO(P_CODICE in varchar2, P_DATA in date, P_FASCIA in Varchar2, P_POS in integer, P_DATO in varchar2) return varchar2 is
  cursor c1 is
    select * from T021_FASCEORARI T021 
    where CODICE = P_CODICE and 
          TIPO_FASCIA = P_FASCIA and
          DECORRENZA = (select max(DECORRENZA) from T021_FASCEORARI where CODICE = T021.CODICE and DECORRENZA <= P_DATA)
    order by nvl(ID_TURNO,oreminuti(entrata)),uscita; 
  i integer;
begin
  i:=0;
  for t1 in c1 loop
    i:=i + 1;
    if i = P_POS then
      if upper(P_DATO) = 'ENTRATA' then
        return(t1.entrata);
      elsif upper(P_DATO) = 'USCITA' then
        return(t1.uscita);
      elsif upper(P_DATO) = 'MMANTICIPO' then
        return(t1.mmanticipo);
      elsif upper(P_DATO) = 'MMANTICIPOU' then
        return(t1.mmanticipou);
      elsif upper(P_DATO) = 'TOLLERANZA' then
        return(t1.tolleranza);
      elsif upper(P_DATO) = 'TOLLERANZAU' then
        return(t1.tolleranzau);
      elsif upper(P_DATO) = 'ARRFLESFASC' then
        return(t1.arrflesfasc);
      elsif upper(P_DATO) = 'ARRFLESFASCU' then
        return(t1.arrflesfascu);
      elsif upper(P_DATO) = 'MMRITARDO' then
        return(t1.mmritardo);
      elsif upper(P_DATO) = 'MMRITARDOU' then
        return(t1.mmritardou);
      elsif upper(P_DATO) = 'MMARROTOND' then
        return(t1.mmarrotond);
      elsif upper(P_DATO) = 'MMARROTONDU' then
        return(t1.mmarrotondu);
      elsif upper(P_DATO) = 'ARRRITARDO' then
        return(t1.arrritardo);
      elsif upper(P_DATO) = 'ARRUSCANT' then
        return(t1.arruscant);
      elsif upper(P_DATO) = 'SCOST_PUNTI_NOMINALI_E' then
        return(t1.scost_punti_nominali_e);
      elsif upper(P_DATO) = 'SCOST_PUNTI_NOMINALI_U' then
        return(t1.scost_punti_nominali_u);
      elsif upper(P_DATO) = 'MMFLEX' then
        return(t1.mmflex);
      elsif upper(P_DATO) = 'ORETEOTUR' then
        return(t1.oreteotur);
      elsif upper(P_DATO) = 'SIGLATURNI' then
        return(t1.siglaturni);
      elsif upper(P_DATO) = 'NUMTURNO' then
        return(t1.numturno);
      elsif upper(P_DATO) = 'OREMINIME' then
        return(t1.oreminime);          
      end if;
    end if;
  end loop;
  return(null);
end T021F_GETDATO;
/