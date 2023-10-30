inherited WA029FSchedaRiepilDM: TWA029FSchedaRiepilDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T070.*,T070.ROWID FROM T070_SchedaRiepil T070'
      'WHERE Progressivo = :Progressivo'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    RefreshOptions = [roBeforeEdit]
    CachedUpdates = True
    BeforeInsert = BeforeInsert
    AfterInsert = selTabellaAfterInsert
    BeforeEdit = BeforeEdit
    AfterPost = AfterPost
    BeforeCancel = selTabellaBeforeCancel
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object selTabellaDEBITOORARIO: TStringField
      DisplayLabel = 'Debito'
      FieldName = 'DEBITOORARIO'
      Size = 6
    end
    object selTabellaDEBITOPO: TStringField
      DisplayLabel = 'Debito agg.'
      FieldName = 'DEBITOPO'
      Size = 6
    end
    object selTabellaOREASSENZE: TStringField
      DisplayLabel = 'Ore rese da assenza'
      FieldName = 'OREASSENZE'
      ReadOnly = True
      Size = 6
    end
    object selTabellaORE_INAIL: TStringField
      DisplayLabel = 'Ore Inail'
      FieldName = 'ORE_INAIL'
      Size = 6
    end
    object selTabellaSCOSTNEG: TStringField
      DisplayLabel = 'Scost.neg.'
      FieldName = 'SCOSTNEG'
      Origin = 'T070_SCHEDARIEPIL.SCOSTNEG'
      Size = 7
    end
    object selTabellaRECANNOCORR: TStringField
      DisplayLabel = 'Rec.anno corr.'
      FieldName = 'RECANNOCORR'
      Origin = 'T070_SCHEDARIEPIL.RECANNOCORR'
      Size = 6
    end
    object selTabellaRECANNOPREC: TStringField
      DisplayLabel = 'Rec.anno prec.'
      FieldName = 'RECANNOPREC'
      Origin = 'T070_SCHEDARIEPIL.RECANNOPREC'
      Size = 6
    end
    object selTabellaRECLIQCORR: TStringField
      FieldName = 'RECLIQCORR'
      Visible = False
      Size = 6
    end
    object selTabellaRECLIQPREC: TStringField
      FieldName = 'RECLIQPREC'
      Visible = False
      Size = 6
    end
    object selTabellaADDEBITOPAGHE: TStringField
      DisplayLabel = 'Ore addebitate'
      FieldName = 'ADDEBITOPAGHE'
      Origin = 'T070_SCHEDARIEPIL.ADDEBITOPAGHE'
      Size = 7
    end
    object selTabellaTIPOPO: TStringField
      FieldName = 'TIPOPO'
      Visible = False
      Size = 1
    end
    object selTabellaFESTIVINTERA: TFloatField
      DisplayLabel = 'Ind.Festiva'
      FieldName = 'FESTIVINTERA'
    end
    object selTabellaFESTIVINTERA_VAR: TFloatField
      FieldName = 'FESTIVINTERA_VAR'
      Visible = False
    end
    object selTabellaFESTIVRIDOTTA: TFloatField
      DisplayLabel = 'Ind.Festiva rid.'
      FieldName = 'FESTIVRIDOTTA'
    end
    object selTabellaFESTIVRIDOTTA_VAR: TFloatField
      FieldName = 'FESTIVRIDOTTA_VAR'
      Visible = False
    end
    object selTabellaINDTURNONUM: TFloatField
      DisplayLabel = 'Num.notti'
      FieldName = 'INDTURNONUM'
    end
    object selTabellaINDTURNONUM_VAR: TIntegerField
      FieldName = 'INDTURNONUM_VAR'
      Visible = False
    end
    object selTabellaINDTURNOORE: TStringField
      DisplayLabel = 'Ind.notturna'
      FieldName = 'INDTURNOORE'
      Size = 6
    end
    object selTabellaINDTURNOORE_VAR: TStringField
      FieldName = 'INDTURNOORE_VAR'
      Visible = False
      Size = 6
    end
    object selTabellaGGPRESENZA: TFloatField
      DisplayLabel = 'gg.presenza'
      FieldName = 'GGPRESENZA'
    end
    object selTabellaGGVUOTI: TFloatField
      DisplayLabel = 'gg.vuoti'
      FieldName = 'GGVUOTI'
    end
    object selTabellaTURNI1: TFloatField
      DisplayLabel = '1'#176'turni'
      FieldName = 'TURNI1'
    end
    object selTabellaTURNI2: TFloatField
      DisplayLabel = '2'#176'turni'
      FieldName = 'TURNI2'
    end
    object selTabellaTURNI3: TFloatField
      DisplayLabel = '3'#176'turni'
      FieldName = 'TURNI3'
    end
    object selTabellaTURNI4: TFloatField
      DisplayLabel = '4'#176'turni'
      FieldName = 'TURNI4'
    end
    object selTabellaCAUSALE1MINASS: TStringField
      DisplayLabel = 'Assestamento 1'
      FieldName = 'CAUSALE1MINASS'
      Visible = False
      Size = 5
    end
    object selTabellaD_Causale1: TStringField
      DisplayLabel = 'Assestamento 1'
      FieldKind = fkLookup
      FieldName = 'D_Causale1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE1MINASS'
      Size = 40
      Lookup = True
    end
    object selTabellaCAUSALE2MINASS: TStringField
      DisplayLabel = 'Assestamento 2'
      FieldName = 'CAUSALE2MINASS'
      Visible = False
      Size = 5
    end
    object selTabellaD_Causale2: TStringField
      DisplayLabel = 'Assestamento 2'
      FieldKind = fkLookup
      FieldName = 'D_Causale2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE2MINASS'
      Size = 40
      Lookup = True
    end
    object selTabellaORECOMP_LIQUIDATE: TStringField
      DisplayLabel = 'Banca ore liquidata'
      FieldName = 'ORECOMP_LIQUIDATE'
      Size = 7
    end
    object selTabellaORECOMP_RECUPERATE: TStringField
      DisplayLabel = 'Banca ore recuperata'
      FieldName = 'ORECOMP_RECUPERATE'
      Size = 6
    end
    object selTabellaOREECCEDCOMP: TStringField
      FieldName = 'OREECCEDCOMP'
      Visible = False
      Size = 6
    end
    object selTabellaOREVARIAZECC: TStringField
      FieldName = 'OREVARIAZECC'
      Visible = False
      Size = 7
    end
    object selTabellaRIPCOM: TStringField
      DisplayLabel = 'Riposi comp.'
      FieldName = 'RIPCOM'
      Origin = 'T070_SCHEDARIEPIL.RIPCOM'
      ReadOnly = True
      Visible = False
      Size = 7
    end
    object selTabellaABBRIPCOM: TStringField
      DisplayLabel = 'Abb.riposi comp.'
      FieldName = 'ABBRIPCOM'
      Origin = 'T070_SCHEDARIEPIL.ABBRIPCOM'
      ReadOnly = True
      Visible = False
      Size = 6
    end
    object selTabellaLIQ_FUORI_BUDGET: TFloatField
      FieldName = 'LIQ_FUORI_BUDGET'
      ReadOnly = True
      Visible = False
    end
    object selTabellaOREECCEDCOMPOLTRESOGLIA: TStringField
      FieldName = 'OREECCEDCOMPOLTRESOGLIA'
      Visible = False
      Size = 6
    end
    object selTabellaRIPOSI_NONFRUITI: TIntegerField
      FieldName = 'RIPOSI_NONFRUITI'
      Visible = False
    end
    object selTabellaRIPOSINONFRUITIORE: TStringField
      FieldName = 'RIPOSINONFRUITIORE'
      Visible = False
      Size = 7
    end
    object selTabellaBANCAORE_LIQ_VAR: TStringField
      FieldName = 'BANCAORE_LIQ_VAR'
      Visible = False
      Size = 7
    end
    object selTabellaRIEPASS_COMPENSATE_ANNO: TStringField
      FieldName = 'RIEPASS_COMPENSATE_ANNO'
      Size = 7
    end
    object selTabellaRIEPASS_COMPENSATE_MESE: TStringField
      FieldName = 'RIEPASS_COMPENSATE_MESE'
      Size = 7
    end
  end
end
