inherited WA080FTipologieCartelliniDM: TWA080FTipologieCartelliniDM
  Height = 285
  Width = 561
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T025.*,T025.ROWID FROM T025_CONTMENSILI T025'
      ' :ORDERBY')
    AfterPost = AfterPost
    OnCalcFields = selTabellaCalcFields
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T025_CONTMENSILI.CODICE'
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Origin = 'T025_CONTMENSILI.DESCRIZIONE'
      Size = 40
    end
    object selTabellaCARTELLINO: TStringField
      DisplayLabel = 'Tipo cartellino'
      FieldName = 'CARTELLINO'
      Origin = 'T025_CONTMENSILI.CARTELLINO'
      Size = 1
    end
    object selTabellaISTITUTI: TStringField
      FieldName = 'ISTITUTI'
      Origin = 'T025_CONTMENSILI.ISTITUTI'
      Visible = False
      Size = 1
    end
    object selTabellaSCOSTSETT: TStringField
      FieldName = 'SCOSTSETT'
      Origin = 'T025_CONTMENSILI.SCOSTSETT'
      Visible = False
      Size = 6
    end
    object selTabellaINDENNITA: TStringField
      FieldName = 'INDENNITA'
      Origin = 'T025_CONTMENSILI.INDENNITA'
      Visible = False
      Size = 1
    end
    object selTabellaINDPRESENZA: TStringField
      FieldName = 'INDPRESENZA'
      Origin = 'T025_CONTMENSILI.INDPRESENZA'
      Visible = False
      Size = 1
    end
    object selTabellaCONTEGGIO: TIntegerField
      FieldName = 'CONTEGGIO'
      Visible = False
    end
    object selTabellaCOMPPREC: TIntegerField
      FieldName = 'COMPPREC'
      Visible = False
      MaxValue = 4
    end
    object selTabellaLIQPREC: TIntegerField
      FieldName = 'LIQPREC'
      Visible = False
      MaxValue = 4
    end
    object selTabellaCOMPATT: TIntegerField
      FieldName = 'COMPATT'
      Visible = False
      MaxValue = 4
    end
    object selTabellaLIQATT: TIntegerField
      FieldName = 'LIQATT'
      Visible = False
      MaxValue = 4
    end
    object selTabellaMESISALDOPREC: TIntegerField
      FieldName = 'MESISALDOPREC'
      Visible = False
      MaxValue = 99
      MinValue = -1
    end
    object selTabellaLIQUIDDISTRIBUITA: TStringField
      FieldName = 'LIQUIDDISTRIBUITA'
      Visible = False
      Size = 1
    end
    object selTabellaTIPOLIMITECOMPA: TStringField
      FieldName = 'TIPOLIMITECOMPA'
      Visible = False
      Size = 1
    end
    object selTabellaLIMITECOMPA: TStringField
      FieldName = 'LIMITECOMPA'
      Visible = False
      Size = 6
    end
    object selTabellaRECUPERO_SERBATOI: TStringField
      DisplayLabel = 'Serbatoi per recupero'
      FieldName = 'RECUPERO_SERBATOI'
      Visible = False
      Size = 1
    end
    object selTabellaBANCAORE: TStringField
      DisplayLabel = 'Banca ore'
      FieldName = 'BANCAORE'
      Size = 1
    end
    object selTabellaABBATTIMENTO_LIQUIDABILE: TStringField
      FieldName = 'ABBATTIMENTO_LIQUIDABILE'
      Visible = False
      Size = 1
    end
    object selTabellaRECUPERODEBITO: TIntegerField
      FieldName = 'RECUPERODEBITO'
      Visible = False
      MaxValue = 99
      MinValue = -1
    end
    object selTabellaRECUPERODEBITO_MAX: TStringField
      FieldName = 'RECUPERODEBITO_MAX'
      Visible = False
      Size = 7
    end
    object selTabellaRECUPERODEBITO_TIPO: TStringField
      FieldName = 'RECUPERODEBITO_TIPO'
      Visible = False
      Size = 1
    end
    object selTabellaRECUPERODEBITO_PERIODICITA: TStringField
      FieldName = 'RECUPERODEBITO_PERIODICITA'
      Visible = False
      Size = 1
    end
    object selTabellaPERIODICITA_ABBATTIMENTO: TStringField
      FieldName = 'PERIODICITA_ABBATTIMENTO'
      Visible = False
      Size = 1
    end
    object selTabellaABBATTIMENTO_MOBILE_MAX: TStringField
      FieldName = 'ABBATTIMENTO_MOBILE_MAX'
      Visible = False
      Size = 7
    end
    object selTabellaABBATTIMENTO_MOBILE_SALDI: TStringField
      FieldName = 'ABBATTIMENTO_MOBILE_SALDI'
      Visible = False
      Size = 2
    end
    object selTabellaCAUSALI_COMPENSABILI: TStringField
      FieldName = 'CAUSALI_COMPENSABILI'
      Visible = False
      Size = 2000
    end
    object selTabellaLIMITE_MM_ECCLIQ_TIPO: TStringField
      FieldName = 'LIMITE_MM_ECCLIQ_TIPO'
      Visible = False
      Size = 2
    end
    object selTabellaLIMITE_MM_ECCLIQ_DEFAULT: TStringField
      FieldName = 'LIMITE_MM_ECCLIQ_DEFAULT'
      Visible = False
      Size = 1
    end
    object selTabellaLIMITE_MM_ECCRES_TIPO: TStringField
      FieldName = 'LIMITE_MM_ECCRES_TIPO'
      Visible = False
      Size = 2
    end
    object selTabellaLIMITE_MM_ECCRES_DEFAULT: TStringField
      FieldName = 'LIMITE_MM_ECCRES_DEFAULT'
      Visible = False
      Size = 1
    end
    object selTabellaTRASF_SUPERO_LIQANN: TStringField
      FieldName = 'TRASF_SUPERO_LIQANN'
      Visible = False
      Size = 1
    end
    object selTabellaSOGLIA_COMP_LIQ: TStringField
      FieldName = 'SOGLIA_COMP_LIQ'
      Visible = False
      Size = 7
    end
    object selTabellaSALDO_NEGATIVO_MINIMO: TStringField
      FieldName = 'SALDO_NEGATIVO_MINIMO'
      Visible = False
      Size = 7
    end
    object selTabellaBANCAORE_RESID: TStringField
      FieldName = 'BANCAORE_RESID'
      Visible = False
      Size = 1
    end
    object selTabellaABBATT_MOBILE_RIFERIMENTO: TStringField
      FieldName = 'ABBATT_MOBILE_RIFERIMENTO'
      Visible = False
      Size = 1
    end
    object selTabellaBANCA_ORE_LIMITATA_SALDO_COMP: TStringField
      FieldName = 'BANCA_ORE_LIMITATA_SALDO_COMP'
      Visible = False
      Size = 1
    end
    object selTabellaBANCA_ORE_LIMITATA_STR_LIQ: TStringField
      FieldName = 'BANCA_ORE_LIMITATA_STR_LIQ'
      Visible = False
      Size = 1
    end
    object selTabellaARR_SOGLIA_COMP_LIQ: TStringField
      FieldName = 'ARR_SOGLIA_COMP_LIQ'
      Visible = False
      Size = 5
    end
    object selTabellaRIPOSO_NONFRUITO: TStringField
      FieldName = 'RIPOSO_NONFRUITO'
      Visible = False
      Size = 5
    end
    object selTabellaARRREC_COMPPREC: TStringField
      FieldName = 'ARRREC_COMPPREC'
      Visible = False
      Size = 5
    end
    object selTabellaARRREC_LIQPREC: TStringField
      FieldName = 'ARRREC_LIQPREC'
      Visible = False
      Size = 5
    end
    object selTabellaARRREC_COMPATT: TStringField
      FieldName = 'ARRREC_COMPATT'
      Visible = False
      Size = 5
    end
    object selTabellaARRREC_LIQATT: TStringField
      FieldName = 'ARRREC_LIQATT'
      Visible = False
      Size = 5
    end
    object selTabellaBANCA_ORE_ESCLUSA_ABBATT: TStringField
      FieldName = 'BANCA_ORE_ESCLUSA_ABBATT'
      Visible = False
      Size = 1
    end
    object selTabellaRECUP_STRAORD_PREC: TStringField
      FieldName = 'RECUP_STRAORD_PREC'
      Visible = False
      Size = 1
    end
    object selTabellaRIPOSO_RECUPLIQUID: TStringField
      FieldName = 'RIPOSO_RECUPLIQUID'
      Visible = False
      Size = 1
    end
    object selTabellaTIPOLIMITECOMPP: TStringField
      FieldName = 'TIPOLIMITECOMPP'
      Visible = False
      Size = 1
    end
    object selTabellaBANCA_ORE_RESID_ANNOPREC: TStringField
      FieldName = 'BANCA_ORE_RESID_ANNOPREC'
      Visible = False
      Size = 1
    end
    object selTabellaBANCA_ORE_MENS_ARR: TStringField
      FieldName = 'BANCA_ORE_MENS_ARR'
      Visible = False
      Size = 5
    end
    object selTabellaSALDO_NEGATIVO_MINIMO_TIPO: TStringField
      FieldName = 'SALDO_NEGATIVO_MINIMO_TIPO'
      Visible = False
      Size = 1
    end
    object selTabellaARRREC_SCOSTNEG: TStringField
      FieldName = 'ARRREC_SCOSTNEG'
      Visible = False
      Size = 5
    end
    object selTabellaPA_LIMITE: TStringField
      FieldName = 'PA_LIMITE'
      Visible = False
      Size = 7
    end
    object selTabellaPA_LIMITESALDOATT: TStringField
      DisplayWidth = 7
      FieldName = 'PA_LIMITESALDOATT'
      Visible = False
      Size = 7
    end
    object selTabellaPA_LIMITESALDOPREC: TStringField
      FieldName = 'PA_LIMITESALDOPREC'
      Visible = False
      Size = 7
    end
    object selTabellaPA_AZZERAMENTOPERIODICO: TStringField
      FieldName = 'PA_AZZERAMENTOPERIODICO'
      Visible = False
      Size = 1
    end
    object selTabellaPA_TIPORESIDUO: TStringField
      FieldName = 'PA_TIPORESIDUO'
      Visible = False
      Size = 1
    end
    object selTabellaBANCA_ORE_ABBATTIBILE: TStringField
      FieldName = 'BANCA_ORE_ABBATTIBILE'
      Visible = False
      Size = 1
    end
    object selTabellaABBATT_RIF_COMPENSABILE: TStringField
      FieldName = 'ABBATT_RIF_COMPENSABILE'
      Visible = False
      Size = 1
    end
    object selTabellaABBATT_RIF_LIQUIDABILE: TStringField
      FieldName = 'ABBATT_RIF_LIQUIDABILE'
      Visible = False
      Size = 1
    end
    object selTabellaABBATTIMENTO_FISSO_RECUPERO: TStringField
      FieldName = 'ABBATTIMENTO_FISSO_RECUPERO'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSRIPCOM_FASCE: TStringField
      FieldName = 'CAUSRIPCOM_FASCE'
      Visible = False
      Size = 5
    end
    object selTabellaD_RIPOSO_NONFRUITO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RIPOSO_NONFRUITO'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaD_CAUSRIPCOM_FASCE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSRIPCOM_FASCE'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaDEBAGG_RAPP_ANNO: TStringField
      FieldName = 'DEBAGG_RAPP_ANNO'
      Visible = False
      Size = 1
    end
    object selTabellaDEBAGG_CONSIDERA_OREPREC: TStringField
      FieldName = 'DEBAGG_CONSIDERA_OREPREC'
      Visible = False
      Size = 1
    end
    object selTabellaPAR_CARTELLINO: TStringField
      FieldName = 'PAR_CARTELLINO'
      Visible = False
      Size = 5
    end
    object selTabellaD_PAR_CARTELLINO: TStringField
      FieldKind = fkLookup
      FieldName = 'D_PAR_CARTELLINO'
      LookupDataSet = selT950
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PAR_CARTELLINO'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaBANCA_ORE_CONTR_LIQUIDAZ: TStringField
      FieldName = 'BANCA_ORE_CONTR_LIQUIDAZ'
      Visible = False
      Size = 1
    end
    object selTabellaRNF_ASSENZE_TOLLERATE: TStringField
      FieldName = 'RNF_ASSENZE_TOLLERATE'
      Visible = False
      Size = 1000
    end
    object selTabellaRNF_FILTRO: TStringField
      FieldName = 'RNF_FILTRO'
      Visible = False
      Size = 2000
    end
    object selTabellaABBATT_RIF_RECUPERO: TStringField
      FieldName = 'ABBATT_RIF_RECUPERO'
      Visible = False
      Size = 1
    end
    object selTabellaITER_AUTORIZZATIVO_STR: TStringField
      FieldName = 'ITER_AUTORIZZATIVO_STR'
      Visible = False
      Size = 1
    end
    object selTabellaBANCA_ORE_ESCLUSA_SALDI: TStringField
      FieldName = 'BANCA_ORE_ESCLUSA_SALDI'
      Visible = False
      Size = 1
    end
    object selTabellaTIPOLIMITECOMP_NOREC: TStringField
      FieldName = 'TIPOLIMITECOMP_NOREC'
      Visible = False
      Size = 1
    end
    object selTabellaRECDEBITO_MAXTOLLERATO: TStringField
      DisplayLabel = 'Soglia massima saldo negativo'
      FieldName = 'RECDEBITO_MAXTOLLERATO'
      Visible = False
      Size = 7
    end
    object selTabellaCAUS_RIENTRIOBBL: TStringField
      DisplayLabel = 'Caus.assenza rientri non resi'
      FieldName = 'CAUS_RIENTRIOBBL'
      Visible = False
      Size = 1000
    end
    object selTabellaPA_RAGGR_LIMITE: TStringField
      DisplayLabel = 'Salva eccedenza in competenze di'
      FieldName = 'PA_RAGGR_LIMITE'
      Visible = False
      Size = 5
    end
    object selTabellaPA_RAGGR_LIMITESALDOATT: TStringField
      DisplayLabel = 'Salva eccedenza in competenze di'
      FieldName = 'PA_RAGGR_LIMITESALDOATT'
      Visible = False
      Size = 5
    end
    object selTabellaPA_RAGGR_LIMITESALDOPREC: TStringField
      DisplayLabel = 'Salva eccedenza in competenze di'
      FieldName = 'PA_RAGGR_LIMITESALDOPREC'
      Visible = False
      Size = 5
    end
    object selTabellaITER_ECCGG_CHECKSALDO: TStringField
      FieldName = 'ITER_ECCGG_CHECKSALDO'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_COMPENSABILI_MENSILI: TStringField
      FieldName = 'CAUSALI_COMPENSABILI_MENSILI'
      Visible = False
      Size = 2000
    end
    object selTabellaCAUSALI_COMP_MESE_RECNEG: TStringField
      FieldName = 'CAUSALI_COMP_MESE_RECNEG'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_COMP_MENS_SALDO: TStringField
      FieldName = 'CAUSALI_COMP_MENS_SALDO'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_COMP_ANN_ADDEB_PAGHE: TStringField
      FieldName = 'CAUSALI_COMP_ANN_ADDEB_PAGHE'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_COMP_ANN_SALDO: TStringField
      FieldName = 'CAUSALI_COMP_ANN_SALDO'
      Visible = False
      Size = 1
    end
    object selTabellaRIPCOM_INCLUSI_SALDO: TStringField
      FieldName = 'RIPCOM_INCLUSI_SALDO'
      Visible = False
      Size = 1
    end
    object selTabellaITER_AUTSTR_CAUSALE: TStringField
      DisplayLabel = 'Causale iter straordinari'
      FieldName = 'ITER_AUTSTR_CAUSALE'
      Visible = False
      Size = 5
    end
    object selTabellaLIMITE_MM_ECCRES_CAUSALI: TStringField
      FieldName = 'LIMITE_MM_ECCRES_CAUSALI'
      Visible = False
      Size = 2000
    end
    object selTabellaITER_AUTSTR_MINIMO_LIQ: TStringField
      FieldName = 'ITER_AUTSTR_MINIMO_LIQ'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaITER_AUTSTR_ARROT_LIQ: TStringField
      FieldName = 'ITER_AUTSTR_ARROT_LIQ'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaITER_AUTSTR_ARROT_ECC: TStringField
      FieldName = 'ITER_AUTSTR_ARROT_ECC'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaXPARAM: TStringField
      FieldName = 'XPARAM'
      ReadOnly = True
      Visible = False
      Size = 1000
    end
    object selTabellaITER_AUTSTR_ARROT_LIQ_FASCE: TStringField
      FieldName = 'ITER_AUTSTR_ARROT_LIQ_FASCE'
      Visible = False
      Size = 1
    end
    object selTabellaGGVUOTO_TURNISTA: TStringField
      FieldName = 'GGVUOTO_TURNISTA'
      Visible = False
      Size = 1
    end
    object selTabellaRIEPASS_COMPENSABILI_ANNO: TStringField
      FieldName = 'RIEPASS_COMPENSABILI_ANNO'
      Visible = False
      Size = 2000
    end
  end
  object Q026: TOracleDataSet
    SQL.Strings = (
      'SELECT T026.*,ROWID FROM T026_SALDIABBATTUTI T026'
      'WHERE CODICE = :CODICE '
      'ORDER BY ANNO_RIF,MESE_RIF')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001000
      000041004E004E004F005F00520049004600010000000000100000004D004500
      530045005F00520049004600010000000000160000004D004500530045005F00
      410042004200410054005400010000000000}
    OnNewRecord = Q026NewRecord
    Left = 32
    Top = 120
    object Q026CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object Q026ANNO_RIF: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO_RIF'
      Required = True
    end
    object Q026MESE_RIF: TIntegerField
      DisplayLabel = 'Mese rif.'
      FieldName = 'MESE_RIF'
      Required = True
      MaxValue = 12
      MinValue = 1
    end
    object Q026MESE_ABBATT: TIntegerField
      DisplayLabel = 'Mese abbatt.'
      FieldName = 'MESE_ABBATT'
      Required = True
      MaxValue = 12
      MinValue = 1
    end
  end
  object D026: TDataSource
    DataSet = Q026
    Left = 32
    Top = 167
  end
  object selT275EsclNorm: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE '
      'WHERE ORENORMALI = '#39'A'#39
      'ORDER BY CODICE')
    Optimize = False
    Left = 95
    Top = 120
  end
  object dsrT275EsclNorm: TDataSource
    DataSet = selT275EsclNorm
    Left = 95
    Top = 167
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE,T265.DESCRIZIONE FROM '
      '  T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      'WHERE '
      '  T265.CODRAGGR = T260.CODICE AND'
      '  T260.CODINTERNO = '#39'H'#39
      'ORDER BY T265.CODICE')
    Optimize = False
    Left = 162
    Top = 120
  end
  object dsrT265: TDataSource
    DataSet = selT265
    Left = 162
    Top = 167
  end
  object insT026: TOracleQuery
    SQL.Strings = (
      'insert into T026_SALDIABBATTUTI '
      '  (CODICE,ANNO_RIF,MESE_RIF,MESE_ABBATT)'
      '  select :CODICE_NEW,ANNO_RIF,MESE_RIF,MESE_ABBATT '
      '  from   T026_SALDIABBATTUTI'
      '  where  CODICE = :CODICE_OLD')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0043004F0044004900430045005F004E004500
      5700050000000000000000000000160000003A0043004F004400490043004500
      5F004F004C004400050000000000000000000000}
    Left = 374
    Top = 120
  end
  object selT950: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T950_STAMPACARTELLINO'
      'ORDER BY CODICE')
    Optimize = False
    Left = 318
    Top = 120
  end
  object dsrT950: TDataSource
    DataSet = selT950
    Left = 318
    Top = 167
  end
  object selT265RNF: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE,UMISURA from T265_CAUASSENZE'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 240
    Top = 120
  end
  object selTipiRichStraord: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'0'#39' CODICE, '#39'No'#39' DESCRIZIONE FROM DUAL'
      'UNION ALL'
      'SELECT '#39'1'#39' CODICE, '#39'Banca ore'#39' DESCRIZIONE FROM DUAL'
      'UNION ALL'
      'SELECT '#39'2'#39' CODICE, '#39'Straord. annuo'#39' DESCRIZIONE FROM DUAL'
      'UNION ALL'
      
        'SELECT '#39'3'#39' CODICE, '#39'Straord. annuo con causale'#39' DESCRIZIONE FROM' +
        ' DUAL'
      'UNION ALL'
      'SELECT '#39'4'#39' CODICE, '#39'Ore causalizzate'#39' DESCRIZIONE FROM DUAL'
      'UNION ALL'
      
        'SELECT '#39'5'#39' CODICE, '#39'Straord. annuo con causale liquid.'#39' DESCRIZI' +
        'ONE FROM DUAL'
      'ORDER BY 1')
    Optimize = False
    Left = 438
    Top = 120
  end
  object dsrTipiRichStraord: TDataSource
    DataSet = selTipiRichStraord
    Left = 438
    Top = 167
  end
  object selT260: TOracleDataSet
    SQL.Strings = (
      'select distinct T260.CODICE,T260.DESCRIZIONE '
      'from T260_RAGGRASSENZE T260'
      'where T260.CONTASOLARE = '#39'S'#39
      'order by T260.CODICE')
    Optimize = False
    Left = 400
    Top = 16
  end
  object selT275LimiteCaus: TOracleDataSet
    SQL.Strings = (
      'select T275.CODICE, T275.DESCRIZIONE'
      '  from T275_CAUPRESENZE T275'
      ' where T275.ORENORMALI <> '#39'A'#39
      ' order by T275.CODICE ')
    Optimize = False
    Left = 243
    Top = 167
  end
  object selT275Lookup: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE '
      'FROM   T275_CAUPRESENZE '
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 31
    Top = 224
  end
end
