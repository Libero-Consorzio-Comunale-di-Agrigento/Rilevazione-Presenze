inherited WA016FCausAssenzeDM: TWA016FCausAssenzeDM
  Height = 139
  Width = 390
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.*,T265.ROWID FROM T265_CAUASSENZE T265 :ORDERBY')
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T265_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    Filtered = True
    AfterPost = AfterPost
    BeforeCancel = selTabellaBeforeCancel
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object T265Codice: TStringField
      DisplayWidth = 6
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T265Descrizione: TStringField
      FieldName = 'Descrizione'
      Required = True
      Size = 40
    end
    object selTabellaDescrizione_estesa: TStringField
      DisplayWidth = 50
      FieldName = 'Descrizione_estesa'
      Visible = False
      Size = 200
    end
    object selTabellaCodRaggr: TStringField
      DisplayLabel = 'Raggruppamento'
      FieldName = 'CodRaggr'
      OnChange = BDET265CodRaggrChange
      Size = 5
    end
    object selTabellaD_Raggruppamento: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Raggruppamento'
      LookupDataSet = A016FCausAssenzeMW.Q260
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCAUSALE_SUCCESSIVA: TStringField
      DisplayLabel = 'Causale comp. esaurite'
      FieldName = 'CAUSALE_SUCCESSIVA'
      Size = 5
    end
    object selTabellaD_CAUSALE_SUCCESSIVA: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_SUCCESSIVA'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE_SUCCESSIVA'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCODCAU3: TStringField
      DisplayLabel = 'Causale primi 10 gg.'
      FieldName = 'CODCAU3'
      Size = 5
    end
    object selTabellaD_CODCAU3: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODCAU3'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODCAU3'
      Visible = False
      Size = 40
      Lookup = True
    end
    object T265RaggrStat: TStringField
      DisplayLabel = 'Raggr. statistica'
      FieldName = 'RaggrStat'
      Required = True
      Size = 1
    end
    object T265VocePaghe: TStringField
      DisplayLabel = 'Codice voce'
      FieldName = 'VocePaghe'
      Size = 10
    end
    object selTabellaD_VOCEPAGHE: TStringField
      Tag = 1999
      FieldKind = fkLookup
      FieldName = 'D_VOCEPAGHE'
      LookupDataSet = A016FCausAssenzeMW.selP200
      LookupKeyFields = 'COD_VOCE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'VocePaghe'
      Visible = False
      Size = 100
      Lookup = True
    end
    object T265VocePaghe2: TStringField
      DisplayLabel = 'Codice aggiuntivo'
      FieldName = 'VocePaghe2'
      Visible = False
      Size = 10
    end
    object T265GNonLav: TStringField
      DisplayLabel = 'Giorno non lav.'
      FieldName = 'GNonLav'
      Required = True
      Size = 1
    end
    object selTabellaInfluCont: TStringField
      DisplayLabel = 'Influenza sui conteggi'
      FieldName = 'InfluCont'
      OnChange = T265InfluContChange
      Size = 1
    end
    object T265ValorGior: TStringField
      DisplayLabel = 'Valorizz. giornaliera'
      FieldName = 'ValorGior'
      Required = True
      Size = 1
    end
    object T265InfluenzaPO: TStringField
      FieldName = 'InfluenzaPO'
      Required = True
      Visible = False
      Size = 1
    end
    object T265Indpres: TStringField
      FieldName = 'Indpres'
      ReadOnly = True
      Required = True
      Visible = False
      Size = 1
    end
    object T265EccedLiq: TStringField
      FieldName = 'EccedLiq'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaHMAssenza: TDateTimeField
      FieldName = 'HMAssenza'
      Visible = False
      OnGetText = selTabellaHMAssenzaGetText
      OnSetText = selTabellaHMAssenzaSetText
      DisplayFormat = 'hh:nn'
    end
    object T265Stampa: TStringField
      DisplayLabel = 'Stampa su cartellino'
      FieldName = 'Stampa'
      Required = True
      Size = 1
    end
    object T265GSignific: TStringField
      DisplayLabel = 'Giorni significativit'#224
      FieldName = 'GSignific'
      Size = 2
    end
    object T265Fruibile: TStringField
      FieldName = 'Fruibile'
      Size = 1
    end
    object T265MaturFerie: TStringField
      DisplayLabel = 'Maturaz. ferie'
      FieldName = 'MaturFerie'
      Size = 1
    end
    object T265AValidAss: TFloatField
      FieldName = 'AValidAss'
      Visible = False
    end
    object selTabellaHMaxUnitario: TStringField
      FieldName = 'HMaxUnitario'
      Visible = False
      OnValidate = BDET265HMaxUnitarioValidate
      Size = 7
    end
    object selTabellaGMaxUnitario: TStringField
      FieldName = 'GMaxUnitario'
      Visible = False
      OnValidate = BDET265GMaxUnitarioValidate
      Size = 6
    end
    object selTabellaUM_INSERIMENTO: TStringField
      DisplayLabel = 'Giornate'
      FieldName = 'UM_INSERIMENTO'
      Size = 1
    end
    object selTabellaUM_INSERIMENTO_MG: TStringField
      DisplayLabel = '1/2 giornate'
      FieldName = 'UM_INSERIMENTO_MG'
      Size = 1
    end
    object selTabellaUM_INSERIMENTO_H: TStringField
      DisplayLabel = 'Num. ore'
      FieldName = 'UM_INSERIMENTO_H'
      Size = 1
    end
    object selTabellaUM_INSERIMENTO_D: TStringField
      DisplayLabel = 'Da ore a ore'
      FieldName = 'UM_INSERIMENTO_D'
      Size = 1
    end
    object selTabellaTipoCumulo: TStringField
      DisplayLabel = 'Tipo cumulo'
      FieldName = 'TipoCumulo'
      Required = True
      Size = 1
    end
    object selTabellaUMisura: TStringField
      DisplayLabel = 'Unit'#224' di misura'
      FieldName = 'UMisura'
      Size = 1
    end
    object selTabellaCompetenza1: TStringField
      DisplayLabel = 'Comp. fascia 1'
      FieldName = 'Competenza1'
      OnValidate = BDET265Competenza1Validate
      Size = 7
    end
    object selTabellaRetribuzione1: TFloatField
      FieldName = 'Retribuzione1'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza2: TStringField
      FieldName = 'Competenza2'
      Visible = False
      OnValidate = BDET265Competenza1Validate
      Size = 7
    end
    object selTabellaRetribuzione2: TFloatField
      FieldName = 'Retribuzione2'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza3: TStringField
      FieldName = 'Competenza3'
      Visible = False
      OnValidate = BDET265Competenza1Validate
      Size = 7
    end
    object selTabellaRetribuzione3: TFloatField
      FieldName = 'Retribuzione3'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza4: TStringField
      FieldName = 'Competenza4'
      Visible = False
      OnValidate = BDET265Competenza1Validate
      Size = 7
    end
    object selTabellaRetribuzione4: TFloatField
      FieldName = 'Retribuzione4'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza5: TStringField
      FieldName = 'Competenza5'
      Visible = False
      OnValidate = BDET265Competenza1Validate
      Size = 7
    end
    object selTabellaRetribuzione5: TFloatField
      FieldName = 'Retribuzione5'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaCompetenza6: TStringField
      FieldName = 'Competenza6'
      Visible = False
      OnValidate = BDET265Competenza1Validate
      Size = 7
    end
    object selTabellaRetribuzione6: TFloatField
      FieldName = 'Retribuzione6'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaDurataCumulo: TFloatField
      FieldName = 'DurataCumulo'
      Visible = False
    end
    object selTabellaUMCumulo: TStringField
      FieldName = 'UMCumulo'
      Visible = False
      Size = 1
    end
    object selTabellaGMCumulo: TStringField
      DisplayWidth = 5
      FieldName = 'GMCumulo'
      Visible = False
      OnValidate = BDET265GMCumuloValidate
      Size = 5
    end
    object selTabellaCodCauInizio: TStringField
      FieldName = 'CodCauInizio'
      Visible = False
      OnValidate = BDET265CodCauInizioValidate
      Size = 5
    end
    object selTabellaCodCau1: TStringField
      DisplayWidth = 20
      FieldName = 'CodCau1'
      Visible = False
      Size = 1000
    end
    object selTabellaCODCAU2: TStringField
      FieldName = 'CODCAU2'
      Visible = False
      Size = 1000
    end
    object selTabellaFruizione: TStringField
      FieldName = 'Fruizione'
      Visible = False
      Size = 1
    end
    object selTabellaDurataFruizione: TFloatField
      FieldName = 'DurataFruizione'
      Visible = False
    end
    object selTabellaUMFruizione: TStringField
      FieldName = 'UMFruizione'
      Visible = False
      Size = 1
    end
    object selTabellaCodCauFruizione: TStringField
      FieldName = 'CodCauFruizione'
      Visible = False
      Size = 5
    end
    object selTabellaD_CodCauInizio: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodCauInizio'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodCauInizio'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaD_CodCauFruizione: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodCauFruizione'
      LookupDataSet = A016FCausAssenzeMW.Q265A
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodCauFruizione'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaDETREPERIB: TStringField
      FieldName = 'DETREPERIB'
      Visible = False
      Size = 1
    end
    object selTabellaORESETT: TStringField
      FieldName = 'ORESETT'
      Visible = False
      OnValidate = selTabellaORESETTValidate
      Size = 5
    end
    object selTabellaASSTOLL: TStringField
      FieldName = 'ASSTOLL'
      Visible = False
      Size = 200
    end
    object selTabellaCUMULOGLOBALE: TStringField
      FieldName = 'CUMULOGLOBALE'
      Visible = False
      Size = 1
    end
    object selTabellaCAMPOGLOBALE: TStringField
      FieldName = 'CAMPOGLOBALE'
      Visible = False
    end
    object selTabellaRICORSIONE: TStringField
      FieldName = 'RICORSIONE'
      Visible = False
      Size = 1
    end
    object selTabellaVALSETIMB: TStringField
      FieldName = 'VALSETIMB'
      Visible = False
      Size = 1
    end
    object selTabellaNO_SUPERO_COMPETENZE: TStringField
      FieldName = 'NO_SUPERO_COMPETENZE'
      Visible = False
      Size = 1
    end
    object selTabellaREGISTRA_STORICO: TStringField
      FieldName = 'REGISTRA_STORICO'
      Visible = False
      Size = 1
    end
    object selTabellaALLUNGA_PROVA: TStringField
      FieldName = 'ALLUNGA_PROVA'
      Visible = False
      Size = 1
    end
    object selTabellaOFFSET_FRUIZIONE: TIntegerField
      FieldName = 'OFFSET_FRUIZIONE'
      Visible = False
    end
    object selTabellaFRUIZIONE_FAMILIARI: TStringField
      FieldName = 'FRUIZIONE_FAMILIARI'
      Visible = False
      Size = 1
    end
    object selTabellaCUMULO_FAMILIARI: TStringField
      FieldName = 'CUMULO_FAMILIARI'
      Visible = False
      Size = 1
    end
    object selTabellaTEMPO_DETERMINATO: TStringField
      FieldName = 'TEMPO_DETERMINATO'
      Visible = False
      Size = 1
    end
    object selTabellaPROPORZIONA_PERSERV: TStringField
      FieldName = 'PROPORZIONA_PERSERV'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_PROPORZIONE: TStringField
      FieldName = 'TIPO_PROPORZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaPARTTIME: TStringField
      FieldName = 'PARTTIME'
      Visible = False
      Size = 3
    end
    object selTabellaTIPORECUPERO: TStringField
      FieldName = 'TIPORECUPERO'
      Visible = False
      Size = 2
    end
    object selTabellaESCLUSIONE: TStringField
      FieldName = 'ESCLUSIONE'
      Visible = False
      Size = 1
    end
    object selTabellaRECUPEROFESTIVO: TStringField
      FieldName = 'RECUPEROFESTIVO'
      Visible = False
      Size = 1
    end
    object selTabellaFRUIZ_MIN: TStringField
      FieldName = 'FRUIZ_MIN'
      Visible = False
      OnValidate = T265FRUIZ_MINValidate
      Size = 5
    end
    object selTabellaFRUIZ_ARR: TStringField
      FieldName = 'FRUIZ_ARR'
      Visible = False
      OnValidate = T265FRUIZ_MINValidate
      Size = 5
    end
    object selTabellaFRUIZ_MAX_DEBITO: TStringField
      FieldName = 'FRUIZ_MAX_DEBITO'
      Visible = False
      Size = 1
    end
    object selTabellaFLESSIBILITA_ORARIO: TStringField
      FieldName = 'FLESSIBILITA_ORARIO'
      Visible = False
      Size = 1
    end
    object selTabellaCQ_PROGRESSIVO: TStringField
      FieldName = 'CQ_PROGRESSIVO'
      Visible = False
      Size = 1
    end
    object selTabellaCQ_FESTIVI: TStringField
      FieldName = 'CQ_FESTIVI'
      Visible = False
      Size = 1
    end
    object selTabellaCQ_GGNONLAV: TStringField
      FieldName = 'CQ_GGNONLAV'
      Visible = False
      Size = 1
    end
    object selTabellaPERC_INAIL: TFloatField
      FieldName = 'PERC_INAIL'
      Visible = False
      MaxValue = 100.000000000000000000
    end
    object selTabellaFRUIZCOMPETENZE_ARR: TStringField
      DisplayWidth = 1
      FieldName = 'FRUIZCOMPETENZE_ARR'
      Visible = False
      Size = 1
    end
    object selTabellaINTERSEZIONE_TIMBRATURE: TStringField
      FieldName = 'INTERSEZIONE_TIMBRATURE'
      Visible = False
      Size = 1
    end
    object selTabellaPROPORZIONA_ABILITAZIONE: TStringField
      FieldName = 'PROPORZIONA_ABILITAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaCP_DOMENICHE: TStringField
      FieldName = 'CP_DOMENICHE'
      Visible = False
      Size = 1
    end
    object selTabellaCP_PIANIFREPER: TStringField
      FieldName = 'CP_PIANIFREPER'
      Visible = False
      Size = 1
    end
    object selTabellaCP_FESTGIUSTIF: TStringField
      FieldName = 'CP_FESTGIUSTIF'
      Visible = False
      Size = 1
    end
    object selTabellaABBATTE_STRIND: TStringField
      FieldName = 'ABBATTE_STRIND'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM: TStringField
      FieldName = 'TIMB_PM'
      Visible = False
      OnChange = BDET265CodCauInizioValidate
      Size = 1
    end
    object selTabellaCUMULO_TIPO_ORE: TStringField
      FieldName = 'CUMULO_TIPO_ORE'
      Visible = False
      Size = 1
    end
    object selTabellaCM_DEBSETT: TStringField
      FieldName = 'CM_DEBSETT'
      Visible = False
      OnValidate = T265CM_DEBSETTValidate
      Size = 5
    end
    object selTabellaVALIDAZIONE: TStringField
      FieldName = 'VALIDAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaVISITA_FISCALE: TStringField
      FieldName = 'VISITA_FISCALE'
      Visible = False
      Size = 1
    end
    object selTabellaSCARICOPAGHE_UM_PROP: TStringField
      FieldName = 'SCARICOPAGHE_UM_PROP'
      Visible = False
      Size = 1
    end
    object selTabellaPERIODO_LUNGO: TStringField
      FieldName = 'PERIODO_LUNGO'
      Visible = False
      Size = 1
    end
    object selTabellaCOPRI_GGNONLAV: TStringField
      FieldName = 'COPRI_GGNONLAV'
      Visible = False
      Size = 1
    end
    object selTabellaRAPPORTI_UNITI: TStringField
      FieldName = 'RAPPORTI_UNITI'
      Visible = False
      Size = 1
    end
    object selTabellaMATERNITA_OBBL: TStringField
      FieldName = 'MATERNITA_OBBL'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_DETRAZ: TStringField
      FieldName = 'TIMB_PM_DETRAZ'
      Visible = False
      Size = 1
    end
    object selTabellaCUMULA_RICHIESTE_WEB: TStringField
      FieldName = 'CUMULA_RICHIESTE_WEB'
      Visible = False
      Size = 1
    end
    object selTabellaUM_SCARICOPAGHE: TStringField
      FieldName = 'UM_SCARICOPAGHE'
      Visible = False
      Size = 1
    end
    object selTabellaFRUIZ_MAX: TStringField
      FieldName = 'FRUIZ_MAX'
      Visible = False
      OnValidate = T265FRUIZ_MINValidate
      Size = 5
    end
    object selTabellaCUMULO_FAM_GGDOPO: TStringField
      FieldName = 'CUMULO_FAM_GGDOPO'
      Visible = False
      Size = 1
    end
    object selTabellaFRUIZIONE_FAM_GGDOPO: TStringField
      FieldName = 'FRUIZIONE_FAM_GGDOPO'
      Visible = False
      Size = 1
    end
    object selTabellaGLAVINPS: TStringField
      FieldName = 'GLAVINPS'
      Visible = False
      Size = 1
    end
    object selTabellaFRUIZ_MAX_NUM: TIntegerField
      FieldName = 'FRUIZ_MAX_NUM'
      Visible = False
      MaxValue = 9999
    end
    object selTabellaALLARME_FRUIZIONE_CONTINUATIVA: TIntegerField
      FieldName = 'ALLARME_FRUIZIONE_CONTINUATIVA'
      Visible = False
    end
    object selTabellaDETREPERIB_TOTALE: TStringField
      FieldName = 'DETREPERIB_TOTALE'
      Visible = False
      Size = 1
    end
    object selTabellaNO_SUPERO_COMPETENZE_WEB: TStringField
      FieldName = 'NO_SUPERO_COMPETENZE_WEB'
      Visible = False
      Size = 1
    end
    object selTabellaCOMPETENZE_PERSONALIZZATE: TStringField
      FieldName = 'COMPETENZE_PERSONALIZZATE'
      Visible = False
      Size = 1
    end
    object selTabellaARROT_ORE2GG: TStringField
      FieldName = 'ARROT_ORE2GG'
      Visible = False
      Size = 1
    end
    object selTabellaSIGLA_CAUSALE: TStringField
      FieldName = 'SIGLA_CAUSALE'
      Visible = False
      Size = 5
    end
    object selTabellaABBATTE_GGSERV_TEMPODET: TStringField
      FieldName = 'ABBATTE_GGSERV_TEMPODET'
      Visible = False
      Size = 1
    end
    object selTabellaVARCOMP_FRUIZMMINTERI: TStringField
      FieldName = 'VARCOMP_FRUIZMMINTERI'
      Visible = False
      Size = 1
    end
    object selTabellaVARCOMP_FRUIZMMCONT: TIntegerField
      FieldName = 'VARCOMP_FRUIZMMCONT'
      Visible = False
      MaxValue = 999
    end
    object selTabellaMMCONT_VARCOMP: TIntegerField
      FieldName = 'MMCONT_VARCOMP'
      Visible = False
      MaxValue = 999
    end
    object selTabellaCOMPINDIV_CONIUGE_ESISTENTE: TIntegerField
      FieldName = 'COMPINDIV_CONIUGE_ESISTENTE'
      Visible = False
      MaxValue = 999
    end
    object selTabellaABBATTE_GGVALUTAZIONE: TStringField
      FieldName = 'ABBATTE_GGVALUTAZIONE'
      Visible = False
      Size = 1
    end
    object selTabellaARROT_COMPETENZE: TStringField
      FieldName = 'ARROT_COMPETENZE'
      Visible = False
      Size = 1
    end
    object selTabellaOREGG_MAX_INF6: TStringField
      FieldName = 'OREGG_MAX_INF6'
      Visible = False
      OnValidate = T265FRUIZ_MINValidate
      Size = 5
    end
    object selTabellaOREGG_MAX_SUP6: TStringField
      FieldName = 'OREGG_MAX_SUP6'
      Visible = False
      OnValidate = T265FRUIZ_MINValidate
      Size = 5
    end
    object selTabellaCOPRE_FASCIA_OBB: TStringField
      FieldName = 'COPRE_FASCIA_OBB'
      Visible = False
      Size = 1
    end
    object selTabellaPERIODO_CUMULO_PERSONALIZZATO: TStringField
      FieldName = 'PERIODO_CUMULO_PERSONALIZZATO'
      Visible = False
      Size = 1
    end
    object selTabellaC_CONTASOLARE: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_CONTASOLARE'
      Visible = False
      Size = 1
      Calculated = True
    end
    object selTabellaPROPPTVGG: TStringField
      FieldName = 'PROPPTVGG'
      Visible = False
      Size = 1
    end
    object selTabellaCT_MANTIENI_RESIDNEG: TStringField
      FieldName = 'CT_MANTIENI_RESIDNEG'
      Visible = False
      Size = 1
    end
    object selTabellaITER_ECCGG: TStringField
      FieldName = 'ITER_ECCGG'
      Visible = False
      Size = 1
    end
    object selTabellaFRUIZGG_NEUTRA: TStringField
      FieldName = 'FRUIZGG_NEUTRA'
      Visible = False
      Size = 1
    end
    object selTabellaITER_IGNORA_FINERAPPORTO: TStringField
      FieldName = 'ITER_IGNORA_FINERAPPORTO'
      Visible = False
      Size = 1
    end
    object selTabellaID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaCAUSALI_CUMULO_L133: TStringField
      FieldName = 'CAUSALI_CUMULO_L133'
      Size = 1000
    end
  end
end
