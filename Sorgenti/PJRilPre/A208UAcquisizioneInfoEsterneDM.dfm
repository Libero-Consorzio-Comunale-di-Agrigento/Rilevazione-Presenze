object A208FAcquisizioneInfoEsterneDM: TA208FAcquisizioneInfoEsterneDM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 170
  Width = 313
  object selT036: TOracleDataSet
    SQL.Strings = (
      
        'select max(TIMESTAMP) TIMESTAMP, T030.CODFISCALE, T036.TIPO, T03' +
        '6.DATO, max(T036.VALORE) VALORE'
      'from T036_ANAGRAFICO_EXTINFO T036, T030_ANAGRAFICO T030'
      'where T036.PROGRESSIVO = T030.PROGRESSIVO'
      'group by T030.CODFISCALE, T036.TIPO, T036.DATO'
      'order by T030.CODFISCALE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000800000016000000500052004F004700520045005300530049005600
      4F000100000000001E00000044004100540041005F0043004F004D0050004500
      540045004E005A0041000100000000002400000043004F0044005F004D004900
      53005500520041005100550041004E0054004900540041000100000000000E00
      00004F0052004900470049004E00450001000000000016000000540049005000
      4F005F005200450043004F005200440001000000000010000000510055004100
      4E0054004900540041000100000000000800000046004C004100470001000000
      00001A00000044004100540041005F004300450044004F004C0049004E004F00
      010000000000}
    Left = 22
    Top = 16
    object selT036TIMESTAMP: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 20
      FieldName = 'TIMESTAMP'
    end
    object selT036CODFISCALE: TStringField
      DisplayLabel = 'Codice fiscale'
      DisplayWidth = 25
      FieldName = 'CODFISCALE'
    end
    object selT036TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
    end
    object selT036DATO: TStringField
      DisplayLabel = 'Dato'
      FieldName = 'DATO'
    end
    object selT036VALORE: TStringField
      DisplayLabel = 'Valore'
      DisplayWidth = 40
      FieldName = 'VALORE'
    end
  end
end
