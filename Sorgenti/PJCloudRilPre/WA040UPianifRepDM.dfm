inherited WA040FPianifRepDM: TWA040FPianifRepDM
  Height = 241
  Width = 397
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T380.DATA,T380.PROGRESSIVO,T380.TURNO1,T380.PRIORITA1,T38' +
        '0.RECAPITO1,T380.TURNO2,T380.PRIORITA2,T380.RECAPITO2,T380.TURNO' +
        '3,T380.PRIORITA3,T380.RECAPITO3,'
      '       T380.DATOLIBERO,T380.TIPOLOGIA,T380.ROWID,'
      '       T030.MATRICOLA,T030.COGNOME||'#39' '#39'||T030.NOME NOMINATIVO'
      'FROM   T380_PIANIFREPERIB T380,'
      '       T030_ANAGRAFICO T030,'
      '       T480_COMUNI T480,'
      '       V430_STORICO V430       '
      'WHERE  T030.PROGRESSIVO = T380.PROGRESSIVO AND'
      '       T380.DATA BETWEEN :DATADA AND :DATAA AND'
      '       T380.TIPOLOGIA = :TIPOLOGIA'
      '      :FILTRO'
      ':ORDERBY')
    Variables.Data = {
      0400000005000000100000003A004F0052004400450052004200590001000000
      00000000000000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      0000140000003A005400490050004F004C004F00470049004100050000000000
      0000000000000E0000003A00460049004C00540052004F000100000000000000
      00000000}
    BeforeInsert = BeforeInsert
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterDelete = AfterPost
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      OnValidate = selTabellaDATAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selTabellaNOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      FieldName = 'NOMINATIVO'
      ReadOnly = True
      Size = 61
    end
    object selTabellaTURNO1: TStringField
      DisplayLabel = '1'#176' Turno'
      FieldName = 'TURNO1'
      Required = True
      OnSetText = TURNOSetText
      OnValidate = TURNOValidate
      Size = 5
    end
    object selTabellaPRIORITA1: TIntegerField
      DisplayLabel = 'Priorit'#224' 1'
      DisplayWidth = 2
      FieldName = 'PRIORITA1'
      MaxValue = 9
    end
    object selTabellaRECAPITO1: TStringField
      DisplayLabel = 'Rec. Alt. 1'
      DisplayWidth = 10
      FieldName = 'RECAPITO1'
      Size = 100
    end
    object selTabellaTURNO2: TStringField
      DisplayLabel = '2'#176' Turno'
      FieldName = 'TURNO2'
      OnSetText = TURNOSetText
      OnValidate = TURNOValidate
      Size = 5
    end
    object selTabellaPRIORITA2: TIntegerField
      DisplayLabel = 'Priorit'#224' 2'
      DisplayWidth = 2
      FieldName = 'PRIORITA2'
      MaxValue = 9
      MinValue = 1
    end
    object selTabellaRECAPITO2: TStringField
      DisplayLabel = 'Rec. Alt. 2'
      DisplayWidth = 10
      FieldName = 'RECAPITO2'
      Size = 100
    end
    object selTabellaTURNO3: TStringField
      DisplayLabel = '3'#176' Turno'
      FieldName = 'TURNO3'
      OnSetText = TURNOSetText
      OnValidate = TURNOValidate
      Size = 5
    end
    object selTabellaPRIORITA3: TIntegerField
      DisplayLabel = 'Priorit'#224' 3'
      DisplayWidth = 2
      FieldName = 'PRIORITA3'
      MaxValue = 9
      MinValue = 1
    end
    object selTabellaRECAPITO3: TStringField
      DisplayLabel = 'Rec. Alt. 3'
      DisplayWidth = 10
      FieldName = 'RECAPITO3'
      Size = 100
    end
    object selTabellaDATOLIBERO: TStringField
      FieldName = 'DATOLIBERO'
      OnSetText = selTabellaDATOLIBEROSetText
      OnValidate = selTabellaDATOLIBEROValidate
    end
    object selTabellaTIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Visible = False
      Size = 1
    end
  end
end
