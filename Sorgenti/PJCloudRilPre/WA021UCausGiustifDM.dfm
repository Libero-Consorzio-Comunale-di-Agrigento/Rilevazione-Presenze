inherited WA021FCausGiustifDM: TWA021FCausGiustifDM
  Height = 182
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T305.*,T305.ROWID '
      'FROM T305_CAUGIUSTIF T305 '
      ':ORDERBY')
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    object selTabellaCodice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object selTabellaDescrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object selTabellaSIGLA: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLA'
      Size = 1
    end
    object selTabellaCodRaggr: TStringField
      DisplayLabel = 'Cod.Raggr.'
      FieldName = 'CodRaggr'
      Required = True
      Size = 5
    end
    object selTabellaD_CodRaggr: TStringField
      DisplayLabel = 'Desc.raggr.'
      FieldKind = fkLookup
      FieldName = 'D_CodRaggr'
      LookupDataSet = Q300
      LookupKeyFields = 'Codice'
      LookupResultField = 'Descrizione'
      KeyFields = 'CodRaggr'
      Size = 40
      Lookup = True
    end
    object selTabellaVocePaghe1: TStringField
      DisplayLabel = 'Voce paghe 1'
      FieldName = 'VocePaghe1'
      Visible = False
      Size = 6
    end
    object selTabellaVocePaghe2: TStringField
      DisplayLabel = 'Voce paghe 2'
      FieldName = 'VocePaghe2'
      Visible = False
      Size = 6
    end
    object selTabellaVocePaghe3: TStringField
      DisplayLabel = 'Voce paghe 3'
      FieldName = 'VocePaghe3'
      Visible = False
      Size = 6
    end
    object selTabellaVocePaghe4: TStringField
      DisplayLabel = 'Voce paghe 4'
      FieldName = 'VocePaghe4'
      Visible = False
      Size = 6
    end
    object selTabellaASSEST_ANNUO: TStringField
      DisplayLabel = 'Assest. annuo'
      FieldName = 'ASSEST_ANNUO'
      Visible = False
      Size = 11
    end
    object selTabellaABBATTE_ECC_GIORN: TStringField
      DisplayLabel = 'Abbatte il liquidabile'
      FieldName = 'ABBATTE_ECC_GIORN'
      Visible = False
      Size = 1
    end
    object selTabellaLIMITE_LIQ: TStringField
      DisplayLabel = 'Inclusione nei limiti del liquidabile'
      FieldName = 'LIMITE_LIQ'
      Visible = False
      Size = 1
    end
    object selTabellaBANCAORE_NEGATIVA: TStringField
      DisplayLabel = 'Consente la banca ore negativa'
      FieldName = 'BANCAORE_NEGATIVA'
      Visible = False
      Size = 1
    end
    object selTabellaDATA_MIN_ASSEST: TDateTimeField
      DisplayLabel = 'Valido dal'
      FieldName = 'DATA_MIN_ASSEST'
      Visible = False
      OnSetText = selTabellaDATA_MIN_ASSESTSetText
      DisplayFormat = 'mm/yyyy'
      EditMask = '!00/0000;1;_'
    end
    object selTabellaAUMENTA_ECC_GIORN: TStringField
      FieldName = 'AUMENTA_ECC_GIORN'
      Visible = False
      Size = 1
    end
  end
  object Q300: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T300_RaggrGiustif ORDER BY Codice')
    Optimize = False
    Left = 32
    Top = 120
  end
  object D300: TDataSource
    DataSet = Q300
    Left = 60
    Top = 120
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T265_CauAssenze '
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 100
    Top = 120
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T275_CauPresenze  '
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 136
    Top = 120
  end
end
