object A091FLiqAuto: TA091FLiqAuto
  Left = 138
  Top = 98
  HelpContext = 2900
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A091> Liquidazione automatica ore di straordinario'
  ClientHeight = 247
  ClientWidth = 349
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpCerca: TSpeedButton
    Left = 0
    Top = 0
    Width = 29
    Height = 25
    Hint = 'Ricerca in anagrafico'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
      3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
      33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpCercaClick
  end
  object Label1: TLabel
    Left = 76
    Top = 4
    Width = 28
    Height = 13
    Caption = 'Anno:'
  end
  object Label2: TLabel
    Left = 140
    Top = 4
    Width = 26
    Height = 13
    Caption = 'Mese'
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 11
    Top = 177
    Width = 100
    Height = 25
    HelpContext = 2906
    Caption = 'S&tampante'
    TabOrder = 0
    OnClick = BtnPrinterSetUpClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object BtnClose: TBitBtn
    Left = 235
    Top = 177
    Width = 100
    Height = 25
    HelpContext = 2908
    Caption = '&Chiudi'
    TabOrder = 1
    Kind = bkClose
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 212
    Width = 349
    Height = 16
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 2
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 228
    Width = 349
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = '0 Records'
  end
  object CStampa: TCheckBox
    Left = 75
    Top = 55
    Width = 138
    Height = 17
    HelpContext = 2903
    Caption = 'Stampa liquidazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object EAnno: TSpinEdit
    Left = 76
    Top = 20
    Width = 53
    Height = 22
    MaxValue = 2999
    MinValue = 1980
    TabOrder = 5
    Value = 1980
    OnChange = EAnnoChange
  end
  object EMese: TComboBox
    Left = 140
    Top = 20
    Width = 109
    Height = 21
    ItemHeight = 13
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    TabOrder = 6
    OnChange = EAnnoChange
  end
  object BtnLiquidazione: TBitBtn
    Left = 124
    Top = 177
    Width = 97
    Height = 25
    Caption = 'Esegui'
    TabOrder = 7
    OnClick = BtnStampaClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
      000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
      FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
      00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
      00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
      FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
      0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
      05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
      55557F7777777555555500000005555555557777777555555555}
    NumGlyphs = 2
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 308
    Top = 4
  end
end
