inherited WA080FRientriObbligatoriDM: TWA080FRientriObbligatoriDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T029.*, T029.rowid '
      'from T029_RIENTRI_OBBLIGATORI T029'
      'where CODICE = :TIPOCARTELLINO'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000001E0000003A005400490050004F0043004100520054004500
      4C004C0049004E004F00050000000000000000000000}
    BeforeEdit = BeforeEdit
    AfterScroll = nil
    OnNewRecord = selTabellaNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selTabellaGG_LAVORATIVI: TFloatField
      DisplayLabel = 'Giorni lavorativi'
      FieldName = 'GG_LAVORATIVI'
      Required = True
    end
    object selTabellaRIENTRI_OBBL: TFloatField
      DisplayLabel = 'Rientri obbligatori'
      FieldName = 'RIENTRI_OBBL'
      Required = True
    end
  end
end
