inherited WA100FMissioniDM: TWA100FMissioniDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT M040.*, M040.ROWID, '
      
        '       T850.TIPO_RICHIESTA, DECODE(T850.TIPO_RICHIESTA,'#39'A'#39','#39'RICH' +
        'IESTA ANNULLATA DAL DIPENDENTE'#39','#39#39') D_ANNULLATA,'
      '       M140.ID,       '
      '       M140.FLAG_DESTINAZIONE, '
      '       M140.FLAG_ISPETTIVA,'
      '       M140.MISSIONE_RIAPERTA'
      
        'FROM   M040_MISSIONI M040, T850_ITER_RICHIESTE T850, M140_RICHIE' +
        'STE_MISSIONI M140'
      'WHERE  M040.PROGRESSIVO = :PROGRESSIVO'
      'AND    T850.ID (+) = M040.ID_MISSIONE'
      'AND    T850.ITER (+) = '#39'M140'#39
      'AND    M140.ID (+) = M040.ID_MISSIONE'
      ':ORDERBY'
      '')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    SequenceField.Field = 'ID_MISSIONE'
    SequenceField.Sequence = 'T850_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    OnApplyRecord = selTabellaApplyRecord
    Filtered = True
    AfterOpen = selTabellaAfterOpen
    BeforeEdit = BeforeEdit
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    OnPostError = selTabellaPostError
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaMESESCARICO: TDateTimeField
      DisplayLabel = 'Mese scarico'
      FieldName = 'MESESCARICO'
      OnGetText = selTabellaMESESCARICOGetText
      OnSetText = selTabellaMESESCARICOSetText
      DisplayFormat = 'mm/yyyy'
    end
    object selTabellaMESECOMPETENZA: TDateTimeField
      DisplayLabel = 'Mese competenza'
      FieldName = 'MESECOMPETENZA'
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selTabellaDATADA: TDateTimeField
      DisplayLabel = 'Dal'
      FieldName = 'DATADA'
    end
    object selTabellaORADA: TStringField
      DisplayLabel = 'Dalle'
      DisplayWidth = 5
      FieldName = 'ORADA'
      Size = 5
    end
    object selTabellaDATAA: TDateTimeField
      DisplayLabel = 'Al'
      FieldName = 'DATAA'
    end
    object selTabellaORAA: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ORAA'
      Size = 5
    end
    object selTabellaPARTENZA: TStringField
      DisplayLabel = 'Partenza'
      FieldName = 'PARTENZA'
      Size = 100
    end
    object selTabelladescpartenza: TStringField
      DisplayLabel = 'Desc.partenza'
      FieldKind = fkLookup
      FieldName = 'descpartenza'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PARTENZA'
      Size = 80
      Lookup = True
    end
    object selTabellaDESTINAZIONE: TStringField
      DisplayLabel = 'Destinazione'
      FieldName = 'DESTINAZIONE'
      Size = 100
    end
    object selTabellaPROTOCOLLO: TStringField
      DisplayLabel = 'Protocollo'
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object selTabellaSTATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
    end
    object selTabellaTOTALEGG: TFloatField
      FieldName = 'TOTALEGG'
      Visible = False
    end
    object selTabellaFLAG_DESTINAZIONE: TStringField
      DisplayLabel = 'Territorio'
      FieldName = 'FLAG_DESTINAZIONE'
      ReadOnly = True
      Size = 1
    end
    object selTabellaFLAG_ISPETTIVA: TStringField
      DisplayLabel = 'Ispettiva'
      FieldName = 'FLAG_ISPETTIVA'
      ReadOnly = True
      Size = 1
    end
    object selTabellaTIPOREGISTRAZIONE: TStringField
      DisplayLabel = 'Registrazione'
      FieldName = 'TIPOREGISTRAZIONE'
      Required = True
      Visible = False
      Size = 5
    end
    object selTabellaDURATA: TStringField
      FieldName = 'DURATA'
      Visible = False
      Size = 7
    end
    object selTabellaTARIFFAINDINTERA: TFloatField
      FieldName = 'TARIFFAINDINTERA'
      Visible = False
      OnValidate = selTabellaTARIFFAINDINTERAValidate
    end
    object selTabellaOREINDINTERA: TFloatField
      FieldName = 'OREINDINTERA'
      Visible = False
      OnValidate = selTabellaTARIFFAINDINTERAValidate
    end
    object selTabellaIMPORTOINDINTERA: TFloatField
      FieldName = 'IMPORTOINDINTERA'
      Visible = False
    end
    object selTabellaTARIFFAINDRIDOTTAH: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAH'
      Visible = False
      OnValidate = INDRIDOTTAHValidate
    end
    object selTabellaOREINDRIDOTTAH: TFloatField
      FieldName = 'OREINDRIDOTTAH'
      Visible = False
      OnValidate = INDRIDOTTAHValidate
    end
    object selTabellaIMPORTOINDRIDOTTAH: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAH'
      Visible = False
    end
    object selTabellaTARIFFAINDRIDOTTAG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAG'
      Visible = False
      OnValidate = selTabellaTARIFFAINDRIDOTTAGValidate
    end
    object selTabellaOREINDRIDOTTAG: TFloatField
      FieldName = 'OREINDRIDOTTAG'
      Visible = False
      OnValidate = selTabellaTARIFFAINDRIDOTTAGValidate
    end
    object selTabellaIMPORTOINDRIDOTTAG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAG'
      Visible = False
    end
    object selTabellaTARIFFAINDRIDOTTAHG: TFloatField
      FieldName = 'TARIFFAINDRIDOTTAHG'
      Visible = False
      OnValidate = selTabellaTARIFFAINDRIDOTTAHGValidate
    end
    object selTabellaOREINDRIDOTTAHG: TFloatField
      FieldName = 'OREINDRIDOTTAHG'
      Visible = False
      OnValidate = selTabellaTARIFFAINDRIDOTTAHGValidate
    end
    object selTabellaIMPORTOINDRIDOTTAHG: TFloatField
      FieldName = 'IMPORTOINDRIDOTTAHG'
      Visible = False
    end
    object selTabellaFLAG_MODIFICATO: TStringField
      FieldName = 'FLAG_MODIFICATO'
      Visible = False
      Size = 1
    end
    object selTabellaTotaleOreIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleOreIndennita'
      Visible = False
      Calculated = True
    end
    object selTabellaTotaleImportiIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleImportiIndennita'
      Visible = False
      Calculated = True
    end
    object selTabellaTotaleKmIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleKmIndennita'
      Visible = False
      Calculated = True
    end
    object selTabellaTotaleImportiKmIndennita: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleImportiKmIndennita'
      Visible = False
      Calculated = True
    end
    object selTabellaTotaleMissione: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotaleMissione'
      Visible = False
      Calculated = True
    end
    object selTabellaCostoMissione: TFloatField
      FieldKind = fkCalculated
      FieldName = 'CostoMissione'
      Visible = False
      Calculated = True
    end
    object selTabellaNOTE_RIMBORSI: TStringField
      FieldName = 'NOTE_RIMBORSI'
      Visible = False
      Size = 240
    end
    object selTabelladesctipomissione: TStringField
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'desctipomissione'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPOREGISTRAZIONE'
      Visible = False
      Size = 40
      Lookup = True
    end
    object selTabellaCOMMESSA: TStringField
      FieldName = 'COMMESSA'
      Visible = False
      Size = 80
    end
    object selTabelladesccommessa: TStringField
      FieldKind = fkLookup
      FieldName = 'desccommessa'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COMMESSA'
      Visible = False
      Size = 80
      Lookup = True
    end
    object selTabellaCOD_TARIFFA: TStringField
      FieldName = 'COD_TARIFFA'
      Visible = False
    end
    object selTabellaCOD_RIDUZIONE: TStringField
      FieldName = 'COD_RIDUZIONE'
      Visible = False
    end
    object selTabelladesctariffa: TStringField
      FieldKind = fkCalculated
      FieldName = 'desctariffa'
      Visible = False
      Size = 80
      Calculated = True
    end
    object selTabellaID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
      Visible = False
    end
    object selTabellaTIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Visible = False
      Size = 1
    end
    object selTabellaD_ANNULLATA: TStringField
      FieldName = 'D_ANNULLATA'
      Visible = False
      Size = 40
    end
    object selTabellaID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaMISSIONE_RIAPERTA: TStringField
      FieldName = 'MISSIONE_RIAPERTA'
      Visible = False
      Size = 1
    end
  end
  inherited dsrTabella: TDataSource
    OnDataChange = dsrTabellaDataChange
  end
  object dsrM050: TDataSource
    Left = 48
    Top = 128
  end
end
