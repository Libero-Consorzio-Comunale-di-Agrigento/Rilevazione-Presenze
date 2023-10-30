inherited P682FRaggruppamentiFondiDtM: TP682FRaggruppamentiFondiDtM
  OldCreateOrder = True
  Height = 208
  Width = 291
  object selP682: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from P682_FONDIRAGGR t'
      'order by cod_raggr')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001200000043004F0044005F00520041004700470052000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000}
    Left = 24
    Top = 16
    object selP682COD_RAGGR: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 15
      FieldName = 'COD_RAGGR'
      Required = True
      Size = 15
    end
    object selP682DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 70
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
  end
end
