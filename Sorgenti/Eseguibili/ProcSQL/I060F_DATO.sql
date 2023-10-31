create or replace function I060F_DATO(pAZIENDA IN VARCHAR2, pPROGRESSIVO IN NUMBER, pDATO in varchar2 := 'EMAIL') return varchar2 is
/* pDATO = EMAIL|EMAIL_PEC|CELLULARE */
  cursor ci060 is
    select email,email_pec,cellulare
    from mondoedp.i060_login_dipendente
    where azienda = pAZIENDA
    and matricola = (select matricola from t030_anagrafico where progressivo = pPROGRESSIVO)
    order by nome_utente;
  Dato1 varchar2(1000):='';
  Dato2 varchar2(1000):='';
  result varchar2(1000):='';
begin
  result:='';
  if upper(nvl(pDATO,'null')) not in ('EMAIL','EMAIL_PEC','CELLULARE') then
    return 'dato '||pDATO||' non valido';
  end if;

  for ri060 in ci060 loop --potrebbero esserci più account per la stessa matricola
    if upper(pDATO) = 'EMAIL' then
      Dato1:=Trim(ri060.email) || ';';
    elsif upper(pDATO) = 'EMAIL_PEC' then
      Dato1:=Trim(ri060.email_pec) || ';';
    elsif upper(pDATO) = 'CELLULARE' then
      Dato1:=Trim(ri060.cellulare) || ';';
  end if;
    while Instr(Dato1,';') > 0 loop --potrebbero esserci più email per lo stesso account
      Dato2:=Trim(Substr(Dato1,1,Instr(Dato1,';') - 1));
      if (NVL(Dato2,'#NULL#') <> '#NULL#')
      and (Instr(';' || Result,';' || Dato2 || ';') = 0) then
        Result:=Result || Dato2 || ';';
      end if;
      Dato1:=Substr(Dato1,Instr(Dato1,';') + 1);
    end loop;
  end loop;
  Result:=Replace(Substr(Result,1,Length(Result) - 1),';','; ');
  return(result);
end;
/