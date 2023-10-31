create or replace function T193F_GETDESCRIZIONE(P_INTERFACCIA in varchar2, P_PROGRESSIVO in integer, P_VOCE_PAGHE in varchar2, P_DATARIF in date) return varchar2 is
  wInterfaccia varchar2(200);
  wDato  varchar2(200);
  wstat  varchar2(2000);
  result varchar2(2000);
begin
  wInterfaccia:=P_INTERFACCIA;
  if (wInterfaccia is null) and (P_PROGRESSIVO is not null) then
    select DATO into wDato from MONDOEDP.I091_DATIENTE where AZIENDA = I090F_GETAZIENDACORRENTE and TIPO = 'C9_SCARICOPAGHE';
    if wDato is null then
      wInterfaccia:='<INTERFACCIA UNICA>';
    else
      wstat:='select '||wDato||' from T430_STORICO where PROGRESSIVO = :PROGRESSIVO and last_day(:DATA) between DATADECORRENZA and DATAFINE';
      execute immediate wstat into wInterfaccia using in P_PROGRESSIVO,in P_DATARIF;
    end if;
  end if;


  select min(T193.DESCRIZIONE) into result
    from T193_VOCIPAGHE_PARAMETRI T193
   where T193.COD_INTERFACCIA = nvl(wInterfaccia,T193.COD_INTERFACCIA)
     and nvl(T193.VOCE_PAGHE_CEDOLINO,T193.VOCE_PAGHE) = P_VOCE_PAGHE
     and P_DATARIF between T193.DECORRENZA and T193F_GETDECORRENZAFINE(T193.COD_INTERFACCIA,T193.VOCE_PAGHE,T193.DECORRENZA)
     and T193.DESCRIZIONE is not null;

  return(result);
exception
  when others then 
    return(null);
end T193F_GETDESCRIZIONE;
/