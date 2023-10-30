inherited WA172FSchedeQuantIndividualiDM: TWA172FSchedeQuantIndividualiDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select'
      'T767.anno,'
      'T767.codgruppo,'
      'T767.descrizione,'
      'T767.filtro_anagrafe,'
      'T767.codtipoquota,'
      'T767.numore_totale,'
      'T767.importo_totale,'
      'T767.tolleranza,'
      'T767.datarif,'
      'T767.stato,'
      'T767.pag1_perc,'
      'T767.pag1_max,'
      'T767.pag2_perc,'
      'T767.pag2_max,'
      'T767.pag3_perc,'
      'T767.pag3_max,'
      'T767.pag4_perc,'
      'T767.pag4_max,'
      'T767.pag5_perc,'
      'T767.pag5_max,'
      'T767.pag6_perc,'
      'T767.pag6_max,'
      'T767.pag7_perc,'
      'T767.pag7_max,'
      'T767.pag8_perc,'
      'T767.pag8_max,'
      'T767.pag9_perc,'
      'T767.pag9_max,'
      'T767.pag10_perc,'
      'T767.pag10_max,'
      'T767.pag11_perc,'
      'T767.pag11_max,'
      'T767.pag12_perc,'
      'T767.pag12_max,'
      'T767.supervisione,'
      'nvl(T767.prog_supervisore,0) prog_supervisore,'
      'T767.numore_min_dirigenti,'
      'T767.importo_max_dirigenti,'
      'T767.tipo_dipendenti,'
      'T767.ROWID'
      'from T767_INCQUANTGRUPPO T767'
      ':ORDERBY'
      ''
      ''
      '')
    Filtered = True
    AfterOpen = selTabellaAfterOpen
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Required = True
    end
    object selTabellaCODGRUPPO: TStringField
      DisplayLabel = 'Cod. gruppo'
      FieldName = 'CODGRUPPO'
      Required = True
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaFILTRO_ANAGRAFE: TStringField
      FieldName = 'FILTRO_ANAGRAFE'
      Visible = False
      Size = 4000
    end
    object selTabellaCODTIPOQUOTA: TStringField
      DisplayLabel = 'Cod. tipo quota'
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selTabellaDESCTIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      FieldKind = fkLookup
      FieldName = 'DESCTIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Lookup = True
    end
    object selTabellaNUMORE_TOTALE: TStringField
      DisplayLabel = 'Num. ore totale'
      FieldName = 'NUMORE_TOTALE'
      Size = 9
    end
    object selTabellaIMPORTO_TOTALE: TFloatField
      DisplayLabel = 'Importo totale'
      FieldName = 'IMPORTO_TOTALE'
    end
    object selTabellaDATARIF: TDateTimeField
      DisplayLabel = 'Data rif.'
      DisplayWidth = 10
      FieldName = 'DATARIF'
    end
    object selTabellaPAG1_PERC: TFloatField
      DisplayLabel = 'Gen: % ore'
      FieldName = 'PAG1_PERC'
      Visible = False
    end
    object selTabellaPAG1_MAX: TStringField
      DisplayLabel = 'Gen: max ore'
      FieldName = 'PAG1_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG2_PERC: TFloatField
      DisplayLabel = 'Feb: % ore'
      FieldName = 'PAG2_PERC'
      Visible = False
    end
    object selTabellaPAG2_MAX: TStringField
      DisplayLabel = 'Feb: max ore'
      FieldName = 'PAG2_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG3_PERC: TFloatField
      DisplayLabel = 'Mar: % ore'
      FieldName = 'PAG3_PERC'
      Visible = False
    end
    object selTabellaPAG3_MAX: TStringField
      DisplayLabel = 'Mar: max ore'
      FieldName = 'PAG3_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG4_PERC: TFloatField
      DisplayLabel = 'Apr: % ore'
      FieldName = 'PAG4_PERC'
      Visible = False
    end
    object selTabellaPAG4_MAX: TStringField
      DisplayLabel = 'Apr: max ore'
      FieldName = 'PAG4_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG5_PERC: TFloatField
      DisplayLabel = 'Mag: % ore'
      FieldName = 'PAG5_PERC'
      Visible = False
    end
    object selTabellaPAG5_MAX: TStringField
      DisplayLabel = 'Mag: max ore'
      FieldName = 'PAG5_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG6_PERC: TFloatField
      DisplayLabel = 'Giu: % ore'
      FieldName = 'PAG6_PERC'
      Visible = False
    end
    object selTabellaPAG6_MAX: TStringField
      DisplayLabel = 'Giu: max ore'
      FieldName = 'PAG6_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG7_PERC: TFloatField
      DisplayLabel = 'Lug: % ore'
      FieldName = 'PAG7_PERC'
      Visible = False
    end
    object selTabellaPAG7_MAX: TStringField
      DisplayLabel = 'Lug: max ore'
      FieldName = 'PAG7_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG8_PERC: TFloatField
      DisplayLabel = 'Ago: % ore'
      FieldName = 'PAG8_PERC'
      Visible = False
    end
    object selTabellaPAG8_MAX: TStringField
      DisplayLabel = 'Ago: max ore'
      FieldName = 'PAG8_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG9_PERC: TFloatField
      DisplayLabel = 'Set: % ore'
      FieldName = 'PAG9_PERC'
      Visible = False
    end
    object selTabellaPAG9_MAX: TStringField
      DisplayLabel = 'Set: max ore'
      FieldName = 'PAG9_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG10_PERC: TFloatField
      DisplayLabel = 'Ott: % ore'
      FieldName = 'PAG10_PERC'
      Visible = False
    end
    object selTabellaPAG10_MAX: TStringField
      DisplayLabel = 'Ott: max ore'
      FieldName = 'PAG10_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG11_PERC: TFloatField
      DisplayLabel = 'Nov: % ore'
      FieldName = 'PAG11_PERC'
      Visible = False
    end
    object selTabellaPAG11_MAX: TStringField
      DisplayLabel = 'Nov: max ore'
      FieldName = 'PAG11_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaPAG12_PERC: TFloatField
      DisplayLabel = 'Dic: % ore'
      FieldName = 'PAG12_PERC'
      Visible = False
    end
    object selTabellaPAG12_MAX: TStringField
      DisplayLabel = 'Dic: max ore'
      FieldName = 'PAG12_MAX'
      Visible = False
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object selTabellaTOLLERANZA: TFloatField
      DisplayLabel = 'Tolleranza'
      FieldName = 'TOLLERANZA'
    end
    object selTabellaSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Size = 1
    end
    object selTabellaSUPERVISIONE: TStringField
      DisplayLabel = 'Supervisione'
      FieldName = 'SUPERVISIONE'
      Size = 1
    end
    object selTabellaPROG_SUPERVISORE: TFloatField
      DisplayLabel = 'Prog. supervisore'
      FieldName = 'PROG_SUPERVISORE'
      Visible = False
    end
  end
  object dsrSG715: TDataSource
    OnStateChange = dsrSG715StateChange
    Left = 128
    Top = 144
  end
end
