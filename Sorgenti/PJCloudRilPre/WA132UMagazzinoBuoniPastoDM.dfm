inherited WA132FMagazzinoBuoniPastoDM: TWA132FMagazzinoBuoniPastoDM
  Height = 176
  Width = 299
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID from T691_MAGAZZINOBUONI T'
      ':where'
      ' :ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000000C0000003A00570048004500520045000100000000000000
      00000000}
    BeforePost = BeforePostNoStorico
    object selTabellaDATA_ACQUISTO: TDateTimeField
      DisplayLabel = 'Data acquisto'
      FieldName = 'DATA_ACQUISTO'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDATA_SCADENZA: TDateTimeField
      DisplayLabel = 'Data scadenza'
      FieldName = 'DATA_SCADENZA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDIM_BLOCCHETTO: TIntegerField
      DisplayLabel = 'Buoni per blocchetto'
      FieldName = 'DIM_BLOCCHETTO'
    end
    object selTabellaID_DAL: TFloatField
      DisplayLabel = 'Dal blocchetto'
      FieldName = 'ID_DAL'
    end
    object selTabellaID_AL: TFloatField
      DisplayLabel = 'Al blocchetto'
      FieldName = 'ID_AL'
    end
    object selTabellaBUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      FieldName = 'BUONIPASTO'
    end
    object selTabellaTICKET: TIntegerField
      DisplayLabel = 'Ticket'
      FieldName = 'TICKET'
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 112
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 112
  end
  inherited selT900: TOracleDataSet
    Left = 184
  end
  inherited selT901: TOracleDataSet
    Left = 240
  end
end
