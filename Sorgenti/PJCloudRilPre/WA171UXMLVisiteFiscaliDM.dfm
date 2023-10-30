inherited WA171FXMLVisiteFiscaliDM: TWA171FXMLVisiteFiscaliDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'select T049.PROGRESSIVO,T030.COGNOME, T030.NOME, T030.CODFISCALE' +
        ', T049.CODCATASTALE_REP, T049.CAP_REP, T049.VIA_REP, '
      
        '       T049.COGNOME_REP, T049.DATA_RICHIESTA, T049.ORA_RICHIESTA' +
        ', T049.CONFERMA_AMB, T049.ACCETTA_ATTI_MED, T049.TIPO_AMB_DOM, '
      
        '       T049.DATA_VISITA, T049.ORARIO_VISITA, T049.OBBLIGO_ORARIO' +
        ', T049.MALATTIA_FERIE, T049.INIZIO_MAL, T049.FINE_MAL, '
      
        '       T049.ELABORATO, T049.DETTAGLI_INDIRIZZO, T049.TELEFONO, T' +
        '049.ROWID'
      '  from T049_XMLVISITEFISCALI T049, T030_ANAGRAFICO T030'
      ' where T030.PROGRESSIVO = T049.PROGRESSIVO'
      '   and T049.DATA_RICHIESTA between :DATADA and :DATAA'
      '   :ELABORATO'
      ' order by T049.DATA_RICHIESTA, T030.COGNOME, T030.NOME')
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      00000000000000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000140000003A0045004C00410042004F005200410054004F00010000000000
      000000000000}
    UpdatingTable = 'T049_XMLVISITEFISCALI'
    BeforeEdit = BeforeEdit
    OnCalcFields = selTabellaCalcFields
    object selTabellaDATA_RICHIESTA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data richiesta'
      DisplayWidth = 10
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaORA_RICHIESTA: TStringField
      DisplayLabel = 'Ora richiesta'
      FieldName = 'ORA_RICHIESTA'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 50
    end
    object selTabellaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object selTabellaCODFISCALE: TStringField
      DisplayLabel = 'Codice fiscale'
      FieldName = 'CODFISCALE'
      Size = 16
    end
    object selTabellaIndComuneCAP: TStringField
      DisplayLabel = 'Indirizzo - Comune - Cap'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'IndComuneCAP'
      Size = 100
      Calculated = True
    end
    object selTabellaD_DETTAGLI_INDIRIZZO: TStringField
      DisplayLabel = 'Dettagli indirizzo'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_DETTAGLI_INDIRIZZO'
      Size = 50
      Calculated = True
    end
    object selTabellaD_TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldKind = fkCalculated
      FieldName = 'D_TELEFONO'
      Size = 15
      Calculated = True
    end
    object selTabellaTELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Visible = False
      Size = 15
    end
    object selTabellaINIZIO_MAL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Inizio mal.'
      DisplayWidth = 10
      FieldName = 'INIZIO_MAL'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaFINE_MAL: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Fine mal.'
      DisplayWidth = 10
      FieldName = 'FINE_MAL'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaMALATTIA_FERIE: TStringField
      DisplayLabel = 'Mal. in ferie'
      FieldName = 'MALATTIA_FERIE'
      Size = 1
    end
    object selTabellaDATA_VISITA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data visita'
      DisplayWidth = 10
      FieldName = 'DATA_VISITA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDataUltimaVisita: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data ultima visita'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'DataUltimaVisita'
      DisplayFormat = 'DD/MM/YYYY'
      Calculated = True
    end
    object selTabellaELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'ELABORATO'
      Visible = False
      Size = 1
    end
    object selTabellaCONFERMA_AMB: TStringField
      DisplayLabel = 'Conferma amb.'
      FieldName = 'CONFERMA_AMB'
      Size = 1
    end
    object selTabellaACCETTA_ATTI_MED: TStringField
      DisplayLabel = 'Accetta atti med.'
      FieldName = 'ACCETTA_ATTI_MED'
      Size = 1
    end
    object selTabellaTIPO_AMB_DOM: TStringField
      DisplayLabel = 'Tipo Amb.\Dom.'
      FieldName = 'TIPO_AMB_DOM'
      Size = 1
    end
    object selTabellaORARIO_VISITA: TStringField
      DisplayLabel = 'Orario visita'
      FieldName = 'ORARIO_VISITA'
      Size = 1
    end
    object selTabellaOBBLIGO_ORARIO: TStringField
      DisplayLabel = 'Obbl. orario'
      FieldName = 'OBBLIGO_ORARIO'
      Size = 1
    end
    object selTabellaCODCATASTALE_REP: TStringField
      DisplayLabel = 'Cod. comune rep.'
      FieldName = 'CODCATASTALE_REP'
      Size = 4
    end
    object selTabellaDescComuneRep: TStringField
      DisplayLabel = 'Comune rep.'
      FieldKind = fkLookup
      FieldName = 'DescComuneRep'
      LookupDataSet = A171FXMLVisiteFiscaliMW.selT480
      LookupKeyFields = 'CODCATASTALE'
      LookupResultField = 'CITTA'
      KeyFields = 'CODCATASTALE_REP'
      Size = 70
      Lookup = True
    end
    object selTabellaCAP_REP: TStringField
      DisplayLabel = 'CAP rep.'
      FieldName = 'CAP_REP'
      Size = 5
    end
    object selTabellaVIA_REP: TStringField
      DisplayLabel = 'Indirizzo rep.'
      FieldName = 'VIA_REP'
      Size = 80
    end
    object selTabellaD_DETTAGLI_INDIRIZZO_REP: TStringField
      DisplayLabel = 'Dettagli indirizzo rep.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_DETTAGLI_INDIRIZZO_REP'
      Size = 50
      Calculated = True
    end
    object selTabellaCOGNOME_REP: TStringField
      DisplayLabel = 'Cognome rep.'
      FieldName = 'COGNOME_REP'
      Size = 60
    end
    object selTabellaDETTAGLI_INDIRIZZO: TStringField
      DisplayLabel = 'Dettagli indirizzo rep.'
      DisplayWidth = 20
      FieldName = 'DETTAGLI_INDIRIZZO'
      Visible = False
      Size = 50
    end
  end
end
