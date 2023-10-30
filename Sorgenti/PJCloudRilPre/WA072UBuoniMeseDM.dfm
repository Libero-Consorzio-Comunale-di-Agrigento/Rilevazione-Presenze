inherited WA072FBuoniMeseDM: TWA072FBuoniMeseDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T680.*,T680.ROWID FROM T680_BUONIMENSILI T680 WHERE '
      'PROGRESSIVO =:PROGRESSIVO'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00050000000000000000000000}
    AfterOpen = selTabellaAfterOpen
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterPost
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 5
      FieldName = 'ANNO'
      Required = True
    end
    object selTabellaMESE: TIntegerField
      DisplayLabel = 'Mese'
      DisplayWidth = 5
      FieldName = 'MESE'
      Required = True
      MaxValue = 12
      MinValue = 1
    end
    object selTabellaCALCMESE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'CALCMESE'
      ReadOnly = True
      Calculated = True
    end
    object selTabellaBUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      FieldName = 'BUONIPASTO'
      ReadOnly = True
    end
    object selTabellaVARBUONIPASTO: TIntegerField
      DisplayLabel = 'Variazioni'
      FieldName = 'VARBUONIPASTO'
    end
    object selTabellaTICKET: TIntegerField
      DisplayLabel = 'Ticket'
      FieldName = 'TICKET'
      ReadOnly = True
    end
    object selTabellaVARTICKET: TIntegerField
      DisplayLabel = 'Variazioni'
      FieldName = 'VARTICKET'
    end
  end
end
