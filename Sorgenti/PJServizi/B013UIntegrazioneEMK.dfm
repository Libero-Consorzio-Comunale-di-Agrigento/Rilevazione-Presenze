object B013FIntegrazioneEMK: TB013FIntegrazioneEMK
  Left = 383
  Top = 200
  HelpContext = 9013000
  BorderStyle = bsSingle
  Caption = '<B013> Integrazione EMK e MICRONTEL'
  ClientHeight = 289
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 85
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lblMaxRigheLog: TLabel
      Left = 221
      Top = 36
      Width = 66
      Height = 13
      Caption = 'Max righe log:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAbilitazioniMensa: TLabel
      Left = 221
      Top = 62
      Width = 121
      Height = 13
      Caption = 'Codice abilitazioni mensa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatabase: TLabel
      Left = 5
      Top = 62
      Width = 49
      Height = 13
      Caption = 'Database:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ToolBar1: TToolBar
      Left = 1
      Top = 1
      Width = 399
      Height = 29
      ButtonWidth = 35
      Caption = 'ToolBar1'
      EdgeBorders = [ebLeft, ebTop, ebRight]
      Flat = False
      Images = ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      object ToolButtonAttiva: TToolButton
        Left = 0
        Top = 0
        Action = actAttiva
        Style = tbsCheck
      end
      object ToolButtonSospendi: TToolButton
        Left = 35
        Top = 0
        Action = actSospendi
      end
      object ToolButtonEsegui: TToolButton
        Left = 70
        Top = 0
        Action = actEsegui
      end
      object ToolButton41: TToolButton
        Left = 105
        Top = 0
        Width = 12
        Caption = 'ToolButton41'
        ImageIndex = 57
        Style = tbsSeparator
      end
      object ToolButtonVisualizzaLog: TToolButton
        Left = 117
        Top = 0
        Action = actVisualizzaLog
      end
      object ToolButtonCancellaLog: TToolButton
        Left = 152
        Top = 0
        Action = actCancellaLog
      end
      object ToolButton2: TToolButton
        Left = 187
        Top = 0
        Width = 12
        Caption = 'ToolButton2'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object ToolButtonPianificazione: TToolButton
        Left = 199
        Top = 0
        Action = actPianificazione
      end
      object ToolButton22: TToolButton
        Left = 234
        Top = 0
        Width = 12
        Caption = 'ToolButton22'
        ImageIndex = 34
        Style = tbsSeparator
      end
      object ToolButtonCancTimb: TToolButton
        Left = 246
        Top = 0
        Action = actCancellaTimbrature
      end
      object ToolButton43: TToolButton
        Left = 281
        Top = 0
        Width = 12
        Caption = 'ToolButton43'
        ImageIndex = 39
        Style = tbsSeparator
      end
      object ToolButton3: TToolButton
        Left = 293
        Top = 0
        Width = 12
        Caption = 'ToolButton3'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object ToolButtonEsci: TToolButton
        Left = 305
        Top = 0
        Action = actEsci
      end
    end
    object speMaxRigheLog: TSpinEdit
      Left = 336
      Top = 33
      Width = 55
      Height = 22
      Increment = 2
      MaxValue = 200
      MinValue = 10
      TabOrder = 2
      Value = 10
    end
    object chkChiudiTermineElab: TCheckBox
      Left = 2
      Top = 35
      Width = 205
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = 'Chiudi al termine dell'#39'elaborazione'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      TabOrder = 1
    end
    object edtAbMensa: TEdit
      Left = 347
      Top = 58
      Width = 44
      Height = 21
      MaxLength = 2
      TabOrder = 5
      OnChange = edtAbMensaChange
    end
    object edtDataBase: TEdit
      Left = 57
      Top = 58
      Width = 94
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object btnDataBase: TButton
      Left = 153
      Top = 57
      Width = 54
      Height = 23
      Caption = 'Cambia...'
      TabOrder = 4
      OnClick = btnDataBaseClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 85
    Width = 401
    Height = 185
    Align = alClient
    Color = cl3DLight
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object stbIntegrazione: TStatusBar
    Left = 0
    Top = 270
    Width = 401
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Panels = <>
    UseSystemFont = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 16
    Top = 120
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 48
    Top = 120
    object File1: TMenuItem
      Caption = '&File'
      ShortCut = 16449
      object Attiva1: TMenuItem
        Action = actAttiva
        ShortCut = 16467
      end
      object Sospendi1: TMenuItem
        Action = actSospendi
      end
      object Eseguiintegrazione1: TMenuItem
        Action = actEsegui
      end
      object Visualizzalog1: TMenuItem
        Action = actVisualizzaLog
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Pianificazione1: TMenuItem
        Action = actPianificazione
      end
      object N1: TMenuItem
        Action = actCancellaTimbrature
        Caption = 'Canc. &timb. di appoggio'
      end
      object Esci1: TMenuItem
        Action = actEsci
      end
    end
  end
  object ImageList1: TImageList
    Left = 128
    Top = 120
    Bitmap = {
      494C010108000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000000FFFF00007B7B00007B7B00007B
      7B00007B7B000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF007B7B7B000000000000000000000000007B7B7B00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      0000000000000000000000000000000000007B7B7B0000FFFF00000000000000
      00000000000000000000000000000000000000FFFF0000FFFF007B7B7B007B7B
      7B00007B7B00000000007B7B7B007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000BDBDBD00FFFFFF00FFFFFF00FFFFFF00BDBDBD0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000FFFFFF007B7B
      7B00007B7B00007B7B0000000000000000000000000000000000000000000000
      00000000000000000000007B00000000000000000000000000007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF007B7B
      7B00BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BDBDBD007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B0000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000000000000000000000
      0000007B7B00000000007B7B7B007B7B7B0000000000000000007B7B7B000000
      000000000000007B0000007B0000007B0000007B0000000000007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B0000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF00007B7B0000FF
      FF0000FFFF0000000000000000000000000000000000000000007B7B7B000000
      0000007B000000000000007B000000000000007B0000000000007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000FF000000000000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000007B000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000007B7B7B0000FFFF0000FFFF0000FF
      FF0000000000000000007B7B7B007B7B7B000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000000000007B
      0000007B0000007B000000000000007B0000007B0000000000007B7B7B007B7B
      7B007B7B7B000000000000000000000000000000000000000000FFFFFF007B7B
      7B00BDBDBD00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00BDBDBD007B7B
      7B00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD0000000000BDBDBD00000000007B7B7B000000
      000000000000000000000000000000000000000000007B7B7B0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000007B00000000000000000000007B0000007B0000000000007B7B7B007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000BDBDBD00FFFFFF0000000000FFFFFF00BDBDBD0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00000000007B7B7B00000000007B7B7B000000
      00000000000000000000000000000000000000000000000000007B7B7B0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      000000000000007B0000007B0000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B
      7B007B7B7B007B7B7B0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF007B7B7B000000000000000000000000007B7B7B00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00007B7B7B00000000007B7B7B00000000007B7B7B00000000007B7B7B000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B
      7B0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF007B7B7B007B7B7B007B7B7B007B7B7B00FFFF
      FF00FFFFFF007B7B7B0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF007B7B7B007B7B7B00FFFFFF007B7B7B00FFFFFF00FFFFFF007B7B
      7B00FFFFFF00FFFFFF0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD00BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B000000000000000000000000000000000000000000000000007B7B7B0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF007B7B
      7B007B7B7B00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF007B7B
      7B007B7B7B007B7B7B00000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF00FFFFFF007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF007B7B7B00FFFFFF00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00BDBDBD007B7B7B007B7B7B007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD00000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B0000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD007B7B7B000000000000000000000000007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000BDBDBD00BDBD
      BD0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000BDBDBD007B7B7B00FFFF
      FF0000000000000000000000FF0000007B0000007B000000000000000000FFFF
      FF007B7B7B007B7B7B00000000000000000000000000BDBDBD007B7B7B00FFFF
      FF00000000000000000000FF0000007B0000007B00000000000000000000FFFF
      FF007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000BDBDBD00000000000000
      FF00000000000000FF0000007B000000FF0000007B0000007B00000000000000
      FF00000000007B7B7B00000000000000000000000000BDBDBD000000000000FF
      00000000000000FF0000007B000000FF0000007B0000007B00000000000000FF
      0000000000007B7B7B00000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000000000BD000000
      BD000000FF000000FF008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000FF000000FF000000FF000000FF0000007B0000000000FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FF000000FF000000FF000000FF0000007B000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF0000000000000000000000FF000000
      FF000000FF000000FF000000FF0084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      FF0000000000FFFFFF000000FF000000FF0000007B000000FF00000000000000
      FF0000000000BDBDBD00000000000000000000000000FFFFFF000000000000FF
      000000000000FFFFFF0000FF000000FF0000007B000000FF00000000000000FF
      000000000000BDBDBD0000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF000000FF000000000000000000FFFF
      FF007B7B7B00BDBDBD00000000000000000000000000FFFFFF007B7B7B00FFFF
      FF000000000000000000FFFFFF00FFFFFF0000FF00000000000000000000FFFF
      FF007B7B7B00BDBDBD0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD000000000000000000000000000000000000000000BDBDBD000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000BDBDBD000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFF0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF000000FF00FFFFFF000000FF00FFFFFF0000000000BDBD
      BD00BDBDBD000000000000000000000000000000000000000000FFFFFF00BDBD
      BD0000000000FFFFFF0000FF0000FFFFFF0000FF0000FFFFFF0000000000BDBD
      BD00BDBDBD000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400FFFF0000BDBD
      0000BDBD0000BDBD00000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000000000000000000000FFFF
      FF00BDBDBD007B7B7B000000000000000000000000007B7B7B00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400FFFF0000BDBD000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00BDBDBD00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000084FFFF00000000008484840084848400848484008484
      840084FFFF000000000084FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF00424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF87FFFF8003E00F7F03FF0F8003E00F
      3E01FCC78003E00F1E00F3C78003E00F8C00CDC78003E00F8600D8438003E00F
      0201D5438003E00F0103B7C38003A00B00CFA2438003C00783FFB6418003E00F
      C1FFB8018003E00F00FFF8018003C007807FE0018003C007C03F80038007C007
      E0FFE00F800FF83FF07F301F801FF83FFF7FFFFFFFFFFF7EFE1FF83FF83F9001
      FE07E00FE00FC0030600C007C007E003FE0180038003E003F80180038003E003
      F80100010001E003F001000100010001C001000100018000C00100010001E007
      C00100010001E00FF00180038003E00FF80180038003E027F801C007C007C073
      F801E00FE00F9E79F801F83FF83F7EFE00000000000000000000000000000000
      000000000000}
  end
  object actlstBase: TActionList
    Images = ImageList1
    Left = 156
    Top = 120
    object actAttiva: TAction
      Caption = '&Attiva'
      Hint = 'Attiva integrazione'
      ImageIndex = 2
      ShortCut = 16449
      OnExecute = actAttivaExecute
    end
    object actSospendi: TAction
      Caption = 'S&ospendi'
      Hint = 'Sospendi integrazione'
      ImageIndex = 1
      ShortCut = 16463
      OnExecute = actSospendiExecute
    end
    object actVisualizzaLog: TAction
      Caption = '&Visualizza log'
      Hint = 'Visualizza log'
      ImageIndex = 3
      ShortCut = 16470
      OnExecute = actVisualizzaLogExecute
    end
    object actEsci: TAction
      Caption = '&Esci'
      Hint = 'Esci'
      ImageIndex = 0
      ShortCut = 16453
      OnExecute = actEsciExecute
    end
    object actCancellaLog: TAction
      Caption = '&Cancella Log'
      Enabled = False
      Hint = 'Cancella file di log (B013.LOG)'
      ImageIndex = 5
      ShortCut = 16451
      Visible = False
    end
    object actEsegui: TAction
      Caption = 'Ese&gui integrazione'
      Hint = 'Esegui integrazione ora'
      ImageIndex = 4
      ShortCut = 16455
      OnExecute = actEseguiExecute
    end
    object actPianificazione: TAction
      Caption = '&Pianificazione'
      Hint = 'Pianificazione integrazione'
      ImageIndex = 6
      ShortCut = 16464
      OnExecute = actPianificazioneExecute
    end
    object actCancellaTimbrature: TAction
      Caption = 'Cancella timbrature di appoggio'
      Hint = 'Cancella timbrature di appoggio'
      ImageIndex = 7
      ShortCut = 16468
      OnExecute = actCancellaTimbratureExecute
    end
  end
end