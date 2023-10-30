inherited WA200FImportazioneMassivaDocumentiDM: TWA200FImportazioneMassivaDocumentiDM
  OldCreateOrder = True
  object cdsAppTipologia: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 48
  end
  object cdsAppUfficio: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 104
  end
  object dsrAppTipologia: TDataSource
    DataSet = cdsAppTipologia
    Left = 143
    Top = 48
  end
  object dsrAppUfficio: TDataSource
    DataSet = cdsAppUfficio
    Left = 143
    Top = 104
  end
end
