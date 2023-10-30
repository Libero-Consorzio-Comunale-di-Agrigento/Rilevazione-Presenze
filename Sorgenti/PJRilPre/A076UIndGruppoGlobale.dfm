object A076FIndGruppoGlobale: TA076FIndGruppoGlobale
  Left = 236
  Top = 186
  Caption = '<A076> Visione globale indennit'#224
  ClientHeight = 299
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 34
    Width = 592
    Height = 265
    Align = alClient
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    HideScrollBars = False
    Lines.Strings = (
      'RichEdit1')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 34
    Align = alTop
    TabOrder = 1
    object lblDescDecorrenza: TLabel
      Left = 5
      Top = 10
      Width = 138
      Height = 16
      Caption = 'Indennit'#224' assegnate al '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = 16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataDecorrenza: TLabel
      Left = 150
      Top = 10
      Width = 113
      Height = 16
      Caption = 'lblDataDecorrenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 293
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Stampa'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object btnSetUpStampante: TBitBtn
      Left = 383
      Top = 4
      Width = 107
      Height = 25
      Caption = 'S&tampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00770000000000
        0777707777777770707700000000000007070778777BBB870007077887788887
        0707000000000000077007788887788070707000000000070700770777777770
        7070777077777776EEE078000000000E600870E6EEEEEEEE077778000000000E
        6008777707777786EEE077777000000800087777777777777777}
      TabOrder = 1
      OnClick = btnSetUpStampanteClick
    end
    object BitBtn2: TBitBtn
      Left = 504
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 2
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 512
    Top = 41
  end
end
