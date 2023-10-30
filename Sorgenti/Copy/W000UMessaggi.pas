unit W000UMessaggi;
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

resourcestring
  //messaggi specifici
  A000MSG_C001_MSG_LEGENDA_GG                  = 'Legenda tipologia giorni';

  A000MSG_W001_MSG_NOTIFICHE_CERTIFIC          = 'sono presenti certificazioni da autorizzare';
  A000MSG_W001_MSG_NOTIFICHE_AUTORIZZ          = 'sono presenti richieste da autorizzare';
  A000MSG_W001_MSG_NOTIFICHE_VALID_CART        = 'sono presenti cartellini da validare';
  A000MSG_W001_MSG_NOTIFICHE_SCIOPERO          = 'sono presenti notifiche di sciopero da completare';
  A000MSG_W001_MSG_NOTIFICHE_MESSAGGI          = 'sono presenti messaggi da leggere';
  A000MSG_W001_MSG_NOTIFICHE_DOCUMENTI         = 'sono presenti documenti da leggere';
  A000MSG_W001_MSG_NOTIFICHE_CEDOLINI          = 'sono presenti cedolini da consultare';
  A000MSG_W001_MSG_NOTIFICHE_CU                = 'sono presenti modelli CU da consultare';
  A000MSG_W001_ERR_NOTIFICHE_FILTRO_ANAGRAFE   = 'Filtro anagrafe incompatibile';
  A000MSG_W001_ERR_FMT_RECUPERO_PWD_INPUT      = 'Per il recupero della password è necessario indicare il dato %s!';
  A000MSG_W001_ERR_RECUPERO_PWD_NO_AZIENDA     = 'L''azienda indicata è inesistente!';
  A000MSG_W001_ERR_RECUPERO_PWD_NO_UTENTE      = 'L''utente indicato è inesistente!';
  A000MSG_W001_MSG_RECUPERO_PWD_INVIATA_TITLE  = 'Password inviata';
  A000MSG_W001_MSG_RECUPERO_PWD_INVIATA        = 'La password è stata inoltrata via email.'#13#10'Controllare la propria casella di posta elettronica registrata su IrisWeb';
  A000MSG_W001_ERR_RECUPERO_PWD_AUT_ESTERNA    = 'Attenzione!'#13#10'L''autenticazione non è gestita da IrisWEB';
  A000MSG_W001_ERR_RECUPERO_PWD_NO_HOST        = 'Non è stato indicato nessun server di posta per l''invio mail.'#13#10'Contattare l''amministratore dell''applicativo.';
  A000MSG_W001_ERR_RECUPERO_PWD_NO_MAIL        = 'L''utente indicato non ha nessun indirizzo di mail associato!'#13#10'Non è possibile recuperare la password.';

  A000MSG_W002_MSG_INSERIRE_NOME_SELEZIONE     = 'Specificare il nome della selezione da salvare!';
  A000MSG_W002_MSG_SELEZIONE_NON_ATTIVA        = 'Non è attiva nessuna selezione personalizzata!';
  A000MSG_W002_MSG_FMT_SELEZIONE_SALVATA       = 'Selezione "%s" salvata!';
  A000MSG_W002_ERR_SELEZIONE_GIA_ESISTENTE     = 'Impossibile salvare! Selezione già esistente.';
  A000MSG_W002_MSG_INSERIRE_DATALAVORO         = 'Indicare la data di lavoro!';
  A000MSG_W002_ERR_DATALAVORO_NON_VALIDA       = 'La data di lavoro indicata non è valida!';
  A000MSG_W002_MSG_SELEZIONE_CANCELLARE        = 'Specificare il nome della selezione da cancellare!';
  A000MSG_W002_MSG_SELEZIONE_CANCELLATA        = 'Selezione cancellata!';
  A000MSG_W002_MSG_IMPOSSIB_CANC_SELEZIONE     = 'Impossibile cancellare! Selezione non esistente.';
  A000MSG_W002_ERR_FMT_FILTRO_NON_ASSOCIATO    = 'Il filtro anagrafe associato all''utente "%s" non è corretto.'#13#10'Errore: %s';
  A000MSG_W002_ERR_FMT_SELEZIONE_SBAGLIATA     = 'La selezione "%s" non è corretta.'#13#10'Errore: %s';
  A000MSG_W002_ERR_FMT_SELEZIONE_SBAGLIATA2    = 'La selezione effettuata non è corretta.'#13#10'Errore: %s';
  A000MSG_W002_ERR_SELEZIONE_ANAG_ERRATA       = 'Attenzione! La selezione anagrafica è errata!';

  A000MSG_W004_MSG_LBL_DETTAGLIO               = 'Dettaglio';
  A000MSG_W004_MSG_LBL_PROSPETTO               = 'Prospetto';
  A000MSG_W004_MSG_LBL_GEST_MENSILE            = 'Gestione mensile';
  A000MSG_W004_MSG_LBL_STAMPA                  = 'Stampa';
  A000MSG_W004_MSG_LEGENDA_COLORI              = 'Legenda colori';
  A000MSG_W004_ERR_TAB_NON_COMPATIBILE         = 'File pdf inesistente!';
  A000MSG_W004_FMT_STAMPA_NON_DISPONIB         = 'Stampa non disponibile: %s';

  A000MSG_W005_ERR_FORMATO_TIMB                = 'Il formato della timbratura è VHH.MM';
  A000MSG_W005_ERR_VERSO_TIMB                  = 'Il verso deve essere E o U';
  A000MSG_W005_ERR_FORMATO_ORA_TIMB            = 'Il formato dell''ora è HH.MM';
  A000MSG_W005_ERR_DELL_ORA                    = 'dell''ora';
  A000MSG_W005_ERR_FMT_STOP_DATA_ANTECEDENTE   = 'Non è possibile visualizzare il cartellino prima del %s!';
  A000MSG_W005_FMT_CAUSALE_INESISTENTE         = 'La causale %s è inesistente oppure non disponibile';
  A000MSG_W005_ERR_COD_MAX_2_CHARATTERI        = 'Il codice del rilevatore può essere al massimo di 2 caratteri';
  A000MSG_W005_MSG_FORMATO_TIMB                = 'Vhh.mm/causale(rilevatore); V = E/U; causale e rilevatore opzionali';
  A000MSG_W005_MSG_CANC_TIMBRATURE             = 'cancellare le timbrature';
  A000MSG_W005_MSG_CANC_TIMB_MANUALI           = 'cancellare le timbrature manuali';
  A000MSG_W005_MSG_CANC_TIMB_ORIGINALI         = 'cancellare le timbrature originali';
  A000MSG_W005_MSG_MODIF_TIMBRATURE            = 'modificare le timbrature';
  A000MSG_W005_MSG_MODIF_RILEVATORE            = 'modificare il rilevatore';
  A000MSG_W005_MSG_MODIF_CAUSALE               = 'modificare la causale';
  A000MSG_W005_MSG_USARE_CAUS_SELEZIONATA      = 'utilizzare la causale selezionata';
  A000MSG_W005_MSG_MANCANO_AUTORIZZAZIONI      = 'Mancano le autorizzazioni per';
  A000MSG_W005_MSG_INSERIMENTO_FALLITO         = 'Inserimento fallito';
  A000MSG_W005_MSG_ANOMALIA                    = 'Anomalia';
  A000MSG_W005_MSG_NUOVOGIUST                  = 'Nuovo giustificativo';
  A000MSG_W005_MSG_GIUSTIFICATIVI              = 'Giustificativi';

  A000MSG_W008_ERR_FMT_FRUIZ_PERIODO           = 'La causale %s non è stata fruita nel periodo indicato!';
  A000MSG_W008_MSG_ORAFINE_MAGG_ORAINIZIO      = 'L''ora finale deve essere successiva all''ora iniziale!';
  A000MSG_W008_ERR_NO_INS_CAUSALE              = 'Attenzione! Inserimento non consentito.'#13#10' %s';
  A000MSG_W008_ERR_NO_BLOCCO_RIEPILOHI         = 'Elenco anomalie - Sicurezza riepiloghi';
  A000MSG_W008_ERR_NO_CERTIFICAZIONE           = 'Attenzione:'#13#10'L''assenza può essere giustificata solo tramite certificazione rilasciata da struttura sanitaria pubblica.';
  A000MSG_W008_MSG_DETT_CALCOLO_COMPETENZE     = 'Dettaglio del calcolo competenze';
  A000MSG_W008_MSG_NO_GIUSTIF_INS              = 'Nessun giustificativo inserito!';
  A000MSG_W008_MSG_RAV_OGGETTO                 = 'OGGETTO: Richiesta';
  A000MSG_W008_MSG_RAV_NOMIN_F                 = 'La sottoscritta:';
  A000MSG_W008_MSG_RAV_NOMIN_M                 = 'Il sottoscritto:';
  A000MSG_W008_MSG_RAV_MATRICOLA               = 'matr.';
  A000MSG_W008_MSG_RAV_USUFRUIRE               = 'di usufruire di';
  A000MSG_W008_MSG_RAV_DA_A                    = 'da %s a %s';
  A000MSG_W008_MSG_RAV_IN_DATA                 = 'in data %s';
  A000MSG_W008_MSG_RAV_MEZZAGG_INDATA          = 'mezza giornata di %s in data %s';
  A000MSG_W008_MSG_RAV_MEZZA_GG                = 'per mezza giornata';
  A000MSG_W008_MSG_RAV_FIRMA_DIP               = 'Firma del dipendente';
  A000MSG_W008_MSG_RAV_FIRMA_RESP              = 'Il Responsabile';
  A000MSG_W008_MSG_RAV_DATA                    = 'Li %s';
  A000MSG_W008_MSG_RAV_CHIEDE                  = 'Chiede';

  A000MSG_W009_ERR_ANOMALIA_GENERICA           = 'Anomalia nella fase di %s'#13#10'%s';
  A000MSG_W009_FMT_CARTELLINI_VALIDATI         = 'I seguenti cartellini non sono stati caricati:%s%s';
  A000MSG_W009_FMT_RICHIESTA_AUTO              = 'E'' stata autorizzata automaticamente una richiesta scaduta:%s%s';
  A000MSG_W009_FMT_RICHIESTA_AUTO2             = 'Sono state autorizzate automaticamente %d richieste scadute:%s%s';
  A000MSG_W009_ERR_FMT_RICHIESTA_AUTO          = 'Attenzione!'#13#10'Si sono verificati errori durante l''autorizzazione'#13#10'delle richieste scadute:'#13#10'%s';
  A000MSG_W009_MSG_RICH_NON_DISPONIBILE        = 'La richiesta da visualizzare non è più disponibile!';
  A000MSG_W009_MSG_RICH_NON_DISPONIBILE2       = 'Attenzione! La richiesta da autorizzare non è più disponibile!';
  A000MSG_W009_FMT_IMP_AUTORIZ_FALLITE         = 'Impostazione dell''autorizzazione fallita!'#13#10'Motivo: %s';
  A000MSG_W009_ERR_RICH_NO_AUTORIZZATE         = 'Attenzione!'#13#10'Alcune richieste non sono state autorizzate'#13#10'a causa di errori di validazione dei cartellini.';
  A000MSG_W009_FMT_ANOMALIE_CARTEllINO         = 'Il cartellino di %s presenta una o più anomalie che non ne consentono la validazione:'#13#10#13#10'%s'#13#10'Validazione impossibile!';
  A000MSG_W009_FMT_RICH_WEB_PENDENTI           = 'Attenzione! Sono presenti richieste web pendenti relative al mese di %s:%s'#13#10#13#10'Procedere comunque con la validazione?';
  A000MSG_W009_MSG_AGG_NON_ABILITATO           = 'Aggiornamento non abilitato!';
  A000MSG_W009_FMT_STOP_CART_PRIMA_DEL         = 'Non è possibile elaborare il cartellino prima del %s!';
  A000MSG_W009_FMT_STOP_CART_PRIMA_MESI        = 'Non è possibile elaborare il cartellino antecedente di %d mesi!';
  A000MSG_W009_FMT_STOP_CART_SUCC_MESI         = 'Non è possibile elaborare il cartellino successivo a %d mesi!';
  A000MSG_W009_ERR_CAMPI_NON_VALIDI            = 'La parametrizzazione di stampa selezionata include campi di intestazione non validi';
  A000MSG_W009_ERR_FMT_STAMPA_CARTELLINO       = 'Errore durante la stampa del cartellino:'#13#10'%s';
  A000MSG_W009_FMT_ANOM_VALIDAZIONE            = 'Avviso: il cartellino di %s presenta le seguenti anomalie bloccanti:'#13#10'%s'#13#10#13#10'Premere OK per visualizzare l''anteprima.';
  A000MSG_W009_FMT_RICH_PENDENTI               = 'Avviso: sono presenti richieste web pendenti relative al mese di %s:%s'#13#10#13#10'Premere OK per visualizzare l''anteprima.';
  A000MSG_W009_FMT_FILE_PDF_FALLITO            = 'Produzione file pdf fallita: %s';
  A000MSG_W009_MSG_NO_CART_DISPONIBILI         = 'Nessun cartellino disponibile nel periodo specificato!';
  A000MSG_W009_FMT_TITOLO_ANTEPRIMA            = 'Anteprima stampa cartellino - %s';
  A000MSG_W009_FMT_CARTELLINO_DI_MESE          = 'Cartellino di %s';
  A000MSG_W009_CARTELLINO_PRONTO_VALIDAZIONE   = 'Cartellino pronto per la validazione';
  A000MSG_W009_FMT_CONFERMA_AGGIORNAMENTO      = 'Eseguire l''aggiornamento per i %d dipendenti selezionati?';
  A000MSG_W009_FMT_CONFERMA_STAMPA             = 'Eseguire la stampa per i %d dipendenti selezionati?';
  A000MSG_W009_ERR_NO_FILE_PDF                 = 'Generazione cartellino fallita!';
  A000MSG_W009_ERR_FMT_STAMPA_CARTELLINO_B028  = 'Errore durante la stampa del cartellino (B028):'#13#10'%s';

  A000MSG_W010_ERR_INS_GIUSTIF                 = 'Specificare il giustificativo!';
  A000MSG_W010_MSG_RICH_MODIFICATA             = 'Attenzione! La richiesta in fase di definizione è stata modificata nel frattempo.'#13#10'Verificarne nuovamente i dati prima di procedere!';
  A000MSG_W010_MSG_RICH_ANNULLATA              = 'La richiesta definitiva è stata annullata ed è tornata ad assumere lo stato di richiesta preventiva.'#13#10'Si ricorda di procedere con la definizione oppure la revoca di questa richiesta.';
  A000MSG_W010_MSG_INS_REVOC_ANNULLATO         = 'Inserimento richiesta revoca annullato:'#13#10'blocco riepiloghi attivo.';
  A000MSG_W010_FMT_C018_CONTINUA               = '%s'#13#10'Vuoi continuare?';
  A000MSG_W010_MSG_ANNULLA_OPERAZIONE          = 'E'' necessario completare oppure annullare'#13#10'l''operazione di definizione in corso prima di procedere!';
  A000MSG_W010_ERR_FMT_DATA_FINE               = 'Indicare una data valida per %s';
  A000MSG_W010_ERR_FMT_DATA_FINE_OPT1          = 'la fine del periodo!';
  A000MSG_W010_ERR_FMT_DATA_FINE_OPT2          = 'l''inserimento!';
  A000MSG_W010_MSG_DATA_FINE_MAGG_INIZIO       = 'La data di fine periodo non può essere precedente a quella iniziale!';
  A000MSG_W010_MSG_TIPO_FRUIZIONE              = 'Selezionare il tipo di fruizione del giustificativo!';
  A000MSG_W010_MSG_TIPO_FRUIZIONE2             = 'Il tipo di fruizione del giustificativo non è indicato!';
  A000MSG_W010_MSG_INS_RICH_ANNULLATO          = '%s'#13#10'blocco riepiloghi attivo.';
  A000MSG_W010_MSG_INS_RICH_ANNULLATO_OPT1     = 'Inserimento richiesta annullato:';
  A000MSG_W010_MSG_INS_RICH_ANNULLATO_OPT2     = 'Definizione richiesta annullata:';
  A000MSG_W010_FMT_INS_RICH_ANOMALIE           = 'Attenzione! Sono state rilevate le seguenti anomalie:'#13#10'%s';
  A000MSG_W010_MSG_INS_RICH_ANOMALIE_OPT1      = 'Inserimento richiesta non consentito.';
  A000MSG_W010_MSG_INS_RICH_ANOMALIE_OPT2      = 'Definizione richiesta non consentita.';
  A000MSG_W010_FMT_CONTROLLI_INS               = 'Si è verificato un errore durante i controlli per %s della richiesta.';
  A000MSG_W010_ERR_CONTROLLI_INS_OPT1          = 'l''inserimento';
  A000MSG_W010_ERR_CONTROLLI_INS_OPT2          = 'la definizione';
  A000MSG_W010_FMT_PERIODO_GIUST_ERRATO        = '%s'#13#10'periodo di inserimento non significativo per questo giustificativo.';
  A000MSG_W010_ERR_RICH_ESISTENTE              = 'Inserimento richiesta annullato:'#13#10'La richiesta indicata è già esistente!';
  A000MSG_W010_FMT_INS_FALLITO                 = 'Inserimento fallito: '#13#10'%s';
  A000MSG_W010_FMT_DEF_FALLITA                 = 'Definizione della richiesta fallita!'#13#10'Motivo: %s';
  A000MSG_W010_MSG_SELEZIONARE_RICH_RIEP       = 'Selezionare una richiesta per visualizzare il conteggio del riepilogo!';
  A000MSG_W010_MSG_ANTEPRIMA_STAMPA            = 'Anteprima stampa autorizzazione';
  A000MSG_W010_MSG_GG_INTERA                   = 'a giornata intera';
  A000MSG_W010_FMT_GG_MEZZA                    = 'mezza giornata%s';
  A000MSG_W010_FMT_NUM_ORE                     = 'numero ore (%s)';
  A000MSG_W010_FMT_DA_ORE_A_ORE                = 'dalle ore %s alle %s';
  A000MSG_W010_FMT_RICHIESTA_ASS               = 'Richiesta effettuata da %s (%s) il %s'#13#10'Periodo: %s - %s'#13#10'Tipo: %s'#13#10'Causale: %s';
  A000MSG_W010_FMT_IMPOST_AUT_FALLITA          = 'Impostazione dell''autorizzazione fallita!'#13#10'Motivo: %s'#13#10#13#10'%s';
  A000MSG_W010_MSG_AUTO_GIUST_ERR              = 'Autorizzazione giustificativi - Errore';
  A000MSG_W010_MSG_RICH_IGNORATE               = 'Alcune richieste non sono state considerate per l''autorizzazione'#13#10'in quanto modificate nel frattempo o non più disponibili.';
  A000MSG_W010_MSG_RICH_GIA_IMPORTATE          = 'Alcune richieste non sono state considerate'#13#10'perché sono state già importate in precedenza';
  A000MSG_W010_FMT_HINT_DESC_RICHIESTA         = ' del %s con causale %s riguardante il periodo dal %s al %s';
  A000MSG_W010_MSG_RIESEGUI_IMPORTAZIONE       = 'Attenzione!'#13#10'Non è stato possibile importare tutte le richieste presenti.'#13#10'Si prega di rieseguire l''importazione.';
  A000MSG_W010_MSG_CONSULTA_NOTIFICHE_ELAB     = 'Consultare le "Notifiche delle elaborazioni" per i dettagli e avvisare l''ufficio competente.';
  A000MSG_W010_MSG_FMT_RICH_INIZIOCATENA       = 'Non è possibile inserire una richiesta di giustificativo con causale %s.'#13#10'Utilizzare la causale %s';
  A000MSG_W010_MSG_RICH_NON_AUT                = 'Attenzione! La richiesta è stata modificata e non è più autorizzabile!';
  A000MSG_W010_ERR_MOTIVAZIONE_NON_INDICATA    = 'E'' necessario selezionare la motivazione della'#13#10'richiesta per la causale selezionata!';
  A000MSG_W010_MSG_CANC_PERIODO                = 'Richiesta cancellazione periodo';
  A000MSG_W010_MSG_RAV_FIRMA_RESP              = 'Il Responsabile U. Operativa / Ufficio';

  A000MSG_W015_MSG_SPECIFICARE_STAMPA          = 'Specificare la stampa da generare!';
  A000MSG_W015_ERR_DATE_NON_CORRETTE           = 'Date non corrette!';
  A000MSG_W015_MSG_PERIODO_MAGGIORE_2_ANNI     = 'Il periodo specificato non può essere superiore ai 2 anni!';
  A000MSG_W015_ERR_TAB_NON_COMPATIBILE         = 'file pdf inesistente!'#13#10'La stampa può essere vuota o la tabella di salvataggio non è compatibile.';
  A000MSG_W015_ERR_FMT_STOP_DATA_ANTECEDENTE   = 'Non è possibile eseguire la stampa prima del %s!';
  A000MSG_W015_FMT_STAMPA_NON_DISPONIB         = 'Stampa non disponibile: %s';

  A000MSG_W017_MSG_NO_CEDOLINO_DISP            = 'Nessun cedolino disponibile';
  A000MSG_W017_ERR_DATA_RETR_ERRATA            = 'Data di retribuzione errata!';
  A000MSG_W017_ERR_DATACEDOLINO_ERRATA         = 'Data cedolino errata!';
  A000MSG_W017_MSG_ANTEPRIMA_CEDOLINO          = 'Anteprima cedolino';
  A000MSG_W017_FMT_RICEZIONE_CEDOLINO          = 'Si conferma l''avvenuta ricezione del cedolino %s con data retribuzione %s?';
  A000MSG_W017_FMT_STOP_CED_PRIMA_DEL          = 'Non è possibile stampare il cedolino prima del %s!';
  A000MSG_W017_FMT_STOP_CED_PRIMA_MESI         = 'Non è possibile stampare il cedolino antecedente di %d mesi!';

  A000MSG_W018_MSG_RICH_IGNORATE               = 'Alcune richieste non sono state considerate per l''autorizzazione'#13#10'in quanto modificate nel frattempo o non più disponibili.';
  A000MSG_W018_MSG_RICH_GIA_IMPORTATE          = 'Alcune richieste non sono state considerate'#13#10'perché sono state già importate in precedenza';
  A000MSG_W018_MSG_RIESEGUI_IMPORTAZIONE       = 'Attenzione!'#13#10'Non è stato possibile confermare tutte le autorizzazioni presenti.'#13#10'Si prega di rieseguire l''operazione di conferma.';
  A000MSG_W018_MSG_CONSULTA_NOTIFICHE_ELAB     = 'Consultare le "Notifiche delle elaborazioni" per i dettagli e avvisare l''ufficio competente.';
  A000MSG_W018_FMT_INS_FALLITO                 = 'Inserimento fallito: '#13#10'%s';

  A000MSG_W019_MSG_NO_DELEGA                   = 'Nessuna delega';
  A000MSG_W019_FMT_RICHIESTA_FILTRO            = 'Prima di procedere con l''inserimento occorre filtrare la lista degli utenti web.'#13#10'Impostare gli eventuali parametri di ricerca e fare click sul pulsante "%s".';
  A000MSG_W019_FMT_LISTA_USR_VUOTA             = 'La lista degli utenti web è vuota! Provare a modificare i parametri'#13#10'di ricerca e quindi fare click sul pulsante "%s".';
  A000MSG_W019_MSG_SELEZIONARE_USR_DELEGA      = 'Selezionare l''utente cui si desidera delegare il proprio profilo!';
  A000MSG_W019_MSG_PROFILO_DA_ASSEGNARE        = 'Specificare il nome del profilo da assegnare al delegato!'#13#10'Nota: è possibile mantenere il nome del profilo originale.';
  A000MSG_W019_FMT_PROFILO_ASSEGNATO           = 'Il profilo risulta già assegnato all''utente "%s".'#13#10'Impossibile procedere!';
  A000MSG_W019_MSG_PERIODO_DELEGA              = 'Il periodo di delega non può iniziare prima della data odierna!';
  A000MSG_W019_FMT_VALIDITA_PROFILO            = 'Il proprio profilo non può essere delegato per il periodo specificato,'#13#10'in quanto ha validità dal %s al %s.';
  A000MSG_W019_FMT_PROFILO_GIA_DELEGATO        = 'Il profilo risulta già delegato all''utente "%s" dal %s al %s';
  A000MSG_W019_FMT_DELEGA_SOVRASCITTA          = '.'#13#10'Proseguendo, la delega esistente verrà sovrascritta e il termine di validità sarà %s al %s.'#13#10'Vuoi continuare?';
  A000MSG_W019_MSG_POSTICIPATO                 = 'posticipato';
  A000MSG_W019_MSG_ANTICIPATO                  = 'anticipato';
  A000MSG_W019_MSG_PERIODO_MODIFICA            = 'Conferma modifica periodo';
  A000MSG_W019_FMT_NO_POSTICIPARE              = '.'#13#10'Impossibile posticipare l''inizio di questo periodo al %s, poiché'#13#10'la delega è attualmente in corso di validità!';
  A000MSG_W019_FMT_SOVRASCRIVI_DELEGA          = '.'#13#10'Proseguendo, la delega esistente verrà sovrascritta e l''inizio di validità sarà %s al %s.'#13#10'Vuoi continuare?';
  A000MSG_W019_MSG_SOVRASCRIVI_DELEGA2         = '.'#13#10'Proseguendo, la delega esistente verrà sovrascritta ed il periodo di validità sarà modificato.'#13#10'Vuoi continuare?';
  A000MSG_W019_FMT_DELEGATO_N_VOLTE            = 'Il profilo risulta già delegato all''utente "%s"'#13#10'per n. %s volte nel periodo dal %s al %s.'#13#10'Considerare la possibilità cancellare manualmente'#13#10'questi periodi prima di inserirne uno solo.';
  A000MSG_W019_FMT_ACCESSO_EFFETTUATO          = 'Impossibile modificare la data di inizio validità!'#13#10'L''utente delegato ha già effettuato accessi con tale profilo.'#13#10'Ultimo accesso effettuato: %s';
  A000MSG_W019_FMT_ACCESSO_EFFETTUATO2         = 'L''utente delegato ha già effettuato accessi con questo profilo.'#13#10'La data di fine validità non può essere precedente alla data '#13#10'di ultimo accesso effettuato: %s';
  A000MSG_W019_FMT_INS_FALLITO                 = 'Inserimento delega fallito: %s';
  A000MSG_W019_FMT_VARIAZIONE_FALLITA          = 'Variazione della delega fallita!'#13#10'Motivo: %s';
  A000MSG_W019_MSG_FMT_RICERCA                 = 'Non è stato impostato nessun parametro di ricerca per filtrare la lista degli utenti web.'#13#10'Vuoi continuare?';
  A000MSG_W019_MSG_NO_UTENTE_WEB               = 'Nessun utente web trovato!';
  A000MSG_W019_FMT_CANCELLARE                  = 'Impossibile cancellare la delega selezionata in quanto'#13#10'l''utente delegato ha già effettuato accessi con tale profilo.'#13#10'Ultimo accesso effettuato: %s';
  A000MSG_W019_FMT_PROFILO_VALIDO_DALAL        = 'Profilo attualmente valido dal <b>%s</b> al <b>%s</b>';
  A000MSG_W019_MASCHERA_PROFILO                = 'Maschera profilo';

  A000MSG_W032_FMT_NOTE_RIMBORSO_AUTOMATICO    = 'Rimborso chilometrico percorso %s ';
  A000MSG_W032_MSG_NO_TAPPE                    = 'Nessuna tappa definita';
  A000MSG_W032_ERR_FMT_QUERY_VALORE            = 'Impossibile determinare i valori del dato %s:'#13#10'l''interrogazione di servizio "%s" contiene errori!';

  A000MSG_W033_MSG_LEGENDA_ASS                 = 'Legenda assenze';
  A000MSG_W033_MSG_LBL_PARAMETRI               = 'Parametri';
  A000MSG_W033_MSG_LBL_PROSPETTO               = 'Prospetto';
  A000MSG_W033_MSG_LBL_TAB_TURNI               = 'Tabellone Turni';
  A000MSG_W033_MSG_LGNPERIODOELAB              = 'Periodo da elaborare';
  A000MSG_W033_MSG_PERIODO_MINORE_DI_12        = 'Il periodo non può essere superiore ai 12 mesi!';
  A000MSG_W033_ERR_JS_JQGRID_NON_SUPP          = 'Il browser in uso e'' obsoleto e non supporta questa funzionalita''. Utilizzare un browser piu'' recente per accedere al prospetto assenze.';
  A000MSG_W033_MSG_NESSUN_DATO                 = 'Nessun dato da visualizzare.';
  A000MSG_W033_ERR_DATASET_NON_DEFINITO        = 'Errore interno: struttura del dataset non definita!';
  A000MSG_W033_MSG_LBL_NOMINATIVO              = 'Nominativo';
  A000MSG_W033_MSG_LBL_CAPTION_GRID            = 'Prospetto assenze';
  A000MSG_W033_ERR_ERRORE_PROSPETTO            = 'Errore durante il recupero dei dati del prospetto';

  A000MSG_W034_MSG_TIPOLOGIA_DOC               = 'Tipologia documento';

  A000MSG_W035_MSG_FMT_DESTINATARI_SEL         = '(%d selezionati, %d non ricevuti)';
  A000MSG_W035_MSG_DESTINATARI_1               = '1 destinatario';
  A000MSG_W035_MSG_FMT_DESTINATARI             = '%d destinatari';
  A000MSG_W035_MSG_DALEGGERE                   = 'Da leggere';
  A000MSG_W035_MSG_FMT_LETTOPARZIALMENTE       = 'Letto da %d destinatari';
  A000MSG_W035_MSG_LETTOPARZIALMENTE_1         = 'Letto da 1 destinatario';
  A000MSG_W035_MSG_LETTO                       = 'Letto';
  A000MSG_W035_MSG_DARICEVERE                  = 'Da ricevere';
  A000MSG_W035_MSG_FMT_RICEVUTOPARZIALMENTE    = 'Ricevuto da %d destinatari';
  A000MSG_W035_MSG_RICEVUTOPARZIALMENTE_1      = 'Ricevuto da 1 destinatario';
  A000MSG_W035_MSG_RICEVUTO                    = 'Ricevuto';
  A000MSG_W035_MSG_FMT_MESSAGGI_RICEVUTI       = 'Messaggi ricevuti%s';
  A000MSG_W035_MSG_MESSAGGI_INVIATI            = 'Messaggi inviati';
  A000MSG_W035_MSG_CTRL_OGGETTO                = 'E'' necessario indicare l''oggetto del messaggio!';
  A000MSG_W035_MSG_CTRL_TESTO                  = 'E'' necessario indicare il testo del messaggio per la risposta!';
  A000MSG_W035_MSG_CTRL_DESTINATARI            = 'E'' necessario indicare almeno un destinatario!';
  A000MSG_W035_ERR_SALVA                       = 'Impossibile salvare il messaggio: %s';
  A000MSG_W035_ERR_INVIO                       = 'Impossibile inviare il messaggio: %s';
  A000MSG_W035_MSG_ELIMINATO_HEAD              = 'Messaggio cancellato';
  A000MSG_W035_MSG_ELIMINATO                   = 'Il messaggio è stato eliminato';
  A000MSG_W035_MSG_SEGNA_CANC                  = 'Il messaggio è stato contrassegnato come cancellato';
  A000MSG_W035_MSG_ALLEG_ELIMINATI_HEAD        = 'Allegati eliminati';
  A000MSG_W035_MSG_ALLEG_ELIMINATI             = 'Gli allegati sono stati eliminati definitivamente';
  A000MSG_W035_MSG_FMT_TESTO_ALLEG_ELIMINATI   = '[Allegati rimossi dall''utente %s in data %s]';
  A000MSG_W035_ERR_FMT_GET_INIZIO_CATENA       = 'Errore durante la ricerca del messaggio iniziale: %s';
  A000MSG_W035_ERR_FMT_SALVA_RICEVENTE         = 'Errore durante il salvataggio del ricevente:'#13#10'%s';
  A000MSG_W035_MSG_FMT_INFO_DIM_ALLEGATO       = 'Dimensione massima del singolo allegato: %d MB.';
  A000MSG_W035_MSG_FMT_INFO_MAX_ALLEGATI       = 'Numero massimo di allegati: %d';
  A000MSG_W035_MSG_MAX_ALLEGATI_RAGGIUNTO      = 'Non è consentito inserire altri allegati.';
  A000MSG_W035_MSG_QUOTA_ALLEGATI_SUPERATA     = 'La dimensione degli allegati contenuti nel messaggio supera la quota disponibile!';
  A000MSG_W035_MSG_LBL_QUOTA_USATA             = 'Spazio utilizzato';

  A000MSG_W037_MSG_CONFERMA_CANC               = 'Eliminare la richiesta selezionata?';
  A000MSG_W037_MSG_RICH_NON_DISPONIBILE        = 'La richiesta da cancellare non è più disponibile!';
  A000MSG_W037_MSG_RICH_NON_DISPONIBILE4       = 'La richiesta da visualizzare non è più disponibile!';
  A000MSG_W037_FMT_C018_CONTINUA               = '%s'#13#10'Vuoi continuare?';
  A000MSG_W037_FMT_INS_FALLITO                 = 'Inserimento fallito:'#13#10'%s';
  A000MSG_W037_ERR_FMT_INS_RICH_ANNULLATO      = 'Inserimento richiesta annullato:'#13#10'blocco riepiloghi attivo.';
  A000MSG_W037_ERR_MINIMO_NON_INDICATO         = 'Indicare il contingente minimo richiesto!';
  A000MSG_W037_ERR_MINIMO_ERRATO               = 'Il contingente minimo indicato è errato!';
  A000MSG_W037_ERR_MINIMO_ZERO                 = 'Il contingente minimo non può essere minore di 0!';
  A000MSG_W037_ERR_MINIMO_DIP_SERV             = 'Il contingente minimo non può essere superiore al totale dei dipendenti in servizio!';
  A000MSG_W037_ERR_FMT_ACCESSO                 = 'L''accesso alla funzione "%s" è consentito solo effettuando il login con un profilo di tipo responsabile';
  A000MSG_W037_MSG_NO_DIPENDENTI               = 'Nessun dipendente';
  A000MSG_W037_MSG_SELEZIONARE_EVENTO          = 'Selezionare l''evento di sciopero per cui effettuare la richiesta!';
  A000MSG_W037_ERR_FMT_1_DIPENDENTE_MIN        = 'E'' necessario avere almeno %d dipendente in servizio!'#13#10;
  A000MSG_W037_ERR_FMT_N_DIPENDENTI_MIN        = 'E'' necessario avere almeno %d dipendenti in servizio!'#13#10;
  A000MSG_W037_ERR_FMT_1_DIP_MANCANTE          = 'Attualmente manca %d unità al contingente minimo richiesto.';
  A000MSG_W037_ERR_FMT_N_DIP_MANCANTI          = 'Attualmente mancano %d unità al contingente minimo richiesto.';

  A000MSG_W039_ERR_CANC_DOC_WEB                = 'Impossibile cancellare un documento caricato dall''applicativo web!';
  A000MSG_W039_ERR_SELEZIONARE_DOC             = 'E'' necessario selezionare il documento da caricare!';
  A000MSG_W039_MSG_FMT_INFO_DIM_DOCUMENTO      = 'La dimensione massima del documento è di %d MB.';
  A000MSG_W039_ERR_ERRORE_UPLOAD_TMP           = 'Si è verificato un errore durante l''upload del documento (formato nome del file temporaneo non valido).';

  A000MSG_W040_ERR_FMT_BASE_DIR                = 'La directory base dei file è inesistente oppure non accessibile:'#13#10'%s';
  A000MSG_W040_ERR_SEL_DESTINAZIONE            = 'Selezionare la cartella di destinazione per il file!';
  A000MSG_W040_ERR_LIV_DESTINAZIONE            = 'Non è possibile effettuare l''upload in questa posizione.'#13#10'Selezionare una cartella di livello diverso.';
  A000MSG_W040_MSG_FMT_UPLOAD_OK               = 'Il file %s è stato caricato nella cartella selezionata.';
  A000MSG_W040_ERR_FMT_DOC_UPLOAD              = 'Errore durante l''upload del documento:'#13#10'%s';
  A000MSG_W040_ERR_FMT_CONFERMA_UPLOAD         = 'Il file da caricare è formalmente corretto e pronto per l''upload.<br/>File selezionato: <b>%s</b><br/>Si prega di controllare la struttura dei dati: %s<br/>%s<br/>Vuoi continuare?';
  A000MSG_W040_ERR_FMT_LIV_FORMATO_FILE        = 'Non è possibile effettuare l''upload di questo file,<br>in quanto il formato del nome non è corretto.<br/>File selezionato: <b>%s</b><br/>Dettaglio errore:<br/>%s<br/>%s';
  A000MSG_W040_MSG_FILE_SOVRASCRITTO           = '<span class="fontRed"><span class="font_grassetto">Importante:</span> il file indicato è già presente nella cartella selezionata e sarà sovrascritto.</span>';
  A000MSG_W040_ERR_SELEZIONARE_FILE            = 'Selezionare il file da caricare!';
  A000MSG_W040_ERR_UPLOAD_FAIL                 = 'Si è verificato un errore durante l''upload del file. Riprovare.';
  A000MSG_W040_ERR_LIV_FILE_ERRATO             = 'La configurazione di questa tipologia di documento'#13#10'non consente di visualizzare file'#13#10'in cartelle a questo livello!';

  A000MSG_W042_MSG_DETRAZIONI_IRPEF_OGGI       = 'Il coniuge è già stato previsto a carico fiscalmente: non sono richiesti dati aggiuntivi.';
  A000MSG_W042_MSG_DETRAZIONI_IRPEF_STORIA     = 'In passato, il coniuge è stato previsto a carico fiscalmente.';
  A000MSG_W042_MSG_FMT_NUCLEO_ANF_STORIA       = '%s coniuge %s componente del nucleo familiare.';
  A000MSG_W042_MSG_CONIUGE_DIPENDENTE          = 'Il coniuge lavora presso la stessa azienda: si possono modificare soltanto i dati relativi a inizio e fine matrimonio.';
  A000MSG_W042_MSG_GIUSTIFICATIVI_DATANAS      = 'Sono già stati fruiti dei giustificativi per il coniuge.';
  A000MSG_W042_MSG_CONTATTARE_UFFICIO          = 'Contattare l''ufficio competente se si devono apportare variazioni a dati non modificabili.';
  A000MSG_W042_ERR_PERIODI_INTERSECANTI        = 'Correggere le date del matrimonio in quanto intersecano quelle di un altro coniuge!';
  A000MSG_W042_MSG_CONFERMARE_DATI             = 'Confermare i dati del coniuge.';
  A000MSG_W042_MSG_EFFETTUARE_SOLO_VARIAZIONI  = 'I dati sono già stati validati: intervenire solo in caso di variazioni.';
  A000MSG_W042_ERR_FMT_CAMPO_OBBLIGATORIO      = 'Il campo "%s" è obbligatorio!';
  A000MSG_W042_ERR_FMT_ESCLUSIONE              = 'I campi "%s" e "%s" devono essere entrambi compilati o entrambi svuotati!';
  A000MSG_W042_ERR_FMT_CAMPO_ERRATO            = 'Correggere il campo "%s"!';
  A000MSG_W042_ERR_FMT_DATE_PASSATE            = 'Nessuna data può essere futura o uguale ad oggi!';
  A000MSG_W042_ERR_FMT_DATE_ORDINATE           = 'La %s deve essere successiva alla %s!';
  A000MSG_W042_ERR_FMT_CODFISCALE              = 'Il codice fiscale digitato (%s) è diverso da quello calcolato (%s) in base ai dati anagrafici dichiarati!';
  A000MSG_W042_ERR_CODFISCALE_DIP              = 'Inserire il codice fiscale del coniuge, non il proprio!';
  A000MSG_W042_ERR_FMT_CODFISCALE_DOPPIO       = 'Il codice fiscale risulta associato ad un altro familiare, di tipo "%s"!';
  A000MSG_W042_ERR_ANOMALIE                    = 'Correggere le anomalie segnalate!';
  A000MSG_W042_MSG_REGISTRAZIONE_OK            = 'Registrazione effettuata!';
  A000MSG_W042_MSG_REGISTRAZIONE_KO            = 'Registrazione fallita!';
  A000MSG_W042_MSG_CANCELLAZIONE_OK            = 'Cancellazione effettuata!';
  A000MSG_W042_MSG_CANCELLAZIONE_KO            = 'Cancellazione fallita!';
  A000MSG_W042_MSG_FMT_NOTIFICA_CU_2016        = 'Da quest''anno, ai fini della compilazione della Certificazione Unica 2016, è richiesta l’indicazione del codice fiscale del coniuge, anche se non a carico.'#13#10 +
                                                 'Se coniugati, siete invitati ad inserire tempestivamente le informazioni relative al marito/moglie accedendo alla pagina %s';
  A000MSG_W042_MSG_FMT_NOTIFICA_CU_2016_MULTI  = 'Da quest''anno, ai fini della compilazione della Certificazione Unica 2016, è richiesta l’indicazione del codice fiscale del coniuge, anche se non a carico.'#13#10 +
                                                 'Se coniugati, siete invitati ad inserire tempestivamente le informazioni relative al marito/moglie accedendo alla pagina %s per ogni matricola disponibile.';

  A000MSG_W043_ERR_FMT_FILTRO2_NOFILTRO1       = '&Egrave; stato specificato il dato aziendale "Reperibilità: Filtro 2" ' +
                                                 'senza specificare il parametro "Reperibilità: Filtro 1".<br>' + #13#10 +
                                                 'Per accedere alla funzione "%s" è necessario correggere questa impostazione.';

  A000MSG_W043_ERR_FMT_FILTRI_UGUALI           = 'Il dato aziendale "Reperibilità: Filtro 1" ' +
                                                 'è uguale al dato "Reperibilità: Filtro 2".' + #13#10 +
                                                 'Per accedere alla funzione "%s" è necessario correggere questa impostazione.';

  { TODO : modifica per nome parametro }
  A000MSG_W043_ERR_FTM_NUMGIORNI_NON_VALIDO    = 'Il parametro aziendale "Reperibilità: num. giorni modificabili in Modifica pers. reper." non è valido (vuoto o non è numero >= 0).' + #13#10 +
                                                 'Per accedere alla funzione "%s" è necessario correggere questa impostazione.';

  A000MSG_W044_ERR_FMT_NO_PARAM_REGOLE_BUONI   = 'Il parametro aziendale "Buoni pasto/Ticket" non è definito.'#13#10 +
                                                 'Per accedere alla funzione "%s" è necessario correggere questa impostazione.';
  A000MSG_W044_ERR_FMT_NO_DATO_REGOLA          = 'Per il dipendente selezionato non è definita la regola relativa ai ticket in data %s.'#13#10 +
                                                 'Verificare il dato anagrafico %s';
  A000MSG_W044_ERR_FMT_NO_REGOLA               = 'La regola relativa ai ticket assegnata al dipendente non è stata trovata nel database.'#13#10 +
                                                 'Verificare le regola ticket associata al %s %s';
  A000MSG_W044_ERR_FMT_NO_DATOLIBERO           = 'Per il dipendente selezionato non è definito il dato di abilitazione dei ticket online in data %s.'#13#10 +
                                                 'Verificare il dato anagrafico %s';
  A000MSG_W044_ERR_FMT_PERIODO_INS_INVALIDO    = 'Il periodo di validità per l''inserimento degli acquisti non è valido: [%d - %d]';
  A000MSG_W044_ERR_FMT_DATO_LIBERO_VALORE_VUOTO= 'Non è stato indicato il valore del dato %s per il confronto';
  A000MSG_W044_ERR_ABILITAZIONE_TICKET_UTENTE  = 'Non si dispone dell''abilitazione alla funzione di acquisto ticket online!';
  A000MSG_W044_ERR_ABILITAZIONE_TICKET_ALTRO   = 'Il dipendente selezionato non è abilitato alla funzione dei ticket online!';
  A000MSG_W044_ERR_FMT_FUORI_PERIODO_INS       = 'Il periodo consentito per la prenotazione / variazione dei %s è scaduto.';
  A000MSG_W044_MSG_FMT_NOTE                    = 'Richiesta on-line del %s';
  A000MSG_W044_ERR_FMT_NUM_TICKET_OBBL         = 'È obbligatorio indicare il numero di %s richiesti!';
  A000MSG_W044_ERR_FMT_NUM_TICKET_GE0          = 'Il numero di %s richiesto non può essere negativo!';
  A000MSG_W044_ERR_FMT_NUM_TICKET_LTSOGLIA     = 'È possibile richiedere un massimo di %d %s mensili!';
  A000MSG_W044_ERR_FMT_NUM_TICKET_TOT_LTSOGLIA = 'La somma dei ticket richiesti nel mese di %s supera la disponibilità di %d %s mensili!';

  A000MSG_W046_ERR_FMT_ERRORE_CONTEGGI         = 'Riscontrati problemi in fase di recupero dati!' + #13#10 + '%s';
  A000MSG_W046_MSG_NO_DATI_DISP                = 'Dati non disponibili. ';
  A000MSG_W046_MSG_NO_DATI_MOD                 = 'Dati non modificabili. ';
  A000MSG_W046_MSG_NO_PERIODO                  = 'Data odierna esterna al periodo di intervento. ';
  A000MSG_W046_MSG_SALDO_POSITIVO              = 'Saldo annuale positivo. ';
  A000MSG_W046_MSG_ORE_RECUPERO_NEGATIVE       = 'Ore a recupero disponibili annuali negative. ';
  A000MSG_W046_MSG_SUPERO_COMP_MAX             = 'Compensazione effettuata maggiore di quella massima. ';
  A000MSG_W046_ERR_ORE_COMP                    = 'E'' stato indicato un numero di ore non valido!';
  A000MSG_W046_ERR_ORE_COMP_OLD                = 'Indicare un numero di ore diverso da quello precedentemente indicato per la compensazione!';
  A000MSG_W046_ERR_ORE_COMP_NEG                = 'E'' stato indicato un numero di ore negativo!';
  A000MSG_W046_ERR_ORE_COMP_OLTRE_MAX          = 'E'' stato indicato un numero di ore superiore alla compensazione massima effettuabile!';

  A000MSG_W047_ERR_FMT_NO_PARAM_ORDSAN_CODICE  = 'Il parametro aziendale "Individua Ordine Sanitario" non è definito.'#13#10 +
                                                 'Per accedere alla funzione "%s" è necessario correggere questa impostazione.';
  A000MSG_W047_ERR_FMT_NO_DATO_REGOLA          = 'Non è prevista l''iscrizione all''ordine professionale per la qualifica ricoperta,'#13#10 +
                                                 'per eventuali chiarimenti rivolgersi all''ufficio del personale.';
  A000MSG_W047_MSG_FMT_NOTE                    = 'Caricamento on-line del %s';
  A000MSG_W047_MSG_FMT_PK                      = 'Per l''ordine professionale %s risulta già esistente un''iscrizione attiva!';

  A000MSG_WC026_MSG_RICHIESTA                  = 'Richiesta';
  A000MSG_WC026_MSG_NESSUN_ALLEGATO            = 'Nessun allegato';
  A000MSG_WC026_MSG_FMT_ALLEGATI_ITER          = 'Allegati richiesta - Iter %s (%s)';
  A000MSG_WC026_MSG_FMT_INFO_ALLEGATI_1        = 'E'' possibile allegare alla richiesta 1 singolo file.'#13#10'La dimensione massima è di %d MB.';
  A000MSG_WC026_MSG_FMT_INFO_ALLEGATI_N        = 'E'' possibile allegare alla richiesta un massimo di %d file.'#13#10'La dimensione massima del singolo allegato è di %d MB.';
  A000MSG_WC026_ERR_FMT_MAX_ALLEGATI           = 'E'' possibile allegare alla richiesta'#13#10'un massimo di %d file!';
  A000MSG_WC026_MSG_FMT_INFO_ABIL_ALLEGATI     = '(*) La modifica degli allegati non è consentita: %s';
  A000MSG_WC026_MSG_CONFERMA_ALLEG_ORIGINALI   = 'Il sottoscritto ai sensi dell''art. 76 del D.P.R. n. 445/2000 dichiara sotto la propria<br>responsabilit&agrave; che gli allegati forniti sono conformi agli originali';


  A000MSG_R013_MSG_TIPORICH_PREVENTIVA         = 'Preventiva';
  A000MSG_R013_MSG_TIPORICH_DEFINITIVA         = 'Definitiva';
  A000MSG_R013_MSG_TIPORICH_REVOCA             = 'Revoca';
  A000MSG_R013_MSG_TIPORICH_CANCELLAZIONE      = 'Cancellazione';
  A000MSG_R013_MSG_CONFERMA_CANC               = 'Eliminare la richiesta selezionata?';
  A000MSG_R013_MSG_CONFERMA_REVOCA             = 'Revocare la richiesta selezionata?';
  A000MSG_R013_MSG_RICHIESTA_DEFINITIVA        = 'Rendere la richiesta definitiva?';
  A000MSG_R013_MSG_HINT_CANC                   = 'Elimina la richiesta';
  A000MSG_R013_MSG_HINT_REVOCA                 = 'Revoca la richiesta';
  A000MSG_R013_MSG_HINT_DEFINITIVA             = 'Rende definitiva la richiesta';
  A000MSG_R013_MSG_HINT_CANCPARZ               = 'Cancella parzialmente la richiesta';
  A000MSG_R013_MSG_HINT_ANNULLA                = 'Annulla la definizione della richiesta';
  A000MSG_R013_MSG_RICH_NON_DISPONIBILE        = 'La richiesta da cancellare non è più disponibile!';
  A000MSG_R013_MSG_RICH_NON_DISPONIBILE2       = 'La richiesta da revocare non è più disponibile!';
  A000MSG_R013_MSG_RICH_NON_DISPONIBILE3       = 'Attenzione! La richiesta da definire non è più disponibile!';
  A000MSG_R013_MSG_RICH_NON_DISPONIBILE4       = 'La richiesta selezionata non è più disponibile!';
  A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE  = 'Nessuna autorizzazione da confermare.';

  A000MSG_R013_MSG_RICHIESTA_SALVA_INS         = 'Attenzione! La richiesta in fase di inserimento non è stata confermata.';
  A000MSG_R013_MSG_RICHIESTA_SALVA_MOD         = 'Attenzione! Sono presenti modifiche in corso non salvate che verranno perse.';
  A000MSG_R013_ERR_FMT_MOD_FALLITA             = 'Modifica della richiesta fallita:'#13#10'%s';
  A000MSG_R013_ERR_FMT_CHIUSURA_FALLITA        = 'Chiusura della richiesta fallita:'#13#10'%s';
  A000MSG_R013_MSG_USCIRE_COMUNQUE             = 'Uscire comunque dalla funzione?';
  A000MSG_R013_MSG_RICHIESTA_ND_AUT            = 'Attenzione! La richiesta da autorizzare non è più disponibile!';
  A000MSG_R013_MSG_RICHIESTA_MODIFICATA_AUT    = 'Attenzione! La richiesta da autorizzare è stata modificata nel frattempo.'#13#10'Verificarne nuovamente i dati prima di procedere!';
  A000MSG_R013_ERR_FMT_AUT_FALLITA             = 'Impostazione dell''autorizzazione fallita!'#13#10'Errore: %s#13#10Tipo: %s';
  A000MSG_R013_ERR_COMPLETA_OPERAZIONE         = 'E'' necessario completare oppure annullare'#13#10'l''operazione in corso prima di procedere!';
  A000MSG_R013_ERR_FMT_COMPLETA_OPERAZIONE     = 'E'' necessario completare oppure annullare l''operazione di %s in corso prima di procedere!';
  A000MSG_R013_MSG_RICHIESTA_ND_MOD            = 'Attenzione! La richiesta da modificare non è più disponibile!';
  A000MSG_R013_MSG_RICHIESTA_ND                = 'Attenzione! La richiesta non è più disponibile:'#13#10'potrebbe essere stata eliminata nel frattempo.';
  A000MSG_R013_MSG_RICHIESTA_CANC_FALLITA      = 'Cancellazione della richiesta fallita!'#13#10'Errore: %s#13#10Tipo: %s';

implementation

end.