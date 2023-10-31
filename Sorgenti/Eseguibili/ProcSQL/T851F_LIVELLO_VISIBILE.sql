create or replace function T851F_LIVELLO_VISIBILE
  (P_ITER in varchar2,P_COD_ITER in varchar2, P_LIVELLO in integer, P_STATO in varchar2, P_AUTORIZZ_AUTOMATICA in varchar2, P_ID in integer, P_ELABORATO in varchar2) 
/*usato nella C018 per vedere le richieste già autorizzate ma non ancora elaborate nel caso di importazione automatica sul cartellino*/
return varchar2 as
--livello visibile per autorizzazione automatica, quando ELABORATO = 'N':
--verifico se ci sono gli estremi perchè sia visibile al livello attuale, sia in fase di approvazione che di respinta
  wUltimoLiv integer;
  result varchar2(1);
begin
  if P_ELABORATO <> 'N' then
    return 'N';
  else --non ancora alaborato
    if P_STATO = 'N' then
      return 'S';
    else -- autorizzato o senza autorizzazione
      wUltimoLiv:=I096F_ULTIMOLIV_OBB(P_ITER, p_COD_ITER);
      if P_LIVELLO = wUltimoLiv then
        --ultimo livello obbligatorio
        return 'S';
      else --non è l'ultimo livello obbligatorio
        --se Stato nullo o Autorizzazione automatica o Livello superiore al livello obbligatorio max, esco 
        if (P_STATO is null) or (P_AUTORIZZ_AUTOMATICA = 'S') or (P_LIVELLO > wUltimoLiv) then
          return 'N';
        else
          --Verifico che la mia sia l'ultima autorizzazione non automatica, e che le restanti autorizzazioni siano tutte automatiche fino all'ultima
          select decode(max(T851.STATO),null,'N','S') into result
          from T850_ITER_RICHIESTE T850, T851_ITER_AUTORIZZAZIONI T851
          where T850.ID = P_ID
          and T850.ID = T851.ID
          and T851.LIVELLO = wUltimoLiv
          and T851.AUTORIZZ_AUTOMATICA = 'S'
          and not exists
            (select 'x' from T851_ITER_AUTORIZZAZIONI where ID = T851.ID and LIVELLO > P_LIVELLO and nvl(AUTORIZZ_AUTOMATICA,'N') = 'N');
          return result;
        end if;  
      end if;
    end if;
  end if;
end;
/