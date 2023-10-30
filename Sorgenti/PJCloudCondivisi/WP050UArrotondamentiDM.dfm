inherited WP050FArrotondamentiDM: TWP050FArrotondamentiDM
  Height = 326
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      
        'SELECT P050.*,P050.ROWID, DECODE(TIPO,'#39'E'#39','#39'Eccesso'#39','#39'D'#39','#39'Difetto' +
        #39','#39'P'#39','#39'Puro'#39') D_TIPO'
      'FROM P050_ARROTONDAMENTI P050'
      'WHERE COD_ARROTONDAMENTO = :COD_ARROTONDAMENTO'
      ':ORDERBY')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      0000000000000000260000003A0043004F0044005F004100520052004F005400
      4F004E00440041004D0045004E0054004F00050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000080000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F000100000000001E0000004400
      450043004F005200520045004E005A0041005F00460049004E00450001000000
      00000C00000044005F005400490050004F00010000000000}
    BeforePost = BeforePost
    AfterDelete = AfterDelete
    OnCalcFields = selTabellaCalcFields
    OnNewRecord = OnNewRecord
    object selTabellaCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Cod. arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
    object selTabellaCOD_VALUTA: TStringField
      DisplayLabel = 'Valuta'
      FieldName = 'COD_VALUTA'
      Size = 10
    end
    object selTabellaDES_VALUTA: TStringField
      DisplayLabel = 'Desc.valuta'
      FieldKind = fkCalculated
      FieldName = 'DES_VALUTA'
      Visible = False
      Calculated = True
    end
    object selTabellaDECORRENZA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Scadenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selTabellaVALORE: TFloatField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
    end
    object selTabellaTIPO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Visible = False
      Size = 1
    end
    object selTabellaD_TIPO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo'
      FieldKind = fkInternalCalc
      FieldName = 'D_TIPO'
      ReadOnly = True
      Size = 7
    end
  end
  object selP050K: TOracleDataSet
    SQL.Strings = (
      'SELECT P050.*, P050.ROWID FROM P050_KARROTONDAMENTI P050 '
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    BeforeDelete = selP050KBeforeDelete
    AfterScroll = selP050KAfterScroll
    Left = 32
    Top = 128
    object selP050KCOD_ARROTONDAMENTO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Cod. arrotondamento'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
  end
  object dsrP050K: TDataSource
    AutoEdit = False
    DataSet = selP050K
    OnStateChange = dsrTabellaStateChange
    Left = 32
    Top = 184
  end
end
