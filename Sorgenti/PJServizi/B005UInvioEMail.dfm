object B005FInvioEMail: TB005FInvioEMail
  Left = 376
  Top = 247
  BorderStyle = bsSingle
  Caption = '<B005> Invio log per E-mail'
  ClientHeight = 179
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 41
    Width = 81
    Height = 13
    Caption = 'Indirizzo mittente:'
  end
  object Label2: TLabel
    Left = 19
    Top = 69
    Width = 107
    Height = 13
    Caption = 'Server di posta SMTP:'
  end
  object Label3: TLabel
    Left = 19
    Top = 97
    Width = 68
    Height = 13
    Caption = 'Utente SMTP:'
  end
  object Label4: TLabel
    Left = 19
    Top = 121
    Width = 82
    Height = 13
    Caption = 'Password SMTP:'
  end
  object edtindirizzo: TEdit
    Left = 157
    Top = 37
    Width = 168
    Height = 21
    TabOrder = 0
    OnChange = edtindirizzoChange
  end
  object edtServer: TEdit
    Left = 157
    Top = 65
    Width = 168
    Height = 21
    TabOrder = 1
    OnChange = edtindirizzoChange
  end
  object btnInvia: TBitBtn
    Left = 19
    Top = 147
    Width = 75
    Height = 25
    Caption = 'Invia'
    TabOrder = 2
    OnClick = btnInviaClick
  end
  object btnChiudi: TBitBtn
    Left = 251
    Top = 147
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Chiudi'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 3
  end
  object edtUtente: TEdit
    Left = 157
    Top = 93
    Width = 168
    Height = 21
    TabOrder = 4
    OnChange = edtindirizzoChange
  end
  object edtPassword: TEdit
    Left = 157
    Top = 117
    Width = 168
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    OnChange = edtindirizzoChange
  end
  object btnDatiAziendali: TButton
    Left = 157
    Top = 6
    Width = 169
    Height = 25
    Caption = 'Leggi dati aziendali'
    TabOrder = 6
    OnClick = btnDatiAziendaliClick
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 139
    Top = 139
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
    Left = 175
    Top = 139
  end
end
