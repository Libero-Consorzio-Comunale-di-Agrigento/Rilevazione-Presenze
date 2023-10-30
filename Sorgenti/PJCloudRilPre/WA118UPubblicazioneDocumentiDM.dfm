inherited WA118FPubblicazioneDocumentiDM: TWA118FPubblicazioneDocumentiDM
  Height = 252
  inherited selTabella: TOracleDataSet
    SQL.Strings = (
      'select i200.*, i200.rowid '
      'from   i200_pubbl_doc i200'
      ':ORDERBY')
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000C00
      0000460049004C00540052004F000100000000000800000052004F004F005400
      010000000000260000005400490050004F004C004F004700490041005F004400
      4F00430055004D0045004E0054004900010000000000}
    AfterPost = AfterPost
    AfterCancel = AfterCancel
    object selTabellaCODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 10
    end
    object selTabellaDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selTabellaFILTRO: TStringField
      DisplayLabel = 'Filtro'
      DisplayWidth = 100
      FieldName = 'FILTRO'
      Size = 2000
    end
    object selTabellaROOT: TStringField
      DisplayLabel = 'Directory radice'
      DisplayWidth = 50
      FieldName = 'ROOT'
      Size = 200
    end
    object selTabellaTIPOLOGIA_DOCUMENTI: TStringField
      DisplayLabel = 'Tipologia'
      FieldName = 'TIPOLOGIA_DOCUMENTI'
      Size = 10
    end
    object selTabellaSORGENTE_DOCUMENTI: TStringField
      DisplayLabel = 'Sorgente documenti'
      FieldName = 'SORGENTE_DOCUMENTI'
      Size = 15
    end
    object selTabellaURL_WS: TStringField
      DisplayLabel = 'URL webservice'
      DisplayWidth = 50
      FieldName = 'URL_WS'
      Size = 200
    end
  end
  inherited dsrTabella: TDataSource
    OnDataChange = dsrTabellaDataChange
  end
  object selI201: TOracleDataSet
    SQL.Strings = (
      'select i201.*, i201.rowid '
      'from   i201_pubbl_doc_path i201'
      'where  codice = :CODICE'
      ':ORDERBY')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A004F00520044004500520042005900010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000000C00000043004F0044004900430045000100000000000E00
      00004C004900560045004C004C004F00010000000000080000004E004F004D00
      4500010000000000060000004500580054000100000000001400000053004500
      500041005200410054004F00520045000100000000000C000000460049004C00
      540052004F00010000000000}
    BeforeInsert = selI201BeforeInsert
    BeforeEdit = selI201BeforeEdit
    BeforePost = selI201BeforePost
    AfterPost = selI201AfterPost
    BeforeDelete = selI201BeforeDelete
    AfterScroll = selI201AfterScroll
    OnNewRecord = selI201NewRecord
    Left = 32
    Top = 136
    object selI201CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 10
    end
    object selI201LIVELLO: TIntegerField
      DisplayLabel = 'Livello'
      DisplayWidth = 3
      FieldName = 'LIVELLO'
      Required = True
    end
    object selI201NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'NOME'
      Size = 200
    end
    object selI201EXT: TStringField
      DisplayLabel = 'Estensione'
      DisplayWidth = 5
      FieldName = 'EXT'
      Size = 10
    end
    object selI201SEPARATORE: TStringField
      DisplayLabel = 'Separatore'
      DisplayWidth = 2
      FieldName = 'SEPARATORE'
      Size = 5
    end
    object selI201FILTRO: TStringField
      DisplayLabel = 'Filtro'
      DisplayWidth = 100
      FieldName = 'FILTRO'
      Size = 2000
    end
  end
  object selI202: TOracleDataSet
    SQL.Strings = (
      'select i202.*, i202.rowid '
      'from   i202_pubbl_doc_desc i202'
      'where  i202.codice = :CODICE'
      'order by i202.livello, i202.dal')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    BeforePost = selI202BeforePost
    OnNewRecord = selI202NewRecord
    Left = 88
    Top = 136
    object selI202CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 10
    end
    object selI202LIVELLO: TIntegerField
      FieldName = 'LIVELLO'
      Visible = False
    end
    object selI202CAMPO: TStringField
      DisplayLabel = 'Campo'
      FieldName = 'CAMPO'
    end
    object selI202DAL: TIntegerField
      DisplayLabel = 'Posizione'
      FieldName = 'DAL'
    end
    object selI202LUNG: TIntegerField
      DisplayLabel = 'Lunghezza'
      FieldName = 'LUNG'
    end
    object selI202VISIBILE: TStringField
      DisplayLabel = 'Visibile'
      FieldName = 'VISIBILE'
      Size = 1
    end
  end
  object dsrI201: TDataSource
    DataSet = selI201
    Left = 32
    Top = 192
  end
  object dsrI202: TDataSource
    DataSet = selI202
    Left = 88
    Top = 192
  end
  object selT962Lookup: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T962_TIPO_DOCUMENTI'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 164
    Top = 136
  end
  object dsrT962Lookup: TDataSource
    DataSet = selT962Lookup
    Left = 165
    Top = 192
  end
end
