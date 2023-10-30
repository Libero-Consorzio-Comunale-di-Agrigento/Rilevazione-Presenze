object B018FArticolo71: TB018FArticolo71
  Left = 183
  Top = 240
  HelpContext = 90018000
  Caption = '<B018> Ricodifica malattia Art.71 D.L.112/08'
  ClientHeight = 450
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TProgressBar
    Left = 0
    Top = 415
    Width = 639
    Height = 16
    Align = alBottom
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 431
    Width = 639
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 377
    Width = 639
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnEsegui: TBitBtn
      Left = 31
      Top = 6
      Width = 105
      Height = 25
      Caption = '&Esegui'
      Default = True
      ModalResult = 6
      TabOrder = 0
      OnClick = BtnEseguiClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
    end
    object btnChiudi: TBitBtn
      Left = 490
      Top = 6
      Width = 105
      Height = 25
      Caption = '&Chiudi'
      TabOrder = 3
      Kind = bkClose
    end
    object btnLog: TBitBtn
      Left = 184
      Top = 6
      Width = 105
      Height = 25
      Caption = '&Visualizza Log'
      Enabled = False
      TabOrder = 1
      OnClick = btnLogClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
    end
    object BitBtn1: TBitBtn
      Left = 337
      Top = 6
      Width = 105
      Height = 25
      Caption = '&Help'
      ModalResult = 6
      TabOrder = 2
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC3777777F7F777777F008888070888
        8003777777777777777F0F0770F7F0770F0373F33337F333337370FFFFF7FFFF
        F07337F33337F33337F370FFFB99FBFFF07337F33377F33337F330FFBF99BFBF
        F033373F337733333733370BFBF7FBFB0733337F333FF3337F33370FBF98BFBF
        0733337F3377FF337F333B0BFB990BFB03333373FF777FFF73333FB000B99000
        B33333377737777733333BFBFBFB99FBF33333333FF377F333333FBF99BF99BF
        B333333377F377F3333333FB99FB99FB3333333377FF77333333333FB9999FB3
        333333333777733333333333FBFBFB3333333333333333333333}
      NumGlyphs = 2
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 639
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 639
    inherited pnlSelAnagrafe: TPanel
      Width = 639
      ExplicitWidth = 639
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
      inherited btnRicerca: TBitBtn
        Left = 52
        ExplicitLeft = 52
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 24
    Width = 639
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object LblDaData: TLabel
      Left = 102
      Top = 9
      Width = 61
      Height = 13
      Caption = 'LblDaData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblAData: TLabel
      Left = 400
      Top = 9
      Width = 53
      Height = 13
      Caption = 'LblAData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TBBDaData: TBitBtn
      Left = 8
      Top = 3
      Width = 90
      Height = 25
      HelpContext = 83001
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = TBBDaDataClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
    end
    object TBBAData: TBitBtn
      Left = 306
      Top = 3
      Width = 90
      Height = 25
      HelpContext = 83001
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = TBBADataClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 55
    Width = 639
    Height = 322
    ActivePage = tbsPagina1
    Align = alClient
    TabOrder = 5
    OnChanging = PageControl1Changing
    object tbsPagina1: TTabSheet
      Caption = 'Pagina 1'
      object Label2: TLabel
        Left = 8
        Top = 7
        Width = 72
        Height = 13
        Caption = 'Codice malattia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescOrigine1: TLabel
        Left = 84
        Top = 34
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine2: TLabel
        Left = 84
        Top = 59
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine3: TLabel
        Left = 84
        Top = 86
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine4: TLabel
        Left = 84
        Top = 112
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine5: TLabel
        Left = 84
        Top = 138
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine6: TLabel
        Left = 84
        Top = 165
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine7: TLabel
        Left = 84
        Top = 191
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine8: TLabel
        Left = 84
        Top = 216
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine9: TLabel
        Left = 84
        Top = 241
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine10: TLabel
        Left = 84
        Top = 266
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest10: TLabel
        Left = 382
        Top = 266
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest9: TLabel
        Left = 382
        Top = 241
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest8: TLabel
        Left = 382
        Top = 216
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest7: TLabel
        Left = 382
        Top = 191
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest6: TLabel
        Left = 382
        Top = 165
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest5: TLabel
        Left = 382
        Top = 138
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest4: TLabel
        Left = 382
        Top = 112
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest3: TLabel
        Left = 382
        Top = 86
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest2: TLabel
        Left = 382
        Top = 59
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest1: TLabel
        Left = 382
        Top = 32
        Width = 15
        Height = 13
        Caption = '     '
      end
      object Label3: TLabel
        Left = 306
        Top = 7
        Width = 123
        Height = 13
        Caption = 'Codice per i primi 10 giorni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtCodOrigine1: TEdit
        Left = 8
        Top = 31
        Width = 50
        Height = 21
        Hint = 'Inserire tutti i codici che identificano i periodi di malattia'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine1: TButton
        Left = 62
        Top = 31
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine2: TEdit
        Left = 8
        Top = 56
        Width = 50
        Height = 21
        TabOrder = 4
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine2: TButton
        Left = 62
        Top = 56
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine3: TEdit
        Left = 8
        Top = 83
        Width = 50
        Height = 21
        TabOrder = 8
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine3: TButton
        Left = 62
        Top = 83
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 9
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine4: TEdit
        Left = 8
        Top = 109
        Width = 50
        Height = 21
        TabOrder = 12
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine4: TButton
        Left = 62
        Top = 109
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 13
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine5: TEdit
        Left = 8
        Top = 135
        Width = 50
        Height = 21
        TabOrder = 16
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine5: TButton
        Left = 62
        Top = 135
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 17
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine6: TEdit
        Left = 8
        Top = 162
        Width = 50
        Height = 21
        TabOrder = 20
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine6: TButton
        Left = 62
        Top = 162
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 21
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine7: TEdit
        Left = 8
        Top = 188
        Width = 50
        Height = 21
        TabOrder = 24
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine7: TButton
        Left = 62
        Top = 188
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 25
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine8: TEdit
        Left = 8
        Top = 213
        Width = 50
        Height = 21
        TabOrder = 28
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine8: TButton
        Left = 62
        Top = 213
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 29
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine9: TEdit
        Left = 8
        Top = 238
        Width = 50
        Height = 21
        TabOrder = 32
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine9: TButton
        Left = 62
        Top = 238
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 33
        OnClick = btnCodOrigine1Click
      end
      object btnCodOrigine10: TButton
        Left = 62
        Top = 263
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 37
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine10: TEdit
        Left = 8
        Top = 263
        Width = 50
        Height = 21
        TabOrder = 36
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest10: TEdit
        Left = 304
        Top = 263
        Width = 50
        Height = 21
        TabOrder = 38
        OnChange = edtCodOrigine1Change
      end
      object btnCodDest10: TButton
        Left = 360
        Top = 263
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 39
        OnClick = btnCodOrigine1Click
      end
      object edtCodDest9: TEdit
        Left = 304
        Top = 238
        Width = 50
        Height = 21
        TabOrder = 34
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest8: TEdit
        Left = 304
        Top = 213
        Width = 50
        Height = 21
        TabOrder = 30
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest7: TEdit
        Left = 304
        Top = 188
        Width = 50
        Height = 21
        TabOrder = 26
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest6: TEdit
        Left = 304
        Top = 162
        Width = 50
        Height = 21
        TabOrder = 22
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest5: TEdit
        Left = 304
        Top = 135
        Width = 50
        Height = 21
        TabOrder = 18
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest4: TEdit
        Left = 304
        Top = 109
        Width = 50
        Height = 21
        TabOrder = 14
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest3: TEdit
        Left = 304
        Top = 83
        Width = 50
        Height = 21
        TabOrder = 10
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest2: TEdit
        Left = 304
        Top = 56
        Width = 50
        Height = 21
        TabOrder = 6
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest1: TEdit
        Left = 304
        Top = 29
        Width = 50
        Height = 21
        TabOrder = 2
        OnChange = edtCodOrigine1Change
      end
      object btnCodDest1: TButton
        Left = 360
        Top = 29
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 3
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest2: TButton
        Left = 360
        Top = 56
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 7
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest3: TButton
        Left = 360
        Top = 83
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 11
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest4: TButton
        Left = 360
        Top = 109
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 15
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest5: TButton
        Left = 360
        Top = 135
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 19
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest6: TButton
        Left = 360
        Top = 162
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 23
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest7: TButton
        Left = 360
        Top = 188
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 27
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest8: TButton
        Left = 360
        Top = 213
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 31
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest9: TButton
        Left = 360
        Top = 238
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 35
        OnClick = btnCodOrigine1Click
      end
    end
    object tbsPagina2: TTabSheet
      Caption = 'Pagina 2'
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 7
        Width = 72
        Height = 13
        Caption = 'Codice malattia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDescOrigine11: TLabel
        Left = 84
        Top = 34
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine12: TLabel
        Left = 84
        Top = 59
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine13: TLabel
        Left = 84
        Top = 86
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine14: TLabel
        Left = 84
        Top = 112
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine15: TLabel
        Left = 84
        Top = 138
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine16: TLabel
        Left = 84
        Top = 165
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine17: TLabel
        Left = 84
        Top = 191
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine18: TLabel
        Left = 84
        Top = 216
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine19: TLabel
        Left = 84
        Top = 241
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescOrigine20: TLabel
        Left = 84
        Top = 266
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest20: TLabel
        Left = 382
        Top = 266
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest19: TLabel
        Left = 382
        Top = 241
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest18: TLabel
        Left = 382
        Top = 216
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest17: TLabel
        Left = 382
        Top = 191
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest16: TLabel
        Left = 382
        Top = 165
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest15: TLabel
        Left = 382
        Top = 138
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest14: TLabel
        Left = 382
        Top = 112
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest13: TLabel
        Left = 382
        Top = 86
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest12: TLabel
        Left = 382
        Top = 59
        Width = 15
        Height = 13
        Caption = '     '
      end
      object lblDescDest11: TLabel
        Left = 382
        Top = 32
        Width = 15
        Height = 13
        Caption = '     '
      end
      object Label24: TLabel
        Left = 306
        Top = 7
        Width = 123
        Height = 13
        Caption = 'Codice per i primi 10 giorni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtCodOrigine11: TEdit
        Left = 8
        Top = 31
        Width = 50
        Height = 21
        Hint = 'Inserire tutti i codici che identificano i periodi di malattia'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine11: TButton
        Left = 62
        Top = 31
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine12: TEdit
        Left = 8
        Top = 56
        Width = 50
        Height = 21
        TabOrder = 4
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine12: TButton
        Left = 62
        Top = 56
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 5
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine13: TEdit
        Left = 8
        Top = 83
        Width = 50
        Height = 21
        TabOrder = 8
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine13: TButton
        Left = 62
        Top = 83
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 9
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine14: TEdit
        Left = 8
        Top = 109
        Width = 50
        Height = 21
        TabOrder = 12
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine14: TButton
        Left = 62
        Top = 109
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 13
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine15: TEdit
        Left = 8
        Top = 135
        Width = 50
        Height = 21
        TabOrder = 16
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine15: TButton
        Left = 62
        Top = 135
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 17
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine16: TEdit
        Left = 8
        Top = 162
        Width = 50
        Height = 21
        TabOrder = 20
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine16: TButton
        Left = 62
        Top = 162
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 21
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine17: TEdit
        Left = 8
        Top = 188
        Width = 50
        Height = 21
        TabOrder = 24
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine17: TButton
        Left = 62
        Top = 188
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 25
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine18: TEdit
        Left = 8
        Top = 213
        Width = 50
        Height = 21
        TabOrder = 28
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine18: TButton
        Left = 62
        Top = 213
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 29
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine19: TEdit
        Left = 8
        Top = 238
        Width = 50
        Height = 21
        TabOrder = 32
        OnChange = edtCodOrigine1Change
      end
      object btnCodOrigine19: TButton
        Left = 62
        Top = 238
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 33
        OnClick = btnCodOrigine1Click
      end
      object btnCodOrigine20: TButton
        Left = 62
        Top = 263
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 37
        OnClick = btnCodOrigine1Click
      end
      object edtCodOrigine20: TEdit
        Left = 8
        Top = 263
        Width = 50
        Height = 21
        TabOrder = 36
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest20: TEdit
        Left = 304
        Top = 263
        Width = 50
        Height = 21
        TabOrder = 38
        OnChange = edtCodOrigine1Change
      end
      object btnCodDest20: TButton
        Left = 360
        Top = 263
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 39
        OnClick = btnCodOrigine1Click
      end
      object edtCodDest19: TEdit
        Left = 304
        Top = 238
        Width = 50
        Height = 21
        TabOrder = 34
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest18: TEdit
        Left = 304
        Top = 213
        Width = 50
        Height = 21
        TabOrder = 30
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest17: TEdit
        Left = 304
        Top = 188
        Width = 50
        Height = 21
        TabOrder = 26
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest16: TEdit
        Left = 304
        Top = 162
        Width = 50
        Height = 21
        TabOrder = 22
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest15: TEdit
        Left = 304
        Top = 135
        Width = 50
        Height = 21
        TabOrder = 18
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest14: TEdit
        Left = 304
        Top = 109
        Width = 50
        Height = 21
        TabOrder = 14
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest13: TEdit
        Left = 304
        Top = 83
        Width = 50
        Height = 21
        TabOrder = 10
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest12: TEdit
        Left = 304
        Top = 56
        Width = 50
        Height = 21
        TabOrder = 6
        OnChange = edtCodOrigine1Change
      end
      object edtCodDest11: TEdit
        Left = 304
        Top = 29
        Width = 50
        Height = 21
        TabOrder = 2
        OnChange = edtCodOrigine1Change
      end
      object btnCodDest11: TButton
        Left = 360
        Top = 29
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 3
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest12: TButton
        Left = 360
        Top = 56
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 7
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest13: TButton
        Left = 360
        Top = 83
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 11
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest14: TButton
        Left = 360
        Top = 109
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 15
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest15: TButton
        Left = 360
        Top = 135
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 19
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest16: TButton
        Left = 360
        Top = 162
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 23
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest17: TButton
        Left = 360
        Top = 188
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 27
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest18: TButton
        Left = 360
        Top = 213
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 31
        OnClick = btnCodOrigine1Click
      end
      object btnCodDest19: TButton
        Left = 360
        Top = 238
        Width = 16
        Height = 21
        Caption = '...'
        TabOrder = 35
        OnClick = btnCodOrigine1Click
      end
    end
  end
end
