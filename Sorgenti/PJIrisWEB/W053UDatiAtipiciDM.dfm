object W053FDatiAtipiciDM: TW053FDatiAtipiciDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object selT077: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T077.*, T077.ROWID, T030.MATRICOLA, T030.COGNOME, T030.NO' +
        'ME'
      'FROM T077_DATISCHEDA T077, T030_ANAGRAFICO T030'
      'WHERE T077.PROGRESSIVO IN (:SEL_ANA)'
      'AND T077.DATA = :DATA'
      'AND T077.DATO = :DATO'
      'AND T030.PROGRESSIVO = T077.PROGRESSIVO'
      'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00530045004C005F0041004E00410001000000000000000000
      00000A0000003A004400410054004F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    OnCalcFields = selT077CalcFields
    Left = 24
    Top = 24
    object selT077PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selT077DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT077DATO: TStringField
      FieldName = 'DATO'
      Size = 30
    end
    object selT077VALORE_AUT: TStringField
      FieldName = 'VALORE_AUT'
      Size = 50
    end
    object selT077VALORE_MAN: TStringField
      FieldName = 'VALORE_MAN'
      Size = 30
    end
    object selT077MATRICOLA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT077COGNOME: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'COGNOME'
      Size = 50
    end
    object selT077NOME: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'NOME'
      Size = 50
    end
    object selT077ABILITA: TStringField
      FieldKind = fkCalculated
      FieldName = 'ABILITA'
      Size = 1
      Calculated = True
    end
    object selT077MESSAGGI: TStringField
      FieldKind = fkCalculated
      FieldName = 'MESSAGGI'
      Size = 100
      Calculated = True
    end
  end
  object selI011: TOracleDataSet
    SQL.Strings = (
      'SELECT DATO, DESCRIZIONE, SELEZIONE_ANAGRAFE'
      'FROM I011_DIZIONARIO_DATISCHEDA'
      'WHERE :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'AND TIPO = '#39'N'#39
      'ORDER BY ORDINAMENTO, DATO')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    OracleDictionary.DefaultValues = True
    OnFilterRecord = selI011FilterRecord
    Left = 88
    Top = 24
  end
  object selGenera: TOracleDataSet
    SQL.Strings = (
      'select T030.PROGRESSIVO'
      'from T030_ANAGRAFICO T030'
      'where T030.PROGRESSIVO IN (:SEL_ANA)'
      
        'and V430F_CHEKANAGRAFE(T030.PROGRESSIVO,:DATA,:SELEZIONE_ANAGRAF' +
        'E) = '#39'S'#39
      'and not exists (select 1'
      '                from T077_DATISCHEDA T077'
      '                where T077.PROGRESSIVO = T030.PROGRESSIVO'
      '                and T077.DATA = :DATA'
      '                and T077.DATO = :DATO)')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00530045004C005F0041004E00410001000000000000000000
      00000A0000003A004400410054004F0005000000000000000000000026000000
      3A00530045004C0045005A0049004F004E0045005F0041004E00410047005200
      410046004500050000000000000000000000}
    OracleDictionary.DefaultValues = True
    Left = 24
    Top = 80
  end
end
