inherited WA094FSkLimitiStraordDM: TWA094FSkLimitiStraordDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T820.*,T820.ROWID FROM T820_LIMITIIND T820'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00080000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    BeforeEdit = BeforeEdit
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selTabellaANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 4
      FieldName = 'ANNO'
      Required = True
    end
    object selTabellaMESE: TIntegerField
      DisplayLabel = 'Mese'
      DisplayWidth = 2
      FieldName = 'MESE'
      Required = True
    end
    object selTabellaDAL: TIntegerField
      DisplayLabel = 'Dal'
      DisplayWidth = 2
      FieldName = 'DAL'
      EditFormat = '!'
      MaxValue = 31
    end
    object selTabellaAL: TIntegerField
      DisplayLabel = 'Al'
      DisplayWidth = 2
      FieldName = 'AL'
      MaxValue = 31
    end
    object selTabellaLIQUIDABILE: TStringField
      DisplayLabel = 'Liquidabile'
      FieldName = 'LIQUIDABILE'
      Required = True
      Size = 1
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 5
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selTabellaORE_TEORICHE: TStringField
      DisplayLabel = 'Ore teoriche'
      FieldName = 'ORE_TEORICHE'
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object selTabellaORE: TStringField
      DisplayLabel = 'Ore effettive'
      DisplayWidth = 7
      FieldName = 'ORE'
      EditMask = '!9900:00;1;_'
      Size = 7
    end
  end
end
