inherited A120FTipiRimborsiMW: TA120FTipiRimborsiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 141
  Width = 185
  object DsrP050: TDataSource
    DataSet = selP050
    Left = 8
    Top = 7
  end
  object selP050: TOracleDataSet
    SQL.Strings = (
      
        'select T.COD_ARROTONDAMENTO, T.COD_VALUTA, T.DECORRENZA, T.DESCR' +
        'IZIONE,T.VALORE,T.TIPO, t.rowid from p050_arrotondamenti t where' +
        ' T.cod_valuta = '
      
        '       (select cod_valuta_base from p150_setup where decorrenza ' +
        '= '
      
        '               (select max(decorrenza) from p150_setup where dec' +
        'orrenza <= :DECORRENZA))'
      
        'and T.DECORRENZA = (select max(A.decorrenza) from p050_arrotonda' +
        'menti A where A.decorrenza <= :DECORRENZA AND A.COD_ARROTONDAMEN' +
        'TO = T.COD_ARROTONDAMENTO)')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000}
    Left = 52
    Top = 7
    object selP050COD_ARROTONDAMENTO: TStringField
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object selP050COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP050DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selP050DESCRIZIONE: TStringField
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selP050VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object selP050TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object selM022: TOracleDataSet
    SQL.Strings = (
      'select M022.CODICE, M022.DESCRIZIONE'
      '  from M022_CATEG_RIMBORSI M022'
      ' order by M022.CODICE')
    Optimize = False
    Left = 120
    Top = 8
  end
  object dsrM022: TDataSource
    DataSet = selM022
    Left = 120
    Top = 56
  end
end
