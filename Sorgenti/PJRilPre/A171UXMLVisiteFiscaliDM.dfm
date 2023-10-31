inherited A171FXMLVisiteFiscaliDM: TA171FXMLVisiteFiscaliDM
  OldCreateOrder = True
  Height = 86
  Width = 127
  object selT049: TOracleDataSet
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
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000140000003A0045004C00410042004F005200410054004F00010000000000
      000000000000}
    UpdatingTable = 'T049_XMLVISITEFISCALI'
    BeforeInsert = selT049BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterScroll = selT049AfterScroll
    OnCalcFields = selT049CalcFields
    Left = 24
    Top = 16
    object selT049DATA_RICHIESTA: TDateTimeField
      DisplayLabel = 'Data richiesta'
      DisplayWidth = 10
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT049ORA_RICHIESTA: TStringField
      DisplayLabel = 'Ora richiesta'
      DisplayWidth = 8
      FieldName = 'ORA_RICHIESTA'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT049PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT049COGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 20
      FieldName = 'COGNOME'
      ReadOnly = True
      Size = 50
    end
    object selT049NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'NOME'
      ReadOnly = True
      Size = 50
    end
    object selT049CODFISCALE: TStringField
      DisplayLabel = 'Codice fiscale'
      DisplayWidth = 20
      FieldName = 'CODFISCALE'
      ReadOnly = True
      Size = 16
    end
    object selT049IndComuneCAP: TStringField
      DisplayLabel = 'Indirizzo - Comune - Cap'
      DisplayWidth = 50
      FieldKind = fkCalculated
      FieldName = 'IndComuneCAP'
      Size = 150
      Calculated = True
    end
    object selT049D_DETTAGLI_INDIRIZZO: TStringField
      DisplayLabel = 'Dettagli indirizzo'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_DETTAGLI_INDIRIZZO'
      Size = 50
      Calculated = True
    end
    object selT049D_TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldKind = fkCalculated
      FieldName = 'D_TELEFONO'
      Size = 15
      Calculated = True
    end
    object selT049TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Visible = False
      Size = 15
    end
    object selT049INIZIO_MAL: TDateTimeField
      DisplayLabel = 'Inizio mal.'
      DisplayWidth = 10
      FieldName = 'INIZIO_MAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT049FINE_MAL: TDateTimeField
      DisplayLabel = 'Fine mal.'
      DisplayWidth = 10
      FieldName = 'FINE_MAL'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT049MALATTIA_FERIE: TStringField
      DisplayLabel = 'Mal. in ferie'
      FieldName = 'MALATTIA_FERIE'
      Size = 1
    end
    object selT049DATA_VISITA: TDateTimeField
      DisplayLabel = 'Data visita'
      DisplayWidth = 10
      FieldName = 'DATA_VISITA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT049DataUltimaVisita: TDateTimeField
      DisplayLabel = 'Data ultima visita'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'DataUltimaVisita'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
      Calculated = True
    end
    object selT049ELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'ELABORATO'
      Visible = False
      Size = 1
    end
    object selT049CONFERMA_AMB: TStringField
      DisplayLabel = 'Conferma amb.'
      FieldName = 'CONFERMA_AMB'
      Size = 1
    end
    object selT049ACCETTA_ATTI_MED: TStringField
      DisplayLabel = 'Accetta atti med.'
      FieldName = 'ACCETTA_ATTI_MED'
      Size = 1
    end
    object selT049TIPO_AMB_DOM: TStringField
      DisplayLabel = 'Tipo amb./dom.'
      FieldName = 'TIPO_AMB_DOM'
      Size = 1
    end
    object selT049ORARIO_VISITA: TStringField
      DisplayLabel = 'Orario visita'
      FieldName = 'ORARIO_VISITA'
      Size = 1
    end
    object selT049OBBLIGO_ORARIO: TStringField
      DisplayLabel = 'Obbligo orario'
      FieldName = 'OBBLIGO_ORARIO'
      Size = 1
    end
    object selT049CODCATASTALE_REP: TStringField
      DisplayLabel = 'Cod. comune rep.'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE_REP'
      OnChange = selT049CODCATASTALE_REPChange
      Size = 4
    end
    object selT049DescComuneRep: TStringField
      DisplayLabel = 'Comune rep.'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DescComuneRep'
      LookupDataSet = A171FXMLVisiteFiscaliMW.selT480
      LookupKeyFields = 'CODCATASTALE'
      LookupResultField = 'CITTA'
      KeyFields = 'CODCATASTALE_REP'
      Size = 70
      Lookup = True
    end
    object selT049CAP_REP: TStringField
      DisplayLabel = 'CAP rep.'
      FieldName = 'CAP_REP'
      Size = 5
    end
    object selT049VIA_REP: TStringField
      DisplayLabel = 'Indirizzo rep.'
      DisplayWidth = 40
      FieldName = 'VIA_REP'
      Size = 80
    end
    object selT049D_DETTAGLI_INDIRIZZO_REP: TStringField
      DisplayLabel = 'Dettagli indirizzo rep.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'D_DETTAGLI_INDIRIZZO_REP'
      Size = 50
      Calculated = True
    end
    object selT049COGNOME_REP: TStringField
      DisplayLabel = 'Cognome rep.'
      DisplayWidth = 20
      FieldName = 'COGNOME_REP'
      Size = 60
    end
    object selT049DETTAGLI_INDIRIZZO: TStringField
      DisplayLabel = 'Dettagli indirizzo rep.'
      DisplayWidth = 20
      FieldName = 'DETTAGLI_INDIRIZZO'
      Visible = False
      Size = 50
    end
  end
end
