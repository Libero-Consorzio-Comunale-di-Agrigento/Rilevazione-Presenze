object A208FVisualizzazioneFileInfoEsterne: TA208FVisualizzazioneFileInfoEsterne
  Left = 92
  Top = 147
  Caption = '<A208> Visualizzazione file delle informazioni esterne'
  ClientHeight = 307
  ClientWidth = 523
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object memVisualizzaFileInfoEsterne: TMemo
    Left = 0
    Top = 0
    Width = 523
    Height = 266
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 266
    Width = 523
    Height = 41
    Align = alBottom
    TabOrder = 1
    object btnChiudi: TBitBtn
      Left = 442
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
end
