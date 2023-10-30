unit A000UMessaggi;
(*
Nomenclature Constanti:
A000MSG[_x]_y_z_descrizione
  A000MSG : prefisso per tutte le costanti definite
  x:
   <Snnn> messaggio specifico per una unit
   dove Snnn è il codice unit - per es. A006, S101, W009. I WAnnn diventano Annn

  y:
    <ERR> : Messaggio di errore
    <MSG> : Messaggio informativo
    <DLG> : Richiesta di conferma tramite dialog

  z:
    <FMT> : Messaggio che contiene parametri (va usato in una format)
*)

interface

uses SysUtils;

resourcestring
  //messaggi di errore generici
  A000MSG_ERR_WEBSRV_CHIMATA_FALLITA       = 'Errore durante l''autenticazione sul servizio web!'#13#10'La chiamata al web service è fallita.';
  A000MSG_ERR_FMT_WEBSRV_RISP_ERRATA       = 'Errore durante l''autenticazione sul servizio web!'#13#10'Risposta del web service non interpretata'#13#10'(%s/%s)';
  A000MSG_ERR_FMT_WEBSRV_GENERICO          = 'Errore durante l''autenticazione sul servizio web!'#13#10'Motivo: %s/%s';
  A000MSG_ERR_WEBSRV_NO_NOME_UTENTE        = 'Errore durante l''autenticazione sul servizio web!'#13#10'Impossibile recuperare il nome utente';
  A000MSG_ERR_WEBSRV_RISP_NO_RICONOS       = 'Errore durante l''autenticazione sul servizio web!'#13#10'La risposta del web service non è stata riconosciuta!';

  A000MSG_ERR_DATA_VALIDA                  = 'Indicare una data valida!';
  A000MSG_ERR_CONN_FALLITA                 = 'Connessione fallita!';
  A000MSG_ERR_AZIENDA_NON_INDICATA         = 'Indicare l''azienda!';
  A000MSG_ERR_AZIENDA_INESISTENTE          = 'Azienda inesistente!';
  A000MSG_MSG_SEL_AZIENDA                  = 'Selezionare l''azienda';
  A000MSG_ERR_ALIAS_DB_ERRATO              = 'Database %s inesistente!';
  A000MSG_ERR_UTENTE_NON_INDICATO          = 'Indicare il nome utente!';
  A000MSG_ERR_AUT_FALLITA                  = 'Autenticazione fallita!';
  A000MSG_MSG_SEL_PROFILO                  = 'Selezionare il profilo';
  A000MSG_ERR_PROFILO_NON_TROVATO          = 'Profilo inesistente!';
  A000MSG_ERR_ACCESSO_NEGATO_NO_PSW        = 'Non è possibile accedere senza password!';
  A000MSG_MSG_ALLINEAMENTO_VERSIONE        = 'Attenzione!'#13#10'La versione del database (%s) non corrisponde alla versione del prodotto (%s).'#13#10'E'' necessario allineare la propria postazione di lavoro alla versione del database.'#13#10'Se il problema persiste contattare l''amministratore di sistema.';
  A000MSG_MSG_ACCESSO_INIBITO              = 'Attenzione!'#13#10'L''accesso all''applicativo è momentaneamente inibito per attività di amministrazione.'#13#10'Riprovare più tardi o contattare l''amministratore dell''applicativo.';
  A000MSG_MSG_USER_SCADUTA                 = 'Attenzione!'#13#10'E'' scaduto il periodo di validità di questo operatore. Contattare l''amministratore dell''applicativo';
  A000MSG_MSG_PSW_SCADUTA                  = 'La password è scaduta! Inserirne una nuova';

  A000MSG_ERR_FORM_CON_MODIFICHE           = 'Attenzione esistono Modifiche non confermate sulla funzione in oggetto.'#13#10'Confermare o annullare i dati.';
  A000MSG_ERR_LOGOUT_IMPEDITO              = 'Alcune schede non possono essere chiuse a causa di operazioni pendenti.'#13#10'Verificare le schede rimaste aperte.';

  A000MSG_ERR_MODIFICHE_PENDING            = 'Attenzione esistono Modifiche non confermate.'#13#10'Impossibile chiudere.';
  A000MSG_ERR_CHIAVE_DUPLICATA             = 'Chiave già esistente';
  A000MSG_ERR_PROFILO_UTILIZZATO           = '';
  A000MSG_ERR_SELEZIONARE_ELEMENTO         = 'E'' necessario selezionare un elemento della lista!';
  A000MSG_ERR_CANC_ESISTE_MOV_STORICO      = 'Esiste almeno un movimento storico associato al dato: impossibile procedere con la cancellazione!';
  A000MSG_ERR_MODIF_ESISTE_MOV_STORICO     = 'Esiste almeno un movimento storico associato al dato con decorrenza precedente a quella impostata: impossibile procedere con la modifica!';
  A000MSG_ERR_DECOR_SUP_SCAD               = 'Periodo storico errato: Decorrenza maggiore della Scadenza.';
  A000MSG_ERR_PERIODI_INTERSECANTI         = 'Periodi intersecanti!';
  A000MSG_ERR_DATE_INTERS_PERIODI          = 'Impossibile effettuare l''inserimento! Le date specificate intersecano periodi già esistenti!';
  A000MSG_ERR_RAGGR_INTERO_ANNO            = 'Se il raggruppamento è ad anno solare, il periodo deve comprendere un intero anno.';
  A000MSG_ERR_AGGIORNAMENTO_NON_ABIL       = 'Aggiornamento non abilitato!';
  A000MSG_ERR_PERIODO_ERRATO               = 'Il periodo indicato non è corretto!';
  A000MSG_ERR_PERIODO_LUNGO                = 'Il periodo indicato è troppo lungo';
  A000MSG_ERR_ELIMINA_PROFILO              = 'Profilo utilizzato, impossibile eliminarlo.';
  A000MSG_ERR_MODIFICA_PROFILO             = 'Profilo utilizzato, impossibile modificarlo.';
  A000MSG_ERR_DECIMALI_GIORNI              = 'E'' ammesso solo .5 come parte decimale dei giorni!';
  A000MSG_ERR_MINUTI                       = 'I minuti devono essere minori di 60!';
  A000MSG_ERR_MINUTI_DIVISORI              = 'I minuti devono essere divisori di 60!';
  A000MSG_ERR_ORA_NON_VALIDA               = 'Formato ora non valido!';
  A000MSG_ERR_FUNZ_NON_ABILITATA           = 'Funzione non abilitata!';
  A000MSG_ERR_FUNZ_NON_ASSEGNATA           = 'Funzione non assegnata!';
  A000MSG_ERR_NO_DIP_INS                   = 'Inserimento impossibile!'#13#10'Nessun dipendente selezionato!';
  A000MSG_ERR_NO_DIP                       = 'Nessun dipendente selezionato!';
  A000MSG_ERR_NO_SANIT_CONV                = 'Nessun sanitario convenzionato selezionato!';
  A000MSG_ERR_GENERICO                     = 'Errore imprevisto';
  A000MSG_ERR_GIORNO_MESE                  = 'Giorno e mese non sono corretti!';
  A000MSG_ERR_DATA_ERRATA                  = 'La data e'' errata!';
  A000MSG_ERR_ANNO_ERRATO                  = 'Anno non valido!';
  A000MSG_ERR_TIMB_DUPLICATA               = 'Timbratura già esistente: chiudere il popup per visualizzarla nel cartellino';
  A000MSG_ERR_NO_LISTA_GIORNI              = 'Selezionare i giorni di riferimento!';
  A000MSG_ERR_DATE_INVERTITE               = 'Le date devono essere in successione cronologica!';
  A000MSG_ERR_DATE_RIFERIMENTO             = 'Le date di riferimento sono errate!';
  A000MSG_ERR_DATE_INSERITE                = 'Le date inserite non sono corrette.';
  A000MSG_ERR_CODICE_ASS_DUPLICATO         = 'Codice già esistente come causale di assenza!';
  A000MSG_ERR_CODICE_PRES_DUPLICATO        = 'Codice già esistente come causale di presenza!';
  A000MSG_ERR_CODICE_ESISTENTE             = 'Codice già esistente!';
  A000MSG_ERR_GIUST_CANC_NON_TROVATO       = 'Giustificativo da cancellare non trovato.';
  A000MSG_ERR_FRUIZ_INF_VINCOLI            = 'La fruizione è inferiore ai vincoli specificati.';
  A000MSG_ERR_FRUIZ_SUP_VINCOLI            = 'La fruizione è superiore ai vincoli specificati.';
  A000MSG_ERR_FMT_FRUIZ_ARR_VINCOLI        = 'La fruizione non è compatibile col valore di arrotondamento %s.';
  A000MSG_ERR_DECORR_NON_SUCC_SCAD         = 'La decorrenza non può essere successiva alla scadenza!';
  A000MSG_ERR_VAL_NUM                      = 'Inserire solo valori numerici';
  A000MSG_MSG_ARROTONDAMENTO_NON_ESISTE    = 'Non esiste l''arrotondamento: formattazione non effettuata';

  A000MSG_ERR_NO_INSERIMENTO               = 'Inserimento non consentito!';
  A000MSG_ERR_ABIL_ESTERNI                 = 'Attenzione! L''utente utilizzato non è abilitato alla modifica di dipendenti Esterni!';
  A000MSG_ERR_DECORRENZA_INVALIDA          = 'La data di decorrenza deve essere compresa tra il 1900 ed il 3999.';
  A000MSG_ERR_DATA_INVALIDA                = 'Sono consentite solo date a partire dal 1900.';
  A000MSG_ERR_PERCENTUALE                  = 'La percentuale deve assumere valori compresi tra 0 e 100.';
  A000MSG_ERR_FMT_PERCENTUALE              = 'La %s deve assumere valori compresi tra 0 e 100.';
  A000MSG_ERR_PWD_CARATTERI_NON_AMMESSI    = 'La password contiene caratteri non ammessi!';
  A000MSG_ERR_FILE_NON_CREATO              = 'File non creato.';
  A000MSG_ERR_FILE_INESISTENTE             = 'File inesistente';
  A000MSG_ERR_FILE_VUOTO                   = 'File vuoto';
  A000MSG_ERR_VISUALIZ_FILE                = 'Impossibile visualizzare il file. File inesistente.';
  A000MSG_ERR_FMT_APRI_FILE                = 'Impossibile aprire il file "%s"!';
  A000MSG_ERR_FMT_LETTURA_FILE             = 'Errore nella lettura del file: %s';
  A000MSG_ERR_DATO_NON_VALIDO              = 'Dato non valido!';
  A000MSG_ERR_FMT_DATO_NON_VALORIZZATO     = 'Il dato ''%s'' deve essere valorizzato!';
  A000MSG_ERR_FMT_DATO_ELEM_LISTA          = 'Il dato ''%s'' non è valido! Selezionare un elemento dalla lista';
  A000MSG_ERR_DATO_SPAZI                   = 'Dato non valido: ci sono degli spazi!';
  A000MSG_ERR_OPERAZIONE_NON_ESEGUITA      = 'Operazione non eseguita!';
  A000MSG_ERR_DATO_BOOLEAN_ERRATO          = 'I valori consentiti sono S o N.';
  A000MSG_ERR_FUNZIONE_MANCANTE            = 'Funzione mancante!';
  A000MSG_ERR_OPERAZIONE_NON_CONSENTITA    = 'Operazione non consentita!';
  A000MSG_ERR_CREAZIONE_JSON               = 'Errore durante la creazione del JSON';
  A000MSG_ERR_DATA_DECORRENZA              = 'Data decorrenza non valida!';
  A000MSG_ERR_DECORRENZA_DUPLICATA         = 'Decorrenza già esistente!';
  A000MSG_ERR_DATA_SCADENZA                = 'Data scadenza non valida!';
  A000MSG_ERR_TAB_NON_COMPATIBILE          = 'file pdf inesistente!'#13#10'La stampa può essere vuota o la tabella di salvataggio non è compatibile.';
  A000MSG_ERR_RILEVATORE_DIZIONARIO        = 'Operazione non consentita su timbratura con rilevatore non abilitato';
  A000MSG_ERR_CAUSALE_DIZIONARIO           = 'Operazione non consentita: causale non abilitata';
  A000MSG_ERR_CAUSALE_NO_INSERIMENTO_TIMB  = 'Operazione non consentita: causale non disponibile per la timbratura';
  A000MSG_ERR_GRID_PENDING                 = 'Esistono Modifiche non confermate sulle griglie. Confermare o annullare i dati su queste prima di proseguire';
  A000MSG_ERR_NO_FILE                      = 'File non indicato!';
  A000MSG_ERR_SPEC_NOME_FILE               = 'Specificare il nome del file di esportazione!';
  A000MSG_ERR_FILE_IN_USO                  = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_ERR_CREAZIONE_FILE               = 'Impossibile procedere alla creazione del file. Verificare che il percorso indicato sia corretto';
  A000MSG_ERR_MESE_DA_A                    = '''Mese a'' deve essere successivo o uguale a ''Mese da''';
  A000MSG_ERR_MESE_STESSO_ANNO             = 'Le date indicate nei campi ''Mese da'' e ''Mese a'' devono essere riferite allo stesso anno.';
  A000MSG_ERR_FMT_CREA_DIR                 = 'Errore in fase di esportazione: impossibile creare directory "%s"';
  A000MSG_ERR_SPEC_NOME_FILE_IMP           = 'Specificare il nome del file di importazione!';
  A000MSG_ERR_FILE_INESISTENTE_IMP         = 'Impossibile procedere con l''importazione: il file indicato non esiste!';

  A000MSG_ERR_FMT_ERRORE                   = 'Attenzione! Si è verificato un errore:'#13#10'%s';
  A000MSG_ERR_FMT_ELAB_ANOM                = 'Elaborazione terminata con anomalie: %s';
  A000MSG_ERR_FMT_DUPLICAZIONE             = 'Duplicazione fallita: %s';
  A000MSG_ERR_FMT_ERRORE_GRAVE_COPIA       = 'Errore grave durante la duplicazione del record:'#13#10'%s'#13#10'Nessuna modifica apportata.';
  A000MSG_ERR_CODICE_VUOTO                 = 'Il nuovo codice non può essere vuoto';
  A000MSG_ERR_CODICE_ESISTE_GIA            = 'Codice già esistente!';
  A000MSG_ERR_FMT_TROPPI_ELEM_SEL          = 'E'' possibile selezionare solo %s voce/i!';
  A000MSG_ERR_FMT_POCHI_ELEM_SEL           = 'E'' necessario selezionare almeno %s voce/i!';
  A000MSG_ERR_FMT_CARATTERI_SPECIALI       = '%s contiene caratteri non permessi: correggere!';
  A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO       = 'Il dato "%s" è obbligatorio!';
  A000MSG_ERR_FMT_DATI_OBBLIGATORI         = 'I seguenti dati devono essere indicati: %s';
  A000MSG_ERR_FMT_MAGGIORE_ZERO            = 'La dimensione di "%s" deve essere maggiore di zero!';
  A000MSG_ERR_FMT_DATA_NON_VALIDA          = 'La data %s non è valida!';
  A000MSG_ERR_FMT_VALORE_NON_CORRETTO      = 'Il valore di "%s" non è corretto!';
  A000MSG_ERR_FMT_PERIODO_NON_CORRETTO     = 'Il periodo "%s" non è corretto!';
  A000MSG_ERR_FMT_LUNG_MAX                 = '"%s" può essere lungo al massimo %d caratteri!';
  A000MSG_ERR_FMT_MODIFICHE_FALLITE        = 'Modifiche fallite: %s';
  A000MSG_ERR_FMT_NON_ESISTENTE            = '%s non esistente!';
  A000MSG_ERR_FMT_GIA_ESISTENTE            = '%s già esistente!';
  A000MSG_ERR_FMT_ELEM_LISTA               = '%s non valida! Selezionare un elemento dalla lista';
  A000MSG_ERR_FMT_PWD_LUNGHEZZA            = 'La password deve essere di almeno %d caratteri!';
  A000MSG_ERR_FMT_PWD_MAIUSCOLE            = 'La password deve contenere almeno %d caratteri maiuscoli!';
  A000MSG_ERR_FMT_PWD_CIFRE                = 'La password deve contenere almeno %d cifre!';
  A000MSG_ERR_FMT_PWD_CARATTERI_SPECIALI   = 'La password deve contenere almeno %d caratteri speciali!';
  A000MSG_ERR_FMT_REG_FALLITA              = 'Registrazione fallita!'#13#10'%s';
  A000MSG_ERR_FMT_CAUS_ASS_INESISTENTE     = 'Causale di assenza inesistente: %s';
  A000MSG_ERR_FMT_VALORE_TROPPO_GRANDE     = 'Valore di ''%s'' troppo grande';
  A000MSG_ERR_EXT_FILE_EXPO_TXT            = 'L''estensione del file di esportazione deve essere: .txt';
  A000MSG_ERR_EXT_FILE_EXPO_TXT_T24        = 'L''estensione del file di esportazione deve essere: .txt o %s';
  A000MSG_ERR_EXT_FILE_EXPO_XLS            = 'L''estensione del file di esportazione deve essere: .xls o .xlsx';
  A000MSG_ERR_EXT_FILE_EXPO_XLSX           = 'L''estensione del file di esportazione deve essere: .xlsx';
  A000MSG_ERR_SPEC_NOME_FILE_DOWNLOAD      = 'Indicare un nome di file valido senza il percorso e senza caratteri speciali';

  A000MSG_MSG_FMT_TIMEOUT_RIDOTTO          = ': completare l''operazione entro %d minuti per non perdere le modifiche';
  A000MSG_ERR_DATABASE_RECORD_LOCKED       = 'Record is locked by another user';

  //caption azioni/messagedlg
  A000MSG_MSG_CANCELLA                     = 'Cancella';
  A000MSG_MSG_MODIFICA                     = 'Modifica';
  A000MSG_MSG_ANNULLA                      = 'Annulla';
  A000MSG_MSG_APPLICA                      = 'Applica';
  A000MSG_MSG_INSERISCI                    = 'Inserisci';
  A000MSG_MSG_SALVAFILE                    = 'Salva file';
  A000MSG_MSG_SCHEDAANAGRAFICA             = 'Scheda anagrafica';
  A000MSG_MSG_INVIA                        = 'Invia messaggio';
  A000MSG_MSG_DEFINISCI                    = 'Definisci';
  A000MSG_MSG_REVOCA                       = 'Revoca';
  A000MSG_MSG_CANCELLAPERIODO              = 'Cancella periodo';
  A000MSG_MSG_AGGIORNA                     = 'Aggiorna';
  A000MSG_MSG_DUPLICA                      = 'Duplica';
  A000MSG_MSG_DETTAGLIO                    = 'Dettaglio';
  A000MSG_MSG_AVVISO                       = 'Avviso';
  A000MSG_MSG_ERRORE                       = 'Errore';
  A000MSG_MSG_INFORMAZIONE                 = 'Informazione';
  A000MSG_MSG_CONFERMA                     = 'Conferma';
  A000MSG_MSG_OK                           = 'OK';
  A000MSG_MSG_TERMINA                      = 'Termina';
  A000MSG_MSG_RIPROVA                      = 'Riprova';
  A000MSG_MSG_IGNORA                       = 'Ignora';
  A000MSG_MSG_SI                           = 'Si';
  A000MSG_MSG_NO                           = 'No';
  A000MSG_MSG_TUTTI                        = 'Tutti';
  A000MSG_MSG_SITUTTI                      = 'Si a tutti';
  A000MSG_MSG_NOTUTTI                      = 'No a tutti';
  A000MSG_MSG_DATA                         = 'Data';
  A000MSG_MSG_BLOCCA                       = 'Blocca';
  A000MSG_MSG_SBLOCCA                      = 'Sblocca';
  A000MSG_MSG_IMPORTA                      = 'Importa';
  A000MSG_MSG_PERCENTUALE_ACCONTO          = 'Percentuale di acconto';

  //Messaggi informativi generici
  A000MSG_MSG_ACCESSO_IN_CORSO             = 'Accesso all''applicativo in corso';
  A000MSG_MSG_FMT_DALAL                    = 'dal %s al %s';
  A000MSG_MSG_ELABORAZIONE                 = 'Elaborazione';
  A000MSG_MSG_ACQUISIZIONE_TERMINATA       = 'Acquisizione terminata';
  A000MSG_MSG_CANCELLAZIONE_AVVENUTA       = 'Cancellazione avvenuta correttamente';
  A000MSG_MSG_SALVATAGGIO_AVVENUTO         = 'Salvataggio avvenuto correttamente';
  A000MSG_MSG_OPERAZIONE_COMPLETATA        = 'Operazione completata.';
  A000MSG_MSG_SALVATAGGIO_IN_CORSO         = 'Salvataggio in corso...';
  A000MSG_MSG_ELABORAZIONE_IN_CORSO        = 'Elaborazione in corso...';
  A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO    = 'Creazione del PDF per la stampa in corso...';
  A000MSG_MSG_ELABORAZIONE_XLS_IN_CORSO    = 'Creazione del file XLS in corso...';
  A000MSG_MSG_ELABORAZIONE_XLSX_IN_CORSO   = 'Creazione del file XLSX in corso...';
  A000MSG_MSG_ELABORAZIONE_TXT_IN_CORSO    = 'Creazione del file TXT in corso...';
  A000MSG_MSG_ELABORAZIONE_INTERROTTA      = 'Elaborazione interrotta su richiesta dell''operatore.';
  A000MSG_MSG_OPERAZIONE_INTERROTTA        = 'Operazione interrotta dall''operatore.';
  A000MSG_MSG_CONTROLLO_TERMINATO          = 'Controllo terminato';
  A000MSG_MSG_ELABORAZIONE_TERMINATA       = 'Elaborazione terminata';
  A000MSG_MSG_ELABORAZIONE_ANOMALIE        = 'Elaborazione terminata con anomalie.';
  A000MSG_MSG_ELABORAZIONE_SEGNALAZIONI    = 'Elaborazione terminata con segnalazioni.';
  A000MSG_MSG_ELABORAZIONE_ANOM_SEGNAL     = 'Elaborazione terminata con anomalie e segnalazioni.';
  A000MSG_MSG_ELABORAZIONE_STEP_FINALE     = 'Finalizzazione elaborazione';
  A000MSG_MSG_PDF_IN_CORSO                 = 'Creazione PDF in corso....ATTENDERE';
  A000MSG_MSG_MODIFICA_COMPLETATA          = 'Modifica effettuata con successo';
  A000MSG_MSG_NESSUN_DIP                   = 'Nessun dipendente';
  A000MSG_MSG_TUTTI_I_DIP                  = 'Tutti i dipendenti';
  A000MSG_MSG_OPERAZIONE_ANNULLATA         = 'Operazione annullata';
  A000MSG_MSG_CONTROLLI_IN_CORSO           = 'Controlli in corso...';
  A000MSG_MSG_REGISTRAZIONE_IN_CORSO       = 'Registrazione in corso...';
  A000MSG_MSG_AGGIORNAMENTO_IN_CORSO       = 'Aggiornamento in corso...';
  A000MSG_MSG_ELAB_ASYNC_IN_CORSO          = 'Attendere, il server sta elaborando la richiesta.<br>Non aggiornare questa pagina. Non chiudere la finestra del browser.';
  A000MSG_MSG_SENZA_ANOMALIE               = 'Non sono state riscontrate anomalie.';
  A000MSG_MSG_IMPORTAZ_SENZA_ANOMALIE      = 'Importazione terminata senza anomalie.';
  A000MSG_ERR_ELAB_ASYNC_REFRESH           = 'L''elaborazione &egrave; stata interrotta a causa del ricaricamento della pagina.<br>Fare click su Chiudi per annullare l''operazione.';
  A000MSG_MSG_TASTO_DESTRO_MOUSE           = 'Occorre agire con il tasto destro del mouse';

  A000MSG_MSG_PERIODO_RICHIESTE            = 'Periodo richieste';
  A000MSG_MSG_OGGI                         = 'oggi';
  A000MSG_MSG_IERI                         = 'ieri';
  A000MSG_MSG_DOMANI                       = 'domani';
  A000MSG_MSG_MESE                         = 'mese';
  A000MSG_MSG_ANNO                         = 'anno';
  A000MSG_MSG_DAL                          = 'dal';
  A000MSG_MSG_FINOAL                       = 'fino al';
  A000MSG_MSG_COMPLETO                     = 'completo';
  A000MSG_MSG_MATRICOLA                    = 'matricola';
  A000MSG_MSG_NOMINATIVO                   = 'nominativo';
  A000MSG_MSG_DATA_DECORRENZA              = 'Data di decorrenza';
  A000MSG_MSG_CODICE                       = 'Codice';
  A000MSG_MSG_DESCRIZIONE                  = 'Descrizione';
  A000MSG_MSG_CAUSALE                      = 'Causale';
  A000MSG_MSG_UM                           = 'U.M.';
  A000MSG_MSG_COMPETENZE                   = 'Competenze';
  A000MSG_MSG_RESIDUO                      = 'Residuo';
  A000MSG_MSG_FRUITO                       = 'Fruito';
  A000MSG_MSG_ORE                          = 'Ore';
  A000MSG_MSG_GIORNI                       = 'Giorni';
  A000MSG_MSG_PERIODO_STAMPA               = 'nel periodo di stampa';
  A000MSG_MSG_AL                           = 'al';
  A000MSG_MSG_PERIODO                      = 'periodo';
  A000MSG_MSG_TIPOLOGIA                    = 'tipologia';
  A000MSG_MSG_DATA_INIZIO                  = 'data inizio';
  A000MSG_MSG_DATA_FINE                    = 'data fine';
  A000MSG_MSG_ORA_INIZIO                   = 'ora inizio';
  A000MSG_MSG_ORA_FINE                     = 'ora fine';
  A000MSG_MSG_COD_TARIFFA                  = 'codice tariffa';
  A000MSG_MSG_COD_RIDUZIONE                = 'codice riduzione';
  A000MSG_MSG_NOME                         = 'Nome';
  A000MSG_MSG_MESE_DA                      = 'Mese Da';
  A000MSG_MSG_MESE_A                       = 'Mese A';
  A000MSG_MSG_DATA_CHIUSURA                = 'Data chiusura';
  A000MSG_MSG_ANNO_COMPETENZA              = 'Anno di competenza';
  A000MSG_MSG_MESE_ELABORAZIONE            = 'Mese elaborazione';

  A000MSG_MSG_ELAB_TERMINATA_OK            = 'Elaborazione terminata correttamente.';
  A000MSG_MSG_FMT_ELAB_TERMINATA           = 'Elaborazione terminata: %s';
  A000MSG_MSG_LIMITE_HISTORY               = 'Vi sono troppe schede attive.'#13#10'Chiudere quelle inutilizzate per poter aprire nuove schede.';
  A000MSG_MSG_UPLOAD_FALLITO               = 'upload fallito';
  A000MSG_ERR_FMT_DIM_ALLEGATO             = 'La dimensione dell''allegato non può superare'#13#10'il limite di %d MB!'#13#10'(il file selezionato è di %f MB)';

  //messaggi generici usati in IrisWEB
  A000MSG_ERR_DATE_STESSO_ANNO             = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_ERR_DATA_INIZIO_PERIODO_VUOTA    = 'E'' necessario indicare la data di inizio del periodo!';
  A000MSG_ERR_DATA_INIZIO_PERIODO          = 'Indicare una data valida per l''inizio del periodo!';
  A000MSG_ERR_DATA_FINE_PERIODO_VUOTA      = 'E'' necessario indicare la data di fine del periodo!';
  A000MSG_ERR_DATA_FINE_PERIODO            = 'Indicare una data valida per la fine del periodo!';
  A000MSG_MSG_NUM_ORE_FRUIZIONE            = 'Specificare il numero di ore di fruizione!';
  A000MSG_MSG_CHIUDI_SCHEDA                = 'Chiudi scheda';
  A000MSG_MSG_DURATA_FRUIZIONE             = 'Specificare la durata della fruizione (Da ore - A ore)!';
  A000MSG_MSG_SPECIFIC_FAMILIARE_RIF       = 'E'' necessario specificare il familiare di riferimento per questa causale!';
  A000MSG_ERR_FMT_CAUS_FAMILIARE           = 'Il familiare specificato non è associato alla causale %s.';
  A000MSG_ERR_FMT_CAUS_FAMILIARE2          = 'Il familiare specificato non è associato alla causale %s alla fine del periodo indicato.'#13#10'Vuoi continuare?';
  A000MSG_ERR_CAUS_FAMILIARE               = 'Familiare di riferimento non valido nel periodo!';
  A000MSG_ERR_NO_INS_GG_INTERE             = 'Giustificativo non inseribile a giornate intere!';
  A000MSG_ERR_NO_INS_GG_MEZZE              = 'Giustificativo non inseribile a mezze giornate!';
  A000MSG_ERR_NO_INS_HH_NUMERO             = 'Giustificativo non inseribile in numero ore!';
  A000MSG_ERR_NO_INS_HH_DA_A               = 'Giustificativo non inseribile nella forma da ore - a ore!';
  A000MSG_MSG_ANOMALIE_R600                = '<R600> Anomalie rilevate';
  A000MSG_MSG_CONTINUA_ANOM                = 'Inserire il giustificativo nel giorno corrente?';
  A000MSG_ERR_FMT_FRUIZ_ORA_MAG_VINCOLI    = 'La fruizione oraria supera il debito giornaliero riconosciuto nel giorno %s';
  A000MSG_ERR_DATA_RIEP                    = 'Indicare una data valida per il conteggio del riepilogo!';
  A000MSG_ERR_CAUSALE_RIEP                 = 'Indicare una causale valida per il conteggio del riepilogo!';
  A000MSG_MSG_ANAGRA_NON_DISPONIBILE       = 'Anagrafico non disponibile!';
  A000MSG_MSG_NESSUNA_RICHIESTA            = 'Nessuna richiesta';
  A000MSG_MSG_NESSUN_ELEMENTO_DA_CANCELLARE= 'Nessun elemento da cancellare';
  A000MSG_MSG_ELAB_OK                      = 'Elaborazione terminata correttamente';
  A000MSG_MSG_ELAB_WARNING                 = 'Elaborazione terminata con avvertimenti'#13#10'%s';
  A000MSG_MSG_ELAB_ERRORE                  = 'Elaborazione terminata con errori';
  A000MSG_MSG_FMT_INIZIOCATENA             = 'Non è possibile inserire un giustificativo con la causale %s.'#13#10'Utilizzare la causale %s';
  A000MSG_MSG_RICERCACOMUNI                = 'Ricerca la città nella tabella dei Comuni';
  A000MSG_MSG_DECORRENZA_INIZIO_MESE       = 'Attenzione: la decorrenza è stata spostata all''inizio del mese specificato!';
  A000MSG_MSG_NO_MINORI_ZERO               = 'Non accetta valori minori di zero';

  //Paginazione medpIWDbGrid
  A000MSG_FMT_PAGIN_COUNT                  = '%d - %d di %d';
  A000MSG_FMT_PAGIN_COUNT_PAG              = 'Pag. %d di %d';
  A000MSG_FMT_PAGIN_COUNT_REC              = 'Record %d - %d di %d';
  A000MSG_PAGIN_PRIMA_PAG                  = 'Prima pagina';
  A000MSG_PAGIN_PRIMO_REC                  = 'Primo record';
  A000MSG_PAGIN_PAG_PREC                   = 'Pagina precedente';
  A000MSG_PAGIN_REC_PREC                   = 'Record precedenti';
  A000MSG_PAGIN_PAG_SUCC                   = 'Pagina successiva';
  A000MSG_PAGIN_REC_SUCC                   = 'Record successivi';
  A000MSG_PAGIN_ULTIMA_PAG                 = 'Ultima pagina';
  A000MSG_PAGIN_ULTIMI_REC                 = 'Ultimi record';

  //messaggi di conferma
  A000MSG_DLG_CANCELLAZIONE                = 'Eliminare il record?';
  A000MSG_DLG_CANCELLAZIONE_MASSIVA        = 'Confermi cancellazione?';
  A000MSG_DLG_STORIC_SUCC                  = 'Esistono delle storicizzazioni successive ma le modifiche verranno applicate solo sulla decorrenza corrente. Confermare?';
  A000MSG_DLG_DECOR_SENZA_STORIC           = 'Attenzione! E'' stata modificata la Decorrenza senza storicizzare. Confermare la modifica?';
  A000MSG_DLG_INSERIMENTO                  = 'Confermi l''inserimento del record?';
  A000MSG_DLG_CTRL_ANOMALIE_VIS            = 'Controllo terminato con anomalie. Si desidera visualizzarle?';
  A000MSG_DLG_ELAB_ANOMALIE_VIS            = 'Elaborazione terminata con anomalie. Si desidera visualizzarle?';
  A000MSG_DLG_ELAB_SEGNALAZIONI_VIS        = 'Elaborazione terminata con segnalazioni. Si desidera visualizzarle?';
  A000MSG_DLG_ELAB_ANOM_SEGNAL_VIS         = 'Elaborazione terminata con anomalie e segnalazioni. Si desidera visualizzarle?';
  A000MSG_DLG_ANOMALIE_BLOCC               = 'Sono state riscontrate anomalie bloccanti nel file: %s';
  A000MSG_DLG_ANOMALIE_NO_BLOCC_IMP        = 'Importazione terminata con anomalie non bloccanti su alcuni dipendenti che sono stati scartati.%s';
  A000MSG_DLG_ANOMALIE_NO_BLOCC            = 'Sono state riscontrate anomalie non bloccanti su alcuni dipendenti che verranno scartati.%s';
  A000MSG_DLG_INTEROMPERE_OPERAZIONE       = 'Si desidera interrompere l''operazione?';
  A000MSG_DLG_CONFERMA_ELABORAZIONE        = 'Procedere con l''elaborazione?';
  A000MSG_DLG_SOSTITUIRE                   = 'Il file indicato per l''esportazione è già esistente. Proseguire comunque sostituendolo con i nuovi dati?';
  A000MSG_DLG_FMT_CANCELLA_TESTATA         = 'Attenzione: la cancellazione comporta l''eliminazione della testata e dei dati elaborati ' + #13#10 +
                                             'di %s dipendenti. Confermi l''operazione? ';

  A000MSG_DLG_FMT_ELIMINARE_QUERY          = 'Eliminare la query "%s" ?';

  // messaggi per applicativi web
  A000MSG_MSG_FMT_BROWSER_SUPPORTATO       = 'Il browser attualmente in uso <b>(%s)</b> è pienamente supportato dall''applicativo web';
  A000MSG_ERR_FMT_BROWSER_NON_SUPPORTATO   = 'La versione del browser in uso <b>(%s)</b> è obsoleta e non garantisce le complete funzionalità dell''applicativo.<br>%s supporta i seguenti browser:<br/>%s';

  // import plugin javascript e controllo versione browser
  A000MSG_ERR_PLUGIN_JS_TITOLO             ='Errore inclusione plugin JavaScript';
  A000MSG_ERR_PLUGIN_JS_BROWSER_NO_SUPP    ='Il browser in uso non supporta questo plugin. Utilizzare una versione del browser pi&ugrave; recente oppure un browser diverso.';
  A000MSG_ERR_PLUGIN_JS_NO_TROV            ='Impossibile caricare il plugin JavaScript. Plugin non trovato.';

  //messaggi specifici
  A000MSG_A002_ERR_SCHEDA_LOCK             = 'Dipendente già in uso da altro operatore e/o applicazione.'#13#10 +
                                             'Attendere alcuni istanti prima di riprovare l''operazione';
  A000MSG_A002_ERR_DIP_IN_USO              = 'Dipendente già in uso da altro operatore e/o applicazione: non è possibile allineare i periodi storici.' + #13#10 +
                                             'Chiudere tutte le applicazioni dei vari operatori che interagiscono sul dipendente e riprovare.' ;
  A000MSG_A002_ERR_FMT_DECO_CAMPI_DISABIL  = 'Operazione di %s impossibile!' + #13#10 + 'Nel periodo storico corrente sono stati variati i seguenti campi sui quali non è possibile intervenire: %s';
  A000MSG_A002_ERR_FMT_CAMPI_NON_STORICIZ  = 'Operazione di %s impossibile!' + #13#10 + 'Nel periodo storico corrente sono stati variati i seguenti campi non storicizzabili: %s' + #13#10 + 'Se necessario, attivare Storici prec. e Storici succ.';
  A000MSG_A002_ERR_DEL_UNICA_DECORRENZA    = 'Non è possibile cancellare l''unico periodo storico rimasto per questo dipendente!';
  A000MSG_A002_ERR_DEL_INIZIO_RAPPORTO     = 'Attenzione! Impossibile effettuare la cancellazione.'#13#10'Nel periodo storico successivo l''inizio rapporto è antecedente alla decorrenza!';
  A000MSG_A002_ERR_MATERNITA_VALOR         = 'Inizio Ind.Maternità e Fine Ind.Maternità devono essere entrambe valorizzate o entrambe nulle.';
  A000MSG_A002_ERR_DATE_MATERNITA          = 'Fine Ind.Maternità dev''essere maggiore di Inizio Ind.Maternità.';
  A000MSG_A002_ERR_BADGE_SERVIZIO          = 'Impossibile specificare un''edizione badge BS perchè riservata ai badge di servizio!';

  A000MSG_A002_ERR_FMT_RAPP_INTERSECA      = 'Attenzione!'#13#10'Il periodo di rapporto del %s si interseca con altri periodi.'#13#10'Correggere la situazione.';
  A000MSG_A002_ERR_FMT_PERIODI_INV         = 'Attenzione!'#13#10'Il periodo di rapporto del %s è antecedente ad un altro inserito su di un periodo storico precedente.'#13#10'Correggere la situazione.';
  A000MSG_A002_ERR_FMT_DATE_INCONGR        = 'Attenzione!'#13#10'Nel periodo di servizio %s ci sono incongruenze con data decorrenza e data scadenza dei periodi storici.'#13#10 +
                                             'Il dato viene comunque salvato. Verificare e correggere opportunamente.';
  A000MSG_A002_ERR_FMT_CAMBIO_RAPP         = 'Attenzione!'#13#10'Il tipo rapporto del dipendente è passato da Ruolo a %s';
  A000MSG_A002_ERR_FMT_INT_MAT             = 'Attenzione!'#13#10'Il periodo di maturazione indennità maternità si interseca con i periodi:'#13#10'%s';
  A000MSG_A002_ERR_FMT_INT_MAT_RAPP        = 'Attenzione!'#13#10'Il periodo di maturazione indennità maternità si interseca con i periodi di rapporto:'#13#10'%s';
  A000MSG_A002_ERR_FMT_DEL_STIPENDIALI     = 'Attenzione! Impossibile effettuare la cancellazione.'#13#10 +
                                             'Esistono periodi storici stipendiali intersecanti il periodo dal %s al %s.'#13#10 +
                                             'Per effettuare le modifiche adeguare l''anagrafica stipendiale.';
  A000MSG_A002_ERR_FMT_CERCA_NO_CAMPO      = 'Nessun campo contiene il testo "%s"!';
  A000MSG_A002_ERR_FMT_INIZIO_ANTE         = 'La data di inizio rapporto (%s) non può essere antecedente alla data di decorrenza del primo periodo storico (%s)';

  A000MSG_A002_ERR_FMT_DECOR_FUORI_PER     = 'Attenzione! La decorrenza indicata (%s) è esterna al periodo storico utilizzato.'#13#10 +
                                             'Per effettuare le modifiche posizionarsi sul periodo storico corretto.';
  A000MSG_A002_ERR_FMT_DECOR_PRIMO_PER     = 'Attenzione! La decorrenza modificata (%s) è relativa al primo periodo storico e non può essere successiva al periodo storico stesso.';
  A000MSG_A002_ERR_FMT_DECOR_PRIMO_STIP    = 'Attenzione! La decorrenza modificata (%s) è relativa al primo periodo storico e, esistendo anche un periodo storico stipendiale, non può essere successiva al primo giorno del mese della data di prima assunzione (%s)';
  A000MSG_A002_ERR_FMT_DECOR_PRIMA_ASSUNZ  = 'Attenzione! La decorrenza modificata (%s) è relativa al primo periodo storico e non può essere successiva alla data di prima assunzione (%s)';
  A000MSG_A002_ERR_FMT_STIP_INTERSEC       = 'Attenzione! Esistono periodi storici stipendiali intersecanti il periodo dal %s al %s.'#13#10 +
                                             'Per effettuare le modifiche adeguare l''anagrafica stipendiale.';

  A000MSG_A002_ERR_FMT_BADGE_USATO         = 'Attenzione!'#13#10'Il badge risulta essere assegnato a:'#13#10'%s';

  A000MSG_A002_DLG_DATA_ASSUNZ_POST        = 'La data di assunzione è posteriore a quella di cessazione. Confermare?';
  A000MSG_A002_DLG_MODIFICA_DECOR          = 'Attenzione! E'' stata modificata la Decorrenza senza storicizzare. Confermare la modifica?';
  A000MSG_A002_DLG_FMT_CF_CAMBIATO         = 'Il codice fiscale è cambiato in %s: aggiornarlo automaticamente?';
  A000MSG_A002_DLG_FMT_CF_USATO            = 'Attenzione! Codice fiscale già in uso da: %s. Confermi l''inserimento?';
  A000MSG_A002_DLG_FMT_DEL_AZIENDA         = 'Attenzione! La cancellazione del periodo storico comporterà la perdita della storicizzazione dell''azienda!' + #13#10 +
                                             'Di conseguenza, nel periodo storico attuale, il dipendente sarà associato all''azienda %s invece di %s.' + #13#10 +
                                             'In particolare per le aziende della Regione Lombardia ciò può comportare gravi incongruenze nelle elaborazioni successive.' + #13#10 +
                                             'Anziché proseguire con la cancellazione, modificare manualmente i dati anagrafici erroneamente storicizzati, impostando sul periodo storico corrente i valori presenti sul periodo storico precedente.' + #13#10 +
                                             'Si desidera ignorare la segnalazione e confermare la cancellazione?';

  A000MSG_A002_DLG_CDC_MANUALE             = 'Attenzione! Si vuole intervenire manualmente sui centri di costo percentualizzati che intersecano il periodo modificato?' + #13#10 +
                                             '<Si> Intervento manuale   <No> Nessun intervento';
  A000MSG_A002_DLG_CDC_AUTOMATICO          = 'Attenzione! Si vuole intervenire automaticamente sui centri di costo percentualizzati che intersecano il periodo modificato?' + #13#10 +
                                             '<Si> Intervento automatico   <No> Intervento manuale   <Annulla> Nessun intervento';

  A000MSG_A002_DLG_FMT_FIELD_SIZE          = 'La selezione effettuata supera la dimensione massima di %d caratteri.'#13#10'Impossibile registrare la selezione!';

  A000MSG_A004_DLG_NUOVO_PERIODO           = 'Trattandosi di nuovo periodo, si desidera comunque coprire i giorni non lavorativi precedenti?';
  A000MSG_A004_DLG_FMT_CONFERMA_DAL_AL     = 'Eseguire %s dal %s al %s?';
  A000MSG_A004_DLG_FMT_CONFERMA_DAL_NUMGG  = 'Eseguire %s dal %s per %d giorni?';
  A000MSG_A004_MSG_RICH_COMPENSATA_REVOCA  = 'La richiesta di giustificativo non è stata considerata'#13#10'poiché compensata da una corrispondente richiesta di revoca.';
  A000MSG_A004_MSG_RICH_COMPENSATA_GIUSTIF = 'La richiesta di revoca non è stata considerata'#13#10'poiché compensata da una corrispondente richiesta di giustificativo.';
  A000MSG_A004_DLG_CERT_PUBBLICA           = 'Attenzione:'#13#10'L''assenza può essere giustificata solo tramite certificazione rilasciata da struttura sanitaria pubblica.'#13#10'Confermare l''inserimento?';
  A000MSG_A004_MSG_NESSUN_GIUST_INSERITO   = 'Nessun giustificativo inserito!';
  A000MSG_A004_DLG_FMT_RIALLINEA           = 'Sono presenti %d giustificativi successivi all''operazione effettuata.'#13#10'Eseguire il riallineamento automatico delle causali concatenate?';
  A000MSG_A004_MSG_NO_CONIUGE              = 'Non esiste il coniuge di riferimento per cui inserire i giustificativi!';
  A000MSG_A004_MSG_NO_CAUSALE              = 'Selezionare la causale del giustificativo';
  A000MSG_A004_MSG_DAORE_VUOTO             = 'E'' necessario indicare il dato "Da ore / Num. ore"!';
  A000MSG_A004_MSG_DAORE_ERRATO            = 'Il dato "Da ore / Num. ore" è errato!';
  A000MSG_A004_MSG_AORE_VUOTO              = 'E'' necessario indicare il dato "A ore"!';
  A000MSG_A004_MSG_AORE_ERRATO             = 'Il dato "A ore" è errato!';
  A000MSG_A004_MSG_DAORE_AORE_ERRATO       = 'Il periodo "Da ore / A ore" è errato!';
  A000MSG_A004_MSG_RECAPITO_NON_MODIF      = 'La visita è già stata comunicata, il recapito non può essere più modificato.';
  A000MSG_A004_DLG_NOTE_NO_DETT_INDIRIZZO  = 'Avvertenza: è stato compilato il campo Note e non il campo Dettagli indirizzo!'#13#10'Si ricorda che il dato che viene trasmesso all''INPS per le visite fiscali è Dettagli indirizzo mentre le note sono ignorate.'#13#10'Confermare l''inserimento?';

  A000MSG_A004_MSG_RICERCA_COMUNE          = 'Effettuare la ricerca del comune indicato tramite l''apposito pulsante';
  A000MSG_A004_DLG_MED_LEG_AUTOMATICA      = 'La medicina legale non è stata indicata.'#13#10'Si desidera impostarla automaticamente?';
  A000MSG_A004_DLG_FMT_COMUNE_DIFF_MED_LEG = 'Il comune di %s è associato ad una medicina'#13#10'legale differente da quella selezionata.'#13#10'Vuoi continuare?';
  A000MSG_A004_DLG_FMT_SOVRASCRIVI_MED_LEG = 'Sovrascrivere la medicina legale attualmente indicata'#13#10'con quella associata al comune di %s?';
  A000MSG_A004_MSG_PRESENZA_ANOMALIE       = 'Attenzione!'#13#10'Sono state rilevate le seguenti anomalie ((*) se bloccante):';
  A000MSG_A004_MSG_GG_STOP_INS             = 'Inserimento impossibile nel giorno corrente.';
  A000MSG_A004_ERR_GGCONSECUTIVI           = 'Per questa causale non è possibile eseguire l''operazione per più giorni consecutivi';

  A000MSG_A005_ERR_NO_DATI                 = 'Non ci sono dati liberi che l''operatore è autorizzato a gestire';

  A000MSG_A006_ERR_ENTRATA_USCITA          = 'Entrata ed Uscita devono essere in ordine cronologico!';
  A000MSG_A006_ERR_INIZIO_RIENTRO          = 'Inizio e Rientro devono essere in ordine cronologico!';
  A000MSG_A006_ERR_TIPO_ORARIO             = 'Il tipo orario non consente di inserire nuove fasce orarie!';
  A000MSG_A006_ERR_NUMERO_TURNO            = 'Il numero del turno deve essere compreso tra 0 e 4!';
  A000MSG_A006_ERR_FMT_MODIF_CODICE        = 'Errore in fase di aggiornamento del dataset %s';
  A000MSG_A006_DLG_CONFERMA_REGISTRAZIONE  = 'Attenzione!'#13#10 +
                                             'Le modifiche apportate alle fasce non possono essere propagate sugli storici precedenti/successivi.'#13#10 +
                                             'Confermare la registrazione?';
  A000MSG_A006_DLG_CONFERMA_MODIFICA_COD   = 'Attenzione! La modifica del codice avverrà per tutte le storicizzazioni presenti.' + #13#10 +
                                             'Confermare?';

  A000MSG_A008_ERR_FMT_CANC_AZIENDA        = 'Cancellazione dell''azienda %s annullata';
  A000MSG_A008_ERR_NOMEPROFILO_NULLO       = 'E'' necessario indicare un Nome profilo valido!';
  A000MSG_A008_ERR_PROFILOFUNZIONI_NULLO   = 'E'' necessario indicare un Filtro Funzioni valido!';
  A000MSG_A008_ERR_PROFILOPERMESSI_NULLO   = 'E'' necessario indicare un Profilo Permessi valido!';
  A000MSG_A008_ERR_NO_CANC_AZIN            = 'L''azienda principale AZIN non può essere eliminata.';
  A000MSG_A008_ERR_NO_CANC_AZIENDA_CORR    = 'Non è possibile cancellare l''azienda su cui si è effettuato l''accesso.';
  A000MSG_A008_DLG_FMT_CANC_AZ_TITOLO      = 'Cancellazione azienda %s';
  A000MSG_A008_DLG_FMT_CANC_AZ_PROMPT      = 'E'' stata richiesta l''eliminazione dell''azienda %s.' + #13#10 +
                                             'Questa operazione non è reversibile.' + #13#10 +
                                             'Specificare il nome azienda per proseguire:';
  A000MSG_A008_DLG_FMT_CANC_AZ             = 'E'' stata richiesta l''eliminazione dell''azienda %s. Questa operazione non è reversibile. Continuare?';
  A000MSG_A008_MSG_FMT_CANC_AZ_AVVISO      = 'L''azienda %s sta per essere definitivamente cancellata. Questa operazione non potrà essere annullata e i dati relativi a questa azienda non potranno essere recuperati.' + #13#10 + 'Si è sicuri di voler procedere?';
  A000MSG_A008_NOME_UTENTE_IN_USO          = 'Il Nome utente o l''Alias indicato è già in uso.' + #13#10 + 'Indicare un nome diverso per proseguire';
  A000MSG_A008_NOME_UTENTE_DUPLICATI       = 'Il suffisso LDAP indicato è in conflitto con gli Utenti e gli Alias già presenti tra i Login dipendenti.' + #13#10 + 'Indicare un suffisso diverso per proseguire';
  A000MSG_A008_NOME_UTENTE_MANCANCANTE     = 'Il Nome utente è obbligatorio!';
  A000MSG_A008_AGGIORNAMENTO_IMPEDITO      = 'Aggiornamento filtro funzioni fallito!';
  A000MSG_A008_VERSIONI_DIVERSE            = 'Versione applicativo %s(%s) e versione database %s(%s) non corrispondenti.';
  A000MSG_A008_VERSIONE_INFERIORE          = 'Versione applicativo %s(%s) inferiore a versione database %s(%s).';
  A000MSG_A008_VERSIONE_DB                 = 'Versione DB non disponibile: confermare l''aggiornamento delle funzioni alla versione %s(%s)?';

  A000MSG_A009_DLG_FMT_DUPLIC              = 'Attenzione: non essendo stato specificato il codice voce speciale, verranno duplicate tutte le voci di pari decorrenza ' + Chr(10) +
                                             'appartenenti al contratto %s con codice voce %s lasciando invariato il codice voce speciale.' + Chr(10) +
                                             'Confermi l''operazione ? ';

  A000MSG_A009_DLG_FMT_ELIM_COMP           = 'Attenzione: dal profilo spariranno le competenze del raggruppamento %s . Continuare?';

  A000MSG_A011_ERR_CODICE_CATASTALE        = 'Il codice catastale deve essere univoco o vuoto!';
  A000MSG_A011_ERR_REGIONE_FISCALE         = 'Con questo codice IRPEF, esiste già una regione non significativa ai soli fini dell''addizionale IRPEF!';
  A000MSG_A011_ERR_CODICE_IRPEF            = 'Il codice IRPEF deve corrispondere al codice catastale di un comune esistente!';
  A000MSG_A011_ERR_CODICE_IRPEF_NOSOPP     = 'Per i comuni non soppressi, il codice IRPEF deve corrispondere al codice catastale del comune stesso!';

  A000MSG_A012_ERR_NO_PERIODO              = 'Non è stato generato alcun periodo con questo calendario';

  A000MSG_A013_DLG_FMT_CONFERMA_AZIONE     = 'Si è sicuri di voler %s il calendario dal %s al %s';
  A000MSG_A013_ERR_DATA_PATRONO            = 'La data del Santo Patrono e'' errata!';
  A000MSG_A013_ERR_CALENDARIO_NON_GENERATO = 'Non e'' stato generato alcun calendario per questo dipendente';

  A000MSG_A015_MSG_FMT_PLUS_GIA_INSERITO   = 'Plus Orario del %s già inserito';

  A000MSG_A016_ERR_IMPOSSIBILE_CUMULARE    = 'Non si può cumulare a partire dalla causale corrente!';
  A000MSG_A016_ERR_TIPO_CUMULO_R           = 'Il tipo di cumulo R richiede l''attivazione di una modalità di recupero!';
  A000MSG_A016_ERR_NUM_GIORNI              = 'Il numero di giorni indicato deve essere maggiore o uguale a zero!';
  A000MSG_A016_ERR_PERIODO_CAUSALE         = 'E'' necessario specificare la causale del periodo di fruizione!';
  A000MSG_A016_ERR_CAUS_SUCCESSIVA         = 'La Causale successiva non può essere uguale alla Causale corrente!';
  A000MSG_A016_ERR_ARROTONDAMENTO          = 'L''arrotondamento deve essere divisore della fruizione minima!';
  A000MSG_A016_ERR_MAX_PER_LAVORATO        = 'I campi "Max per lavorato < 6h" e "Max per lavorato > 6h" devono essere entrambi valorizzati o entrambi vuoti!';
  A000MSG_A016_ERR_SUP6_MINORE_INF6        = 'Il campo "Max per lavorato < 6h" non può contenere un valore maggiore del campo "Max per lavorato > 6h"!';
  A000MSG_A016_ERR_CODICE_GIUST_DUPLICATO  = 'Codice già esistente come causale di giustificazione!';
  A000MSG_A016_ERR_MASSIMALE               = 'Il Massimale deve essere maggiore di 0!';
  A000MSG_A016_ERR_DURATANULLA             = 'Il campo durata non può essere nullo per il tipo cumulo B.';
  A000MSG_A016_ERR_PROPPTVGG_UM            = 'Il tipo di proporzione per part-time verticale non è utilizzabile con unità di misura ad ore';
  A000MSG_A016_ERR_PROPPTVGG_RAGGR         = 'Il tipo di proporzione per part-time verticale non è utilizzabile con raggruppamenti residuabili, o ad anno solare';

  A000MSG_A016_ERR_FMT_CAUS_PARAZIENDALI       = 'Impossibile procedere: la causale %s è utilizzata nei parametri aziendali!';
  A000MSG_A016_ERR_FMT_INFLUCONT_DIMINUISCEORE = 'La causale %s è utilizzata nei parametri aziendali ' + #13#10 + 'e l''influenza sui conteggi deve essere "Diminuisce le ore lavorate"!';

  A000MSG_A016_MSG_REGISTRA_STORICO        = 'Attenzione: ai fini economici la variazione dell''indicatore "Registra nello storico" ha effetto solo sulle operazioni effettuate a partire da questo momento: verificare se occorre allineare le registrazioni pregresse';
  A000MSG_A016_MSG_ASSENZE_DA_VALIDARE     = 'Non è possibile deselezionare il campo Richiedi validazione in quanto esistono ancora delle assenze da validare.' + #13#10 +
                                             'Premendo su OK verranno visualizzate.';
  A000MSG_A016_DLG_RICHIEDI_VALIDAZIONE    = 'Attenzione: ai fini economici, l''attivazione di "Richiedi validazione" comporta il NON passaggio diretto sul cedolino delle assenze inserite, che dovranno quindi essere prima "validate". Verificare con l''ufficio stipendi. Si conferma comunque la modifica?' ;

  A000MSG_A016_MSG_NO_CAUSALI_COMP         = '(nessuna causale)';
  A000MSG_A016_MSG_NO_ELIMINA_STOR         = 'Il periodo selezionato è l''unico esistente. Non è possibile eliminarlo.';
  A000MSG_A016_ERR_T230_APERTO             = 'Errore interno: impossibile accedere alla causale. Il dataset non è chiuso.';
  A000MSG_A016_ERR_STORIA_T230             = 'Errore interno durante elaborazione storia dei dati storicizzati: il dataset per la tabella T230 non pronto per l''operazione.';
  A000MSG_A016_ERR_STORIA_GEN              = 'Errore durante l''elaborazione dello storico dati: %s';
  A000MSG_A016_ERR_COPIA_STORIA_NO_REC     = 'Copia fallita, la causale di origine non ha dati storicizzati!';
  A000MSG_A016_ERR_COPIA_STORIA_GEN        = 'Errore durante la copia dei parametri storicizzati: %s';
  A000MSG_A016_ERR_VALORGIOR_ORE_FISSE     = 'E'' necessario specificare le Ore di valorizzazione giornaliera.';

  A000MSG_A020_ERR_FASCIA_AUTORIZZAZIONE   = 'Specificare la fascia di autorizzazione!';
  A000MSG_A020_ERR_VALORI_TIPO_GIORNO      = 'I valori possibili sono: L(lavorativo), NL(non lavorativo), PF(pre-festivo), F(festivo/domenica), FF(solo festivo) e i singoli giorni da 1 a 7';
  A000MSG_A020_ERR_TIPO_GIORNO             = 'Tipo giorno non previsto!';
  A000MSG_A020_ERR_VALORI_AMMESSI_SN       = 'I valori ammessi sono S o N!';
  A000MSG_A020_ERR_FASCE_VOCI_PAGHE        = 'Le fasce orarie delle Voci Paghe specificate non sono corrette!';
  A000MSG_A020_MSG_NO_ELIMINA_STOR         = 'Il periodo selezionato è l''unico esistente. Non è possibile eliminarlo.';
  A000MSG_A020_ERR_STORIA_T235             = 'Errore interno durante elaborazione storia dei dati storicizzati: il dataset per la tabella T235 non pronto per l''operazione.';
  A000MSG_A020_ERR_T235_INCOERENTE         = 'Errore interno durante elaborazione storia dei dati storicizzati: dati incoerenti (la tabella contiene più di un record per il periodo storico specificato.)';
  A000MSG_A020_ERR_STORIA_GEN              = 'Errore durante l''elaborazione dello storico dati: %s';
  A000MSG_A020_ERR_COPIA_STORIA_GEN        = 'Errore durante la copia dei parametri storicizzati: %s';

  A000MSG_A022_ERR_IND_NOTTURNA_ARROT      = 'Indennità notturna:L''arrotondamento deve essere maggiore della tolleranza!';

  A000MSG_A023_DLG_CANC_TIMB               = 'Confermi la cancellazione della timbratura?';

  A000MSG_A023_MSG_FMT_NCAUS               = 'n. %s per la causale %s' + #13#10;
  A000MSG_A023_DLG_IMPORTA_RICH            = 'Confermi l''importazione di tutte le richieste visualizzate?';

  A000MSG_A023_DLG_FMT_RIALLINEA           = 'Sono presenti giustificativi successivi all''operazione effettuata:' + #13#10 +
                                             '%s ' + #13#10 +
                                             'Eseguire il riallineamento automatico delle causali concatenate?';
  A000MSG_A023_ERR_TIPO_GIUST              = 'Indicare il tipo giustificativo!';
  A000MSG_A023_ERR_NO_CAUS                 = 'Manca il codice di causale!';
  A000MSG_A023_ERR_CAUS_NO_ELENCO          = 'Selezionare una causale tra quelle presenti in elenco!';
  A000MSG_A023_ERR_DAORE                   = 'Il dato "da ore/num.ore" è errato!';
  A000MSG_A023_ERR_AORE                    = 'Il dato "a ore" è errato!';
  A000MSG_A023_ERR_PERIODO                 = 'Il periodo "da ore/a ore" è errato!';
  A000MSG_A023_ERR_GIUST_NO_ORE            = 'Giustificativo non inseribile in num. ore!';
  A000MSG_A023_ERR_GIUST_NO_DA_A           = 'Giustificativo non inseribile da ore a ore!';
  A000MSG_A023_ERR_GIUST_NO_GIORN          = 'Giustificativo non inseribile a giornate intere!';
  A000MSG_A023_ERR_GIUST_NO_MG             = 'Giustificativo non inseribile a mezze giornate!';
  A000MSG_A023_ERR_GIUST_NO_FAMILIARE      = 'Specificare il familiare di riferimento!';
  A000MSG_A023_ERR_COMANDO_ALLTIMB         = 'Impossibile eseguire il comando';
  A000MSG_A023_ERR_NO_TIMB_DA_SCAMBIARE    = 'Nessuna timbratura da scambiare';
  A000MSG_A023_ERR_MOD_VISITA_FISCALE_N_S  = 'Impossibile modificare il giustificativo indicando una causale legata alla gestione delle visite fiscali!';
  A000MSG_A023_ERR_FMT_MOD_VISITA_FISCALE_S= 'Impossibile modificare un giustificativo legato alla gestione'#13#10'delle visite fiscali.'#13#10'Selezionare la voce di menu "%s" e procedere '#13#10'con la cancellazione e un nuovo inserimento';
  A000MSG_A023_ERR_NO_MOD_GIUST            = 'Per questa causale non è possibile effettuare una modifica diretta.'#13#10'Procedere con la cancellazione e un nuovo inserimento';

  A000MSG_A025_DLG_FMT_TURNO_ERRATO        = 'Il turno %s è errato!';
  A000MSG_A025_DLG_FMT_TURNO_NON_PREVISTO  = 'Il turno %s non è previsto in orario! Sono disponibili %s turni.';
  A000MSG_A025_DLG_FMT_CANCELLAZIONE       = 'Eseguire la cancellazione del periodo dal %s al %s ?';
  A000MSG_A025_DLG_FMT_ACQUISIZ_TURNI      = 'Verranno acquisiti i turni pianificati dal %s al %s per i dipendenti selezionati.'+ #13#10 + 'Continuare?';
  A000MSG_A025_DLG_FMT_ESEGUI_INSERIMENTO  = 'Eseguire l''inserimento nel periodo dal %s al %s ?';
  A000MSG_A025_ERR_PRIMO_TURNO             = 'E'' richiesto il 1° turno da pianificare!';
  A000MSG_A025_ERR_CODICE_ORARIO           = 'E'' richiesto il codice dell''orario da pianificare!';
  A000MSG_A025_ERR_COD_ORARIO_INDENNITA    = 'Sono richiesti o il codice Orario o il codice Indennità!';
  A000MSG_A025_ERR_FMT_DATI                = 'Sono richiesti o il codice Orario o il codice Indennità o il codice %s o le note!';
  A000MSG_A025_ERR_DATA                    = 'Indicare la data!';

  A000MSG_A025_ERR_MOTIV_PIANIF_ORARIO     = 'La Motivazione specificata richiede di pianificare l''orario.';
  A000MSG_A025_ERR_MOTIV_PIANIF            = 'La Motivazione specificata richiede che esista una pianificazione Non Operativa nel giorno pianificato.';
  A000MSG_A025_ERR_COD_INDENNITA           = 'Codice Indennità non valido!';
  A000MSG_A025_ERR_TURNO1                  = '1° turno non valido!';
  A000MSG_A025_ERR_TURNO1EU                = '1° turno E/U non valido!';
  A000MSG_A025_ERR_TURNO2                  = '2° turno non valido!';
  A000MSG_A025_ERR_TURNO2EU                = '2° turno E/U non valido!';
  A000MSG_A025_ERR_COD_ORARIO              = 'Codice Orario non valido!';
  A000MSG_A025_ERR_FMT_COD_NON_VALIDO      = 'Codice %s non valido!';

  A000MSG_A026_DLG_CANCELLA                = 'Attenzione! La cancellazione del dato libero non deve essere interrotta per nessun motivo.' + #13#10 +
                                             'Attendere il termine dell''elaborazione anche se l''applicativo sembra bloccato.' + #13#10 +
                                             'Confermare la cancellazione?';
  A000MSG_A026_DLG_FMT_CANCELLA            = 'Attenzione!'#13#10'Il dato libero è riferito alla funzione %s.' + #13#10 +
                                             'La sua eliminazione comporterà il mancato funzionamento del relativo modulo.' + #13#10 +
                                             'Confermare la cancellazione?';
  A000MSG_A026_DLG_DIMINIZ                 = 'Poichè il campo è stato diminuito, i dati verranno persi: Confermare?';
  A000MSG_A026_DLG_DIMINIZ_DESC            = 'Poichè la dimensione del campo descrizione è stata diminuita, il contenuto di quest''ultima verrà perso: Confermare?';

  A000MSG_A027_MSG_PARAMETRIZZAZIONE           = 'Parametrizzazione';
  A000MSG_A027_ERR_FMT_STAMPA                  = 'La parametrizzazione di stampa selezionata include campi di intestazione non validi';
  A000MSG_A027_ERR_DATE_ANNO                   = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_A027_ERR_FMT_NON_PRIMA               = 'Non è possibile elaborare il cartellino prima del %s!';
  A000MSG_A027_ERR_FMT_CART_ANTEC              = 'Non è possibile elaborare il cartellino antecedente di %d mesi!';
  A000MSG_A027_ERR_FMT_CART_SUCC               = 'Non è possibile elaborare il cartellino successivo a %d mesi!';
  A000MSG_A027_ERR_NO_CART                     = 'Nessun cartellino disponibile nel periodo specificato!';
  A000MSG_A027_ERR_NO_FILE_PDF                 = 'Generazione cartellino fallita!';
  A000MSG_A027_ERR_FMT_STAMPA_CARTELLINO_B028  = 'Errore durante la stampa del cartellino (B028):'#13#10'%s';
  A000MSG_A027_ERR_CONFERMA_PERIODO_TITOLO     = 'Conferma del periodo';
  A000MSG_A027_ERR_CONFERMA_PERIODO            = 'Attenzione! Il periodo di elaborazione scelto supera la fine del mese corrente, ' + #13#10 +
                                                 'sei sicuro di proseguire? Reimmetti la data di fine periodo per conferma';
  A000MSG_A027_ERR_DATA_ERRATA                 = 'La data selezionata non corrisponde a quella indicata precedentemente';

  A000MSG_A029_ERR_INDENNITA               = 'Indennità di presenza non valida!';
  A000MSG_A029_ERR_CAUS_PRES               = 'Causale di presenza non valida!';
  A000MSG_A029_ERR_CAUS_ASSESTAMENTO       = 'Specificare la causale di assestamento!';
  A000MSG_A029_ERR_DELETE_LIQUID           = 'Cancellazione impossibile: sono presenti delle liquidazioni!';
  A000MSG_A029_ERR_DELETE_ASSEST           = 'Cancellazione impossibile: sono presenti degli assestamenti!';
  A000MSG_A029_ERR_DELETE_INDPRESMAN       = 'Cancellazione impossibile: sono presenti delle indennità di presenza con gestione Manuale!';
  A000MSG_A029_ERR_DELETE_RIEPPRESMAN      = 'Cancellazione impossibile: sono presenti dei riepiloghi di presenza con gestione Manuale!';
  A000MSG_A029_ERR_SCHEDA_PRESENTE         = 'Scheda riepilogativa già esistente!';
  A000MSG_A029_ERR_LIQ_BLOC                = 'Con la liquidazione bloccata per la Banca Ore non è possibile liquidare più della quantità liquidata precedentemente!';
  A000MSG_A029_ERR_STRAORD_EST             = 'Lo straordinario esterno non può superare quello fatto nel mese!';
  A000MSG_A029_ERR_DISP_LIQ                = 'Impossibile liquidare oltre la disponibilità';
  A000MSG_A029_ERR_CONTR_FASCE             = 'Contratto o fasce di maggiorazione non validi!';
  A000MSG_A029_ERR_LIQ_COMPL               = 'La liquidazione complessiva supera la disponibilità!';
  A000MSG_A029_ERR_ORE_LIQ                 = 'Ore da liquidare non corrette!';
  A000MSG_A029_ERR_SUPERO_LIQ              = 'La liquidazione richiesta supera quella disponibile!';
  A000MSG_A029_ERR_FMT_LIQ_FASCIA          = 'La liquidazione in fascia %s supera la disponibilità!';
  A000MSG_A029_ERR_FMT_DISP_ANN            = 'E'' stata superata la disponibilità individuale annuale!' + #13#10 +
                                             '%s >  %s ' + #13#10 +
                                             'Sono ancora disponibili %s ore';
  A000MSG_A029_ERR_FMT_DISP_MENS           = 'E'' stata superata la disponibilità individuale mensile!' + #13#10 +
                                             '%s >  %s ' + #13#10 +
                                             'Sono ancora disponibili %s ore';
  A000MSG_A029_DLG_GEST_BUDGET             = 'Si intende usare la gestione budgetaria per questa liquidazione?';
  A000MSG_A029_DLG_FMT_GEST_BUDGET         = 'Si stanno liquidando %s ore.' + #13#10 +
                                             'Si intende usare la gestione budgetaria per questa liquidazione?';
  A000MSG_A029_DLG_FMT_STR_INSUF           = 'Attenzione!' + #13#10 +
                                             'Straordinario insufficiente: %s';
  A000MSG_A029_ERR_RECORD_AUTOMATICO       = 'Non è consentito intervenire su un record di tipo automatico!';
  A000MSG_A029_ERR_SCHEDA_MODIF_ESTERNO    = 'La scheda è stata aggiornata nel frattempo da elaborazioni esterne!'#13#10'Si prega di effettuare nuovamente l''operazione.';
  A000MSG_A029_ERR_SCHEDA_CANC_ESTERNO     = 'La scheda è stata eliminata nel frattempo da un altro operatore!';
  A000MSG_A029_ERR_TIPO_RECORD             = 'Il tipo record deve essere A=Automatico o M=Manuale';

  A000MSG_A032_DLG_RECUPERARE_FILE         = 'Recuperare i files selezionati?';
  A000MSG_A032_MSG_SCARICO_TERMINATO       = 'Scarico terminato';

  A000MSG_A033_ERR_NO_ANOM_SEL             = 'Nessuna anomalia selezionata!';

  A000MSG_A034_MSG_FORMULA_CORRETTA        = 'Formula corretta!';
  A000MSG_A034_ERR_NO_CODICE_PAGHE         = 'Specificare il codice paghe!';
  A000MSG_A034_ERR_FORMULA_VALORI          = 'La formula inserita estrae più valori! Verificare.';
  A000MSG_A034_ERR_FORMULA_VARIABILE       = 'è stata utilizzata una variabile non valida!';
  A000MSG_A034_ERR_DATA_INIZIO_VALIDITA    = 'Non è possibile indicare una data inizio validità antecedente la data di decorrenza!';
  A000MSG_A034_ERR_DATA_FINE_VALIDITA      = 'Non è possibile indicare una data fine validità antecedente la data di decorrenza!';
  A000MSG_A034_ERR_FMT_FORMULA_ERRORI      = 'La formula inserita contiene errori:'#13#10'%s';
  A000MSG_A034_DLG_ELIMINA_INTERFACCIA     = 'Eliminare l''interfaccia corrente?';

  A000MSG_A035_MSG_ALLINEA                 = 'Attenzione!'#13#10'Le modifiche effettuate, se non allineate con la struttura della tabella,' + #13#10 +
                                             'potrebbero causare errori in fase di elaborazione dati!';
  A000MSG_A035_ERR_FORMULA                 = 'Non è possibile inserire più di una virgola all''interno della formula';
  A000MSG_A035_DLG_PAR_ERR                 = 'Parametri scorretti, salvare ugualmente ?';
  A000MSG_A035_ERR_DARE_AVERE_RIGA         = 'Attenzione! Non è consentito selezionare insieme N. RIGHE DETT. D/A SU STESSA RIGA e N. RIGHE DETT. D/A SU DUE RIGHE.';
  A000MSG_A035_ERR_DATI_DARE_AVERE         = 'Attenzione! I dati IMPORTO e DARE_AVERE non possono essere utilizzati contemporaneamente a SEGNO IMP. DARE, IMPORTO_DARE, SEGNO IMP.AVERE e IMPORTO_AVERE.';
  A000MSG_A035_ERR_IMPORTO_DARE_AVERE      = 'Attenzione! E'' necessario selezionare anche DARE_AVERE se si sceglie IMPORTO.' + #13 +
                                             'In alternativa a DARE_AVERE/IMPORTO è possibile usare IMPORTO_DARE/IMPORTO_AVERE.';

  A000MSG_A037_ERR_BILANCIO                = 'Sono presenti liquidazioni superiori alla disponibilità di bilancio.' + #13#10 +
                                             'Non è possibile elaborare lo scarico alle paghe.';
  A000MSG_A037_ERR_NO_VOCI                 = 'Non è presente nessuna voce paghe!' + #13#10 +
                                             'Riaccedere allo scarico paghe e verificare il filtro voci paghe.';
  A000MSG_A037_ERR_FMT_DATA_CASSA_ANTE     = 'La Data di Cassa non può essere precedente a %s, mese dell''ultimo scarico';
  A000MSG_A037_ERR_FMT_DATA_ANTE_SCARICO   = 'La Data di Cassa (%s) non può essere precedente al mese di scarico (%s).';

  A000MSG_A037_ERR_NO_PARAMETRIZZAZIONE    = 'E''necessario selezionare una parametrizzazione' + #13#10+
                                             'per effettuare lo scarico paghe';
  A000MSG_A037_DLG_SCARICO_GIA_PRESENTE    = 'E'' già stato effetuato uno scarico con la Data di Cassa indicata!' + #13#10 +
                                             'Eseguire comunque lo scarico paghe?';
  A000MSG_A037_DLG_ESEGUIRE_SCARICO        = 'Eseguire lo scarico?';
  A000MSG_A037_DLG_SOVRASCRIVERE_FILTRO    = 'Il filtro indicato è già esistente. Si vuole sovrascrivere il vecchio filtro?';
  A000MSG_A037_DLG_FMT_SCARICO_FILTRO      = 'Lo scarico avverrà con il filtro voci: %s';
  A000MSG_A037_DLG_FMT_CREA_DIR            = 'Directory ''%s'' inesistente. Crearla?';
  A000MSG_A037_DLG_FMT_PATH_INESISTENTE    = 'Percorso file ''%s'' inesistente. Impossibile proseguire!';
  A000MSG_A037_DLG_FMT_RIPRISTINA          = 'ATTENZIONE!!'#13#10#13#10 +
                                             'DATI SALVATI PRECEDENTEMENTE:' + #13#10 +
                                             'Tabella Voci Variabili:' + #13#10 +
                                             'Righe: %d' + #13#10 +
                                             'Ultima data di riferimento: %s' + #13#10 +
                                             'Ultima data di cassa: %s' + #13#10 + #13#10 +
                                             'Eseguire il ripristino?' + #13#10;
  A000MSG_A037_DLG_FMT_ELIMINA_CASSA       = 'ATTENZIONE!!' + #13#10 + #13#10 +
                                             'Ultima data di cassa: %s' + #13#10 +
                                             'Voci scaricate riferite al periodo da %s a %s' + #13#10 +
                                             'Righe: %d' + #13#10 +
                                             'Eliminare questi dati dalla tabella delle Voci Variabili?' + #13#10;

  A000MSG_A037_DLG_FMT_SALVA_FILTRO        = 'ATTENZIONE!!' + #13#10 + #13#10 +
                                             'DATI ATTUALI:' + #13#10 +
                                             'Tabella Voci Variabili:' + #13#10 +
                                             'Righe: %d' + #13#10 +
                                             'Ultima data di riferimento: %s' + #13#10 +
                                             'Ultima data di cassa: %s' + #13#10 + #13#10 +
                                             'Eseguire il salvataggio?' + #13#10;
  A000MSG_A037_DLG_FMT_ELIMINA_FILTRO      = 'Eliminare il filtro %s?';

  A000MSG_A039_FMT_ALLINEAMENTO_RIEPILOGHI = 'Attenzione!' + #13#10 +
                                             'Non sarà possibile allineare automaticamente i riepiloghi di reperibilità %s.' + #13#10 +
                                             'Pertanto è necessario rieseguire i cartellini di reperibilità per tutti i dipendenti interessati dal turno modificato, in tutto il periodo di utilizzo.';
  A000MSG_A039_FMT_ALLINEAMENTO_ESEGUITO   = 'Allineamento eseguito %s.' + #13#10 +
                                             'Ricordarsi di eseguire la decodifica della voce paghe tramite l''apposita funzione in <A038> Voci variabili scaricate.';
  A000MSG_A039_DLG_FMT_AGGIORNAMENTO_TURNI = 'Aggiornare anche i seguenti turni con la nuova voce paghe [%s]?' + #13#10 +
                                             ' %s';
  A000MSG_A039_ERR_DURATA_TURNI            = 'Il valore è superiore alla durata effettiva del turno';
  A000MSG_A039_MSG_ALLINEAMENTO_IN_CORSO   = 'Allineamento turni riepilogati...';

  A000MSG_A040_ERR_DATA_ESTERNA_MESE       = 'La data specificata deve essere compresa nel mese di competenza!';
  A000MSG_A040_ERR_FMT_COD_NON_VALIDO      = '%s non valido!';
  A000MSG_A040_ERR_FMT_RANGE_PRIORITA      = 'La priorità di chiamata del turno %s deve essere compresa fra 1 e 9!';
  A000MSG_A040_ERR_DLG_FMT_NO_RAGGR        = 'Il dipendente non ha raggruppamenti di %s abilitati in data %s!' + #13#10 +
                                             '%s';
  A000MSG_A040_ERR_NO_TURNO_1              = 'E'' necessario specificare il 1° turno!';
  A000MSG_A040_ERR_NO_TURNO_2              = 'Pianificare prima il 2° turno!';
  A000MSG_A040_ERR_ESISTE_PIANIFICAZIONE   = 'Pianificazione già esistente!';
  A000MSG_A040_ERR_TURNO_RIPETUTO          = 'Il dipendente non può fare due volte lo stesso turno!';
  A000MSG_A040_DLG_FMT_ESISTE_ASSENZA      = 'Nel giorno %s è presente una giornata di assenza %s.' + #13#10 +
                                             'Pianificare ugualmente?';
  A000MSG_A040_DLG_FMT_TURNO_PIANIFICATO   = 'Il turno %s è già stato pianificato il %s.' + #13#10 +
                                             'Registrarlo ugualmente?';
  A000MSG_A040_DLG_FMT_TURNO_NON_DISP      = 'Attenzione: in data %s il turno %s non è disponibile nei vincoli di pianificazione! %s';
  A000MSG_A040_DLG_FMT_TURNI_SOVRAPPOSTI   = 'Attenzione!' + #13#10 +
                                             'I turni si sovrappongono %s' + #13#10 +
                                             '%s: %s - %s' + #13#10 +
                                             '%s: %s - %s' + #13#10 +
                                             'Confermare?';
  A000MSG_A040_DLG_FMT_CONFIGURAZIONE_KO   = 'Attenzione!' + #13#10 +
                                             'Esistono pianificazioni %s configurate non correttamente %s.' + #13#10 +
                                             'Confermare?';
  A000MSG_A040_DLG_FMT_LIMITE_SUPERATO     = 'Il numero massimo di pianificazioni mensili indicato per il turno %s è stato superato.' + #13#10 +
                                             'Turni %s pianificati: %s' + #13#10 +
                                             'Limite turni %s: %d' + #13#10 +
                                             '%s';
  A000MSG_A040_DLG_FMT_ACQUISIZ_TURNI      = 'Verranno acquisiti i turni pianificati nel mese di %s %s per i dipendenti selezionati.' + #13#10 + 'Continuare?';
  A000MSG_A040_DLG_FMT_CANCELLA_TURNI      = 'Eliminare i turni esistenti nel mese di %s %s per i dipendenti selezionati?';
  A000MSG_A040_MSG_FMT_TURNI_ESCLUSI       = 'Sono stati esclusi dalla selezione i turni pianificati nel mese: %s.' + #13#10 +
                                             'Effettuare successivamente la stampa di questi turni esclusi.' + #13#10 +
                                             'Nota: per garantire una corretta visualizzazione dei dati, la stampa selezionata prevede un limite di %s turni.';
  A000MSG_A040_ERR_DATA_INIZIO             = 'Indicare una data valida di inizio periodo!';
  A000MSG_A040_ERR_DATA_FINE               = 'Indicare una data valida di fine periodo!';
  A000MSG_A040_ERR_DATE_INVERTITE          = 'Il periodo indicato non è valido!';
  A000MSG_A040_ERR_DATE_STESSO_ANNO        = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_A040_ERR_NO_TURNO                = 'E'' necessario indicare almeno un turno da considerare!';
  A000MSG_A040_ERR_NO_CAMPO                = 'E'' necessario indicare il campo di raggruppamento!';
  A000MSG_A040_DLG_NO_DETTAGLIO_STAMPA     = 'Non è stato selezionato nessun dettaglio di pianificazione o assenza.' + #13#10 + 'Vuoi stampare comunque un prospetto vuoto?';
  A000MSG_A040_ERR_FMT_STAMPA              = 'Attenzione! Si è verificato un errore durante l''elaborazione della stampa richiesta.' + #13#10 + 'Motivo: %s';

  A000MSG_A044_MSG_SCHEDULATO              = 'schedulato';
  A000MSG_A044_MSG_CREATO                  = 'creato';
  A000MSG_A044_MSG_FMT_JOB                 = 'Job %s.';
  A000MSG_A044_ERR_ORA_JOB                 = 'Specificare un orario per la schedulazione giornaliera del job!';
  A000MSG_A044_ERR_JOB_INESISTENTE         = 'Attenzione! Job inesistente!';
  A000MSG_A044_ERR_JOB_NON_CREATO          = 'Attenzione! Job non creato!';
  A000MSG_A044_ERR_DIP_IN_USO              = 'Dipendente già in uso da altro operatore e/o applicazione: non è possibile allineare i periodi storici.' + #13#10 +
                                             'Chiudere tutte le applicazioni dei vari operatori che interagiscono sul dipendente e riprovare.' ;
  A000MSG_A044_DLG_FMT_ESEC_JOB            = 'Job %s. Prossima esecuzione: %s';

  A000MSG_A045_ERR_ORDINE_DATE             = 'La data iniziale non può essere successiva a quella finale.';
  A000MSG_A045_ERR_SELEZ_QUALIFICA         = 'Selezionare almeno una qualifica dalla lista.';
  A000MSG_A045_ERR_CODICI_MANCANTI         = 'Indicare Codice Regione e Codice Azienda!';
  A000MSG_A045_ERR_FILE_ESPORTAZ           = 'Indicare il File di esportazione!';
  A000MSG_A045_ERR_QUALIF_MINISTERIALE_UP20= 'Codice qualifica ministeriale superiore ai 20 caratteri!';
  A000MSG_A045_ERR_QUALIF_MINISTERIALE_UP6 = 'Attenzione: codice qualifica ministeriale superiore ai 6 caratteri!';
  A000MSG_A045_ERR_ASSENZE_NON_CORRISPONDONO='Attenzione: nessuna assenza corrisponde ai filtri di ricerca indicati!';
  A000MSG_A045_DLG_STAMPA_ULTIMA_OPERAZ    = 'Attenzione: la stampa verrà eseguita sull''ultima elaborazione effettuata. Continuare?';
  A000MSG_A045_DLG_ANTEPRIMA_ULTIMA_OPERAZ = 'Attenzione: l''anteprima verrà eseguita sull''ultima elaborazione effettuata. Continuare?';
  A000MSG_A045_DLG_ESPORTAZ_ULTIMA_OPERAZ  = 'Attenzione: l''esportazione verrà eseguita sull''ultima elaborazione effettuata. Continuare?';
  A000MSG_A045_DLG_FMT_SOSTITUZIONE_FILE   = '%s : File già esistente. Sostituire il file?';

  A000MSG_A047_ERR_CAUSALE                 = 'Causale già esistente!';

  A000MSG_A050_ERR_FMT_OROLOGIO_DUPL       = 'Attenzione: esiste già l''orologio %s che ha lo stesso rilevatore!';
  A000MSG_A050_ERR_FMT_SCARICO             = 'Attenzione: specificare lo scarico di riferimento perchè esiste già l''orologio %s che ha lo stesso rilevatore con lo scarico %s !';

  A000MSG_A052_ERR_FMT_CAMPO_PRESENTE      = 'Campo %s già presente!';
  A000MSG_A052_ERR_PENDING                 = 'Attenzione: modifiche pendenti alla struttura della sezione.' + #13#10 +
                                             'Confermare o annullare i dati.';

  A000MSG_A056_ERR_NO_DIP                  = 'Dipendente non più disponibile!';
  A000MSG_A056_ERR_TURNAZIONE              = 'Turnazione non valida!';
  A000MSG_A056_ERR_TURNAZ_INESISTENTE      = 'Turnazione inesistente o non valida!';
  A000MSG_A056_DLG_CANCELLAZIONE           = 'Confermi la cancellazione per tutti i dipendenti selezionati?';
  A000MSG_A056_DLG_INSERIMENTO             = 'Confermi l''assegnazione a tutti i dipendenti selezionati?';
  A000MSG_A056_DLG_ASSEGNAZ_AUTOMATICA     = 'Per i dipendenti selezionati, verranno cancellate le assegnazioni precedenti.' + #13#10 +
                                             'Continuare?';

  A000MSG_A057_ERR_SQUADRA_NON_SPECIFICATA = 'Non è stata specificata la squadra!';
  A000MSG_A057_ERR_TIPOOPE_NON_SPECIF      = 'Non è stato specificato il tipo operatore!';
  A000MSG_A057_ERR_ORARIO_NON_SPECIF       = 'Non è stato specificato l''orario!';
  A000MSG_A057_ERR_PIANIF_TURNO_DOPPIO     = 'Non si può pianificare 2 volte lo stesso turno!';
  A000MSG_A057_ERR_PIANIF_SEC_TURNO        = 'Non si può pianificare il secondo turno senza aver pianificato il primo!';

  A000MSG_A058_ERR_PROFILO_ERRATO          = 'Profilo pianificazione inesistente!';
  A000MSG_A058_ERR_PROFILO_MANCANTE        = 'Non è stato selezionato alcun profilo pianificazione!';
  A000MSG_A058_ERR_SQUADRA_MANCANTE        = 'Non è stata selezionata alcuna squadra!';
  A000MSG_A058_ERR_PERIODO                 = 'Il periodo specificato non è valido!';
  A000MSG_A058_ERR_PERIODO_DATE            = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_A058_ERR_REGISTRA_MODIFICHE      = 'Prima di rendere operativa la pianificazione corrente, occorre registrare le modifiche apportate!';
  A000MSG_A058_ERR_NO_PIANIFICAZIONE       = 'Impossibile proseguire nella pianificazione dei dipendenti selezionati.' + #13#10 + 'Nessun valore presente nella maschera ''<A056> Assegnazione turnazioni'' per il dipendente %s.';
  A000MSG_A058_DLG_RENDI_OPERATIVA         = 'ATTENZIONE!' + #13#10 +
                                             'I dati relativi alla pianificazione operativa di tutti i dipendenti visualizzati saranno sovrascritti dai dati della pianificazione corrente.' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_ERR_MODIFICHE_PENDENTI      = 'ATTENZIONE!' + #13#10 +
                                             'Sono prensenti modifiche pendenti, effettuare la registrazione prima di proseguire.';
  A000MSG_A058_DLG_CANC_PIANIF_PROG        = 'ATTENZIONE!' + #13#10 +
                                             'Verranno cancellati i dati di pianificazione di tutti i dipendenti visualizzati per la pianificazione operativa e non operativa.' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_CANC_PIANIF             = 'ATTENZIONE!' + #13#10 +
                                             'Verranno cancellati i dati di pianificazione di tutti i dipendenti visualizzati' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_REG_PIANIF              = 'ATTENZIONE!' + #13#10 +
                                             'I dati di pianificazione saranno registrati anche sulla pianificazione iniziale e su quella corrente, sovrascrivendo eventuali altre informazioni già presenti e riferite al periodo ed ai dipendenti visualizzati.' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_MODIFICHE_NON_SALVATE   = 'Le modifiche apportate non sono state salvate!' + #13#10 +
                                             'Proseguire nell''operazione?';
  A000MSG_A058_DLG_FMT_PIANIF_ESISTENTE    = 'La pianificazione esiste già per i seguenti dipendenti:' + #13#10 + '%s' + #13#10 +
                                             'La creazione di una nuova pianificazione non eliminerà quella esistente.' + #13#10 +
                                             'Continuare?';
  A000MSG_A058_ERR_JS_JQGRID_NON_SUPP      = 'Il browser in uso &egrave; obsoleto e non supporta il tabellone turni. Utilizzare un browser più recente o un browser diverso e riprovare.';
  A000MSG_A058_DLG_BLOCCA_SBLOCCA          = 'ATTENZIONE!' + #13#10 +
                                             'Verranno %s tutti i dati di pianificazione riferiti al periodo ed ai dipendenti visualizzati.' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_NUOVA_VERSIONE          = 'Versione precedente del tabellone turni già presente, proseguire con l''archiviazione di una nuova versione del documento?';
  A000MSG_A058_DLG_SOVRASCRIVI             = 'Documento già archiviato in precedenza, proseguire con la sostituzione del documento precedente?';
  A000MSG_A058_ERR_FMT_GENERICO_ARCH       = 'Errore durante l''archiviazione del tabellone turni su gestione documentale: %s';
  A000MSG_A058_ERR_FMT_NO_TIPOLOGIA        = 'Errore durante l''archiviazione del tabellone turni su gestione documentale: tipologia %s non trovata';

  A000MSG_A059_ERR_SQUADRE                 = 'Le squadre devono essere specificate in ordine alfabetico!';
  A000MSG_A059_ERR_SQUADRA_MANCANTE        = 'Non sono state specificate entrambe le squadre!';

  A000MSG_A060_DLG_FMT_ELIMINA_TIMBRATURE  = 'Attenzione!' + #13#10 +
                                             'Eliminare timbrature dal %s al %s ?';

  A000MSG_A061_ERR_SELEZIONE_MANCANTE      = 'Selezionare "Stampa dati individuali" o "Totali generali".';
  A000MSG_A061_ERR_CAUSALE                 = 'Nessuna causale selezionata';
  A000MSG_A061_MSG_INIZIO_REGISTRAZIONE    = 'Inizio registrazione:';
  A000MSG_A061_MSG_FINE_REGISTRAZIONE      = 'Fine registrazione:';
  A000MSG_A061_MSG_DALLA_DATA              = 'Dalla data:';
  A000MSG_A061_MSG_ALLA_DATA               = 'Alla data:';
  A000MSG_A061_DLG_TOT_FRUIZIONI_CONIUGE   = 'Attenzione! Le assenze fruite dal coniuge verranno totalizzate soltanto se gli unici Totali selezionati sono quelli Individuali (eventualmente Distinti per familiare). Proseguire?';

  A000MSG_A062_DLG_FMT_QUERY_ESISTENTE     = 'Attenzione! La tabella T921%s è già esistente e verrà ricreata.' + #13#10 +
                                             'I dati contenuti nella tabella precedente andranno persi. Continuare?';
  A000MSG_A062_MSG_FMT_DATI_REGISTRATI     = 'I dati sono stati registrati nella tabella T921%s .';
  A000MSG_A062_MSG_QUERY_ESISTENTE         = 'Query già esistente!! Sovrascrivere?';
  A000MSG_A062_ERR_NOME_QUERY_MANCANTE     = 'Inserire il nome della query da salvare';
  A000MSG_A062_ERR_ACCESSO_NEGATO          = 'Accesso negato';
  A000MSG_A062_ERR_SCRIPT_INVALIDO         = 'Script non valido!';
  A000MSG_A062_ERR_QUERY_ESISTENTE         = 'Impossibile salvare %s!'#13#10'Esiste già una query con lo stesso nome!';

  A000MSG_A063_ERR_PERIODO_CALCOLO_FRUITO  = 'Impostare correttamente il periodo per il calcolo del fruito!';
  A000MSG_A063_ERR_PERIODO_RIPORTO_RESIDUO = 'Impostare correttamente il periodo per il riporto del residuo!';
  A000MSG_A063_ERR_NO_BUDGET               = 'Selezionare almeno un budget di straordinario!';
  A000MSG_A063_ERR_ANNO_DUPLICAZIONE       = 'Selezionare un anno di duplicazione differente!';
  A000MSG_A063_DLG_ASSEGNA_BUDGET          = 'Attenzione! Proseguire con la sovrascrittura del budget mensile per i gruppi selezionati?';
  A000MSG_A063_DLG_CALCOLA_E_RIPORTA       = 'Attenzione! Proseguire con il riallineamento del fruito mensile e con il riporto del residuo sui mesi successivi per i gruppi selezionati?';
  A000MSG_A063_DLG_CALCOLA_FRUITO          = 'Attenzione! Proseguire con il riallineamento del fruito mensile per i gruppi selezionati?';
  A000MSG_A063_DLG_RIPORTA_RESIDUO         = 'Attenzione! Proseguire con il riporto del residuo sui mesi successivi per i gruppi selezionati?';
  A000MSG_A063_DLG_FMT_CONTROLLO_FA        = 'Attenzione! L''operazione potrebbe richiedere diversi minuti. Proseguire con il controllo della sovrapposizione dei filtri anagrafe dell''anno %s?';
  A000MSG_A063_DLG_FMT_DUPLICA_GRUPPI      = 'Attenzione! Proseguire con la duplicazione dei gruppi selezionati sull''anno %s?';
  A000MSG_A063_MSG_FMT_GRUPPO              = 'Cod. gruppo: %s, Tipo: %s, Periodo: %s. ';
  A000MSG_A063_ERR_NO_TROV_BUDGET          = 'Budget di straordinario non trovato';
  A000MSG_A063_ERR_FMT_MESE_ESTERNO        = 'Il mese di riferimento (%s) non è compreso nel periodo';
  A000MSG_A063_ERR_BUDGET_ESISTE           = 'Budget di straordinario già esistente nel periodo';
  A000MSG_A063_ERR_FMT_BUDGET_ESISTE_PERIODO = 'Budget di straordinario già esistente con Tipo: %s ma con Periodo: %s-%s';
  A000MSG_A063_ERR_INSERIMENTO             = 'Inserimento fallito';
  A000MSG_A063_ERR_FMT_DIP_2_GRUPPI        = 'Dipendente presente contemporaneamente in 2 gruppi: %s e %s dal %s al %s';

  A000MSG_A064_ERR_INIZIO_VALIDITA         = 'Indicare un mese di inizio validità corretto!';
  A000MSG_A064_ERR_FINE_VALIDITA           = 'Indicare un mese di fine validità corretto!';
  A000MSG_A064_ERR_INIZIO_FINE_VALIDITA    = 'Il mese di inizio validità non può essere successivo al mese di fine validità!';
  A000MSG_A064_MSG_DISPONIBILITA_NEGATIVA  = 'Attenzione! La variazione produce disponibilità negativa sull''ultimo mese!';
  A000MSG_A064_MSG_FMT_FRUITO_AZZERATO     = 'Il fruito è stato azzerato per tutti tipi del gruppo %s nel periodo %s-%s!';
  A000MSG_A064_DLG_CONTROLLO_FA            = 'Attenzione! Si rende necessario controllare che i dipendenti selezionati non si trovino contemporaneamente negli altri gruppi. Si vuole accedere ora alla maschera di allineamento del budget per effettuare questa operazione?';
  A000MSG_A064_MSG_CONTROLLO_FA_MANUALE    = 'Ricordarsi di lanciare manualmente il "Controllo sovrapposizione filtri anagrafe" dalla maschera <A063> Allineamento del budget';
  A000MSG_A064_MSG_CONTROLLO_FA_AUTOMATICO = 'Lanciare il "Controllo sovrapposizione filtri anagrafe" dalla maschera <A063> Allineamento del budget';
  A000MSG_A064_ERR_NO_CODICE               = 'Indicare il codice del gruppo del budget di straordinario!';
  A000MSG_A064_ERR_NO_TIPO                 = 'Indicare il tipo del budget di straordinario!';
  A000MSG_A064_ERR_NO_ANNO                 = 'Indicare l''anno di riferimento!';
  A000MSG_A064_ERR_ANNO_UGUALE_FILTRO      = 'L''anno di riferimento deve essere uguale a quello indicato in Filtro anno!';
  A000MSG_A064_ERR_NO_FA                   = 'Indicare il filtro anagrafe!';
  A000MSG_A064_ERR_SQL_FA                  = 'Filtro anagrafe errato!';
  A000MSG_A064_ERR_FMT_GRUPPO_FA_NO_DIP    = 'Non è possibile effettuare %s in quanto il codice gruppo indicato è già legato ad un filtro anagrafe che non estrarrebbe nessun dipendente nel periodo indicato per l''operatore corrente!';
  A000MSG_A064_ERR_FA_NO_DIP               = 'Non è possibile effettuare l''inserimento in quanto il filtro anagrafe indicato non estrarrebbe nessun dipendente nel periodo indicato per l''operatore corrente!';
  A000MSG_A064_DLG_FMT_AGG_PERIODO         = 'Attenzione! E'' già stato registrato del fruito per il gruppo %s nel periodo %s-%s. Proseguire con la modifica del periodo di validità, sovrascrivendo l''assegnazione mensile del budget?';
  A000MSG_A064_DLG_FMT_AGG_FA              = 'Attenzione! Il filtro anagrafe indicato differisce da quello precedentemente impostato. Per ognuno dei tipi del gruppo %s nel periodo %s-%s verrà applicato il nuovo filtro e bisognerà ricalcolare il fruito. Proseguire?';
  A000MSG_A064_DLG_AGG_ORE                 = 'Attenzione! E'' stato modificato il valore di Ore. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?';
  A000MSG_A064_DLG_AGG_IMPORTO             = 'Attenzione! E'' stato modificato il valore di Importo. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?';
  A000MSG_A064_ERR_FMT_ESISTE_CHIAVE       = 'Chiave già esistente nel periodo %s-%s!';
  A000MSG_A064_DLG_FMT_AGG_FA_2            = 'Attenzione! Il filtro anagrafe indicato differisce da quello già impostato per gli altri tipi del gruppo %s nel periodo %s-%s. Per ognuno di essi verrà applicato il nuovo filtro e bisognerà ricalcolare il fruito. Proseguire?';
  A000MSG_A064_ERR_FMT_PERIODI_INTERSECANTI = 'Il periodo indicato interseca periodi già impostati per gli altri tipi dello stesso gruppo!' + Chr(10) + '%s' + Chr(10) + 'Utilizzare un periodo già esistente!';
  A000MSG_A064_DLG_FMT_AGG_PERIODO_2       = 'Il periodo indicato differisce dal periodo (%s) già impostato per gli altri tipi dello stesso gruppo.' + Chr(10) + ' Proseguendo verrà modificato il periodo su tutti i tipi del gruppo e, per ognuno di essi, verrà sovrascritta l''assegnazione mensile del budget. Proseguire?';
  A000MSG_A064_DLG_FMT_AGG_PERIODO_3       = 'Attenzione! E'' stato modificato il periodo di validità dei dati. Verrà sovrascritta l''assegnazione mensile del budget. Proseguire?';

  A000MSG_A065_ERR_PERIODO                 = 'Impostare correttamente il periodo!';
  A000MSG_A065_NO_GRUPPI                   = 'Selezionare almeno un gruppo!';

  A000MSG_A067_ERR_NO_CAUSALE              = 'Non è stata specificata la causale correttiva!';

  A000MSG_A071_ERR_DATO_NON_SPECIF         = 'Dato non specificato!';

  A000MSG_A074_ERR_CAMPO_RIFERIMENTO       = 'Non è specificato il campo di riferimento sui parametri aziendali!';
  A000MSG_A074_ERR_PWD_FILE                = 'Password errata, impossibile creare il file sequenziale!';
  A000MSG_A074_ERR_PARAMETRIZZAZIONE       = 'Specificare una parametrizzazione valida o disattivare l''opzione ''Genera file per acquisto ticket''!';
  A000MSG_A074_ERR_FMT_CREATE_FILE         = 'Impossibile creare il file %s';
  A000MSG_A074_DLG_FILE_SEQUENZIALE        = 'Attenzione!' + #13#10 +
                                             'Si consigia di utilizzare l''opzione ''Genera file per acquisto ticket'' scegliendo la parametrizzazione ''A074'''+ #13#10 +
                                             'in quanto l''opzione ''Genera file sequenziale'' verrà dismessa nelle prossime versioni.' + #13#10 + #13#10 +
                                             'Per informazioni a riguardo chiedere al servizio di assistenza.' + #13#10 + #13#10 +
                                             'Continuare comunque con l''opzione ''Genera file sequenziale''?';
  A000MSG_A074_DLG_DISAB_AGGIORNAMENTO     = 'ATTENZIONE!' + #13#10 + #13#10 +
                                             'Poichè è stato richiesto l''elaborazione di un mese precedente' + #13#10 +
                                             'ad altri acquisti effettuati, l''aggiornameto sarà disabilitato.' + #13#10 + #13#10 +
                                             'Proseguire comunque?';
  A000MSG_A074_DLG_FMT_ELIMINA_ACQUISTO    = 'ATTENZIONE!' + #13#10 +
                                             'Sono presenti %d movimenti di acquisto relativi al mese di %s' + #13#10 +
                                             'Eliminarli?';


  A000MSG_A077_ERR_TAB_NON_COMPATIBILE     = 'file pdf inesistente!'#13#10'La stampa può essere vuota o la tabella di salvataggio non è compatibile.';
  A000MSG_A077_FMT_STAMPA_NON_DISPONIB     = 'Stampa non disponibile: %s';

  A000MSG_A080_ERR_ORDINE_SERBATOI         = 'Specificare esattamente l''ordine di prelievo dai serbatoi!';
  A000MSG_A080_ERR_TIPI_APPLICAZIONE       = 'Le impostazioni dei tipi applicazione dei limiti mensili dell''eccedenza liquidabile e residuabile sono incompatibili!';
  A000MSG_A080_ERR_RESID_INFERIORE_LIMITE  = 'Il limite ore residuabili non può essere inferiore al minore dei limiti dell''anno prec. e dell''anno corr.!';
  A000MSG_A080_ERR_RESID_SUPERIORE_LIMITE  = 'Il limite ore residuabili non può essere superiore alla somma dei limiti dell''anno prec. e dell''anno corr.!';
  A000MSG_A080_DLG_NO_SALDI_MOBILI         = 'Attenzione!' + #13 +
                                             'Specificando più di un mese come riferimento al recupero del debito sulle paghe, è necessario attivare i Saldi Mobili.' + #13 +
                                             'Non facendolo, l''addebito sul mese di Gennaio sarà sempre riferito a Dicembre.' + #13 +
                                             'Confermare comunque?';
  A000MSG_A080_ERR_ARRLIQ_POSITIVO         = 'Il valore di arrotondamento, se indicato, deve essere almeno di 1 minuto!';
  A000MSG_A080_ERR_FMT_MINLIQ_MOD_ARRLIQ   = 'Il minimo liquidabile delle richieste di straordinari (%s)'#13#10 +
                                             'deve essere multiplo del''arrotondamento liquidabile (%s)!';
  A000MSG_A080_ERR_TIPOABBATTIMENTO        = 'I valori ammissibili per Tipo Abbatt sono:'#13#10 +
                                             'N=abbattimento saldo al MESE_RIF non recuperato entro il MESE_ABBATT'#13#10 +
                                             'P=abbattimento ore dell''anno precedente ancora disponibili nel MESE_ABBATT';

  A000MSG_A082_DLG_RIPRISTINO              = 'Verrà ripristinata l''ultima situazione corretta rilevata dal sistema. Vuoi procedere?';
  A000MSG_A082_DLG_FMT_COPIA               = 'I centri di costo del dipendente %s %s ,' + #13#10 +
                                             'alla data di lavoro %s, verranno riportati sugli altri dipendenti selezionati.' + #13#10 +
                                             'Eventuali storicizzazioni esistenti verranno sovrascritte.' + #13#10 +
                                             'Proseguire l''operazione?';
  A000MSG_A082_ERR_NO_CDC                  = 'Non è specificato il campo Centro di costo percentualizzato in Gestione Aziende!';
  A000MSG_A082_ERR_FMT_ANOMALIE_PENDING    = 'Attenzione! La situazione attuale non è valida. Correggerla prima di abbandonarla%s!';
  A000MSG_A082_ERR_FMT_ANOMALIE_PENDING2   = ', eventualmente ripristinando la situazione corretta precedente tramite l''apposito pulsante';


  A000MSG_A082_ERR_FMT_PERIODI             = 'Attenzione! Sono state rilevate le seguenti anomalie.'#13#10#13#10'%s';

  A000MSG_A085_ERR_VALORE_PERCENTUALE      = 'Il valore deve essere compreso tra 0 e 100';

  A000MSG_A086_ERR_TIPO                    = 'Indicare il tipo di motivazione';
  A000MSG_A086_ERR_FMT_TIPO_VALORE         = 'Il tipo indicato non è valido: %s';
  A000MSG_A086_ERR_CODICE_DEFAULT          = 'Indicare S oppure N per il dato default';
  A000MSG_A086_ERR_CODICE_DEFAULT_CAUS_NOT_NULL = 'Impossibile attribuire il valore di default ad una motivazione legata a causali specifiche!';
  A000MSG_A086_ERR_CODICE_DEFAULT_MULT     = 'Impossibile attribuire più di un default!';

  A000MSG_A087_MSG_VISUALIZZA_FILE         = '<A087> Visualizzazione file di importazione XML';
  A000MSG_A087_MSG_IMPORT_TERMINATA        = 'Importazione terminata correttamente.';
  A000MSG_A087_MSG_ANOMALIE_BLOCCANTI      = 'Importazione terminata con anomalie bloccanti.';
  A000MSG_A087_MSG_ANOMALIE_NON_BLOCCANTI  = 'Importazione terminata correttamente con anomalie non bloccanti.';
  A000MSG_A087_MSG_NO_ANOMALIE             = 'Non sono state riscontrate anomalie.';
  A000MSG_A087_MSG_PERIODO_MAL_CANC_SI     = 'Periodo di malattia cancellato correttamente.';
  A000MSG_A087_MSG_PERIODO_MAL_CANC_NO     = 'Errore nella cancellazione del periodo di malattia.';
  A000MSG_A087_MSG_PERIODO_ANNULLATO       =  '%s periodo annullato correttamente';
  A000MSG_A087_MSG_CAPTION_ELENCO_COMUNI   = '<A087> Selezione del comune reperibilità';
  A000MSG_A087_MSG_DADATA                  = 'Dalla data:';
  A000MSG_A087_MSG_DIP_ESCLUSI             = 'Dipendenti esclusi dalla selezione';
  A000MSG_A087_MSG_NO_DATA_INI_NULLA       = 'La data di inizio malattia non può essere nulla!';
  A000MSG_A087_MSG_NO_DATA_FINE_NULLA      = 'La data di fine malattia non può essere nulla!';
  A000MSG_A087_MSG_DATA_INI_NON_VALIDA     = 'Data inizio malattia non valida!';
  A000MSG_A087_MSG_DATA_FINE_NON_VALIDA    = 'Data fine malattia non valida!';
  A000MSG_A087_MSG_PERIODO_INSERITO        = 'Periodo inserito correttamente';
  A000MSG_A087_MSG_PERIODO_ANNUNLLATO      = ': giustificativo annullato correttamente';
  A000MSG_A087_MSG_GIUSTIF_INSERITO        = '%s : giustificativo inserito correttamente';
  A000MSG_A087_MSG_IMPORT_TXT_TERMINATA    = 'Importazione file terminata senza anomalie.';
  A000MSG_A087_MSG_NO_CAUS_ASSOCIATA       = 'Nessuna causale associata per questo dipendente.';
  A000MSG_A087_MSG_NO_PROFILI_ABILITATI    = 'Non ci sono profili abilitati per questo dipendente!';
  A000MSG_A087_MSG_MATRICOLA_NON_TROVATA   = 'Matricola non trovata in anagrafico.';
  A000MSG_A087_MSG_TIMESTAMP_GIA_INSERITO  = 'Periodo dal %s al %s: comunicazione di malattia già registrata in precedenza.';
  A000MSG_A087_MSG_CDTSTXTFILE_CHIUSO      = 'CDtsTXTFile non attivo o vuoto.';
  A000MSG_A087_MSG_ANOMALIA_BLOCCANTE      = 'Anomalia bloccante: %s';
  A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE  = 'Anomalia non bloccante: %s';
  A000MSG_A087_MSG_CODFISCALE_NON_TROVATO  = 'Codice fiscale del dipendente %s non trovato';
  A000MSG_A087_MSG_DIP_NON_SERVIZIO        = 'Dipendente non in servizio alla data %s';
  A000MSG_A087_MSG_DIP_NON_ASSOCIATO       = 'Dipendente non appartenente a nessun profilo.';
  A000MSG_A087_MSG_CODFISCALE_DOPPIO       = 'Codice fiscale %s associato a più di un dipendente in servizio alla data %s';
  A000MSG_A087_MSG_CAUS_NON_TROVATE        = 'Causali di assenza non trovate per il certificato numero %s';
  A000MSG_A087_MSG_PERIDO_GIA_INSERITO     = 'Periodo già inserito da un precedente certificato.';
  A000MSG_A087_MSG_GIUSTIF_RETT            = ': giustificativo rettificato correttamente.';
  A000MSG_A087_MSG_COMUNE_RES_NON_TROVATO  = '%s comune di residenza non trovato';
  A000MSG_A087_MSG_COMUNE_REP_NON_TROVATO  = '%s comune di reperibilità non trovato';
  A000MSG_A087_MSG_PERIODO_MAG_10GG        = 'Periodo di malattia superiore ai 10 giorni.';
  A000MSG_A087_MSG_CAUS_RIC_NON_INS        = 'Causale di ricovero non inserita.';
  A000MSG_A087_MSG_ID_ANNULL_NON_TROVATO   = 'Certificato numero %s da annullare non trovato';
  A000MSG_A087_MSG_ID_RETT_NON_TROVATO     = 'Certificato numero %s da rettificare non trovato';
  A000MSG_A087_MSG_PERIODO_RETTIFICATO     = '%s periodo rettificato correttamente.';
  A000MSG_A087_ERR_CAUS_SV_NON_SELEZIONATA = '%s Causale salvavita non selezionata!';
  A000MSG_A087_ERR_CAUS_SRV_NON_SEL        = '%s Causale di servizio non selezionata!';
  A000MSG_A087_ERR_CERT_DATA_INIZIO        = 'Certificato numero %s con data inizio malattia %s non valida';
  A000MSG_A087_ERR_CERT_DATA_FINE          = 'Certificato numero %s con data fine malattia %s non valida';
  A000MSG_A087_ERR_ID_INIZIO_MAGG_FINE     = 'Certificato numero %s con data inizio malattia successiva alla data fine malattia';
  A000MSG_A087_ERR_DIMISSIONI_1            = '%s La data inizio del certificato di dimissioni"%s" è diversa dalla data di ricovero.';
  A000MSG_A087_ERR_ESECUZIONE_QUERY        = 'Errore nell''esecuzione filtro %s: %s';
  A000MSG_A087_ERR_IMPORT_TXT_TERMINATA    = 'Sono state riscontrate anomalie durante l''importazione';
  A000MSG_A087_ERR_OPZIONI_1               = 'Impossibile selezionare più di un''opzione tra: Ricovero\Post-ricovero, Agevolazioni e Particolari cause di malattia.';
  A000MSG_A087_ERR_OPZIONI_2               = 'Impossibile specificare %s se la comunicazione è avvenuta per via telefonica.';
  A000MSG_A087_ERR_PROTOCOLLO_NULL_1       = 'Impossibile specificare Numero protocollo nullo se Data rilascio e/o Data consegna sono valorizzati.';
  A000MSG_A087_ERR_PROTOCOLLO_NULL_2       = 'Impossibile specificare Numero protocollo nullo se tipo comunicazione è uguale a Certificato medico e Data rilascio e/o Data consegna non sono valorizzati.';
  A000MSG_A087_ERR_PROTOCOLLO_NULL_3       = 'Attenzione non è possibile inserire più di 3 gioni senza numero di protocollo.';
  A000MSG_A087_ERR_CONSEGNA_NON_VALIDA     = 'Data di consegna non valida!';
  A000MSG_A087_ERR_RILASCIO_MIN_INIZIO     = 'La Data di di rilascio deve essere maggiore o uguale alla data di inizio malattia.';
  A000MSG_A087_ERR_CONSEGNA_MIN_RILASCIO   = 'La Data di consegna deve essere maggiore o uguale alla data di rilascio.';
  A000MSG_A087_ERR_RILASCIO_NON_VALIDO     = 'Data di rilascio non valida!';
  A000MSG_A087_ERR_FINE_MINORE_INIZIO      = 'La data fine malattia non può essere inferiore alla data di inizio!';
  A000MSG_A087_ERR_ANOMALIE_BLOCCANTI      = 'Sono state riscontrate anomalie bloccanti.';
  A000MSG_A087_ERR_ANOMALIE_NON_BLOCCANTI  = 'Sono state riscontrate anomalie non bloccanti.';
  A000MSG_A087_ERR_FMT_FILTROPROFILI       = 'E'' necessario attivare il profilo corretto: contattare il servizio di assistenza di %s.';
  A000MSG_A087_ERR_CONVERSIONE_DATA        = 'Errore conversione data!';
  A000MSG_A087_ERR_SALVAVITA               = 'Anomalia dimissioni terapia salvavita';
  A000MSG_A087_DLG_DIP_ESCLUSI             = 'Alcuni dipendenti sono esclusi dalla selezione.'#13#10'Visualizzarli?';
  A000MSG_A087_DLG_FMT_CAUSALE_DIVERSA     = 'Causale di malattia %s diversa dall''ultima causale utilizzata: %s' + #13#10 +
                                             'Continuare?';
  A000MSG_A087_DLG_CANCELLA_CAUSALE        = 'Verrà cancellato il periodo dal %s al %s per il dipendente %s %s.'#13#10'Continuare?';

  A000MSG_A088_ERR_FMT_DEL_CAT0            = 'La cancellazione della categoria %s non è consentita!';
  A000MSG_A088_ERR_FMT_DUP_CAT0            = 'La duplicazione della categoria %s non è consentita!';
  A000MSG_A088_ERR_FMT_DEL_CAT             = 'La categoria %s contiene dei dati.'#13#10'E'' necessario eliminarli prima di poter procedere con la cancellazione';
  A000MSG_A088_MSG_MOTIVAZIONE             = 'La motivazione selezionata è utilizzata';
  A000MSG_A088_MSG_IPOTESI                 = 'L''ipotesi selezionata è utilizzata';
  A000MSG_A088_MSG_DATO_LIBERO             = 'Il dato libero selezionato è utilizzato';
  A000MSG_A088_ERR_CODICE_CAT_NULLO        = 'Il codice della categoria non può essere nullo!';
  A000MSG_A088_ERR_FMT_DESC_CAT_NULLA      = 'La descrizione della categoria con codice %s non può essere nulla!';
  A000MSG_A088_ERR_CODICE_NULLO            = 'Il codice del dato libero non può essere nullo!';
  A000MSG_A088_ERR_FMT_DESC_NULLA          = 'La descrizione del dato con codice %s non può essere nulla!';
  A000MSG_A088_ERR_FMT_VALORI              = 'La lista di valori del dato %s'#13#10'deve contenere almeno due elementi separati da virgola!';
  A000MSG_A088_ERR_FMT_OBBLIGATORIO        = 'Indicare se il dato %s è obbligatorio (S), oppure no (N)';
  A000MSG_A088_ERR_FMT_FORMATO             = 'Selezionare il formato del dato %s:'#13#10'- S = stringa'#13#10'- N = numero'#13#10'- D = data (gg/mm/aaaa)';
  A000MSG_A088_ERR_FMT_RIGHE               = 'Indicare il numero di righe per il dato %s'#13#10'scegliendo un valore compreso fra 1 e 9';
  A000MSG_A088_ERR_FMT_LUNG_MAX            = 'Indicare una lunghezza max per il dato %s'#13#10'scegliendo un valore compreso fra 0 e 9999';
  A000MSG_A088_ERR_FMT_SELEZIONE_VALORI    = 'Per il dato %s'#13#10'è possibile indicare un solo valore fra:'#13#10'- %s'#13#10'- %s'#13#10'- %s';
  A000MSG_A088_ERR_FMT_ELENCO_FISSO        = 'Per il dato %s'#13#10'indicare il valore di Elenco fisso, scegliendo:'#13#10'- S se la scelta è limitata ai valori in elenco'#13#10'- N altrimenti';
  A000MSG_A088_ERR_CATEGORIA               = 'Indicare la categoria';
  A000MSG_A088_ERR_CATEGORIA_EDIT          = 'La modifica dei dati di questa categoria non è consentita!';
  A000MSG_A088_ERR_FMT_ORDINE              = 'La categoria %s deve avere un ordine maggiore o uguale a 1!';
  A000MSG_A088_ERR_FMT_DELETE              = '%s nelle richieste'#13#10 +
                                             'di trasferta effettuate dall''applicativo IrisWeb.'#13#10 +
                                             'Cancellazione impossibile!';
  A000MSG_A088_ERR_FMT_LIMITE_FASE_NULL    = 'Il dato %s'#13#10'della categoria %s'#13#10'non può essere nullo!';

  A000MSG_A089_ERR_TIPO_NON_DISPONIBILE    = 'Tipo non disponibile!';
  A000MSG_A089_ERR_PROP_TURNI_PCT          = 'La proporzione dei turni è espressa in percentuale!';
  A000MSG_A089_ERR_FMT_LEGAME_INDENNITA    = 'Impossibile stabilire un legame tra l''indennità corrente e l''indennità ''%s'' poichè si verrebbe a creare un ciclo ricorsivo!';

  A000MSG_A091_ERR_NO_CAUSALE              = 'Causale non specificata!';
  A000MSG_A091_ERR_ANNO                    = 'Anno non valido!';
  A000MSG_A091_ERR_MESE                    = 'Mese non valido!';
  A000MSG_A091_ERR_TROPPE_CAUSALI          = 'Selezionare solo una causale!';
  A000MSG_A091_DLG_FMT_NO_LIQ_ANNO         = 'Non esistono liquidazioni per i dipendenti selezionati nel %d';
  A000MSG_A091_DLG_FMT_ULTIMA_LIQ_PERIODO  = 'L''ultima liquidazione effettuata nel periodo selezionato è di %s';
  A000MSG_A091_DLG_FMT_ULTIMA_LIQ_ANNO     = 'L''ultima liquidazione effettuata nell''anno è di %s';
  //A000MSG_A091_DLG_FMT_ANNULLA_LIQ         = 'Verranno alterati i riepiloghi di %s per i dipendenti selezionati';
  A000MSG_A091_DLG_FMT_CONF_ANNULLA_LIQ_1  = 'Verranno alterati i riepiloghi'#13#10'del mese di %s'#13#10'per i dipendenti selezionati.'#13#10'Continuare?';
  A000MSG_A091_DLG_FMT_CONF_ANNULLA_LIQ_N  = 'Verranno alterati i riepiloghi'#13#10'nei mesi da %s a %s'#13#10'per i dipendenti selezionati.'#13#10'Continuare?';

  A000MSG_A092_ERR_ANAGRAFE                = 'Nessuna anagrafica selezionata.';
  A000MSG_A092_ERR_DATO_ANAGRAFE           = 'Nessun dato anagrafico selezionato.';

  A000MSG_A093_DLG_FMT_ELIMINA             = 'Eliminare le registrazioni effettuate dal %s al %s?';
  A000MSG_A093_ERR_DATA_INVALIDA           = 'Date non valide.';

  A000MSG_A094_ERR_DATA                    = 'Anno o mese errati';
  A000MSG_A094_ERR_DATA_DECOR              = 'Sono ammesse date di decorrenza solo del primo gennaio di ogni anno';
  A000MSG_A094_ERR_CAMPO                   = 'Deve essere inserito il campo';
  A000MSG_A094_ERR_FMT_CAUSALE_BANCAORE    = 'La causale ''%s'' deve avere Banca ore = ''%s''';
  A000MSG_A094_ERR_FMT_BANCAORE            = 'Se Banca ore = ''S'' è possibile inserire solo la causale ''%s''';
  A000MSG_A094_ERR_FMT_NON_IN_ELENCO       = 'Valore di %s non tra quelli presenti in elenco';
  A000MSG_A094_ERR_TIPO_LIMITE_ERRATO      = 'Tipo limite può solo assumere i valori L o R.';
  A000MSG_A094_ERR_RAGGR_ANNO              = 'Ragguppamento non definito per l''anno indicato';

  A000MSG_A095_ERR_NO_LIQ                  = 'Non esistono liquidazioni per i dipendenti selezionati';
  A000MSG_A095_DLG_FMT_ANNULLA_LIQ         = 'Verranno alterati i riepiloghi di %s per i dipendenti selezionati. Continuare?';

  A000MSG_A096_ERR_CAUSALE_INESISTENTE     = 'Causale inesistente';
  A000MSG_A096_ERR_FMT_INTERSEZIONE        = 'Nel giorno %s la pianificazione %s-%s ne interseca una già esistente (%s %s-%s)!';

  A000MSG_A097_ERR_CAUSALE_INESISTENTE     = 'Causale inesistente';
  A000MSG_A097_ERR_DATA_ESTERNA            = 'La data deve essere interna al periodo di visualizzazione indicato!';
  A000MSG_A097_ERR_FMT_INTERSEZIONE        = 'Nel giorno %s la pianificazione %s-%s ne interseca una già esistente (%s %s-%s)!';
  A000MSG_A097_ERR_PERIODO_LUNGO           = 'Il periodo può essere al massimo di cinque anni';
  A000MSG_A097_ERR_PROFILO_NON_VALIDO      = 'Profilo non valido!';
  A000MSG_A097_DLG_FMT_CONFERMA            = 'Confermi %s dei turni di libera professione per tutti i dipendenti selezionati dal %s al %s?';
  A000MSG_A097_DLG_FMT_CONFERMA_IMPORT     = 'Confermi l''importazione delle attività di libera professione' + #13#10 + 'dal file %s' + #13#10 + 'per i %s dipendenti selezionati' + #13#10 + 'nel periodo %s-%s?';
  A000MSG_A097_ERR_NO_IMPORT               = 'Nessuna attività importata! ';
  A000MSG_A097_ERR_IMP_COLONNA_NON_TROV    = 'Colonna %s non presente nel file! Impossibile reperire il dato %s';
  A000MSG_A097_ERR_IMP_DATO_VUOTO          = 'Riga %s: Colonna %s non valorizzata! Impossibile reperire il dato %s';
  A000MSG_A097_ERR_IMP_DATA_NON_VALIDA     = 'Riga %s: Il valore %s della colonna %s non è una data valida nel formato ''DD-MON-YY''! Impossibile reperire il dato %s';
  A000MSG_A097_ERR_IMP_ORA_NON_VALIDA      = 'Riga %s: Il valore %s della colonna %s non è un''ora valida! Impossibile reperire il dato %s';

  A000MSG_A099_DLG_FMT_ESEGUI              = 'Eseguire il comando ''%s'' per tutte le tabelle selezionate?';
  A000MSG_A099_DLG_SCONSIGLIATA            = 'ATTENZIONE! Questa operazione è sconsigliata!'#13#10'Continuare comunque?';
  A000MSG_A099_MSG_INDICI                  = 'E'' necessario effettuare subito il rebuild degi indici per le tabelle spostate!';
  A000MSG_A099_DLG_FMT_DB                  = 'Eseguire il comando ''%s'' per il database %s?';

  A000MSG_A100_ERR_NOTERIMBORSI            = 'Non esistono rimborsi per cui indicare le note.';
  A000MSG_A100_ERR_RIMBORSA                = 'La colonna ''Rimborsa'' ammette i valori ''S'' o ''N''.';
  A000MSG_A100_ERR_NO_DATA_RIMB            = 'Indicare la data del rimborso.';
  A000MSG_A100_ERR_DATA_RIMB_ANTE          = 'La data del rimborso non può essere precedente alla data di inzio missione.';
  A000MSG_A100_ERR_DATA_RIMB_POST          = 'La data del rimborso non può essere successiva alla data di fine missione.';
  A000MSG_A100_ERR_NO_MOD_PAG              = 'Indicare la modalità di pagamento.';
  A000MSG_A100_ERR_NO_IMP_RIMB             = 'Indicare l''importo del rimborso.';
  A000MSG_A100_ERR_IMP_RIMB_NEG            = 'L''importo del rimborso deve essere un valore positivo.';
  A000MSG_A100_ERR_COD_RIMB_NO_ESISTE      = 'Il codice rimborso inserito non esiste nella tabella rimborsi.';
  A000MSG_A100_ERR_COD_RIMB_GIA_INS        = 'Codice rimborso già inserito!';
  A000MSG_A100_ERR_COD_VALUTA              = 'Il codice della valuta è errato!';
  A000MSG_A100_ERR_COEFF_CAMBIO            = 'Impossibile convertire l''importo, manca il coefficente di cambio!';
  A000MSG_A100_ERR_DATE_TRASFERTA_MESE_ANNO= 'Le date di trasferta devono appartenere allo stesso mese ed anno.';
  A000MSG_A100_ERR_INTERVALLO_DATE         = 'L''intervallo di date non è corretto.';
  A000MSG_A100_ERR_INTERVALLO_ORE          = 'L''intervallo di ore non è corretto.';
  A000MSG_A100_ERR_DATI_NON_SIGNIFICATIVI  = 'I dati inseriti non sono significativi!';
  A000MSG_A100_ERR_COD_RIMB_NON_ABIL       = 'Codice rimborso non abilitato per questa regola missione!';
  A000MSG_A100_ERR_DATA_DETT               = 'La data indicata per il dettaglio non è valida!';
  A000MSG_A100_ERR_DATA_DETT_MISSIONE      = 'La data indicata per il dettaglio deve essere compresa nel periodo della missione!';
  A000MSG_A100_ERR_NO_TIPO_DETT_MISSIONE   = 'Indicare il tipo di dettaglio!';
  A000MSG_A100_ERR_TIPO_DETT_MISSIONE      = 'Il tipo di dettaglio indicato non è valido!'#13#10'Indicare S (servizio attivo) oppure V (ore viaggio)';
  //A000MSG_A100_ERR_TIPO_DETT_MISSIONE_1GG  = 'Non è consentito indicare ore di viaggio per una missione di un giorno solo!';
  A000MSG_A100_ERR_ORA_INIZIO_ATTIVITA     = 'L''ora di inizio dell''attività è precedente all''ora di inizio della missione!';
  A000MSG_A100_ERR_ORA_FINE_ATTIVITA       = 'L''ora di fine dell''attività è successiva all''ora di fine della missione!';
  A000MSG_A100_ERR_NO_DATA_ATTIVITA        = 'Indicare la data dell''attività!';
  A000MSG_A100_ERR_NO_ORA_INIZIO_ATTIVITA  = 'Indicare l''ora di inizio dell''attività!';
  A000MSG_A100_ERR_NO_ORA_FINE_ATTIVITA    = 'Indicare l''ora di fine dell''attività!';
  A000MSG_A100_ERR_PERIODO_ATTIVITA        = 'Il periodo dell''attività non è corretto!';
  //A000MSG_A100_ERR_NOTE_ATTIVITA           = 'Indicare le note dell''attività';
  A000MSG_A100_ERR_DETT_SCAGLIONI          = 'Impossibile dettagliare il riborso pasto, se la regola prevede gli scaglioni cumulativi.';
  A000MSG_A100_ERR_DETT_NO_CODICE          = 'Indicare il codice del rimborso.';
  A000MSG_A100_ERR_DETT_ANTICIPO           = 'Non è possibile dettagliare un anticipo.';
  A000MSG_A100_ERR_DETT_IMP_RIMB           = 'Cancellare l''importo del rimborso prima di procedere al dettaglio.';
  A000MSG_A100_ERR_CANC_DETT               = 'Non è possibile eliminare l''elemento selezionato in quanto è stato generato dal programma';
  A000MSG_A100_ERR_MOD_DETT                = 'Non è possibile modificare l''elemento selezionato in quanto è stato generato dal programma';
  A000MSG_A100_ERR_TRASFERTA_PRESENTE      = 'Impossibile confermare l''operazione: esiste già una trasferta riferita al dipendente in oggetto con mese competenza, data ed ora inizio uguali a quelli indicati.';
  A000MSG_A100_ERR_DATA_MISS_SUCC          = 'Attenzione!' + #13#10 +
                                             'La data missione è successiva al mese di scarico, continuare nell''inserimento?';
  A000MSG_A100_ERR_INS_TRASFERTA           = 'Inserimento impossibile!!!' + #13#10 +
                                             'Esiste già una trasferta riferita al dipendente in oggetto con mese scarico, mese competenza, data inizio ed ora inizio uguali a quelli della missione che si sta tentando di inserire.';
  A000MSG_A100_ERR_REGOLE_TRASFERTA        = 'Regole trasferte non specificate nella maschera <A008> Gestione Aziende.';
  A000MSG_A100_ERR_KM_AUTOR_NEG            = 'Il numero di km autorizzati non può essere negativo!';
  A000MSG_A100_ERR_IMP_AUTOR_NEG           = 'L''importo autorizzato non può essere negativo!';
  A000MSG_A100_ERR_STATO_RIMBORSO          = 'Lo stato indicato non è valido.' + #13#10 +
                                             'Indicare S per confermare il rimborso.';
  A000MSG_A100_ERR_PAG_DEBIT               = 'Non è possibile eliminare la modalità di pagamento selezionata poichè è utilizzata dal programma.';
  A000MSG_A100_MSG_ANOMALIE                = 'Sono state riscontrate delle anomalie in fase di gestione automatica del giustificativo!';
  A000MSG_A100_MSG_IMP_RICALC              = 'L''importo relativo all''indennità di trasferta è stato ricalcolato in funzione della riduzione relativa al rimborso pasto.';
  A000MSG_A100_MSG_IMP_RICALC_CANC         = 'L''importo relativo all''indennità di trasferta è stato ricalcolato in funzione della cancellazione del rimborso pasto.';
  A000MSG_A100_ERR_FMT_REGOLE              = 'Regole non trovate per il dipendente e la tipologia di trasferta selezionati alla data %s.';
  A000MSG_A100_ERR_FMT_PERIODO_ATT_INTERS  = 'Il periodo dell''attività indicato interseca'#13#10'un periodo già esistente [%s]';
  //A000MSG_A100_ERR_PERIODO_ATT_DIVERSE     = 'Non è consentito inserire dettagli di servizio attivo'#13#10'e di viaggio nello stesso giorno!';
  A000MSG_A100_MSG_ELENCO_COMUNI           = '<A100> Selezione del comune missioni/trasferte';
  A000MSG_A100_MSG_FMT_TRASFERTA_COMPRESA  = 'Esiste già %s trasferta/e comprese nel periodo indicato.'#13#10'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_COMPRENDE = 'Esiste già %s trasferta/e che comprende il periodo indicato.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_PERIODO   = 'Esiste già %s trasferta/e per il periodo indicato.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_PERIODO_PARZ = 'Esiste già %s trasferta/e che comprende in parte il periodo indicato.' + #13#10 +
                                               'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_DATA      = 'Esiste %s trasferta/e che inizia in data %s e termina in data %s.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_TERMINA   = 'Esiste già una trasferta che termina in data %s.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_INIZIA    = 'Esiste già una trasferta che inizia in data %s.' + #13#10 +
                                             'Si desidera continuare ugualmente?';

  A000MSG_A100_MSG_COLLEGA_ANTICIPI        = 'Collegare la missione con questi Anticipi?' + #13#10#13#10;
  A000MSG_A100_MSG_FMT_ANTICIPO_COLL       = 'Codice: %s, Importo: $s €' + #13#10 +
                                             '------------------------------------------' + #13#10;
  A000MSG_A100_MSG_FMT_ANT_REGOLA          = 'L''Anticipo ''%s'' non può essere collegato con questa missione,' + #13#10 +
                                             'poichè la regola assegnata alla missione non lo permette.' + #13#10;
  A000MSG_A100_MSG_FMT_VOCE_NO_RIMB        = 'Cod. Voce: %s' +  #13#10 +
                                             'non è registrato come rimborso.' + #13#10 +
                                             '------------------------------------------' + #13#10;
  A000MSG_A100_MSG_ANT_GIA_INS             = 'Anticipo già inserito:' + #13#10#13#10;
  A000MSG_A100_MSG_FMT_SOSP                = 'Numero sospeso: %s, Data Missione: %s, Importo: %s €' + #13#10 +
                                             '------------------------------------------' + #13#10;

  A000MSG_A100_MSG_FMT_RICALCOLO           = 'Saranno ricalcolate le indennità chilometriche di tutte le missioni riferite ai dipendenti selezionati e con mese di scarico compreso tra: %s e %s.' + #13#10 +
                                             'Si desidera continuare ?';

  A000MSG_A100_MSG_KM_AUTOR                = 'Il numero di km autorizzati è maggiore di quello richiesto.' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_A100_MSG_IMP_AUTOR               = 'L''importo del rimborso autorizzato è maggiore di quello richiesto.' + #13#10 +
                                             'Vuoi continuare?';

  A000MSG_A104_ERR_NO_TRASF                = 'Nessuna trasferta trovata nel periodo indicato per i dipendenti selezionati.';

  A000MSG_A105_ERR_NO_CAUSALE              = 'Nessuna causale selezionata';

  A000MSG_A106_MSG_PARTENZA                = 'Località partenza';
  A000MSG_A106_MSG_DESTINAZIONE            = 'Località destinazione';
  A000MSG_A106_ERR_DUPLICAZIONE            = 'Inserimento non consentito.' + #13#10 +
                                             'Distanza chilometrica già esistente.';
  A000MSG_A106_ERR_CHILOMETRI              = 'Indicare una distanza chilometrica valida';
  A000MSG_A106_ERR_LOCALITA                = 'Indicare una destinazione diversa dalla partenza';
  A000MSG_A106_ERR_LOCALITA_CODICE         = 'Indicare il codice della località personalizzata!';
  A000MSG_A106_ERR_LOCALITA_DESCRIZIONE    = 'Indicare la descrizione della località personalizzata!';
  A000MSG_A106_ERR_LOCALITA_COMUNE         = 'Indicare il comune della località personalizzata!';

  A000MSG_A108_ERR_MESE                    = 'Il mese specificato non è corretto!';
  A000MSG_A108_ERR_FMT_INSERIMENTO         = '%s  %s';
  A000MSG_A108_ERR_FMT_ORE_SCOPERTE        = '%s  %s ore scoperte';

  A000MSG_A109_MSG_IMMAGINE_NON_VALIDA     = 'Attenzione! Il formato dell''immagine selezionata non è valido.' + #13#10 +
                                             'E'' possibile selezionare solo immagini bmp (bitmap).';
  A000MSG_A109_MSG_ELIMINA_IMG             = 'Eliminare l''immagine corrente?';

  A000MSG_A110_MSG_CODICE                  = 'Codice';
  A000MSG_A110_MSG_TIPO_MISSIONE           = 'Tipo missione';
  A000MSG_A110_MSG_DESC_REGOLA             = 'Descrizione regola';
  A000MSG_A110_MSG_TAR_IND_INT             = 'Tariffa di indennità intera';
  A000MSG_A110_MSG_ORE_MIN_IND             = 'Ore minime di indennità intera';
  A000MSG_A110_MSG_TIPO_TAR_IND_INT        = 'Tipo tariffa di indennità intera';
  A000MSG_A110_MSG_TIPO_ARR_ORE            = 'Tipo arrotondamento ore';
  A000MSG_A110_MSG_ARR_TOT_ORE             = 'Arrotondamento totale importi per dati paghe';
  A000MSG_A110_MSG_ARR_TAR_RID             = 'Arrotondamento tariffa dopo riduzione';
  A000MSG_A110_MSG_ORE_RETR_INT            = 'Limite delle ore retribuite intere';
  A000MSG_A110_MSG_LIM_GG_RET_MESE         = 'Limite dei giorni retribuiti interi nel mese;';
  A000MSG_A110_MSG_PERC_RIMB_PASTO         = 'Percentuale di retribuzione al rimborso del pasto';
  A000MSG_A110_MSG_PERC_SUP_ORE            = 'Percentuale di retribuzione dopo il supero ore';
  A000MSG_A110_MSG_PERC_SUP_GG             = 'Percentuale di retribuzione dopo il supero giorni';
  A000MSG_A110_MSG_SELEZIONATO             = 'Selezionato';
  A000MSG_A110_DLG_ALTRE_REGOLE            = 'Confermando l''operazione sui mesi di rimborso, si andranno a modificare ' + #13#10 +
                                             'anche le altre regole con la medesima data di decorrenza e codice missione.';
  A000MSG_A110_DLG_FMT_INTERSEC_DECORRENZA = 'Attenzione! La data decorrenza inserita interseca il periodo %s - %s.' + #13#10 +
                                             'Continuare?';
  A000MSG_A110_ERR_24H                     = 'Attenzione! Non è possbile inserire una soglia superiore alle 24 ore.';
  A000MSG_A110_ERR_INCOMPLETI              = 'Dati incompleti.';
  A000MSG_A110_ERR_ARROT_ORE               = 'Indicare un valore maggiore o uguale ad 1 per il campo arrotondamento ore!';
  A000MSG_A110_ERR_ARROT_ORE_DIV           = 'Il valore per l''arrotondamento dell'' ora deve essere maggiore o uguale a 1 o un divisore di 60.';
  A000MSG_A110_ERR_NOT_ASSIGNED            = 'Funzione lettura data decorrenza non impostata';
  A000MSG_A110_ERR_IND_KM                  = 'Indicare il codice di indennità km se si attiva il rimborso chilometrico automatico';

  A000MSG_A111_ERR_NO_DV                   = 'Impossibile specificare record DF senza record DV!';
  A000MSG_A111_ERR_FILTRO_ANAGRAFICO       = 'Filtro anagrafico non valido!';
  A000MSG_A111_ERR_CAMBIO_NUM_RECORD_DF    = 'Per il tipo record DF il numero record non può cambiare';
  A000MSG_A111_ERR_NUM_RECORD              = 'Numero record specificato invalido';
  A000MSG_A111_ERR_RECORD_ACCAVALLATI      = 'Posizione/Lunghezza invalidi (record DV accavallato a record DF)';
  A000MSG_A111_ERR_NOME_COLONNA_DUPLICATO  = 'Nome colonna non valido (duplicato)!';
  A000MSG_A111_ERR_INCONGRUENZA_DV_DF      = 'Incongruenza su colonne tra record DV e record DF!';
  A000MSG_A111_ERR_NOME_CAMPO_DUPLICATO    = 'Nomi campi non univoci';
  A000MSG_A111_ERR_CAMPI_ACCAVALLATI       = 'Posizione/Lunghezza invalidi (campi che si accavallano)';
  A000MSG_A111_ERR_CAMPI_NON_CONTIGUI      = 'Campi non contigui!';
  A000MSG_A111_ERR_AGG_CODICE              = 'AGGIORNAMENTO CODICE IN PARAMETRIZZAZIONE FALLITO';
  A000MSG_A111_ERR_TIPO_COLONNA_RECORD     = 'Tipo colonna specificato non valido per questo tipo record!';
  A000MSG_A111_ERR_LUNGHEZZA_DIVERSA       = 'Lunghezza specificata diversa dalla lunghezza del Formato!';
  A000MSG_A111_ERR_LUNGHEZZA_MINORE        = 'Lunghezza specificata minore della lunghezza del Default!';
  A000MSG_A111_ERR_TIPO_RECORD_FILE        = 'Tipo Record non valido per questo tipo di file!';
  A000MSG_A111_ERR_TIPO_RECORD             = 'Tipo Record non valido!';
  A000MSG_A111_ERR_TIPO_COLONNA            = 'Tipo Colonna non valido!';
  A000MSG_A111_ERR_POSIZIONE               = 'Posizione non valida!';
  A000MSG_A111_ERR_LUNGHEZZA               = 'Lunghezza non valida!';
  A000MSG_A111_ERR_NOME_COLONNA            = 'Nome colonna non valido!';
  A000MSG_A111_ERR_FORMATO                 = 'Formato non valido per questo tipo colonna!';
  A000MSG_A111_ERR_NO_FORMATO              = 'Colonna senza Formato specificato!';
  A000MSG_A111_ERR_SVUOTA_FORMATO          = 'Per questo tipo colonna il Formato non deve essere specificato!';
  A000MSG_A111_ERR_NO_DEFAULT              = 'Nei file elaborabili in batch per questo tipo colonna il Default deve essere specificato!';
  A000MSG_A111_ERR_DEFAULT                 = 'Valore di default non valido per questo tipo colonna!';
  A000MSG_A111_ERR_SVUOTA_DEFAULT          = 'Per questo tipo colonna il valore di Default non deve essere specificato!';

  A000MSG_A112_DLG_NO_ANAGRAFICHE          = 'ATTENZIONE: Nessuna anagrafica selezionata! Continuare?';
  A000MSG_A112_ERR_NO_SELEZIONE            = 'ATTENZIONE: Nessuna selezione disponibile!';
  A000MSG_A112_DLG_FMT_ESEGUI              = 'Eseguire l''elaborazione per %s anagrafiche?';
  A000MSG_A112_DLG_SOVRASCRIVI_MSG         = 'Attenzione: messaggio già esistente per la matricola selezionata! Sovrascrivere il messaggio?';
  A000MSG_A112_ERR_DEFAULT                 = 'Valore specificato non valido: scegliere tra la lista dei valori possibili!';
  A000MSG_A112_ERR_FMT_CARATTERI           = 'Il numero di caratteri disponibili è %s!';

  A000MSG_A116_ERR_ANNO_RIF_PREC           = 'L''anno di riferimento deve essere l''anno precedente o due anni precedenti rispetto alla data di liquidazione!';
  A000MSG_A116_DLG_FMT_CANCELLA            = 'Sei sicuro di voler procedere alla cancellazione delle liquidazioni/abbattimenti ore residue riferite all''anno %s effettuate a %s?';

  A000MSG_A117_ERR_ANNO_RIF_PREC           = 'L''anno di riferimento non può essere successivo rispetto alla data di liquidazione!';
  A000MSG_A117_ERR_ANNO_RIF_SUCC           = 'L''anno di riferimento deve essere antecedente all''anno della data di liquidazione!';
  A000MSG_A117_ERR_VARIAZ_ORE              = 'La variazione delle ore perse può essere solo negativa!';
  A000MSG_A117_ERR_LIQ_GIA_REGISTRATA      = 'Liquidazione già registrata; agire su diverso anno di riferimento o mese di liquidazione!';
  A000MSG_A117_ERR_NO_TIPOLOGIA            = 'Selezionare almeno una tipologia di trasferta!';

  A000MSG_A119_ERR_DATA_OBBL               = 'E'' necessario specificare la data';
  A000MSG_A119_ERR_FMT_DATA_ESISTENTE      = 'In archivio è già presente un altro evento'#13#10'di sciopero per il giorno %s.'#13#10'Impossibile confermare!';
  A000MSG_A119_ERR_DAORE_OBBL              = 'E'' necessario specificare il dato "da ore"';
  A000MSG_A119_ERR_AORE_OBBL               = 'E'' necessario specificare il dato "a ore"';
  A000MSG_A119_ERR_FMT_SELANAGRAFE         = 'La selezione anagrafica indicata non è valida:'#13#10'%s';
  A000MSG_A119_ERR_FMT_CAUS_TIPOFRUIZ      = 'La causale selezionata "%s" non è fruibile %s';
  A000MSG_A119_ERR_CANC                    = 'Sono presenti schede di notifica di adesione'#13#10'per l''evento di sciopero selezionato.'#13#10'Cancellazione impossibile!';
  A000MSG_A119_ERR_MOD                     = 'Sono presenti schede di notifica di adesione'#13#10'per l''evento di sciopero selezionato.'#13#10'Modifica impossibile!';
  A000MSG_A119_ERR_FMT_BLOCCO_RIEP         = 'Attenzione!'#13#10'Non è possibile effettuare l''importazione dei giustificativi,'#13#10'in quanto per i seguenti dipendenti è attivo il blocco'#13#10'dei riepiloghi [T040] per il mese di %s:'#13#10'%s';
  A000MSG_A119_ERR_FMT_TIPO_RICH           = 'Errore durante la lettura del tipo richiesta per ID = %d';

  A000MSG_A121_DLG_CANCELLA_PARTECIPANTI   = 'Attenzione: verranno cancellati anche partecipazioni e permessi dell''organismo selezionato! ' +  #13#10 +
                                             'Confermi cancellazione?';
  A000MSG_A121_DLG_CANCELLA_RECAPITI       = 'Attenzione: verranno cancellati anche recapiti, competenze, iscrizioni, partecipazioni e permessi del sindacato selezionato! ' + #13#10 +
                                             'Confermi cancellazione?';

  A000MSG_A122_ERR_COD_SINDACATO           = 'Codice sindacato non valido!';

  A000MSG_A123_ERR_COD_SINDACATO           = 'Codice sindacato non valido!';
  A000MSG_A123_ERR_COD_ORGANISMO           = 'Codice organismo non valido!';

  A000MSG_A124_MSG_NO_COMP_CONTRATTO       = 'Comp. non specificate sul contratto del dip.corrente!';
  A000MSG_A124_ERR_FMT_PERM_CANCELLATO     = 'Impossibile %s un permesso CANCELLATO!';
  A000MSG_A124_ERR_STESSO_ANNO             = 'Le date devono afferire allo stesso anno!';
  A000MSG_A124_ERR_NO_DALLE                = 'Specificare il dato "num.Ore"!';
  A000MSG_A124_ERR_NO_DALLE_ALLE           = 'Specificare l''intervallo "da Ore" / "a Ore"!';
  A000MSG_A124_ERR_NO_ORE                  = 'Non è possibile calcolare le "Ore tot." di permesso!';
  A000MSG_A124_ERR_NO_SINDACATO            = 'Specificare il "Sindacato"!';
  A000MSG_A124_ERR_NO_ORGANISMO            = 'Specificare l''"Organismo"!';
  A000MSG_A124_ERR_NO_NUM_PROTOCOLLO       = 'Specificare il numero protocollo!';
  A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE     = '"a Ore" deve essere superiore a "da Ore"!';
  A000MSG_A124_DLG_FMT_INS_PERMESSO        = 'Confermi l''inserimento del permesso per i dipendenti selezionati (%s)?';
  A000MSG_A124_MSG_FMT_PERMESSI_INSERITI   = 'Elaborazione terminata: sono stati inseriti %s permessi!';
  A000MSG_A124_DLG_FMT_STATO_CANC_PERMESSO = 'Confermi il passaggio allo stato CANCELLATO del permesso per i dipendenti selezionati (%s)?';
  A000MSG_A124_MSG_FMT_PERMESSI_STATO_CANC = 'Elaborazione terminata: sono stati aggiornati allo stato CANCELLATO %s permessi!';
  A000MSG_A124_DLG_FMT_CANC_PERMESSO       = 'Confermi la cancellazione del permesso per i dipendenti selezionati (%s)?';
  A000MSG_A124_MSG_FMT_PERMESSI_CANCELLATI = 'Elaborazione terminata: sono stati cancellati %s permessi!';
  A000MSG_A124_MSG_ANOMALIE                = 'Attenzione: sono state riscontrate delle anomalie durante l''elaborazione!' + #13#10 + '(Premere il pulsante Anomalie per visualizzarle)';
  A000MSG_A124_ERR_FMT_ORGANISMO_NO_CAUS   = 'L''organismo %s non è associato ad alcuna causale di assenza!';
  A000MSG_A124_ERR_COMP_SUPERATE           = 'Sono state superate le competenze del sindacato!';
  A000MSG_A124_ERR_INSERIMENTO             = 'Inserimento impossibile';
  A000MSG_A124_ERR_PERMESSO_ESISTE         = 'permesso già esistente alla data indicata!';
  A000MSG_A124_ERR_PERMESSO_INTERSECA      = 'intersezione con permesso già esistente!';
  A000MSG_A124_ERR_FMT_DATI_ANAGRAFICI     = 'Non è possibile estrarre i dati anagrafici! (%s)';
  A000MSG_A124_ERR_FMT_DATO_AZIENDALE      = 'Il campo indicato nel dato aziendale "%s" non è valido!';
  A000MSG_A124_ERR_FMT_DATO_AZ_VUOTO       = 'Non è stato specificato il dato aziendale "%s"!';
  A000MSG_A124_ERR_FMT_CAMPO_VUOTO         = 'Campo "%s" non valorizzato!';
  A000MSG_A124_ERR_FMT_CAMPO_VUOTO_DATA    = 'Campo "%s" non valorizzato alla data del permesso %s!';
  A000MSG_A124_ERR_FMT_QUALIFICA_NUMERICA  = 'Qualifica "%s" non convertibile in dato numerico!';
  A000MSG_A124_ERR_FMT_ESITO_NEGATIVO_WS   = 'Esito negativo: %s';
  A000MSG_A124_ERR_FMT_RICHIAMO_WS         = 'Errore nel richiamo al WebService! %s';
  A000MSG_A124_ERR_NO_CALCOLO_ORE_FRUITE   = 'Permesso non inviato perché non possono essere calcolate le ore fruite!';

  A000MSG_A126_ERR_NO_RIEPILOGO            = 'Nessun riepilogo selezionato';
  A000MSG_A126_ERR_DATA_CASSA_ANTE         = 'Non si può utilizzare una data di cassa antecedente a quella effettiva!';
  A000MSG_A126_DLG_CASSA_SUCCESSIVA        = 'Selezionare la data di cassa successiva?';
  A000MSG_A126_DLG_CASSA_PRECEDENTE        = 'Selezionare la data di cassa antecedente?';
  A000MSG_A126_DLG_ANNULLA_CASSA           = 'ATTENZIONE!' + #13#10 +
                                             'Annullando la data di cassa utilizzata' + #13#10 +
                                             'sarà possibile modificarla direttamente in fase di Scarico Paghe.' + #13#10 +
                                             'Annullare la data di cassa?';
  A000MSG_A126_DLG_FMT_BLOCCO              = 'ATTENZIONE!' + #13#10 + #13#10 +
                                             'Verranno bloccati i riepiloghi specificati per tutti i dipendenti selezionati.' + #13#10 +
                                             'Al termine dell''operazione non sarà più possibile modificare i dati.' + #13#10 +
                                             'I record da inserire sono %s' + #13#10 +
                                             'Continuare?';
  A000MSG_A126_DLG_FMT_SBLOCCO             = 'ATTENZIONE!' + #13#10 + #13#10 +
                                             'Verranno sbloccati i riepiloghi specificati per tutti i dipendenti selezionati.' + #13#10 +
                                             'Al termine dell''operazione sarà nuovamente possibile modificare i dati.' + #13#10 +
                                             'I record da cancellare sono %s' + #13#10 +
                                             'Continuare?';
  A000MSG_A126_DLG_FMT_ELIMINA_DATA_CASSA  ='ATTENZIONE!!' + #13#10 + #13#10 +
                                            'Ultima data di cassa: %s' + #13#10 +
                                            'Voci scaricate riferite al periodo da %s a %s' + #13#10 +
                                            'Righe: %d' + #13#10 +
                                            'Eliminare questi dati dalla tabella delle Voci Variabili?' + #13#10;

  A000MSG_A128_ERR_DATA_ESTERNA_MESE       = 'La data specificata deve essere compresa nel mese di competenza!';
  A000MSG_A128_ERR_FMT_COD_NON_VALIDO      = '%s non valido!';
  A000MSG_A128_ERR_NO_TURNO_1              = 'E'' necessario specificare il 1° turno!';
  A000MSG_A128_ERR_ESISTE_PIANIFICAZIONE   = 'Pianificazione già esistente!';
  A000MSG_A128_ERR_TURNO_RIPETUTO          = 'Il dipendente non può fare due volte lo stesso turno!';
  A000MSG_A128_DLG_TURNO_NO_PARTTIME       = 'Confermi la pianificazione di un turno incompatibile con dipendente part-time?';
  A000MSG_A128_ERR_FMT_PATH_ERRATO         = 'Il percorso del file di acquisizione dei turni di prestazioni aggiuntive %s non è corretto o il file è inesistente.';
  A000MSG_A128_ERR_CREA_FILE_APPOGGIO      = 'Impossibile creare il file di appoggio!';
  A000MSG_A128_ERR_CREA_FILE_BACKUP        = 'Impossibile creare il file di salvataggio!';
  A000MSG_A128_ERR_FMT_DATO_ERRATO         = 'Dato non numerico nella colonna numero %s. Correggere.';
  A000MSG_A128_ERR_FMT_DATO_NEGATIVO       = 'Dato minore di zero nella colonna numero %s. Correggere.';
  A000MSG_A128_ERR_FMT_POSIZIONE_ERRATA    = 'La posizione nella colonna numero %s non è consecutiva alla definizione della colonna precedente non impostata a zero. Correggere.';
  A000MSG_A128_ERR_FMT_ACQ_NO_MATRICOLA          = 'Riga n. %s : %s - Matricola non indicata.';
  A000MSG_A128_ERR_FMT_ACQ_NO_FMT_DATA           = 'Riga n. %s : %s - Formato della data errato.';
  A000MSG_A128_ERR_FMT_ACQ_DATA_INCOMPLETA       = 'Riga n. %s : %s - Data incompleta.';
  A000MSG_A128_ERR_FMT_ACQ_DATA_ESTERNA          = 'Riga n. %s : %s - Data %s fuori dal periodo di acquisizione.';
  A000MSG_A128_ERR_FMT_ACQ_NO_TURNO              = 'Riga n. %s : %s - Almeno uno tra codice turno e fascia oraria dev''essere indicato affinchè il record sia valido.';
  A000MSG_A128_ERR_FMT_ACQ_TURNO_INESISTENTE     = 'Riga n. %s : %s - Codice turno %s inesistente.';
  A000MSG_A128_ERR_FMT_ACQ_DIP_PARTTIME          = 'Riga n. %s : %s - Matricola %s dipendente part-time. Assegnato turno non compatibile. Verificare ed eventualmente rimuovere manualmente la pianificazione.';
  A000MSG_A128_ERR_FMT_ACQ_MATR_INESISTENTE      = 'Riga n. %s : %s - La matricola %s non risulta presente in anagrafico.';
  A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO     = 'Riga n. %s : %s - Per la matricola %s il turno %s risulta già pianificato nel giorno %s.';
  A000MSG_A128_ERR_FMT_ACQ_TROPPI_TURNI          = 'Riga n. %s : %s - Per la matricola %s esistono già due turni pianificati nel giorno %s.';
  A000MSG_A128_ERR_FMT_ACQ_ORARIO_NON_VALIDO     = 'Riga n. %s : %s - L''orario "%s" impostato per il "%d° Turno" non è valido.';
  A000MSG_A128_ERR_FMT_ACQ_TURNO_ORARIO          = 'Riga n. %s : %s - Non è possibile importare una fascia oraria quando è già specificato un codice turno.';
  A000MSG_A128_ERR_FMT_ACQ_NO_ORARIO             = 'Riga n. %s : %s - Fascia oraria non correttamente valorizzata.';
  A000MSG_A128_ERR_FMT_ACQ_DB_TURNO_NON_NULLO    = 'Riga n. %s : %s - Codice turno non nullo a DB con fascia oraria in input.';
  A000MSG_A128_ERR_FMT_ACQ_DB_ORARIO_NON_NULLO   = 'Riga n. %s : %s - Fascia oraria non nulla a DB con codice turno in input.';
  A000MSG_A128_ERR_FMT_ACQ_ORA_INTERSEZIONE      = 'Riga n. %s : %s - Gli orari dei due turni si intersecano fra di loro.';
  A000MSG_A128_ERR_TURNO_NON_VALIDO        = 'Il "%d° Turno" non è valorizzato correttamente. Correggere.';
  A000MSG_A128_ERR_ORA_INTERSEZIONE        = 'Gli orari inseriti si intersecano fra loro. Correggere.';
  A000MSG_A128_ERR_GESIONE_PER_TURNI       = 'Non è possibile applicare una fascia oraria perché sul "%d° Turno" è già presente una gestione per codice turno. Correggere.';

  A000MSG_A130_DLG_FMT_APPLICA_MODIFICHE   = 'Applicare le modifiche?'#13#10+
                                             'Dalla data: %s alla data %s: '+#13#10+
                                             'dalle ore: %s alle ore %s: ' + #13#10;
  A000MSG_A130_DLG_SALVA_INTESTAZIONE      = 'Salvare anche l''intestazione delle colonne?';

  A000MSG_A131_MSG_CASSA                   = 'cassa';
  A000MSG_A131_MSG_ANNO_MOVIMENTO          = 'anno movimento';
  A000MSG_A131_MSG_NUMERO_MOVIMENTO        = 'numero movimento';
  A000MSG_A131_MSG_DATA_MOVIMENTO          = 'data del movimento';
  A000MSG_A131_MSG_DATA_MISSIONE           = 'data della missione';
  A000MSG_A131_MSG_CODICE_VOCE             = 'codice voce';
  A000MSG_A131_DLG_FMT_STATO               = 'Attenzione, ponendo lo stato dell''anticipo a %s' + #13#10+
                                             ', successivamente non sarà più modificabile, a causa delle autorizzazioni dell''operatore.'+ #13#10 +
                                             'Continuare?';
  A000MSG_A131_DLG_COLLEGA                 = 'Collegare gli anticipi con la missione?';
  A000MSG_A131_ERR_FMT_COD_ANT             = 'Nessun anticipo con il codice  "%s," inesistente nell''array locale.';
  A000MSG_A131_ERR_FMT_ANT_REGOLA          = 'L''Anticipo "%s" non può essere collegato con questa missione,' + #13#10 +
                                             'poichè la regola assegnata alla missione non lo permette.';
  A000MSG_A131_ERR_FMT_ANT_RIMB            = 'Codice Voce "%s" non riconosciuto come rimborso.' + #13#10 +
                                             'Per collegarlo all''anticipo inserirlo prima dall'' apposita maschera "Tipi Rimborsi".';
  A000MSG_A131_ERR_FMT_ANT_NO_ANT          = 'Il collegamento con la missione non può avvenire, in quanto l''anticipo "%s" non è  classificato come tale.';
  A000MSG_A131_ERR_FMT_RIMB_GIA_SOMMA      = 'Rimborso "%s" già esistente!, l''importo è stato sommato al rimborso già esistente.';
  A000MSG_A131_ERR_NO_ANT                  = 'Non ci sono anticipi da inserire.';
  A000MSG_A131_ERR_NO_MISSIONE             = 'Selezionare la missione.';

  A000MSG_A133_MSG_COD_TARIFFA             = 'Codice tariffa';

  A000MSG_A136_MSG_COMPONI_PENDING         = 'Attenzione! La composizione relazione è stata modificata. Confermare o annullare le modifiche apportate!';
  A000MSG_A136_ERR_TAB_DIVERSE             = 'La tabella di origine non può essere diversa da quella del dato pilotato se la relazione è di tipo filtrato (F)!';
  A000MSG_A136_ERR_UTENTE_NO_TABELLA       = 'Profilo utente non abilitato alla creazione di una relazione con la tabella pilota(/origine) selezionata!';
  A000MSG_A136_ERR_UTENTE_NO_CAMPO         = 'Profilo utente non abilitato alla creazione di una relazione con il campo selezionato!';
  A000MSG_A136_ERR_UTENTE_NO_DELETE        = 'Profilo utente non abilitato alla cancellazione di una relazione con il campo selezionato!';
  A000MSG_A136_ERR_TABELLA_COLONNA         = 'Impostare correttamente la tabella e la colonna di partenza oppure svuotarle entrambe!';
  A000MSG_A136_DLG_RELAZ_NO_STANDARD       = 'Attenzione! La relazione non è standard; non è quindi possibile procedere con l''abbinamento automatico. Continuare?';
  A000MSG_A136_DLG_RELAZ_NO_PILOTA         = 'Attenzione! Impossibile caricare i dati dalla colonna pilota specificata; non è quindi possibile procedere con l''abbinamento automatico. Continuare?';
  A000MSG_A136_DLG_VALORI_DUPLICATI        = 'Attenzione! Valori pilotati duplicati. Verranno persi alcuni abbinamenti. Continuare?';
//  A000MSG_A136_DLG_NO_DATI_PILOTA        = 'Attenzione! Impossibile caricare i dati dalla colonna pilota specificata; non è quindi possibile procedere con l''abbinamento automatico. Continuare?';
  A000MSG_A136_DLG_MODIFICHE               = 'Attenzione! Confermare le modifiche effettuate alla relazione?';
  A000MSG_A136_NO_RELAZIONI_ELAB           = 'Non ci sono relazioni da elaborare!';
  A000MSG_A136_NO_DATA                     = 'Impostare una data di riferimento!';
  A000MSG_A136_ERR_TABELLA                 = 'Selezionare la tabella tra l''elenco di valori disponibili!';
  A000MSG_A136_ERR_COLONNA_PARTENZA        = 'Selezionare la colonna di partenza tra l''elenco di valori disponibili!';
  A000MSG_A136_ERR_COLONNA_ARRIVO          = 'Selezionare la colonna di arrivo tra l''elenco di valori disponibili!';
  A000MSG_A136_ERR_TIPO                    = 'Selezionare almeno un tipo di relazione!';
  A000MSG_A136_ERR_FMT_RANGE_LIVELLI       = 'Selezionare un numero di livelli compreso tra %s e %s!';

  A000MSG_A137_MSG_FMT_NO_LOC_PART         = '%10s - Dipendente senza località di partenza anagrafica';
  A000MSG_A137_MSG_FMT_NO_RILEVATORE       = '%10s - Timbrature senza rilevatore';
  A000MSG_A137_MSG_FMT_RIL_NO_LOC          = '%10s - Rilevatore %-2s senza dati per località';
  A000MSG_A137_MSG_FMT_DIST_NO_IMP         = '%10s - Km di distanza non impostati tra %-6s (%-13s) e %-6s (%-13s)';
  A000MSG_A137_MSG_NO_KM_PERCORSI          = 'Fine mese  - Km percorsi calcolati nel mese: 0';
  A000MSG_A137_MSG_FMT_GIA_ESISTE          = '%-8s %-40s %10s - Impossibile inserire la testata della trasferta perché esiste già un record con Mese scarico %s e Data/Ora inizio %s 00.00';
  A000MSG_A137_MSG_FMT_INS_IND_KM          = '%-8s %-40s %10s - Impossibile inserire l''indennità chilometrica';
  A000MSG_A137_MSG_FMT_UPD_IND_KM          = '%-8s %-40s %10s - Impossibile aggiornare l''indennità chilometrica';

  A000MSG_A141_ERR_FMT_GIUST_NO_GIORN      = 'Giustificativo %s non inseribile a giornate intere!';
  A000MSG_A141_DLG_NO_RIPOSO               = 'Attenzione: causale di Riposo con raggruppamento diverso da Riposo! Continuare?';
  A000MSG_A141_DLG_NO_RIPOSO_COMP          = 'Attenzione: causale di Riposo comp. con raggruppamento diverso da Riposo/Rip.comp.! Continuare?';

  A000MSG_A145_DLG_FMT_ANNULLAMENTO        = 'Confermi l''annullamento dell''ultima comunicazione' + #13#10 +
                                             'presente in archivio (%s)?';
  A000MSG_A145_DLG_COM_PREC_SYSDATE        = 'Attenzione:' + #13#10 +
                                             'La data della comunicazione indicata è antecedente a quella odierna.' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_A145_DLG_AGGIORNAMENTO           = 'Confermi l''aggiornamento?';
  A000MSG_A145_DLG_AGGIORNAMENTO_MED_LEG   = 'Attenzione:' + #13#10 +
                                             'La comunicazione sarà resa effettiva per la sola medicina legale selezionata.' + #13#10 +
                                             'Confermi l''aggiornamento?';
  A000MSG_A145_DLG_ESENZ_NON_LAV           = 'Attenzione: il periodo di assenza comprende giornate precedenti o successive a quelle non lavorative: confermi comunque l’esenzione?';

  A000MSG_A145_MSG_FMT_CONFERMA_ANNULLAMENTO='La comunicazione del %s è stata annullata!';
  A000MSG_A145_ERR_DATA_ELAB               = 'La data di elaborazione non è valida!';
  A000MSG_A145_ERR_TIPO_OPERAZIONE         = 'Selezionare almeno un tipo di operazione da elaborare!';
  A000MSG_A145_ERR_NO_LOGO_LARG            = 'Indicare la larghezza del logo in pixel!';
  A000MSG_A145_ERR_LOGO_LARG               = 'Indicare un valore valido per la larghezza del logo!';
  A000MSG_A145_ERR_NO_NUM_PROT             = 'Indicare il numero di protocollo!';
  A000MSG_A145_ERR_NO_LUOGO                = 'Indicare il luogo di stampa!';
  A000MSG_A145_ERR_DATA_INIZIO_PERIODO     = 'La data di inizio periodo non è valida!';
  A000MSG_A145_ERR_DATA_FINE_PERIODO       = 'La data di fine periodo non è valida!';
  A000MSG_A145_ERR_PERIODO                 = 'Il periodo indicato non è valido!';
  A000MSG_A145_ERR_COM_PRECEDENTE          = 'Impossibile creare una comunicazione in data precedente all''ultima' + #13#10 +
                                             'comunicazione effettuata (%s).';
  A000MSG_A145_ERR_NO_ASSENZA              = 'Nessuna assenza presente nel periodo indicato!';
  A000MSG_A145_ERR_NO_PERIODO_ASSENZA      = 'Nessun periodo di assenze da comunicare per la data indicata!';

  A000MSG_A145_ERR_FMT_ESTR_DOM            = 'Anomalia durante l''estrazione dei dati di domicilio:' + #13#10 +
                                              '%s/%s';

  A000MSG_A147_ERR_NO_TURNI                = 'Specificare i turni vincolanti!';
  A000MSG_A147_DATA_COMPRESA               = 'La data indicata deve essere compresa nel periodo del vincolo corrente!';
  A000MSG_A147_DLG_CANC_SELEZ              = 'Eliminare la pianificazione corrente da tutti i dipendenti selezionati?';
  A000MSG_A147_DLG_INS_SELEZ               = 'Copiare la pianificazione corrente sugli altri dipendenti selezionati?';

  A000MSG_A150_DLG_INSERISCI               = 'Confermi l''inserimento delle assenze selezionate ?';
  A000MSG_A150_DLG_CANCELLAZIONE           = 'Confermi la cancellazione di TUTTE le causali di assenza di questo accorpamento?';
  A000MSG_A150_ERR_ACCORPAMENTO_WEB        = 'Non è possibile creare più di un accorpamente WEB.';
  A000MSG_A150_ERR_CANC_ACCORPAMENTO       = 'Impossibile cancellare un accorpamento con causali di assenza specificate!';

  A000MSG_A151_MSG_ELAB_PRESENZE           = 'Elaborazione dati di presenza in corso...premere Esc per interrompere';
  A000MSG_A151_MSG_ELAB_ASSENZE            = 'Elaborazione dati di assenza in corso...premere Esc per interrompere';
  A000MSG_A151_MSG_ELAB_TOTALI             = 'Totalizzazione in corso...';
  A000MSG_A151_DLG_GENERA_TABELLA          = 'Confermi la generazione della tabella per il periodo indicato, per i dipendenti selezionati?';
  A000MSG_A151_ERR_FMT_DIP_NON_PRES        = 'Il dipendente non è presente nella tabella %s';
  A000MSG_A151_ERR_NO_STAMPA               = 'Specificare la stampa del generatore di stampe!';
  A000MSG_A151_ERR_NO_TIPO_ACCORP          = 'Specificare il tipo di accorpamento causali di assenza da considerare!';
  A000MSG_A151_ERR_NO_COD_ACCORP           = 'Specificare i codici accorpamento da considerare!';
  A000MSG_A151_ERR_NO_COLONNE              = 'Selezionare almeno una colonna di elaborazione!';
  A000MSG_A151_ERR_NO_RIGHE                = 'Selezionare almeno una riga di raggruppamento!';
  A000MSG_A151_ERR_FMT_RIGENERA_TABELLA    = 'La tabella %s non contiene dati riferiti al periodo indicato. Rigenerare la tabella!';
  A000MSG_A151_MSG_FINI_L104               = 'Ai fini della legge 104/1992, ';
  A000MSG_A151_ERR_FMT_NO_DATO_TABELLA     = 'Il dato %s non è presente nella tabella %s';
  A000MSG_A151_ERR_FMT_ESPRESSIONE_DATO    = 'L''espressione del dato %s non è valida';
  A000MSG_A151_MSG_DEBITO_0_ORE            = 'In data %s il dipendente ha un debito settimanale di zero ore';
  A000MSG_A151_MSG_0_GIORNI_LAVORATIVI     = 'In data %s il dipendente ha un numero di giorni lavorativi pari a zero';
  A000MSG_A151_MSG_TIPI_FRUIZIONE          = 'Il dipendente utilizza le causali sia a giorni che a ore';
  A000MSG_A151_ERR_FMT_PIU_GIORNATE_INTERE = 'In data %s il dipendente ha più di un giustificativo a giornata intera: ne verrà conteggiato solo uno';
  A000MSG_A151_ERR_FMT_GG_INTERA_E_ORE     = 'In data %s il dipendente ha giustificativi a giornata intera e a ore: verrà conteggiato solo quello a giornata intera';
  A000MSG_A151_ERR_FMT_GIUST_NO_FAMILIARE  = 'In data %s il dipendente ha giustificativi privi del riferimento al familiare';
  A000MSG_A151_ERR_FMT_FAMILIARE_NO_ESISTE = 'In data %s il dipendente ha giustificativi riferiti al familiare %s che non esiste nella relativa tabella dei familiari';
  A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO   = 'Sul familiare con data nascita %s occorre indicare %s';
  A000MSG_A151_ERR_FMT_FAMILIARE_CON_DATO  = 'Sul familiare con data nascita %s occorre pulire %s';
  A000MSG_A151_ERR_NO_FILE                 = 'Specificare il nome del file di esportazione!';
  A000MSG_A151_DLG_FILE_ESISTE             = 'Il file indicato per l''esportazione è già esistente. Proseguire comunque sostituendolo con i nuovi dati?';
  A000MSG_A151_ERR_FILE_IN_USO             = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_A151_DLG_FMT_GARANZIA_EXPORT     = 'Attenzione: il buon esito dell''esportazione in .xml %s è garantito esclusivamente con %s. Continuare comunque?';
  A000MSG_A151_DLG_FMT_DETTAGLIO_DATA_FAM  = 'Attenzione: con il dettaglio familiari, occorre verificare che la stampa %s abbia nel Dettaglio serbatoio il dato giornaliero ''Assenza:data familiare''. Continuare?';
  A000MSG_A151_DLG_NO_ID_MITTENTE          = 'Attenzione: ID Mittente non indicato! Il dato verrà valorizzato con il numero progressivo della riga. Continuare?';
  A000MSG_A151_DLG_EXPORT_1000_TASSI       = 'Attenzione: nella griglia risultato sono presenti più di 1000 tassi di assenza da esportare! Continuare comunque?';
  A000MSG_A151_ERR_FMT_NO_ID               = 'Attenzione: riga non elaborata. ID %s (%s) non valorizzato sulla riga %s';
  A000MSG_A151_ERR_FMT_ERR_GEN             = 'Attenzione: riga non valida in %s: %s';
  A000MSG_A151_ERR_FMT_RIGA_INVALIDA       = 'Attenzione: riga non valida. %s non valorizzato %s';
  A000MSG_A151_ERR_FMT_VALORI_DIVERSI      = 'Attenzione: riga non valida. %s diverso dai valori previsti (%s)';
  A000MSG_A151_ERR_GIUST_NO_FAMILIARE      = 'Attenzione: riga non valida. Giustificativi privi del riferimento al familiare';
  A000MSG_A151_MSG_FMT_CF_FAMILIARE        = ' per il familiare con cod.fiscale %s';
  A000MSG_A151_ERR_FMT_DATO_AZ_VUOTO       = 'Non è stato specificato il dato aziendale "%s"!';

  A000MSG_A153_ERR_FMT_DATA_ANTECEDENTE    = 'Il %s è antecedente al periodo di riferimento';
  A000MSG_A153_ERR_FMT_DATA_SUCCESSIVA     = 'Il %s è successivo al periodo di riferimento';

  A000MSG_A154_ERR_CANC_DOC_ALTRO_USER     = 'Impossibile cancellare un documento creato da un altro utente!';
  A000MSG_A154_ERR_CANC_DOC_VISUALIZZATO   = 'Impossibile cancellare un documento già visualizzato da un altro utente!';
  A000MSG_A154_ERR_CANC_DOC_WEB            = 'Impossibile cancellare un documento caricato dall''applicativo web!';
  A000MSG_A154_ERR_MOD_TIPO_ITER           = 'Impossibile modificare un documento associato ad una richiesta web!';
  A000MSG_A154_ERR_CANC_TIPO_ITER          = 'Impossibile cancellare un documento associato ad una richiesta web!';
  A000MSG_A154_ERR_DOC_INESISTENTE         = 'Il documento è inesistente!';
  A000MSG_A154_ERR_FMT_DOC_SALVA           = 'Errore durante il salvataggio del documento: %s';
  A000MSG_A154_ERR_FMT_DOC_APRI            = 'Errore durante l''apertura del documento: %s';
  A000MSG_A154_ERR_FILE_NON_INDICATO       = 'E'' necessario indicare il documento da salvare!';
  A000MSG_A154_ERR_FMT_PERIODO             = 'Il periodo indicato non è valido: %s';
  A000MSG_A154_ERR_TIPOLOGIA_NON_INDICATA  = 'E'' necessario indicare la tipologia del documento!';
  A000MSG_A154_ERR_FMT_TIPOLOGIA_ITER_INS  = 'Non è possibile selezionare la tipologia'#13#10'"%s"!';
  A000MSG_A154_ERR_FMT_TIPOLOGIA_ITER_VAR  = 'Non è possibile modificare la tipologia scegliendo'#13#10'"%s"!';
  A000MSG_A154_ERR_UFFICIO_NON_INDICATO    = 'E'' necessario indicare l''ufficio di riferimento!';
  A000MSG_A154_ERR_FMT_CANC_TIPOL_PREDEF   = 'Impossibile eliminare la tipologia predefinita "%s"';
  A000MSG_A154_ERR_FMT_CANC_TIPOL_ITER     = 'Impossibile eliminare la tipologia "%s"';
  A000MSG_A154_ERR_CANC_TIPOL_FK           = 'Sono presenti documenti associati a questa tipologia.'#13#10'Impossibile eliminare!';
  A000MSG_A154_ERR_FMT_MOD_TIPOL_ITER      = 'Impossibile modificare la tipologia "%s"';
  A000MSG_A154_ERR_FMT_CANC_UFFICIO_PREDEF = 'Impossibile eliminare l''ufficio predefinito "%s"';
  A000MSG_A154_ERR_CANC_UFFICIO_FK         = 'Sono presenti documenti associati a questo ufficio.'#13#10'Impossibile eliminare!';
  A000MSG_A154_ERR_CODICE_DEFAULT          = 'Indicare S oppure N per il codice di default';
  A000MSG_A154_ERR_CODICE_DEFAULT_MULT     = 'Impossibile attribuire più di un default!';
  A000MSG_A154_MSG_FMT_INFO_DIM_DOCUMENTO  = '(max %d MB)';
  A000MSG_A154_DLG_NUOVA_VERSIONE          = 'Per il documento selezionato sono già presenti una o più versioni archiviate in precedenza, proseguire con la creazione di una nuova versione?';

  A000MSG_A155_ERR_DOC_INESISTENTE         = 'Il documento è inesistente!';
  A000MSG_A155_ERR_FMT_DOC_SALVA           = 'Errore durante il salvataggio del documento: %s';
  A000MSG_A155_ERR_FMT_DOC_APRI            = 'Errore durante l''apertura del documento: %s';

  A000MSG_A156_ERR_DESCRIZIONE_VUOTA       = 'Indicare la descrizione!';
  A000MSG_A156_ERR_NOTIFICA_VUOTA          = 'Selezionare la procedure oracle di notifica!';
  A000MSG_A156_ERR_ATTIVO                  = 'Il campo Attivo può contenere solo i valori "S" o "N"!';

  A000MSG_A159_DLG_FMT_CONFERMA_ELAB       = 'Verrano generati PDF per n. %s dipendent%s. Procedere?';
  A000MSG_A159_DLG_FMT_NUOVA_VERSIONE      = 'E'' già presente una versione archiviata in precedenza di %s document%s, proseguire con la creazione di una nuova versione?' + ''#13#10'[Yes]: Procede comunque con la creazione di una nuova versione'#13#10'[No]: Procede con l''elaborazione dei soli dipendenti senza documento già archiviato in versione precedente'#13#10'[Cancel]: Annulla l''elaborazione';
  A000MSG_A159_DLG_FMT_SOVRASCRIVI         = 'Per %s document%s è già presente un file archiviato in precedenza, proseguire con la sostituzione?' + ''#13#10'[Yes]: Procede con la sostituzione'#13#10'[No]: Procede con l''elaborazione dei soli dipendenti senza documento già archiviato in precedenza'#13#10'[Cancel]: Annulla l''elaborazione;';
  A000MSG_A159_DLG_INVIA_REGISTRO          = 'Procedere con l''invio del registro di archiviazione selezionato al sistema di archiviazione sostitutiva?';

  A000MSG_A160_INCENTIVI_DATO_1            = 'Specificare il dato aziendale <INCENTIVI:DATO 1>';

  A000MSG_A162_ERR_PCT_ABBATT              = 'Attenzione! Le percentuali di abbattimento non possono superare il 100%.';
  A000MSG_A162_ERR_TUTTE_LE_QUOTE          = 'Attenzione! A parità di dati anagrafici, non è possibile gestire abbattimenti per tutte le quote e per singole quote!';
  A000MSG_A162_ERR_CODTIPOQUOTA            = 'Attenzione! Il codice quota indicato non è tra quelli disponibili!';

  A000MSG_A163_ERR_CODICE_MENO             = 'Attenzione! Non è possibile inserire un Tipo Quota con codice ''-''.';
  A000MSG_A163_ERR_CODICE_UNDERSCORE       = 'Attenzione! Non è possibile inserire un Tipo Quota con codice ''_''.';
  A000MSG_A163_ERR_IMP_CAMBIARE            = 'Per questo tipo quota è impossibile cambiare la tipologia!';
  A000MSG_A163_ERR_QUOTE_REGISTRATE        = 'Impossibile cambiare la tipologia perché per questo codice esistono già delle quote registrate!';
  A000MSG_A163_ERR_FMT_ACCONTO_USATO       = 'L''acconto %s è già stato associato al saldo %s!';
  A000MSG_A163_ERR_RIFERIMENTO             = 'Specificare almeno un acconto di riferimento!';
  A000MSG_A163_ERR_ASSESTAMENTO            = 'Specificare la causale di assestamento!';
  A000MSG_A163_ERR_PENALIZZAZIONE          = 'Impossibile specificare più di una quota di penalizzazione!';
  A000MSG_A163_ERR_IMP_CANCELLARE          = 'Impossibile cancellare questo tipo quota!';
  A000MSG_A163_ERR_IMP_CANCELLARE_REGIST   = 'Impossibile cancellare questo tipo quota perchè esistono già delle quote registrate!';
  A000MSG_A163_MSG_DECORRENZA_SPOSTATA     = 'Attenzione: la decorrenza verrà spostata all''inizio del mese specificato!'#13#10'Vuoi continuare?';

  A000MSG_A164_ERR_FMT_REGOLE_DATO         = 'Regole incentivi non esistenti per questo livello (%s)!';
  A000MSG_A164_ERR_PCT_INCIDENZA           = 'Attenzione: la somma delle percentuali di incidenza individuale e strutturale deve essere 100!';
  A000MSG_A164_ERR_PCT_O_IMP               = 'Indicare una percentuale o un importo di variazione significativo!';
  A000MSG_A164_ERR_QUOTA_O_CAUS            = 'Indicare ''tipo quota'' o ''causale di assenza''';
  A000MSG_A164_MSG_DECORRENZA_INIZIO_MESE  = 'Attenzione: la decorrenza è stata spostata all''inizio del mese specificato!';
  A000MSG_A164_MSG_FMT_AGG_GLOBALE         = 'Confermi l''aggiornamento/storicizzazione di TUTTE le quote ''%s %s'' ' + #13#10+
                                             'dal %s con %s rispetto alle attuali?';

  A000MSG_A166_DLG_FORZA_DEC_SCAD          ='Attenzione: la decorrenza e la scadenza sono diversi da inizio e fine mese. ' + #13#10 +
                                            'Questo è significativo SOLO se la quota indicata è DIVERSA rispetto alle quote generali spettanti. ' + #13#10 +
                                            'Se il dipendente è assunto/cessato in corso di mese oppure ha delle assenze non tollerate il PROPORZIONAMENTO è AUTOMATICO e ' + #13#10 +
                                            'FUNZIONA correttamente solo se decorrenza e scadenza coincidono con inizio e fine mese. Forzare questi ultimi a inizio e fine mese?';
  A000MSG_A166_DLG_FORZA_DEC               ='Attenzione: la decorrenza è diversa da inizio mese. ' + #13#10 +
                                            'Questo è significativo SOLO se la quota indicata è DIVERSA rispetto alle quote generali spettanti. ' + #13#10 +
                                            'Se il dipendente è assunto/cessato in corso di mese oppure ha delle assenze non tollerate il PROPORZIONAMENTO è AUTOMATICO e ' + #13#10 +
                                            'FUNZIONA correttamente solo se la decorrenza coincide con l''inizio del mese. Forzare quest''ultima a inizio mese?';
  A000MSG_A166_DLG_FORZA_SCAD              ='Attenzione: la scadenza è diversa da fine mese. ' + #13#10 +
                                            'Questo è significativo SOLO se la quota indicata è DIVERSA rispetto alle quote generali spettanti. ' + #13#10 +
                                            'Se il dipendente è assunto/cessato in corso di mese oppure ha delle assenze non tollerate il PROPORZIONAMENTO è AUTOMATICO e ' + #13#10 +
                                            'FUNZIONA correttamente solo se la scadenza coincide con la fine del mese. Forzare quest''ultima a fine mese? ';
  A000MSG_A166_DLG_FMT_ACQUISIZIONE        ='Confermi l''acquisizione delle quote ''%s %s'' ' + #13#10 +
                                            'per i %s dipendenti selezionati presenti sul file?';

  A000MSG_A166_ERR_FMT_REGOLE_INCENTIVI    ='Regole incentivi non esistenti per il livello (%s) di questo dipendente!';
  A000MSG_A166_ERR_QUOTE_QUANTITATIVE      = 'Impossibile specificare quote quantitative perchè vengono gestite attraverso le schede quantitative individuali (A172)!';
  A000MSG_A166_ERR_TIPO_QUOTA              = 'Indicare tipo quota!';


  A000MSG_A167_MSG_FMT_CONFERMA_CANC       = 'Confermi la cancellazione delle quote %s da %s a %s per TUTTI i dipendenti selezionati?';

  A000MSG_A169_ERR_PESI_BASE               = 'Attenzione: totale pesi base superiore al peso totale previsto!';
  A000MSG_A169_ERR_QUOTE_BASE              = 'Attenzione: totale quote base superiore alla quota totale prevista!';
  A000MSG_A169_ERR_PESI_CALCOLATI          = 'Attenzione: totale pesi calcolati superiore al peso totale previsto!';
  A000MSG_A169_ERR_QUOTE_ASSEGNATE         = 'Attenzione: totale quote assegnate superiore alla quota totale prevista!';
  A000MSG_A169_ERR_QUOTE_CALCOLATE         = 'Attenzione: totale quote calcolate superiore alla quota totale prevista!';
  A000MSG_A169_MSG_DIPENDENTI_CAMBIATI     = 'Attenzione: la situazione dei dipendenti potrebbe essere cambiata. ' + #13#10 +
                                             'Consigliamo di procedere con l''aggiornamento del gruppo dall''apposita funzione!';
  A000MSG_A169_MSG_DIPENDENTI_GRUPPO       = 'Il dipendente non è stato inserito perchè fa già parte del gruppo ';
  A000MSG_A169_MSG_PESO_MINIMO             = 'Indicare un peso individuale minimo significativo!';
  A000MSG_A169_MSG_PESO_INFERIORE          = 'Peso inferiore al minimo individuale previsto!';
  A000MSG_A169_MSG_PESO_SUPERIORE          = 'Peso superiore al massimo individuale previsto!';

  A000MSG_A170_ERR_ABIL_PES_SCHEDE         = 'Funzione (A169) Pesature individuali e/o (A172) Schede quantitative individuali non abilitate!';
  A000MSG_A170_ERR_GRUPPI_PESATURE         = 'Selezionare almeno un gruppo pesature da elaborare!';
  A000MSG_A170_ERR_GRUPPI_SCHEDE           = 'Selezionare almeno un gruppo schede da elaborare!';
  A000MSG_A170_ERR_ANNO_SCHEDE             = 'Indicare l''anno  delle schede da elaborare!';
  A000MSG_A170_ERR_DATA_RIF_SCHEDE         = 'Specificare una data di riferimento valida!';
  A000MSG_A170_ERR_ANNO_DATA_RIF_SCHEDE    = 'Specificare una data di riferimento compresa nel nuovo anno!';
  A000MSG_A170_ERR_TIPOLOGIA_QUOTA         = 'Specificare la tipologia quota!';
  A000MSG_A170_DLG_NO_MESE_PAGAMENTO       = 'Attenzione: non è stato specificato alcun mese di pagamento. Continuare comunque?';
  A000MSG_A170_DLG_FMT_CHIUSURA_PESATURE   = 'Confermi la chiusura dei gruppi pesature selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_RIAPERTURA_PESATURE = 'Confermi la riapertura dei gruppi pesature selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_AGGIORNA_PESATURE   = 'Confermi l''aggiornamento dei gruppi pesature selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_CHIUSURA_SCHEDE     = 'Confermi la chiusura dei gruppi schede selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_RIAPERTURA_SCHEDE   = 'Confermi la riapertura dei gruppi schede selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_AGGIORNA_SCHEDE     = 'Confermi l''aggiornamento dei gruppi schede selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_PASSAGGIO_ANNO_SCHEDE  ='Attenzione: verranno ribaltati i gruppi schede presenti nel %s sul nuovo anno %s. ' + #13#10 +
                                               'Eventuali gruppi già presenti nel %s verranno sovrascritti. Prima di procedere, CHIUDERE quelli che si vogliono mantenere intatti. Confermare l''operazione?';
  A000MSG_A170_DLG_FMT_GRUPPI_APERTI_SCHEDE= 'Attenzione: sono presenti %s gruppi aperti nell''anno %s che verranno sovrascritti. ' + #13#10 +
                                             'Continuare?';

  A000MSG_A171_DLG_CARICAMENTO             = 'Vuoi caricare i dati dalla ''Comunicazione visite fiscali''?';
  A000MSG_A171_ERR_NO_VISITE               = 'Non sono presenti visite fiscali da caricare in data odierna!';
  A000MSG_A171_DLG_FMT_INSERIMENTO         = 'Verranno inserite %s richieste visite fiscali. Continuare?';
  A000MSG_A171_MSG_FMT_FINEELAB            = 'Elaborazione terminata: sono stati generati %s file in quanto è stato superato il numero massimo di richieste inviabile per ogni file (50 richieste per ogni file)';
  A000MSG_A171_ERR_FMT_DIPINS              = 'Richiesta visita fiscale già inserita in data %s';
  A000MSG_A171_ERR_FMT_NO_REPERIBILITA     = 'Visita fiscale con nominativo di riferimento ma senza %s di reperibilità';
  A000MSG_A171_MSG_COMUNE_DIVERSO          = 'Visita fiscale con comune diverso da comune di domicilio/residenza (%s)';
  A000MSG_A171_ERR_COMUNE_NOT480           = 'Visita fiscale con comune %s non trovato nella tabella di riferimento';
  A000MSG_A171_DLG_FMT_CANCELLAZIONE       = 'Attenzione: la cancellazione comporta l''eliminazione di tutte le %s visite fiscali dal %s al %s. Confermi l''operazione?';
  A000MSG_A171_MSG_COGNOME_REP             = 'Visita fiscale con comune di reperibilità ma senza nominativo di riferimento che è stato impostato uguale al cognome e nome del dipendente';
  A000MSG_A171_MSG_COGNOME_REP_ORIG        = 'Visita fiscale con comune di reperibilità ma senza nominativo di riferimento che è stato impostato uguale al cognome di reperibilità del certificato originale';
  A000MSG_A171_ERR_PERIODO_MAL             = 'Visita fiscale con periodo di malattia che non comprende la data richiesta e la data visita';
  A000MSG_A171_MSG_REP_ORIGINALE           = 'Visita fiscale senza dati di reperibilità: annullati dall''operatore ma presenti sul certificato originale (%s)';

  A000MSG_A172_MSG_GRUPPO_APERTO           = 'Gruppo aperto';
  A000MSG_A172_MSG_GRUPPO_CHIUSO           = 'Gruppo chiuso';
  A000MSG_A172_MSG_GRUPPO_MODIFICA         = 'Gruppo in modifica';
  A000MSG_A172_MSG_MODIFICA_NON_CONSENTITA = 'La modifica/cancellazione è consentita solamente per i gruppi in stato Aperto';
  A000MSG_A172_MSG_MODIFICA_DETAIL_NON_CONSENTITA = 'La modifica  è consentita solamente per i gruppi che non siano Chiusi';
  A000MSG_A172_MSG_DIPENDENTI_CAMBIATI     = 'Attenzione: la situazione dei dipendenti potrebbe essere cambiata. ' + #13#10 +
                                             'Consigliamo di eliminare il gruppo e ricrearlo con i nuovi parametri!';
  A000MSG_A172_ERR_ANNO_RIF                = 'Indicare l''anno di riferimento!';
  A000MSG_A172_ERR_DATA_RIF                = 'La data di riferimento deve essere compresa nell''anno di riferimento!';
  A000MSG_A172_ERR_TIPO_QUOTA              = 'Indicare il tipo quota!';
  A000MSG_A172_ERR_SUPERVISORE             = 'Indicare il supervisore di riferimento!';
  A000MSG_A172_ERR_NO_FILTRO_ANAG          = 'Indicare il filtro anagrafe!';
  A000MSG_A172_ERR_FILTRO_ANAG             = 'Filtro anagrafe non corretto!';
  A000MSG_A172_ERR_NO_CODGRUPPO            = 'Indicare il codice gruppo!';
  A000MSG_A172_ERR_TOT_ORE_ACCETTATE       = 'Attenzione: totale importo ore accettate superiore all''importo totale previsto!';
  A000MSG_A172_ERR_NUM_ORE_ASSEGNATE       = 'Num.ore assegnate non valide!';
  A000MSG_A172_ERR_MINUTI_ORE_ASSEGNATE    = 'I minuti delle ore assegnate devono essere minori di 60!';
  A000MSG_A172_ERR_NUM_ORE_ACCETTATE       = 'Num.ore accettate non valide!';
  A000MSG_A172_ERR_MINUTI_ORE_ACCETTATE    = 'I minuti delle ore accettate devono essere minori di 60!';
  A000MSG_A172_ERR_NUM_ORE_EXTRA           = 'Num.ore extra non valide!';
  A000MSG_A172_ERR_MINUTI_ORE_EXTRA        = 'I minuti delle ore extra devono essere minori di 60!';
  A000MSG_A172_ERR_GIA_FIRMATO             = 'Impossibile modificare i dati perchè il dipendente ha già firmato!';
  A000MSG_A172_ERR_NO_VALUTATORE           = 'Specificare il valutatore di riferimento!';
  A000MSG_A172_ERR_ORE_ACCETTATE_PROG_QUANT= 'Specificare le ore accettate quando vengono confermati i progetti quantitativi (punto 2 della flessibilità)!';
  A000MSG_A172_ERR_PROG_QUANT_ORE_ACCETTATE= 'Specificare la conferma dei progetti quantitativi (punto 2 della flessibilità) quando vengono accettate delle ore!';
  A000MSG_A172_ERR_NO_DESC_OBIETTIVO       = 'Specificare la descrizione dell''obiettivo!';
  A000MSG_A172_ERR_NO_PESO_OBIETTIVO       = 'Specificare il peso dell''obiettivo!';
  A000MSG_A172_ERR_PESO_OBIETTIVO4         = 'Il peso dell''obiettivo 4 non può essere inferiore a 40!';
  A000MSG_A172_ERR_FMT_SOMMA_PESI          = 'La somma totale dei pesi è %s ma non può essere diversa da 100!';

  A000MSG_A173_ERR_NO_FILE                 = 'Specificare il file contenente le ore di assestamento da importare!';
  A000MSG_A173_ERR_COLONNE_FILE            = 'Impossibile elaborare il file! Il file contiene un numero di colonne non corretto!';
  A000MSG_A173_ERR_FMT_ACQ_NO_ANNO         = 'Riga %s: %s Anno non corretto';
  A000MSG_A173_ERR_FMT_ACQ_NO_MESE         = 'Riga %s: %s Mese non corretto';
  A000MSG_A173_ERR_FMT_ACQ_NO_ORE          = 'Riga %s: %s Valore del campo ore non corretto, valori ammessi tra 0 e 999';
  A000MSG_A173_ERR_FMT_ACQ_NO_MINUTI       = 'Riga %s: %s Valore del campo minuti non corretto, valori ammessi tra 0 e 59';
  A000MSG_A173_ERR_FMT_ACQ_NO_CAUSALE      = 'Riga %s: %s Causale non esistente';
  A000MSG_A173_ERR_FMT_ACQ_NO_MATRICOLA    = 'Riga %s: %s Matricola non esistente';
  A000MSG_A173_ERR_FMT_ACQ_NO_CODFISCALE   = 'Riga %s: %s Codice fiscale non esistente';
  A000MSG_A173_ERR_FMT_ACQ_PIU_CODFISCALE  = 'Riga %s: %s Codice fiscale associato a più dipendenti %s';
  A000MSG_A173_ERR_FMT_ACQ_CESS_CODFISCALE = 'Riga %s: %s Codice fiscale associato ad un dipendente cessato ma l''elaborazione prosegue';
  A000MSG_A173_ERR_FMT_ACQ_TROPPE_CAUSALI  = 'Riga %s: Matricola %s Mese %s/%s Elaborazione impedita dalla presenza di altre due causali di assestamento';
  A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_COMP = 'Riga %s: Matricola %s Mese %s/%s Le ore di abbattimento superano il saldo complessivo, l''operazione viene comunque effettuata';
  A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_CORR = 'Riga %s: Matricola %s Mese %s/%s Le ore di abbattimento superano il saldo anno corrente, l''operazione viene comunque effettuata';
  A000MSG_A173_ERR_FMT_CANC_NO_CAUSALE     = 'Riga %s: Matricola %s Mese %s/%s Cancellazione non avvenuta per l''assenza della causale di assestamento';
  A000MSG_A173_ERR_FMT_CANC_NO_ORE         = 'Riga %s: Matricola %s Mese %s/%s Cancellazione non avvenuta per l''assenza di corrispondenza del numero ore di assestamento (%s <> %s)';
  A000MSG_A173_ERR_FMT_ACQ_NO_SCHEDA_RIEP  = 'Riga %s: Matricola %s Mese %s/%s Elaborazione impedita dall''assenza della scheda riepilogativa';
  A000MSG_A173_ERR_FMT_LIQ_SUPERO_SALDO_LIQ = 'Riga %s: Matricola %s Mese %s/%s Le ore da liquidare superano il saldo liquidabile dell''anno corrente: %s > %s. Elaborazione impedita.';
  A000MSG_A173_ERR_FMT_CANC_NO_ORE_LIQ     = 'Riga %s: Matricola %s Mese %s/%s Annullamento ore liquidate non avvenuto per l''assenza di corrispondenza con le ore già presenti (%s <> %s)';
  A000MSG_A173_ERR_FMT_ACQ_ORE             = 'Riga %s: Matricola %s Mese %s/%s Elaborazione impedita per la presenza di colonne non valide';

  A000MSG_A177_ERR_RAGGR_ASSENZE           = 'Inserimento impossibile: raggruppamento assenze con inquadramento ''Ferie solidali'' assente, inserirlo nella relativa tabella!';
  A000MSG_A177_ERR_RAGGR_ASSENZE_DIP       = 'Inserimento impossibile: dipendente senza raggruppamento assenze!';
  A000MSG_A177_ERR_FMT_DATA_ANNO           = 'La data %s deve essere compresa nell''anno di riferimento!';
  A000MSG_A177_ERR_SCADENZA_NULLA          = 'Prima di chiudere è necessario specificare la scadenza!';
  A000MSG_A177_ERR_FMT_CAUSALE_NULLA       = 'Specificare la causale di assenza per la verifica del residuo sulla quantità %s!';
  A000MSG_A177_ERR_FMT_QUANTITA_NULLA      = 'Specificare la quantità %s!';
  A000MSG_A177_ERR_FMT_QUANTITA_ZERO       = 'La quantità %s deve essere maggiore di zero!';
  A000MSG_A177_ERR_FMT_QUANTITA_DEC        = 'La quantità %s non può avere decimali, deve essere un numero intero!';
  A000MSG_A177_ERR_FMT_QUANTITA            = 'La quantità %s non può essere maggiore di %s';
  A000MSG_A177_DLG_QUANTITA_RES            = 'Attenzione: la quantità offerta non può essere maggiore di %s. Si conferma comunque la registrazione del dato che manderà in negativo il residuo a fine anno?';
  A000MSG_A177_ERR_OFF_DECORRENZA          = 'Il numero richiesta indicato non è valido alla decorrenza specificata con questa unità di misura!';
  A000MSG_A177_ERR_OFF_UMISURA             = 'Alla decorrenza specificata, non sono presenti richieste aperte valide con questa unità di misura!';
  A000MSG_A177_MSG_OFF_TOTQUANTITA         = 'Attenzione: il totale delle quantità offerte (%s) non corrisponde all''offerta iniziale del dipendente (%s)!';
  A000MSG_A177_ERR_RIC_VARIAZIONE          = 'Variazione impossibile perchè sono presenti offerte con lo stesso Numero richiesta che verrebbero escluse dal periodo Decorrenza-Scadenza';
  A000MSG_A177_DLG_TUTTE_RICH              = 'Attenzione: l''offerta sarà valida per tutte le richieste. Continuare?';
  A000MSG_A177_DLG_CANC_OFFERTA            = 'Attenzione: verranno cancellate anche tutte le offerte collegate. Continuare comunque?';
  A000MSG_A177_ERR_FMT_CANCELLAZIONE       = 'Cancellazione impossibile perchè sono presenti offerte %s.';
  A000MSG_A177_DLG_STATO_APERTA            = 'Attenzione: riportando lo stato richiesta ad Aperta, verranno azzerate tutte le quantità ottenute e accettate. Continuare comunque?';
  A000MSG_A177_ERR_RIC_DATA_TERMINE        = 'La data termine diritto deve essere successiva alla scadenza!';
  A000MSG_A177_DLG_QUANTITA_TERMINE        = 'Attenzione: la quantità ottenuta di ferie solidali è stata interamente fruita, l''impostazione della data termine diritto non avrà alcun effetto sulle quantità restituite. Continuare comunque?';
  A000MSG_A177_DLG_QUANTITA_RESTITUITA     = 'Attenzione: la quantità residua di ferie solidali è maggiore della quantità ottenuta, verrà restituita la sola quantità ottenuta. Continuare comunque?';
  A000MSG_A177_ERR_GIORNI_FRUITI           = 'Sono presenti %s di ferie solidali successivi alla data termine %s: prima di procedere, cancellare i relativi giustificativi!';

  A000MSG_A178_ERR_DALLE_ALLE              = 'Il dato Alle deve essere maggiore del dato Dalle!';
  A000MSG_A178_ERR_GIORNO_SETTIMANA        = 'Il dato Giorno deve essere compreso tra 1 e 7!';
  A000MSG_A178_ERR_RESPONSABILE            = 'Il responsabile non è valido: deve essere selezionato dall''elenco proposto!';
  A000MSG_A178_ERR_INTERVALLO              = 'L''intervallo Dalle-Alle non è valido perchè si interseca con periodi già esistenti sullo stesso giorno!';

  A000MSG_A183_MSG_FILTRO_CORRETTO         = 'Filtro Corretto!';
  A000MSG_A183_ERR_FMT_FILTRO              = 'Impossibile salvare il filtro!'#13#10'%s';
  A000MSG_A184_DLG_FMT_CANCELLA            = 'Attenzione!'#13#10'Il profilo ha delle funzioni attivate per i seguenti applicativi:'#13#10 +
                                             '%s'#13#10'Eliminare il record?';

  A000MSG_A186_ERR_FMT_DEFINIRE_FILTRO     = 'Definire un filtro %s: nessun login inserito';
  A000MSG_A186_ERR_FMT_ESPR_UT_PWD         = 'Le espressioni indicate per l''utente e la password non sono valide!'#13#10'%s';

  A000MSG_A186_DLG_FMT_TRIG_060            = '%s il trigger T030_AFTERINS_I060 ?';
  A000MSG_A186_DLG_FMT_ELIM_LOGIN          = 'Confermi l''eliminazione del login di accesso per i %s dipendenti selezionati?';
  A000MSG_A186_DLG_FMT_INS_LOGIN           = 'Confermi l''inserimento del login di accesso per i %s dipendenti selezionati?';
  A000MSG_A186_DLG_ELIM_PROFILI            = 'Confermi l''eliminazione dei profili con le impostazioni indicate per i login selezionati?';
  A000MSG_A186_DLG_VAL_DEFAULT             = 'Attenzione!' + #13#10 + 'Per tutte le aziende esistenti verranno applicati i valori di default specificati in ' + #13#10 + 'Permessi, Filtro funzioni, Filtro dizionario.' + #13#10 + 'Confermare?';
  A000MSG_A186_DLG_FMT_UPD_PWD             = 'Confermi la modifica della password per i %s dipendenti selezionati?';
  A000MSG_A186_ERR_PWD_ERRATA              = 'La password attuale è errata';
  A000MSG_A186_ERR_FMT_LUNG_PWD            = 'La password deve essere di almeno %d caratteri!';
  A000MSG_A186_ERR_DLG_PWD                 = 'La nuova password non è stata confermata correttamente!';
  A000MSG_A186_ERR_NO_UTENTE               = 'Nessun utente selezionato a cui applicare il filtro.';

  A000MSG_A186_ERR_INIZ_CELLULARE          = 'Il cellulare deve iniziare con la cifra "3"!';
  A000MSG_A186_ERR_FMT_LUNG_CELLULARE      = 'Il cellulare deve essere di almeno %d caratteri!';
  A000MSG_A186_ERR_NON_NUMERICO            = 'Il cellulare deve contenere soltanto caratteri numerici!';

  A000MSG_A187_ERR_FMT_V_SESSION           = 'Attenzione! Probabilmente mancano i diritti di accesso alle viste ' + #13#10 +
                                             'V$SESSION e V$MYSTAT.' + #13#10 +
                                             'Non è pertanto possibile visualizzare le Sessioni attive.'#13#10'%s';
  A000MSG_A187_DLG_BLOCCO                  = 'Bloccare gli accessi a tutti gli utenti?';
  A000MSG_A187_DLG_SBLOCCO                 = 'Sbloccare gli accessi a tutti gli utenti?';
  A000MSG_A187_DLG_TERMINA_SESS            = 'Terminare la sessione selezionata?';
  A000MSG_A187_DLG_TERMINA_ALL_SESS        = 'Terminare tutte le sessioni?';

  A000MSG_A193_DLG_IMPORTA_RICH            = 'Confermi l''importazione di tutte le richieste visualizzate?';

  A000MSG_A197_ERR_LAYOUT_DEFAULT          = 'Impossibile rinominare/cancellare il layout DEFAULT';
  A000MSG_A197_ERR_LAYOUT_MEDP             = 'Impossibile creare il layout MONDOEDP';

  A000MSG_A197_ERR_LAYOUT_USO              = 'Impossibile rinominare/cancellare il layout poichè in uso';

  A000MSG_A198_MSG_SERBATOIO               = 'Serbatoio';
  A000MSG_A198_MSG_NOME                    = 'Nome';
  A000MSG_A198_MSG_ESPRESSIONE             = 'Espressione';

  A000MSG_A200_MSG_DLG_NUM_FILE_SELEZ      = 'File selezionati: %d';
  A000MSG_A200_MSG_DLG_DIM_FILE_SELEZ      = 'Dimensione totale: %s';
  A000MSG_A200_ERR_NO_NOMEFILE_PRED        = 'Specificare il nome di file di destinazione predefinito';
  A000MSG_A200_ERR_FMT_NOMEFILE_NO_TAG     = 'Il formato nome del file non contiene il tag %s';
  A000MSG_A200_ERR_B021_NON_RISPONDE       = 'Nessuna risposta dal servizio B021.';
  A000MSG_A200_ERR_NO_DATE_PERIODO         = 'Entrambe le date di riferimento devono essere valorizzate oppure vuote.';
  A000MSG_A200_DLG_FMT_AVVIO_IMPORT        = 'Importare %d file?';
  A000MSG_A200_DLG_FMT_CONFIRM_SOVRASCR    = 'È stato scelto di sovrascrivere i documenti esistenti della tipologia %s.' + #13#10 +
                                             'Tali documenti saranno cancellati se è presente un file da importare per il dipendente e non potranno essere recuperati.' + #13#10 +
                                             'Proseguire con l''importazione?';
  A000MSG_A200_MSG_IMPORTAZIONE            = 'Importazione di %s...';
  A000MSG_A200_ERR_SUPERO_MAX_DIM          = 'Il file %s supera la dimensione massima consentita e non è stato importato';
  A000MSG_A200_ERR_FMT_IMPORT_EXC          = 'Errore durante l''importazione di %s: %s';
  A000MSG_A200_MSG_IMPORT_OK               = 'Importazione completata correttamente.';
  A000MSG_A200_ERR_IMPORT_ANOM             = 'Si sono verificate anomalie durante l''importazione.';

  A000MSG_A202_ERR_NO_DATA_INIZIO          = 'Indicare la data di inizio rapporto!';
  A000MSG_A202_ERR_NO_DATA_FINE            = 'Indicare la data di fine rapporto!';
  A000MSG_A202_ERR_FMT_PERIODO             = 'La data fine %s non può essere antecedente alla data inizio %s!';
  A000MSG_A202_MSG_INTERSEZIONE            = 'Il periodo indicato risulta intersecare un altro periodo! (%s - %s)';
  A000MSG_A202_MSG_CONFERMA_STORICIZZ      = 'Eseguire la storicizzazione del Profilo Assenze?';

  A000MSG_A204_ERR_CODICE_MOD_NULLO        = 'Il codice del modello non può essere nullo!';
  A000MSG_A204_ERR_CODICE_IN_USO           = 'Codice già utilizzato nel modello di certificazione';
  A000MSG_A204_ERR_PERIODO                 = 'Periodo indicato non valido';
  A000MSG_A204_ERR_COL_DATO_ANAGRAFICO     = 'Se la colonna %s è valorizzata, alla colonna %s possono essere assegnati solo i valori ''C'' o ''P''';
  A000MSG_A204_ERR_COL_VALORI              = 'Le colonne %s, %s, %s non possono essere contemporaneamente valorizzate';
  A000MSG_A204_ERR_URL                     = 'Formato del URL non valido.' + #13#10 + 'Indicare il testo visualizzato e l''indirizzo di destinazione separati dal carattere ","';
  A000MSG_A204_ERR_COL_VALORI_01           = 'Le colonne %s, %s, %s non possono essere utilizzate per il tipo di dato indicato';

  A000MSG_A205_MSG_FMT_TIPOOPE_NON_TROVATO = 'Attenzione! Il tipo operatore %s non è abbinato alla squadra %s sull''anagrafica di nessun dipendente nel periodo di validità %s-%s. Il dato viene comunque salvato.';

  A000MSG_A210_ERR_SI_PATH_FILE_NO_FILE    = 'Svuotare il percorso di archiviazione oppure compilare almeno il nome di un file!';
  A000MSG_A210_ERR_NO_PATH_FILE_SI_FILE    = 'Compilare il percorso di archiviazione oppure svuotare i nomi dei file!';
  A000MSG_A210_ERR_FORMATO_PDF             = 'Il nome del file in formato pdf deve terminare con .pdf''';
  A000MSG_A210_ERR_FORMATO_XML             = 'Il nome del file in formato xml deve terminare con .xml''';
  A000MSG_A210_ERR_FORMATO_JSON            = 'Il nome del file in formato json deve terminare con .json''';
  A000MSG_A210_ERR_NO_CAMPI_XML            = 'Compilare l''elenco dei campi da inserire nel file xml!';
  A000MSG_A210_ERR_NO_REGOLA_JSON          = 'Compilare la regola sql con i campi da inserire ne lfile json!';
  A000MSG_A210_ERR_NO_FILE_META_SI_CAMPI   = 'Compilare il nome del file di metadati o svuotare l''elenco dei campi!';
  A000MSG_A210_ERR_FMT_SINTASSI_NOMEFILE   = 'Errore di sintassi nel nome del file %s: %s';
  A000MSG_A210_ERR_NO_PATH_FILE            = 'Percorso di archiviazione non indicato!';
  A000MSG_A210_ERR_NO_VAR_TIPO_DOCUMENTO   = 'Il percorso di archivazione deve necessariamente includere la variabile "Tipo di documento" come prima variabile (es: C:\TEMP\:TIPODOCUMENTO\)!';
  A000MSG_A210_ERR_FMT_VAR_PATH            = 'La variabile %s indicata nel percorso di archiviazione non è gestita. Impossibile effettuare la sostituzione!';
  A000MSG_A210_ERR_FMT_VAR_PATH_NO_ANAG    = 'La variabile %s indicata nel percorso di archiviazione non è un dato anagrafico. Impossibile effettuare la sostituzione!';
  A000MSG_A210_ERR_FMT_ELENCO_NO_UGUALE    = 'L''abbinamento %s nell''elenco dei campi per il file xml non contiene il simbolo "="!';
  A000MSG_A210_ERR_FMT_ELENCO_NO_CAMPO_ANA = 'Nell''abbinamento %s dell''elenco dei campi per il file xml non è stato indicato il nome del dato anagrafico!';
  A000MSG_A210_ERR_FMT_ELENCO_NO_CAMPO_XML = 'Nell''abbinamento %s dell''elenco dei campi per il file xml non è stato indicato il nome del campo xml!';
  A000MSG_A210_ERR_FMT_ELENCO_NO_ANAG      = 'Il campo %s indicato nell''elenco dei campi per il file xml non è un dato anagrafico!';
  A000MSG_A210_ERR_FMT_ELENCO_VAR_SCON     = '%s non è una variabile valida.';
  A000MSG_A210_ERR_NO_LOCALE               = 'Per impostare i parametri di archiviazione remota è necessario impostare quelli di archiviazione locale!';
  A000MSG_A210_ERR_NO_SFTP_INFO            = 'Indicare i dati per il trasferimento via SFTP oppure svuotare il nome del server!';
  A000MSG_A210_ERR_NO_SFTP_SERVER          = 'Indicare il nome del server SFTP oppure svuotare i campi nome utente e password!';
  A000MSG_A210_ERR_NO_SFTP_SERVER_USER_PASS= 'Indicare i dati di accesso al server SFTP oppure svuotare il campo ''Cartella remota in cui copiare i file''!';
  A000MSG_A210_ERR_PSCP_NO_VALIDO          = 'Eseguibile di PSCP (%s) non trovato!';
  A000MSG_A210_ERR_PATH_ARCH_REMOTA        = 'Il percorso di archivazione remota deve terminare con / !';
  A000MSG_A210_ERR_NO_IMPOSTAZIONI_SFTP    = 'Nome / Indirizzo del server SFTP, nome utente o password non impostati. Verificare la configurazione in Interfacce\Regole archiviazione documenti';
  A000MSG_A210_ERR_NO_DIRECTORY_LOCALE     = 'La cartella %s non esiste.';
  A000MSG_A210_ERR_ERRORE_SFTP             = 'Si è veriicato il seguente errore durante il traferimento via SFTP: %s';
  A000MSG_A210_ERR_ERRORE_PSCP             = 'Errore nel trasferimento via SFTP della cartella %s. PSCP ha emesso l''errore: %s';
  A000MSG_A210_ERR_ALTRE_DIR_PRESENTI      = 'In %s sono presenti cartelle che non sono state create dall''ultima elaborazione. Svuotare il contenuto della cartella e avviare una nuova elaborazione!';
  A000MSG_A210_ERR_DIR_SPORCA              = 'La cartella %s contiene file che non sono in formato pdf o xml. Invio annullato!';
  A000MSG_A210_ERR_TEMP_PATH_NON_VALIDO    = 'Il percorso di archiviazione indicato nella maschera Regole archiviazione documenti non è valido. Controllarlo prima di proseguire.';
  A000MSG_A210_ERR_DIR_NO_CANCELLA         = 'La cartella %s contiene file che non sono PDF, XML o JSON. Impossibile cancellarla!';
  A000MSG_A210_ERR_DIR_ERR_CANCELLA        = 'Errore durante l''eliminazione dei contenuti della cartella %s';
  A000MSG_A210_ERR_JSON_NO_RECORD          = 'Record non trovato';
  A000MSG_A210_ERR_JSON_TROPPI_RECORD      = 'Trovato più di un record';
  A000MSG_A210_ERR_JSON_NO_FIELDS          = 'Nessuna colonna da utilizzare';

  A000MSG_B007_ERR_SINTASSI                = 'Sintassi non corretta per il nuovo valore.' + #13#10 +
                                             'Per ulteriori informazioni consultare l''help in linea.';
  A000MSG_B007_ERR_VAL_OLD_NON_PREVISTO    = 'Valore esistente non previsto!';
  A000MSG_B007_ERR_VAL_NEW_EMPTY           = 'Specificare il nuovo valore!';
  A000MSG_B007_ERR_DATO_AGG_EMPTY          = 'Selezionare il dato da aggiornare!';
  A000MSG_B007_ERR_NO_VALORI               = 'Specificare i nuovi valori da assegnare!';
  A000MSG_B007_ERR_CORRISPONDENZA_SINGOLA  = 'Indicare una sola corrispondenza ''Valore esistente - Nuovo valore''!';
  A000MSG_B007_ERR_DEFAULT                 = 'Specificare un solo valore di default!';
  A000MSG_B007_ERR_FMT_CANC_TAB            = 'Cancellazione %s terminata con anomalie';
  A000MSG_B007_ERR_FMT_DIP_NO_DATI         = 'Dipendente privo di dati (rapporto di lavoro: %s - %s)';
  A000MSG_B007_ERR_FMT_DIP_TAB             = 'Dipendente presente in tabella %s ma non in %s - progressivo: %s';
  A000MSG_B007_ERR_NO_MATRICOLA            = 'Selezionare almeno una matricola da cancellare!';
  A000MSG_B007_ERR_NO_TABELLA              = 'Nessuna tabella selezionata';
  A000MSG_B007_ERR_NO_CAUSALE              = 'Nessuna causale selezionata';
  A000MSG_B007_ERR_DATI_RICODIFICA         = 'Dati di ricodifica mancanti';
  A000MSG_B007_ERR_NO_CAUSALE_ASS          = 'Nessuna causale di assenza indicata';
  A000MSG_B007_ERR_SOLO_UN_DIP             = 'Impossibile effettuare l''unificazione per più di un dipendente!';
  A000MSG_B007_ERR_DATI_ANAG_UNIF          = 'Specificare i dati anagrafici per cui unificare!';
  A000MSG_B007_ERR_NO_MATR_UNIF            = 'Selezionare almeno una matricola da unificare!';
  A000MSG_B007_ERR_INDICARE_FILE_SCRIPT    = 'Selezionare il file contenente lo script da eseguire!';

  A000MSG_B007_DLG_CANCELLA_OK             = 'Codice cancellato correttamente';
  A000MSG_B007_DLG_RIPRISTINA_OK           = 'Codice ripristinato correttamente';
  A000MSG_B007_DLG_FMT_CONFERMA_STORICIZZA = 'Attenzione: verranno aggiornati i dati per i dipendenti selezionati' + #13#10 +
                                             '%s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_PERIODO_STORICIZZA  = 'nel periodo dal %s al %s.';
  A000MSG_B007_DLG_FMT_DAL_STORICIZZA      = 'a partire dal %s.';
  A000MSG_B007_DLG_FMT_CANC_DATI_DIP       = 'Verranno cancellati tutti i dati relativi a n. %s dipendenti selezionati.' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_ALL_TIMB_DIP        = 'Attenzione!'#13#10'Verranno riallineate le timbrature'#13#10'dal %s al %s'#13#10'per i %d dipendenti selezionati.'#13#10'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_CANC_DATI           = 'Attenzione!!! Verranno cancellati i dati delle tabelle ' + #13#10 +
                                             '%s' + #13#10 +
                                             'dalla data %s alla data %s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_CANC_SCHEDE_ANAG    = 'Confermi la cancellazione delle %s matricole selezionate?';
  A000MSG_B007_DLG_FMT_CANC_GIUST          = 'Attenzione!!! Verranno cancellati i giustificativi ' + #13#10 +
                                             '%s ' +
                                             'dalla data %s alla data %s' + #13#10 +
                                             '%s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_RICODIFICA          = 'Attenzione!!! Verranno ricodificati i Giustificativi %s ' + #13#10 +
                                             'dalla causale %s alla causale %s ' + #13#10 +
                                             'dalla data %s alla data %s ' + #13#10 +
                                             '%s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_RIALL_GIUST         = 'Verrà effettuato il riallineamento dei giustificativi corrispondenti' + #13#10 +
                                             'a partire dal %s per le %s anagrafiche selezionate.' + #13#10 +
                                             'L''elaborazione non considererà i giustificativi legati ai  familiari. ' + #13#10 +
                                             'Vuoi continuare?';

  A000MSG_B007_DLG_FMT_UNIFICAZIONE        = 'Confermi l''unificazione delle %s matricole selezionate sulla matricola di partenza ''%s'' ?';
  A000MSG_B007_DLG_FMT_RIPRISTINA_CODICE   = 'Ripristinare il codice "%s" ?';
  A000MSG_B007_DLG_FMT_RIPRISTINA_CODICI   = 'Ripristinare i codici "%s" ?';
  A000MSG_B007_DLG_FMT_CANCELLA_CODICE     = 'Cancellare definitavemente il codice "%s" ?';
  A000MSG_B007_DLG_FMT_CANCELLA_CODICI     = 'Cancellare definitavemente i codici "%s" ?';
  A000MSG_B007_DLG_FMT_RIDEF_RIPRISTINA    = 'Nella tabella "%s" esiste già il valore "%s".' + #13#10 +
                                             'Ridefinire il codice?';
  A000MSG_B007_DLG_FMT_UNIF_SERVIZIO       = 'Attenzione: la matricola di partenza %s non è in servizio alla Data di lavoro, mentre ' +
                                             'la matricola selezionata %s ha un periodo di servizio più recente. Confermi lo stesso l''unificazione?';

  A000MSG_B007_MSG_TUTTE_CAUS              = ', le Timbrature, le Schede Riepil., i Residui ';
  A000MSG_B007_MSG_DALLA_DATA              = 'Dalla data';
  A000MSG_B007_MSG_ALLA_DATA               = 'Alla data';
  A000MSG_B007_MSG_ERR_AGG_STORICO         = 'Decorrenza %s non aggiornata: %s %s diverso dal valore esistente %s';
  A000MSG_B007_MSG_NUM_DIP                 = 'per i %s dipendenti selezionati';

  A000MSG_B007_MSG_FMT_TUTTI_DIP_AZ        = 'L''operazione riguarda TUTTI i dipendenti dell''azienda %s';
  A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU  = 'Ricodifica causale su %s terminata con anomalie';
  A000MSG_B007_MSG_FMT_INI_RIALL_GIUST     = 'Inizio riallineamento giustificativi per n. %s anagrafiche';
  A000MSG_B007_MSG_FINE_RIALL_GIUST        = 'Fine riallineamento giustificativi';
  A000MSG_B007_MSG_DIP_MESSO_SERVIZIO      = 'ATTENZIONE: IL DIPENDENTE NON ERA IN SERVIZIO E ADESSO LO E'', CONTROLLARE!';
  A000MSG_B007_MSG_DIP_DISMESSO_SERVIZIO   = 'ATTENZIONE: IL DIPENDENTE ERA IN SERVIZIO E ADESSO NON LO E'' PIU'', CONTROLLARE!';
  A000MSG_B007_MSG_ANOM_PERIODI_SERVIZIO   = 'ATTENZIONE: ANOMALIE NEI PERIODI DI SERVIZIO, CONTROLLARE!';
  A000MSG_B007_MSG_PIU_PERIODI_SERVIZIO    = 'ATTENZIONE: PIU'' PERIODI DI SERVIZIO APERTI, CONTROLLARE!';
  A000MSG_B007_MSG_FMT_TAB_DIPENDENTE      = 'Elenco delle prime 5 tabelle in cui è presente il dipendente: %s';
  A000MSG_B007_MSG_FMT_CANC_ERRORE         = 'Cancellazione %s terminata con errore %s';
  A000MSG_B007_MSG_UNIF_PERIODI_INTERSECANTI='Unificazione impossibile: sono presenti periodi di servizio (assunz.,cessaz.) intersecanti';
  A000MSG_B007_MSG_UNIF_PRESENZA_442        = 'Unificazione impossibile: sono presenti record di P442 con origine ''P'' o ''C'' (data cedolino %s, data retribuzione %s) su cedolini di anni esistenti anche sulla matricola di partenza';
  A000MSG_B007_MSG_FMT_UNIF_ANNO            = 'Unificazione impossibile: sono già presenti record di P504 con stesso anno (%s)';
  A000MSG_B007_MSG_FMT_UNIF_PRESENZA_441    = 'Unificazione impossibile: sono già presenti record di P441 con stessa data cedolino (%s), data retribuzione (%s), tipo_cedolino %s e record di P442 con origine ''P'' o ''C''';
  A000MSG_B007_MSG_FMT_ERR_254              = 'Unificazione fallita: aggiornamento P254_VOCIPROGRAMMATE terminato con errore %s';
  A000MSG_B007_MSG_FMT_ERR_262              = 'Unificazione fallita: aggiornamento P262_MOD730TESTATA terminato con errore %s';
  A000MSG_B007_MSG_FMT_PERIODO_STORICO      = 'Unificazione fallita: creazione periodo storico %s - %s terminata con errore %s';
  A000MSG_B007_MSG_PERIODI_STIP_ANTE        = 'Unificazione fallita: ci sono più periodi stipendiali antecenti il primo periodo storico';
  A000MSG_B007_MSG_FMT_PERIODO_STIPENDIALE  = 'Unificazione fallita: creazione periodo stipendiale %s - %s terminata con errore %s';
  A000MSG_B007_MSG_FMT_AGG_PERIODO_STIPENDIALE  = 'Unificazione fallita: aggiornamento  periodo stipendiale %s - %s terminata con errore %s';
  A000MSG_B007_MSG_FMT_ALL_STORICI          = 'Allineamento periodi storici terminato con errore %s';
  A000MSG_B007_MSG_FMT_ALL_STIPENDIALI      = 'Allineamento periodi stipendiali terminato con errore %s';
  
  A000MSG_B023_ERR_PRIVILEGI_INSUFF         ='L''utente non dispone dei privilegi necessari per eseguire questa applicazione.';
  A000MSG_B023_ERR_PERCORSO_INVALIDO        ='Percorso specificato non valido.';
  A000MSG_B023_ERR_NO_DIR_O_PERC_INVALIDO   ='Il percorso specificato non esiste o non è valido.';
  A000MSG_B023_ERR_DIR_ENUM                 ='Errore durante l''enumerazione dei file nella cartella specificata.';
  A000MSG_B023_DLG_NO_SOLO_PDF              ='La cartella specificata contiene uno o più file non in formato PDF. Proseguendo saranno processati solo i file PDF.' + #10#13 + 'Continuare?';
  A000MSG_B023_MSG_ELAB_OK                  ='Elaborazione terminata.';
  A000MSG_B023_MSG_ELAB_ABORT               ='Operazione annullata.';
  A000MSG_B023_DLG_ELAB_ANOM                ='Elaborazione terminata con anomalie. Si desidera visualizzarle?';
  A000MSG_B023_DLG_INTERR_ELAB              ='Interrompere l''operazione in corso?';
  A000MSG_B023_DLG_CIFR_AVVIO               ='Stanno per essere cifrati %d file. Assicurarsi che tali file non siano già cifrati prima di continuare.' + #10#13 + 'Proseguire con l''operazione?';
  A000MSG_B023_DLG_DECIFR_AVVIO             ='Stanno per essere decifrati %d file. Assicurarsi che tali file non siano già decifrati prima di continuare.' + #10#13 + 'Proseguire con l''operazione?';
  A000MSG_B023_ERR_NO_HASH                  ='Operazione al momento non supportata.';
  A000MSG_B023_ERR_NO_PDF                   ='La cartella specificata non contiene alcun file pdf.';


  A000MSG_C700_ERR_NO_SELEZIONE            = 'Specificare il nome della selezione';
  A000MSG_C700_ERR_SELEZIONE_INESISTENTE   = 'Selezione inesistente';
  A000MSG_C700_ERR_FMT_SEL_GIA_ESISTENTE   = 'Selezione ''%s'' già esistente: impossibile sovrascrivere!';
  A000MSG_C700_DLG_FMT_SEL_GIA_ESISTENTE   = 'Selezione ''%s'' già esistente: sovrascrivere?';

  //Messaggi dei progetti CONDIVISI

  A000MSG_P032_ERR_COEFF_INVALIDO          = 'Impostare un coefficiente di cambio significativo!';

  A000MSG_P050_ERR_COD_VALUTA              = 'Codice valuta obbligatorio!';
  A000MSG_P050_ERR_COD_ARROTONDAMENTO      = 'Impossibile procedere perchè esistono delle valute legate a questo codice arrotondamento!';

  A000MSG_P501_ERR_DATE_INCONGRUENTI       = 'Le date di inizio e fine periodo per la dichiarazione relativa alle detrazioni IRPEF devono essere entrambe valorizzate o svuotate!';
  A000MSG_P501_ERR_DATE_ORDINATE           = 'Le date di inizio e fine periodo per la dichiarazione relativa alle detrazioni IRPEF devono essere in ordine cronologico!';
  A000MSG_P501_ERR_FMT_DATE_RANGE          = 'Le date di inizio e fine periodo per la dichiarazione relativa alle detrazioni IRPEF devono essere interne all''anno %s !';
  A000MSG_P501_ERR_DATA_FIRMA_CU           = 'Specificare la data firma CU per la stampa da web!';
  A000MSG_P501_ERR_FILEPDF_INESISTENTE     = 'Il percorso dell''archivio dei singoli cedolini in formato PDF è inesistente!';
  A000MSG_P501_ERR_PATH_FILE_MASSIVO       = 'Il percorso del file di esportazione della stampa massiva dei cedolini in formato PDF è inesistente!';
  A000MSG_P501_ERR_FORMATO_FILE_MASSIVO    = 'L''estensione del file di esportazione della stampa massiva dei cedolini deve essere .PDF!';

  A000MSG_P651_ERR_NO_CDC                  = 'Non è specificato il campo Centro di costo percentualizzato in Gestione Aziende!';
  A000MSG_P651_ERR_FMT_NO_FLUPER           = 'Non è specificato il campo %s sulle Regole fornitura FLUPER!';
  A000MSG_P651_ERR_FMT_FLUPER              = 'E'' specificato più di un campo %s sulle Regole fornitura FLUPER!';
  A000MSG_P651_ERR_INS_NO_NOMEFLUSSO       = 'Impossibile inserire una relazione senza specificare la tipologia!';
  A000MSG_P651_MSG_ANOMALIE                = 'Attenzione! Sono state rilevate le seguenti anomalie.' + #13#10;
  A000MSG_P651_MSG_FMT_PERCENTUALE_1       = #13#10 + 'Il valore %s nel periodo %s-';
  A000MSG_P651_MSG_FMT_PERCENTUALE_2       = '%s è relazionato al %s%%';
  A000MSG_P651_DLG_EXIT_ANOMALIE           = 'Uscire senza correggere le anomalie segnalate?';

  //Messaggi dei progetti PAGHE

  A000MSG_P000_MSG_DATO_UTILIZZATO         = 'Il dato viene comunque utilizzato.';
  A000MSG_P000_MSG_DATO_SALVATO            = 'Il dato viene comunque salvato.';
  A000MSG_P000_MSG_DATI_SALVATI            = 'I dati vengono comunque salvati.';
  A000MSG_P000_ERR_VOCE_INESISTENTE        = 'Voce non esistente!';
  A000MSG_P000_ERR_FMT_NUMERO_RATE         = 'Il numero di rate deve essere un valore intero compreso tra 1 e %s!';
  A000MSG_P000_ERR_FMT_DATO_MIN_ZERO       = 'Attenzione: %s deve essere maggiore di zero!';
  A000MSG_P000_ERR_FMT_DATO_MAG_CENTO      = 'Attenzione: %s deve essere minore di 100!';
  A000MSG_P000_ERR_FMT_QUERYVOCE           = 'Non esiste la voce Contratto=%s Voce=%s Decorrenza(cassa)=%s Decorrenza(competenza)=%s.';
  A000MSG_P000_ERR_PERIODO                 = 'La data finale deve essere maggiore o uguale alla data iniziale!';
  A000MSG_P000_ERR_FMT_VAL_NUMERICO        = '%s errato! Il valore inserito deve essere numerico!';
  A000MSG_P000_ERR_MESE_CEDOLINO           = 'Mese cedolino errato!';
  A000MSG_P000_ERR_DATA_EMISSIONE          = 'Data emissione errata!';
  A000MSG_P000_ERR_MESE_ELAB               = 'Indicare un mese di elaborazione valido!';
  A000MSG_P000_ERR_DATI_AZIENDALI          = 'Non esistono i dati aziendali per l''anno ';
  A000MSG_P000_ERR_FMT_NO_DATI_EXPO        = 'Non esistono dati %s da esportare per il mese indicato!';
  A000MSG_P000_ERR_FMT_NO_DATI_EXPO_ANNO   = 'Non esistono dati %s da esportare per l''anno indicato!';
  A000MSG_P000_ERR_CED_CHIUSO_SUCC         = 'Esiste almeno un cedolino chiuso con data retribuzione successiva al Mese cedolino impostato.' + #13#10 +
                                             'L''operazione per il mese indicato non può essere effettuata!';
  A000MSG_P000_DLG_FMT_CED_CHIUSO          = 'Esiste almeno un cedolino chiuso con data retribuzione uguale al Mese cedolino impostato.' + #13#10 +
                                             'Verificare attentamente la correttezza del mese indicato.' + #13#10 +
                                             'Confermi la registrazione delle voci variabili per il mese cedolino %s';
  A000MSG_P000_DLG_FMT_CED_SUCCESSIVO_1    = 'Il mese cedolino impostato è successivo al mese per il quale si stanno ancora elaborando i cedolini.';
  A000MSG_P000_DLG_FMT_CED_SUCCESSIVO_2A   = 'Se si intende proseguire comunque, confermare il mese cedolino sul quale registrare i dati:';
  A000MSG_P000_DLG_FMT_CED_SUCCESSIVO_2B   = 'Si intende proseguire comunque? (Se sì, confermare il mese cedolino sul quale registrare i dati)';
  A000MSG_P000_ERR_FILTRO_DIP              = 'Filtro dipendenti errato!';

  A000MSG_P002_MSG_FMT_CREAZIONE_IN_CORSO  = 'Creazione tabelle anno %s in corso...';
  A000MSG_P002_MSG_FMT_GENERAZ_IN_CORSO    = 'Generazione reddito anno %s in corso...';

  A000MSG_P010_ERR_ABI_ESISTENTE           = 'ABI già esistente!';
  A000MSG_P010_ERR_BIC                     = 'Specificare il codice BIC della banca estera!';
  A000MSG_P010_ERR_CODICE_BIC              = 'Il codice della banca estera deve essere uguale al BIC!';
  A000MSG_P010_ERR_NAZIONE                 = 'Specificare la nazione IBAN!';
  A000MSG_P010_ERR_CODICE                  = 'Il codice della banca italiana deve essere uguale a ABI_CAB.';
  A000MSG_P010_ERR_BIC_IT                  = 'Il dato BIC è previsto solo per le banche estere (Nazione IBAN diversa da ''IT'').';

  A000MSG_P016_ERR_NO_FILE_CSV             = 'Il formato del file contenente le voci programmate da importare deve essere .csv!';
  A000MSG_P016_ERR_FILE_NUM_COLONNE        = 'Impossibile elaborare il file! Il file contiene un numero di colonne non corretto!';

  A000MSG_P022_MSG_CF_NO_VUOTO             = 'Il Codice fiscale deve essere vuoto!';
  A000MSG_P022_MSG_CF_UGUALE_CODICE        = 'Il Codice fiscale deve essere uguale al Codice!';

  A000MSG_P042_DLG_FMT_SCAGLIONI           = 'Confermi l''inserimento degli scaglioni IRPEF %s?';
  A000MSG_P042_ERR_IMPORTI                 = 'L''importo "Da" non deve superare l''importo "A"!';
  A000MSG_P042_ERR_FASCE                   = 'Intersezione tra le fasce!';
  A000MSG_P042_ERR_ULTIMO_IMP              = 'L''ultimo importo "A" deve essere a zero!';
  A000MSG_P042_MSG_SUPERO_SOGLIA           = 'L''addizionale supera la soglia di %s%%.';

  A000MSG_P092_ERR_POSIZIONE               = 'Il campo Posizione deve rispettare il seguente formato: xxxxxxxx/xx';
  A000MSG_P092_ERR_MINIM_MASSIM            = 'Il minimale non deve superare il massimale!';
  A000MSG_P092_ERR_RETR_MINIMALE           = 'Specificare la retribuzione minimale giornaliera!';
  A000MSG_P092_ERR_ORE_MESE                = 'Specificare le ore del mese ad orario normale!';
  A000MSG_P092_ERR_ACC_VOCI                = 'Specificare l''accorpamento voci per il calcolo retribuzione orario tabellare!';
  A000MSG_P092_ERR_FMT_ORE_MIN_ZERO        = 'Attenzione: le ore %s devono essere maggiori di zero!';

  A000MSG_P191_ERR_STESSA_POSIZIONE        = 'Modifiche fallite: Più dati con la stessa posizione';
  A000MSG_P191_ERR_FORMATO_DATA            = 'Formato per data non valido!';
  A000MSG_P191_ERR_FMT_DATO_OBBL           = 'Manca la definizione del dato obbligatorio: %s %s';
  A000MSG_P191_ERR_POSIZIONE_LUNGHEZZA     = 'Errore nella definizione di posizione o lunghezza dei dati';
  A000MSG_P191_ERR_MANCA_NOME_COLONNA      = 'Trattandosi di Tabella ORACLE devono essere indicati tutti i nomi delle colonne';
  A000MSG_P191_ERR_DATO_RIPETUTO           = 'Risulta ripetuto un tipo di dato';

  A000MSG_P192_ERR_MESE                    = 'Indicare un mese valido!';
  A000MSG_P192_ERR_STATO                   = 'Stato importazione voce non valido!';
  A000MSG_P192_ERR_ECCEZIONI_IRPEF         = 'Impossibile impostare contemporaneamente più eccezioni di calcolo relative all''IRPEF!';
  A000MSG_P192_ERR_FMT_ACQUISIZIONE        = 'Errore durante l''acquisizione: %s';
  A000MSG_P192_ERR_FMT_COLONNA_CSV         = 'La colonna ''%s'' prevista nei Parametri non è presente sulla prima riga del file csv';
  A000MSG_P192_ERR_FILE                    = 'Indicare il Nome file!';
  A000MSG_P192_ERR_NO_FILE_CSV             = 'Il formato del file contenente le voci da importare deve essere .csv!';
  A000MSG_P192_MSG_TABELLA_ESISTENTE       = 'Tabella esistente!';
  A000MSG_P192_ERR_TABELLA_INESISTENTE     = 'Tabella inesistente!';
  A000MSG_P192_DLG_FUNZIONE_IN_USO         = 'Vuoi forzare il proseguimento nell''utilizzo della funzione anche se risulta già in uso?';
  A000MSG_P192_DLG_FMT_ACQUISISCI_PA       = 'Confermi acquisizione transitoria delle voci variabili del file %s per il mese cedolino %s?';
  A000MSG_P192_DLG_FMT_CANCELLA_PA         = 'Confermi la cancellazione delle acquisizioni transitorie per mese cedolino %s?';
  A000MSG_P192_DLG_FMT_REGISTRA_TUTTE      = 'Sono già state caricate TUTTE le %s voci caricabili (evidenziate nella griglia).' + #13#10 +
                                             'Confermi una nuova acquisizione transitoria delle voci variabili per il mese cedolino %s?' + #13#10 + #13#10 +
                                             '<Yes> Inserisci nuovamente le voci' + #13#10 + '<No> Annulla operazione';
  A000MSG_P192_DLG_FMT_REGISTRA_ALTRE      = 'Sono già state caricate %s voci (evidenziate nella griglia) su %s voci caricabili.' + #13#10 +
                                             'Confermi una nuova acquisizione transitoria di TUTTE le voci variabili per il mese cedolino %s?' + #13#10 + #13#10 +
                                             '<Yes> Inserisci TUTTE le voci caricabili' + #13#10 + '<No> Inserisci SOLO le voci non caricate' + #13#10 + '<Cancel> Annulla operazione';
  A000MSG_P192_DLG_FMT_CANCELLA_AD_VIS     = 'Confermi la cancellazione dal cedolino del mese di %s delle sole voci presenti nella griglia di visualizzazione per tutti i dipendenti selezionati?';
  A000MSG_P192_DLG_FMT_CANCELLA_AD_VIS_SEL = 'Confermi la cancellazione dal cedolino del mese di %s delle voci %s presenti nella griglia di visualizzazione per tutti i dipendenti selezionati?';
  A000MSG_P192_DLG_FMT_CANCELLA_AD         = 'Attenzione: la cancellazione comporta l''eliminazione di %s righe, quindi TUTTE le voci variabili del cedolino di %s importate da TUTTI i file già elaborati per tutti i dipendenti selezionati. Confermi l''operazione?';
  A000MSG_P192_DLG_FMT_CANCELLA_AD_SEL     = 'Attenzione: la cancellazione comporta l''eliminazione di %s righe, quindi le voci %s del cedolino di %s importate da TUTTI i file già elaborati per tutti i dipendenti selezionati. Confermi l''operazione?';
  A000MSG_P192_DLG_CAMBIA_STATO            = 'Confermi trasformazione di tutti i movimenti allo stato impostato?';

  A000MSG_P200_ERR_NO_CEDOLINO_NORMALE     = 'Per attivare la riduzione, l''unità di misura deve essere di tipo quantità a giorni';
  A000MSG_P200_ERR_DIV_QUOTE               = 'Attenzione: il dato ''Divisore quote'' deve essere maggiore di zero!';
  A000MSG_P200_DLG_RID_TRED                = 'Attenzione: l''assenza riduce i giorni delle voci in quota ma non abbatte integralmente la tredicesima. ' + #13#10 +
                                             'Il dato viene comunque salvato.';

  A000MSG_P200_ERR_VOCE_QUOTA              = 'La voce in quota deve essere diversa dalla voce da quotare!';
  A000MSG_P200_DLG_PCT_ACCUMULO            = 'Attenzione: per le assenze che riducono i giorni delle voci in quota, la percentuale di accumulo vale, di norma, -100. Il dato viene comunque salvato';

  A000MSG_P201_ERR_VOCI                    = 'La voce padre deve essere diversa dalla voce figlio!';
  A000MSG_P201_ERR_VOCE_ASSOGG             = 'La voce da aggiungere non è compresa tra i codici previsti e cioè con raggruppamento assoggettamento valorizzato';
  A000MSG_P201_ERR_PROTETTA                = 'La voce da aggiungere fa parte di un raggruppamento assoggettamento bloccato, per cui non può essere inserita come assoggettamento della voce che a sua volta risulta protetta';

  A000MSG_P208_DLG_CANCELLA_INFO           = 'Cancellare tutte le informazioni esterne per la combinazione di Tipo/Dato selezionata?';
  A000MSG_P208_DLG_INSERISCI_INFO          = 'Acquisire le  nuove informazioni esterne cancellando quelle esistenti per la combinazione di Tipo/Dato selezionata?';
  A000MSG_P208_ERR_FMT_NO_CF               = 'Nessun dipendente trovato con codice fiscale %s, informazione non acquisita';
  A000MSG_P208_ERR_FMT_CF_GENERICO         = 'Errore durante l''acquisizione dell''informazione per il codice fiscale %s: %s';

  A000MSG_P212_ERR_ABB_ASSENZA_ASS_CESS    = 'Tipo maturazione per assunzione/cessazione o assenza con abbattimento complessivo incompatibile con Tipo di abbattimento in caso di assenza';

  A000MSG_P214_MSG_CONTROLLO_OK            = 'Non sono state riscontrate anomalie durante il controllo delle voci';
  A000MSG_P214_DLG_FMT_CANCELLA            = 'Attenzione: la cancellazione comporta l''eliminazione dell''accorpamento contenente %s voci. Confermi l''operazione?';
  A000MSG_P214_DLG_FMT_INSVOCI             = 'Confermi l''inserimento delle voci selezionate?';
  A000MSG_P214_ERR_COD_CONTRATTO           = 'Specificare il codice del Contratto voci!';

  A000MSG_P216_ERR_PROTETTO                = 'Accorpamento non utilizzabile perchè protetto!';

  A000MSG_P228_ERR_FMT_COD_CATEGORIA       = 'Indicare il Codice categoria %s!';
  A000MSG_P228_ERR_COD_POSIZIONE_ECONOMICA = 'Indicare il Codice posizione economica per la voce da ripartire!';
  A000MSG_P228_ERR_FMT_COD_VOCE            = 'Indicare il Codice voce %s!';
  A000MSG_P228_ERR_COD_VOCE_TIT_SOST       = 'Il Codice voce per titolare deve essere diverso dal codice voce per sostituto!';
  A000MSG_P228_ERR_PERC_MENSILE            = 'Indicare la percentuale spettante al sostituto per tutti i mesi dell''anno!';
  A000MSG_P228_ERR_PERC_RANGE              = 'La percentuale spettante al sostituto deve essere maggiore di 0 e minore/uguale a 100 per tutti i mesi dell''anno!';

  A000MSG_P232_ERR_MENSILITA_ANNUE         = 'Il numero di mensilità annue deve essere compreso tra 12 e 14 !';
  A000MSG_P232_ERR_NO_VOCE_CONGUAGLIO      = 'Inserire la voce di conguaglio';
  A000MSG_P232_ERR_MASSIMALE1              = 'Il dato ''Massimale 1'' deve essere maggiore di zero!';
  A000MSG_P232_ERR_MASSIMALE2              = 'Il dato ''Massimale 2'' deve essere maggiore di zero!';
  A000MSG_P232_ERR_NO_MASSIMALI            = 'Specificare almeno un massimale!';
  A000MSG_P232_ERR_RIPART_ONERE_CARICO     = 'Specificare tutte le voci richieste per la ripartizione onere carico dipendente/ente!';
  A000MSG_P232_ERR_IMPORTO_DA              = 'L''importo "Da" non deve superare l''importo "A"!';
  A000MSG_P232_ERR_INTERSEZIONE_FASCE      = 'Intersezione tra le fasce';
  A000MSG_P232_ERR_ULTIMO_IMPORTO_A        = 'L''ultimo importo "A" deve essere a zero';

  A000MSG_P239_DLG_PRECALCOLO_ESEGUITO     = 'Se nel periodo selezionato è presente un mese ancora da chiudere occorre averne eseguito almeno il precalcolo. Confermi prosecuzione?';
  A000MSG_P239_DLG_CHIUSURA_ASSEGNO        = 'Confermi l''operazione di chiusura dell''assegno dei dipendenti selezionati alla data indicata?';
  A000MSG_P239_MSG_ELAB_TERM_VARIAZIONI    = 'Elaborazione terminata %s variazioni.';

  A000MSG_P253_ERR_DATA_RICEZIONE          = 'Indicare la data di ricezione.';
  A000MSG_P253_ERR_FILE_NON_VALIDO         = 'File di importazione non valido, privo di elementi ''Documento_730-4''!';
  A000MSG_P253_DLG_SALVA_EXCEL             = 'Attenzione: se non si è proceduto a salvare i dati in Excel si consiglia di procedere in tal senso. Confermi comunque la chiusura?';
  A000MSG_P253_DLG_AVVERTIMENTI            = '%s avvertimenti che possono richiedere interventi manuali da parte dell''operatore. %s';

  A000MSG_P254_MSG_ANOMALIE                = 'Sono presenti anomalie. Premere il pulsante Anomalie per visualizzarle!';
  A000MSG_P254_ERR_AMM_INPDAP              = 'Tutti i campi del piano ammortamento INPDAP sono obbligatori!';
  A000MSG_P254_ERR_PERIODO                 = 'La data finale deve essere maggiore o uguale alla data iniziale';
  A000MSG_P254_ERR_PERIODICITA             = 'La periodicità della rata deve essere compresa tra 1 e 12!';
  A000MSG_P254_ERR_COMPETENZA              = 'Il mese fisso di competenza deve essere minore o uguale alla data di inizio!';
  A000MSG_P254_ERR_MESI_COMPETENZA_PREC    = 'Il numero mesi precedenti la data di retribuzione deve essere maggiore di zero!';
  A000MSG_P254_ERR_COMPETENZA_VOCE         = 'Mese fisso di competenza non inseribile per voce diversa da ''Retribuzione base'' o ''Altro''!';
  A000MSG_P254_ERR_MESIPREC_VOCE           = 'Numero mesi precedenti la data di retribuzione non inseribile per voce diversa da ''Retribuzione base'' o ''Altro''!';
  A000MSG_P254_ERR_COMPETENZA_QM           = 'Mese fisso di competenza non inseribile per voce con unità di misura di formato ''Quantità mensile''!';
  A000MSG_P254_ERR_MESIPREC_QM             = 'Numero mesi precedenti la data di retribuzione non inseribile per voce con unità di misura di formato ''Quantità mensile''!';
  A000MSG_P254_ERR_RATA                    = 'Attenzione: l''importo della rata è nullo!';
  A000MSG_P254_ERR_IMPORTO_TOTALE          = 'Attenzione: l''importo totale è nullo con voce particolare da saldare ai cessati!';
  A000MSG_P254_ERR_SALDATA                 = 'La voce programmata deve essere impostata come saldata!';
  A000MSG_P254_ERR_INCR_RATA               = 'Attenzione: l''importo massimo dell''incremento su ultima rata è da intendersi in valore assoluto e quindi inserire solo valori positivi!';
  A000MSG_P254_ERR_IMPORTO_INCR_RATA       = 'Attenzione: l''importo massimo dell''incremento su ultima rata non può superare l''importo della rata stessa!';
  A000MSG_P254_ERR_BENEFICIARIO            = 'Non è possibile specificare il beneficiario quando l''importo rata è zero!';
  A000MSG_P254_MSG_NUOVI_IMPORTI           = 'Attenzione: Importo rata a zero, non verrano aperte nuove posizioni per la voce.';
  A000MSG_P254_MSG_INTERSEZIONE            = 'Attenzione: la voce è già prevista su un altro periodo intersecante la Data inizio - Data fine. Il dato viene comunque salvato.';
  A000MSG_P254_MSG_DATA_FINE               = 'Attenzione: la Data fine non coincide con la fine del mese. Il dato viene comunque salvato.';
  A000MSG_P254_MSG_DATA_INIZIO             = 'Attenzione: la Data inizio non coincide con l''inizio del mese. Il dato viene comunque salvato.';
  A000MSG_P254_MSG_PIANO_AMM_INPDAP        = 'Attenzione: non è stato inserito il piano di ammortamento INPDAP. Il dato viene comunque salvato.';
  A000MSG_P254_MSG_PIANO_AMM               = 'Attenzione: la voce prevede un piano di ammortamento INPDAP. Il dato viene comunque salvato.';
  A000MSG_P254_MSG_COMP_ANNI               = 'Attenzione: impostata una competenza precedente superiore a due anni. Il dato viene comunque salvato';
  A000MSG_P254_DLG_FMT_DEL_VOCE_PROG       = 'La voce programmata per il dipendente %s %s matr. %s' + #13#10 +
                                             'non è stata cancellata in quanto non univoca';
  A000MSG_P254_MSG_FMT_MESI_PREC           = 'Attenzione: non è stato impostato il N. mesi precedenti data retribuzione al valore 1 come già effettuato per la matricola %s.' + #13#10 +
                                             'Sono possibili dei problemi nel calcolo della corretta competenza dei contributi. Il dato viene comunque salvato';
  A000MSG_P254_MSG_FMT_ELAB                = 'Elaborazione terminata righe elaborate: %s';
  A000MSG_P254_MSG_FMT_ELAB_RIAP           = 'Elaborazione terminata righe elaborate: %s' + #13#10 +
                                             'voci riaperte: %s';
  A000MSG_P254_DLG_FMT_AGG_FILTRO          = 'Dipendenti selezionati: %s. ' + #13#10 +
                                             'Confermi l''aggiornamento dei dati %s' + #13#10 +
                                             'utilizzando come filtro di ricerca i campi %s' + #13#10 +
                                             'per tutti i dipendenti selezionati ?';
  A000MSG_P254_DLG_FMT_CANC_FILTRO         = 'Dipendenti selezionati: %s' + #13#10 +
                                             'Confermi la cancellazione delle voci programmate ' + #13#10 +
                                             'che rispondono al filtro di ricerca %s per tutti i dipendenti selezionati ? ';
  A000MSG_P254_DLG_FMT_INSERIMENTO         = 'Dipendenti selezionati: %s' + #13#10 +
                                             'Confermi l''inserimento dei dati per tutti i dipendenti selezionati ?';
  A000MSG_P254_DLG_FMT_VOCE_PROG           = 'La voce programmata per il dipendente %s %s matr. %s' + #13#10 +
                                             'non è stata aggiornata in quanto non univoca';

  A000MSG_P258_DLG_ENTE_VERSAMENTO         = 'L''Ente versamento non è riferibile all''Ente: tale incongruenza comporterà un errore nel versamento dell''addizionale. Annullare la modifica?';
  A000MSG_P258_MSG_MODIF_ENTE_VERSAMENTO   = 'Attenzione: la modifica dell''Ente versamento può determinare una incongruenza sugli F24EP dell''anno già versati!';

  A000MSG_P261_ERR_PERC                    = 'La percentuale di rimborso a Luglio è %s solo nel caso in cui non sia ancora iniziata l''assistenza fiscale dell''anno!';
  A000MSG_P261_ERR_PERC_RIMB               = 'Specificare la percentuale rimborso!';
  A000MSG_P261_ERR_PERC_RIMB_NO_VAL        = 'Percentuale rimborso non valida!';
  A000MSG_P261_ERR_TIPI_IMPORTI            = 'Specificare i tipi importi per i quali impostare la percentuale rimborso!';
  A000MSG_P261_ERR_FMT_IMP_PERC_RIMB       = 'Attenzione: verrà impostata la percentuale rimborso %s sugli importi %s per l''anno %s per i dipendenti selezionati. Continuare?';
  A000MSG_P261_ERR_FMT_ANN_PERC_RIMB       = 'Attenzione: verrà annullata la percentuale rimborso per l''anno %s per i dipendenti selezionati. Continuare?';
  A000MSG_P261_MSG_IMPOST                  = 'Impostazione in corso...';
  A000MSG_P261_MSG_ANNULL                  = 'Annullamento in corso...';

  A000MSG_P262_ERR_COD_CAAF                = 'Specificare il codice C.A.F.!';
  A000MSG_P262_ERR_DATA_RICEZIONE          = 'Specificare la data ricezione!';
  A000MSG_P262_ERR_DATA_MOTIVO_RETTIF      = 'Il Codice motivo rettificativo deve essere compilato se è stata indicata la Data ricezione rettificativo!';
  A000MSG_P262_ERR_DATA_MOTIVO_INTEGR      = 'Il Codice motivo integrativo deve essere compilato se è stata indicata la Data ricezione integrativo!';
  A000MSG_P262_ERR_NO_ENTE                 = 'Specificare il codice ente!';
  A000MSG_P262_ERR_PERC_MAG_100            = 'Attenzione: la percentuale di rimborso a Luglio deve essere minore di 100!';
  A000MSG_P262_ERR_PERC_VAL_RIMB           = 'La percentuale di rimborso a Luglio è valorizzabile solo per gli importi da rimborsare nel mese stesso!';
  A000MSG_P262_ERR_PERC_VAL_ASSFISC        = 'La percentuale di rimborso a Luglio è valorizzabile solo nel caso in cui non sia ancora iniziata l''assistenza fiscale dell''anno!';
  A000MSG_P262_ERR_IMP_INIZIALE            = 'l''Importo iniziale è uguale a zero';
  A000MSG_P262_ERR_FMT_DATO_AUTOMATICO     = '%s deve essere gestito automaticamente dal programma';
  A000MSG_P262_ERR_DIMESSO                 = 'è stata assegnata una voce di trattenuta ad un dimesso prima del 30 Giugno e pertanto non verrà inserita nel cedolino di Luglio.';
  A000MSG_P262_ERR_IMPORTI_FISSI_NEG       = 'Gli Importi fissi per incapienza stipendiale non possono essere negativi!';
  A000MSG_P262_ERR_NO_CANC_MOD_LIQUID      = 'Il modello 730 non si può eliminare in quanto è già iniziata la sua liquidazione!';
  A000MSG_P262_ERR_NO_CANC_TIPO_IMP_LIQUID = 'Il tipo importo modello 730 non si può eliminare in quanto è già iniziata la sua liquidazione!';

  A000MSG_P265_ERR_RITENUTA_NO_PROF         = 'Esiste ritenuta O.N.A.O.S.I. in assenza di professione O.N.A.O.S.I. su anagrafica';
  A000MSG_P265_ERR_PROF_NO_RIT              = 'Esiste professione O.N.A.O.S.I. su anagrafica in assenza di ritenuta O.N.A.O.S.I.';
  A000MSG_P265_ERR_DIP_CESSATO              = 'Dipendente cessato nel semestre senza tipo cessazione O.N.A.O.S.I. su anagrafica';
  A000MSG_P265_ERR_FMT_PARAMETRI_STIP       = 'Non esistono i parametri stipendio dell''area contrattuale %s alla data %s';


  A000MSG_P268_ERR_VOCE_NO_ELENCO          = 'L''inserimento di questa voce non è previsto!';
  A000MSG_P268_ERR_VOCE_DUPLICATA          = 'Voce già caricata!';
  A000MSG_P268_ERR_FMT_PERC_RITENUTA       = '- la ritenuta %s non corrisponde al %s%% di %s';
  A000MSG_P268_MSG_RITENUTE                = '- si ricorda che l''importo delle ritenute deve essere coerente con gli imponibili, in applicazione dei corretti scaglioni e percentuali';
  A000MSG_P268_ERR_FMT_VOCI_CONGUAGLIO     = '- ai fini del corretto conguaglio è obbligatorio inserire tutte le voci %s';
  A000MSG_P268_ERR_FMT_VOCI_CONG_PRIVATO   = '- se non si inseriscono tutte le voci %s, si intende che il precedente rapporto di lavoro è un''azienda privata';
  A000MSG_P268_ERR_FMT_VOCI_IMPONIBILE     = 'Le voci %s devono avere tutte lo stesso imponibile!';
  A000MSG_P268_ERR_FMT_DATO_MIN_ZERO       = 'Il valore del dato ''%s'' deve essere maggiore o uguale a zero!';
  A000MSG_P268_ERR_DECOR_ANAG              = 'Verificare che la decorrenza sull''anagrafica stipendiale del dipendente sia antecedente al Mese cedolino inserito.';
  A000MSG_P268_ERR_GG_DETRAZ               = 'Esiste già il cedolino normale per Gennaio: impossibile caricare anche i giorni lavoro dipendente.' + #13#10 + 'Azzerarli e modificare manualmente GGDLD del mese stesso.';
  A000MSG_P268_ERR_CEDOLINO_GIA_ESISTENTE  = 'Esiste già il cedolino normale per il mese: impossibile caricare anche il cedolino del rapporto precedente.' + #13#10 +
                                             'Inserire quest''ultimo su Gennaio o sul mese precedente al primo cedolino elaborato nell''anno';
  A000MSG_P268_MSG_INS_FAM                 = '- occorre inserire i familiari a carico con decorrenza da inizio anno';
  A000MSG_P268_MSG_CF_MANCANTE             = '- non avendo indicato il Codice fiscale del soggetto che ha corrisposto il reddito esso si intende prodotto all''interno dell''azienda stessa ' +
                                             'e, pertanto, non sarà oggetto di denuncia sui modelli CU nella sezione ''REDDITI EROGATI DA ALTRI SOGGETTI''';
  A000MSG_P268_ERR_ADDIZ_MANCANTE          = '- non è stato possibile aggiornare la relativa tabella delle addizionali IRPEF perchè non esiste %s alla data %s. Occorre intervenire manualmente in base alle istruzioni fornite nel manuale in linea' + #13#10;
  A000MSG_P268_MSG_FMT_ERRADDIZ            = '- sulla relativa tabella, è presente l''addizionale IRPEF %s con un codice ente diverso da quello calcolato %s. Occorre intervenire manualmente in base alle istruzioni fornite nel manuale in linea' + #13#10;
  A000MSG_P268_MSG_FMT_ADDIZ_KO            = '- sulla relativa tabella, l''addizionale IRPEF %s NON coincide con quella caricata per l''anno corrente. Occorre intervenire manualmente in base alle istruzioni fornite nel manuale in linea' + #13#10;
  A000MSG_P268_MSG_CANC_ADDIZ              = 'Attenzione! Occorre intervenire manualmente sulla relativa tabella delle addizionali IRPEF per cancellare opportunamente l''importo pagato!';

  A000MSG_P272_MSG_DALLA_DATA              = 'Dalla data';
  A000MSG_P272_MSG_ALLA_DATA               = 'Alla data';
  A000MSG_P272_ERR_DECORRENZA              = 'Indicare la data decorrenza!';
  A000MSG_P272_ERR_IMPORTI                 = 'I campi Importo e Importo intero non possono essere nulli';
  A000MSG_P272_DLG_FMT_CALCOLO             = 'Attenzione: verrano rideterminati gli storici delle retribuzioni contrattuali per n. %s dipendenti selezionati.' + #13#10 +
                                             'a partire dal %s. Confermi l''operazione?';

  A000MSG_P280_ERR_PERIODO_INTERSECANTE    = 'Esiste un periodo intersecante con le date specificate';
  A000MSG_P280_ERR_ESISTE_PERIODO_CHIUSO   = 'Esiste già un periodo chiuso nell''arco temporale richiesto';
  A000MSG_P280_ERR_TIPO_PT                 = 'Specificare il tipo part-time!';
  A000MSG_P280_ERR_PERC_PT                 = 'Specificare la percentuale part-time!';
  A000MSG_P280_DLG_FMT_CALCOLA_CHIUSURA    = 'Attenzione: verrano %s i periodi pensionistici e previdenziali per n. %s dipendenti selezionati'+ #13#10 +
                                             'a partire dal %s, sovrascrivendo anche eventuali modifiche manuali. Confermi l''operazione?';

  A000MSG_P282_ERR_ACC_VOCI                = 'Specificare l''accorpamento voci per il calcolo dei periodi retributivi!';
  A000MSG_P282_ERR_COD_ACCORP_LUNG         = 'Impossibile effettuare il calcolo per il codice accorpamento voci selezionato!' + #13#10 +
                                             'Per essere compatibile con il file di esportazione, il codice può essere lungo al massimo 11 caratteri!';
  A000MSG_P282_ERR_ACC_VOCI_ACCESSORIE     = 'In caso di calcolo automatico, l''accorpamento delle voci accessorie deve essere vuoto';
  A000MSG_P282_ERR_FMT_VOCE_ACCESSORIA     = 'La voce seguente è una retribuzione accessoria inserita anche nell''accorpamento voci %s delle retribuzioni fisse:' + #13#10 +
                                             'Contratto=%s Voce=%s %s %s';
  A000MSG_P282_ERR_PERIODO_INTERSECANTE    = 'Esiste un periodo intersecante con le date specificate!';
  A000MSG_P282_ERR_ESISTE_PERIODO_CHIUSO   = 'Esiste già un periodo chiuso nell''arco temporale richiesto';
  A000MSG_P282_DLG_FMT_CALCOLA_CHIUSURA    = 'Attenzione: verrano %s i periodi retributivi per n. %s dipendenti selezionati'+ #13#10 +
                                             'a partire dal %s, sovrascrivendo anche eventuali modifiche manuali. Confermi l''operazione?';

  A000MSG_P290_ERR_FRAZIONE_MESE           = 'La frazione di mese deve essere maggiore di 0 e minore o uguale a 1!';

  A000MSG_P292_ERR_PERC_ISTAT              = 'Inserire percentuale ISTAT valida';
  A000MSG_P292_ERR_IMP_MIN_MAX             = 'Inserire importi minimale e massimale validi';
  A000MSG_P292_ERR_RETR_MIN_GIORN          = 'Inserire retribuzione minimale giornaliera valida';
  A000MSG_P292_DLG_CONF_PARAM              = 'Confermi registrazione parametri calcolo per la nuova decorrenza?';

  A000MSG_P310_MSG_CONTR_STORICO_RETR      = 'Elaborazione terminata: per accertare la correttezza dei dati retributivi controllare anche gli importi riportati sullo storico retribuzione contrattuale del/dei dipendente/i elaborati';
  A000MSG_P310_ERR_NO_ANAG_STIP            = 'Non esiste l''anagrafica stipendi';
  A000MSG_P310_ERR_NO_RETRIB_CONTR         = 'Non esistono dati nello storico retribuzione contrattuale';
  A000MSG_P310_ERR_NO_ACCORP_VOCI          = 'Non esiste l''Accorpamento voci di riferimento: TFR';
  A000MSG_P310_ERR_NO_TFR1_APERTO          = 'Non esiste modello TFR 1 aperto';
  A000MSG_P310_ERR_NO_TFR1_CHIUSO          = 'Non esiste modello TFR 1 chiuso';
  A000MSG_P310_ERR_PIU_TFR1_APERTI         = 'Esistono più modelli TFR 1 aperti: procedere con la chiusura di quello meno recente';

  A000MSG_P312_ERR_FMT_PERIODO             = 'La data fine %s non può essere antecedente alla data inizio %s!';
  A000MSG_P312_ERR_INIZIO_TFR              = 'La data inizio servizio utile TFR deve corrispondere con l''inizio del mese!';
  A000MSG_P312_ERR_FINE_TFR                = 'La data fine servizio utile TFR deve corrispondere con la fine del mese!';
  A000MSG_P312_ERR_DATA_DECESSO            = 'La data decesso deve essere successiva alla data fine rapporto!';
  A000MSG_P312_ERR_INIZIO                  = 'Attenzione: la data inizio servizio utile TFR è antecedente alla data inizio rapporto.';
  A000MSG_P312_ERR_FINE                    = 'Attenzione: la data fine servizio utile TFR è successiva alla data fine rapporto.';
  A000MSG_P312_ERR_VOCE                    = 'Voce non prevista tra quelle inseribili nella sezione Assenze del modello TFR 1!';
  A000MSG_P312_ERR_NUMERO_ORE              = 'Il numero ore può essere inserito solo se il periodo Dal-Al è pari a 1 giorno!';
  A000MSG_P312_ERR_PT                      = 'Il tipo part-time può essere esclusivamente O (orizzontale) oppure V (verticale)!';
  A000MSG_P312_ERR_TIPO_PT                 = 'Specificare il tipo part-time!';
  A000MSG_P312_ERR_PERC_PT                 = 'Specificare la percentuale part-time!';
  A000MSG_P312_ERR_FMT_PERIODO_TFR         = 'Il periodo %s deve essere compreso nel periodo di servizio utile TFR';
  A000MSG_P312_DLG_CONF_CANC               = 'Attenzione: verranno cancellati anche le Assenze e i Dati retributivi. Confermi comunque la cancellazione?';

  A000MSG_P314_MSG_NO_MODELLITFR1          = 'Nessun modello TFR1 elaborato';
  A000MSG_P314_MSG_NO_MODELLOTFR1DIP       = 'Non esiste il modello TFR 1 per il dipendente corrente';
  A000MSG_P314_ERR_FMT_EREDE_NO_GRADO_PAR  = 'L''erede %s è senza grado di parentela: occorre caricarlo sui familiari del deceduto stesso';

  A000MSG_P430_ERR_SCHEDA_LOCK             = 'Dipendente già in uso da altro operatore e/o applicazione.'#13#10 +
                                             'Attendere alcuni istanti prima di riprovare l''operazione';
  A000MSG_P430_ERR_DIP_IN_USO              = 'Dipendente già in uso da altro operatore e/o applicazione: non è possibile allineare i periodi storici.' + #13#10 +
                                             'Chiudere tutte le applicazioni dei vari operatori che interagiscono sul dipendente e riprovare.';
  A000MSG_P430_ERR_IBAN                    = 'Indicare il codice IBAN in tutte le sue parti';
  A000MSG_P430_ERR_FMT_CONTROLLO_IBAN      = 'Attenzione: l''IBAN non risulta corretto!' + #13#10 + '%s';
  A000MSG_P430_ERR_BANCA                   = 'I codici ABI, CAB e Codice nazione specificati non corrispondono a nessun codice banca registrato!';
  A000MSG_P430_ERR_DECOR_INIZIO_MESE       = 'La decorrenza deve coincidere con l''inizio del mese!';
  A000MSG_P430_ERR_DETRAZ_REDD_MIN         = 'Scegliere solo un minimo annuale garantito!';
  A000MSG_P430_ERR_CAUSALE_F24             = 'La causale di versamento non può iniziare con ''F24''!';
  A000MSG_P430_ERR_NO_COD_FPC              = 'Il Fondo previdenza complementare deve essere indicato se è stato impostato almeno un altro dato relativo all''iscrizione!';
  A000MSG_P430_ERR_SI_TIPO_ADES_COD_FPC    = 'Il Fondo previdenza complementare non deve essere indicato nel caso del Tipo di adesione impostato!';
  A000MSG_P430_ERR_NO_TIPO_ADES_COD_FPC    = 'Il Fondo previdenza complementare deve essere indicato nel caso del Tipo di adesione impostato!';
  A000MSG_P430_ERR_NO_DATA_INF_SIL_ASS_FPC = 'La Data informativa sul silenzio-assenso deve essere indicata per il Tipo di adesione impostato!';
  A000MSG_P430_ERR_SI_DATA_INF_SIL_ASS_FPC = 'La Data informativa sul silenzio-assenso non deve essere indicata per il Tipo di adesione impostato!';
  A000MSG_P430_ERR_NO_DATA_DOMANDA_FPC     = 'La Data sottoscrizione domanda deve essere indicata se è stato selezionato un Fondo previdenza complementare!';
  A000MSG_P430_ERR_LAV_PRIMA_OCCUP_FPC     = 'Il campo Lavoratore di prima occupazione può essere attivato soltanto con Data sottoscrizione domanda successiva al 01/01/2018!';
  A000MSG_P430_ERR_NO_PERC_TOT_DIP_FPC     = 'La Percentuale totale carico dipendente deve essere maggiore di zero se è stato selezionato un Fondo previdenza complementare!';
  A000MSG_P430_ERR_MOTIVO_SOSP             = 'Il motivo di sospensione e il tipo di cessazione sono alternativi!';
  A000MSG_P430_ERR_PERC_IRPEF_REGIMI_SPEC  = 'La percentuale tassazione regimi speciali deve essere compresa tra 10 e 50!';
  A000MSG_P430_ERR_NO_CONTRATTO_VOCI       = 'Il contratto voci deve essere indicato!';
  A000MSG_P430_ERR_NO_AREA_CONTRAT         = 'L''area contrattuale deve essere indicata!';
  A000MSG_P430_ERR_PERC_EREDITA            = 'La percentuale eredità non può essere superiore a 100!';
  A000MSG_P430_ERR_CREDITORI_PIGNORATIZI   = 'Al fine di poter gestire i creditori pignoratizi è necessario installare il relativo modulo opzionale!';
  A000MSG_P430_ERR_AREA_CONTRAT            = 'L''area contrattuale deve essere uguale al contratto voci!';
  A000MSG_P430_ERR_NO_TIPO_SERV_ALTRA_AMM  = 'Specificare la tipologia servizio altra amministrazione!';
  A000MSG_P430_ERR_TIPO_RETRIBUZIONE       = 'Il tipo retribuzione mese precedente è applicabile solo ai medici di medicina generale e ai pediatri di libera scelta';
  A000MSG_P430_ERR_NO_COD_FISC_ALTRA_AMM   = 'Specificare il codice fiscale altra amministrazione!';
  A000MSG_P430_ERR_NO_COD_STATO_REG_SPEC   = 'Per poter inserire il codice dello stato estero è necessario specificare la percentuale di tassazione per regimi speciali!';
  A000MSG_P430_ERR_PROG_ALTRA_AMM          = 'Specificare il progressivo azienda altra amministrazione!';
  A000MSG_P430_ERR_COD_BANCA               = 'Codice banca non valido!';
  A000MSG_P430_ERR_COD_BANCA_ESTERA        = 'In caso di IBAN estero è necessario specificare una banca estera (il codice banca deve avere una Nazione IBAN diversa da ''IT'')!';
  A000MSG_P430_ERR_CITTA_ESTERA            = 'In caso di IBAN estero è necessario specificare la città di destinazione estera!';
  A000MSG_P430_ERR_CED_ANTE_PRIMO_STORICO  = 'Attenzione!'#13#10'Esistono cedolini antecedenti il primo periodo storico dall''anagrafica stipendiale.'#13#10'Correggere urgentemente la situazione.';
  A000MSG_P430_ERR_DEL_ESISTE_CEDOLINO     = 'Non è possibile eliminare l''anagrafica stipendiale perché esiste almeno un cedolino per il dipendente selezionato!';
  A000MSG_P430_MSG_REDD_COMPLE             = 'Si precisa che il reddito complessivo per il calcolo delle detrazioni sarà dato dal reddito annuale ulteriore indicato più il reddito maturato in azienda';
  A000MSG_P430_MSG_REDD_ABITAZIONE_PRINC   = 'Si precisa che, per il calcolo delle detrazioni, il reddito abitazione principale non viene cumulato con il reddito complessivo';
  A000MSG_P430_MSG_EREDE_NONDIP            = 'Attenzione: Tipo lavoratore ''Erede'' con Stato dipendente diverso da ''Non dipendente''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_VOCI_VARIABILI    = 'Attenzione: Tipo lavoratore ''Erede'' con Tipo emissione per cedolino normale diverso da ''Voci variabili''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_IRAP              = 'Attenzione: Tipo lavoratore ''Erede'' con Tipo assoggettamento diverso da ''IRAP''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_SENZA_EREDE_DI    = 'Attenzione: Tipo lavoratore ''Erede'' con Erede di non valorizzato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_PCT_EREDITA       = 'Attenzione: Tipo lavoratore ''Erede'' con % eredità non valorizzata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_PCT_EREDITA_ERR   = 'Attenzione: Tipo lavoratore ''Erede'' con % eredità non significativa. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_CONGUAGLIO_IRPEF  = 'Attenzione: Tipo lavoratore ''Erede'' con Conguaglio IRPEF diverso da ''No''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_CAUS_VERS         = 'Attenzione: Tipo lavoratore ''Erede'' con Causale versamento IRPEF diverso da ''1001''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_DETRAZ_LAVDIP     = 'Attenzione: Tipo lavoratore ''Erede'' con Tipo Altre detrazioni diverso da ''Nessuna detrazione del tipo precedente''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_EREDE_BONUS_RIDUZ_FISC  = 'Attenzione: Tipo lavoratore ''Erede'' con Tipo riconoscimento del Bonus riduzione cuneo fiscale diverso da ''Non riconosciuto''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_DIP_RETRIBUITO    = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Stato dipendente diverso da ''Dipendente retribuito''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_CEDOL_COMPLETO    = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Tipo emissione per cedolino normale diverso da ''Completa''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_IRPEF             = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Tipo assoggettamento diverso da ''IRPEF''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_SENZA_CREDITORE_DI= 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Creditore di non valorizzato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_TREDICESIMA       = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Prevista Tredicesima diverso da ''No''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_CONGUAGLIO_IRPEF  = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Conguaglio IRPEF diverso da ''No''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_DETRAZ_LAVDIP     = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Tipo Altre detrazioni diverso da ''Nessuna detrazione del tipo precedente''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_CRPIG_BONUS_RIDUZ_FISC  = 'Attenzione: Tipo lavoratore ''Creditore pignoratizio'' con Tipo riconoscimento del Bonus riduzione cuneo fiscale diverso da ''Non riconosciuto''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_INQUADR_INPS            = 'Attenzione: il codice di inquadramento INPS non è vuoto';
  A000MSG_P430_MSG_NO_CAUS_VERS_IRPEF      = 'Attenzione: la causale di versamento IRPEF non è stata indicata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_PROF_ONAOSI          = 'Attenzione: La professione ONAOSI non è stata indicata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_COD_INAIL            = 'Attenzione: il codice INAIL non è stato indicato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_CAUS_LAV_AUTO        = 'Attenzione: la Causale lav.autonomi non è stato indicata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_SI_CAUS_LAV_AUTO        = 'Attenzione: è stata indicata la Causale lav.autonomi. Il dato viene comunque salvato';
  A000MSG_P430_MSG_LAV_AUTO_CONG_IRPEF     = 'Attenzione: tipo lavoratore autonomo con conguaglio IRPEF diverso da ''No''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_COD_INPS             = 'Attenzione: il codice INPS non è stato indicato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_NAZ                  = 'Attenzione: la nazionalità non è stata indicata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_COD_INPS_NO_VUOTO       = 'Attenzione: il codice INPS non è vuoto. Il dato viene comunque salvato';
  A000MSG_P430_MSG_MASSIMALE_NO_NUOVO_ISCR = 'Attenzione: il tipo massimale contributivo non è impostato a ''Nuovo iscritto dal 1/1/96 a forme pensionistiche obbligatorie oppure optante per il sistema contributivo''. Il dato viene comunque salvato';
  A000MSG_P430_MSG_TABELLA_ANF             = 'Attenzione: la tabella ANF deve essere indicata SOLO quando il calcolo automatico rileva una tabella diversa da quella desiderata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_COD_BANCA            = 'Attenzione: il codice banca non è stato indicato. Il campo è obbligatorio per generare il file con i netti a pagare (utilizzare 99999_99999 per le modalità di pagamento diverse dal bonifico). Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_CIN_ITALIA           = 'Attenzione: il CIN Italia non è stato indicato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_CIN_EUROPA           = 'Attenzione: il CIN Europa non è stato indicato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_MOD_PAG              = 'Attenzione: la modalità di pagamento del cedolino non è stata indicata. Il dato viene comunque salvato';
  A000MSG_P430_MSG_FONDO_AOSTA             = 'Attenzione: il dipendente è stato iscritto ad un fondo della regione Valle d''Aosta. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_FONDO_AOSTA          = 'Attenzione: il dipendente non è stato iscritto ad un fondo della regione Valle d''Aosta. Il dato viene comunque salvato';
  A000MSG_P430_MSG_INQUADR_INPDAP          = 'Attenzione: codice inquadramento INPDAP incoerente con la posizione economica. La denuncia DMA2 potrebbe non essere corretta. Il dato viene comunque salvato';
  A000MSG_P430_MSG_INQUADR_INPDAP_TP       = 'Attenzione: codice inquadramento INPDAP incoerente con la posizione economica ed il tipo orario a tempo pieno/part-time. La denuncia DMA2 potrebbe non essere corretta. Il dato viene comunque salvato';
  A000MSG_P430_MSG_INQUADR_INPDAP_PARTTIME = 'Attenzione: codice inquadramento INPDAP incoerente con la posizione economica ed il tipo orario part-time. La denuncia DMA2 potrebbe non essere corretta. Il dato viene comunque salvato';
  A000MSG_P430_MSG_NO_CATEG_ENPAM          = 'Attenzione: il codice categoria ENPAM non è stato indicato. Il dato viene comunque salvato';
  A000MSG_P430_MSG_DEC_SIL_ASS_FPC_GG_01   = 'Attenzione: la data iscrizione al Fondo previdenza complementare in modalità silenzio-assenso non decorre dal primo giorno del mese. Il dato viene comunque salvato';
  A000MSG_P430_MSG_DEC_SIL_ASS_FPC_SEI_MM  = 'Attenzione: il Tipo di adesione al Fondo previdenza complementare in modalità silenzio-assenso non decorre dal primo giorno del mese successivo alla scadenza dei sei mesi dalla Data informativa. Il dato viene comunque salvato';
  A000MSG_P430_MSG_PRIMA_ASSUNZ_INIZIO_MESE= 'I dati relativi alla prima assunzione devono decorrere da inizio mese';
  A000MSG_P430_MSG_COPIA_DIPENDENTE        = 'Sono stati copiati tutti i dati tranne quelli delle pagine ''Dati aggiuntivi'' escluse le valute, ''Detrazioni'', ''A.N.F.'', ' + #13#10 +
                                              '''Altra amm.'', ''F.P.C.'' e la Matricola pensionistica!';
  A000MSG_P430_MSG_BONUS_RIDUZ_FISC        = 'Attenzione: il Bonus riduzione cuneo fiscale deve essere ''Riconosciuto senza conguaglio'' solo nel caso di particolari operazioni societarie: viceversa il calcolo risulterà errato. Il dato viene comunque salvato';
  A000MSG_P430_DLG_DECOR_ANTE              = 'Attenzione: è già presente una decorrenza precedente a quella indicata. Confermi il salvataggio comunque?';
  A000MSG_P430_DLG_IBAN_DISALLINEATO       = 'Attenzione: IBAN non allineato con dati bonifico. Confermi il salvataggio comunque?';
  A000MSG_P430_DLG_EREDE                   = 'Attenzione: il soggetto è l''erede di un lavoratore autonomo. Confermi il salvataggio?';
  A000MSG_P430_DLG_NO_INQUADR_INPDAP       = 'Attenzione: il codice inquadramento INPDAP non è stato indicato e il dipendente sarà escluso dalle denunce. Confermi il salvataggio comunque?';
  A000MSG_P430_DLG_COPIA_DIP               = 'Si desidera copiare i dati da un altro dipendente?';

  A000MSG_P441_MSG_FMT_INS_RECUPERO_VOCI   = 'Inserimento voce %s %s in voci da recuperare/recuperate';
  A000MSG_P441_DLG_RECUPERO_VOCI           = 'Confermi l''inserimento della voce nella tabella ''Voci da recuperare/recuperate''?';
  A000MSG_P441_DLG_FMT_RECUPERO_VOCI       = 'Attenzione: per il dipendente selezionato, sul mese di %s la voce %s con importo %s esiste già nella tabella ''Voci da recuperare/recuperate''. Continuare comunque?';
  A000MSG_P441_ERR_INS_VOCI_RECUPERO_VOCI  = 'Inserimento previsto solo per le voci 10011, 10041 e 10071!';
  A000MSG_P441_MSG_INS_IMP_RECUPERO_VOCI   = 'Il recupero ha superato l’importo da recuperare: il dato viene comunque salvato.';
  A000MSG_P441_ERR_ARROTONDAMENTO          = 'La voce non possiede arrotondamento';
  A000MSG_P441_ERR_NO_MESE_RETR_E_CASSA    = 'I mesi di retribuzione e di cassa devono essere inseriti';
  A000MSG_P441_ERR_ESISTE_CEDOLINO         = 'Esiste già il cedolino del mese o di un mese successivo';
  A000MSG_P441_ERR_CEDOLINO_APERTO         = 'Per eliminare il cedolino utilizzare l''apposita funzione di annullamento della maschera "Elaborazione cedolini"';
  A000MSG_P441_ERR_COMP_NO_ASSUNZIONE      = 'Il periodo di competenza dal/al risulta non interamente coperto dall''assunzione';
  A000MSG_P441_ERR_COMP_DOPO_CEDOLINO      = 'Attenzione! Il periodo di competenza dal/al è successivo al mese del cedolino';
  A000MSG_P441_ERR_COMP_STESSO_MM_AAAA     = 'Il periodo di competenza dal/al deve riferirsi allo stesso mese e anno.';
  A000MSG_P441_ERR_ECCEZIONI_IRPEF         = 'Impossibile impostare contemporaneamente più eccezioni di calcolo relative all''IRPEF!';
  A000MSG_P441_MSG_INS_DATA_COMP_QUOTE     = 'Attenzione: la data competenza delle quote è stata impostata automaticamente alla data di competenza.';

  A000MSG_P447_DLG_FMT_CANCELLA            = 'Attenzione: la cancellazione comporta l''eliminazione dell''intero parcheggio, compresi i dati elaborati di %s dipendenti. Confermi l''operazione?';
  A000MSG_P447_ERR_PERIODO_NON_COP_ASSUNZ  = 'Il periodo di competenza dal/al risulta non interamente coperto dall''assunzione';
  A000MSG_P447_ERR_PERIODO_STESSO_MESE     = 'Il periodo di competenza dal/al deve riferirsi allo stesso mese e anno.';
  A000MSG_P447_ERR_PARCHEGGIO_CHIUSO       = 'Il parcheggio voci è già chiuso per cui non può essere cancellato';
  A000MSG_P447_ERR_ECCEZIONI_IRPEF         = 'Impossibile impostare contemporaneamente più eccezioni di calcolo relative all''IRPEF!';
  A000MSG_P447_ERR_ARROTONDAMENTO          = 'La voce non possiede arrotondamento';
  A000MSG_P447_MSG_MODIFICA_NON_CONSENTITA = 'La modifica è consentita solamente per gli elementi che non siano Chiusi';
  A000MSG_P447_DLG_FMT_CANCELLA_VOCI       = 'Confermi la cancellazione delle voci dei %s dipendenti selezionati?';
  A000MSG_P447_ERR_DATA_COMPETENZA         = 'Indicare il periodo di competenza della voce da selezionare!';

  A000MSG_P449_ERR_NO_PARCHEGGIO           = 'Scegliere il parcheggio';
  A000MSG_P449_ERR_PARCHEGGIO_MESE         = 'Se si calcola sul parcheggio, ''Mese a'' deve essere uguale a ''Mese da''';
  A000MSG_P449_ERR_FMT_ANAG_STIP           = '%-8s %-40s - Non esiste l''anagrafica stipendiale alla data: %s';
  A000MSG_P449_ERR_FMT_VALUTA              = 'Non esiste la valuta da utilizzare per i calcoli del cedolino alla data: %s';
  A000MSG_P449_ERR_FMT_VOCE_INAIL          = 'La voce INAIL seguente non esiste: Contratto=%s Voce=%s %s' +
                                             ' Decorrenza (cassa)=%s Decorrenza (competenza)=%s';
  A000MSG_P449_ERR_FMT_ARROT_VOCE          = 'La voce seguente non possiede arrotondamento: Contratto=%s Voce=%s %s' +
                                             ' Valuta=%s Decorrenza=%s';

  A000MSG_P449_ERR_FMT_NO_VOCI             = 'Non esistono voci nell''accorpamento %s presente nel codice Inail %s' +
                                             ' con Decorrenza=%s';
  A000MSG_P449_ERR_FMT_SETUP               = 'Non esiste il record di setup al %s';

  A000MSG_P450_ERR_MESE_RI13A              = 'Il numero manuale dei ratei annuali può essere inserito solo sul mese di dicembre!';
  A000MSG_P450_ERR_MESE_CIAAP              = 'Il conguaglio IRPEF anno precedente può essere inserito solo sui mesi di gennaio o febbraio!';
  A000MSG_P450_ERR_VALORE_RI13A            = 'Il numero manuale dei ratei annuali deve essere compreso tra 0 e 12!';
  A000MSG_P450_ERR_NUMERO_DECIMALI         = 'Numero di decimali superiore a quelli previsti!';
  A000MSG_P450_ERR_VALORE_TESTO            = 'Il valore inserito deve essere tra quelli previsti. Consultare la lista!';
  A000MSG_P450_ERR_VARIAZIONE_TESTO        = 'Variazione non prevista per campi non numerici!';
  A000MSG_P450_ERR_VARIAZIONE_AUTO         = 'Attenzione: considerare che è già presente una Variazione automatica!';

  A000MSG_P460_ERR_DATI_NULLI              = 'Inserire tutti i dati!';
  A000MSG_P460_DLG_FMT_INSCANC_PERIODO     = 'Effettuare %s delle quantità mensili per il periodo selezionato?';
  A000MSG_P460_ERR_PERIODO_COMPETENZA      = 'Il periodo di competenza dal/al risulta non interamente coperto dall''assunzione!';

  A000MSG_P461_ERR_DATA_COMPETENZA         = 'Indicare il Mese di competenza delle quantità mensili da acquisire!';
  A000MSG_P461_ERR_ID_SANIT_CONV           = 'Indicare l''Identificativo sanitario convenzionato!';
  A000MSG_P461_ERR_NO_FILE_CSV_STRAN       = 'Il formato del file indicato in Nome file stranieri con rinnovo permesso di soggiorno deve essere .csv!';
  A000MSG_P461_ERR_FILE_INESISTENTE_STRAN  = 'Impossibile procedere con l''importazione: il file indicato in Nome file stranieri con rinnovo permesso di soggiorno non esiste!';
  A000MSG_P461_ERR_FMT_COLONNE_FILE_STRAN  = 'Nel file indicato in Nome file stranieri con rinnovo permesso di soggiorno l''intestazione della colonna %s (%s) è diversa da %s!';
  A000MSG_P461_ERR_FMT_VALORE_NON_POS      = 'Inserire un valore intero maggiore di 0 in %s!';
  A000MSG_P461_ERR_MIN_ARROT_UGUALI_ZERO   = 'Inserire un valore intero diverso da 0 in Min. di arrotondamento!';
  A000MSG_P461_ERR_MIN_ARROT_NO_DIVIS_60   = 'Inserire un divisore di 60 nei Min. di arrotondamento!';
  A000MSG_P461_ERR_CAUSALI_ASSENZA         = 'Specificare almeno una causale di assenza!';
  A000MSG_P461_ERR_FMT_ACQUISIZIONE        = 'Errore durante l''acquisizione: %s';
  A000MSG_P461_ERR_FMT_CAUSALI_REC_DOPPIE  = 'E'' possibile definire la causale %s solo una volta!';
  A000MSG_P461_ERR_CONFIG_AZIENDALI        = 'Valorizzare tutti i campi nelle configurazioni dati aziendali annuali!';
  A000MSG_P504_DLG_CAUSALE_PRESENZA        = 'Attenzione! Non è stata specificata la causale di presenza. Proseguire?';

  A000MSG_P462_ERR_NO_MATR_TITOLARE        = 'Indicare il titolare!';
  A000MSG_P462_ERR_NO_MATR_SOSTITUTO       = 'Indicare il sostituto!';
  A000MSG_P462_ERR_SOSTIT_UGUALE_TITOL     = 'Il sostituto deve essere diverso dal titolare!';
  A000MSG_P462_ERR_NO_DATA_INIZIO_SOST     = 'Indicare la data inizio sostituzione!';
  A000MSG_P462_ERR_DATA_FINE_SOST          = 'La data fine sostituzione deve essere maggiore o uguale alla data inizio sostituzione!';
  A000MSG_P462_ERR_FMT_NO_SERVIZIO         = 'Il %s non è in servizio nel periodo indicato!';
  A000MSG_P462_ERR_FMT_SOST_GIA_SOSTITUTO  = 'Il sostituto è già un titolare sostituito dal %s';
  A000MSG_P462_ERR_FMT_TIT_GIA_SOSTITUTO   = 'Il titolare è già un sostituto dal %s';
  A000MSG_P462_ERR_FMT_TIT_GIA_SOSTITUITO  = 'Il titolare è già sostituito da %s dal %s';

  A000MSG_P464_DLG_CANC_PERIODI            = 'Attenzione: il premio di operosità è già stato pagato! Continuare cancellando i dati già consolidati?';
  A000MSG_P464_ERR_NO_ORARIO_SETTIMANALE   = 'Specificare l''orario settimanale!';
  A000MSG_P464_ERR_NO_VOCI_NO_IMPORTO      = 'Selezionare le voci dall''apposito elenco oppure indicare l''importo orario totale!';
  A000MSG_P464_ERR_SI_VOCI_SI_IMPORTO      = 'Specificare o le voci o l''importo orario totale!';
  A000MSG_P464_ERR_FMT_IMPORTO_ORARIO      = 'Importo orario %s non valido!';
  A000MSG_P464_ERR_NO_PERIODI_LAVORATI     = 'Non sono presenti periodi lavorati!';

  A000MSG_P466_ERR_NO_VOCI                 = 'Selezionare almeno una voce dall''apposito elenco';
  A000MSG_P466_ERR_ASS_CESS_INCONGRUENTI   = 'Periodi di assunzione/cessazione incongruenti; correggere e rielaborare';

  A000MSG_P500_ERR_PWD_ERRATA              = 'Password errata! Operazione annullata';
  A000MSG_P500_ERR_MESI_CEDOL_RETRIB       = 'Il mese cedolino deve essere maggiore o uguale al mese retribuzione!';
  A000MSG_P500_ERR_DATA_EMISSIONE          = 'E'' necessario impostare la data di emissione!';
  A000MSG_P500_MSG_NO_CEDOLINO             = 'Nessun cedolino elaborato';
  A000MSG_P500_ERR_PROC_CREA_PDF           = 'Procedura creazione PDF non definita';
  A000MSG_P500_ERR_DATA_VALUTA             = 'E'' necessario impostare la data di cambio valuta!';
  A000MSG_P500_ERR_FMT_REWRITE_PDF         = 'Non è stato possibile sovrascrivere il file %s!';
  A000MSG_P500_ERR_NO_DATO_CHK_REGOLE_CED  = 'Dato anagrafico non trovato! Verificare l''esistenza dei campi indicati nelle sezioni "Postel" e "Cedolino" in Ambiente\Tabelle di configurazione\Configurazione dati aziendali';
  A000MSG_P500_ERR_FMT_DIR_PDF             = 'Directory %s inesistente!' + #13#10 +
                                             'Indicare un percorso corretto tra le impostazioni della stampa in PDF!';
  A000MSG_P500_ERR_FMT_DIR_FILE_PDF        = 'Directory ''%s'' inesistente!' + #13#10 +
                                             'Parametrizzare correttamente l''impostazione aziendale annuale per la creazione dell''archivio PDF!';

  A000MSG_P500_ERR_FMT_DIR_STAMPA_PDF      = 'Directory ''%s'' inesistente!' + #13#10 +
                                             'Parametrizzare correttamente l''impostazione aziendale annuale per la creazione della stampa PDF!';

  A000MSG_P500_ERR_FMT_DIR_CREA_DIR        = 'Impossibile creare la directory ''%s''!';
  A000MSG_P500_DLG_FMT_FILE_EXIST          = 'Il file %s esiste già e verrà sovrascritto.' + #13#10 + 'Proseguire?';
  A000MSG_P500_DLG_CHIUSURA                = 'Confermi l''operazione di chiusura cedolini dei dipendenti selezionati per il mese indicato';
  A000MSG_P500_DLG_PRECALCOLO_AVVISO_MESE  = 'Mese cedolino diverso da mese di lavoro. Si ricorda che per le assunzioni avvenute ' + #13#10 +
                                             'successivamente alla chiusura del mese, il Mese cedolino deve comunque coincidere con quello corrente ' + #13#10 +
                                             ' e solo il Mese retribuzione deve essere precedente. Confermi prosecuzione ?';
  A000MSG_P500_DLG_RIAPERTURA              = 'Confermi l''operazione di riapertura del cedolino indicato per tutti i dipendenti selezionati';
  A000MSG_P500_DLG_ARCH_DT_PROCEDI         = 'Sono già stati archiviati cedolini con data di retribuzione uguale o successiva a quella impostata (ultima archiviazione: %s).' + #13#10 +
                                             'I cedolini di questo periodo potrebbero essere già stati archiviati.' + #13#10 +
                                             'Proseguire comunque?';
  A000MSG_P500_ERR_DIR_NO_CANCELLA_MAN     = 'La cartella %s contiene file che non sono XML o PDF. Verificare ed eventualmente eliminarla manualmente.';
  A000MSG_P500_ERR_DIR_ERR_CANCELLA_MAN    = 'Errore durante l''eliminazione della cartella %s. Tale cartella andrà svuotata manualmente.';
  A000MSG_P500_ERR_CHECK_REGOLE_ARCH       = 'Verificare la configurazione in Interfacce\Regole archiviazione documenti.';
  A000MSG_P500_ERR_XML_NO_DATA_CHIUS_AUT   = 'Data di chiusura automatica non disponibile.';
  A000MSG_P500_MSG_FMT_CED_APERTI          = #13#10 + 'Attenzione: sono ancora presenti %s cedolini aperti nel Mese cedolino appena chiuso!';

  A000MSG_P502_ERR_NO_MODIFICA             = 'Modifica consentita solo per le regole impostate come ''Regola modificabile''';
  A000MSG_P502_MSG_NO_REGOLA               = 'Non esiste alcuna regola originale.';
  A000MSG_P502_DLG_RIPRISTINO_REGOLA       = 'Confermi il ripristino della regola di calcolo originale' + #13#10 +
                                             'sostituendo quella manuale ? ';

  A000MSG_P503_ERR_NO_MATR_PARTENZA        = 'Indicare la matricola di partenza!';
  A000MSG_P503_ERR_NO_MATR_APP             = 'Indicare la matricola di appoggio!';
  A000MSG_P503_ERR_NO_MATR_PARTENZA_APP    = 'La matricola di appoggio può essere impostata solo dopo aver scelto la matricola di partenza!';
  A000MSG_P503_ERR_NO_CU_PART_ANNI_OLD     = 'Non è possibile inserire modelli CU particolari di anni con modelli CU già trasmessi!';
  A000MSG_P503_ERR_MATR_APP_UGUA_PARTENZA  = 'La matricola di appoggio deve essere diversa dalla matricola di partenza!';
  A000MSG_P503_ERR_PUNTO_A                 = 'Il valore del punto A-010 non è previsto!';
  A000MSG_P503_ERR_MATR_APP_GIA_PARTENZA   = 'La matricola di appoggio è già presente tra le matricole di partenza caricate!';
  A000MSG_P503_ERR_MATR_PARTENZA_GIA_APP   = 'La matricola di partenza è già presente tra le matricole di appoggio!';

  A000MSG_P504_ERR_ANNO_MINORE_2015        = 'L''anno indicato non può essere antecedente al 2015!';
  A000MSG_P504_ERR_NO_DATA_FIRMA           = 'Specificare la data firma sostituto d''imposta da riportare nel file di esportazione!';
  A000MSG_P504_ERR_NO_SEDE_ENTRATEL        = 'Specificare il codice sede Entratel!';
  A000MSG_P504_ERR_CODICE_SEDE_ENTRATEL    = 'Il Codice sede Entratel deve essere un numero di 3 cifre compreso tra 000 e 999!';
  A000MSG_P504_ERR_MODELLO_NON_ESISTE      = 'Non esiste alcun modello CU da esportare!';
  A000MSG_P504_DLG_FORZA_MODELLO           = 'Confermi la forzatura della creazione del modello CU dell''anno indicato per i dipendenti selezionati ? L''operazione è da effettuare solo in casi eccezionali';
  A000MSG_P504_DLG_SOLO_CONIUGE            = 'Confermi l''elaborazione del solo coniuge non a carico per i dipendenti selezionati ?';
  A000MSG_P504_DLG_ANNULLA                 = 'Confermi l''operazione di annulla CU dell''anno indicato per i dipendenti selezionati?';
  A000MSG_P504_DLG_CHIUSURA                = 'Confermi l''operazione di chiusura CU dell''anno indicato per i dipendenti selezionati?';
  A000MSG_P504_MSG_EXP_DATI_IN_CORSO       = 'Esportazione dati in corso...';

  A000MSG_P505_DLG_RIAPERTURA_CU           = 'Attenzione: il modello potrebbe già essere stato consegnato al percettore delle somme e trasmesso all''Agenzia delle Entrate. Confermi riapertura?';
  A000MSG_P505_ERR_CERTIF_PROGR_NO_NUM     = 'Il progressivo certificazione assegnato nel file di invio deve essere numerico!';
  A000MSG_P505_ERR_CERTIF_PROGR_NO_POS     = 'Il progressivo certificazione assegnato nel file di invio deve essere maggiore di zero!';
  A000MSG_P505_ERR_CERTIF_PROGR_NO_SPEC    = 'Specificare il progressivo certificazione assegnato nel file di invio!';
  A000MSG_P505_ERR_PROT_TEL_ID_INV_NO_NUM  = 'L''identificativo invio del protocollo assegnato dal servizio telematico deve essere numerico!';
  A000MSG_P505_ERR_PROT_TEL_ID_INV_NO_POS  = 'L''identificativo invio del protocollo assegnato dal servizio telematico deve essere maggiore di zero!';
  A000MSG_P505_ERR_PROT_TEL_ID_INV_NO_SPEC = 'Specificare l''identificativo invio del protocollo assegnato dal servizio telematico!';
  A000MSG_P505_ERR_PROT_TEL_PROGR_NO_NUM   = 'Il progressivo del protocollo assegnato dal servizio telematico deve essere numerico!';
  A000MSG_P505_ERR_PROT_TEL_PROGR_NO_POS   = 'Il progressivo del protocollo assegnato dal servizio telematico deve essere maggiore di zero!';
  A000MSG_P505_ERR_PROT_TEL_PROGR_NO_SPEC  = 'Specificare il progressivo del protocollo assegnato dal servizio telematico!';
  A000MSG_P505_ERR_NO_REGOLA               = 'Parte e Numero non presenti nell''elenco dei dati previsti per l''Anno!';
  A000MSG_P505_ERR_CU_CHIUSO               = 'Il CUD è già chiuso per cui non può essere cancellato';
  A000MSG_P505_MSG_FLAG_CONFERMA_CONTROLLI = 'Attenzione: è stato attivato il campo %s: ciò comporta un invio forzato della CU nonostante gli errori segnalati dall''Agenzia delle Entrate! Il dato viene comunque salvato';

  A000MSG_P507_MSG_ELAB_TERM_POSIZ         = 'Elaborazione terminata.' + #13#10 +
                                             'Posizionamento sulla pagina Importazione su cedolino';
  A000MSG_P507_MSG_RITENUTA_IMP            = 'Il conguaglio delle Voci di ritenuta su imponibile potrebbe essere ignorato dalle eventuali denunce correlate.' + #13#10 +
                                             'Contattare il fornitore per analizzare l’esigenza specifica.';
  A000MSG_P507_DLG_VOCI_STIP               = 'Si vogliono selezionare le voci con importo derivante da quote relative alle voci stipendiali e programmate già selezionate?';
  A000MSG_P507_ERR_NO_CONTR_VOCI           = 'Impostare il contratto voci!';
  A000MSG_P507_ERR_NO_PARK_CED             = 'Impostare il parcheggio cedolini!';
  A000MSG_P507_ERR_PARK_CED_CHIUSO         = 'Il parcheggio cedolini è chiuso!';
  A000MSG_P507_ERR_NO_VOCE2                = 'Specificare la voce da inserire per il supero tetto per il secondo controllo!';
  A000MSG_P507_ERR_NO_VOCE1                = 'Specificare la voce da inserire per il supero tetto per il primo controllo!';
  A000MSG_P507_ERR_NO_TETTO2               = 'Specificare l''accorpamento tetto di riferimento per il secondo controllo!';
  A000MSG_P507_ERR_NO_TETTO1               = 'Specificare l''accorpamento tetto di riferimento per il primo controllo!';
  A000MSG_P507_ERR_NO_ACCORP               = 'Specificare almeno un''accorpamento voci da controllare!';
  A000MSG_P507_ERR_ECC_A_C                 = 'Impossibile impostare contemporaneamente più eccezioni di calcolo relative all''IRPEF!';
  A000MSG_P507_ERR_MESE_INIZIO_CONG        = 'Mese inizio conguaglio errato!';
  A000MSG_P507_ERR_MESE_FINE_CONG          = 'Mese fine conguaglio errato!';
  A000MSG_P507_ERR_PERIODO_CONG            = 'Il mese di fine conguaglio non può essere inferiore al mese di inizio.';
  A000MSG_P507_ERR_PARK_CEDOLINI           = 'Impostare il parcheggio cedolini.';
  A000MSG_P507_ERR_CONTRATTO_VOCI          = 'Impostare il contratto voci.';
  A000MSG_P507_ERR_NO_VOCI                 = 'Impostare le voci da conguagliare.';
  A000MSG_P507_ERR_TRED_DA_INIZIO_ANNO     = 'E'' stato richiesto di conguagliare una voce di tredicesima per cui l''elaborazione deve partire da inizio anno.';
  A000MSG_P507_ERR_TRED_SEPARATA           = 'E'' stato richiesto di conguagliare una voce di tredicesima per cui l''elaborazione va eseguita separatamente tra il periodo fino all''ultimo' + #13#10 +
                                             ' anno recuperato ed il periodo successivo al recupero.';
  A000MSG_P507_ERR_MASSIMALI_ANNO          = 'Essendo stato richiesto di conguagliare voci con massimali contributivi' + #13#10 +
                                             ' il periodo deve riferirsi ad un solo anno intero.';
  A000MSG_P507_DLG_CONGUAGLIO_RECUP        = 'Attenzione! Confermi la scelta del conguaglio delle voci recuperate ?' + #13#10 +
                                             'Questa operazione è da fare solo per sanare la situazione dei dati recuperati dalla precedente gestione e di norma viene fatta dal fornitore';
  A000MSG_P507_DLG_FMT_CONGUAGLIO          = 'Confermi l''operazione di conguaglio retroattivo sul parcheggio %s' + #13#10 +
                                             ' del/i %s dipendente/i selezionato/i per il periodo dal %s al %s ?';
  A000MSG_P507_DLG_FMT_CANCELLAZIONE       = 'Confermi la cancellazione delle voci importate sul cedolino del mese %s' + #13#10 +
                                             ' dei dipendenti selezionati?';
  A000MSG_P507_DLG_FMT_CANC_VOCI_PARK      = 'Confermi la cancellazione delle voci sul cedolino di parcheggio %s' + #13#10 +
                                             ' del dipendente selezionato?';
  A000MSG_P507_DLG_FMT_CONTROLLO           = 'Confermi il controllo tetto accessorie sul cedolino di %s'  + #13#10 +
                                             'per i dipendenti selezionati?';


  A000MSG_P508_ERR_CALCOLO_CHIUSO          = 'Il calcolo dei ratei di tredicesima per la contabilità analitica, del mese di elaborazione risulta già chiuso.';
  A000MSG_P508_ERR_CALCOLO_SUCC            = 'Esiste già un calcolo dei ratei di tredicesima per la contabilità analitica, di mesi successivi al mese di elaborazione.';
  A000MSG_P508_ERR_GIA_CHIUSO              = 'Il calcolo dei ratei di tredicesima per la contabilità analitica, del mese di elaborazione risulta già chiuso.';

  A000MSG_P508_DLG_FMT_CONFERMA_CALCOLO    = 'Confermi il calcolo rateo di tredicesima sul parcheggio %s' + #13#10 +
                                             ' del/i %s dipendente/i selezionato/i ' + #13#10 +
                                             'per il mese di %s ?';
  A000MSG_P508_DLG_FMT_CONFERMA_CHIUSURA   = 'Confermi la chiusura del parcheggio voci dei ratei di tredicesima ' + #13#10 +
                                             'per la contabilità analitica %s per tutti i dipendenti?';

  A000MSG_P510_ERR_NETTO_MINIMO_NEG        = 'Inserire un valore maggiore di 0 in Netto minimo!';
  A000MSG_P510_ERR_NETTO_MINIMO_NUM        = 'Inserire un valore numerico in Netto minimo!';
  A000MSG_P510_ERR_NO_PAG                  = 'Indicare almeno una modalità di pagamento!';
  A000MSG_P510_ERR_NO_DATA_ESEC_STESSO_ABI = 'Indicare la data esecuzione per beneficiari con c/c su stessa banca del tesoriere dell''ente!';
  A000MSG_P510_ERR_NO_DATA_ESEC_ABI_DIVERSO= 'Indicare la data esecuzione per beneficiari con c/c su altre banche diverse dal tesoriere dell''ente!';
  A000MSG_P510_ERR_DATA_ESEC_ABI_DIV_MAGG  = 'La data esecuzione per beneficiari con c/c su altre banche diverse dal tesoriere dell''ente è successiva ' +
                                             'alla data esecuzione per beneficiari con c/c su stessa banca del tesoriere dell''ente!';
  A000MSG_P510_ERR_DETT_DISP               = 'Indicare i dettagli della disposizione!';
  A000MSG_P510_ERR_NO_IDENTIFICATIVO       = 'Indicare l''identificativo flusso della disposizione!';
  A000MSG_P510_DLG_DATA_ESEC               = 'La data esecuzione per beneficiari con c/c su stessa banca del tesoriere dell''ente, di norma, coincide con il 27 del mese della data di lavoro. ' + #13#10 +
                                             'Proseguire comunque?';
  A000MSG_P510_DLG_DATA_ESEC_ABI_DIV_UGUALE= 'La data esecuzione per beneficiari con c/c su altre banche diverse dal tesoriere dell''ente è uguale ' +
                                             'alla data esecuzione per beneficiari con c/c su stessa banca del tesoriere dell''ente!' + #13#10 +
                                             'Proseguire comunque?';
  A000MSG_P510_ERR_ABI_FILE_UNICO          = 'Sono presenti contemporaneamente beneficiari con c/c sulla stessa e su altra banca del tesoriere: non è possibile procedere se il dato File unico per beneficiari con c/c sulla stessa/altra banca del tesoriere non è attivo!';
  A000MSG_P510_DLG_FMT_ELABORAZIONE        =  #13#10 + 'Con data esecuzione %s sono stati creati %s bonifici per un importo di euro %s per gli IBAN con ABI uguale a %s (tesoriere)' + #13#10 +
                                              'Con data esecuzione %s sono stati creati %s bonifici per un importo di euro %s per gli IBAN con ABI diverso da %s (tesoriere)' + #13#10 +
                                              'In totale sono stati creati %s bonifici per un importo di euro %s';
  A000MSG_P510_ERR_FMT_FLUSSO_ACQUISITO    =  'Impossibile creare il flusso del mese %s poiché già acquisito automaticamente per l’invio al tesoriere da %s in data %s';

  A000MSG_P511_ERR_SPEC_NOME_FILE          = 'Specificare il nome del file %s!';
  A000MSG_P511_ERR_FILE_INESISTENTE        = 'Impossibile procedere con l''importazione: il file %s non esiste!';
  A000MSG_P511_ERR_FILE_NON_VALIDO         = 'File %s vuoto o non valido!';

  A000MSG_P513_ERR_PROG_FLUSSO_NUM_INT     = 'Inserire un numero intero in Progressivo flusso!';
  A000MSG_P513_ERR_PROG_FLUSSO_NUM_POS     = 'Inserire un numero positivo in Progressivo flusso!';
  A000MSG_P513_ERR_DATA_CREAZIONE          = 'La data creazione flusso non è valida!';
  A000MSG_P513_ERR_PATH_FILE               = 'Il percorso della cartella di esportazione non è valido!';
  A000MSG_P513_ERR_NO_DATI_EXP             = 'Non sono stati individuati soggetti da esportare in base ai parametri specificati.';
  A000MSG_P513_ERR_FMT_LIMITE_DATI_EXP     = 'Sono stati individuati %s soggetti da esportare. Dato che non è possibile inviarne più di %s contemporaneamente, è necessario ridurre la selezione anagrafica!';
  A000MSG_P513_MSG_FMT_TIPO_SOGGETTO       = 'Codice fiscale %s (%s) ma il dato Tipo soggetto è impostato come Persona %s. Verificare l''anagrafica!';

  A000MSG_P552_ERR_NO_COD_TABELLA          = 'Indicare il Codice tabella!';
  A000MSG_P552_ERR_NO_DATO_LIBERO          = 'Indicare il Nome del dato libero!';
  A000MSG_P552_ERR_NO_FUNZ_ORACLE          = 'Indicare il testo della Funzione Oracle!';
  A000MSG_P552_MSG_FILTRO_DIP              = 'Filtro dipendenti non compatibile con la selezione anagrafica!';
  A000MSG_P552_DLG_RIPRISTINO_REGOLA       = 'Confermi il ripristino della regola di calcolo originale' + #13#10 +
                                             'sostituendo quella manuale ? ';

  A000MSG_P554_ERR_ANNO                    = 'Indicare un anno valido!';

  A000MSG_P555_ERR_NO_CALC_MAN_ANNO        = 'Query calcolo manuale inesistente per l''' + 'anno selezionato!';
  A000MSG_P555_ERR_NO_CALC_MAN_TAB         = 'Query calcolo manuale inesistente per la tabella selezionata!';
  A000MSG_P555_ERR_CHIUSO                  = 'L''elaborato risulta già chiuso per cui non può essere cancellato!';
  A000MSG_P555_MSG_MODIFICA_NON_CONSENTITA = 'La modifica è consentita solamente per gli elementi che non siano Chiusi';
  A000MSG_P555_DLG_INTESTAZIONE            = 'Salvare anche l''intestazione delle colonne?';
  A000MSG_P555_ERR_FMT_VALORI_DIVERSI      = 'La somma dei valori individuali (%s) non corrisponde al valore riepilogato (%s): occorre ricalcolare i dati riepilogativi di tutti i dipendenti!';

  A000MSG_P590_MSG_ACCORPAMENTI            = 'Attenzione: la stringa degli accorpamenti supera la massima lunghezza consentita (500 caratteri).';
  A000MSG_P590_MSG_DECORRENZA              = 'La data decorrenza è stata impostata a Inizio Mese!';
  A000MSG_P590_MSG_SCADENZA                = 'La data scadenza è stata impostata a Fine Mese!';
  A000MSG_P590_ERR_FMT_INTERSEZIONE        = 'Attenzione! Intersezione con i seguenti periodi: %s';
  A000MSG_P590_DLG_FMT_CODARROT            = 'Per il conto %s esistono periodi storici intersecanti che presentano un Codice arrotondamento diverso da quello che si sta cercando di impostare!'+#13#10+
                                             'Impostare il nuovo Codice arrotondamento %s per tutti i periodi storici intersecanti del conto %s?';
  A000MSG_P590_DLG_FMT_IDCONTO             = 'Per il conto %s esistono periodi storici intersecanti che presentano un Id conto diverso da quello che si sta cercando di impostare!'+#13#10+
                                             'Impostare il nuovo Id conto %s per tutti i periodi storici intersecanti del conto %s?';
  A000MSG_P590_DLG_CONFERMA_MODIF          = 'Confermi comunque la modifica anche se incompatibile con il passaggio dati alla contabilità generale?';
  A000MSG_P590_MSG_MODIFICA_CODARROT       = 'Modifica Codice arrotondamento effettuata con successo';
  A000MSG_P590_MSG_MODIFICA_IDCONTO        = 'Modifica Id conto effettuata con successo';
  A000MSG_P590_ERR_CODARROT                = 'Verificare il Codice arrotondamento impostato perchè diverso da quelli già esistenti per questo conto!';
  A000MSG_P590_ERR_IDCONTO                 = 'Verificare l''Id conto impostato perchè diverso da quelli già esistenti per questo conto!';

  A000MSG_P591_ERR_TIPO_CONTABILITA        = 'Selezionare il tipo contabilità!';
  A000MSG_P591_ERR_CONTAB_CHIUSA           = 'Impossibile eseguire l''operazione perché la contabilizzazione mensile è già stata chiusa!';
  A000MSG_P591_ERR_TIPO_CEDOLINO           = 'Selezionare almeno un tipo cedolino!';
  A000MSG_P591_ERR_PARAM_ESPORTAZIONE      = 'Selezionare una parametrizzazione di esportazione valida!';
  A000MSG_P591_ERR_NO_DEST_ESPORTAZIONE    = 'Indicare file o tabella di esportazione!';
  A000MSG_P591_ERR_FILE                    = 'Impossibile esportare i dati nel file!';
  A000MSG_P591_ERR_FMT_NO_CONTAB           = 'Nessuna contabilizzazione trovata per il mese %s e per il progressivo mensile indicato!';
  A000MSG_P591_ERR_FMT_TABELLA             = 'Impossibile esportare i dati nella tabella %s!';
  A000MSG_P591_ERR_FMT_COD_ARROT           = 'Trovato più di un codice arrotondamento per il conto: %s in data %s';
  A000MSG_P591_ERR_FMT_NO_DATO_INDIVID     = 'Nessun dato individuale trovato per il mese %s e per il progressivo mensile indicato!';
  A000MSG_P591_ERR_DATA_CHIUSURA           = 'Indicare una data chiusura valida!';
  A000MSG_P591_ERR_DATA_ESPORTAZIONE       = 'Indicare una data di esportazione valida!';
  A000MSG_P591_DLG_DATI_RIEP               = 'Si desidera eseguire il calcolo dei dati riepilogativi?';
  A000MSG_P591_DLG_ELAB_DATI_CONTAB        = 'Attenzione! I dati della contabilità saranno sovrascritti. Continuare?';
  A000MSG_P591_DLG_ELAB_RIEPILOGHI         = 'Attenzione! I riepiloghi saranno sovrascritti. Continuare?';
  A000MSG_P591_DLG_ELAB_ANNULLA_CONTAB     = 'Attenzione! Eliminare i dati della contabilità dei dipendenti selezionati e i dati riepilogativi?';
  A000MSG_P591_DLG_ELAB_CHIUSURA           = 'Confermi l''operazione di chiusura della contabilizzazione mensile?';
  A000MSG_P591_DLG_ELAB_ESPORTAZIONE       = 'Confermi l''esportazione dei dati?';
  A000MSG_P591_DLG_FMT_ESPORTA_DARE_AVERE  = 'Attenzione! Somma degli importi esportata in dare (%s) diversa da quella esportata in avere (%s)!';
  A000MSG_P591_DLG_FMT_ESPORTA_RIEP        = 'Attenzione! Somme degli importi esportate in dare (%s) e in avere (%s) diverse da quelle riepilogative calcolate in dare (%s) e in avere (%s)!';
  A000MSG_P591_DLG_FMT_ESPORTA_TOT         = 'Elaborazione terminata.' + #13#10 +
                                             'Totale in dare (%s) uguale al totale in avere (%s)';

  A000MSG_P592_DLG_CANCELLA                = 'Attenzione: la cancellazione comporta l''eliminazione della testata e dei dati elaborati di tutti i dipendenti. Confermi l''operazione?';
  A000MSG_P592_ERR_INSERISCI_CONTO         = 'Conto non abilitato all''inserimento per il periodo di lavoro!';

  A000MSG_P602_ERR_NO_MODIFICA             = 'Modifica consentita solo per le regole impostate come ''Regola modificabile''';
  A000MSG_P602_MSG_NO_REGOLA               = 'Non esiste alcuna regola originale.';
  A000MSG_P602_DLG_RIPRISTINO_REGOLA       = 'Confermi il ripristino della regola di calcolo originale' + #13#10 +
                                             'sostituendo quella manuale ? ';

  A000MSG_P604_ERR_ANNO_MINORE_2015        = 'L''anno indicato non può essere antecedente al 2015!';
  A000MSG_P604_ERR_MODELLO_GIA_CHIUSO      = 'Esiste già un modello 770 chiuso riferito all''anno indicato! ' + #13#10 + 'Impossibile proseguire con l''elaborazione';
  A000MSG_P604_ERR_MODELLO_NON_ESISTE_APER = 'Non esiste un modello 770 aperto riferito all''anno indicato! ' + #13#10 + 'Impossibile proseguire con l''elaborazione';
  A000MSG_P604_ERR_MODELLO_NON_ESISTE      = 'Non esiste un modello 770 da esportare riferito all''anno indicato!';
  A000MSG_P604_ERR_MODELLO_DOPPIO          = 'Esiste più di un modello 770 relativo all''anno indicato: rimuovere quelli non validi';
  A000MSG_P604_DLG_CHIUSURA                = 'Confermi l''operazione di chiusura del modello 770 riferito all''anno indicato?';

  A000MSG_P605_ERR_PERIODO_FUORI_ANNO      = 'Il periodo indicato deve essere compreso nell''anno di riferimento!';
  A000MSG_P605_ERR_NO_REGOLA               = 'Parte e Numero non presenti nell''elenco dei dati previsti per l''Anno!';
  A000MSG_P605_ERR_PARTE_PROSPETTO         = 'Parte incompatibile con il prospetto riepilogativo selezionato!';
  A000MSG_P605_ERR_DATO_NON_VALIDO         = 'Il dato "%s" non è valido!';
  A000MSG_P605_ERR_DATO_ZERO               = 'Il dato "%s" deve essere diverso da zero';

  A000MSG_P652_MSG_NO_REGOLA               = 'Non esiste alcuna regola originale.';
  A000MSG_P652_ERR_NO_MODIFICA             = 'Modifica consentita solo per le regole impostate come ''Regola modificabile''';
  A000MSG_P652_DLG_RIPRISTINO_REGOLA       = 'Confermi il ripristino della regola di calcolo originale' + #13#10 +
                                             'sostituendo quella manuale ? ';

  A000MSG_P655_ERR_TIPO_RECORD_MANUALI     = 'Modifica dei dai consentita solo se indicati';
  A000MSG_P655_ERR_PARTE                   = 'Il valore indicato nel campo Parte non è valido. Selezionarne uno dalla lista!';
  A000MSG_P655_ERR_NUMERO                  = 'Il valore indicato nel campo Numero non è valido. Selezionarne uno dalla lista!';
  A000MSG_P655_ERR_CHIUSO                  = 'L''elaborato risulta già chiuso per cui non può essere cancellato';

  A000MSG_P656_ERR_FMT_NO_FORNIT_ANTE      = 'Non esiste fornitura da esportare relativa al mese %s';
  A000MSG_P656_ERR_FMT_FORNIT_GIA_ESISTENTE= 'Esiste già una fornitura chiusa riferita al %s! ' + #13#10 +
                                             'Impossibile proseguire con l''elaborazione';
  A000MSG_P656_ERR_FMT_FORNIT_NON_ESISTENTE= 'Non esiste fornitura aperta del %s! ' + #13#10 +
                                             'Impossibile proseguire con l''elaborazione';
  A000MSG_P656_ERR_DEL_FILE                = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_P656_ERR_SCRIT_FILE              = 'Errore scrittura su file';
  A000MSG_P656_DLG_FMT_FORNIT_ANTE         = 'Esistono una o più forniture antecedenti a %s non chiuse! Proseguire comunque l''elaborazione del nuovo periodo?';
  A000MSG_P656_DLG_CHIUSURA                = 'Confermi l''operazione di chiusura della fornitura mensile?';

  A000MSG_P658_ERR_NO_REGOLA               = 'Non è stata definita alcuna regola per l''estrazione degli importi %s da versare con il modello F24 EP in data ';
  A000MSG_P658_ERR_NO_IMPORTI              = 'Non esistono importi %s da versare con il modello F24 EP in data ';
  A000MSG_P658_ERR_ERARIO_NEGATIVO         = 'Saldo totale negativo sulla sezione Erario per un importo pari a ';

  A000MSG_P659_DLG_ELAB_POST_2016          = 'A decorrere dal 2016 le compensazioni si possono effettuare direttamente sul modello F24 EP. Proseguire comunque elaborando il modello F24 ordinario?';
  A000MSG_P659_ERR_NO_REGOLA               = 'Non è stata definita alcuna regola per l''estrazione degli importi da dichiarare con il modello F24 ordinario in data ';
  A000MSG_P659_ERR_NO_IMPORTI              = 'Non esistono importi da dichiarare con il modello F24 ordinario in data ';

  A000MSG_P670_ERR_NO_MODIFICA             = 'Modifica consentita solo per le regole impostate come ''Regola modificabile''';
  A000MSG_P670_MSG_NO_REGOLA               = 'Non esiste alcuna regola originale.';
  A000MSG_P670_DLG_RIPRISTINO_REGOLA       = 'Confermi il ripristino della regola di calcolo originale' + #13#10 +
                                             'sostituendo quella manuale ? ';

  A000MSG_P671_ERR_MESE                    = 'Indicare un mese valido!';
  A000MSG_P671_ERR_FORNITURA_CHIUSA        = 'Esiste già una fornitura chiusa riferita al mese! ' + #13#10 + 'Impossibile proseguire con l''elaborazione';
  A000MSG_P671_ERR_FORNITURA_NON_ESISTE    = 'Non esiste fornitura aperta del mese! ' + #13#10 + 'Impossibile proseguire con l''elaborazione';
  A000MSG_P671_ERR_FORNITURA_DOPPIA        = 'Esiste più di una fornitura relativa al mese di elaborazione: rimuovere quelle non valide';
  A000MSG_P671_ERR_EXP_NO_TIPO_DATI        = 'Selezionare almeno una tipologia di dati da esportare!';
  A000MSG_P671_ERR_EXP_FORNITURA_NON_ESISTE= 'Non esiste fornitura mensile da esportare!';
  A000MSG_P671_ERR_EXP_NO_DATI             = 'Non esistono dati da esportare per i dipendenti selezionati!';
  A000MSG_P671_ERR_NO_ROOT                 = 'Le regole non hanno il primo nodo (radice)!';
  A000MSG_P671_ERR_FORNITURA_CHIUSA_IMP    = 'Impossibile procedere con l''importazione: esiste già una fornitura chiusa riferita al mese in elaborazione!';
  A000MSG_P671_ERR_FMT_CESSATO_E0          = 'Attenzione: dipendente cessato il %s: correggere manualmente il GiornoFine del quadro E0_PeriodoNelMese ed inserire il CodiceCessazione';
  A000MSG_P671_ERR_FMT_CESSATO_SENZACOD    = 'Attenzione: dipendente cessato il %s: inserire il corretto CodiceCessazione nel quadro E0_PeriodoNelMese/V1_PeriodoPrecedente';
  A000MSG_P671_ERR_FMT_CESSATO_POSAPERTA   = 'Attenzione: dipendente cessato il %s senza chiusura della PosPa (l''ultimo CodiceCessazione inviato è diverso da quello effettivo): occorre intervenire manualmente creando un V1_PeriodoPrecedente CausaleVariazione=7 CodiceMotivoUtilizzo=5' + ' ove ne ricorrano le condizioni oppure creando un V1_PeriodoPrecedente CausaleVariazione=5 correttivo';
  A000MSG_P671_ERR_FMT_ASSENTE_SENZACOD    = 'Attenzione: dipendente in aspettativa il primo giorno del mese successivo alla fornitura: inserire il CodiceCessazione %s nell''ultimo quadro E0_PeriodoNelMese';
  A000MSG_P671_ERR_ENTE_APPARTENENZA       = 'Ente di appartenenza coincidente con l''azienda dichiarante';
  A000MSG_P671_MSG_FMT_ELEMENTO_NO_IMP     = '%s_%s: Elemento non importabile. Contattare il fornitore';
  A000MSG_P671_ERR_FMT_ELEMENTO_NO_IMP     = '%s_%s: Elemento non importabile. Contattare il fornitore';
  A000MSG_P671_ERR_FMT_CODFISCALE_NO_TROV  = '%s: Cod.fiscale non trovato sull''anagrafica di base';
  A000MSG_P671_ERR_FMT_CODFISCALE_DOPPIO   = '%s: Cod.fiscale assegnato a più dipendenti, dimessi o in servizio contemporaneamente';
  A000MSG_P671_DLG_FMT_FORNITURA_PREC      = 'Esiste una fornitura precedente riferita al %s non chiusa! Proseguire comunque l''elaborazione del nuovo periodo?';
  A000MSG_P671_DLG_CHIUSURA                = 'Confermi l''operazione di chiusura della fornitura mensile?';
  A000MSG_P671_DLG_EXP_COMPLETA            = 'Attenzione: se si sta procedendo all''esportazione definitiva occorre avere appena eseguito Calcola giorni lavorativi INPS per tutti i dipendenti. Procedere con la creazione del file?';
  A000MSG_P671_DLG_EXP_DENUNCIA_AZIENDALE  = 'Attenzione: si sta procedendo all''esportazione della PosContributiva senza Denuncia aziendale. Procedere con la creazione del file?';
  A000MSG_P671_DLG_FORNITURA_ESISTE_IMP    = 'Esiste già una fornitura aperta riferita al mese in elaborazione! Prima di procedere con l''importazione del file, verificare se i dati INPDAP di tutti i dipendenti selezionati debbano essere cancellati. Proseguire comunque con l''importazione?';
  A000MSG_P671_MSG_EXP_INPS_IN_CORSO       = 'Esportazione dati INPS in corso...';
  A000MSG_P671_MSG_EXP_COLLAB_IN_CORSO     = 'Esportazione dati collaboratori in corso...';
  A000MSG_P671_MSG_EXP_INPDAP_IN_CORSO     = 'Esportazione dati INPDAP in corso...';
  A000MSG_P671_MSG_EXP_FINE_IN_CORSO       = 'Controlli aggiuntivi in corso...';
  A000MSG_P671_ERR_FMT_ENTEVERSANTE        = 'Attenzione: verificare il CFAzienda dell''EnteVersante sul periodo %s';
  A000MSG_P671_ERR_FMT_V17CMU2             = 'Attenzione: verificare il GiornoFine del quadro V1_PeriodoPrecedente CausaleVariazione=7 CodMotivoUtilizzo=2 perche'' non esiste alcun E0_PeriodoNelMese con lo stesso anno/mese (%s)';
  A000MSG_P671_ERR_FMT_V17CMU7             = 'Attenzione: presenza di più quadri V1_PeriodoPrecedente CausaleVariazione=7 CodMotivoUtilizzo=7 afferenti allo stesso mese: occorre intervenire manualmente creando un V1_PeriodoPrecedente CausaleVariazione=7 CodMotivoUtilizzo=7 cumulativo';
  A000MSG_P671_ERR_FMT_TFSTFR              = 'Attenzione: passaggio da TFS a TFR nel giorno %s senza presenza dei due relativi quadri E0_PeriodoNelMese afferenti allo stesso mese: occorre intervenire manualmente verificando la storicizzazione del passaggio e creando i quadri correttivi';
  A000MSG_P671_ERR_FMT_CODCESS48_1         = 'Attenzione: dipendente con variazione TipoImpiego il %s: spezzare il quadro E0_PeriodoNelMese inserendo il CodiceCessazione=48 sul primo';
  A000MSG_P671_ERR_FMT_CODCESS48_2         = 'Attenzione: dipendente con variazione TipoImpiego il %s: inserire il CodiceCessazione=48 sul quadro E0_PeriodoNelMese';

  A000MSG_P672_DLG_FMT_CANCELLA_DIP        = 'Eliminare la fornitura del dipendente selezionato alla data %s?';
  A000MSG_P672_DLG_FMT_CANCELLA_TESTATA    = 'Attenzione: la cancellazione comporta l''eliminazione della testata e dei dati elaborati di %s dipendenti. Confermi l''operazione?';
  A000MSG_P672_DLG_VARIAZ_V1C5             = 'Sono stati modificati dei valori numerici di un quadro V1 causale 5 e ciò può comportare un disallineamento con i versamenti dei contributi già effettutati. Confermi prosecuzione?';
  A000MSG_P672_DLG_DATI_INSERIMENTO        = 'Inserire solo i dati anagrafici (CFLavoratore, Cognome, Nome, DatiSedeLavoro) di D0_DenunciaIndividuale?';
  A000MSG_P672_DLG_FMT_COPIA_NODO          = 'Copiare il nodo %s con gli stessi valori?';
  A000MSG_P672_DLG_FMT_DUPLICA_NODO        = 'Duplicare il nodo %s inserendovi valori ''vuoti''?';
  A000MSG_P672_DLG_FMT_ELIMINA_NODO        = 'Eliminare il nodo %s?';
  A000MSG_P672_DLG_FMT_INS_FIGLI_MANCANTI  = 'Inserire i nodi figli mancanti di %s?';
  A000MSG_P672_DLG_FMT_COPIA_E0_DMA        = 'Copiare i quadri E0 e V1 della vecchia DMA riferiti al mese %s in un quadro V1 CausaleVariazione 5 cumulativo con sezione EnteVersante valorizzata?';
  A000MSG_P672_DLG_FMT_COPIA_E0_DMA2       = 'Copiare i quadri E0 del mese %s in quadri V1 CausaleVariazione 5 con gli stessi valori, creando l''eventuale quadro V1 CausaleVariazione 1 cumulativo con sezione EnteVersante valorizzata?';
  A000MSG_P672_DLG_IGNORARE_V1C1_CESSAZ48  = 'Ignorare gli eventuale quadri V1 CausaleVariazione 1 con CodiceCessazione 48 (Cambio TipoImpiego)?';
  A000MSG_P672_DLG_FMT_CUMUL_V1C1_CESSAZ48 = 'Cumulare tutti gli eventuale quadri V1 CausaleVariazione 1 con CodiceCessazione 48 (Cambio TipoImpiego) creati dopo il mese %s?';
  A000MSG_P672_DLG_FMT_CREARE_V1C7_CMU5    = 'Creare V1 CausaleVariazione 7 CodMotivoUtilizzo 5 riferito alla cessazione del %s?';
  A000MSG_P672_DLG_FMT_CREARE_V1C7_CMU7    = 'Copiare i quadri V1 CausaleVariazione 7 CodMotivoUtilizzo 7 riferiti al mese %s in un quadro V1 CausaleVariazione 7 CodMotivoUtilizzo 7 cumulativo con sezione EnteVersante valorizzata?';
  A000MSG_P672_DLG_FMT_CREARE_V1C7_CMU8    = 'Copiare i quadri V1 CausaleVariazione 7 CodMotivoUtilizzo 8 esistenti sul mese %s che si riferiscono al periodo %s?';
  A000MSG_P672_DLG_FMT_COPIA_E0_MOLTEPLICI = 'Copiare i quadri E0 dal mese %s al mese %s in quadri V1 CausaleVariazione 5 con gli stessi valori, creando gli eventuali quadri V1 CausaleVariazione 1 cumulativi con sezione EnteVersante valorizzata?';
  A000MSG_P672_DLG_CAMBIARE_TIPO_IMPIEGO   = 'Cambiare il TipoImpiego da 8/18 Part-time a 9 Orario ridotto con cancellazione del nodo PartTimePA?';
  A000MSG_P672_FMT_DLG_SPOSTARE_1_PERCENTO = 'Spostare l''importo %s relativo al conguaglio contributo 1 per cento dal quadro E0 al quadro V1 CausaleVariazione 7 CodMotivoUtilizzo 2? Attenzione, l''operazione deve essere eseguita una sola volta!';
  A000MSG_P672_MSG_CREATO_V1C1             = 'Se è stato creato il quadro V1 CausaleVariazione 1 sostitutivo, verificarne il GiornoInizio/GiornoFine per il corretto appoggio sul quadro E0.';
  A000MSG_P672_MSG_CREATO_V1C1_CESSAZ48    = 'Se è stato creato il quadro V1 CausaleVariazione 1 con CodiceCessazione 48 sostitutivo, verificarne il GiornoInizio/GiornoFine per il corretto appoggio sul quadro E0.';
  A000MSG_P672_ERR_NO_ROOT                 = 'Le regole non hanno il primo nodo (radice)!';
  A000MSG_P672_ERR_PERIODO_GIA_ESISTENTE   = 'Periodo già esistente!';
  A000MSG_P672_ERR_FMT_ELEM_INESISTENTE    = 'Elemento inesistente! Scegliere i valori dalla lista!';
  A000MSG_P672_ERR_FMT_ELEM_NUM            = 'Il valore dell''elemento ''%s - %s'' non è corretto: deve essere numerico!';
  A000MSG_P672_ERR_FMT_ELEM_DATA           = 'Il valore dell''elemento ''%s - %s'' non è corretto: deve essere una data nel formato GG/MM/AAAA!';
  A000MSG_P672_ERR_FMT_ELEM_MESE           = 'Il valore dell''elemento ''%s - %s'' non è corretto: deve essere una data nel formato MM/AAAA oppure MMAAAA!';
  A000MSG_P672_ERR_FMT_ELEM_STRINGA        = 'Il valore dell''elemento ''%s - %s'' non è corretto: deve essere una stringa lunga al massimo %s caratteri!';
  A000MSG_P672_ERR_FMT_NO_QUADRI           = 'Non sono presenti quadri %s nella fornitura del mese %s!';
  A000MSG_P672_ERR_V1C5_ANTE_DMA2          = 'Il mese inizio dei V1 CausaleVariazione 5 deve essere successivo o uguale a 10/2012!';
  A000MSG_P672_ERR_FMT_NO_DATA_ANTECEDENTE = 'Il mese fine dei V1 CausaleVariazione 5 deve essere antecedente il mese corrente %s!';
  A000MSG_P672_ERR_FMT_NO_QUADRO           = 'L''operazione non è possibile perchè non è presente il quadro %s!';
  A000MSG_P672_ERR_FMT_NO_CONTRIB1SUCEDOL  = 'L''operazione non è possibile perchè sul cedolino del mese non sono presenti voci relative al conguaglio contributo 1% con competenza anno precedente!';
  A000MSG_P672_ERR_FMT_PIU_QUADRI          = 'L''operazione non è possibile perchè sono presenti più quadri %s nel mese %s';
  A000MSG_P672_ERR_FMT_E0_DATA_INIZIO      = 'L''operazione non è possibile perchè il quadro %s del mese %s ha un GiornoInizio non coincidente con l''inizio del mese';
  A000MSG_P672_ERR_FMT_E0_TIPO_IMPIEGO     = 'L''operazione non è possibile perchè il quadro E0_PeriodoNelMese del mese %s ha un TipoImpiego diverso da 8/18 Part-time';
  A000MSG_P672_ERR_ANTE2012_E0_V1          = 'L''operazione non è possibile perchè sono già presenti quadri E0_PeriodoNelMese o V1_PeriodoPrecedente sulla nuova DMA2 antecedenti 10/2012';
  A000MSG_P672_ERR_FMT_V1_PERIODO_PREC     = 'Non è possibile creare i quadri V1_PeriodoPrecedente perchè sul mese %s sono già presenti quadri V1_PeriodoPrecedente %s';
  A000MSG_P672_ERR_FMT_V1_7_CMU5_NO_CESS   = 'Non è possibile creare il quadro V1_PeriodoPrecedente CausaleVariazione 7 CodMotivoUtilizzo 5 in quanto il dipendente non è cessato';
  A000MSG_P672_ERR_FMT_V1_7_CMU5_NO_CAUCESS= 'Non è possibile creare il quadro V1_PeriodoPrecedente CausaleVariazione 7 CodMotivoUtilizzo 5 in quanto non è stata impostata la causa di cessazione';
  A000MSG_P672_ERR_FMT_V1_7_CMU5_E0_PRES   = 'Non è possibile creare il quadro V1_PeriodoPrecedente CausaleVariazione 7 CodMotivoUtilizzo 5 relativo alla cessazione perchè sono già presenti quadri E0_PeriodoNelMese';
  A000MSG_P672_ERR_FMT_V1_7                = 'Non è possibile creare i quadri V1_PeriodoPrecedente CausaleVariazione 7 CodMotivoUtilizzo %s perchè sono presenti quadri successivi al mese %s anch''essi relativi a %s';
  A000MSG_P672_ERR_FMT_V1_78               = 'Non è possibile creare i quadri V1_PeriodoPrecedente CausaleVariazione 7 CodMotivoUtilizzo 8 con TipoServizio %s perchè sono presenti quadri successivi al mese %s anch''essi relativi a %s con stesso TipoServizio';
  A000MSG_P672_ERR_FMT_INS_PERIODO         = 'Inserimento fallito. Il periodo indicato potrebbe essere già esistente per il dipendente selezionato.' + #13#10 + '%s';
  A000MSG_P672_ERR_CANC_FORNITURA          = 'Errore durante la cancellazione della fornitura';
  A000MSG_P672_ERR_MODIF_ATTRIBUTO         = 'Impostare correttamente l''attributo rispettandone le regole sintattiche!';
  A000MSG_P672_ERR_CHIUSO                  = 'L''elaborato risulta già chiuso per cui non può essere cancellato';

  A000MSG_P664_DLG_FMT_CANCELLA_FONDO      = 'Attenzione: verranno cancellate %s risorse generali e %s destinazioni generali. Confermi l''operazione?';
  A000MSG_P664_DLG_RINUM_ORDINE_STAMPA     = 'Confermi la rinumerazione dell''ordine di stampa partendo da 10 con incremento di 5?';
  A000MSG_P664_DLG_ALLINEA_SPESO           = 'La somma degli importi delle voci è diversa dall''importo totale speso sulla destinazione dettagliata: allineare quest''ultimo?';
  A000MSG_P684_MSG_COD_ARROTONDAMENTO      = 'Attenzione: il codice Arrotondamento non è stato indicato. Il dato viene comunque salvato.';
  A000MSG_P684_MSG_ACCORPAMENTI            = 'Attenzione: la stringa degli accorpamenti supera la massima lunghezza consentita (500 caratteri).';
  A000MSG_P684_MSG_FILTRO_DIPENDENTI       = 'Attenzione: la stringa del filtro dipendenti supera la massima lunghezza consentita (500 caratteri).';
  A000MSG_P684_MSG_MODIFICA_COD_VOCE       = 'Modifica Codice voce terminata correttamente.';
  A000MSG_P684_MSG_IMPORTO_SPESO           = 'Attenzione: l''Importo speso non coincide con il dettaglio dei consumi mensili.';
  A000MSG_P684_ERR_COD_FONDO               = 'Specificare il Codice fondo!';
  A000MSG_P684_ERR_DATO_BASE               = 'Specificare il Dato base!';
  A000MSG_P684_ERR_MOLTIPLICATORE          = 'Specificare il Moltiplicatore!';
  A000MSG_P684_ERR_QUANTITA                = 'Specificare la Quantità!';
  A000MSG_P684_ERR_MESE_RETRIBUZIONE       = 'Specificare il Mese retribuzione!';
  A000MSG_P684_ERR_COD_CONTRATTO           = 'Specificare il Contratto voci!';
  A000MSG_P684_ERR_COD_VOCE                = 'Specificare un Codice voce esistente!';
  A000MSG_P684_ERR_MODIFICA_COD_VOCE       = 'Modifica impossibile: Codice voce già esistente!';
  A000MSG_P684_ERR_FMT_MODIFICA_COD_VOCE   = 'Modifica Codice voce terminata in modo irregolare a causa dei seguenti errori: %s!';
  A000MSG_P684_ERR_TIPO_ACCORPAMENTO       = 'Occorre selezionare almeno un Tipo accorpamento!';

  A000MSG_P686_DLG_ELAB_FONDI              = 'Confermi l''elaborazione dei fondi selezionati? L''operazione potrebbe richiedere diversi minuti.';
  A000MSG_P686_ERR_FONDI                   = 'Selezionare almeno un fondo da calcolare!';

  A000MSG_P690_ERR_FONDI                   = 'Selezionare almeno un fondo da stampare!';

  A000MSG_P700_ERR_COD_INPS                = 'Indicare almeno un Codice INPS!';
  A000MSG_P700_ERR_COD_DM10                = 'Indicare almeno un Codice DM10!';
  A000MSG_P700_ERR_COD_ACCORP_VOCI         = 'Selezionare almeno un codice accorpamento voci!';
  A000MSG_P700_ERR_RICERCA                 = 'Nessun dipendente risponde ai filtri di ricerca indicati!';

  A000MSG_P710_ERR_ANNO                    = 'La denuncia deve essere elaborata nell''ambito dello stesso anno!';
  A000MSG_P710_ERR_PERIODO                 = 'Il mese di inizio elaborazione non può essere successivo al mese di fine elaborazione!';
  A000MSG_P710_DLG_DENUNCIA                = 'Attenzione! Di norma la denuncia è annuale.' + #13#10 + 'Si desidera continuare?';
  A000MSG_P710_ERR_COD_INAIL               = 'Indicare almeno un Codice INAIL!';
  A000MSG_P710_ERR_POSIZ_INAIL             = 'Indicare almeno una Posizione da stampare!';
  A000MSG_P710_DLG_FMT_CALCOLO             = 'Prima di eseguire questa stampa occorre aver calcolato la ritenuta INAIL ente per il periodo dal %s al %s.' + #13#10 + 'Si desidera continuare?';
  A000MSG_P710_ERR_RICERCA                 = 'Nessun dipendente risponde ai filtri di ricerca indicati!';

  A000MSG_P715_ERR_CHK_REGOLE_ARCH         = 'Verificare la configurazione in Interfacce\Regole archiviazione documenti.';
  A000MSG_P715_ERR_ANNO_MINORE_2014        = 'L''anno di elaborazione non può essere antecedente al 2014!';
  A000MSG_P715_MSG_NO_MODELLO_CU           = 'Non esiste il modello CU sintetico per l''anno indicato';
  A000MSG_P715_DLG_ARCH_DT_PROCEDI         = 'Sono già state archiviate CU uguali o successive all''anno indicato (ultima archiviazione: %s).' + #13#10 +
                                             'Le CU di questo periodo potrebbero essere già state archiviate.' + #13#10 +
                                             'Proseguire comunque?';
  A000MSG_P715_ERR_FMT_DIR_CREA_DIR        = 'Impossibile creare la directory ''%s''!';
  A000MSG_P715_ERR_FMT_DIR_FILE_PDF        = 'Directory ''%s'' inesistente!' + #13#10 +
                                             'Parametrizzare correttamente il percorso per la stampa modelli CU in PDF!';
  A000MSG_P715_ERR_NO_DATO_CHK_REGOLE_ARCH = 'Dato anagrafico non trovato! Verificare l''esistenza dei campi indicati in Interfacce\Regole archiviazione documenti';
  A000MSG_P715_ERR_PROC_CREA_PDF           = 'Procedura creazione PDF non definita';

  A000MSG_P719_ERR_SPEC_CAT_CONV           = 'Specificare la categoria convenzionato!';

  A000MSG_P720_ERR_ANNO                    = 'Indicare un anno valido!';

  A000MSG_P725_ERR_COD_AZIENDA_NO_SPEC     = 'Specificare il Codice azienda!';

  A000MSG_P842_MSG_FMT_INS_RECUPERO_VOCI   = 'Inserimento voce %s %s in voci da recuperare/recuperate';
  A000MSG_P842_MSG_FMT_INS_STESSI_IMPORTI  = 'Inserimento voce %s %s con stessi importi e quantità per tutti dip.selez.';
  A000MSG_P842_MSG_FMT_DEL_STESSI_IMPORTI  = 'Cancellazione voce %s %s con stessi importi e quantità per tutti dip.selez.';
  A000MSG_P842_MSG_FMT_DEL_VARI_IMPORTI    = 'Cancellazione voce %s %s indipendentemente da importi e quantità per tutti dip.selez.';
  A000MSG_P842_DLG_RECUPERO_VOCI           = 'Confermi l''inserimento della voce nella tabella ''Voci da recuperare/recuperate''?';
  A000MSG_P842_DLG_FMT_RECUPERO_VOCI       = 'Attenzione: per il dipendente selezionato, sul mese di %s la voce %s con importo %s esiste già nella tabella ''Voci da recuperare/recuperate''. Continuare comunque?';
  A000MSG_P842_ERR_INS_VOCI_RECUPERO_VOCI  = 'Inserimento previsto solo per le voci 10011, 10041 e 10071!';
  A000MSG_P842_MSG_INS_IMP_RECUPERO_VOCI   = 'Il recupero ha superato l’importo da recuperare: il dato viene comunque salvato.';
  A000MSG_P842_ERR_ARROTONDAMENTO          = 'La voce non possiede arrotondamento';
  A000MSG_P842_DLG_UPD_NOTE                = 'Confermi l''aggiornamento delle note per tutti i dipendenti selezionati?';
  A000MSG_P842_DLG_UPD_ALLEGATO            = 'Confermi l''aggiornamento del nome file allegato e descrizione per tutti i dipendenti selezionati?';
  A000MSG_P842_DLG_FMT_INS_STESSI_IMPORTI  = 'Dipendenti selezionati: %s. Confermi l''inserimento della voce %s %s con stessi importi e quantità per tutti i dipendenti selezionati?';
  A000MSG_P842_DLG_FMT_DEL_STESSI_IMPORTI  = 'Dipendenti selezionati: %s. Confermi la cancellazione della voce %s %s con stessi importi e quantità per tutti i dipendenti selezionati?';
  A000MSG_P842_DLG_FMT_DEL_VARI_IMPORTI    = 'Dipendenti selezionati: %s. Confermi la cancellazione della voce %s %s indipendentemente da importi e quantità per tutti i dipendenti selezionati?';
  A000MSG_P842_ERR_VOCE_ESISTE             = 'Voce non inserita in quanto già esistente con stesse caratteristiche';
  A000MSG_P842_ERR_CEDOLINO_PREC_CHIUSO    = 'Voce non inserita: cedolino da aprire precedente all''ultimo chiuso';
  A000MSG_P842_ERR_CEDOLINO_APERTO         = 'Per eliminare il cedolino utilizzare l''apposita funzione di annullamento della maschera "Elaborazione cedolini"';
  A000MSG_P842_ERR_COMPETENZA_NO_ASSUNZ    = 'Voce non inserita: il periodo di competenza dal/al risulta non interamente coperto dall''assunzione';
  A000MSG_P842_ERR_NO_DATA_CED_RETR        = 'I mesi di retribuzione e di cassa devono essere inseriti';
  A000MSG_P842_ERR_DATA_CED                = 'Il mese cedolino deve essere maggiore o uguale al mese retribuzione!';
  A000MSG_P842_ERR_DATA_RETRIB_MESE_PREC   = 'Il mese cedolino deve essere maggiore del mese retribuzione se il tipo retribuzione dell''anagrafica stipendiale è impostata a mese precedente!';
  A000MSG_P842_ERR_NO_ANAG_STIP            = 'Non esiste l''anagrafica stipendi nel mese retribuzione';
  A000MSG_P842_ERR_DESCR_ALLEGATO          = 'E'' stata indicata una descrizione file allegato senza specificare il nome file allegato!';
  A000MSG_P842_ERR_ESISTE_CED              = 'Esiste già il cedolino del mese o di un mese successivo';
  A000MSG_P842_ERR_COMP_NO_ASSUNZIONE      = 'Il periodo di competenza dal/al risulta non interamente coperto dall''assunzione';
  A000MSG_P842_ERR_ORDINE_DATE_COMP        = 'Attenzione! Le date di competenza devono essere in ordine cronologico';
  A000MSG_P842_ERR_COMP_DOPO_CEDOLINO      = 'Attenzione! Il periodo di competenza dal/al è successivo al mese del cedolino';
  A000MSG_P842_ERR_COMP_STESSO_MM_AAAA     = 'Il periodo di competenza dal/al deve riferirsi allo stesso mese e anno.';
  A000MSG_P842_ERR_NO_DATOBASE             = 'Attenzione: importo unitario nullo.';
  A000MSG_P842_ERR_IND_PREAVVISO           = 'Attenzione: inserire nell''importo unitario e con segno positivo la somma totale destinata agli eredi inserita in capo al deceduto.';
  A000MSG_P842_ERR_ECCEZIONI_IRPEF         = 'Impossibile impostare contemporaneamente più eccezioni di calcolo relative all''IRPEF!';
  A000MSG_P842_MSG_INS_DATA_COMP_QUOTE     = 'Attenzione: la data competenza delle quote è stata impostata automaticamente alla data di competenza.';
  A000MSG_P842_MSG_FMT_UM_QUANTITA         = 'Attenzione: la voce prevede una quantità con unità di misura %s. Il dato viene comunque salvato';
  A000MSG_P842_MSG_NO_QUANTITA             = 'Attenzione: la voce non prevede quantità. Il dato viene comunque salvato';
  A000MSG_P842_MSG_NO_IMPORTO              = 'Attenzione: l''importo della voce è nullo. Il dato viene comunque salvato';
  A000MSG_P842_MSG_UPD_IMPORTO_VOCE_PROGR  = 'Attenzione: l''importo pagato della voce programmata %s %s non sarà aggiornato automaticamente dall''operazione di chiusura cedolino. L''aggiornamento avviene se la voce viene inserita tramite il conguaglio retroattivo';
  A000MSG_P842_ERR_INS_CED_APERTO_DIVERSO  = 'Esiste già un cedolino aperto di tipo diverso o relativo ad un altro mese retribuzione';

  A000MSG_R101_MSG_PSW_SCADUTA             = 'La password è scaduta! Inserirne una nuova';

  A000MSG_R400_MSG_RILEVAZIONE_MESE        = 'RILEVAZIONE DEL MESE DI';
  A000MSG_R400_MSG_AGGIORNAMENTO_SCHEDA    = 'CON AGGIORNAMENTO DELLA SCHEDA RIEPILOGATIVA';

  //Messaggi dei progetti STAGIU

  A000MSG_S000_ERR_DATO_AZIENDALE          = 'Attenzione: specificare il dato aziendale di riferimento per l''unità organizzativa!';

  A000MSG_S030_DLG_INS_DIP_UNO             = 'Si desidera inserire il provvedimento per il dipendente selezionato?';
  A000MSG_S030_DLG_FMT_INS_DIP             = 'Si desidera inserire il provvedimento per i %s dipendenti selezionati?';
  A000MSG_S030_DLG_DEL_DIP_UNO             = 'Si desidera cancellare il provvedimento visualizzato per il solo dipendente selezionato?';
  A000MSG_S030_DLG_FMT_DEL_DIP             = 'Si desidera cancellare il provvedimento visualizzato per tutti i %s dipendenti selezionati?';
  A000MSG_S030_ERR_NO_MOTIVAZIONE          = 'Per gestire il dettaglio è necessario indicare la motivazione!';
  A000MSG_S030_MSG_FMT_MOTIVAZIONE         = 'Attenzione: motivazione %s non trovata nella tabella corrispondente!';
  A000MSG_S030_DLG_CANCELLA_DETTAGLIO      = 'Attenzione: sono già presenti delle righe di dettaglio che verranno completamente rigenerate. Continuare comunque l''elaborazione?';
  A000MSG_S030_DLG_FMT_ELABORA_DETTAGLIO   = 'Confermi l''elaborazione dettaglio di %s in base alla situazione corrente degli archivi, con riferimento alla data %s?';
  A000MSG_S030_ERR_NO_RTF                  = 'Scegliere il modulo .rtf da stampare!';
  A000MSG_S030_ERR_FMT_NO_DECORRENZA       = 'Decorrenza non esistente per il dipendente: %s - %s %s --> Provvedimento non inserito!';
  A000MSG_S030_ERR_FMT_INSERIMENTO_KO      = 'Inserimento fallito per il dipendente: %s - %s %s';
  A000MSG_S030_ERR_FMT_CANCELLAZIONE_KO    = 'Cancellazione fallita per il dipendente: %s - %s %s';
  A000MSG_S030_ERR_FMT_NO_PROVVEDIMENTO    = 'Provvedimento non trovato per il dipendente: %s - %s %s --> Provvedimento non cancellato';
  A000MSG_S030_ERR_NO_DATO                 = 'Specificare il dato storico di riferimento!';
  A000MSG_S030_ERR_NO_CAUSALE              = 'Specificare la causale di assenza di riferimento!';
  A000MSG_S030_ERR_NO_DATA_REGISTRAZIONE   = 'Specificare la data di registrazione del provvedimento';
  A000MSG_S030_ERR_NO_DATA_DECORRENZA      = 'Specificare la data decorrenza del provvedimento';
  A000MSG_S030_ERR_NO_DATA_FINE            = 'Specificare la data fine del provvedimento';
  A000MSG_S030_DLG_NUM_ATTO_ESISTENTE      = 'Attenzione: numero atto già esistente. Continuare comunque?';
  A000MSG_S030_ERR_FMT_NUM_PREC            = 'Numero precedente %s non trovato su P660!';
  A000MSG_S030_ERR_FMT_NUM_SUCC            = 'Numero successivo %s non trovato su P660!';
  A000MSG_S030_ERR_FMT_QUERY_KO            = 'Query del numero %s non corretta!';

  A000MSG_S031_ERR_FMT_CANCFAM_GIUSTIF      = 'Impossible eliminare il familiare!' + #13#10 +
                                              'Sono presenti %s giustificativi nel periodo compreso tra il %s e il %s.';
  A000MSG_S031_ERR_GRADO_NESSUNO            = 'Esiste già un familiare con grado di parentela ''Nessuno''!';
  A000MSG_S031_ERR_MATR_NULLA               = 'Specificare la matricola di riferimento del dipendente!';
  A000MSG_S031_ERR_MATR_NODIP               = 'La matricola specificata non è quella del dipendente selezionato!';
  A000MSG_S031_ERR_MATR_DIP                 = 'La matricola specificata non può essere quella del dipendente selezionato!';
  A000MSG_S031_ERR_FMT_CF_DOPPIO            = 'Codice fiscale già utilizzato per il familiare con numero ordine %s !';
  A000MSG_S031_ERR_FMT_GRADO                = 'Per la parentela ''%s'' occorre specificare un grado superiore o uguale a %s!';
  A000MSG_S031_ERR_IRPEF                    = 'Grado di parentela incompatibile con il tipo di detrazione IRPEF!';
  A000MSG_S031_ERR_PERC_NULLA               = 'Familiare con detrazione IRPEF ma percentuale di carico sul dipendente nulla!';
  A000MSG_S031_ERR_PERC_NON_NULLA           = 'Detrazione IRPEF per nessun familiare ma percentuale di carico sul dipendente valorizzata!';
  A000MSG_S031_ERR_ANF                      = 'Il familiare non può fare parte del nucleo per l''assegno!';
  A000MSG_S031_ERR_DATADOZ_NULLA            = 'Specificare la data di nascita o la data di adozione del familiare!';
  A000MSG_S031_ERR_DATANAS_NULLA            = 'Specificare la data di nascita del familiare!';
  A000MSG_S031_ERR_FMT_COMUNE_NULLO         = 'Specificare il comune di %s del familiare!';
  A000MSG_S031_ERR_CF_NULLO                 = 'Specificare il codice fiscale del familiare!';
  A000MSG_S031_ERR_FMT_M3G_NULLO            = 'Specificare il motivo terzo grado %s!';
  A000MSG_S031_ERR_AAREV_NULLO              = 'Specificare la data di revisione della disabilità del familiare!';
  A000MSG_S031_ERR_ALTERN_NULLA             = 'Specificare il tipo soggetto dell''alternativa!';
  A000MSG_S031_ERR_DISAB_NULLA              = 'Specificare il tipo di disabilità!';
  A000MSG_S031_ERR_FMT_PERIODO              = '%s deve essere maggiore o uguale %s!';
  A000MSG_S031_MSG_INIZIO_EFF               = 'L''inizio gravidanza effettivo non può essere successivo all''inizio scelto dal dipendente!';
  A000MSG_S031_ERR_ALLINEA                  = 'Allineamento dati fallito. Valori Originali non trovati.';
  A000MSG_S031_MSG_FMT_INCOMPATIBILE        = 'il grado di parentela potrebbe essere incompatibile con il %s';
  A000MSG_S031_MSG_FMT_NULLO                = '%s non indicato';
  A000MSG_S031_MSG_FMT_INIZIO_FUORI_PERIODO = '%s non è compreso nel periodo previsto (%s)';
  A000MSG_S031_MSG_DATA_PREADOZ             = 'La data di pre-adozione deve essere valorizzata solo se tipo adozione internazionale!';
  A000MSG_S031_ERR_CODFISCALE_CONIUGE_CU    = 'E'' necessario indicare il codice fiscale del coniuge per poterlo riportare sul modello CU!';
  A000MSG_S031_DLG_FMT_DATA_DICHIARAZIONE   = 'Impostare la Data ultima dichiarazione familiari a carico al %s ?';
  A000MSG_S031_DLG_DATA_DICHIARAZIONE_VUOTA = 'Attenzione! Si sta svuotando la Data ultima dichiarazione familiari a carico per tutti i familiari del dipendente selezionato. Proseguire? ';

  A000MSG_S200_ERR_CANC                    = 'Impossibile procedere alla cancellazione della struttura perchè esistono uno o più atti che vi fanno riferimento.';
  A000MSG_S200_DLG_CANC                    = 'Saranno eliminati anche tutti i posti caricati nella distribuzione organico riferiti alla struttura corrente.' + #13#10 + 'Confermi cancellazione?';
  A000MSG_S200_ERR_NO_STRUTTURA            = 'La struttura di caricamento/visualizzazione non deve fare riferimento ad alcuna struttura.' + #13#10 + 'Il campo di riferimento sarà ripulito.';
  A000MSG_S200_ERR_POSTI_DETT              = 'Il numero dei posti dettagliati non deve essere maggiore del numero di posti previsti';
  A000MSG_S200_ERR_FMT_NO_ID_PADRE         = 'Impossibile copiare la struttura di riferimento: ID_PADRE %s non esistente!' + #13#10 + 'ID_RAMO figlio %s con PERCORSO:' + #13#10 + '%s';
  A000MSG_S201_ERR_NO_TIPO_STRUTTURA       = 'Selezionare il tipo di struttura o atti da visualizzare!';
  A000MSG_S202_ERR_NO_STRUTTURA            = 'Selezionare una struttura di caricamento/visualizzazione';
  A000MSG_S202_MSG_ELAB_VERIFICHE          = 'Verifica allineamenti in corso...';
  A000MSG_S202_MSG_ESPANSIONE              = 'Espansione in corso...premere Esc per interrompere';
  A000MSG_S202_MSG_CONTEGGIO_POSTI_PT      = 'Conteggio posti calcolati in percentuale part-time';
  A000MSG_S202_MSG_CONTEGGIO_POSTI_REG     = 'Conteggio posti calcolati da registrazione';
  A000MSG_S202_DLG_RICARICA_ALBERO         = 'Attenzione: per rendere effettiva tale impostazione occorre ricaricare l''albero. Caricare l''albero adesso?';

  A000MSG_S203_ERR_NO_DATO_ANAGRAFICO      = 'Indicare il dato anagrafico prima di selezionare i valori.';
  A000MSG_S203_ERR_SQL                     = 'Condizione non valida!';
  A000MSG_S203_ERR_ALL1_ALL2               = 'Selezionare il valore ''#ALL#'' oppure il valore ''#ALL-*#'' ma non entrambi!';
  A000MSG_S203_MSG_ALL1                    = 'Il valore ''#ALL#'' forza la considerazione di tutti i valori e non è più necessario selezionarli.';
  A000MSG_S203_MSG_ALL2                    = 'Il valore ''#ALL-*#'' forza la considerazione di tutti i valori tranne ''*'' e non è più necessario selezionarli.';
  A000MSG_S203_ERR_NO_CODICE               = 'Nessuna stampa selezionata!';
  A000MSG_S203_ERR_NO_DATO_RIGHE           = 'Righe di stampa: nessun dato selezionato!';
  A000MSG_S203_ERR_NO_FILTRO_RIGHE         = 'Righe di stampa: nessun filtro impostato!';
  A000MSG_S203_ERR_NO_DATO_COLONNE         = 'Colonne di stampa: nessun dato selezionato!';
  A000MSG_S203_ERR_NO_DATO_DIPENDENTI      = 'Dati anagrafici dipendenti: nessun dato selezionato!';
  A000MSG_S203_ERR_NO_ORDINE_DIPENDENTI    = 'Dettaglio dipendenti: nessun ordinamento impostato!';
  A000MSG_S203_MSG_ELAB_VERIFICHE          = 'Verifica allineamenti in corso...';
  A000MSG_S203_MSG_ELAB_RIGHE              = 'Caricamento righe in corso...premere Esc per interrompere';
  A000MSG_S203_MSG_ELAB_COLONNE            = 'Caricamento colonne in corso...premere Esc per interrompere';
  A000MSG_S203_MSG_ELAB_STAMPA             = 'Preparazione stampa in corso...premere Esc per interrompere';

  A000MSG_S210_ERR_NO_FILE                 = 'Specificare il nome del file di esportazione!';
  A000MSG_S210_DLG_FILE_ESISTE             = 'Il file indicato per l''esportazione è già esistente. Proseguire comunque sostituendolo con i nuovi dati?';
  A000MSG_S210_ERR_FILE_IN_USO             = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_S210_ERR_LIMITE_ANAGRAFICHE      = 'Non è possibile esportare il curriculum di più di 50 dipendenti per volta. Limitare la selezione anagrafica.';
  A000MSG_S210_MSG_NO_INCARICO_ATTUALE     = 'Impossibile esportare il curriculum: incarico attuale non indicato!';

  A000MSG_S250_FMT_DATA_NO_SUCCESSIVA      = 'La %s non può essere successiva alla %s!';

  A000MSG_S303_ERR_VIS_ASSENZE             = 'Specificare le causali di assenza da considerare nella visualizzazione dei periodi!';
  A000MSG_S303_ERR_DATA_SCADENZA           = 'Specificare una data scadenza successiva alla data affidamento!';
  A000MSG_S303_ERR_DATA_SCADENZA_VUOTA     = 'Specificare una data scadenza prorogata solo se è già stata specificata la data scadenza!';
  A000MSG_S303_ERR_DATA_SCADENZA_PROROGATA = 'Specificare una data scadenza prorogata successiva alla data scadenza!';
  A000MSG_S303_MSG_UO_DIP                  = 'Attenzione: unità organizzativa diversa da quella del dipendente. Il dato viene comunque salvato!';
  A000MSG_S303_DLG_COPIA_INCARICO          = 'Vuoi copiare i dati da un incarico esistente?';

  A000MSG_S402_DLG_CANCELLA                = 'Attenzione: verranno cancellate anche tutte le visite collegate al rischio corrente. Continuare?';
  A000MSG_S402_ERR_NO_DATA_ASSUNZ          = 'Dipendente senza data di assunzione!';
  A000MSG_S402_ERR_DATE_ESPOSIZIONE        = 'Attenzione: data fine antecedente alla data inizio esposizione!';
  A000MSG_S402_DLG_SUCC_PRIMA_VISITA       = 'Attenzione: data inizio esposizione successiva alla data prima visita! Continuare?';
  A000MSG_S402_DLG_PRE_ULTIMA_VISITA       = 'Attenzione: data fine esposizione antecedente alla data ultima visita! Continuare?';
  A000MSG_S402_DLG_PERIODO_INTERSECA       = 'Attenzione: il periodo interseca un periodo rischio già esistente! Continuare?';
  A000MSG_S402_ERR_DATE_VISITA             = 'Attenzione: data prossima visita antecedente alla data visita!';
  A000MSG_S402_ERR_ESITO                   = 'Attenzione: esito non valido!';
  A000MSG_S402_DLG_PRE_INIZIO_RISCHIO      = 'Attenzione: data visita antecedente alla data inizio esposizione rischio! Continuare?';
  A000MSG_S402_DLG_SUCC_FINE_RISCHIO       = 'Attenzione: data visita successiva alla data fine esposizione rischio! Continuare?';
  A000MSG_S402_DLG_ESITO_PRE_VISITA        = 'Attenzione: data esito inferiore a data visita! Continuare?';

  A000MSG_S700_ERR_FMT_VAL_COMPRESO        = 'Il valore del campo %s deve essere compreso tra 0 e 100!';
  A000MSG_S700_ERR_FMT_COD_INSERITO        = 'Il codice elemento %s dell''area %s è già stato inserito manualmente nelle schede di valutazione!';
  A000MSG_S700_ERR_INSERIRE_COD            = 'Inserire il codice dell''elemento!';
  A000MSG_S700_ERR_INSERIRE_DESC           = 'Inserire la descrizione dell''elemento!';
  A000MSG_S700_ERR_INS_COD_AREA            = 'Inserire il codice dell''area collegata!';
  A000MSG_S700_ERR_INS_COD_ELEM            = 'Inserire il codice dell''elemento collegato!';
  A000MSG_S700_ERR_VALID_ELEM              = 'L''elemento collegato non è valido! Sceglierne uno dalla lista!';
  A000MSG_S700_ERR_PESO_PERC_AREA          = 'Indicare il Peso % dell''area';
  A000MSG_S700_ERR_PESO_RANGE_ELEM         = 'Impostare correttamente il range del dato Elementi personalizzati!';
  A000MSG_S700_MSG_COMPILARE_CAMPO         = 'Compilare il campo ';
  A000MSG_S700_ERR_SOMMA_PESO              = 'La somma di Peso % degli elementi deve essere 100!';
  A000MSG_S700_ERR_PESO_COMPRESO           = 'Il Peso % dell''area deve essere compreso tra 0 e 100!';
  A000MSG_S700_ERR_FMT_DATE_SUCC           = 'Attenzione! Sono già state create delle Schede di valutazione con il codice area %s in date successive alla decorrenza corrente! Potrebbero verificarsi dei disallineamenti!';
  A000MSG_S700_MSG_CANC_VALUT              = 'Attenzione: verranno cancellate anche tutte le valutazioni collegate all''area. Continuare?';
  A000MSG_S700_ERR_FMT_COPIA_DETT_AREE     = 'Al %s non sono presenti aree compatibili con l''operazione richiesta!';
  A000MSG_S700_DLG_FMT_COPIA_DETT          = 'Attenzione! Riportando gli elementi dell''area corrente (%s)' + #13#10 + 'sulle aree selezionate (%s)' + #13#10 + 'per quest''ultime verranno eliminati gli elementi precedentemente configurati al %s.' + #13#10 + 'Proseguire comunque?';

  A000MSG_S715_ERR_NO_TIPO_QUOTA           = 'Selezionare almeno una tipologia quota per l''aggiornamento degli incentivi!';
  A000MSG_S715_ERR_NO_STATO_AVANZAMENTO    = 'Selezionare almeno uno stato avanzamento dall''elenco!';
  A000MSG_S715_DLG_FMT_CONFERMA_ESEGUI     = 'Attenzione! Sulle schede corrispondenti ai filtri selezionati verranno eseguite le seguenti azioni: %s ' + #13#10 +
                                             'Proseguire?';

  A000MSG_S720_ERR_SEL_AREA_VAL            = 'Selezionare l''area di valutazione!';
  A000MSG_S720_ERR_SPEC_PRIMO_LIV          = 'Specificare il primo livello anagrafico!';
  A000MSG_S720_ERR_SPEC_SECONDO_LIV        = 'Specificare il secondo livello anagrafico!';
  A000MSG_S720_DLG_FMT_CONFERMA_IMP        = 'Confermi l''importazione da file dei profili delle valutazioni per l''anno %s?';
  A000MSG_S720_ERR_NO_ANNO                 = 'Indicare l''anno da valutare!';
  A000MSG_S720_ERR_NO_SEPARATORE           = 'Indicare il separatore!';
  A000MSG_S720_ERR_ESISTE_SCHEDA           = 'Sono già state create delle schede di valutazione a partire dall''anno selezionato!';
  A000MSG_S720_ERR_LETTURA_FILE            = 'Errore durante la lettura del file!';
  A000MSG_S720_ERR_FILE_NO_DATI            = 'Il file non contiene dati da importare!';
  A000MSG_S720_MSG_STEP_CTRL_GEN           = 'Lettura del file e controlli preliminari...';
  A000MSG_S720_MSG_STEP_CTRL_PESI          = 'Controllo pesi obiettivi...';
  A000MSG_S720_MSG_STEP_INIZIO_IMP         = 'Impostazioni iniziali...';
  A000MSG_S720_MSG_STEP_ITEM_PROPRI        = 'Caricamento obiettivi individuali...';
  A000MSG_S720_MSG_STEP_ITEM_RIPORTA       = 'Caricamento obiettivi riportati...';
  A000MSG_S720_MSG_STEP_ITEM_CONVOGLIA     = 'Caricamento obiettivi convogliati...';
  A000MSG_S720_ERR_FMT_NO_DATO             = '"%s" non valorizzato!';
  A000MSG_S720_ERR_FMT_NO_DIP_IN_SERVIZIO  = '%s non corrisponde ad alcun dipendente in servizio durante l''anno %s (valore presente: %s)';
  A000MSG_S720_ERR_FMT_FASCIA_EXTRA        = '"Fascia del dirigente" contiene un valore non consentito (valore presente: %s; valori consentiti: 1,2)';
  A000MSG_S720_ERR_FASCIA_DIVERSA          = '"Fascia del dirigente" contiene valori diversi per la stessa "Matricola del dirigente"';
  A000MSG_S720_ERR_FMT_DATO_NO_NUMERICO    = '%s contiene un valore non numerico (valore presente: %s)';
  A000MSG_S720_ERR_FMT_ITEM_DOPPIO         = '"Codice obiettivo" ripetuto per la stessa "Matricola del dirigente" (valore presente: %s)';
  A000MSG_S720_ERR_FMT_DIPENDENTE_DOPPIO   = '"Elenco matricole dei dipendenti" contiene una matricola associata a più di un dirigente (valore presente: %s)';
  A000MSG_S720_ERR_FMT_DIR_SUP_PER_FASCIA1 = '"Matricola del dirigente di fascia superiore" valorizzata per dirigente di primo livello (valore presente: %s)';
  A000MSG_S720_ERR_FMT_DIR_SUP_CON_FASCIA2 = '"Matricola del dirigente di fascia superiore" contiene una matricola segnalata come dirigente di secondo livello (valore presente: %s)';
  A000MSG_S720_ERR_FMT_TOT_PESI_ITEM       = 'Il totale dei pesi degli obiettivi è diverso da 100 (valore presente: %s)';
  A000MSG_S720_ERR_FMT_TROPPE_COMB_ITEM    = 'Impossibile recuperare gli obiettivi per il dipendente: combinazione successiva fuori dal range a..z (massimo valore utilizzato: %s)';
  A000MSG_S720_ERR_COD_DIR_TROPPE_AREE     = 'Impossibile recuperare il codice del dirigente dall''ultima scheda: troppe aree';
  A000MSG_S720_ERR_COD_DIR_TROPPI_VALORI   = 'Impossibile recuperare il codice del dirigente dalla scheda anagrafica: troppi valori';
  A000MSG_S720_ERR_TROPPI_COD_DIR          = 'Impossibile recuperare il codice del dirigente: fuori dal range 1..998';

  A000MSG_S730_ERR_DIST_SCALE_PUNT         = 'Impossibile accedere! Impostare a livello aziendale il dato anagrafico per la distinzione delle scale di punteggio!';

  A000MSG_S740_ERR_DATE_VAL                = 'Le date di inizio e fine periodo per l''assegnazione preventiva degli obiettivi devono essere entrambe valorizzate!';
  A000MSG_S740_ERR_DATE_ORDINE             = 'Le date di inizio e fine periodo per l''assegnazione preventiva degli obiettivi devono essere in ordine cronologico!';
  A000MSG_S740_ERR_IMPOSTARE_CAMPO         = 'Impostare correttamente il campo "';
  A000MSG_S740_ERR_SESTA_FIRMA             = 'E'' necessario indicare la sesta firma in quanto è stata scelta in "';
  A000MSG_S740_ERR_INTERNO_ANNO            = 'Attenzione! Il periodo per l''assegnazione preventiva degli obiettivi non è interno all''anno ';

  A000MSG_S746_ERR_CODICE                  = 'Il codice deve essere un numero maggiore di 0!';
  A000MSG_S746_ERR_PERIODO_INF_LIV_PREC    = 'Lo stato di avanzamento precedente non ha un periodo di decorrenza sufficientemente ampio!';
  A000MSG_S746_ERR_PERIODO_MAGG_LIV_SUCC   = 'Lo stato di avanzamento successivo ha un periodo di decorrenza più ampio!';
  A000MSG_S746_ERR_ESISTE_LIV_SUCC         = 'Esiste uno stato di avanzamento successivo che interseca il periodo storico da cancellare!';
  A000MSG_S746_ERR_DATE_DA_VALORIZZARE     = 'Le date di inizio e fine periodo per la compilazione devono essere entrambe valorizzate!';
  A000MSG_S746_ERR_DATE_VAL_O_SVUO         = 'Le date di inizio e fine periodo per la registrazione della presa visione devono essere entrambe valorizzate o svuotate!';
  A000MSG_S746_ERR_ORDINE_DATE_RICH        = 'Le date di inizio e fine periodo per la registrazione della presa visione devono essere in ordine cronologico!';
  A000MSG_S746_ERR_ORDINE_DATE_COMP        = 'Le date di inizio e fine periodo per la compilazione devono essere in ordine cronologico!';
  A000MSG_S746_ERR_FMT_PERIODO_INTERNO     = 'Attenzione! Il periodo per la compilazione non è interno all''anno %s !';

  A000MSG_C018_MSG_NESSUN_ALLEGATO         = '(nessun allegato)';
  A000MSG_C018_MSG_NOABIL_ALL_AUT          = 'l''autorizzatore può esclusivamente consultare gli allegati';
  A000MSG_C018_MSG_NOABIL_ALL_RIC_DA_AUT   = 'la richiesta è ancora da autorizzare';
  A000MSG_C018_MSG_FMT_NOABIL_ALL_RIC_AUT  = 'è %s la modifica degli allegati per le richieste autorizzate definitivamente';
  A000MSG_C018_MSG_NOABIL_ALL_RIC_NEG      = 'la richiesta è negata';
  A000MSG_C018_MSG_NOABIL_ALL_RIC_ANNULL   = 'la richiesta è annullata';
  A000MSG_C018_MSG_STRUTTURA               = 'Struttura';
  A000MSG_C018_MSG_ALLEGATI                = 'Allegati richiesta';
  A000MSG_C018_MSG_ALLEGATI_ESISTENTI      = 'allegati presenti';
  A000MSG_C018_MSG_ALLEGATI_OBBLIGATORI    = 'allegati obbligatori';
  A000MSG_C018_MSG_ALLEGATI_FACOLTATIVI    = 'allegati facoltativi';
  A000MSG_C018_ERR_ALLEGATI_OBBLIGATORI    = 'la richiesta prevede la presenza obbligatoria di allegati';
  A000MSG_C018_ERR_STOP_DATA_ANTECEDENTE   = 'Non è possibile effettuare la richiesta prima del %s!';
  A000MSG_C018_ERR_PRESENZA_ALLEGATI       = 'La richiesta da eliminare ha documenti allegati.'#13#10'Cancellazione non consentita!';
  A000MSG_C018_ERR_FMT_CONDIZ_ALLEG        = 'Riconoscimento della gestione allegati per la struttura "%s" fallito.'#13#10'Deve ritornare uno dei valori ammessi: N,F,O.'#13#10'%s';
  A000MSG_C018_ERR_FMT_FLAG_CONDIZ_ALLEG   = 'Tipo di gestione allegati per la struttura "%s" non valido: %s'#13#10'Valori ammessi: N, F, O';

  A000MSG_WC018_MSG_FMT_RIEPILOGO_ITER     = 'Riepilogo Iter %s (%s)';
  A000MSG_WC018_MSG_RICHIESTA              = 'Richiesta';
  A000MSG_WC018_MSG_AUTORIZZAZIONE         = 'Autorizzazione';
  A000MSG_WC018_MSG_VISTO                  = 'Visto';
  A000MSG_WC018_DLG_SALVA_NOTE             = 'Salvare le modifiche alle note?';
  A000MSG_WC018_MSG_NESSUNA_NOTA           = '(nessuna nota)';

  A000MSG_WC026_ERR_SELEZIONARE_DOC        = 'Selezionare il documento da allegare alla richiesta!';
  A000MSG_WC026_ERR_FMT_DOC_UPLOAD         = 'Errore durante l''upload del documento:'#13#10'%s';
  A000MSG_WC026_ERR_FMT_DOC_DOWNLOAD       = 'Errore durante il download del documento:'#13#10'%s';
  A000MSG_WC026_ERR_DOC_INESISTENTE        = 'Il documento allegato non esiste!';

  A000MSG_C021_ERR_FMT_ELIMINA_DOC        = 'Errore durante l''eliminazione del documento:'#13#10'%s';
  A000MSG_C021_ERR_FMT_SALVA_DOC          = 'Errore durante il salvataggio del documento:'#13#10'%s';

  A000MSG_WC501_ERR_MESSAGGI_LETT_OBBL     = 'Sono presenti messaggi con lettura obbligatoria!';

  A000MSG_R003_ERR_FORMATO_GIUST           = 'Formato non corretto: (C)odice o (D)escrizione';
  A000MSG_R003_ERR_FORMATO_DIM_GIUST       = 'Formato non corretto: inserire la dimensione dopo C/D';
  A000MSG_R003_ERR_FORMATO_TIMBR           = 'Formato non corretto: (T)imbratura (C)ausale (R)ilevatore (S)igla causale';
  A000MSG_R003_ERR_DUPLICA_TROPPO_LUNGO    = 'Codice nuova stampa troppo lungo!';
  A000MSG_R003_ERR_DUPLICA_ESISTENTE       = 'Codice nuova stampa già esistente!';
  A000MSG_R003_ERR_DUPLICA_VUOTO           = 'Codice nuova stampa non indicato!';
  A000MSG_R003_ERR_DATO_ESISTENTE          = 'Dato già esistente! Usare un altro nome';
  A000MSG_R003_ERR_NO_DATO_STAMPA          = 'Non è stato selezionato nessun dato da stampare: Impossibile proseguire!';
  A000MSG_R003_ERR_AREA_STAMPA_PENDING     = 'Esistono Modifiche non confermate sulle griglie di intestazione o dettaglio. Confermare o annullare i dati su queste';
  A000MSG_R003_ERR_DATE_NON_CORRETTE       = 'Date non corrette!';
  A000MSG_R003_ERR_DELETE_USATO            = 'Dato utilizzato nelle stampe: impossible cancellarlo!';

  A000MSG_R003_MSG_STAMPA_BLOCCATA         = 'Impossibile modificare/cancellare una stampa protetta';
  A000MSG_R003_MSG_NO_TABELLA              = 'Nome tabella da generare non indicato!';
  A000MSG_R003_MSG_SPECIFICARE_STAMPA      = 'Specificare la stampa da generare!';
  A000MSG_R003_MSG_PERIODO_MAGGIORE_2_ANNI = 'Il periodo specificato non può essere superiore ai 2 anni!';
  A000MSG_R003_MSG_PERIODO_MAGGIORE_20_ANNI = 'Il periodo specificato non può essere superiore ai 20 anni!';
  A000MSG_R003_MSG_CONFERMA_SOSTITUISCI    = 'Sostituire le occorrenze del dato col nuovo nome?';

  A000MSG_DATIBLOCCATI_ERR_FMT_DATI_NONMODIF  = '%s : [%s] dati non modificabili, riepilogo bloccato';

function A000TraduzioneEccezioni(Msg:String):String;

implementation

function A000TraduzioneEccezioni(Msg:String):String;
begin
  Result:=Msg;

  if (Pos('Field ',Result) = 1) then
  begin
    Result:=StringReplace(Result,'Field ','Il dato ',[]);
  end;
  Result:=StringReplace(Result,'The following exception occured' + #13#10,'',[]);
  Result:=StringReplace(Result,'must have a value','deve essere valorizzato',[]);
  Result:=StringReplace(Result,'is not a valid date and time','non è una data/ora valida',[]);
  Result:=StringReplace(Result,'is not a valid date','non è una data valida',[]);
  // daniloc. - aggiunto 01/12/2014
  Result:=StringReplace(Result,'is not a valid value for field ','non è un valore valido per il dato ',[]);
  Result:=StringReplace(Result,'The allowed range is ','Indicare un valore compreso fra ',[]);
  Result:=StringReplace(Result,' to ',' e ',[]);
end;

end.





