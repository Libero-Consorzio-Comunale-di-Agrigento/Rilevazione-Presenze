inherited WA011FEntiLocaliDM: TWA011FEntiLocaliDM
  Height = 354
  object T480: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T480.*,ROWID, DECODE(SOPPRESSO,'#39'N'#39','#39'Attivo'#39','#39'I'#39','#39'Attivo c' +
        'on incorporazione'#39','#39'Soppresso'#39') D_SOPPRESSO FROM T480_COMUNI T48' +
        '0 WHERE CODICE IN '
      
        '   (SELECT CODICE FROM T480_COMUNI T480 WHERE :TipoSelezione = '#39 +
        'T'#39
      '   UNION'
      
        '   SELECT CODICE FROM T480_COMUNI T480 WHERE :TipoSelezione = '#39'R' +
        #39' AND '
      
        '     CODICE IN (SELECT COMUNENAS FROM T030_ANAGRAFICO UNION SELE' +
        'CT COMUNE FROM T430_STORICO)'
      '   )'
      ' :ORDERBY'
      '')
    ReadBuffer = 8000
    Optimize = False
    Variables.Data = {
      04000000020000001C0000003A005400490050004F00530045004C0045005A00
      49004F004E004500050000000000000000000000100000003A004F0052004400
      4500520042005900010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000090000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000
      1200000053004F005000500052004500530053004F0001000000000012000000
      43004F0044005F00490052005000450046000100000000001600000044005F00
      53004F005000500052004500530053004F000100000000002200000044004100
      540041005F0053004F0050005000520045005300530049004F004E0045000100
      00000000}
    BeforePost = BeforePostNoStorico
    Left = 32
    Top = 124
    object T480CODICE: TStringField
      DisplayLabel = 'Codice ISTAT'
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object T480CITTA: TStringField
      DisplayLabel = 'Comune'
      FieldName = 'CITTA'
      Size = 60
    end
    object T480SOPPRESSO: TStringField
      DisplayLabel = 'Stato comune'
      FieldName = 'SOPPRESSO'
      Size = 1
    end
    object T480D_SOPPRESSO: TStringField
      DisplayLabel = 'Descr. Stato comune'
      FieldKind = fkInternalCalc
      FieldName = 'D_SOPPRESSO'
      ReadOnly = True
      Size = 25
    end
    object T480DATA_SOPPRESSIONE: TDateTimeField
      DisplayLabel = 'Data soppressione'
      DisplayWidth = 10
      FieldName = 'DATA_SOPPRESSIONE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object T480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object T480PROVINCIA: TStringField
      DisplayLabel = 'Provincia'
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object T480D_PROVINCIA: TStringField
      DisplayLabel = 'Descr. Provincia'
      FieldKind = fkLookup
      FieldName = 'D_PROVINCIA'
      LookupKeyFields = 'COD_PROVINCIA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PROVINCIA'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
    object T480CODCATASTALE: TStringField
      DisplayLabel = 'Codice Catastale'
      FieldName = 'CODCATASTALE'
      Size = 4
    end
    object T480COD_REGIONE: TStringField
      DisplayLabel = 'Regione'
      FieldKind = fkLookup
      FieldName = 'COD_REGIONE'
      LookupKeyFields = 'COD_PROVINCIA'
      LookupResultField = 'COD_REGIONE'
      KeyFields = 'PROVINCIA'
      ReadOnly = True
      Size = 5
      Lookup = True
    end
    object T480D_REGIONE: TStringField
      DisplayLabel = 'Descr. Regione'
      FieldKind = fkLookup
      FieldName = 'D_REGIONE'
      LookupKeyFields = 'COD_REGIONE'
      LookupResultField = 'DESCRIZIONE_1'
      KeyFields = 'COD_REGIONE'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
    object T480COD_IRPEF: TStringField
      DisplayLabel = 'Codice IRPEF'
      FieldName = 'COD_IRPEF'
      Size = 4
    end
    object T480D_COD_IRPEF: TStringField
      DisplayLabel = 'Descr. Codice IRPEF'
      FieldKind = fkLookup
      FieldName = 'D_COD_IRPEF'
      LookupDataSet = A011FEntiLocaliMW.selT480
      LookupKeyFields = 'CODCATASTALE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_IRPEF'
      ReadOnly = True
      Size = 60
      Lookup = True
    end
  end
  object T481: TOracleDataSet
    SQL.Strings = (
      'SELECT T481.*, T481.ROWID '
      '  FROM T481_PROVINCE T481'
      '  :ORDERBY')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000001600000043004F0044005F0052004500470049004F004E00
      45000100000000001A00000043004F0044005F00500052004F00560049004E00
      430049004100010000000000160000004400450053004300520049005A004900
      4F004E004500010000000000260000004400450053004300520049005A004900
      4F004E0045005F0052004500470049004F004E0045000100000000001C000000
      4C0043004F0044005F00500052004F00560049004E0043004900410001000000
      0000180000004C004400450053004300520049005A0049004F004E0045000100
      00000000}
    Left = 33
    Top = 172
    object T481COD_PROVINCIA: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_PROVINCIA'
      Required = True
      Size = 2
    end
    object T481DESCRIZIONE: TStringField
      DisplayLabel = 'Provincia'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
    object T481COD_REGIONE: TStringField
      DisplayLabel = 'Regione'
      FieldName = 'COD_REGIONE'
      Required = True
      Size = 5
    end
    object T481D_REGIONE: TStringField
      DisplayLabel = 'Descr. Regione'
      FieldKind = fkLookup
      FieldName = 'D_REGIONE'
      LookupKeyFields = 'COD_REGIONE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_REGIONE'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
  end
  object T482: TOracleDataSet
    SQL.Strings = (
      'SELECT T482.*, T482.ROWID '
      '  FROM T482_REGIONI T482'
      '  :ORDERBY')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0052004500470049004F004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    BeforePost = BeforePostNoStorico
    Left = 33
    Top = 224
    object T482COD_REGIONE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_REGIONE'
      Required = True
      Size = 5
    end
    object T482DESCRIZIONE: TStringField
      DisplayLabel = 'Regione'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
    object T482COD_IRPEF: TStringField
      DisplayLabel = 'Codice IRPEF'
      FieldName = 'COD_IRPEF'
      Required = True
      Size = 2
    end
    object T482FISCALE: TStringField
      DisplayLabel = 'Regione significativa solo ai fini dell'#39'addizionale IRPEF'
      FieldName = 'FISCALE'
      Required = True
      Size = 1
    end
  end
  object D480: TDataSource
    DataSet = T480
    OnStateChange = dsrTabellaStateChange
    Left = 64
    Top = 124
  end
  object D481: TDataSource
    DataSet = T481
    OnStateChange = dsrTabellaStateChange
    Left = 64
    Top = 173
  end
  object D482: TDataSource
    DataSet = T482
    OnStateChange = dsrTabellaStateChange
    Left = 64
    Top = 222
  end
  object T483: TOracleDataSet
    SQL.Strings = (
      'SELECT T483.*, T483.ROWID '
      '  FROM T483_NAZIONI T483'
      '  :ORDERBY')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0052004500470049004F004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    BeforePost = BeforePostNoStorico
    Left = 33
    Top = 280
    object StringField1: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_NAZIONE'
      Required = True
      Size = 3
    end
    object StringField2: TStringField
      DisplayLabel = 'Nazione'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
  end
  object D483: TDataSource
    DataSet = T483
    OnStateChange = dsrTabellaStateChange
    Left = 64
    Top = 278
  end
end
