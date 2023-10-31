create or replace procedure M040P_CARICA_MISSIONE_DAITER(pID in integer) as
  wProgressivo m140_richieste_missioni.progressivo%type;
  wMaschera    mondoedp.i005_msginfo.maschera%type;
  wTipo        mondoedp.i006_msgdati.tipo%type;
  wMsg         mondoedp.i006_msgdati.msg%type;
begin
  /* inizializzazioni */
  wMaschera:='M040P_CARICA_MISSIONE_DAITER';
  
  /* fase 1: importazione richiesta */
  begin
    /* estrae dati della richiesta per info log */ 
    begin
      select m140.progressivo
      into   wProgressivo
      from   m140_richieste_missioni m140, 
             t850_iter_richieste t850
      where  m140.id = pID
      and    t850.iter = 'M140'
      and    t850.id = m140.id;
    exception
      when no_data_found then
        wProgressivo:=null;
    end;
    
    if wProgressivo is null then
      /* se il progressivo è null, significa che la richiesta con l'id indicato è inesistente */
      wTipo:='A';
      wMsg:='Importazione impossibile: la richiesta ID = ' || pID || ' non è presente in archivio!';
    else
      /* importazione della trasferta su win */
      insert into m040_missioni 
        (progressivo, mesescarico, mesecompetenza, datada, orada, protocollo, tiporegistrazione, dataa, oraa,
         totalegg, durata,
         tariffaindintera, oreindintera, importoindintera, tariffaindridottah, oreindridottah, importoindridottah,
         tariffaindridottag, oreindridottag, importoindridottag, tariffaindridottahg, oreindridottahg, importoindridottahg,
         flag_modificato, partenza, destinazione, note_rimborsi, commessa, stato, cod_tariffa, cod_riduzione, id_missione)
      select m140.progressivo, trunc(m140.dataa,'MM'), trunc(m140.dataa,'MM'), m140.datada, m140.orada, m140.protocollo, m140.tiporegistrazione, m140.dataa, m140.oraa,
             m140.dataa - m140.datada + 1, minutiore(((m140.dataa - M140.datada) * 24 * 60) + (oreminuti(m140.oraa) - oreminuti(m140.orada))),
             0, 0, 0, 0, 0, 0,
             0, 0, 0, 0, 0, 0,
             'N',
             m140f_getpartenza(m140.id),
             m140f_getdestinazione(m140.id),
             null, null, 'S',
             decode(m140.flag_destinazione,'E','ESTERO',NULL), /* COD_TARIFFA   */
             decode(m140.flag_destinazione,'E','ZERO',NULL),   /* COD_RIDUZIONE */
             m140.id
      from   m140_richieste_missioni m140, 
             t850_iter_richieste t850
      where  m140.id = pID
      and    t850.iter = 'M140'
      and    t850.id = m140.id;
    
      /* errore se nessuna riga è stata inserita */
      if sql%rowcount = 0 then
        wTipo:='A';
        wMsg:='Importazione fallita: la richiesta ID = ' || pID || ' non è stata importata su IrisWin';
      else
        wTipo:='I';
        wMsg:='Importazione effettuata correttamente: richiesta ID = ' || pID;
      end if;
    end if;
  exception
    when others then
      /* errore in fase di inserimento */
      wTipo:='A';
      /*--NOLOG--*/
      wMsg:='Errore in fase di importazione della richiesta ID = ' || pID || ': ORA-' || sqlcode || ': ' || sqlerrm;
  end;
  
  /* fase 2: log delle operazioni relative all'inserimento missione */
  I005P_REGISTRAMSG(null,null,wMaschera,wTipo,wMsg,wProgressivo);
end;
/