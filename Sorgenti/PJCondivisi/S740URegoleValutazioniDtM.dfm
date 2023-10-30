inherited S740FRegoleValutazioniDtM: TS740FRegoleValutazioniDtM
  OldCreateOrder = True
  Height = 169
  Width = 124
  object SG741: TOracleDataSet
    SQL.Strings = (
      'SELECT SG741.*, SG741.ROWID'
      'FROM SG741_REGOLE_VALUTAZIONI SG741'
      'ORDER BY CODICE, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    AfterOpen = SG741AfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = SG741AfterScroll
    OnCalcFields = SG741CalcFields
    Left = 8
    Top = 16
    object SG741DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object SG741DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza fine'
      FieldName = 'DECORRENZA_FINE'
    end
    object SG741CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object SG741DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object SG741FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 4000
    end
    object SG741COD_TIPI_RAPPORTO: TStringField
      DisplayLabel = 'Tipi rapporto valutabili'
      FieldName = 'COD_TIPI_RAPPORTO'
      Size = 400
    end
    object SG741GIORNI_MINIMI: TIntegerField
      DisplayLabel = 'Giorni minimi'
      FieldName = 'GIORNI_MINIMI'
    end
    object SG741VALUTA_CESSATI_RUOLO: TStringField
      DisplayLabel = 'Ignora gg min cessati ruolo'
      FieldName = 'VALUTA_CESSATI_RUOLO'
      Size = 1
    end
    object SG741AGGIORNA_DATA_COMPILAZIONE: TStringField
      DisplayLabel = 'Agg. data compil.'
      FieldName = 'AGGIORNA_DATA_COMPILAZIONE'
      Size = 1
    end
    object SG741INVIO_EMAIL: TStringField
      DisplayLabel = 'Invio email valutato'
      FieldName = 'INVIO_EMAIL'
      Size = 1
    end
    object SG741TIPO_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrotondamento Punt. scheda'
      FieldName = 'TIPO_ARROTONDAMENTO'
      Size = 1
    end
    object SG741PAGINE_ABILITATE: TStringField
      DisplayLabel = 'Pagine abilitate'
      FieldName = 'PAGINE_ABILITATE'
      Size = 50
    end
    object SG741CAMPI_OPZIONALI_COMPILAZIONE: TStringField
      DisplayLabel = 'Col. opzionali compilazione'
      FieldName = 'CAMPI_OPZIONALI_COMPILAZIONE'
      Size = 15
    end
    object SG741PATH_INFORMAZIONI: TStringField
      DisplayLabel = 'Path file informazioni'
      FieldName = 'PATH_INFORMAZIONI'
      Size = 1000
    end
    object SG741PATH_ISTRUZIONI: TStringField
      DisplayLabel = 'Path file istruzioni'
      FieldName = 'PATH_ISTRUZIONI'
      Size = 1000
    end
    object SG741DATO_STAMPA_1: TStringField
      DisplayLabel = 'Dato stampa 1'
      FieldName = 'DATO_STAMPA_1'
      Size = 30
    end
    object SG741DESC_LUNGA_1: TStringField
      DisplayLabel = 'Descr. lunga 1'
      FieldName = 'DESC_LUNGA_1'
      Size = 1
    end
    object SG741DATO_STAMPA_2: TStringField
      DisplayLabel = 'Dato stampa 2'
      FieldName = 'DATO_STAMPA_2'
      Size = 30
    end
    object SG741DATO_STAMPA_3: TStringField
      DisplayLabel = 'Dato stampa 3'
      FieldName = 'DATO_STAMPA_3'
      Size = 30
    end
    object SG741DESC_LUNGA_3: TStringField
      DisplayLabel = 'Descr. lunga 3'
      FieldName = 'DESC_LUNGA_3'
      Size = 1
    end
    object SG741DATO_STAMPA_4: TStringField
      DisplayLabel = 'Dato stampa 4'
      FieldName = 'DATO_STAMPA_4'
      Size = 30
    end
    object SG741DATO_STAMPA_5: TStringField
      DisplayLabel = 'Dato stampa 5'
      FieldName = 'DATO_STAMPA_5'
      Size = 30
    end
    object SG741DESC_LUNGA_5: TStringField
      DisplayLabel = 'Descr. lunga 5'
      FieldName = 'DESC_LUNGA_5'
      Size = 1
    end
    object SG741STAMPA_VARIAZIONI_5: TStringField
      DisplayLabel = 'Stampa variaz. 5'
      FieldName = 'STAMPA_VARIAZIONI_5'
      Size = 1
    end
    object SG741DATO_STAMPA_6: TStringField
      DisplayLabel = 'Dato stampa 6'
      FieldName = 'DATO_STAMPA_6'
      Size = 30
    end
    object SG741DATO_VARIAZIONE_VALUTATORE: TStringField
      DisplayLabel = 'Campo firma 2'#176' valut.'
      FieldName = 'DATO_VARIAZIONE_VALUTATORE'
      Size = 30
    end
    object SG741LOGO_LARGHEZZA: TIntegerField
      DisplayLabel = 'Larghezza logo'
      FieldName = 'LOGO_LARGHEZZA'
    end
    object SG741LOGO_ALTEZZA: TIntegerField
      DisplayLabel = 'Altezza logo'
      FieldName = 'LOGO_ALTEZZA'
    end
    object SG741CAMPI_OPZIONALI_STAMPA: TStringField
      DisplayLabel = 'Col. opzionali stampa'
      FieldName = 'CAMPI_OPZIONALI_STAMPA'
      Size = 15
    end
    object SG741STAMPA_PERIODO_VALUTAZIONE: TStringField
      DisplayLabel = 'Stampa periodo valutazione'
      FieldName = 'STAMPA_PERIODO_VALUTAZIONE'
      Size = 1
    end
    object SG741TESTO_AVVISO_PRESA_VISIONE: TStringField
      DisplayLabel = 'Testo avviso per p.v.'
      FieldName = 'TESTO_AVVISO_PRESA_VISIONE'
      Size = 500
    end
    object SG741CODTIPOQUOTA_STAMPA: TStringField
      DisplayLabel = 'Quota stampa scaglioni inc.'
      FieldName = 'CODTIPOQUOTA_STAMPA'
      Size = 5
    end
    object SG741D_TIPOQUOTA_STAMPA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPOQUOTA_STAMPA'
      Size = 40
      Calculated = True
    end
    object SG741COD_PARPROTOCOLLO: TStringField
      DisplayLabel = 'Param. protocollazione'
      FieldName = 'COD_PARPROTOCOLLO'
      Size = 5
    end
    object SG741D_PARPROTOCOLLO: TStringField
      DisplayLabel = 'Desc. param. protocollazione'
      FieldKind = fkCalculated
      FieldName = 'D_PARPROTOCOLLO'
      Size = 40
      Calculated = True
    end
    object SG741PATH_FILEPDF: TStringField
      DisplayLabel = 'Path file PDF'
      FieldName = 'PATH_FILEPDF'
      Size = 1000
    end
    object SG741TESTO_VALUTAZIONI_COMPLESSIVE: TStringField
      DisplayLabel = 'Testo val. compl.'
      FieldName = 'TESTO_VALUTAZIONI_COMPLESSIVE'
      Size = 500
    end
    object SG741ASSEGN_PREVENTIVA_OBIETTIVI: TStringField
      DisplayLabel = 'Assegn. preventiva obiettivi'
      FieldName = 'ASSEGN_PREVENTIVA_OBIETTIVI'
      Size = 1
    end
    object SG741DATA_DA_OBIETTIVI: TDateTimeField
      DisplayLabel = 'Inizio periodo assegn. ob.'
      FieldName = 'DATA_DA_OBIETTIVI'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG741DATA_A_OBIETTIVI: TDateTimeField
      DisplayLabel = 'Fine periodo assegn. ob.'
      FieldName = 'DATA_A_OBIETTIVI'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG741ABILITA_AREE_FORMATIVE: TStringField
      DisplayLabel = 'Abilita aree form.'
      FieldName = 'ABILITA_AREE_FORMATIVE'
      Size = 1
    end
    object SG741AREA_FORMATIVA_OBBLIGATORIA: TStringField
      DisplayLabel = 'Area form. obblig.'
      FieldName = 'AREA_FORMATIVA_OBBLIGATORIA'
      Size = 1
    end
    object SG741COMMENTI_VALUTATO_DIP: TStringField
      DisplayLabel = 'Pagina (P4) gestita dal valutato'
      FieldName = 'COMMENTI_VALUTATO_DIP'
      Size = 1
    end
    object SG741ABILITA_ACCETTAZIONE_VALUTATO: TStringField
      DisplayLabel = 'Abilita accett. valutato'
      FieldName = 'ABILITA_ACCETTAZIONE_VALUTATO'
      Size = 1
    end
    object SG741REGISTRA_DATA_ACCETTAZIONE_VAL: TStringField
      DisplayLabel = 'Registra data accett. valutato'
      FieldName = 'REGISTRA_DATA_ACCETTAZIONE_VAL'
      Size = 1
    end
    object SG741ABILITA_COMMENTI_VALUTATO: TStringField
      DisplayLabel = 'Abilita comm. valutato'
      FieldName = 'ABILITA_COMMENTI_VALUTATO'
      Size = 1
    end
    object SG741MODIFICA_NOTE_SUPERVISOREVALUT: TStringField
      DisplayLabel = 'Modifica note Supervisore'
      FieldName = 'MODIFICA_NOTE_SUPERVISOREVALUT'
      Size = 1
    end
  end
end
