inherited P501FCudSetupMW: TP501FCudSetupMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 144
  Width = 166
  object selP030: TOracleDataSet
    SQL.Strings = (
      'SELECT COD_VALUTA, DESCRIZIONE FROM P030_VALUTE T1'
      'WHERE DECORRENZA ='
      '  (SELECT MAX(DECORRENZA) FROM P030_VALUTE WHERE '
      '     DECORRENZA <= :DECORRENZA AND '
      '     COD_VALUTA = T1.COD_VALUTA)'
      'ORDER BY COD_VALUTA')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 17
    Top = 8
    object selP030COD_VALUTA: TStringField
      DisplayWidth = 14
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP030DESCRIZIONE: TStringField
      DisplayWidth = 25
      FieldName = 'DESCRIZIONE'
    end
  end
  object dsrI010: TDataSource
    AutoEdit = False
    Left = 72
    Top = 8
  end
  object selT440: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DECODE(CODICE,'#39'BASE'#39',:DESCRIZIONE_BASE,DESCRIZIONE' +
        ') DESCRIZIONE'
      'FROM T440_AZIENDE_BASE '
      'ORDER BY DECODE(CODICE,'#39'BASE'#39',0,1), CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000220000003A004400450053004300520049005A0049004F00
      4E0045005F004200410053004500050000000000000000000000}
    Left = 17
    Top = 64
    object selT440CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT440DESCRIZIONE: TStringField
      DisplayWidth = 600
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
  end
  object dsrT440: TDataSource
    AutoEdit = False
    DataSet = selT440
    Left = 72
    Top = 64
  end
end
