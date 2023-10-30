inherited WS031FFamiliariDM: TWS031FFamiliariDM
  Height = 402
  Width = 532
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG101.*,SG101.ROWID,'
      
        '  DECODE(GRADOPAR, '#39'NS'#39','#39'Nessuno/S'#232' stesso'#39', '#39'CG'#39','#39'Coniuge'#39', '#39'FG' +
        #39','#39'Figlio/Figlia'#39', '#39'GT'#39','#39'Genitore'#39','
      
        '                   '#39'FR'#39','#39'Fratello/Sorella'#39', '#39'NP'#39','#39'Nipote'#39', '#39'NF'#39',' +
        #39'Nipote equiparato figlio'#39', '#39'AL'#39','#39'Altro'#39', '#39'AF'#39', '#39'Affidato'#39', '
      
        '                   '#39'UC'#39', '#39'Unito civilmente'#39', '#39'CF'#39', '#39'Convivente d' +
        'i fatto'#39') D_GRADOPAR,'
      
        '  DECODE(TIPO_DETRAZIONE, '#39'ND'#39','#39'Nessuna'#39', '#39'DC'#39','#39'Coniuge'#39', '#39'DF'#39','#39 +
        'Figlio'#39', '#39'DA'#39','#39'Altri'#39') D_DETRAZIONE,'
      '  DECODE(TIPOPAR, '#39'P'#39','#39'Parente'#39', '#39'A'#39','#39'Affine'#39') D_TIPOPAR,'
      
        '  DECODE(TIPO_DISABILITA, '#39'1'#39','#39'Rivedibile'#39', '#39'2'#39','#39'Non rivedibile'#39 +
        ', '#39'3'#39','#39'Provvisorio'#39') D_DISABILITA,'
      
        '  DECODE(GRADOPAR, '#39'NS'#39','#39'Nessuno/S'#232' stesso'#39', '#39'CG'#39','#39'Coniuge'#39', '#39'FG' +
        #39','#39'Figlio/Figlia'#39', '#39'GT'#39','#39'Genitore'#39','
      
        '                   '#39'FR'#39','#39'Fratello/Sorella'#39', '#39'NP'#39','#39'Nipote'#39', '#39'NF'#39',' +
        #39'Nipote equiparato figlio'#39', '#39'AL'#39','#39'Altro'#39', '#39'AF'#39', '#39'Affidato'#39', '
      
        '                   '#39'UC'#39', '#39'Unito civilmente'#39', '#39'CF'#39', '#39'Convivente d' +
        'i fatto'#39')||'#39' '#39'||COGNOME||'#39' '#39'||NOME D_FAMILIARE,'
      '  DECODE(COMPONENTE_ANF,'#39'S'#39','#39'Si'#39','#39'N'#39','#39'No'#39') D_ANF,'
      '  DECODE(INABILE_ANF,'#39'S'#39','#39'Si'#39','#39'N'#39','#39'No'#39') D_INABILE'
      '  FROM SG101_FAMILIARI SG101'
      ' WHERE SG101.PROGRESSIVO = :PROGRESSIVO'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000003F00000016000000500052004F004700520045005300530049005600
      4F000100000000000C0000004E0055004D004F00520044000100000000001400
      00004400450043004F005200520045004E005A0041000100000000000E000000
      43004F0047004E004F004D004500010000000000080000004E004F004D004500
      0100000000000C00000043004F004D004E00410053000100000000000E000000
      44004100540041004E0041005300010000000000100000004700520041004400
      4F005000410052000100000000001E0000005400490050004F005F0044004500
      5400520041005A0049004F004E00450001000000000016000000500045005200
      43005F00430041005200490043004F000100000000000E000000440041005400
      41004D00410054000100000000000E0000004400410054004100530045005000
      0100000000002800000044004500540052005F004600490047004C0049004F00
      5F00480041004E0044004900430041005000010000000000120000004D004100
      54005200490043004F004C004100010000000000100000004400410054004100
      410044004F005A000100000000000A00000053004500530053004F0001000000
      00001400000043004F004400460049005300430041004C004500010000000000
      1C00000043004F004D0050004F004E0045004E00540045005F0041004E004600
      010000000000160000005200450044004400490054004F005F0041004E004600
      010000000000220000005200450044004400490054004F005F0041004C005400
      52004F005F0041004E0046000100000000001800000053005000450043004900
      41004C0045005F0041004E0046000100000000001600000049004E0041004200
      49004C0045005F0041004E0046000100000000001E0000004400450043004F00
      5200520045004E005A0041005F00460049004E00450001000000000020000000
      44004100540041004E00410053005F00500052004500530055004E0054004100
      01000000000022000000430041005500530041004C0049005F00410042004900
      4C00490054004100540045000100000000000E0000004E004F004D0045005F00
      500041000100000000001200000049004E0044004900520049005A005A004F00
      0100000000000C00000043004F004D0055004E00450001000000000006000000
      43004100500001000000000010000000540045004C00450046004F004E004F00
      0100000000000C0000004300410050004E004100530001000000000020000000
      44004100540041005F0055004C0054005F00460041004D005F00430041005200
      010000000000100000004E0055004D0047005200410044004F00010000000000
      0E0000005400490050004F005000410052000100000000002A00000044004500
      540052005F004600490047004C0049004F005F003100300030005F0041004600
      460049004400010000000000080000004E004F00540045000100000000001200
      00004400550052004100540041005F0050004100010000000000100000004100
      4E004E004F005F004100560056000100000000001800000041004E004E004F00
      5F004100560056005F00460041004D000100000000001E000000540049005000
      4F005F004400490053004100420049004C004900540041000100000000001C00
      000041004E004E004F005F005200450056004900530049004F004E0045000100
      000000001C0000004D004F005400490056004F005F0047005200410044004F00
      5F0033000100000000001600000041004C005400450052004E00410054004900
      56004100010000000000160000004E004F004D0045005F00500041005F004100
      4C005400010000000000240000004D004F005400490056004F005F0047005200
      410044004F005F0033005F0041004C0054000100000000001E00000054004900
      50004F005F00410044004F005A005F0041004600460049004400010000000000
      2000000047005200410056005F0049004E0049005A0049004F005F0054004500
      4F0052000100000000002400000047005200410056005F0049004E0049005A00
      49004F005F005300430045004C00540041000100000000001E00000047005200
      410056005F0049004E0049005A0049004F005F00450046004600010000000000
      1200000047005200410056005F00460049004E00450001000000000018000000
      44004100540041005F00500052004500410044004F005A000100000000001400
      000044005F0047005200410044004F0050004100520001000000000018000000
      44005F00440045005400520041005A0049004F004E0045000100000000001200
      000044005F005400490050004F00500041005200010000000000180000004400
      5F004400490053004100420049004C0049005400410001000000000016000000
      44005F00460041004D0049004C0049004100520045000100000000000A000000
      44005F0041004E0046000100000000001200000044005F0049004E0041004200
      49004C0045000100000000000E0000004E0041005A0049004F004E0045000100
      00000000220000004D004F005400490056004F005F004500530043004C005500
      530049004F004E0045000100000000001E000000430041005200540041005F00
      490044005F004E0055004D00450052004F000100000000002200000043004100
      5200540041005F00490044005F0044004100540041005F00520049004C000100
      0000000024000000430041005200540041005F00490044005F00440041005400
      41005F005300430041004400010000000000}
    AfterOpen = selTabellaAfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object QSG101PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object QSG101NUMORD: TFloatField
      DisplayLabel = 'N.ordine'
      FieldName = 'NUMORD'
      Required = True
      MaxValue = 999.000000000000000000
    end
    object QSG101DECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaGRADOPAR: TStringField
      Alignment = taCenter
      DisplayLabel = 'Cod.parentela'
      DisplayWidth = 5
      FieldName = 'GRADOPAR'
      Visible = False
      Size = 2
    end
    object selTabellaD_GRADOPAR: TStringField
      DisplayLabel = 'Parentela'
      FieldKind = fkInternalCalc
      FieldName = 'D_GRADOPAR'
      ReadOnly = True
      Size = 24
    end
    object selTabellaTIPOPAR: TStringField
      DisplayLabel = 'Cod.tipo parentela'
      FieldName = 'TIPOPAR'
      Visible = False
      Size = 1
    end
    object selTabellaD_TIPOPAR: TStringField
      DisplayLabel = 'Tipo parentela'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPOPAR'
      ReadOnly = True
      Visible = False
      Size = 7
    end
    object selTabellaNUMGRADO: TStringField
      DisplayLabel = 'Grado'
      FieldName = 'NUMGRADO'
      Visible = False
      Size = 2
    end
    object selTabellaMOTIVO_GRADO_3: TStringField
      DisplayLabel = 'Motivo 3'#176' grado'
      FieldName = 'MOTIVO_GRADO_3'
      Visible = False
      Size = 1
    end
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Visible = False
      OnValidate = selTabellaMATRICOLAValidate
      Size = 8
    end
    object QSG101COGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 50
      FieldName = 'COGNOME'
      Size = 50
    end
    object QSG101NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object selTabellaSESSO: TStringField
      DisplayLabel = 'Sesso'
      FieldName = 'SESSO'
      Visible = False
      Size = 1
    end
    object selTabellaDATANAS_PRESUNTA: TDateTimeField
      DisplayLabel = 'Data presunta'
      FieldName = 'DATANAS_PRESUNTA'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selTabellaDATANAS: TDateTimeField
      DisplayLabel = 'Data nascita'
      FieldName = 'DATANAS'
      OnValidate = DataGenericaValidate
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selTabellaCOMNAS: TStringField
      DisplayLabel = 'Cod.comune nascita'
      FieldName = 'COMNAS'
      Visible = False
      Size = 6
    end
    object selTabellaD_DESCOMNAS: TStringField
      DisplayLabel = 'Comune nascita'
      FieldKind = fkLookup
      FieldName = 'D_DESCOMNAS'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMNAS'
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaCAPNAS: TStringField
      DisplayLabel = 'CAP nascita'
      FieldName = 'CAPNAS'
      Visible = False
      Size = 5
    end
    object selTabellaD_PROVINCIA: TStringField
      DisplayLabel = 'Prov.nascita'
      FieldKind = fkLookup
      FieldName = 'D_PROVINCIA'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMNAS'
      Visible = False
      Lookup = True
    end
    object selTabellaCODFISCALE: TStringField
      DisplayLabel = 'Cod.fiscale'
      FieldName = 'CODFISCALE'
      Visible = False
      Size = 16
    end
    object selTabellaDATA_PREADOZ: TDateTimeField
      DisplayLabel = 'Data pre-adozione'
      DisplayWidth = 10
      FieldName = 'DATA_PREADOZ'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATAADOZ: TDateTimeField
      DisplayLabel = 'Data adozione'
      FieldName = 'DATAADOZ'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'dd/mm/yyyy hh.nn'
      EditMask = '!00/00/0000 09:00;1;_'
    end
    object selTabellaTIPO_ADOZ_AFFID: TStringField
      DisplayLabel = 'Tipo adozione/affidamento'
      FieldName = 'TIPO_ADOZ_AFFID'
      Visible = False
      Size = 1
    end
    object selTabellaDATASEP: TDateTimeField
      DisplayLabel = 'Data esclusione'
      DisplayWidth = 10
      FieldName = 'DATASEP'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATAMAT: TDateTimeField
      DisplayLabel = 'Data matrimonio'
      DisplayWidth = 10
      FieldName = 'DATAMAT'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaGRAV_INIZIO_TEOR: TDateTimeField
      DisplayLabel = 'Inizio teorico gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_INIZIO_TEOR'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaGRAV_INIZIO_SCELTA: TDateTimeField
      DisplayLabel = 'Inizio scelto dal dip. gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_INIZIO_SCELTA'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaGRAV_INIZIO_EFF: TDateTimeField
      DisplayLabel = 'Inizio effettivo gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_INIZIO_EFF'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaGRAV_FINE: TDateTimeField
      DisplayLabel = 'Fine effettiva gravidanza'
      DisplayWidth = 10
      FieldName = 'GRAV_FINE'
      Visible = False
      OnValidate = DataGenericaValidate
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCAUSALI_ABILITATE: TStringField
      DisplayLabel = 'Causali fruibili'
      FieldName = 'CAUSALI_ABILITATE'
      Visible = False
      Size = 2000
    end
    object selTabellaTIPO_DETRAZIONE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Cod.tipo detrazione'
      FieldName = 'TIPO_DETRAZIONE'
      Visible = False
      Size = 2
    end
    object selTabellaD_DETRAZIONE: TStringField
      DisplayLabel = 'Tipo detrazione'
      FieldKind = fkInternalCalc
      FieldName = 'D_DETRAZIONE'
      ReadOnly = True
      Size = 7
    end
    object selTabellaPERC_CARICO: TFloatField
      DisplayLabel = '% carico'
      FieldName = 'PERC_CARICO'
      DisplayFormat = '000.00'
      MaxValue = 100.000000000000000000
      Precision = 4
    end
    object selTabellaDETR_FIGLIO_HANDICAP: TStringField
      DisplayLabel = 'Figlio handicap'
      FieldName = 'DETR_FIGLIO_HANDICAP'
      Visible = False
      Size = 1
    end
    object selTabellaDETR_FIGLIO_100_AFFID: TStringField
      DisplayLabel = 'Detr. 100% affid.figlio'
      FieldName = 'DETR_FIGLIO_100_AFFID'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_ULT_FAM_CAR: TDateTimeField
      DisplayLabel = 'Data ultima dichiarazione'
      FieldName = 'DATA_ULT_FAM_CAR'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCOMPONENTE_ANF: TStringField
      Alignment = taCenter
      DisplayLabel = 'Componente nucleo'
      FieldName = 'COMPONENTE_ANF'
      Visible = False
      Size = 1
    end
    object selTabellaD_ANF: TStringField
      Alignment = taCenter
      DisplayLabel = 'Componente nucleo'
      FieldKind = fkInternalCalc
      FieldName = 'D_ANF'
      ReadOnly = True
      Size = 2
    end
    object selTabellaSPECIALE_ANF: TStringField
      DisplayLabel = 'Studente/Apprendista'
      FieldName = 'SPECIALE_ANF'
      Visible = False
      Size = 1
    end
    object selTabellaINABILE_ANF: TStringField
      DisplayLabel = 'Inabile'
      FieldName = 'INABILE_ANF'
      Visible = False
      Size = 1
    end
    object selTabellaD_INABILE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Inabile'
      FieldKind = fkInternalCalc
      FieldName = 'D_INABILE'
      ReadOnly = True
      Size = 2
    end
    object selTabellaREDDITO_ANF: TFloatField
      DisplayLabel = 'Reddito lav.dip.'
      FieldName = 'REDDITO_ANF'
      Visible = False
    end
    object selTabellaREDDITO_ALTRO_ANF: TFloatField
      DisplayLabel = 'Altri redditi'
      FieldName = 'REDDITO_ALTRO_ANF'
      Visible = False
    end
    object selTabellaTIPO_DISABILITA: TStringField
      DisplayLabel = 'Cod.disabilit'#224
      FieldName = 'TIPO_DISABILITA'
      Visible = False
      Size = 1
    end
    object selTabellaD_DISABILITA: TStringField
      DisplayLabel = 'Disabilit'#224
      FieldKind = fkInternalCalc
      FieldName = 'D_DISABILITA'
      ReadOnly = True
      Visible = False
      Size = 14
    end
    object selTabellaANNO_REVISIONE: TDateTimeField
      DisplayLabel = 'Data revisione'
      DisplayWidth = 10
      FieldName = 'ANNO_REVISIONE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaANNO_AVV: TFloatField
      DisplayLabel = 'Anno avv.'
      FieldName = 'ANNO_AVV'
      Visible = False
    end
    object selTabellaANNO_AVV_FAM: TFloatField
      DisplayLabel = 'Anno avv.fam.'
      FieldName = 'ANNO_AVV_FAM'
      Visible = False
    end
    object selTabellaINDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      FieldName = 'INDIRIZZO'
      Visible = False
      Size = 40
    end
    object selTabellaCOMUNE: TStringField
      DisplayLabel = 'Cod.comune'
      FieldName = 'COMUNE'
      Visible = False
      Size = 6
    end
    object selTabellaDesc_Comune: TStringField
      DisplayLabel = 'Comune'
      FieldKind = fkLookup
      FieldName = 'Desc_Comune'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COMUNE'
      Visible = False
      Size = 100
      Lookup = True
    end
    object selTabellaCAP: TStringField
      FieldName = 'CAP'
      Visible = False
      Size = 5
    end
    object selTabellaProv_Comune: TStringField
      DisplayLabel = 'Prov.comune'
      FieldKind = fkLookup
      FieldName = 'Prov_Comune'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'PROVINCIA'
      KeyFields = 'COMUNE'
      Visible = False
      Size = 5
      Lookup = True
    end
    object selTabellaTELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Visible = False
      Size = 15
    end
    object selTabellaNOME_PA: TStringField
      DisplayLabel = 'Denominazione P.A.'
      FieldName = 'NOME_PA'
      Visible = False
      Size = 100
    end
    object selTabellaDURATA_PA: TStringField
      DisplayLabel = 'Durata contratto'
      FieldName = 'DURATA_PA'
      Visible = False
      Size = 1
    end
    object selTabellaALTERNATIVA: TStringField
      DisplayLabel = 'Tipo soggetto alternativa'
      FieldName = 'ALTERNATIVA'
      Visible = False
      Size = 1
    end
    object selTabellaMOTIVO_GRADO_3_ALT: TStringField
      DisplayLabel = 'Motivo 3'#176' grado alternativa'
      FieldName = 'MOTIVO_GRADO_3_ALT'
      Visible = False
      Size = 1
    end
    object selTabellaNOME_PA_ALT: TStringField
      DisplayLabel = 'Denominazione P.A. alternativa'
      FieldName = 'NOME_PA_ALT'
      Visible = False
      Size = 100
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Visible = False
      Size = 2000
    end
    object selTabellaD_CAP: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAP'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMUNE'
      Visible = False
      Size = 5
      Lookup = True
    end
    object selTabellaD_CAPNAS: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAPNAS'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CAP'
      KeyFields = 'COMNAS'
      Visible = False
      Size = 5
      Lookup = True
    end
    object selTabellaD_CODCATASTALE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODCATASTALE'
      LookupDataSet = S031FFamiliariMW.Q480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CODCATASTALE'
      KeyFields = 'COMNAS'
      Visible = False
      Size = 10
      Lookup = True
    end
    object selTabellaD_FAMILIARE: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'D_FAMILIARE'
      ReadOnly = True
      Visible = False
      Size = 86
    end
    object selTabellaNAZIONE: TStringField
      DisplayLabel = 'Nazionalit'#224
      FieldName = 'NAZIONE'
      Visible = False
      Size = 3
    end
    object selTabellaMOTIVO_ESCLUSIONE: TStringField
      DisplayLabel = 'Motivo esclusione'
      FieldName = 'MOTIVO_ESCLUSIONE'
      Visible = False
      Size = 1
    end
    object selTabellaCARTA_ID_NUMERO: TStringField
      DisplayLabel = 'Numero carta identit'#224
      FieldName = 'CARTA_ID_NUMERO'
      Visible = False
    end
    object selTabellaCARTA_ID_DATA_RIL: TDateTimeField
      DisplayLabel = 'Data rilascio carta identit'#224
      DisplayWidth = 10
      FieldName = 'CARTA_ID_DATA_RIL'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaCARTA_ID_DATA_SCAD: TDateTimeField
      DisplayLabel = 'Data scadenza carta identit'#224
      DisplayWidth = 10
      FieldName = 'CARTA_ID_DATA_SCAD'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaINSERIMENTO_CU: TStringField
      DisplayLabel = 'Inserimento su modello CU'
      FieldName = 'INSERIMENTO_CU'
      Visible = False
      Size = 1
    end
    object selTabellaPASSAPORTO_NUMERO: TStringField
      FieldName = 'PASSAPORTO_NUMERO'
      Visible = False
    end
    object selTabellaPASSAPORTO_DATA_RIL: TDateTimeField
      FieldName = 'PASSAPORTO_DATA_RIL'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaPASSAPORTO_DATA_SCAD: TDateTimeField
      FieldName = 'PASSAPORTO_DATA_SCAD'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
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
