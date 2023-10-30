inherited WA046FTerMensaDM: TWA046FTerMensaDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T360.*,T360.ROWID FROM T360_TERMENSA T360'
      'ORDER BY CODICE')
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaD_CODICE: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'D_CODICE'
      Size = 40
      Calculated = True
    end
    object selTabellaNUMTIMBPASTO: TStringField
      DisplayLabel = 'Timbrature per pasto'
      FieldName = 'NUMTIMBPASTO'
      Origin = 'T360_TERMENSA.NUMTIMBPASTO'
      Required = True
      Size = 1
    end
    object SelTabellaDIFFTRA2TIMB: TDateTimeField
      DisplayLabel = 'Intervallo minimo tra due pasti'
      FieldName = 'DIFFTRA2TIMB'
      Origin = 'T360_TERMENSA.DIFFTRA2TIMB'
      OnGetText = Q360TerMensaDIFFTRA2TIMBGetText
      OnSetText = SelTabellaDIFFTRA2TIMBSetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaMENSA_STIMBRATA: TStringField
      FieldName = 'MENSA_STIMBRATA'
      Visible = False
      Size = 1
    end
    object selTabellaMENSA_NON_STIMBRATA: TStringField
      FieldName = 'MENSA_NON_STIMBRATA'
      Visible = False
      Size = 1
    end
    object selTabellaTIMBANTECENTRATA: TStringField
      FieldName = 'TIMBANTECENTRATA'
      Origin = 'T360_TERMENSA.TIMBANTECENTRATA'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaTIMBDOPOUSCITA: TStringField
      FieldName = 'TIMBDOPOUSCITA'
      Origin = 'T360_TERMENSA.TIMBDOPOUSCITA'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaCONTROLLOPRESENZA: TStringField
      FieldName = 'CONTROLLOPRESENZA'
      Origin = 'T360_TERMENSA.CONTROLLOPRESENZA'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaINTERVALLO: TStringField
      FieldName = 'INTERVALLO'
      Required = True
      Visible = False
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaPAUSAMENSAGESTITA: TStringField
      FieldName = 'PAUSAMENSAGESTITA'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaPRESENZAMINIMA: TStringField
      FieldName = 'PRESENZAMINIMA'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaVOCEPAGHE1: TStringField
      DisplayLabel = 'Voce paghe imp. convenzionato'
      FieldName = 'VOCEPAGHE1'
      Size = 6
    end
    object selTabellaVOCEPAGHE2: TStringField
      DisplayLabel = 'Voce paghe imp. intero'
      FieldName = 'VOCEPAGHE2'
      Size = 6
    end
    object selTabellaORARIOSPEZZATO: TStringField
      FieldName = 'ORARIOSPEZZATO'
      Visible = False
      Size = 1
    end
    object selTabellaCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Visible = False
      Size = 1
    end
    object selTabellaMENSA_DALLE: TStringField
      DisplayLabel = 'Accesso mensa dalle'
      DisplayWidth = 5
      FieldName = 'MENSA_DALLE'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaMENSA_ALLE: TStringField
      DisplayLabel = 'Accesso mensa alle'
      FieldName = 'MENSA_ALLE'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaCENA_DALLE: TStringField
      DisplayLabel = 'Intervallo cena dalle'
      DisplayWidth = 5
      FieldName = 'CENA_DALLE'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaCENA_ALLE: TStringField
      DisplayLabel = 'Intervallo cena alle'
      FieldName = 'CENA_ALLE'
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaORE_MINIME: TStringField
      DisplayWidth = 5
      FieldName = 'ORE_MINIME'
      Visible = False
      EditMask = '!00.00;1;_'
      Size = 5
    end
    object selTabellaMENSA_STIMBRATA_INTERO: TStringField
      FieldName = 'MENSA_STIMBRATA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaMENSA_NON_STIMBRATA_INTERO: TStringField
      FieldName = 'MENSA_NON_STIMBRATA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaTIMBANTECENTRATA_INTERO: TStringField
      FieldName = 'TIMBANTECENTRATA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaTIMBDOPOUSCITA_INTERO: TStringField
      FieldName = 'TIMBDOPOUSCITA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaCONTROLLOPRESENZA_INTERO: TStringField
      FieldName = 'CONTROLLOPRESENZA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaORARIOSPEZZATO_INTERO: TStringField
      FieldName = 'ORARIOSPEZZATO_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaPAUSAMENSAGESTITA_INTERO: TStringField
      FieldName = 'PAUSAMENSAGESTITA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaPRESENZAMINIMA_INTERO: TStringField
      FieldName = 'PRESENZAMINIMA_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaINTERVALLO_INTERO: TStringField
      FieldName = 'INTERVALLO_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaORE_MINIME_INTERO: TStringField
      FieldName = 'ORE_MINIME_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaALIMENTA_BUONIPASTO: TStringField
      FieldName = 'ALIMENTA_BUONIPASTO'
      Visible = False
      Size = 1
    end
    object selTabellaMATURA_BUONO: TStringField
      FieldName = 'MATURA_BUONO'
      Visible = False
      Size = 1
    end
    object selTabellaMATURA_BUONO_INTERO: TStringField
      FieldName = 'MATURA_BUONO_INTERO'
      Visible = False
      Size = 1
    end
    object selTabellaINTERVALLO_PM_INTERO: TStringField
      FieldName = 'INTERVALLO_PM_INTERO'
      Visible = False
      EditMask = '!00.00;1;_'
      Size = 1
    end
  end
  object selInterfaccia: TOracleDataSet
    Optimize = False
    Left = 104
    Top = 16
  end
  object dsrInterfaccia: TDataSource
    DataSet = selInterfaccia
    Left = 102
    Top = 64
  end
end
