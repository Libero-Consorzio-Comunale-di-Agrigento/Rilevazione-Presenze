inherited WA127FTurniPrestazioniAggiuntiveDM: TWA127FTurniPrestazioniAggiuntiveDM
  Height = 123
  Width = 392
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T330.*, T330.ROWID '
      'FROM T330_REG_ATT_AGGIUNTIVE T330'
      ':ORDERBY')
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaORAINIZIO: TDateTimeField
      DisplayLabel = 'Ora inizio'
      FieldName = 'ORAINIZIO'
      Required = True
      OnGetText = selTabellaORAINIZIOGetText
      OnSetText = selTabellaORAINIZIOSetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaORAFINE: TDateTimeField
      DisplayLabel = 'Ora fine'
      FieldName = 'ORAFINE'
      Required = True
      OnGetText = selTabellaORAINIZIOGetText
      OnSetText = selTabellaORAINIZIOSetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selTabellaCONTROLLO_PT: TStringField
      DisplayLabel = 'Controllo Part Time'
      FieldName = 'CONTROLLO_PT'
      Size = 1
    end
  end
end
