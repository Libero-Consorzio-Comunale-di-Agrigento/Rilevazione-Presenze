inherited WA016FCausAssenzeStoricoDM: TWA016FCausAssenzeStoricoDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T230.*, T230.ROWID'
      'from T230_CAUASSENZE_PARSTO T230'
      'where T230.id = :ID'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000060000003A0049004400030000000000000000000000}
    object selTabellaID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldKind = fkLookup
      FieldName = 'CODICE'
      LookupDataSet = selT265
      LookupKeyFields = 'ID'
      LookupResultField = 'CODICE'
      KeyFields = 'ID'
      Size = 5
      Lookup = True
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione periodo'
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selTabellaDESC_CAUSALE: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupDataSet = selT265
      LookupKeyFields = 'ID'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ID'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaVALORGIOR: TStringField
      FieldName = 'VALORGIOR'
      Visible = False
      Size = 1
    end
    object selTabellaVALORGIOR_ORE: TStringField
      FieldName = 'VALORGIOR_ORE'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaVALORGIOR_COMP: TStringField
      FieldName = 'VALORGIOR_COMP'
      Visible = False
      Size = 1
    end
    object selTabellaPESOGIOR_DAORARIO: TStringField
      DisplayLabel = 'Peso giornata assenza da modello orario'
      FieldName = 'PESOGIOR_DAORARIO'
      Size = 1
    end
    object selTabellaVALORGIOR_ORECOMP: TStringField
      DisplayWidth = 5
      FieldName = 'VALORGIOR_ORECOMP'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaVALORGIOR_ORE_PROPPT: TStringField
      FieldName = 'VALORGIOR_ORE_PROPPT'
      Visible = False
      Size = 1
    end
    object selTabellaHMASSENZA: TStringField
      FieldName = 'HMASSENZA'
      Visible = False
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaHMASSENZA_PROPPT: TStringField
      FieldName = 'HMASSENZA_PROPPT'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_COMPATIBILI: TStringField
      FieldName = 'CAUSALI_COMPATIBILI'
      Visible = False
      OnGetText = selTabellaCAUSALI_COMPATIBILIGetText
      Size = 2000
    end
    object selTabellaSTATO_COMPATIBILITA: TStringField
      FieldName = 'STATO_COMPATIBILITA'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALI_CHECKCOMPETENZE: TStringField
      FieldName = 'CAUSALI_CHECKCOMPETENZE'
      Visible = False
      Size = 100
    end
    object selTabellaCAUSALE_VISUALCOMPETENZE: TStringField
      FieldName = 'CAUSALE_VISUALCOMPETENZE'
      Visible = False
      Size = 5
    end
    object selTabellaSCARICOPAGHE_FRUIZ_GG: TStringField
      FieldName = 'SCARICOPAGHE_FRUIZ_GG'
      Visible = False
      Size = 1
    end
    object selTabellaSCARICOPAGHE_FRUIZ_ORE: TStringField
      FieldName = 'SCARICOPAGHE_FRUIZ_ORE'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALE_FRUIZORE: TStringField
      FieldName = 'CAUSALE_FRUIZORE'
      Visible = False
      Size = 5
    end
    object selTabellaCAUSALE_HMASSENZA: TStringField
      FieldName = 'CAUSALE_HMASSENZA'
      Visible = False
      Size = 5
    end
    object selTabellaCHECK_SOLOCOMPETENZE: TStringField
      FieldName = 'CHECK_SOLOCOMPETENZE'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM: TStringField
      FieldName = 'TIMB_PM'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_H: TStringField
      FieldName = 'TIMB_PM_H'
      Visible = False
      Size = 1
    end
    object selTabellaTIMB_PM_DETRAZ: TStringField
      FieldName = 'TIMB_PM_DETRAZ'
      Visible = False
      Size = 1
    end
    object selTabellaCAUS_CHECKNOCOMP_I: TStringField
      FieldName = 'CAUS_CHECKNOCOMP_I'
      Visible = False
      Size = 2000
    end
    object selTabellaCAUS_CHECKNOCOMP_M: TStringField
      FieldName = 'CAUS_CHECKNOCOMP_M'
      Visible = False
      Size = 2000
    end
    object selTabellaCAUS_CHECKNOCOMP_N: TStringField
      FieldName = 'CAUS_CHECKNOCOMP_N'
      Visible = False
      Size = 2000
    end
    object selTabellaCAUS_CHECKNOCOMP_D: TStringField
      FieldName = 'CAUS_CHECKNOCOMP_D'
      Visible = False
      Size = 2000
    end
    object selTabellaGIUST_DAA_RECUP_FLEX: TStringField
      FieldName = 'GIUST_DAA_RECUP_FLEX'
      Visible = False
      Size = 1
    end
    object selTabellaABBATTE_STRIND: TStringField
      FieldName = 'ABBATTE_STRIND'
      Visible = False
      Size = 1
    end
    object selTabellaINTERSEZIONE_TIMBRATURE: TStringField
      FieldName = 'INTERSEZIONE_TIMBRATURE'
      Visible = False
      Size = 1
    end
    object selTabellaCONTEGGIO_TIMB_INTERNA: TStringField
      FieldName = 'CONTEGGIO_TIMB_INTERNA'
      Visible = False
      Size = 1
    end
    object selTabellaSCELTA_ORARIO: TStringField
      FieldName = 'SCELTA_ORARIO'
      Visible = False
      Size = 1
    end
    object selTabellaINDPRES: TStringField
      FieldName = 'INDPRES'
      Visible = False
      Size = 1
    end
    object selTabellaINDPRES_FESTIVO: TStringField
      FieldName = 'INDPRES_FESTIVO'
      Visible = False
      Size = 1
    end
    object selTabellaINDTURNO: TStringField
      FieldName = 'INDTURNO'
      Visible = False
      Size = 1
    end
    object selTabellaFRUIZ_INTERNA_PN: TStringField
      FieldName = 'FRUIZ_INTERNA_PN'
      Visible = False
      Size = 1
    end
    object selTabellaCM_CAUSPRES_INCLUSE: TStringField
      FieldName = 'CM_CAUSPRES_INCLUSE'
      Visible = False
      Size = 2000
    end
    object selTabellaCOMPETENZE_PERSONALIZZATE: TStringField
      FieldName = 'COMPETENZE_PERSONALIZZATE'
      Visible = False
      Size = 1
    end
    object selTabellaARROT_COMPETENZE: TStringField
      FieldName = 'ARROT_COMPETENZE'
      Visible = False
      Size = 1
    end
    object selTabellaARROT_RESIDUI: TStringField
      FieldName = 'ARROT_RESIDUI'
      Visible = False
      Size = 1
    end
    object selTabellaCONDIZIONE_ALLEGATI: TStringField
      FieldName = 'CONDIZIONE_ALLEGATI'
      Visible = False
      Size = 1
    end
    object selTabellaGEDAP_CAUSALE: TStringField
      FieldName = 'GEDAP_CAUSALE'
      Visible = False
      Size = 5
    end
    object selTabellaGEDAP_TIPO: TStringField
      FieldName = 'GEDAP_TIPO'
      Visible = False
      Size = 1
    end
  end
  inherited dsrTabella: TDataSource
    OnDataChange = dsrTabellaDataChange
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select ID,CODICE,DESCRIZIONE,TIPOCUMULO'
      'from T265_CAUASSENZE T'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 32
    Top = 136
  end
end
