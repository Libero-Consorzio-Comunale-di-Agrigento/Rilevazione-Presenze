inherited WA039FRegReperibDM: TWA039FRegReperibDM
  Height = 118
  Width = 293
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T350.*,T350.ROWID '
      '  FROM T350_REGREPERIB T350'
      ' :ORDERBY')
    CachedUpdates = True
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    AfterDelete = AfterDelete
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Required = True
      Size = 40
    end
    object selTabellaSIGLA: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLA'
      Size = 5
    end
    object selTabellaTIPOLOGIA: TStringField
      DisplayLabel = 'Tipologia turno'
      FieldName = 'TIPOLOGIA'
      Size = 1
    end
    object selTabellaORAINIZIO: TDateTimeField
      DisplayLabel = 'Inizio'
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
      Required = True
      OnGetText = selTabellaORAINIZIOGetText
      OnSetText = SetTextOre
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaORAFINE: TDateTimeField
      DisplayLabel = 'Fine'
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
      Required = True
      OnGetText = selTabellaORAINIZIOGetText
      OnSetText = SetTextOre
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaTURNO_INTERO: TStringField
      DisplayLabel = 'Durata turno intero'
      FieldName = 'TURNO_INTERO'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object selTabellaTIPOORE: TStringField
      DisplayLabel = 'Suddivisione ore'
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Visible = False
      Size = 1
    end
    object selTabellaORENORMALI: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
      Visible = False
      OnGetText = selTabellaORAINIZIOGetText
      OnSetText = SetTextOre
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaORECOMPRESENZA: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
      Origin = 'T350_REGREPERIB.ORECOMPRESENZA'
      Visible = False
      OnGetText = selTabellaORAINIZIOGetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaTIPOTURNO: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.TIPOTURNO'
      Visible = False
      OnValidate = selTabellaTIPOTURNOValidate
      Size = 1
    end
    object selTabellaRAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.RAGGRUPPAMENTO'
      Visible = False
    end
    object selTabellaORENONCAUS: TStringField
      FieldName = 'ORENONCAUS'
      Origin = 'T350_REGREPERIB.CODICE'
      Visible = False
      Size = 1
    end
    object selTabellaTOLLERANZA: TFloatField
      FieldName = 'TOLLERANZA'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Visible = False
      MaxValue = 99.000000000000000000
    end
    object selTabellaVP_TURNO: TStringField
      DisplayLabel = 'Voce turni interi'
      FieldName = 'VP_TURNO'
      Size = 6
    end
    object selTabellaVP_ORE: TStringField
      DisplayLabel = 'Voce ore'
      FieldName = 'VP_ORE'
      Size = 6
    end
    object selTabellaVP_MAGGIORATE: TStringField
      DisplayLabel = 'Voce ore magg.'
      FieldName = 'VP_MAGGIORATE'
      Size = 6
    end
    object selTabellaVP_NONMAGGIORATE: TStringField
      DisplayLabel = 'Voce ore non magg.'
      FieldName = 'VP_NONMAGGIORATE'
      Size = 6
    end
    object selTabellaVP_GETTONE_CHIAMATA: TStringField
      FieldName = 'VP_GETTONE_CHIAMATA'
      Visible = False
      Size = 6
    end
    object selTabellaVP_TURNI_OLTREMAX: TStringField
      FieldName = 'VP_TURNI_OLTREMAX'
      Visible = False
      Size = 6
    end
    object selTabellaDETRAZ_MENSA: TStringField
      FieldName = 'DETRAZ_MENSA'
      Visible = False
      Size = 1
    end
    object selTabellaPIANIF_MAX_MESE: TIntegerField
      FieldName = 'PIANIF_MAX_MESE'
      Visible = False
      MaxValue = 99
      MinValue = 1
    end
    object selTabellaPIANIF_MAX_MESE_TURNI_INTERI: TStringField
      FieldName = 'PIANIF_MAX_MESE_TURNI_INTERI'
      Visible = False
      Size = 1
    end
    object selTabellaORE_MIN_INDENNITA: TStringField
      FieldName = 'ORE_MIN_INDENNITA'
      Visible = False
      OnValidate = selTabellaORE_MIN_INDENNITAValidate
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object selTabellaBLOCCA_MAX_MESE: TStringField
      FieldName = 'BLOCCA_MAX_MESE'
      Visible = False
      Size = 1
    end
    object selTabellaTOLL_CHIAMATA_INIZIO: TStringField
      FieldName = 'TOLL_CHIAMATA_INIZIO'
      OnValidate = selTabellaTOLL_CHIAMATA_INIZIOValidate
      Size = 5
    end
    object selTabellaTOLL_CHIAMATA_FINE: TStringField
      FieldName = 'TOLL_CHIAMATA_FINE'
      OnValidate = selTabellaTOLL_CHIAMATA_FINEValidate
      Size = 5
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 104
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 104
  end
  inherited selT900: TOracleDataSet
    Left = 192
  end
  inherited selT901: TOracleDataSet
    Left = 248
  end
end
