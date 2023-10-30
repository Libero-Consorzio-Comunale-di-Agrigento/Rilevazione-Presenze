inherited WS740FRegoleValutazioniDM: TWS740FRegoleValutazioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG741.*, SG741.ROWID'
      'FROM SG741_REGOLE_VALUTAZIONI SG741'
      ':ORDERBY'
      '--ORDER BY CODICE, DECORRENZA')
    AfterOpen = selTabellaAfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaFILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Visible = False
      Size = 4000
    end
    object selTabellaCOD_TIPI_RAPPORTO: TStringField
      DisplayLabel = 'Tipi rapporto valutabili'
      FieldName = 'COD_TIPI_RAPPORTO'
      Visible = False
      Size = 400
    end
    object selTabellaGIORNI_MINIMI: TIntegerField
      DisplayLabel = 'Giorni minimi'
      FieldName = 'GIORNI_MINIMI'
      Visible = False
    end
    object selTabellaVALUTA_CESSATI_RUOLO: TStringField
      DisplayLabel = 'Ignora gg min cessati ruolo'
      FieldName = 'VALUTA_CESSATI_RUOLO'
      Visible = False
      Size = 1
    end
    object selTabellaAGGIORNA_DATA_COMPILAZIONE: TStringField
      DisplayLabel = 'Agg. data compil.'
      FieldName = 'AGGIORNA_DATA_COMPILAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaINVIO_EMAIL: TStringField
      DisplayLabel = 'Invio email valutato'
      FieldName = 'INVIO_EMAIL'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrotondamento Punt. scheda'
      FieldName = 'TIPO_ARROTONDAMENTO'
      Visible = False
      Size = 1
    end
    object selTabellaPAGINE_ABILITATE: TStringField
      DisplayLabel = 'Pagine abilitate'
      DisplayWidth = 50
      FieldName = 'PAGINE_ABILITATE'
      Visible = False
      Size = 50
    end
    object selTabellaCAMPI_OPZIONALI_COMPILAZIONE: TStringField
      DisplayLabel = 'Col. opzionali compilazione'
      FieldName = 'CAMPI_OPZIONALI_COMPILAZIONE'
      Visible = False
      Size = 15
    end
    object selTabellaPATH_ISTRUZIONI: TStringField
      DisplayLabel = 'Path file istruzioni'
      FieldName = 'PATH_ISTRUZIONI'
      Visible = False
      Size = 1000
    end
    object selTabellaPATH_INFORMAZIONI: TStringField
      DisplayLabel = 'Path file informazioni'
      FieldName = 'PATH_INFORMAZIONI'
      Visible = False
      Size = 1000
    end
    object selTabellaDATO_STAMPA_1: TStringField
      DisplayLabel = 'Dato stampa 1'
      FieldName = 'DATO_STAMPA_1'
      Visible = False
      Size = 30
    end
    object selTabellaDESC_LUNGA_1: TStringField
      DisplayLabel = 'Descr. lunga 1'
      FieldName = 'DESC_LUNGA_1'
      Visible = False
      Size = 1
    end
    object selTabellaDATO_STAMPA_2: TStringField
      DisplayLabel = 'Dato stampa 2'
      FieldName = 'DATO_STAMPA_2'
      Visible = False
      Size = 30
    end
    object selTabellaDATO_STAMPA_3: TStringField
      DisplayLabel = 'Dato stampa 3'
      FieldName = 'DATO_STAMPA_3'
      Visible = False
      Size = 30
    end
    object selTabellaDESC_LUNGA_3: TStringField
      DisplayLabel = 'Descr. lunga 3'
      FieldName = 'DESC_LUNGA_3'
      Visible = False
      Size = 1
    end
    object selTabellaDATO_STAMPA_4: TStringField
      DisplayLabel = 'Dato stampa 4'
      FieldName = 'DATO_STAMPA_4'
      Visible = False
      Size = 30
    end
    object selTabellaDATO_STAMPA_5: TStringField
      DisplayLabel = 'Dato stampa 5'
      FieldName = 'DATO_STAMPA_5'
      Visible = False
      Size = 30
    end
    object selTabellaDESC_LUNGA_5: TStringField
      DisplayLabel = 'Descr. lunga 5'
      FieldName = 'DESC_LUNGA_5'
      Visible = False
      Size = 1
    end
    object selTabellaSTAMPA_VARIAZIONI_5: TStringField
      DisplayLabel = 'Stampa variaz. 5'
      FieldName = 'STAMPA_VARIAZIONI_5'
      Visible = False
      Size = 1
    end
    object selTabellaDATO_STAMPA_6: TStringField
      DisplayLabel = 'Dato stampa 6'
      FieldName = 'DATO_STAMPA_6'
      Visible = False
      Size = 30
    end
    object selTabellaDATO_VARIAZIONE_VALUTATORE: TStringField
      DisplayLabel = 'Campo firma 2'#176' valut.'
      FieldName = 'DATO_VARIAZIONE_VALUTATORE'
      Visible = False
      Size = 30
    end
    object selTabellaLOGO_LARGHEZZA: TIntegerField
      DisplayLabel = 'Larghezza logo'
      FieldName = 'LOGO_LARGHEZZA'
      Visible = False
    end
    object selTabellaLOGO_ALTEZZA: TIntegerField
      DisplayLabel = 'Altezza logo'
      FieldName = 'LOGO_ALTEZZA'
      Visible = False
    end
    object selTabellaCAMPI_OPZIONALI_STAMPA: TStringField
      DisplayLabel = 'Col. opzionali stampa'
      FieldName = 'CAMPI_OPZIONALI_STAMPA'
      Visible = False
      Size = 15
    end
    object selTabellaSTAMPA_PERIODO_VALUTAZIONE: TStringField
      DisplayLabel = 'Stampa periodo valutazione'
      FieldName = 'STAMPA_PERIODO_VALUTAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaTESTO_AVVISO_PRESA_VISIONE: TStringField
      DisplayLabel = 'Testo avviso per p.v.'
      FieldName = 'TESTO_AVVISO_PRESA_VISIONE'
      Visible = False
      Size = 500
    end
    object selTabellaCODTIPOQUOTA_STAMPA: TStringField
      DisplayLabel = 'Quota stampa scaglioni inc.'
      FieldName = 'CODTIPOQUOTA_STAMPA'
      Visible = False
      Size = 5
    end
    object selTabellaD_TIPOQUOTA_STAMPA: TStringField
      DisplayLabel = 'Desc. quota stampa scaglioni inc.'
      FieldKind = fkCalculated
      FieldName = 'D_TIPOQUOTA_STAMPA'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_PARPROTOCOLLO: TStringField
      DisplayLabel = 'Param. protocollazione'
      FieldName = 'COD_PARPROTOCOLLO'
      Visible = False
      Size = 5
    end
    object selTabellaD_PARPROTOCOLLO: TStringField
      DisplayLabel = 'Desc. param. protocollazione'
      FieldKind = fkCalculated
      FieldName = 'D_PARPROTOCOLLO'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaPATH_FILEPDF: TStringField
      DisplayLabel = 'Path file PDF'
      FieldName = 'PATH_FILEPDF'
      Visible = False
      Size = 1000
    end
    object selTabellaTESTO_VALUTAZIONI_COMPLESSIVE: TStringField
      DisplayLabel = 'Testo val. compl.'
      FieldName = 'TESTO_VALUTAZIONI_COMPLESSIVE'
      Visible = False
      Size = 500
    end
    object selTabellaASSEGN_PREVENTIVA_OBIETTIVI: TStringField
      DisplayLabel = 'Assegn. preventiva obiettivi'
      FieldName = 'ASSEGN_PREVENTIVA_OBIETTIVI'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_DA_OBIETTIVI: TDateTimeField
      DisplayLabel = 'Inizio periodo assegn. ob.'
      FieldName = 'DATA_DA_OBIETTIVI'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATA_A_OBIETTIVI: TDateTimeField
      DisplayLabel = 'Fine periodo assegn. ob.'
      FieldName = 'DATA_A_OBIETTIVI'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaABILITA_AREE_FORMATIVE: TStringField
      DisplayLabel = 'Abilita aree form.'
      FieldName = 'ABILITA_AREE_FORMATIVE'
      Visible = False
      Size = 1
    end
    object selTabellaAREA_FORMATIVA_OBBLIGATORIA: TStringField
      DisplayLabel = 'Area form. obblig.'
      FieldName = 'AREA_FORMATIVA_OBBLIGATORIA'
      Visible = False
      Size = 1
    end
    object selTabellaCOMMENTI_VALUTATO_DIP: TStringField
      DisplayLabel = 'Pagina (P4) gestita dal valutato'
      FieldName = 'COMMENTI_VALUTATO_DIP'
      Visible = False
      Size = 1
    end
    object selTabellaABILITA_ACCETTAZIONE_VALUTATO: TStringField
      DisplayLabel = 'Abilita accett. valutato'
      FieldName = 'ABILITA_ACCETTAZIONE_VALUTATO'
      Visible = False
      Size = 1
    end
    object selTabellaREGISTRA_DATA_ACCETTAZIONE_VAL: TStringField
      DisplayLabel = 'Registra data accett. valutato'
      FieldName = 'REGISTRA_DATA_ACCETTAZIONE_VAL'
      Visible = False
      Size = 1
    end
    object selTabellaABILITA_COMMENTI_VALUTATO: TStringField
      DisplayLabel = 'Abilita comm. valutato'
      FieldName = 'ABILITA_COMMENTI_VALUTATO'
      Visible = False
      Size = 1
    end
    object selTabellaMODIFICA_NOTE_SUPERVISOREVALUT: TStringField
      DisplayLabel = 'Modifica note Supervisore'
      FieldName = 'MODIFICA_NOTE_SUPERVISOREVALUT'
      Visible = False
      Size = 1
    end
  end
end
