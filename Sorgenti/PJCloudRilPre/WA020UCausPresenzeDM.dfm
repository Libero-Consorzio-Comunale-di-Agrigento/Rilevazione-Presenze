inherited WA020FCausPresenzeDM: TWA020FCausPresenzeDM
  Height = 141
  Width = 312
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T275.*,T275.ROWID FROM T275_CAUPRESENZE T275 :ORDERBY')
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaCodice: TStringField
      FieldName = 'Codice'
      Required = True
      OnValidate = selTabellaCodiceValidate
      Size = 5
    end
    object selTabellaDescrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object selTabellaCodRaggr: TStringField
      DisplayLabel = 'Raggruppamento'
      FieldName = 'CodRaggr'
      Required = True
      OnChange = selTabellaCodRaggrChange
      Size = 5
    end
    object selTabellaD_CodRaggr: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CodRaggr'
      LookupDataSet = A020FCausPresenzeMW.selT270
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaOreNormali: TStringField
      DisplayLabel = 'Incl./Escl. ore normali'
      FieldName = 'OreNormali'
      Size = 1
    end
    object selTabellaTipoConteggio: TStringField
      DisplayLabel = 'Caus. timbrature'
      FieldName = 'TipoConteggio'
      Size = 1
    end
    object selTabellaStampe: TStringField
      DisplayLabel = 'Riepilogo'
      FieldName = 'Stampe'
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
    object selTabellaLINK_ASSENZA: TStringField
      DisplayLabel = 'Caus. assenza'
      FieldName = 'LINK_ASSENZA'
      Size = 5
    end
    object selTabellaD_LINK_ASSENZA: TStringField
      FieldKind = fkLookup
      FieldName = 'D_LINK_ASSENZA'
      LookupDataSet = A020FCausPresenzeMW.selT265
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'LINK_ASSENZA'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaAUTOGIUST_DALLEALLE: TStringField
      DisplayLabel = 'Fruizione'
      FieldName = 'AUTOGIUST_DALLEALLE'
      Size = 1
    end
    object selTabellaRipFasce: TStringField
      FieldName = 'RipFasce'
      Visible = False
      Size = 1
    end
    object selTabellaArrotondamento: TFloatField
      FieldName = 'Arrotondamento'
      Visible = False
      OnValidate = selTabellaArrotondamentoValidate
      MaxValue = 60.000000000000000000
      MinValue = -60.000000000000000000
    end
    object selTabellaScostamento: TDateTimeField
      FieldName = 'Scostamento'
      Visible = False
      OnGetText = selTabellaScostamentoGetText
      OnSetText = selTabellaScostamentoSetText
      DisplayFormat = 'hh:nn'
    end
    object selTabellaVocePaghe1: TStringField
      FieldName = 'VocePaghe1'
      Visible = False
      Size = 10
    end
    object selTabellaVocePaghe2: TStringField
      FieldName = 'VocePaghe2'
      Visible = False
      Size = 10
    end
    object selTabellaVocePaghe3: TStringField
      FieldName = 'VocePaghe3'
      Visible = False
      Size = 10
    end
    object selTabellaVocePaghe4: TStringField
      FieldName = 'VocePaghe4'
      Visible = False
      Size = 10
    end
    object selTabellaVOCEPAGHELIQ1: TStringField
      FieldName = 'VOCEPAGHELIQ1'
      Visible = False
      Size = 10
    end
    object selTabellaVOCEPAGHELIQ2: TStringField
      FieldName = 'VOCEPAGHELIQ2'
      Visible = False
      Size = 10
    end
    object selTabellaVOCEPAGHELIQ3: TStringField
      FieldName = 'VOCEPAGHELIQ3'
      Visible = False
      Size = 10
    end
    object selTabellaVOCEPAGHELIQ4: TStringField
      FieldName = 'VOCEPAGHELIQ4'
      Visible = False
      Size = 10
    end
    object selTabellaLIQUIDABILE: TStringField
      FieldName = 'LIQUIDABILE'
      Visible = False
      Size = 1
    end
    object selTabellaDETREPERIB: TStringField
      FieldName = 'DETREPERIB'
      Visible = False
      Size = 1
    end
    object selTabellaRIPLIQ: TStringField
      FieldName = 'RIPLIQ'
      Visible = False
      Size = 1
    end
    object selTabellaMATURAMENSA: TStringField
      FieldName = 'MATURAMENSA'
      Visible = False
      Size = 1
    end
    object selTabellaSIGLA: TStringField
      FieldName = 'SIGLA'
      Visible = False
      Size = 1
    end
    object selTabellaMAXMINUTI: TIntegerField
      FieldName = 'MAXMINUTI'
      Visible = False
      MaxValue = 999
    end
    object selTabellaPIANIFREP: TStringField
      FieldName = 'PIANIFREP'
      Visible = False
      Size = 1
    end
    object selTabellaLFSCAVMEZ: TStringField
      FieldName = 'LFSCAVMEZ'
      Visible = False
      Size = 1
    end
    object selTabellaABBATTE_BUDGET: TStringField
      FieldName = 'ABBATTE_BUDGET'
      Visible = False
      Size = 1
    end
    object selTabellaRESIDUABILE: TStringField
      DisplayWidth = 7
      FieldName = 'RESIDUABILE'
      Visible = False
      OnValidate = selTabellaRESIDUABILEValidate
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object selTabellaMINMINUTI: TIntegerField
      FieldName = 'MINMINUTI'
      Visible = False
    end
    object selTabellaTIPO_MINMINIMI: TStringField
      FieldName = 'TIPO_MINMINIMI'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_NONAUTORIZZATE: TStringField
      FieldName = 'TIPO_NONAUTORIZZATE'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_U_NONAUTORIZZATE: TStringField
      FieldName = 'TIPO_U_NONAUTORIZZATE'
      Visible = False
      Size = 1
    end
    object selTabellaGETTONE_ORE: TStringField
      FieldName = 'GETTONE_ORE'
      Visible = False
      OnValidate = selTabellaGETTONE_OREValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaGETTONE_TIPO_OREINF: TStringField
      FieldName = 'GETTONE_TIPO_OREINF'
      Visible = False
      Size = 1
    end
    object selTabellaGETTONE_TIPO_ORESUP: TStringField
      FieldName = 'GETTONE_TIPO_ORESUP'
      Visible = False
      Size = 1
    end
    object selTabellaGETTONE_INDENNITA: TStringField
      FieldName = 'GETTONE_INDENNITA'
      Visible = False
      Size = 5
    end
    object selTabellaGETTONE_SPEZZONI: TStringField
      FieldName = 'GETTONE_SPEZZONI'
      Visible = False
      Size = 1
    end
    object selTabellaLIMITE_DEBITOGG: TStringField
      FieldName = 'LIMITE_DEBITOGG'
      Visible = False
      Size = 1
    end
    object selTabellaSENZA_FLESSIBILITA: TStringField
      FieldName = 'SENZA_FLESSIBILITA'
      Visible = False
      Size = 1
    end
    object selTabellaNO_LIMITE_MENSILE_LIQ: TStringField
      FieldName = 'NO_LIMITE_MENSILE_LIQ'
      Visible = False
      Size = 1
    end
    object selTabellaSCOST_PUNTI_NOMINALI: TStringField
      FieldName = 'SCOST_PUNTI_NOMINALI'
      Visible = False
      Size = 1
    end
    object selTabellaSTACCO_MINIMO_SCOST: TStringField
      FieldName = 'STACCO_MINIMO_SCOST'
      Visible = False
      Size = 1
    end
    object selTabellaNO_ECCEDENZA_IN_FASCIA: TStringField
      FieldName = 'NO_ECCEDENZA_IN_FASCIA'
      Visible = False
      Size = 1
    end
    object selTabellaCOMPETENZE_AUTOGIUST: TStringField
      FieldName = 'COMPETENZE_AUTOGIUST'
      Visible = False
      Size = 1
    end
    object selTabellaESCLUSIONE_FASCIA_OBB: TStringField
      FieldName = 'ESCLUSIONE_FASCIA_OBB'
      Visible = False
      Size = 1
    end
    object selTabellaFLESSIBILITA_ORARIO: TStringField
      FieldName = 'FLESSIBILITA_ORARIO'
      Visible = False
      Size = 1
    end
    object selTabellaSOGLIA_FASCE_OBBLFAC: TIntegerField
      FieldName = 'SOGLIA_FASCE_OBBLFAC'
      Visible = False
    end
    object selTabellaRESIDUO_LIQUIDABILE: TStringField
      FieldName = 'RESIDUO_LIQUIDABILE'
      Visible = False
      Size = 1
    end
    object selTabellaCAUS_FUORI_TURNO: TStringField
      FieldName = 'CAUS_FUORI_TURNO'
      Visible = False
      Size = 5
    end
    object selTabellaPERC_INAIL: TStringField
      FieldName = 'PERC_INAIL'
      Visible = False
      Size = 1
    end
    object selTabellaGETTONE_DALLE: TStringField
      FieldName = 'GETTONE_DALLE'
      Visible = False
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaGETTONE_ALLE: TStringField
      FieldName = 'GETTONE_ALLE'
      Visible = False
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selTabellaTIMB_PM: TStringField
      FieldName = 'TIMB_PM'
      Visible = False
      Size = 1
    end
    object selTabellaINCLUDI_INDTURNO: TStringField
      FieldName = 'INCLUDI_INDTURNO'
      Visible = False
      Size = 1
    end
    object selTabellaARROT_RIEPGG: TStringField
      FieldName = 'ARROT_RIEPGG'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaARROT_RIEPGG_ORENORM: TStringField
      FieldName = 'ARROT_RIEPGG_ORENORM'
      Visible = False
      Size = 1
    end
    object selTabellaARROT_RIEPGG_FASCE: TStringField
      FieldName = 'ARROT_RIEPGG_FASCE'
      Visible = False
      Size = 1
    end
    object selTabellaE_IN_FLESSIBILITA: TStringField
      FieldName = 'E_IN_FLESSIBILITA'
      Visible = False
      Size = 1
    end
    object selTabellaCOMP_CAUS_OREMAX: TStringField
      FieldName = 'COMP_CAUS_OREMAX'
      Visible = False
      Size = 1
    end
    object selTabellaAUTOCOMPLETAMENTO_UE: TStringField
      FieldName = 'AUTOCOMPLETAMENTO_UE'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_RICHIESTA_WEB: TStringField
      FieldName = 'TIPO_RICHIESTA_WEB'
      Visible = False
      Size = 1
    end
    object selTabellaCONSIDERA_SCELTA_ORARIO: TStringField
      FieldName = 'CONSIDERA_SCELTA_ORARIO'
      Visible = False
      Size = 1
    end
    object selTabellaFLEX_TIMBR_CAUS: TStringField
      FieldName = 'FLEX_TIMBR_CAUS'
      Visible = False
      Size = 1
    end
    object selTabellaINCLUSIONE_SALDI_CAUSALI: TStringField
      FieldName = 'INCLUSIONE_SALDI_CAUSALI'
      Visible = False
      Size = 1
    end
    object selTabellaFORZA_NOTTE_SPEZZATA: TStringField
      FieldName = 'FORZA_NOTTE_SPEZZATA'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALIZZA_TIMB_INTERSECANTI: TStringField
      FieldName = 'CAUSALIZZA_TIMB_INTERSECANTI'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_DETRAZ: TStringField
      FieldName = 'TIMB_PM_DETRAZ'
      Visible = False
      Size = 1
    end
    object selTabellaPERIODICITA_ABBATTIMENTO: TIntegerField
      FieldName = 'PERIODICITA_ABBATTIMENTO'
      Visible = False
      MaxValue = 99
      MinValue = -1
    end
    object selTabellaGIUST_DAA_TIMB: TStringField
      FieldName = 'GIUST_DAA_TIMB'
      Visible = False
      Size = 1
    end
    object selTabellaCUMULA_RICHIESTE_WEB: TStringField
      FieldName = 'CUMULA_RICHIESTE_WEB'
      Visible = False
      Size = 1
    end
    object selTabellaINTERSEZIONE_TIMBRATURE: TStringField
      FieldName = 'INTERSEZIONE_TIMBRATURE'
      Visible = False
      Size = 1
    end
    object selTabellaSEMPRE_APPOGGIATA: TStringField
      FieldName = 'SEMPRE_APPOGGIATA'
      Visible = False
      Size = 1
    end
    object selTabellaNO_ECCED_IN_FASCIA_CONS_ASS: TStringField
      FieldName = 'NO_ECCED_IN_FASCIA_CONS_ASS'
      Visible = False
      Size = 1
    end
    object selTabellaD_GETTONE_INDENNITA: TStringField
      FieldKind = fkLookup
      FieldName = 'D_GETTONE_INDENNITA'
      LookupDataSet = A020FCausPresenzeMW.selT162
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'GETTONE_INDENNITA'
      Visible = False
      Size = 50
      Lookup = True
    end
    object selTabellaD_CAUS_FUORI_TURNO: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUS_FUORI_TURNO'
      LookupDataSet = A020FCausPresenzeMW.selT275lkp
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUS_FUORI_TURNO'
      Visible = False
      Size = 50
      Lookup = True
    end
    object selTabellaCAUSCOMP_DEBITOGG: TStringField
      FieldName = 'CAUSCOMP_DEBITOGG'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object selTabellaFORZA_CAUSECCEDENZA: TStringField
      FieldName = 'FORZA_CAUSECCEDENZA'
      Visible = False
      Size = 1
    end
    object selTabellaLIQUIDAZIONE_MESIPREC: TStringField
      FieldName = 'LIQUIDAZIONE_MESIPREC'
      Visible = False
      Size = 1
    end
    object selTabellaNO_LIMITE_ANNUALE_LIQ: TStringField
      FieldName = 'NO_LIMITE_ANNUALE_LIQ'
      Visible = False
      Size = 1
    end
    object selTabellaINSERIMENTO_TIMB: TStringField
      DisplayLabel = 'Consenti causalizzazione timbrature'
      FieldName = 'INSERIMENTO_TIMB'
      Visible = False
      Size = 1
    end
    object selTabellaINSERIMENTO_TIMBVIRT: TStringField
      DisplayLabel = 'Consenti causalizzazione timbrature virtuali'
      FieldName = 'INSERIMENTO_TIMBVIRT'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_H: TStringField
      FieldName = 'TIMB_PM_H'
      Size = 1
    end
    object selTabellaID: TIntegerField
      FieldName = 'ID'
      Visible = False
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
