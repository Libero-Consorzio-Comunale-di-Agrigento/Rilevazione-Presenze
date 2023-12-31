inherited A020FCausPresenzeStoricoMW: TA020FCausPresenzeStoricoMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 259
  Width = 368
  object selT275: TOracleDataSet
    SQL.Strings = (
      'select * '
      'from T275_CAUPRESENZE'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Left = 168
    Top = 16
  end
  object selT235: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from T235_CAUPRESENZE_PARSTO'
      'where ID = :ID'
      'order by DECORRENZA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 32
    Top = 16
  end
  object insT235Nuovo: TOracleQuery
    SQL.Strings = (
      
        'insert into T235_CAUPRESENZE_PARSTO(ID,DECORRENZA,DECORRENZA_FIN' +
        'E,DESCRIZIONE)'
      'values(:ID,:DECORRENZA,:DECORRENZA_FINE,:DESCRIZIONE)')
    Optimize = False
    Variables.Data = {
      0400000004000000060000003A00490044000300000000000000000000001600
      00003A004400450043004F005200520045004E005A0041000C00000000000000
      00000000200000003A004400450043004F005200520045004E005A0041005F00
      460049004E0045000C0000000000000000000000180000003A00440045005300
      4300520049005A0049004F004E004500050000000000000000000000}
    Left = 32
    Top = 80
  end
  object insT235NuovoCompleto: TOracleQuery
    SQL.Strings = (
      'insert into T235_CAUPRESENZE_PARSTO ('
      '  ID,'
      '  :COLONNE)'
      'select'
      '  :ID,'
      '  :COLONNE'
      'from T235_CAUPRESENZE_PARSTO where ID = :OLD_ID')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0043004F004C004F004E004E00450001000000
      0000000000000000060000003A00490044000300000000000000000000000E00
      00003A004F004C0044005F0049004400030000000000000000000000}
    Left = 136
    Top = 80
  end
  object cdsStoriaParamStorizz: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 144
    object cdsStoriaParamStorizzDATO: TStringField
      DisplayLabel = 'Dato'
      DisplayWidth = 250
      FieldName = 'DATO'
      Size = 250
    end
    object cdsStoriaParamStorizzDECORRENZA: TStringField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Size = 10
    end
    object cdsStoriaParamStorizzFINE_DECORRENZA: TStringField
      DisplayLabel = 'Termine'
      FieldName = 'FINE_DECORRENZA'
      Size = 10
    end
    object cdsStoriaParamStorizzVALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Size = 2000
    end
  end
  object selT275CAUS: TOracleDataSet
    SQL.Strings = (
      'select T275.TIPOCONTEGGIO, T275.ORENORMALI, T270.CODINTERNO'
      'from T275_CAUPRESENZE T275, T270_RAGGRPRESENZE T270'
      'where T275.CODRAGGR = T270.CODICE'
      'and T275.ID = :ID')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 96
    Top = 16
  end
  object selCdzAbilitazione: TOracleQuery
    Optimize = False
    Left = 284
    Top = 15
  end
end
