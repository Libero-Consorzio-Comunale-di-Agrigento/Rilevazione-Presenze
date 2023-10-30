inherited WP430FAnagraficoDM: TWP430FAnagraficoDM
  Height = 255
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT P430.*,P430.ROWID FROM P430_ANAGRAFICO P430'
      'WHERE PROGRESSIVO = :Progressivo'
      ':ORDERBY'
      ''
      '')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaCOD_CONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      FieldName = 'COD_CONTRATTO'
      Size = 5
    end
    object selTabellaD_CONTRATTO: TStringField
      DisplayLabel = 'Desc. contratto voci'
      FieldKind = fkCalculated
      FieldName = 'D_CONTRATTO'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_PARAMETRISTIPENDI: TStringField
      DisplayLabel = 'Area contrattuale'
      FieldName = 'COD_PARAMETRISTIPENDI'
      Visible = False
      Size = 5
    end
    object selTabellaD_PARAMETRISTIPENDI: TStringField
      DisplayLabel = 'Desc. area contrattuale'
      FieldKind = fkCalculated
      FieldName = 'D_PARAMETRISTIPENDI'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_TIPOASSOGGETTAMENTO: TStringField
      DisplayLabel = 'Tipo assoggettamento'
      DisplayWidth = 10
      FieldName = 'COD_TIPOASSOGGETTAMENTO'
      Size = 10
    end
    object selTabellaD_TIPOASSOGGETTAMENTO: TStringField
      DisplayLabel = 'Descrizione tipo assoggettamento'
      FieldKind = fkCalculated
      FieldName = 'D_TIPOASSOGGETTAMENTO'
      Size = 100
      Calculated = True
    end
    object selTabellaCOD_POSIZIONE_ECONOMICA: TStringField
      DisplayLabel = 'Posizione economica'
      DisplayWidth = 5
      FieldName = 'COD_POSIZIONE_ECONOMICA'
      Size = 5
    end
    object selTabellaD_POSIZIONE_ECONOMICA: TStringField
      DisplayLabel = 'Descrizione posizione economica'
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'D_POSIZIONE_ECONOMICA'
      Size = 100
      Calculated = True
    end
    object selTabellaCOD_PARTTIME: TStringField
      DisplayLabel = 'Part-time'
      FieldName = 'COD_PARTTIME'
      Size = 5
    end
    object selTabellaD_PARTTIME: TStringField
      DisplayLabel = 'Descrizione part-time'
      FieldKind = fkLookup
      FieldName = 'D_PARTTIME'
      LookupKeyFields = 'COD_PARTTIME'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_PARTTIME'
      Size = 40
      Lookup = True
    end
    object selTabellaTIPO_DIPENDENTE: TStringField
      DisplayLabel = 'Tipo lavoratore'
      FieldName = 'TIPO_DIPENDENTE'
      Visible = False
      Size = 2
    end
    object selTabellaD_TIPO_DIPENDENTE: TStringField
      DisplayLabel = 'Descrizione Tipo lavoratore'
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_DIPENDENTE'
      Size = 100
      Calculated = True
    end
    object selTabellaPROGRESSIVO_EREDE_DI: TFloatField
      DisplayLabel = 'Progressivo erede'
      FieldName = 'PROGRESSIVO_EREDE_DI'
      Visible = False
    end
    object selTabellaD_NOMINATIVO_EREDE: TStringField
      DisplayLabel = 'Nominativo erede'
      DisplayWidth = 40
      FieldKind = fkCalculated
      FieldName = 'D_NOMINATIVO_EREDE'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaPERC_EREDITA: TFloatField
      DisplayLabel = 'Percentuale eredit'#224
      FieldName = 'PERC_EREDITA'
      Visible = False
    end
    object selTabellaSTATO_DIPENDENTE: TStringField
      DisplayLabel = 'Stato dipendente'
      FieldName = 'STATO_DIPENDENTE'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaNO_CEDOLINO_NORMALE: TStringField
      DisplayLabel = 'Tipo emissione cedolino normale'
      FieldName = 'NO_CEDOLINO_NORMALE'
      Visible = False
      Size = 1
    end
    object selTabellaRETRIB_MESE_PREC: TStringField
      DisplayLabel = 'Retribuzioni afferenti al mese precedente'
      FieldName = 'RETRIB_MESE_PREC'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_BANCA: TStringField
      DisplayLabel = 'Codice banca'
      DisplayWidth = 15
      FieldName = 'COD_BANCA'
      Visible = False
      Size = 15
    end
    object selTabellaD_BANCA: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'D_BANCA'
      LookupKeyFields = 'COD_BANCA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_BANCA'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaCONTO_CORRENTE: TStringField
      DisplayLabel = 'Conto corrente'
      FieldName = 'CONTO_CORRENTE'
      Visible = False
      OnSetText = selTabellaCONTO_CORRENTESetText
      Size = 13
    end
    object selTabellaCIN_ITALIA: TStringField
      DisplayLabel = 'CIN italia'
      FieldName = 'CIN_ITALIA'
      Visible = False
      Size = 1
    end
    object selTabellaCIN_EUROPA: TStringField
      DisplayLabel = 'CIN europa'
      FieldName = 'CIN_EUROPA'
      Visible = False
      Size = 2
    end
    object selTabellaIBAN_ESTERO: TStringField
      DisplayLabel = 'IBAN estero'
      FieldName = 'IBAN_ESTERO'
      Visible = False
      Size = 35
    end
    object selTabellaIBAN_ESTERO_CITTA: TStringField
      DisplayLabel = 'Citt'#224' estera'
      FieldName = 'IBAN_ESTERO_CITTA'
      Visible = False
      Size = 30
    end
    object selTabellaCOD_PAGAMENTO: TStringField
      DisplayLabel = 'Modalit'#224' pagamento'
      FieldName = 'COD_PAGAMENTO'
      Visible = False
      Size = 5
    end
    object selTabellaD_PAGAMENTO: TStringField
      DisplayLabel = 'Descrizione modalit'#224' pagamento'
      FieldKind = fkLookup
      FieldName = 'D_PAGAMENTO'
      LookupKeyFields = 'COD_PAGAMENTO'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_PAGAMENTO'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCOD_VALUTA_BASE: TStringField
      DisplayLabel = 'Valuta calcoli'
      FieldName = 'COD_VALUTA_BASE'
      Visible = False
      Size = 10
    end
    object selTabellaD_COD_VALUTA_BASE: TStringField
      DisplayLabel = 'Descrizione valuta calcoli'
      FieldKind = fkCalculated
      FieldName = 'D_COD_VALUTA_BASE'
      LookupKeyFields = 'COD_VALUTA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VALUTA_BASE'
      Visible = False
      Calculated = True
    end
    object selTabellaCOD_VALUTA_STAMPA: TStringField
      DisplayLabel = 'Valuta netto'
      FieldName = 'COD_VALUTA_STAMPA'
      Visible = False
      Size = 10
    end
    object selTabellaD_VALUTA: TStringField
      DisplayLabel = 'Descrizione valuta netto'
      FieldKind = fkCalculated
      FieldName = 'D_VALUTA'
      LookupKeyFields = 'COD_VALUTA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VALUTA_STAMPA'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_STATOCIVILE: TStringField
      DisplayLabel = 'Stato civile'
      FieldName = 'COD_STATOCIVILE'
      Visible = False
      Size = 5
    end
    object selTabellaD_STATOCIVILE: TStringField
      DisplayLabel = 'Descrizione stato civile'
      FieldKind = fkLookup
      FieldName = 'D_STATOCIVILE'
      LookupKeyFields = 'COD_STATOCIVILE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_STATOCIVILE'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCOD_NAZIONALITA: TStringField
      DisplayLabel = 'Nazionalit'#224
      FieldName = 'COD_NAZIONALITA'
      Visible = False
      Size = 5
    end
    object selTabellaD_NAZIONALITA: TStringField
      DisplayLabel = 'Descrizione nazionalit'#224
      FieldKind = fkLookup
      FieldName = 'D_NAZIONALITA'
      LookupKeyFields = 'COD_NAZIONALITA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_NAZIONALITA'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaTREDICESIMA: TStringField
      DisplayLabel = 'Tredicesima prevista'
      FieldName = 'TREDICESIMA'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_CALCOLO_IMPORTO13A: TStringField
      DisplayLabel = 'Tipo calcolo tredicesima'
      FieldName = 'TIPO_CALCOLO_IMPORTO13A'
      Required = True
      Visible = False
      Size = 2
    end
    object selTabellaCONGUAGLIO: TStringField
      DisplayLabel = 'Conguaglio IRPEF'
      FieldName = 'CONGUAGLIO'
      Visible = False
      Size = 1
    end
    object selTabellaPERC_IRPEF_MANUALE: TFloatField
      DisplayLabel = 'Percentuale fissa IRPEF'
      FieldName = 'PERC_IRPEF_MANUALE'
      Visible = False
    end
    object selTabellaPERC_IRPEF_EXTRA27: TFloatField
      DisplayLabel = 'Percentuale fissa Extra27'
      FieldName = 'PERC_IRPEF_EXTRA27'
      Visible = False
    end
    object selTabellaPERC_IRPEF_TFR: TFloatField
      DisplayLabel = 'Percentuale IRPEF TFR'
      FieldName = 'PERC_IRPEF_TFR'
      Required = True
      Visible = False
    end
    object selTabellaPERC_IRPEF_MASSIMA_EXTRA27: TStringField
      DisplayLabel = 'Massima percentuale anno'
      FieldName = 'PERC_IRPEF_MASSIMA_EXTRA27'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_CAUSALEIRPEF: TStringField
      DisplayLabel = 'Causale IRPEF'
      FieldName = 'COD_CAUSALEIRPEF'
      Visible = False
      Size = 10
    end
    object selTabellaD_CAUSALEIRPEF: TStringField
      DisplayLabel = 'Descrizione causale IRPEF'
      FieldKind = fkLookup
      FieldName = 'D_CAUSALEIRPEF'
      LookupKeyFields = 'COD_CAUSALEIRPEF'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_CAUSALEIRPEF'
      Visible = False
      Size = 250
      Lookup = True
    end
    object selTabellaCOD_COMUNE_IRPEF: TStringField
      DisplayLabel = 'Comune IRPEF'
      DisplayWidth = 4
      FieldName = 'COD_COMUNE_IRPEF'
      Visible = False
      Size = 6
    end
    object selTabellaD_COMUNE_IRPEF: TStringField
      DisplayLabel = 'Descrizione comune IRPEF'
      FieldKind = fkLookup
      FieldName = 'D_COMUNE_IRPEF'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE_IRPEF'
      LookupCache = True
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaCOD_REGIONE_IRPEF: TStringField
      DisplayLabel = 'Regione IRPEF'
      FieldName = 'COD_REGIONE_IRPEF'
      Visible = False
      Size = 5
    end
    object selTabellaD_REGIONE_IRPEF: TStringField
      DisplayLabel = 'Descrizione regione IRPEF'
      FieldKind = fkLookup
      FieldName = 'D_REGIONE_IRPEF'
      LookupKeyFields = 'COD_REGIONE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_REGIONE_IRPEF'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaREDDITO_DETRAZ_FIGLI_ALTRI: TFloatField
      DisplayLabel = 'Reddito annuale ulteriore'
      FieldName = 'REDDITO_DETRAZ_FIGLI_ALTRI'
      Visible = False
    end
    object selTabellaREDDITO_DETRAZ_LAVDIP: TFloatField
      DisplayLabel = 'Reddito abitazione principale'
      FieldName = 'REDDITO_DETRAZ_LAVDIP'
      Visible = False
    end
    object selTabellaREDDITO_DETRAZ_CONIUGE: TFloatField
      DisplayLabel = 'Reddito detrazione coniuge'
      FieldName = 'REDDITO_DETRAZ_CONIUGE'
      Visible = False
    end
    object selTabellaDETRAZ_LAVDIP: TStringField
      DisplayLabel = 'Tipo detrazioni'
      FieldName = 'DETRAZ_LAVDIP'
      Visible = False
      Size = 1
    end
    object selTabellaDETRAZ_REDDITI_MIN_INDET: TStringField
      DisplayLabel = 'Minino garantito contratto indeterminato'
      FieldName = 'DETRAZ_REDDITI_MIN_INDET'
      Visible = False
      Size = 1
    end
    object selTabellaDETRAZ_REDDITI_MIN_DET: TStringField
      DisplayLabel = 'Minino garantito contratto determinato'
      FieldName = 'DETRAZ_REDDITI_MIN_DET'
      Visible = False
      Size = 1
    end
    object selTabellaPERC_DETRAZ_FAM_NUMEROSE: TStringField
      DisplayLabel = 'Detrazione 100% senza familiare a carico'
      FieldName = 'PERC_DETRAZ_FAM_NUMEROSE'
      Visible = False
      Size = 1
    end
    object selTabellaCREDITO_FAM_NUMEROSE: TStringField
      DisplayLabel = 'Credito famiglie numerose'
      FieldName = 'CREDITO_FAM_NUMEROSE'
      Visible = False
      Size = 1
    end
    object selTabellaBONUS_RIDUZ_CUNEO_FISC: TStringField
      DisplayLabel = 'Bonus riduzione cuneo fiscale'
      FieldName = 'BONUS_RIDUZ_CUNEO_FISC'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_TABELLAANF: TStringField
      DisplayLabel = 'Tabella A.N.F.'
      FieldName = 'COD_TABELLAANF'
      Visible = False
      Size = 5
    end
    object selTabellaD_TABELLAANF: TStringField
      DisplayLabel = 'Descrizione tabella A.N.F.'
      DisplayWidth = 200
      FieldKind = fkCalculated
      FieldName = 'D_TABELLAANF'
      Visible = False
      Size = 200
      Calculated = True
    end
    object selTabellaSCADENZA_ANF: TDateTimeField
      DisplayLabel = 'Data fine A.N.F.'
      FieldName = 'SCADENZA_ANF'
      Visible = False
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selTabellaREDDITO_ANF: TFloatField
      DisplayLabel = 'Reddito lav.dip. A.N.F.'
      FieldName = 'REDDITO_ANF'
      Visible = False
    end
    object selTabellaREDDITO_ALTRO_ANF: TFloatField
      DisplayLabel = 'Altri redditi A.N.F.'
      FieldName = 'REDDITO_ALTRO_ANF'
      Visible = False
    end
    object selTabellaINABILE_ANF: TStringField
      DisplayLabel = 'Inabile A.N.F.'
      FieldName = 'INABILE_ANF'
      Visible = False
      Size = 1
    end
    object selTabellaCOMPONENTI_ANF: TFloatField
      DisplayLabel = 'Componenti A.N.F.'
      FieldName = 'COMPONENTI_ANF'
      Visible = False
    end
    object selTabellaVARIAZIONE_IMPORTO_ANF: TFloatField
      DisplayLabel = 'Variazione A.N.F.'
      FieldName = 'VARIAZIONE_IMPORTO_ANF'
      Visible = False
    end
    object selTabellaCOD_CODICEINPS: TStringField
      DisplayLabel = 'Codice INPS'
      FieldName = 'COD_CODICEINPS'
      Visible = False
      Size = 5
    end
    object selTabellaD_CODICEINPS: TStringField
      DisplayLabel = 'Descrizione codice INPS'
      FieldKind = fkCalculated
      FieldName = 'D_CODICEINPS'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_INQUADRINPS: TStringField
      DisplayLabel = 'Codice inquadramento INPS'
      FieldName = 'COD_INQUADRINPS'
      Visible = False
      Size = 10
    end
    object selTabellaD_INQUADRINPS: TStringField
      DisplayLabel = 'Descrizione inquadramento INPS'
      FieldKind = fkCalculated
      FieldName = 'D_INQUADRINPS'
      LookupKeyFields = 'COD_INQUADRINPS'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_INQUADRINPS'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCOD_EMENSQUALPROF: TStringField
      DisplayLabel = 'Qualifica professionale'
      FieldName = 'COD_EMENSQUALPROF'
      Visible = False
      Size = 15
    end
    object selTabellaCOD_EMENSTIPOASS: TStringField
      DisplayLabel = 'Tipo assunzione'
      FieldName = 'COD_EMENSTIPOASS'
      Visible = False
      Size = 5
    end
    object selTabellaD_EMENSTIPOASS: TStringField
      DisplayLabel = 'Descrizione tipo assunzione'
      FieldKind = fkCalculated
      FieldName = 'D_EMENSTIPOASS'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_EMENSTIPOCESS: TStringField
      DisplayLabel = 'Tipo cessazione'
      FieldName = 'COD_EMENSTIPOCESS'
      Visible = False
      Size = 5
    end
    object selTabellaD_EMENSTIPOCESS: TStringField
      DisplayLabel = 'Descrizione tipo cessazione'
      FieldKind = fkCalculated
      FieldName = 'D_EMENSTIPOCESS'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_TIPORAPP_COCOCO: TStringField
      DisplayLabel = 'Tipo rapporto parasubordinato'
      FieldName = 'COD_TIPORAPP_COCOCO'
      Visible = False
      Size = 5
    end
    object selTabellaD_TIPORAPP_COCOCO: TStringField
      DisplayLabel = 'Descrizioner tipo rapporto parasubordinato'
      FieldKind = fkCalculated
      FieldName = 'D_TIPORAPP_COCOCO'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_TIPOATT_COCOCO: TStringField
      DisplayLabel = 'Tipo attivit'#224' parasubordinato'
      FieldName = 'COD_TIPOATT_COCOCO'
      Visible = False
      Size = 5
    end
    object selTabellaD_TIPOATT_COCOCO: TStringField
      DisplayLabel = 'Descrizione tipo attivit'#224' parasubordinato'
      FieldKind = fkCalculated
      FieldName = 'D_TIPOATT_COCOCO'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_ALTRAASS_COCOCO: TStringField
      DisplayLabel = 'Altra assicurazine parasubord.'
      FieldName = 'COD_ALTRAASS_COCOCO'
      Visible = False
      Size = 5
    end
    object selTabellaD_ALTRAASS_COCOCO: TStringField
      DisplayLabel = 'Desc. altra assicurazine parasubord.'
      FieldKind = fkCalculated
      FieldName = 'D_ALTRAASS_COCOCO'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaLIVELLO_INPS: TStringField
      DisplayLabel = 'Livello INPS'
      FieldName = 'LIVELLO_INPS'
      Visible = False
      Size = 5
    end
    object selTabellaCOD_INQUADRINPDAP: TStringField
      DisplayLabel = 'Codice inquadramento INPDAP'
      DisplayWidth = 10
      FieldName = 'COD_INQUADRINPDAP'
      Visible = False
      Size = 10
    end
    object selTabellaD_INQUADRINPDAP: TStringField
      DisplayLabel = 'Descrizione inquadramento INPDAP'
      DisplayWidth = 300
      FieldKind = fkCalculated
      FieldName = 'D_INQUADRINPDAP'
      LookupKeyFields = 'COD_INQUADRINPDAP'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_INQUADRINPDAP'
      Visible = False
      Size = 300
      Calculated = True
    end
    object selTabellaCOD_CUDINPDAPCAUSACESS: TStringField
      DisplayLabel = 'Causa cessazione INPDAP'
      FieldName = 'COD_CUDINPDAPCAUSACESS'
      Visible = False
      Size = 5
    end
    object selTabellaD_CUDINPDAPCAUSACESS: TStringField
      DisplayLabel = 'Descrizione causa cessazione INPDAP'
      FieldKind = fkCalculated
      FieldName = 'D_CUDINPDAPCAUSACESS'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_CATEG_CONVENZ: TStringField
      DisplayLabel = 'Categoria ENPAM'
      FieldName = 'COD_CATEG_CONVENZ'
      Visible = False
      Size = 5
    end
    object selTabellaD_CATEG_CONVENZ: TStringField
      DisplayLabel = 'Descrizione categoria ENPAM'
      FieldKind = fkCalculated
      FieldName = 'D_CATEG_CONVENZ'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaMATR_PENSIONISTICA: TStringField
      DisplayLabel = 'Matricola pensionistica'
      FieldName = 'MATR_PENSIONISTICA'
      Visible = False
      Size = 10
    end
    object selTabellaTIPO_MASSIMALE_CONTR: TStringField
      DisplayLabel = 'Tipo massimale contributivo'
      FieldName = 'TIPO_MASSIMALE_CONTR'
      Visible = False
      Size = 1
    end
    object selTabellaALTRA_AMM: TStringField
      DisplayLabel = 'Tipologia altra amministrazione'
      FieldName = 'ALTRA_AMM'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_INPDAPTIPOLS_ALTRA_AMM: TStringField
      DisplayLabel = 'Tipologia servizio altra amm.'
      FieldName = 'COD_INPDAPTIPOLS_ALTRA_AMM'
      Visible = False
      Size = 5
    end
    object selTabellaD_INPDAPTIPOLS_ALTRA_AMM: TStringField
      DisplayLabel = 'Descrizione tipologia servizio altra amm.'
      FieldKind = fkCalculated
      FieldName = 'D_INPDAPTIPOLS_ALTRA_AMM'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_FISCALE_ALTRA_AMM: TStringField
      DisplayLabel = 'Codice fiscale altra amm.'
      FieldName = 'COD_FISCALE_ALTRA_AMM'
      Visible = False
    end
    object selTabellaCODICE_INPDAP_ALTRA_AMM: TStringField
      DisplayLabel = 'Progressivo azienda altra amm.'
      FieldName = 'CODICE_INPDAP_ALTRA_AMM'
      Visible = False
      Size = 5
    end
    object selTabellaCOD_CODICEINAIL: TStringField
      DisplayLabel = 'Codice INAIL'
      FieldName = 'COD_CODICEINAIL'
      Visible = False
      Size = 5
    end
    object selTabellaD_CODICEINAIL: TStringField
      DisplayLabel = 'Descrizione codice INAIL'
      FieldKind = fkCalculated
      FieldName = 'D_CODICEINAIL'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaCOD_QUALIFICA_INAIL: TStringField
      DisplayLabel = 'Qualifica INAIL'
      FieldName = 'COD_QUALIFICA_INAIL'
      Visible = False
      Size = 5
    end
    object selTabellaD_QUALIFICA_INAIL: TStringField
      DisplayLabel = 'Descrizione qualifica INAIL'
      FieldKind = fkCalculated
      FieldName = 'D_QUALIFICA_INAIL'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_COMUNE_INAIL: TStringField
      DisplayLabel = 'Codice comune INAIL'
      FieldName = 'COD_COMUNE_INAIL'
      Visible = False
      Size = 4
    end
    object selTabellaD_COMUNE_INAIL: TStringField
      DisplayLabel = 'Comune INAIL'
      FieldKind = fkLookup
      FieldName = 'D_COMUNE_INAIL'
      LookupKeyFields = 'CODCATASTALE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE_INAIL'
      LookupCache = True
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaCOD_CATEGPARTICOLARE: TStringField
      DisplayLabel = 'Categoria particolare'
      FieldName = 'COD_CATEGPARTICOLARE'
      Visible = False
      Size = 5
    end
    object selTabellaD_CATEGPARTICOLARE: TStringField
      DisplayLabel = 'Descrizione categoria particolare'
      FieldKind = fkCalculated
      FieldName = 'D_CATEGPARTICOLARE'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_CAUSALELA: TStringField
      DisplayLabel = 'Causale lav. autonomi'
      FieldName = 'COD_CAUSALELA'
      Visible = False
      Size = 5
    end
    object selTabellaD_CAUSALELA: TStringField
      DisplayLabel = 'Descrizione causale lav. autonomi'
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALELA'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaPROFESSIONE_ONAOSI: TStringField
      DisplayLabel = 'Professione ONAOSI'
      FieldName = 'PROFESSIONE_ONAOSI'
      Visible = False
      Size = 2
    end
    object selTabellaCOD_ONAOSITIPOPAG: TStringField
      DisplayLabel = 'Pagamento particolare ONAOSI'
      FieldName = 'COD_ONAOSITIPOPAG'
      Visible = False
      Size = 5
    end
    object selTabellaD_ONAOSITIPOPAG: TStringField
      DisplayLabel = 'Desc. pagamento particolare ONAOSI'
      FieldKind = fkCalculated
      FieldName = 'D_ONAOSITIPOPAG'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_ONAOSITIPOASS: TStringField
      DisplayLabel = 'Tipo assunzione ONAOSI'
      FieldName = 'COD_ONAOSITIPOASS'
      Visible = False
      Size = 5
    end
    object selTabellaD_ONAOSITIPOASS: TStringField
      DisplayLabel = 'Descrizionetipo assunzione ONAOSI'
      FieldKind = fkCalculated
      FieldName = 'D_ONAOSITIPOASS'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_ONAOSITIPOCESS: TStringField
      DisplayLabel = 'Tipo cessazione ONAOSI'
      FieldName = 'COD_ONAOSITIPOCESS'
      Visible = False
      Size = 5
    end
    object selTabellaD_ONAOSITIPOCESS: TStringField
      DisplayLabel = 'Descrizione tipo cessazione ONAOSI'
      FieldKind = fkCalculated
      FieldName = 'D_ONAOSITIPOCESS'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaDATA_ISCRIZIONE_ALBO: TDateTimeField
      DisplayLabel = 'Data iscrizione albo ONAOSI'
      DisplayWidth = 10
      FieldName = 'DATA_ISCRIZIONE_ALBO'
      Visible = False
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaNUMERO_ISCRIZIONE_ALBO: TStringField
      DisplayLabel = 'Numero iscrizione albo ONAOSI'
      FieldName = 'NUMERO_ISCRIZIONE_ALBO'
      Visible = False
      Size = 10
    end
    object selTabellaPROVINCIA_ALBO: TStringField
      DisplayLabel = 'Provincia albo ONAOSI'
      FieldName = 'PROVINCIA_ALBO'
      Visible = False
      Size = 2
    end
    object selTabellaTIPO_ADESIONE_FPC: TStringField
      DisplayLabel = 'Tipo adesione F.P.C.'
      FieldName = 'TIPO_ADESIONE_FPC'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_INF_SIL_ASS_FPC: TDateTimeField
      DisplayLabel = 'Data inf. silenzio-assenso'
      DisplayWidth = 10
      FieldName = 'DATA_INF_SIL_ASS_FPC'
      Visible = False
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCOD_FPC: TStringField
      DisplayLabel = 'F.P.C.'
      FieldName = 'COD_FPC'
      Visible = False
      Size = 10
    end
    object selTabellaD_FPC: TStringField
      DisplayLabel = 'Descrizione F.P.C.'
      FieldKind = fkCalculated
      FieldName = 'D_FPC'
      Visible = False
      Size = 100
      Calculated = True
    end
    object selTabellaDATA_DOMANDA_FPC: TDateTimeField
      DisplayLabel = 'Data domanda F.P.C.'
      DisplayWidth = 10
      FieldName = 'DATA_DOMANDA_FPC'
      Visible = False
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaLAV_PRIMA_OCCUP_FPC: TStringField
      DisplayLabel = 'Lavoratore di prima occupazione'
      FieldName = 'LAV_PRIMA_OCCUP_FPC'
      Visible = False
      Size = 1
    end
    object selTabellaPERC_TOT_DIP_FPC: TFloatField
      DisplayLabel = 'Percentuale carico dipendente F.P.C.'
      FieldName = 'PERC_TOT_DIP_FPC'
      Visible = False
    end
    object selTabellaDATA_SOSP_CESS_FPC: TDateTimeField
      DisplayLabel = 'Data sospens./cess. contribuzione F.P.C.'
      DisplayWidth = 10
      FieldName = 'DATA_SOSP_CESS_FPC'
      Visible = False
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCOD_INPDAPMOTIVOSOSP_FPC: TStringField
      DisplayLabel = 'Motivo sospensione F.P.C.'
      FieldName = 'COD_INPDAPMOTIVOSOSP_FPC'
      Visible = False
      Size = 5
    end
    object selTabellaD_INPDAPMOTIVOSOSP_FPC: TStringField
      DisplayLabel = 'Descrizione sospensione F.P.C.'
      FieldKind = fkCalculated
      FieldName = 'D_INPDAPMOTIVOSOSP_FPC'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_INPDAPTIPOCESS_FPC: TStringField
      DisplayLabel = 'Tipo cessazione F.P.C.'
      FieldName = 'COD_INPDAPTIPOCESS_FPC'
      Visible = False
      Size = 5
    end
    object selTabellaD_INPDAPTIPOCESS_FPC: TStringField
      DisplayLabel = 'Descrizione tipo cessazione F.P.C.'
      FieldKind = fkCalculated
      FieldName = 'D_INPDAPTIPOCESS_FPC'
      Visible = False
      Size = 500
      Calculated = True
    end
    object selTabellaCOD_NAZIONALITAESTERE: TStringField
      DisplayLabel = 'Codice nazionalit'#224' estera'
      FieldName = 'COD_NAZIONALITAESTERE'
      Visible = False
      Size = 5
    end
    object selTabellaREDDITO_DETRAZ_REDDITI_MIN: TFloatField
      DisplayLabel = 'Reddito detraz redditi min.'
      FieldName = 'REDDITO_DETRAZ_REDDITI_MIN'
      Visible = False
    end
    object selTabellaCOD_DEDUZIONEIRPEF: TStringField
      DisplayLabel = 'Codice deduzione IRPEF'
      FieldName = 'COD_DEDUZIONEIRPEF'
      Visible = False
      Size = 10
    end
    object selTabellaDETRAZ_PROGR_IMP: TStringField
      DisplayLabel = 'Detraz progr. imp.'
      FieldName = 'DETRAZ_PROGR_IMP'
      Visible = False
      Size = 1
    end
    object selTabellaREDDITO_DETRAZ_PROGR_IMP: TFloatField
      DisplayLabel = 'Reddito detraz. progr. imp.'
      FieldName = 'REDDITO_DETRAZ_PROGR_IMP'
      Visible = False
    end
    object selTabellaCOD_ENTE_APPARTENENZA: TStringField
      DisplayLabel = 'Codice ente appartenenza'
      FieldName = 'COD_ENTE_APPARTENENZA'
      Visible = False
      Size = 5
    end
    object selTabellaD_ENTE_APPARTENENZA: TStringField
      DisplayLabel = 'Denomin. ente appartenenza'
      FieldKind = fkLookup
      FieldName = 'D_ENTE_APPARTENENZA'
      LookupKeyFields = 'COD_ENTE_APPARTENENZA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_ENTE_APPARTENENZA'
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaPERC_IRPEF_REGIMI_SPECIALI: TFloatField
      DisplayLabel = 'Percentuale tassazione regimi speciali'
      FieldName = 'PERC_IRPEF_REGIMI_SPECIALI'
      Visible = False
    end
    object selTabellaCOD_STATO_EST_REG_SPEC: TStringField
      DisplayLabel = 'Codice stato estero regimi speciali'
      FieldName = 'COD_STATO_EST_REG_SPEC'
      Visible = False
      Size = 3
    end
  end
  object selT030Elenco: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.COGNOME, T030.NOME, TRIM(T030.COGNOME)||'#39' '#39'|| TRIM(T' +
        '030.NOME) AS NOMINATIVO, T030.MATRICOLA, T030.PROGRESSIVO '
      'FROM T030_ANAGRAFICO T030 /*I072*/ '
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    Left = 192
    Top = 120
    object selT030ElencoCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 30
      FieldName = 'COGNOME'
      Size = 50
    end
    object selT030ElencoNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 30
      FieldName = 'NOME'
      Size = 50
    end
    object selT030ElencoNOMINATIVO: TStringField
      DisplayWidth = 61
      FieldName = 'NOMINATIVO'
      Visible = False
      Size = 81
    end
    object selT030ElencoMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT030ElencoPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
  end
  object cdsStoriaDato: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 344
    Top = 185
    object cdsStoriaDatoDATO: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 50
      FieldName = 'DATO'
      Size = 50
    end
    object cdsStoriaDatoDATADEC: TStringField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DATADEC'
    end
    object cdsStoriaDatoDATAFINE: TStringField
      DisplayLabel = 'Termine'
      FieldName = 'DATAFINE'
    end
    object cdsStoriaDatoVALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 50
      FieldName = 'VALORE'
      Size = 50
    end
    object cdsStoriaDatoDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 200
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object cdsStoriaDatoKEY: TStringField
      FieldName = 'KEY'
      Visible = False
    end
    object cdsStoriaDatoRIGACOLORATA: TBooleanField
      FieldName = 'RIGACOLORATA'
      Visible = False
    end
  end
  object cdsrStoriaDato: TDataSource
    AutoEdit = False
    DataSet = cdsStoriaDato
    Left = 417
    Top = 185
  end
end
