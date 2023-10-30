object S720FImportProfili: TS720FImportProfili
  Left = 0
  Top = 0
  HelpContext = 2720000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<S720> Importazione profili'
  ClientHeight = 187
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel0: TPanel
    Left = 0
    Top = 0
    Width = 431
    Height = 111
    Align = alClient
    ParentBackground = False
    TabOrder = 0
    object lblAnno: TLabel
      Left = 20
      Top = 14
      Width = 81
      Height = 13
      Caption = 'Anno da valutare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNomeFileInput: TLabel
      Left = 20
      Top = 42
      Width = 117
      Height = 13
      Caption = 'Nome file di importazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSeparatore: TLabel
      Left = 285
      Top = 14
      Width = 52
      Height = 13
      Caption = 'Separatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtNomeFileInput: TSpeedButton
      Left = 394
      Top = 55
      Width = 15
      Height = 21
      Caption = '...'
      OnClick = sbtNomeFileInputClick
    end
    object edtAnno: TSpinEdit
      Left = 109
      Top = 11
      Width = 50
      Height = 22
      HelpContext = 200
      MaxLength = 4
      MaxValue = 9999
      MinValue = 2016
      TabOrder = 0
      Value = 2016
    end
    object edtNomeFileInput: TEdit
      Left = 20
      Top = 55
      Width = 374
      Height = 21
      TabOrder = 2
    end
    object edtSeparatore: TEdit
      Left = 344
      Top = 11
      Width = 50
      Height = 21
      TabOrder = 1
    end
    object chkSoloControlli: TCheckBox
      Left = 20
      Top = 84
      Width = 239
      Height = 17
      Caption = 'Effettua solo controllo dati da importare'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      OnClick = chkSoloControlliClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 111
    Width = 431
    Height = 76
    Align = alBottom
    TabOrder = 1
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 40
      Width = 429
      Height = 16
      Align = alBottom
      TabOrder = 3
    end
    object StatusBar: TStatusBar
      Left = 1
      Top = 56
      Width = 429
      Height = 19
      Panels = <
        item
          Width = 150
        end
        item
          Width = 50
        end>
    end
    object btnEsegui: TBitBtn
      Left = 20
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Esegui'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnChiudi: TBitBtn
      Left = 319
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnAnomalie: TBitBtn
      Left = 169
      Top = 8
      Width = 90
      Height = 25
      Cancel = True
      Caption = '&Anomalie'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333933333333333333333833333333000033333BFB999BFB333333
        333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
        FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
        7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
        BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
        000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
        37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
        FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
        8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
        33333333333333FF733333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAnomalieClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Txt/Csv files (*.txt;*.csv)|*.txt;*.csv'
    Left = 192
    Top = 1
  end
end
