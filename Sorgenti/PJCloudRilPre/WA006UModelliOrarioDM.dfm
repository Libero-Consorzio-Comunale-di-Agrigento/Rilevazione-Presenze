inherited WA006FModelliOrarioDM: TWA006FModelliOrarioDM
  Height = 139
  Width = 305
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T020.*,ROWID FROM T020_ORARI T020 :ORDERBY')
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    OnFilterRecord = selTabellaFilterRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaTIPOORA: TStringField
      DisplayLabel = 'Tipo Orario'
      FieldName = 'TIPOORA'
      Required = True
      Size = 1
    end
    object selTabellaPERLAV: TStringField
      DisplayLabel = 'Per. lavorativo'
      FieldName = 'PERLAV'
      Required = True
      Size = 2
    end
    object selTabellaFRAZDEB: TStringField
      DisplayLabel = 'Fraz.debito'
      FieldName = 'FRAZDEB'
      Size = 1
    end
    object selTabellaNOTTEENTRATA: TStringField
      DisplayLabel = 'Notte su entrata'
      FieldName = 'NOTTEENTRATA'
      Size = 1
    end
    object selTabellaTIPOFLE: TStringField
      FieldName = 'TIPOFLE'
      Visible = False
      Size = 1
    end
    object selTabellaOBBLFAC: TStringField
      FieldName = 'OBBLFAC'
      Visible = False
      Size = 1
    end
    object selTabellaORETEOR: TStringField
      DisplayLabel = 'Ore teoriche'
      FieldName = 'ORETEOR'
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaORETEOR_GGASS: TStringField
      FieldName = 'ORETEOR_GGASS'
      Visible = False
      OnValidate = ValidateOreMinuti
      Size = 5
    end
    object selTabellaOREMIN: TStringField
      FieldName = 'OREMIN'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaOREMAX: TStringField
      FieldName = 'OREMAX'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaCOMPDETR: TStringField
      FieldName = 'COMPDETR'
      Visible = False
      Size = 1
    end
    object selTabellaARRFUOENT: TStringField
      FieldName = 'ARRFUOENT'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaARRFUOUSC: TStringField
      FieldName = 'ARRFUOUSC'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaARRPOS: TStringField
      FieldName = 'ARRPOS'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaARRNEG: TStringField
      FieldName = 'ARRNEG'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaTOLLPRES: TStringField
      FieldName = 'TOLLPRES'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaMMINDPRES: TStringField
      FieldName = 'MMINDPRES'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaFLAGPRES: TStringField
      DisplayLabel = 'Ind. presenza'
      FieldName = 'FLAGPRES'
      Size = 1
    end
    object selTabellaCOMPNOT: TStringField
      FieldName = 'COMPNOT'
      Visible = False
      Size = 1
    end
    object selTabellaMMINDMPRES: TStringField
      FieldName = 'MMINDMPRES'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaFLAGMPRES: TStringField
      FieldName = 'FLAGMPRES'
      Visible = False
      Size = 1
    end
    object selTabellaMIN_USCITA_NOTTE: TStringField
      FieldName = 'MIN_USCITA_NOTTE'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaINDFESTIVA: TStringField
      DisplayLabel = 'Ind.festiva'
      FieldName = 'INDFESTIVA'
      Size = 1
    end
    object selTabellaOREINDFEST: TStringField
      FieldName = 'OREINDFEST'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaINDTURNO: TStringField
      DisplayLabel = 'Ind.notturna'
      FieldName = 'INDTURNO'
      Size = 1
    end
    object selTabellaMATURA_RIPCOM: TStringField
      FieldName = 'MATURA_RIPCOM'
      Visible = False
      Size = 1
    end
    object selTabellaTIPOMENSA: TStringField
      DisplayLabel = 'Tipo mensa'
      FieldName = 'TIPOMENSA'
      Size = 1
    end
    object selTabellaCAUOBFAC: TStringField
      FieldName = 'CAUOBFAC'
      Visible = False
      Size = 1
    end
    object selTabellaMMMINIMI: TStringField
      FieldName = 'MMMINIMI'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaMINPERCORR: TStringField
      FieldName = 'MINPERCORR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaTIMBRATURAMENSA: TStringField
      FieldName = 'TIMBRATURAMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaINTERSEZIONEMENSA: TStringField
      FieldName = 'INTERSEZIONEMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaPAUSAMENSA_AUTOMATICA: TStringField
      FieldName = 'PAUSAMENSA_AUTOMATICA'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaPM_AUTO_URIT: TStringField
      FieldName = 'PM_AUTO_URIT'
      Visible = False
      Size = 1
    end
    object selTabellaDETRAUTCONT: TStringField
      FieldName = 'DETRAUTCONT'
      Visible = False
      Size = 1
    end
    object selTabellaRIENTRO_MINIMO: TStringField
      FieldName = 'RIENTRO_MINIMO'
      Visible = False
      Size = 5
    end
    object selTabellaCOMPFASCIA: TStringField
      FieldName = 'COMPFASCIA'
      Visible = False
      Size = 1
    end
    object selTabellaTUTTOCOMP: TStringField
      FieldName = 'TUTTOCOMP'
      Visible = False
      Size = 1
    end
    object selTabellaMINSCOSTR: TStringField
      FieldName = 'MINSCOSTR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaORAMAX_COMPENSABILE: TStringField
      FieldName = 'ORAMAX_COMPENSABILE'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaARRSCOSTR: TStringField
      FieldName = 'ARRSCOSTR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaARRSCOSTR_COMP: TStringField
      FieldName = 'ARRSCOSTR_COMP'
      Visible = False
      Size = 1
    end
    object selTabellaCOMPLIQ: TStringField
      FieldName = 'COMPLIQ'
      Visible = False
      Size = 1
    end
    object selTabellaMINIMISTR: TStringField
      FieldName = 'MINIMISTR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaARRIVRANG: TStringField
      FieldName = 'ARRIVRANG'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaMINGIOSTR: TStringField
      FieldName = 'MINGIOSTR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaARROTGIOR: TStringField
      FieldName = 'ARROTGIOR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaMAXGIOSTR: TStringField
      FieldName = 'MAXGIOSTR'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaINTERUSC: TStringField
      FieldName = 'INTERUSC'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaSTR_DOPO_HHMAX: TStringField
      FieldName = 'STR_DOPO_HHMAX'
      Visible = False
      Size = 1
    end
    object selTabellaINDPRESSTR: TStringField
      FieldName = 'INDPRESSTR'
      Visible = False
      Size = 1
    end
    object selTabellaINDFESTSTR: TStringField
      FieldName = 'INDFESTSTR'
      Visible = False
      Size = 1
    end
    object selTabellaINDNOTSTR: TStringField
      FieldName = 'INDNOTSTR'
      Visible = False
      Size = 1
    end
    object selTabellaCARENZA_OBB_NO_LIQ: TStringField
      FieldName = 'CARENZA_OBB_NO_LIQ'
      Visible = False
      Size = 1
    end
    object selTabellaRICALCOLO_DEBITO_GG: TStringField
      FieldName = 'RICALCOLO_DEBITO_GG'
      Visible = False
      Size = 1
    end
    object selTabellaRICALCOLO_MIN: TStringField
      FieldName = 'RICALCOLO_MIN'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaRICALCOLO_MAX: TStringField
      FieldName = 'RICALCOLO_MAX'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaARR_ECCED_LIQ: TStringField
      FieldName = 'ARR_ECCED_LIQ'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaPAUSAMENSA_ESTERNA: TStringField
      FieldName = 'PAUSAMENSA_ESTERNA'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaREGOLE_PROFILO: TStringField
      FieldName = 'REGOLE_PROFILO'
      Visible = False
      Size = 1
    end
    object selTabellaECC_COMP_CAUSALIZZATA: TStringField
      FieldName = 'ECC_COMP_CAUSALIZZATA'
      Visible = False
      Size = 1
    end
    object selTabellaSTRRIPFASCE: TStringField
      FieldName = 'STRRIPFASCE'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaCOPERTURA_CARENZA: TStringField
      FieldName = 'COPERTURA_CARENZA'
      Visible = False
      Size = 1
    end
    object selTabellaARR_ECCED_FASCE: TStringField
      FieldName = 'ARR_ECCED_FASCE'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaARROT_COMP: TStringField
      FieldName = 'ARROT_COMP'
      Visible = False
      Size = 1
    end
    object selTabellaARR_TIMB_INTERNE: TStringField
      FieldName = 'ARR_TIMB_INTERNE'
      Visible = False
      Size = 1
    end
    object selTabellaARR_ECC_FASCE_COMP: TStringField
      FieldName = 'ARR_ECC_FASCE_COMP'
      Visible = False
      Size = 1
    end
    object selTabellaPM_RECUP_USCITA: TStringField
      FieldName = 'PM_RECUP_USCITA'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaTIMBRATURAMENSA_INTERNA: TStringField
      FieldName = 'TIMBRATURAMENSA_INTERNA'
      Visible = False
      Size = 1
    end
    object selTabellaPMT_TIMB_AUTORIZZATE: TStringField
      FieldName = 'PMT_TIMB_AUTORIZZATE'
      Visible = False
      Size = 1
    end
    object selTabellaPMA_PRESERVA_TIMBINFASCIA: TStringField
      FieldName = 'PMA_PRESERVA_TIMBINFASCIA'
      Visible = False
      Size = 1
    end
    object selTabellaSCOSTGG_MIN_SOGLIA: TStringField
      FieldName = 'SCOSTGG_MIN_SOGLIA'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaPMT_TOLLERANZA: TStringField
      FieldName = 'PMT_TOLLERANZA'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaDEBITO_RIPCOM: TStringField
      FieldName = 'DEBITO_RIPCOM'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaTIMBRATURAMENSA_DETRAZIONE: TStringField
      FieldName = 'TIMBRATURAMENSA_DETRAZIONE'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaPMT_TIMB_MATURAMENSA: TStringField
      FieldName = 'PMT_TIMB_MATURAMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaPMT_SOLO_TIMBMENSA: TStringField
      FieldName = 'PMT_SOLO_TIMBMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaTIMBRATURAMENSA_DETRTOT: TStringField
      FieldName = 'TIMBRATURAMENSA_DETRTOT'
      Visible = False
      Size = 1
    end
    object selTabellaPM_OREMINIME_INF: TStringField
      FieldName = 'PM_OREMINIME_INF'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaPM_STACCO_INF: TStringField
      FieldName = 'PM_STACCO_INF'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaMINIMISTR_COMP: TStringField
      FieldName = 'MINIMISTR_COMP'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALE_FASCE: TStringField
      FieldName = 'CAUSALE_FASCE'
      Visible = False
      Size = 5
    end
    object selTabellaD_CAUSALE_FASCE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_FASCE'
      LookupDataSet = A006FModelliOrarioMW.selT276
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE_FASCE'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaRICALCOLO_SPOSTA_PN: TStringField
      FieldName = 'RICALCOLO_SPOSTA_PN'
      Visible = False
      Size = 1
    end
    object selTabellaRICALCOLO_OFF_NOTIMB: TStringField
      FieldName = 'RICALCOLO_OFF_NOTIMB'
      Visible = False
      Size = 1
    end
    object selTabellaRICALCOLO_DEB_MIN: TStringField
      FieldName = 'RICALCOLO_DEB_MIN'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaRICALCOLO_DEB_MAX: TStringField
      FieldName = 'RICALCOLO_DEB_MAX'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaRICALCOLO_CAUS_NEG: TStringField
      FieldName = 'RICALCOLO_CAUS_NEG'
      Visible = False
      Size = 5
    end
    object selTabellaRICALCOLO_CAUS_POS: TStringField
      FieldName = 'RICALCOLO_CAUS_POS'
      Visible = False
      Size = 5
    end
    object selTabellaPMT_LIMITE_FLEX: TStringField
      FieldName = 'PMT_LIMITE_FLEX'
      Visible = False
      Size = 1
    end
    object selTabellaTIMBRATURAMENSA_FLEX: TStringField
      FieldName = 'TIMBRATURAMENSA_FLEX'
      Visible = False
      Size = 1
    end
    object selTabellaXPARAM: TStringField
      FieldName = 'XPARAM'
      ReadOnly = True
      Visible = False
      Size = 500
    end
    object selTabellaXPARAM_COMP_OLDVERS: TStringField
      FieldName = 'XPARAM_COMP_OLDVERS'
      ReadOnly = True
      Visible = False
      Size = 1000
    end
    object selTabellaSPEZZNONCAUS_SCARTOECC: TStringField
      FieldName = 'SPEZZNONCAUS_SCARTOECC'
      Visible = False
      Size = 1
    end
    object selTabellaFLEXDOPOMEZZANOTTE: TStringField
      FieldName = 'FLEXDOPOMEZZANOTTE'
      Visible = False
      Size = 1
    end
    object selTabellaINTERSEZ_AUTOGIUST: TStringField
      FieldName = 'INTERSEZ_AUTOGIUST'
      Visible = False
      Size = 1
    end
    object selTabellaRIPCOM_GGNONLAV: TStringField
      FieldName = 'RIPCOM_GGNONLAV'
      Visible = False
      Size = 1
    end
    object selTabellaPMT_STACCOMIN: TStringField
      FieldName = 'PMT_STACCOMIN'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaPMT_USCITARIT: TStringField
      FieldName = 'PMT_USCITARIT'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_ECCEDENZA: TStringField
      FieldName = 'CAUSALI_ECCEDENZA'
      Visible = False
    end
    object selTabellaARRSCOSTR_SOTTOSOGLIA: TStringField
      FieldName = 'ARRSCOSTR_SOTTOSOGLIA'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!#0:00;1;_'
      Size = 5
    end
    object selTabellaRIENTRO_POMERIDIANO: TStringField
      FieldName = 'RIENTRO_POMERIDIANO'
      Visible = False
      Size = 1
    end
    object selTabellaFESTLAV_LIQ: TStringField
      FieldName = 'FESTLAV_LIQ'
      Visible = False
      Size = 5
    end
    object selTabellaD_FESTLAV_LIQ: TStringField
      FieldKind = fkLookup
      FieldName = 'D_FESTLAV_LIQ'
      LookupDataSet = A006FModelliOrarioMW.selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'FESTLAV_LIQ'
      Visible = False
      Size = 50
      Lookup = True
    end
    object selTabellaFESTLAV_CMP_LIQ: TStringField
      FieldName = 'FESTLAV_CMP_LIQ'
      Visible = False
      Size = 5
    end
    object selTabellaD_FESTLAV_CMP_LIQ: TStringField
      FieldKind = fkLookup
      FieldName = 'D_FESTLAV_CMP_LIQ'
      LookupDataSet = A006FModelliOrarioMW.selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'FESTLAV_CMP_LIQ'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaFESTLAV_CMP_LIQ_TURN: TStringField
      FieldName = 'FESTLAV_CMP_LIQ_TURN'
      Visible = False
      Size = 5
    end
    object selTabellaD_FESTLAV_CMP_LIQ_TURN: TStringField
      FieldKind = fkLookup
      FieldName = 'D_FESTLAV_CMP_LIQ_TURN'
      LookupDataSet = A006FModelliOrarioMW.selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'FESTLAV_CMP_LIQ_TURN'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCAUSALE_DISABIL_BLOCCANTE: TStringField
      FieldName = 'CAUSALE_DISABIL_BLOCCANTE'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALE_INIZIOORARIO: TStringField
      FieldName = 'CAUSALE_INIZIOORARIO'
      Visible = False
      Size = 5
    end
    object selTabellaCAUSALE_FINEORARIO: TStringField
      FieldName = 'CAUSALE_FINEORARIO'
      Visible = False
      Size = 5
    end
    object selTabellaMINUTICAUS_INIZIOORARIO: TStringField
      FieldName = 'MINUTICAUS_INIZIOORARIO'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaMINUTICAUS_FINEORARIO: TStringField
      FieldName = 'MINUTICAUS_FINEORARIO'
      Visible = False
      OnValidate = ValidateOreMinuti
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaTURNI_INIZIOORARIO: TStringField
      FieldName = 'TURNI_INIZIOORARIO'
      Visible = False
      Size = 50
    end
    object selTabellaTURNI_FINEORARIO: TStringField
      FieldName = 'TURNI_FINEORARIO'
      Visible = False
      Size = 50
    end
    object selTabellaMINUTICAUS_PRIORITARI: TStringField
      FieldName = 'MINUTICAUS_PRIORITARI'
      Visible = False
      Size = 1
    end
    object selTabellaRIPCOM_DEBITOGG: TStringField
      FieldName = 'RIPCOM_DEBITOGG'
      Visible = False
      Size = 1
    end
    object selTabellaMMINDPRESMAG: TStringField
      FieldName = 'MMINDPRESMAG'
      Visible = False
      Size = 5
    end
    object selTabellaCOEFF_INDPRESMAG: TFloatField
      FieldName = 'COEFF_INDPRESMAG'
      Visible = False
    end
    object selTabellaFESTLAV_GGSETT: TStringField
      FieldName = 'FESTLAV_GGSETT'
      Visible = False
      Size = 1
    end
    object selTabellaCAUS_RIDUZPN: TStringField
      FieldName = 'CAUS_RIDUZPN'
      Visible = False
      Size = 100
    end
    object selTabellaCAUS_RIDUZPN_CHECKPMT: TStringField
      FieldName = 'CAUS_RIDUZPN_CHECKPMT'
      Visible = False
      Size = 100
    end
    object selTabellaPMT_TIMBRATURAMENSA: TStringField
      FieldName = 'PMT_TIMBRATURAMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaPMT_NOOREMIN_TIMBMENSA: TStringField
      FieldName = 'PMT_NOOREMIN_TIMBMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaFASCIA_NOTTFEST_COMPLETA: TStringField
      FieldName = 'FASCIA_NOTTFEST_COMPLETA'
      Visible = False
      Size = 1
    end
    object selTabellaINDFESTIVA_USA_NOTTE_COMPLETA: TStringField
      FieldName = 'INDFESTIVA_USA_NOTTE_COMPLETA'
      Visible = False
      Size = 1
    end
    object selTabellaDETRAZ_RIEPPR_NORM: TStringField
      FieldName = 'DETRAZ_RIEPPR_NORM'
      Visible = False
      Size = 2
    end
    object selTabellaORARI_SCAMBIO: TStringField
      FieldName = 'ORARI_SCAMBIO'
      Visible = False
      Size = 2000
    end
    object selTabellaSTR_NOTTE_SPEZZATO: TStringField
      FieldName = 'STR_NOTTE_SPEZZATO'
      Visible = False
      Size = 1
    end
    object selTabellaDETRAZ_PARZ_STACCO_INF: TStringField
      FieldName = 'DETRAZ_PARZ_STACCO_INF'
      Visible = False
      Size = 1
    end
    object selTabellaANOM_BLOCC_23LIV: TStringField
      FieldName = 'ANOM_BLOCC_23LIV'
      Visible = False
      Size = 1000
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
