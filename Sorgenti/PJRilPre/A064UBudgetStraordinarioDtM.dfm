inherited A064FBudgetStraordinarioDtM: TA064FBudgetStraordinarioDtM
  OldCreateOrder = True
  Height = 212
  Width = 316
  object selT713: TOracleDataSet
    SQL.Strings = (
      'select t713.*, t713.rowid '
      'from T713_BUDGETANNO t713'
      ':FiltroPeriodo'
      'order by t713.codgruppo, t713.decorrenza, t713.tipo')
    Optimize = False
    Variables.Data = {
      04000000010000001C0000003A00460049004C00540052004F00500045005200
      49004F0044004F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A0000001200000043004F004400470052005500500050004F000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000001E000000460049004C00540052004F005F0041004E00410047005200
      4100460045000100000000001800000043004F0044005400490050004F005100
      55004F0054004100010000000000160000005000450053004F005F0054004F00
      540041004C004500010000000000180000005000450053004F005F0049004E00
      44005F004D0049004E00010000000000180000005000450053004F005F004900
      4E0044005F004D004100580001000000000018000000510055004F0054004100
      5F0054004F00540041004C0045000100000000000E0000004400410054004100
      5200490046000100000000000800000041004E004E004F00010000000000}
    BeforeInsert = BeforeInsert
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterCancel = selT713AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    AfterScroll = selT713AfterScroll
    OnFilterRecord = selT713FilterRecord
    OnNewRecord = selT713NewRecord
    Left = 16
    Top = 16
    object selT713CODGRUPPO: TStringField
      DisplayLabel = 'Cod. gruppo'
      FieldName = 'CODGRUPPO'
      Required = True
      OnValidate = selT713CODGRUPPOValidate
      Size = 10
    end
    object selT713TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 5
    end
    object selT713DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      OnValidate = selT713DECORRENZAValidate
    end
    object selT713DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      OnValidate = selT713DECORRENZA_FINEValidate
    end
    object selT713ANNO: TFloatField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Required = True
    end
    object selT713DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT713FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Required = True
      OnValidate = selT713FILTRO_ANAGRAFEValidate
      Size = 4000
    end
    object selT713ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT713IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '0.00'
    end
  end
  object selT714: TOracleDataSet
    SQL.Strings = (
      'select t714.*, t714.rowid'
      'from T714_BUDGETMESE t714'
      'where codgruppo = :CODGRUPPO'
      '  and tipo = :TIPO'
      '  and decorrenza = :DECORRENZA'
      'order by t714.mese')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000C0000001200000043004F004400470052005500500050004F000100
      000000001800000043004F0044005400490050004F00510055004F0054004100
      01000000000016000000500052004F0047005200450053005300490056004F00
      010000000000200000005000450053004F005F0049004E004400490056004900
      4400550041004C0045000100000000001C0000005000450053004F005F004300
      41004C0043004F004C00410054004F0001000000000022000000510055004F00
      540041005F0049004E0044004900560049004400550041004C00450001000000
      00001E000000510055004F00540041005F00430041004C0043004F004C004100
      540041000100000000000E00000043004F0047004E004F004D00450001000000
      0000080000004E004F004D004500010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000470047005F00530045005200
      560049005A0049004F000100000000000800000041004E004E004F0001000000
      0000}
    ReadOnly = True
    CachedUpdates = True
    BeforeInsert = selT714BeforeInsert
    BeforePost = selT714BeforePost
    AfterPost = selT714AfterPost
    BeforeDelete = selT714BeforeDelete
    OnCalcFields = selT714CalcFields
    Left = 72
    Top = 16
    object selT714CODGRUPPO: TStringField
      DisplayLabel = 'Cod. gruppo'
      FieldName = 'CODGRUPPO'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object selT714TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      ReadOnly = True
      Required = True
      Size = 5
    end
    object selT714DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      ReadOnly = True
      Required = True
    end
    object selT714MESE: TFloatField
      DisplayLabel = 'Mese'
      FieldName = 'MESE'
      ReadOnly = True
      Required = True
    end
    object selT714ORE_AUTO: TStringField
      DisplayLabel = 'Ore autom.'
      FieldKind = fkCalculated
      FieldName = 'ORE_AUTO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT714ORE: TStringField
      DisplayLabel = 'Ore manuali'
      FieldName = 'ORE'
      EditMask = '!#000:00;1;_'
      Size = 10
    end
    object selT714ORE_FRUITO: TStringField
      DisplayLabel = 'Ore fruite'
      FieldName = 'ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT714ORE_RESIDUO_AUTO: TStringField
      DisplayLabel = 'Ore res. aut.'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ORE_RESIDUO_AUTO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT714ORE_RESIDUO: TStringField
      DisplayLabel = 'Ore res. man.'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ORE_RESIDUO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT714IMPORTO_AUTO: TFloatField
      DisplayLabel = 'Importo autom.'
      FieldKind = fkCalculated
      FieldName = 'IMPORTO_AUTO'
      ReadOnly = True
      DisplayFormat = '0.00'
      Calculated = True
    end
    object selT714IMPORTO: TFloatField
      DisplayLabel = 'Importo manuale'
      FieldName = 'IMPORTO'
      DisplayFormat = '0.00'
    end
    object selT714IMPORTO_FRUITO: TFloatField
      DisplayLabel = 'Importo fruito'
      FieldName = 'IMPORTO_FRUITO'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object selT714IMPORTO_RESIDUO_AUTO: TFloatField
      DisplayLabel = 'Imp. res. aut.'
      FieldKind = fkCalculated
      FieldName = 'IMPORTO_RESIDUO_AUTO'
      ReadOnly = True
      DisplayFormat = '0.00'
      Calculated = True
    end
    object selT714IMPORTO_RESIDUO: TFloatField
      DisplayLabel = 'Imp. res. man.'
      FieldKind = fkCalculated
      FieldName = 'IMPORTO_RESIDUO'
      ReadOnly = True
      DisplayFormat = '0.00'
      Calculated = True
    end
  end
  object dsrT714: TDataSource
    DataSet = selT714
    Left = 72
    Top = 72
  end
end
