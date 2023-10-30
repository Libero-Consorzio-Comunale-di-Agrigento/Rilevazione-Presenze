object B110FForm: TB110FForm
  Left = 271
  Top = 114
  ActiveControl = btnRunClient
  Caption = '<B110> Server per mobile'
  ClientHeight = 412
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    285
    412)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label2: TLabel
    Left = 24
    Top = 104
    Width = 86
    Height = 13
    Caption = 'Parametri di avvio'
  end
  object lblLiveView: TLabel
    Left = 80
    Top = 350
    Width = 78
    Height = 13
    Caption = 'Debug Live View'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 120
    Height = 34
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 150
    Top = 8
    Width = 120
    Height = 34
    Anchors = [akTop, akRight]
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object EditPort: TEdit
    Left = 24
    Top = 67
    Width = 120
    Height = 21
    TabOrder = 2
    Text = '8080'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 372
    Width = 113
    Height = 34
    Anchors = [akLeft, akBottom]
    Caption = 'Apri browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object btnRunClient: TButton
    Left = 157
    Top = 372
    Width = 113
    Height = 34
    Anchors = [akRight, akBottom]
    Caption = 'Apri client di test'
    TabOrder = 4
    OnClick = btnRunClientClick
  end
  object memParametriServer: TMemo
    Left = 24
    Top = 123
    Width = 246
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'memParametriIni')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
    WordWrap = False
  end
  object swcLiveView: TToggleSwitch
    Left = 24
    Top = 346
    Width = 50
    Height = 20
    FrameColor = clGray
    ShowStateCaption = False
    StateCaptions.CaptionOn = 'LiveView ON'
    StateCaptions.CaptionOff = 'LiveView OFF'
    TabOrder = 6
    ThumbColor = clSilver
    ThumbWidth = 20
    OnClick = swcLiveViewClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    OnIdle = ApplicationEvents1Idle
    Left = 192
    Top = 64
  end
  object Taskbar1: TTaskbar
    TaskBarButtons = <>
    ProgressState = Normal
    ProgressMaxValue = 100
    ProgressValue = 100
    TabProperties = []
    Left = 248
    Top = 64
  end
end
