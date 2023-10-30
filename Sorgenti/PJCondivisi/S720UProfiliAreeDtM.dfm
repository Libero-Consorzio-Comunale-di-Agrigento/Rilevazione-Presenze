inherited S720FProfiliAreeDtM: TS720FProfiliAreeDtM
  OldCreateOrder = True
  Height = 102
  Width = 103
  object selSG720: TOracleDataSet
    SQL.Strings = (
      'select SG720.*, SG720.ROWID'
      'from SG720_PROFILI_AREE SG720'
      'order by DATO1, DATO2, DATO3, DATO4, COD_AREA, DECORRENZA'
      '')
    Optimize = False
    BeforePost = BeforePost
    OnNewRecord = OnNewRecord
    Left = 24
    Top = 24
    object selSG720DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG720DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG720DATO1: TStringField
      DisplayLabel = 'Cod'
      FieldName = 'DATO1'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 290
      FieldKind = fkLookup
      FieldName = 'DESC_DATO1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 290
      Lookup = True
    end
    object selSG720DATO2: TStringField
      DisplayLabel = 'Cod'
      FieldName = 'DATO2'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO2: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO2'
      Size = 290
      Lookup = True
    end
    object selSG720DATO3: TStringField
      DisplayLabel = 'Cod'
      FieldName = 'DATO3'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO3: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO3'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO3'
      Size = 290
      Lookup = True
    end
    object selSG720DATO4: TStringField
      DisplayLabel = 'Cod'
      FieldName = 'DATO4'
      Visible = False
      Size = 50
    end
    object selSG720DESC_DATO4: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO4'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO4'
      Size = 290
      Lookup = True
    end
    object selSG720COD_AREA: TStringField
      DisplayLabel = 'Cod'
      FieldName = 'COD_AREA'
      Size = 5
    end
    object selSG720DESCRIZIONE: TStringField
      DisplayLabel = 'Area'
      DisplayWidth = 290
      FieldKind = fkLookup
      FieldName = 'DESCRIZIONE'
      LookupKeyFields = 'COD_AREA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_AREA'
      Size = 290
      Lookup = True
    end
  end
end
