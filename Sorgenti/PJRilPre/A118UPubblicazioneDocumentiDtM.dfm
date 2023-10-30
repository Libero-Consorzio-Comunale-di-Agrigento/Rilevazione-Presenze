inherited A118FPubblicazioneDocumentiDtM: TA118FPubblicazioneDocumentiDtM
  OldCreateOrder = True
  Height = 140
  Width = 279
  object selI200: TOracleDataSet
    SQL.Strings = (
      'select i200.*, i200.rowid '
      'from   i200_pubbl_doc i200'
      'order by codice')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterCancel = selI200AfterCancel
    AfterScroll = selI200AfterScroll
    Left = 24
    Top = 24
  end
  object selI201: TOracleDataSet
    SQL.Strings = (
      'select i201.*, i201.rowid '
      'from   i201_pubbl_doc_path i201'
      'where  codice = :CODICE'
      'order by livello')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    CachedUpdates = True
    BeforeInsert = selI201BeforeInsert
    BeforeEdit = selI201BeforeEdit
    BeforePost = selI201BeforePost
    AfterPost = selI201AfterPost
    BeforeDelete = selI201BeforeDelete
    AfterDelete = selI201AfterDelete
    BeforeScroll = selI201BeforeScroll
    AfterScroll = selI201AfterScroll
    OnNewRecord = selI201NewRecord
    Left = 80
    Top = 24
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
    CachedUpdates = True
    BeforeInsert = selI202BeforeInsert
    BeforeEdit = selI202BeforeEdit
    BeforePost = selI202BeforePost
    BeforeDelete = selI202BeforeDelete
    OnNewRecord = selI202NewRecord
    Left = 136
    Top = 24
    object selI202CODICE: TStringField
      FieldName = 'CODICE'
      Size = 10
    end
    object selI202LIVELLO: TIntegerField
      FieldName = 'LIVELLO'
    end
    object selI202CAMPO: TStringField
      FieldName = 'CAMPO'
    end
    object selI202DAL: TIntegerField
      FieldName = 'DAL'
    end
    object selI202LUNG: TIntegerField
      FieldName = 'LUNG'
    end
    object selI202VISIBILE: TStringField
      FieldName = 'VISIBILE'
      OnValidate = selI202VISIBILEValidate
      Size = 1
    end
  end
  object dsrI201: TDataSource
    DataSet = selI201
    Left = 80
    Top = 80
  end
  object dsrI202: TDataSource
    DataSet = selI202
    Left = 136
    Top = 80
  end
  object selT962Lookup: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from   T962_TIPO_DOCUMENTI'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    ReadOnly = True
    Left = 212
    Top = 24
  end
  object dsrT962Lookup: TDataSource
    DataSet = selT962Lookup
    Left = 216
    Top = 80
  end
end
