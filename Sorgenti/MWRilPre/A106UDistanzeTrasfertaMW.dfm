inherited A106FDistanzeTrasfertaMW: TA106FDistanzeTrasfertaMW
  OldCreateOrder = True
  Height = 163
  Width = 286
  object SelT480: TOracleDataSet
    SQL.Strings = (
      'select * from t480_comuni t'
      ':orderby')
    ReadBuffer = 2000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 19
    Top = 8
    object SelT480CODICE: TStringField
      DisplayLabel = 'Cod.ISTAT'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 6
    end
    object SelT480CITTA: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 60
      FieldName = 'CITTA'
      Size = 60
    end
    object SelT480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object SelT480PROVINCIA: TStringField
      DisplayLabel = 'Prov.'
      DisplayWidth = 5
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object SelT480CODCATASTALE: TStringField
      DisplayLabel = 'Cod.Catastale'
      DisplayWidth = 10
      FieldName = 'CODCATASTALE'
      Size = 4
    end
  end
  object SelM042: TOracleDataSet
    SQL.Strings = (
      'select t.* from m042_localita t'
      'order by descrizione')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 19
    Top = 56
    object SelM042CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object SelM042DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 30
    end
    object SelM042COD_ISTAT: TStringField
      FieldName = 'COD_ISTAT'
      Size = 6
    end
  end
  object dsrSelT480: TDataSource
    DataSet = SelT480
    Left = 76
    Top = 8
  end
  object dsrSelM042: TDataSource
    DataSet = SelM042
    Left = 76
    Top = 56
  end
  object SelM041C: TOracleDataSet
    SQL.Strings = (
      'select count(*) '
      'from m041_distanze'
      
        'where ((tipo1 || localita1=:codloc1 and tipo2 || localita2=:codl' +
        'oc2)'
      
        '   or (tipo2 || localita2=:codloc1 and tipo1 || localita1=:codlo' +
        'c2))'
      ':NROWID'
      ''
      ' ')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0043004F0044004C004F004300310005000000
      0000000000000000100000003A0043004F0044004C004F004300320005000000
      00000000000000000E0000003A004E0052004F00570049004400010000000000
      000000000000}
    Left = 152
    Top = 6
  end
  object selM042Edit: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from m042_localita t'
      'order by descrizione')
    ReadBuffer = 500
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    BeforePost = selM042EditBeforePost
    Left = 19
    Top = 110
    object selM042EditCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object selM042EditDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 30
    end
    object selM042EditCOD_ISTAT: TStringField
      FieldName = 'COD_ISTAT'
      Visible = False
      Size = 6
    end
    object selM042EditD_COMUNE: TStringField
      DisplayLabel = 'Comune'
      DisplayWidth = 55
      FieldKind = fkLookup
      FieldName = 'D_COMUNE'
      LookupDataSet = SelT480
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_ISTAT'
      Size = 60
      Lookup = True
    end
  end
end
