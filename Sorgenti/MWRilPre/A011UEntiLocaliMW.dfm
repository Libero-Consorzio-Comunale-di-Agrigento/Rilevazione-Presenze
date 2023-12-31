inherited A011FEntiLocaliMW: TA011FEntiLocaliMW
  OldCreateOrder = True
  Height = 223
  Width = 391
  object selCodCatastale: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COUNT(*) NCODCATASTALE FROM T480_COMUNI T480 WHERE CODCAT' +
        'ASTALE = :CodCatastale'
      '  AND CODICE <> :Codice')
    ReadBuffer = 8000
    Optimize = False
    Variables.Data = {
      04000000020000001A0000003A0043004F004400430041005400410053005400
      41004C0045000500000000000000000000000E0000003A0043004F0044004900
      43004500050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 40
    Top = 71
  end
  object selRegioneFiscale: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T482_REGIONI'
      ' WHERE COD_IRPEF = :CODICE'
      '   AND FISCALE = '#39'N'#39
      '   AND ROWID <> :RIGA')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A005200490047004100050000000000000000000000}
    Left = 144
    Top = 72
  end
  object selT481: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T481.COD_PROVINCIA,T481.DESCRIZIONE,T481.COD_REGIONE,T482' +
        '.DESCRIZIONE DESCRIZIONE_1 '
      '  FROM T481_PROVINCE T481, T482_REGIONI T482 '
      ' WHERE T481.COD_REGIONE = T482.COD_REGIONE'
      ' ORDER BY COD_PROVINCIA')
    ReadBuffer = 200
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000040000001A00000043004F0044005F00500052004F00560049004E00
      430049004100010000000000160000004400450053004300520049005A004900
      4F004E0045000100000000001600000043004F0044005F005200450047004900
      4F004E0045000100000000001A0000004400450053004300520049005A004900
      4F004E0045005F003100010000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 32
    Top = 12
  end
  object dsrT481: TDataSource
    DataSet = selT481
    Left = 81
    Top = 12
  end
  object selT482: TOracleDataSet
    SQL.Strings = (
      'SELECT COD_REGIONE,DESCRIZIONE FROM T482_REGIONI '
      ' WHERE FISCALE = '#39'N'#39' '
      '  ORDER BY COD_REGIONE')
    ReadBuffer = 50
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000160000004400450053004300520049005A0049004F004E00
      45000100000000001600000043004F0044005F0052004500470049004F004E00
      4500010000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 140
    Top = 13
  end
  object dsrT482: TDataSource
    DataSet = selT482
    Left = 188
    Top = 13
  end
  object selT480: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T480_COMUNI'
      ' ORDER BY CODICE')
    ReadBuffer = 10000
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000160000004400450053004300520049005A0049004F004E00
      45000100000000001600000043004F0044005F0052004500470049004F004E00
      4500010000000000}
    ReadOnly = True
    CommitOnPost = False
    Left = 252
    Top = 13
  end
  object dsrT480: TDataSource
    DataSet = selT480
    Left = 300
    Top = 13
  end
end
