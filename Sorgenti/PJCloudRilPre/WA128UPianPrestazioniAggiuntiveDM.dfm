inherited WA128FPianPrestazioniAggiuntiveDM: TWA128FPianPrestazioniAggiuntiveDM
  Height = 121
  Width = 392
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '    T332.DATA,'
      '    T332.PROGRESSIVO,'
      '    T332.TURNO1,'
      '    T332.ORAINIZIO_TURNO1,'
      '    T332.ORAFINE_TURNO1,'
      '    T332.TURNO2,'
      '    T332.ORAINIZIO_TURNO2,'
      '    T332.ORAFINE_TURNO2,'
      '    T332.ROWID,'
      '    T030.MATRICOLA,'
      '    T030.COGNOME||'#39' '#39'||T030.NOME NOMINATIVO'
      'FROM   '
      '    T332_PIAN_ATT_AGGIUNTIVE T332,'
      '    T030_ANAGRAFICO T030,'
      '    T480_COMUNI T480,'
      '    V430_STORICO V430  '
      'WHERE  '
      '    T030.PROGRESSIVO = T332.PROGRESSIVO AND'
      '    T332.DATA BETWEEN :DATADA AND :DATAA '
      '    :FILTRO'
      ':ORDERBY')
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      00000000000000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000}
    BeforeInsert = BeforeInsert
    AfterPost = AfterPost
    AfterDelete = AfterPost
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Required = True
      OnValidate = selTabellaDATAValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
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
      OnChange = selTabellaTURNOChange
      OnSetText = selTabellaTURNOSetText
      OnValidate = selTabellaTURNOValidate
      Size = 5
    end
    object selTabellaTURNO2: TStringField
      DisplayLabel = '2'#176' Turno'
      FieldName = 'TURNO2'
      OnSetText = selTabellaTURNOSetText
      OnValidate = selTabellaTURNOValidate
      Size = 5
    end
    object selTabellaORAINIZIO_TURNO1: TStringField
      DisplayLabel = 'Inizio 1'#176' Turno'
      FieldName = 'ORAINIZIO_TURNO1'
      OnChange = selTabellaORAChange
      OnSetText = selTabellaORASetText
      OnValidate = selTabellaORAValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaORAFINE_TURNO1: TStringField
      DisplayLabel = 'Fine 1'#176' Turno'
      FieldName = 'ORAFINE_TURNO1'
      OnChange = selTabellaORAChange
      OnSetText = selTabellaORASetText
      OnValidate = selTabellaORAValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaORAINIZIO_TURNO2: TStringField
      DisplayLabel = 'Inizio 2'#176' Turno'
      FieldName = 'ORAINIZIO_TURNO2'
      OnChange = selTabellaORAChange
      OnSetText = selTabellaORASetText
      OnValidate = selTabellaORAValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selTabellaORAFINE_TURNO2: TStringField
      DisplayLabel = 'Fine 2'#176' Turno'
      FieldName = 'ORAFINE_TURNO2'
      OnChange = selTabellaORAChange
      OnSetText = selTabellaORASetText
      OnValidate = selTabellaORAValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
  end
end
