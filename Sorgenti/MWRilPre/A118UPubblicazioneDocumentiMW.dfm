inherited A118FPubblicazioneDocumentiMW: TA118FPubblicazioneDocumentiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 121
  Width = 421
  object selFiltro: TOracleQuery
    ReadBuffer = 2
    Optimize = False
    Left = 216
    Top = 16
  end
  object selI200: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   I200_PUBBL_DOC'
      'order by CODICE')
    ReadBuffer = 10
    Optimize = False
    Left = 24
    Top = 16
  end
  object selI201: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   I201_PUBBL_DOC_PATH'
      'where  CODICE = :CODICE'
      'order by LIVELLO')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 88
    Top = 16
  end
  object selI202: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   I202_PUBBL_DOC_DESC'
      'where  CODICE = :CODICE'
      'order by LIVELLO, DAL')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 152
    Top = 16
  end
  object cdsI200Sorgente: TClientDataSet
    Active = True
    Aggregates = <>
    IndexFieldNames = 'CODICE'
    Params = <>
    Left = 288
    Top = 16
    Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      4943450100490000000100055749445448020002000F000B4445534352495A49
      4F4E45010049000000010005574944544802000200C8000000}
    object cdsI200SorgenteCODICE: TStringField
      FieldName = 'CODICE'
      Size = 15
    end
    object cdsI200SorgenteDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
  end
  object dsrI200Sorgente: TDataSource
    DataSet = cdsI200Sorgente
    Left = 288
    Top = 72
  end
end
