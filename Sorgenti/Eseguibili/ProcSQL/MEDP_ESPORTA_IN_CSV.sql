create or replace procedure MEDP_ESPORTA_IN_CSV(TABELLA in varchar2, TABELLA_EXPORT in varchar2, INTERVALLO_COMMIT integer := 1000)
is  
  cursor cur_colonne_tabella(TABELLA varchar2) is
    select COLUMN_NAME
    from COLS
    where TABLE_NAME = upper(TABELLA);
  colonna COLS.TABLE_NAME%type;
  num_colonne integer;
  intestazione varchar2(32767);
  query_estrazione varchar2(32767);
  prima_riga boolean;
  type tcur_estrazione is ref cursor;
  cur_estrazione tcur_estrazione; 
  riga_estrazione varchar2(32767);
  num_linea integer;  
begin
  select count(*) into num_colonne
  from COLS
  where TABLE_NAME = upper(TABELLA);
  if num_colonne = 0 then   
    dbms_output.put_line(' !!! La tabella/vista '||TABELLA||' non esiste.');
    raise PROGRAM_ERROR;
  end if;
  
  select count(*) into num_colonne 
  from dual 
  where upper(TABELLA_EXPORT) like 'TMP%' or upper(TABELLA_EXPORT) like 'USR%';
  if num_colonne = 0 then      
    dbms_output.put_line(' !!! Il nome della tabella di destinazione deve inziare con USR o TMP.');
    raise PROGRAM_ERROR;
  end if;
  
  -- Compongo la query che estrarrà le righe del CSV
  prima_riga:=true;
  intestazione:='';
  query_estrazione:='select ';  
  begin
    open cur_colonne_tabella(TABELLA);  
    loop
      fetch cur_colonne_tabella into colonna;
      exit when cur_colonne_tabella%notfound;      
      if prima_riga then
        intestazione:=intestazione||colonna;
        query_estrazione:=query_estrazione||colonna;
        prima_riga:=false;
      else
        intestazione:=intestazione||';'||colonna;
        query_estrazione:=query_estrazione||'||'';''||'||colonna;
      end if;            
    end loop;
    exception 
      when others then
        dbms_output.put_line(' !!! Errore durante la creazione della query per l''estrazione.');  
        dbms_output.put_line(SQLCODE||' - '||SQLERRM);
        if cur_colonne_tabella%isopen then
          close cur_colonne_tabella;
        end if;
        raise;
  end;
  close cur_colonne_tabella;
  query_estrazione:=query_estrazione||' as CSV from '||TABELLA;    
 
  -- Svuoto la tabella temporanea
  begin
    execute immediate 'truncate table '||TABELLA_EXPORT;
    exception
      when others then
        dbms_output.put_line(' !!! Errore durante l''eliminazione dei record dalla tabella di destinazione '||TABELLA_EXPORT||'.');  
        dbms_output.put_line(SQLCODE||' - '||SQLERRM);
        raise;
  end;
  
  -- Ciclo nel cursore dinamico e salvo i record in TABELLA_EXPORT 
  begin
    -- Riga di intestazione
    execute immediate 'insert into '||TABELLA_EXPORT||' (NUM_LINEA,LINEA) values (0,:intestazione)' using intestazione;
    num_linea:=0;
    open cur_estrazione for query_estrazione;
    loop
      fetch cur_estrazione into riga_estrazione;
      exit when cur_estrazione%notfound;
      num_linea:=num_linea + 1;      
      execute immediate 'insert into '||TABELLA_EXPORT||' (NUM_LINEA,LINEA) values (:num_linea,:riga_estrazione)' using num_linea,riga_estrazione;
      if MOD(num_linea,INTERVALLO_COMMIT) = 0 then
        commit;
      end if;    
    end loop;
    close cur_estrazione; 
    commit;
  exception
      when others then
        dbms_output.put_line(' !!! Errore durante l''esportazione di '||TABELLA||' su '||TABELLA_EXPORT||'.');  
        dbms_output.put_line(SQLCODE||' - '||SQLERRM);  
        if cur_estrazione%isopen then
          close cur_estrazione;
        end if;
        commit; -- E' una tabella temporanea, evitiamo solo che ci siano transazioni pendenti.
        raise;
  end;
end;
/
