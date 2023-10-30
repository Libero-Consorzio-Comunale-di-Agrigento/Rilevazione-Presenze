inherited WA147FRepVincoliIndividualiDM: TWA147FRepVincoliIndividualiDM
  Height = 135
  Width = 395
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from T385_VINCOLI_REPERIB t'
      'where tipologia = :TIPO'
      'and progressivo = :PROGRESSIVO'
      ':ORDERBY')
    Variables.Data = {
      0400000003000000100000003A004F0052004400450052004200590001000000
      00000000000000000A0000003A005400490050004F0005000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    BeforePost = BeforePostNoStorico
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selTabellaTIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaGIORNO: TStringField
      DisplayLabel = 'Giorno'
      FieldName = 'GIORNO'
      Required = True
      Size = 2
    end
    object selTabellaDescGiorno: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'DescGiorno'
      Size = 50
      Calculated = True
    end
    object selTabellaDISPONIBILE: TStringField
      DisplayLabel = 'Disponibilit'#224
      FieldName = 'DISPONIBILE'
      Size = 1
    end
    object selTabellaBLOCCA_PIANIF: TStringField
      DisplayLabel = 'Blocco'
      FieldName = 'BLOCCA_PIANIF'
      Size = 1
    end
    object selTabellaTURNI: TStringField
      DisplayLabel = 'Turni'
      DisplayWidth = 100
      FieldName = 'TURNI'
      Size = 1000
    end
  end
end
