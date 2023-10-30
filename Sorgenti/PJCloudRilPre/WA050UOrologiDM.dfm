inherited WA050FOrologiDM: TWA050FOrologiDM
  Height = 400
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'SELECT T361.*,T361.ROWID FROM T361_OROLOGI T361 '
      ':ORDERBY')
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    OnNewRecord = OnNewRecord
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Origin = 'T361_OROLOGI.CODICE'
      Size = 2
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 100
      FieldName = 'DESCRIZIONE'
      Origin = 'T361_OROLOGI.DESCRIZIONE'
      Size = 100
    end
    object selTabellaFUNZIONE: TStringField
      DisplayLabel = 'Funzione'
      FieldName = 'FUNZIONE'
      Origin = 'T361_OROLOGI.FUNZIONE'
      Size = 1
    end
    object selTabellaRILEVATORE: TStringField
      DisplayLabel = 'Rilevatore'
      FieldName = 'RILEVATORE'
      Size = 10
    end
    object selTabellaSCARICO: TStringField
      DisplayLabel = 'Scarico'
      FieldName = 'SCARICO'
    end
    object selTabellaCAUSMENSA: TStringField
      FieldName = 'CAUSMENSA'
      Origin = 'T361_OROLOGI.CAUSMENSA'
      Visible = False
      Size = 5
    end
    object selTabellaVERSO: TStringField
      FieldName = 'VERSO'
      Visible = False
      Size = 1
    end
    object selTabellaPOSTAZIONE: TStringField
      FieldName = 'POSTAZIONE'
      Visible = False
      Size = 5
    end
    object selTabellaINDIRIZZO_TERMINALE: TStringField
      FieldName = 'INDIRIZZO_TERMINALE'
      Visible = False
      Size = 5
    end
    object selTabellaINDIRIZZO_IP: TStringField
      FieldName = 'INDIRIZZO_IP'
      Visible = False
      Size = 15
    end
    object selTabellaRICEZIONE_MESSAG: TStringField
      FieldName = 'RICEZIONE_MESSAG'
      Required = True
      Visible = False
      Size = 1
    end
    object selTabellaAPPLICA_PERCORRENZA_PM: TStringField
      FieldName = 'APPLICA_PERCORRENZA_PM'
      Visible = False
      Size = 1
    end
    object selTabellaTIPO_LOCALITA: TStringField
      FieldName = 'TIPO_LOCALITA'
      Visible = False
      Size = 1
    end
    object selTabellaCOD_LOCALITA: TStringField
      FieldName = 'COD_LOCALITA'
      Visible = False
      Size = 6
    end
    object selTabellaINDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Visible = False
      Size = 60
    end
    object selTabellaD_LOCALITA: TStringField
      FieldKind = fkLookup
      FieldName = 'D_LOCALITA'
      LookupDataSet = SelLocalita
      LookupKeyFields = 'CODICE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_LOCALITA'
      Visible = False
      Size = 60
      Lookup = True
    end
    object selTabellaLAT: TFloatField
      DisplayLabel = 'Latitudine'
      FieldName = 'LAT'
      DisplayFormat = '0.00000000'
    end
    object selTabellaLNG: TFloatField
      DisplayLabel = 'Longitudine'
      FieldName = 'LNG'
      DisplayFormat = '0.00000000'
    end
    object selTabellaRAGGIO_VALIDITA: TIntegerField
      DisplayLabel = 'Raggio validit'#224
      DisplayWidth = 4
      FieldName = 'RAGGIO_VALIDITA'
      MaxValue = 9999
      MinValue = -1
    end
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T305_CAUGIUSTIF'
      'ORDER BY CODICE')
    Optimize = False
    Left = 68
    Top = 128
  end
  object D305: TDataSource
    AutoEdit = False
    DataSet = Q305
    Left = 96
    Top = 128
  end
  object selI100: TOracleDataSet
    SQL.Strings = (
      'SELECT SCARICO FROM MONDOEDP.I100_PARSCARICO'
      'ORDER BY SCARICO')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000000E0000005300430041005200490043004F00010000000000}
    Left = 152
    Top = 128
  end
  object dsrI100: TDataSource
    AutoEdit = False
    DataSet = selI100
    Left = 192
    Top = 128
  end
  object DSelLocalita: TDataSource
    DataSet = SelLocalita
    Left = 96
    Top = 184
  end
  object SelLocalita: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE, DESCRIZIONE CITTA, ROWID FROM M042_LOCALITA :ORDE' +
        'RBY')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000000A00
      000043004900540054004100010000000000}
    Left = 32
    Top = 184
    object SelLocalitaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object SelLocalitaCITTA: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'CITTA'
      Size = 60
    end
  end
  object ControlloRilev: TOracleQuery
    SQL.Strings = (
      'select scarico, codice from T361_orologi'
      'where codice <> :CODICE'
      '  and rilevatore = :RILEV')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000C0000003A00520049004C004500560005000000000000000000
      0000}
    Left = 48
    Top = 256
  end
  object selM042: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE, ROWID '
      'from M042_LOCALITA '
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 200
    Top = 184
    object selM042CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object selM042DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 30
    end
  end
  object dsrM042: TDataSource
    DataSet = selM042
    Left = 251
    Top = 184
  end
end
