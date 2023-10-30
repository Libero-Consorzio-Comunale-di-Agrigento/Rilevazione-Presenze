inherited A101FRaggrInterrogazioniDtm: TA101FRaggrInterrogazioniDtm
  OldCreateOrder = True
  object selT005: TOracleDataSet
    SQL.Strings = (
      'select T005.*, T005.ROWID'
      '  from T005_RAGGRQUERYPERS T005'
      ' order by T005.DESCRIZIONE')
    Optimize = False
    OracleDictionary.UseMessageTable = True
    BeforePost = BeforePostNoStorico
    AfterScroll = selT005AfterScroll
    Left = 32
    Top = 16
    object selT005ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT005DESCRIZIONE: TStringField
      DisplayLabel = 'Raggruppamento'
      DisplayWidth = 60
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selT006: TOracleDataSet
    SQL.Strings = (
      'select T006.ID, T006.COD_QUERY, T006.ROWID'
      '  from T006_ASSOCIA_QUERYPERS_RAGGR T006'
      ' where T006.ID = :ID_RAGGR'
      '   and exists (select 1 '
      '                 from T002_QUERYPERSONALIZZATE T002'
      '                where T002.NOME = T006.COD_QUERY'
      '                  and T002.APPLICAZIONE = :APPLICAZIONE)'
      ' order by T006.COD_QUERY')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A00490044005F00520041004700470052000300
      000000000000000000001A0000003A004100500050004C004900430041005A00
      49004F004E004500050000000000000000000000}
    OracleDictionary.UseMessageTable = True
    BeforeEdit = selT006BeforeEdit
    BeforePost = selT006BeforePost
    BeforeDelete = selT006BeforeDelete
    Left = 88
    Top = 16
    object selT006ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT006COD_QUERY: TStringField
      DisplayLabel = 'Interrogazione di servizio'
      DisplayWidth = 60
      FieldName = 'COD_QUERY'
      Size = 30
    end
  end
  object dsrT006: TDataSource
    AutoEdit = False
    DataSet = selT006
    Left = 88
    Top = 64
  end
end
