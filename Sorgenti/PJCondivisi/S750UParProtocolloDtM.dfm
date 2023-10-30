object S750FParProtocolloDtM: TS750FParProtocolloDtM
  OldCreateOrder = True
  OnCreate = S750FParProtocolloDtMCreate
  OnDestroy = S750FParProtocolloDtMDestroy
  Height = 301
  Width = 493
  object D751: TDataSource
    DataSet = SG751
    Left = 88
    Top = 12
  end
  object SG750: TOracleDataSet
    SQL.Strings = (
      'SELECT SG750.*, SG750.ROWID'
      'FROM SG750_PARPROTOCOLLO SG750'
      'ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      00005400490050004F00460049004C0045000100000000001600000044004500
      4600410055004C00540045004E00540045000100000000001600000054004100
      420045004C004C00410045004E00540045000100000000001200000043004100
      4D0050004F0045004E0054004500010000000000100000004E004F004D004500
      460049004C004500010000000000100000004400410054004100460049004C00
      4500010000000000100000004D0045005300450041004E004E004F0001000000
      00001400000046004F0052004D00410054004F004F0052004500010000000000
      1400000050005200450043004900530049004F004E0045000100000000001200
      00005500530045005200500041004700480045000100000000002C0000005300
      41004C0056004100540041004700470049004F005F004100550054004F004D00
      41005400490043004F0001000000000024000000530045005000410052004100
      54004F005200450044004500430049004D0041004C0049000100000000001A00
      00005400490050004F0044004100540041005F00460049004C00450001000000
      00002C0000005200490043005200450041005A0049004F004E0045005F004100
      550054004F004D00410054004900430041000100000000002C00000054004900
      50004F005F0050004100520041004D0045005400520049005A005A0041005A00
      49004F004E004500010000000000}
    AfterInsert = SG750AfterInsert
    AfterEdit = SG750AfterEdit
    BeforePost = SG750BeforePost
    AfterPost = SG750AfterPost
    AfterCancel = SG750AfterCancel
    BeforeDelete = SG750BeforeDelete
    AfterDelete = SG750AfterDelete
    AfterScroll = SG750AfterScroll
    OnCalcFields = SG750CalcFields
    Left = 16
    Top = 12
    object SG750CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object SG750DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object SG750TIPOXML: TStringField
      FieldName = 'TIPOXML'
      Size = 1
    end
    object SG750WS_URL: TStringField
      FieldName = 'WS_URL'
      Size = 1000
    end
    object SG750D_TIPOXML: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPOXML'
      Size = 50
      Calculated = True
    end
    object SG750INVIO_CONSEGNA: TStringField
      DisplayLabel = 'Invio alla presa visione'
      FieldName = 'INVIO_CONSEGNA'
      Size = 1
    end
  end
  object SG751: TOracleDataSet
    SQL.Strings = (
      'SELECT SG751.*, SG751.ROWID'
      'FROM SG751_PARPROTOCOLLODATI SG751'
      'WHERE CODICE = :CODICE '
      'ORDER BY ORDINE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000000600
      000050004F005300010000000000080000004C0055004E004700010000000000
      06000000440045004600010000000000080000005400490050004F0001000000
      0000080000004E004F004D0045000100000000002C0000005400490050004F00
      5F0050004100520041004D0045005400520049005A005A0041005A0049004F00
      4E004500010000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforeInsert = SG751BeforeInsert
    BeforeDelete = SG751BeforeDelete
    Left = 52
    Top = 12
    object SG751CODICE: TStringField
      FieldName = 'CODICE'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object SG751ORDINE: TIntegerField
      FieldName = 'ORDINE'
      ReadOnly = True
    end
    object SG751TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldName = 'TIPO'
      ReadOnly = True
      Size = 50
    end
    object SG751DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione tipo'
      FieldName = 'DESCRIZIONE'
      ReadOnly = True
      Size = 100
    end
    object SG751DATO: TStringField
      DisplayLabel = 'Dato'
      FieldName = 'DATO'
      Size = 150
    end
  end
  object selTipoXML_old: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'A'#39' CODICE, '#39'ProtocolloService'#39' DESCRIZIONE'
      'FROM DUAL')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000000600
      000050004F005300010000000000080000004C0055004E004700010000000000
      06000000440045004600010000000000080000005400490050004F0001000000
      0000080000004E004F004D0045000100000000002C0000005400490050004F00
      5F0050004100520041004D0045005400520049005A005A0041005A0049004F00
      4E004500010000000000}
    ReadOnly = True
    Left = 156
    Top = 68
    object selTipoXML_oldCODICE: TStringField
      DisplayWidth = 5
      FieldName = 'CODICE'
      Size = 1
    end
    object selTipoXML_oldDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
  end
  object dTipoXML_old: TDataSource
    DataSet = selTipoXML_old
    Left = 240
    Top = 68
  end
  object insSG751_old: TOracleQuery
    SQL.Strings = (
      'INSERT INTO SG751_PARPROTOCOLLODATI'
      ' ( CODICE,  ORDINE,  TIPO,  DESCRIZIONE,  DATO)'
      'VALUES'
      ' (:CODICE, :ORDINE, :TIPO, :DESCRIZIONE, :DATO)')
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A0043004F004400490043004500050000000000
      0000000000000E0000003A004F005200440049004E0045000300000000000000
      000000000A0000003A005400490050004F000500000000000000000000001800
      00003A004400450053004300520049005A0049004F004E004500050000000000
      0000000000000A0000003A004400410054004F00050000000000000000000000}
    Left = 48
    Top = 64
  end
  object updSG751_old: TOracleQuery
    SQL.Strings = (
      'UPDATE SG751_PARPROTOCOLLODATI'
      'SET ORDINE = :ORDINE'
      'WHERE CODICE = :CODICE'
      'AND TIPO = :TIPO')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      0000000000000E0000003A004F005200440049004E0045000300000000000000
      000000000A0000003A005400490050004F00050000000000000000000000}
    Left = 48
    Top = 120
  end
  object delSG751_old: TOracleQuery
    SQL.Strings = (
      'DELETE SG751_PARPROTOCOLLODATI'
      'WHERE CODICE = :CODICE'
      'AND TIPO = :TIPO')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      0000000000000E0000003A004F005200440049004E0045000300000000000000
      000000000A0000003A005400490050004F00050000000000000000000000}
    Left = 48
    Top = 176
  end
  object D010_old: TDataSource
    Left = 336
    Top = 68
  end
end
