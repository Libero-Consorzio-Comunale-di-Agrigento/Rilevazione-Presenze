inherited A022FContrattiMW: TA022FContrattiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 266
  Width = 520
  object selT203: TOracleDataSet
    SQL.Strings = (
      'SELECT T203.*,T203.ROWID '
      'FROM T203_ORESUPPLEMENTARI_PT T203'
      'WHERE CODICE = :CODICE'
      'ORDER BY DECORRENZA,PT_DAL')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    CachedUpdates = True
    BeforePost = selT203BeforePost
    OnFilterRecord = selT203FilterRecord
    OnNewRecord = selT203NewRecord
    Left = 20
    Top = 80
    object StringField1: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selT203DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Visible = False
    end
    object selT203DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selT203PT_DAL: TFloatField
      DisplayLabel = 'Da %'
      FieldName = 'PT_DAL'
    end
    object selT203PT_AL: TFloatField
      DisplayLabel = 'A %'
      FieldName = 'PT_AL'
      ReadOnly = True
    end
    object selT203ORE_SUPPL: TStringField
      DisplayLabel = 'Ore supplementari'
      FieldName = 'ORE_SUPPL'
      EditMask = '!990:00;1;_'
      Size = 6
    end
  end
  object dsrT203: TDataSource
    DataSet = selT203
    Left = 19
    Top = 128
  end
end
