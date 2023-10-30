object C014FImpostazioneFiltroDtM: TC014FImpostazioneFiltroDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 158
  Width = 276
  object selSQL: TOracleDataSet
    Left = 72
    Top = 16
  end
  object testSQL: TOracleQuery
    Left = 120
    Top = 16
  end
  object dsrI010: TDataSource
    Left = 23
    Top = 16
  end
end
