create or replace procedure MEDP_IMPORTA_OGGETTI_MONDOEDP(P_AZIENDA in varchar2) as
  wUser varchar2(100);
  i integer;
  stmt varchar2(1000);
type 
  t_array is varray(29) of varchar2(30);
  wTabMondoedp t_array := t_array(
    'I015_TRADUZIONI_CAPTION',
    'I060_LOGIN_DIPENDENTE',
    'I061_PROFILI_DIPENDENTE',
    'I070_UTENTI',
    'I071_PERMESSI',
    'I072_FILTROANAGRAFE',
    'I073_FILTROFUNZIONI',
    'I074_FILTRODIZIONARIO',
    'I075_ITER_AUTORIZZATIVI',
    'I076_REGOLE_ACCESSO',
    'I080_MODULI',
    'I090_ENTI',
    'I091_DATIENTE',
    'I092_LOGTABELLE',
    'I093_BASE_ITER_AUT',
    'I094_CHKDATI_ITER_AUT',
    'I095_ITER_AUT',
    'I096_LIVELLI_ITER_AUT',
    'I097_VALIDITA_ITER_AUT',
    'I100_PARSCARICO',
    'I150_PARSCARICOGIUST',
    'IA100_STRUTTUREDATI',
    'IA110_DETTAGLIODATI',
    'IA120_DATIOUTPUT',
    'IA200_NBS_DATIANAGRAFICI',
    'IA203_NBS_DECODIFICHE',
    'IA205_SCR_VARIAZ_ANAGRAFICO',
    'T940_SCHEDULAZIONI_B027',
    'T941_SCHEDULAZIONI_B026'
  );
begin
  select UTENTE into wUser from MONDOEDP.I090_ENTI where AZIENDA = P_AZIENDA;
  if wUser = 'MONDOEDP' then
    return;
  end if;
  
  for i in 1..wTabMondoedp.count loop
    stmt:='drop table '||wUser||'.'||wTabMondoedp(i);
    dbms_output.put_line(stmt||';'); 
    --begin execute immediate stmt; exception when others then null; end;

    stmt:='drop synonym '||wUser||'.'||wTabMondoedp(i);
    dbms_output.put_line(stmt||';'); 
    --begin execute immediate stmt; exception when others then null; end;

    stmt:='create table '||wUser||'.'||wTabMondoedp(i)||' as select * from MONDOEDP.'||wTabMondoedp(i);
    if wTabMondoedp(i) = 'I100_PARSCARICO' then
      stmt:=stmt||' where AZIENDE like ''%'||P_AZIENDA||'%''';
    elsif wTabMondoedp(i) = 'IA100_STRUTTUREDATI' then
      null;
    elsif wTabMondoedp(i) = 'IA110_DETTAGLIODATI' then
       stmt:=stmt||' where AZIENDA in (''*'','''||P_AZIENDA||''')';
    else
      stmt:=stmt||' where AZIENDA = '''||P_AZIENDA||'''';    
    end if;

    dbms_output.put_line(stmt||';'); 
    --begin execute immediate stmt; exception when others then null; end;
  end loop;
end;
/