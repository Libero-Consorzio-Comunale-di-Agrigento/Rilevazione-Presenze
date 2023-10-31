inherited A149FCategRimborsi: TA149FCategRimborsi
  Tag = 118
  HelpContext = 149000
  Caption = '<A149> Categoria rimborsi'
  ClientHeight = 381
  ExplicitWidth = 558
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 363
    ExplicitTop = 363
  end
  object dgrdCategRimborsi: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 542
    Height = 334
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited DButton: TDataSource
    DataSet = A149FCategRimborsiDM.selM022
  end
end
