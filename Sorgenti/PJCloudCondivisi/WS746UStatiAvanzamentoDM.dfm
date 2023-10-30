inherited WS746FStatiAvanzamentoDM: TWS746FStatiAvanzamentoDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG746.*, SG746.ROWID'
      'FROM SG746_STATI_AVANZAMENTO SG746'
      ':ORDERBY'
      '')
    AfterOpen = selTabellaAfterOpen
    BeforePost = BeforePost
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODREGOLA: TStringField
      DisplayLabel = 'Cod. Regola'
      FieldName = 'CODREGOLA'
      OnValidate = selTabellaCODICEValidate
      Size = 5
    end
    object selTabellaDESCCODREGOLA: TStringField
      DisplayLabel = 'Desc. Cod. Regola'
      FieldKind = fkLookup
      FieldName = 'DESCCODREGOLA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODREGOLA'
      Size = 50
      Lookup = True
    end
    object selTabellaCODICE: TIntegerField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      OnValidate = selTabellaCODICEValidate
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      OnValidate = selTabellaDECORRENZAValidate
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      OnValidate = selTabellaCODICEValidate
      Size = 50
    end
    object selTabellaMODIFICABILE: TStringField
      DisplayLabel = 'Abil. Modifica'
      FieldName = 'MODIFICABILE'
      Visible = False
      Size = 1
    end
    object selTabellaCODSTAMPA: TIntegerField
      DisplayLabel = 'Cod. Stampa'
      FieldName = 'CODSTAMPA'
      Visible = False
    end
    object selTabellaDESCCODSTAMPA: TStringField
      DisplayLabel = 'Desc. Cod. Stampa'
      FieldKind = fkLookup
      FieldName = 'DESCCODSTAMPA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODSTAMPA'
      Visible = False
      Size = 50
      Lookup = True
    end
    object selTabellaDATA_DA: TDateTimeField
      DisplayLabel = 'Inizio periodo compilazione'
      FieldName = 'DATA_DA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATA_A: TDateTimeField
      DisplayLabel = 'Fine periodo compilazione'
      FieldName = 'DATA_A'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATA_DA_RICHIESTA_VISIONE: TDateTimeField
      DisplayLabel = 'Inizio periodo registra presa visione'
      FieldName = 'DATA_DA_RICHIESTA_VISIONE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATA_A_RICHIESTA_VISIONE: TDateTimeField
      DisplayLabel = 'Fine periodo registra presa visione'
      FieldName = 'DATA_A_RICHIESTA_VISIONE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaVAL_INTERM_MODIFICABILE: TStringField
      DisplayLabel = 'Val. Interm. Modificabile'
      FieldName = 'VAL_INTERM_MODIFICABILE'
      Visible = False
      Size = 1
    end
    object selTabellaVAL_INTERM_OBBLIGATORIA: TStringField
      DisplayLabel = 'Val. Interm. obbligatoria'
      FieldName = 'VAL_INTERM_OBBLIGATORIA'
      Visible = False
      Size = 1
    end
    object selTabellaCREA_AUTOVALUTAZIONE: TStringField
      DisplayLabel = 'Duplicabile in autovalutazione'
      FieldName = 'CREA_AUTOVALUTAZIONE'
      Visible = False
      Size = 1
    end
  end
end
