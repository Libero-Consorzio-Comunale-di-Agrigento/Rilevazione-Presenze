create or replace function I060F_NOMEUTENTE(pAZIENDA IN VARCHAR2, pPROGRESSIVO IN NUMBER) return varchar2 is

  cursor ci060 is
    select NOME_UTENTE
    from mondoedp.i060_login_dipendente
    where azienda = pAZIENDA
    and matricola = (select matricola from t030_anagrafico where progressivo = pPROGRESSIVO)
    order by nome_utente;

  result varchar2(1000);
begin
  result:=null;
  
  for ri060 in ci060 loop --potrebbero esserci più account per la stessa matricola    
    if result is not null then
      result:=result ||';';
    end if;
    result:=result||Trim(ri060.NOME_UTENTE);
  end loop;

  return(result);
end;
/