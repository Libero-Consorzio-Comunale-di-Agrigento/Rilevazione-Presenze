inherited A179FProfiliIterAutMW: TA179FProfiliIterAutMW
  OldCreateOrder = True
  object cdsI075LookUp: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'Codice'
      end>
    Params = <>
    StoreDefs = True
    AfterOpen = cdsI075LookUpAfterOpen
    Left = 34
    Top = 13
    Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020001000B4445534352495A49
      4F4E4501004900000001000557494454480200020014000000}
    object cdsI075LookUpCODICE: TStringField
      FieldName = 'CODICE'
      Size = 1
    end
    object cdsI075LookUpDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
    end
  end
end
