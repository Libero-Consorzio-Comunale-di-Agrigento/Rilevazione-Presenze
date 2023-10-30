inherited WA073FAcquistoBuoniDM: TWA073FAcquistoBuoniDM
  Height = 129
  Width = 312
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T690.*,T690.ROWID FROM T690_ACQUISTOBUONI T690'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ' :ORDERBY'
      '/*'
      'SELECT t690.*, t690.ROWID '
      'FROM t690_acquistobuoni t690 '
      'WHERE t690.progressivo = :PROGRESSIVO'
      'GROUP BY t690.progressivo, t690.data, '
      '         t690.buonipasto, t690.ticket, '
      '         t690.buoni_auto, t690.ticket_auto, '
      '         t690.buoni_recuperati, t690.buoni_recuperati_prec, '
      '         t690.ticket_recuperati, t690.ticket_recuperati_prec, '
      '         t690.note, t690.data_scadenza, t690.ROWID '
      'ORDER BY t690.data desc'
      '*/')
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterPost
    OnNewRecord = OnNewRecord
    object Q690PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data acquisto'
      DisplayWidth = 10
      FieldName = 'DATA'
      OnValidate = selTabellaDATAValidate
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaDATA_MAGAZZINO: TDateTimeField
      DisplayLabel = 'Data Magazzino'
      FieldName = 'DATA_MAGAZZINO'
      Visible = False
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaID_BLOCCHETTI: TStringField
      DisplayLabel = 'Blocchetti acquistati'
      DisplayWidth = 15
      FieldName = 'ID_BLOCCHETTI'
      OnValidate = selTabellaID_BLOCCHETTIValidate
      Size = 100
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 20
      FieldName = 'NOTE'
      Size = 200
    end
    object selTabellaBUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      DisplayWidth = 5
      FieldName = 'BUONIPASTO'
    end
    object selTabellaBUONI_AUTO: TIntegerField
      DisplayLabel = 'Buoni automatici'
      DisplayWidth = 5
      FieldName = 'BUONI_AUTO'
      ReadOnly = True
    end
    object selTabellaBUONI_RECUPERATI: TIntegerField
      DisplayLabel = 'Buoni recuperati'
      DisplayWidth = 5
      FieldName = 'BUONI_RECUPERATI'
      ReadOnly = True
    end
    object selTabellaTICKET: TIntegerField
      DisplayLabel = 'Ticket'
      DisplayWidth = 5
      FieldName = 'TICKET'
    end
    object selTabellaTICKET_AUTO: TIntegerField
      DisplayLabel = 'Ticket automatici'
      DisplayWidth = 5
      FieldName = 'TICKET_AUTO'
      ReadOnly = True
    end
    object selTabellaTICKET_RECUPERATI: TIntegerField
      DisplayLabel = 'Ticket recuperati'
      DisplayWidth = 5
      FieldName = 'TICKET_RECUPERATI'
      ReadOnly = True
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 200
  end
  inherited selT901: TOracleDataSet
    Left = 256
  end
end
