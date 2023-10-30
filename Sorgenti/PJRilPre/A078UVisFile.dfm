object A078FVisFile: TA078FVisFile
  Left = 260
  Top = 224
  Caption = '<A078> Visualizza comunicazione'
  ClientHeight = 337
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 296
    Width = 528
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 436
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 4
    end
    object btnStampa: TBitBtn
      Left = 113
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      ParentFont = False
      TabOrder = 1
      OnClick = btnStampaClick
    end
    object btnStampante: TBitBtn
      Left = 11
      Top = 8
      Width = 91
      Height = 25
      Caption = 'S&tampante'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 0
      OnClick = btnStampanteClick
    end
    object btnEMail: TBitBtn
      Left = 198
      Top = 8
      Width = 65
      Height = 25
      Caption = '&E-mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        0000777777777777777707FFFFFFFFFFFF70773FF33333333F770F77FFFFFFFF
        77F07F773FF3333F77370FFF77FFFF77FFF07F33773FFF7733370FFFFF0000FF
        FFF07F333F77773FF3370FFF70EEEE07FFF07F3F773333773FF70F707FFFFFF7
        07F07F77333333337737007EEEEEEEEEE70077FFFFFFFFFFFF77077777777777
        77707777777777777777307EEEEEEEEEE7033773FF333333F77333707FFFFFF7
        0733333773FF33F773333333707EE707333333333773F7733333333333700733
        3333333333377333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btnEMailClick
    end
    object btnRegistra: TBitBtn
      Left = 274
      Top = 8
      Width = 76
      Height = 25
      Caption = '&Registra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000000000000000000000000000000000
        00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
        00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
        00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
        00001F7C1F7C0000E03DE03D000000000000000000000000000000000000E03D
        00001F7C1F7C0000E03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03D
        00001F7C1F7C0000E03DE03D00000000000000000000000000000000E03DE03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E00000000
        00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000F75E
        00001F7C1F7C0000000000000000000000000000000000000000000000000000
        00001F7C1F7C}
      ParentFont = False
      TabOrder = 3
      OnClick = btnRegistraClick
    end
  end
  object memoComunicazione: TMemo
    Left = 0
    Top = 0
    Width = 528
    Height = 296
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 380
    Top = 308
  end
  object SaveDialog1: TSaveDialog
    Left = 408
    Top = 308
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 160
    Top = 64
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 96
    Top = 72
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 208
    Top = 64
  end
end
