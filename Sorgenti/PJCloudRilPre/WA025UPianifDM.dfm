inherited WA025FPianifDM: TWA025FPianifDM
  Height = 132
  Width = 309
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select T080.*, T080.ROWID '
      '  from T080_PIANIFORARI T080'
      ' where T080.PROGRESSIVO = :PROGRESSIVO '
      '   and T080.DATA between :DATA1 and :DATA2'
      ' :ORDERBY')
    Variables.Data = {
      0400000004000000100000003A004F0052004400450052004200590001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    BeforeDelete = BeforeDelete
    OnNewRecord = OnNewRecord
    object selTabellaPROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Origin = 'T080_PIANIFORARI.PROGRESSIVO'
      Visible = False
    end
    object selTabellaDATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Origin = 'T080_PIANIFORARI.DATA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selTabellaORARIO: TStringField
      DisplayLabel = 'Orario'
      FieldName = 'ORARIO'
      Origin = 'T080_PIANIFORARI.ORARIO'
      OnSetText = selTabellaORARIOSetText
      OnValidate = selTabellaORARIOValidate
      Size = 5
    end
    object selTabellaD_ORARIO: TStringField
      DisplayLabel = ' '
      FieldKind = fkLookup
      FieldName = 'D_ORARIO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ORARIO'
      ReadOnly = True
      Lookup = True
    end
    object selTabellaTURNO1: TStringField
      DisplayLabel = '1'#176' Turno'
      FieldName = 'TURNO1'
      Origin = 'T080_PIANIFORARI.TURNO1'
      OnValidate = selTabellaTURNO1Validate
      Size = 2
    end
    object selTabellaTURNO1EU: TStringField
      DisplayLabel = 'E/U'
      FieldName = 'TURNO1EU'
      Origin = 'T080_PIANIFORARI.TURNO1EU'
      OnValidate = selTabellaTURNO1EUValidate
      Size = 1
    end
    object selTabellaTURNO2: TStringField
      DisplayLabel = '2'#176' Turno'
      FieldName = 'TURNO2'
      Origin = 'T080_PIANIFORARI.TURNO2'
      OnValidate = selTabellaTURNO2Validate
      Size = 2
    end
    object selTabellaTURNO2EU: TStringField
      DisplayLabel = 'E/U'
      FieldName = 'TURNO2EU'
      Origin = 'T080_PIANIFORARI.TURNO2EU'
      OnValidate = selTabellaTURNO2EUValidate
      Size = 1
    end
    object selTabellaVALORGIOR: TStringField
      DisplayLabel = 'Val.giorn.'
      FieldName = 'VALORGIOR'
      Visible = False
      Size = 1
    end
    object selTabellaFLAGAGG: TStringField
      FieldName = 'FLAGAGG'
      Origin = 'T080_PIANIFORARI.FLAGAGG'
      Visible = False
      Size = 1
    end
    object selTabellaINDPRESENZA: TStringField
      DisplayLabel = 'Indennit'#224
      FieldName = 'INDPRESENZA'
      Origin = 'T080_PIANIFORARI.INDPRESENZA'
      OnSetText = Q080INDPRESENZASetText
      OnValidate = Q080INDPRESENZAValidate
      Size = 5
    end
    object selTabellaD_INDENNITA: TStringField
      DisplayLabel = ' '
      FieldKind = fkLookup
      FieldName = 'D_INDENNITA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'INDPRESENZA'
      ReadOnly = True
      Lookup = True
    end
    object selTabellaDATOLIBERO: TStringField
      FieldName = 'DATOLIBERO'
      OnSetText = Q080DATOLIBEROSetText
      OnValidate = Q080DATOLIBEROValidate
    end
    object selTabellaD_DATOLIBERO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_DATOLIBERO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATOLIBERO'
      ReadOnly = True
      Size = 80
      Lookup = True
    end
    object selTabellaMOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Visible = False
      Size = 2
    end
    object selTabellaD_MOTIVAZIONE: TStringField
      DisplayLabel = 'Motivazione'
      FieldKind = fkLookup
      FieldName = 'D_MOTIVAZIONE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'MOTIVAZIONE'
      Lookup = True
    end
    object selTabellaNOTE: TStringField
      DisplayLabel = 'Note'
      FieldName = 'NOTE'
      Size = 2000
    end
  end
  inherited selEstrazioneDati: TOracleDataSet
    Left = 120
  end
  inherited dsrEstrazioniDati: TDataSource
    Left = 120
  end
  inherited selT900: TOracleDataSet
    Left = 208
  end
  inherited selT901: TOracleDataSet
    Left = 264
  end
end
