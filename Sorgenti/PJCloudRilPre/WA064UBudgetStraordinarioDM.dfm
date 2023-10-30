inherited WA064FBudgetStraordinarioDM: TWA064FBudgetStraordinarioDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select t713.*, t713.rowid '
      'from T713_BUDGETANNO t713'
      ':FiltroPeriodo'
      ':OrderBy')
    Variables.Data = {
      0400000002000000100000003A004F0052004400450052004200590001000000
      00000000000000001C0000003A00460049004C00540052004F00500045005200
      49004F0044004F00010000000000000000000000}
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    BeforeDelete = BeforeDelete
    AfterDelete = AfterDelete
    OnFilterRecord = selTabellaFilterRecord
    OnNewRecord = OnNewRecord
    object selTabellaCODGRUPPO: TStringField
      DisplayLabel = 'Cod. gruppo'
      FieldName = 'CODGRUPPO'
      Required = True
      OnValidate = selTabellaCODGRUPPOValidate
      Size = 10
    end
    object selTabellaTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 5
    end
    object selTabellaDECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
      OnValidate = selTabellaDECORRENZAValidate
    end
    object selTabellaDECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      OnValidate = selTabellaDECORRENZA_FINEValidate
    end
    object selTabellaANNO: TFloatField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Required = True
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaFILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Filtro anagrafe'
      FieldName = 'FILTRO_ANAGRAFE'
      Required = True
      OnValidate = selTabellaFILTRO_ANAGRAFEValidate
      Size = 4000
    end
    object selTabellaORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selTabellaIMPORTO: TFloatField
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
      ':OrderBy')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A0043004F004400470052005500500050004F00
      0500000000000000000000000A0000003A005400490050004F00050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000100000003A004F00520044004500520042005900
      010000000000000000000000}
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
    Left = 96
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
    Left = 96
    Top = 64
  end
end
