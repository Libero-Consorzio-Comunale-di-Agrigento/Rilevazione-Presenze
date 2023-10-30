object L001FStorici: TL001FStorici
  Left = 509
  Top = 152
  Caption = '<L001> Descrizione dati storici'
  ClientHeight = 393
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 362
    Height = 366
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 366
    Width = 362
    Height = 27
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 0
      Top = 2
      Width = 81
      Height = 25
      Caption = 'Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 84
    Top = 92
  end
  object Table1: TOracleDataSet
    SQL.Strings = (
      'SELECT T431.*,T431.ROWID FROM T431_DATISTORICI T431 '
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    BeforeInsert = Table1BeforeInsert
    AfterPost = Table1AfterPost
    Left = 56
    Top = 92
    object Table1CODICE: TFloatField
      FieldName = 'CODICE'
      ReadOnly = True
      Required = True
    end
    object Table1DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
  end
  object Query1: TOracleDataSet
    SQL.Strings = (
      'SELECT NOMECAMPO FROM I500_DATILIBERI '
      'ORDER BY PROGRESSIVO')
    Optimize = False
    Left = 120
    Top = 92
  end
end
