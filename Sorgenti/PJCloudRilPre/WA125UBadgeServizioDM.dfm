inherited WA125FBadgeServizioDM: TWA125FBadgeServizioDM
  Height = 127
  Width = 305
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T435.*,T435.ROWID FROM T435_BADGESERVIZIO T435'
      'WHERE PROGRESSIVO = :Progressivo'
      ':orderby')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    OnNewRecord = OnNewRecord
    object selTabellaBADGESERV: TFloatField
      DisplayLabel = 'Numero di badge'
      DisplayWidth = 10
      FieldName = 'BADGESERV'
      Required = True
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza (data ed ora)'
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy hh:mm'
      EditMask = '!00/00/0000 00:00;1;_'
    end
    object selTabellaSCADENZA: TDateTimeField
      DisplayLabel = 'Scadenza (data ed ora)'
      FieldName = 'SCADENZA'
      DisplayFormat = 'dd/mm/yyyy hh:mm'
      EditMask = '!00/00/0000 00:00;1;_'
    end
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
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
