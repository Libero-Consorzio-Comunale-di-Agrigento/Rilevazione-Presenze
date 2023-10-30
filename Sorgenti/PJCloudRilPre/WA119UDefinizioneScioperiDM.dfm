inherited WA119FDefinizioneScioperiDM: TWA119FDefinizioneScioperiDM
  Height = 126
  Width = 392
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T250.*, '
      '       decode(T250.TIPOGIUST,'
      '              '#39'I'#39','#39'Giornata intera'#39','
      '              '#39'M'#39','#39'Mezza giornata'#39','
      '              '#39'N'#39','#39'Numero ore'#39','
      '              '#39'D'#39','#39'Da ore - a ore'#39','
      '              T250.TIPOGIUST) D_TIPOGIUST, '
      '       T250.ROWID'
      'from   T250_SCIOPERI T250'
      ':ORDERBY')
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T250_ID'
    OracleDictionary.DefaultValues = False
    BeforeEdit = BeforeEdit
    BeforeDelete = BeforeDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaID: TFloatField
      DisplayLabel = '(**) ID'
      DisplayWidth = 6
      FieldName = 'ID'
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaCAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selTabellaTIPOGIUST: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldName = 'TIPOGIUST'
      Visible = False
      Size = 1
    end
    object selTabellaD_TIPOGIUST: TStringField
      DisplayLabel = 'Tipo giust.'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPOGIUST'
    end
    object selTabellaDAORE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DAORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaAORE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'AORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaSELEZIONE_ANAGRAFICA: TStringField
      DisplayLabel = 'Sel. anagrafica'
      FieldName = 'SELEZIONE_ANAGRAFICA'
      Size = 2000
    end
    object selTabellaGG_NOTIFICA: TIntegerField
      DisplayLabel = 'GG. notifica'
      FieldName = 'GG_NOTIFICA'
      MaxValue = 99
    end
    object selTabellaD_GG_NOTIFICA: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_GG_NOTIFICA'
      Visible = False
      Size = 30
      Calculated = True
    end
  end
  inherited dsrTabella: TDataSource
    OnDataChange = dsrTabellaDataChange
  end
end
