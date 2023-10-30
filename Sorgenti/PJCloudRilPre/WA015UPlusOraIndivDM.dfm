inherited WA015FPlusOraIndivDM: TWA015FPlusOraIndivDM
  Height = 129
  Width = 292
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T090.*,T090.ROWID FROM T090_PLUSORAINDIV T090'
      'WHERE PROGRESSIVO = :PROGRESSIVO '
      ':ORDERBY')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    OnNewRecord = OnNewRecord
    OnPostError = selTabellaPostError
    object T090Progressivo: TFloatField
      FieldName = 'Progressivo'
      Visible = False
    end
    object T090Anno: TFloatField
      FieldName = 'Anno'
      Required = True
    end
    object T090DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object T090TipoPO: TStringField
      FieldName = 'TipoPO'
      Required = True
      Visible = False
      Size = 1
    end
    object T090TipoDebito: TStringField
      DisplayLabel = 'Debito'
      FieldName = 'TipoDebito'
      Required = True
      Size = 1
    end
    object selTabellaOre1: TStringField
      DisplayLabel = 'Gennaio'
      FieldName = 'Ore1'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre2: TStringField
      DisplayLabel = 'Febbraio'
      FieldName = 'Ore2'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre3: TStringField
      DisplayLabel = 'Marzo'
      FieldName = 'Ore3'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre4: TStringField
      DisplayLabel = 'Aprile'
      FieldName = 'Ore4'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre5: TStringField
      DisplayLabel = 'Maggio'
      FieldName = 'Ore5'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre6: TStringField
      DisplayLabel = 'Giugno'
      FieldName = 'Ore6'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre7: TStringField
      DisplayLabel = 'Luglio'
      FieldName = 'Ore7'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre8: TStringField
      DisplayLabel = 'Agosto'
      FieldName = 'Ore8'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre9: TStringField
      DisplayLabel = 'Settembre'
      FieldName = 'Ore9'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre10: TStringField
      DisplayLabel = 'Ottobre'
      FieldName = 'Ore10'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre11: TStringField
      DisplayLabel = 'Novembre'
      FieldName = 'Ore11'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaOre12: TStringField
      DisplayLabel = 'Dicembre'
      FieldName = 'Ore12'
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object selTabellaTipoGest1: TStringField
      FieldName = 'TipoGest1'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest2: TStringField
      FieldName = 'TipoGest2'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest3: TStringField
      FieldName = 'TipoGest3'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest4: TStringField
      FieldName = 'TipoGest4'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest5: TStringField
      FieldName = 'TipoGest5'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest6: TStringField
      FieldName = 'TipoGest6'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest7: TStringField
      FieldName = 'TipoGest7'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest8: TStringField
      FieldName = 'TipoGest8'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest9: TStringField
      FieldName = 'TipoGest9'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest10: TStringField
      FieldName = 'TipoGest10'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest11: TStringField
      FieldName = 'TipoGest11'
      Visible = False
      Size = 1
    end
    object selTabellaTipoGest12: TStringField
      FieldName = 'TipoGest12'
      Visible = False
      Size = 1
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
