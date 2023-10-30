object A050FPosizioneRilevatore: TA050FPosizioneRilevatore
  Left = 427
  Top = 268
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A050> Posizione geografica rilevatore'
  ClientHeight = 510
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 89
    Width = 848
    Height = 421
    Align = alClient
    TabOrder = 1
    OnBeforeNavigate2 = WebBrowser1BeforeNavigate2
    OnNavigateComplete2 = WebBrowser1NavigateComplete2
    OnDocumentComplete = WebBrowser1DocumentComplete
    ExplicitLeft = -56
    ExplicitTop = 95
    ControlData = {
      4C000000A5570000832B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 848
    Height = 89
    Align = alTop
    TabOrder = 0
    object lblIndirizzo: TLabel
      Left = 3
      Top = 8
      Width = 38
      Height = 13
      Caption = 'Indirizzo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object memIndirizzo: TMemo
      Left = 3
      Top = 27
      Width = 729
      Height = 57
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btnGotoIndirizzo: TButton
      Left = 745
      Top = 27
      Width = 95
      Height = 28
      Caption = 'Vai'
      TabOrder = 1
      OnClick = btnGotoIndirizzoClick
    end
    object btnOK: TBitBtn
      Left = 745
      Top = 56
      Width = 95
      Height = 28
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnOKClick
    end
  end
end
