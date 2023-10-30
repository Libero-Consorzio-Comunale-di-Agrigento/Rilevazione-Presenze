inherited WS750FParProtocolloDM: TWS750FParProtocolloDM
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT SG750.*, SG750.ROWID'
      'FROM SG750_PARPROTOCOLLO SG750'
      ':ORDERBY')
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    OnCalcFields = CalcFields
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
    end
    object selTabellaTIPOXML: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPOXML'
    end
    object selTabellaWS_URL: TStringField
      DisplayLabel = 'URL WebService'
      FieldName = 'WS_URL'
      Size = 250
    end
    object selTabellaINVIO_CONSEGNA: TStringField
      DisplayLabel = 'Invio scheda all'#39'atto della presa visione del valutato'
      FieldName = 'INVIO_CONSEGNA'
      Size = 1
    end
  end
  object D751: TDataSource
    DataSet = SG751
    Left = 208
    Top = 148
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
    Left = 172
    Top = 148
    object SG751CODICE: TStringField
      FieldName = 'CODICE'
      ReadOnly = True
      Visible = False
      Size = 5
    end
    object SG751ORDINE: TIntegerField
      DisplayLabel = 'N'#176
      FieldName = 'ORDINE'
      ReadOnly = True
    end
    object SG751TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldName = 'TIPO'
      ReadOnly = True
      Visible = False
      Size = 50
    end
    object SG751DESCRIZIONE: TStringField
      DisplayLabel = 'Tipo'
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
end
