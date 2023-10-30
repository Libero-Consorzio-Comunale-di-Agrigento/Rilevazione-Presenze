inherited WA110FParametriConteggioDM: TWA110FParametriConteggioDM
  Height = 141
  Width = 415
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT M010.*, M010.ROWID '
      '  FROM M010_PARAMETRICONTEGGIO M010'
      ':ORDERBY'
      '')
    Filtered = True
    AfterOpen = selTabellaAfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 80
    end
    object selTabellaTIPO_MISSIONE: TStringField
      DisplayLabel = 'Tipo Missione'
      FieldName = 'TIPO_MISSIONE'
      Required = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaM010OREMINIMEPERINDENNITA: TStringField
      DisplayLabel = 'Ore min.indennit'#224
      FieldName = 'OREMINIMEPERINDENNITA'
      Visible = False
      Size = 40
    end
    object selTabellaLIMITEORERETRIBUITEINTERE: TStringField
      DisplayLabel = 'Limite ore retr. int.'
      FieldName = 'LIMITEORERETRIBUITEINTERE'
      Visible = False
      Size = 10
    end
    object selTabellaARROTONDAMENTOORE: TFloatField
      FieldName = 'ARROTONDAMENTOORE'
      Visible = False
    end
    object selTabellaPERCRETRIBSUPEROORE: TFloatField
      FieldName = 'PERCRETRIBSUPEROORE'
      Visible = False
    end
    object selTabellaMAXGIORNIRETRMESE: TFloatField
      FieldName = 'MAXGIORNIRETRMESE'
      Visible = False
    end
    object selTabellaPERCRETRIBSUPEROGG: TFloatField
      FieldName = 'PERCRETRIBSUPEROGG'
      Visible = False
    end
    object selTabellaARROTTARIFFADOPORIDUZIONE: TStringField
      FieldName = 'ARROTTARIFFADOPORIDUZIONE'
      Visible = False
      Size = 5
    end
    object selTabellaARROTTOTIMPORTIDATIPAGHE: TStringField
      FieldName = 'ARROTTOTIMPORTIDATIPAGHE'
      Visible = False
      Size = 5
    end
    object selTabellaRIDUZIONE_PASTO: TStringField
      FieldName = 'RIDUZIONE_PASTO'
      Visible = False
      Size = 1
    end
    object selTabellaPERCRETRIBPASTO: TFloatField
      FieldName = 'PERCRETRIBPASTO'
      Visible = False
    end
    object selTabellaTARIFFAINDENNITA: TFloatField
      FieldName = 'TARIFFAINDENNITA'
      Visible = False
    end
    object selTabellaTIPO_TARIFFA: TStringField
      FieldName = 'TIPO_TARIFFA'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selTabellaCODVOCEPAGHEINTERA: TStringField
      DisplayLabel = 'Voce paghe ind.intera'
      FieldName = 'CODVOCEPAGHEINTERA'
      Visible = False
      Size = 6
    end
    object selTabellaCODVOCEPAGHESUPHH: TStringField
      DisplayLabel = 'Ind. rid.supero hh/riduz.rimb.pasto'
      FieldName = 'CODVOCEPAGHESUPHH'
      Visible = False
      Size = 6
    end
    object selTabellaCODVOCEPAGHESUPGG: TStringField
      DisplayLabel = 'Indennit'#224' rid.supero gg'
      FieldName = 'CODVOCEPAGHESUPGG'
      Visible = False
      Size = 6
    end
    object selTabellaCODVOCEPAGHESUPHHGG: TStringField
      DisplayLabel = 'Indennit'#224' rid.supero hhgg'
      FieldName = 'CODVOCEPAGHESUPHHGG'
      Visible = False
      Size = 6
    end
    object selTabellaTIPO_RIMBORSOPASTO: TStringField
      DisplayLabel = 'Tipo rimb.pasto'
      FieldName = 'TIPO_RIMBORSOPASTO'
      Size = 1
    end
    object selTabellaORERIMBORSOPASTO: TStringField
      DisplayLabel = 'Soglia maturaz.pranzo'
      FieldName = 'ORERIMBORSOPASTO'
      Size = 5
    end
    object selTabellaTARIFFARIMBORSOPASTO: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO'
      Visible = False
    end
    object selTabellaORERIMBORSOPASTO2: TStringField
      DisplayLabel = 'Soglia maturaz.cena'
      FieldName = 'ORERIMBORSOPASTO2'
      Size = 5
    end
    object selTabellaTARIFFARIMBORSOPASTO2: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO2'
      Visible = False
    end
    object selTabellaCalcArrotTariffaDopoRiduzione: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotTariffaDopoRiduzione'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaCalcArrotImportiDatiPaghe: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotImportiDatiPaghe'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaMAXMESIRIMB: TFloatField
      DisplayLabel = 'Num.mesi per rimborso'
      FieldName = 'MAXMESIRIMB'
    end
    object selTabellaDATARIF_VOCEPAGHE: TStringField
      DisplayLabel = 'Data comp. scarico paghe'
      FieldName = 'DATARIF_VOCEPAGHE'
      Size = 1
    end
    object selTabellaIND_DA_TAB_TARIFFE: TStringField
      FieldName = 'IND_DA_TAB_TARIFFE'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALE_MISSIONE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE_MISSIONE'
      Size = 5
    end
    object selTabellaCalcCausale: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcCausale'
      Visible = False
      Size = 40
      Calculated = True
    end
    object selTabellaGIUSTIF_HHMAX: TStringField
      FieldName = 'GIUSTIF_HHMAX'
      Visible = False
      Size = 5
    end
    object selTabellaGIUSTIF_COPRE_DEBITOGG: TStringField
      FieldName = 'GIUSTIF_COPRE_DEBITOGG'
      Visible = False
      Size = 1
    end
    object selTabelladesc_codice: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_codice'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Visible = False
      Size = 80
      Lookup = True
    end
    object selTabelladesc_tipomissione: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_tipomissione'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO_MISSIONE'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCODICI_INDENNITAKM: TStringField
      DisplayLabel = 'Ind.KM'
      DisplayWidth = 40
      FieldName = 'CODICI_INDENNITAKM'
      Size = 500
    end
    object selTabellaCODICI_RIMBORSI: TStringField
      DisplayLabel = 'Rimborsi'
      DisplayWidth = 40
      FieldName = 'CODICI_RIMBORSI'
      Size = 500
    end
    object selTabellaCODRIMBORSOPASTO: TStringField
      FieldName = 'CODRIMBORSOPASTO'
      Visible = False
      Size = 5
    end
    object selTabellaRIMB_KM_AUTO: TStringField
      FieldName = 'RIMB_KM_AUTO'
      Visible = False
      Size = 1
    end
    object selTabellaIND_KM_AUTO: TStringField
      FieldName = 'IND_KM_AUTO'
      Visible = False
      Size = 5
    end
    object selTabellaDESC_IND_KM_AUTO: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_IND_KM_AUTO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'IND_KM_AUTO'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaRIMB_KM_AUTO_MINIMO: TIntegerField
      DisplayLabel = 'Soglia per rimborso automatico'
      FieldName = 'RIMB_KM_AUTO_MINIMO'
      Visible = False
      MaxValue = 9999
    end
  end
end
