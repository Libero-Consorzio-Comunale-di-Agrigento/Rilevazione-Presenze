object frmADSI: TfrmADSI
  Left = 0
  Top = 0
  Caption = 'ADSI'
  ClientHeight = 467
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 305
    Top = 161
    Width = 2
    Height = 306
    ExplicitLeft = 281
    ExplicitTop = 49
    ExplicitHeight = 418
  end
  object pnlIns: TPanel
    Left = 0
    Top = 0
    Width = 618
    Height = 161
    Align = alTop
    TabOrder = 0
    object lblNomeutente: TLabel
      Left = 8
      Top = 51
      Width = 62
      Height = 13
      Caption = 'Nome utente'
    end
    object lblPassword: TLabel
      Left = 296
      Top = 51
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 37
      Height = 13
      Caption = 'Dominio'
    end
    object Label2: TLabel
      Left = 296
      Top = 4
      Width = 71
      Height = 13
      Caption = 'Autenticazione'
    end
    object Label3: TLabel
      Left = 8
      Top = 94
      Width = 42
      Height = 13
      Caption = 'LDAP DN'
    end
    object btnInserisci: TButton
      Left = 423
      Top = 50
      Width = 75
      Height = 21
      Caption = 'Inserisci'
      TabOrder = 0
      OnClick = btnInserisciClick
    end
    object edtUsr: TEdit
      Left = 8
      Top = 70
      Width = 282
      Height = 21
      TabOrder = 3
    end
    object edtDominio: TEdit
      Left = 8
      Top = 23
      Width = 282
      Height = 21
      TabOrder = 1
    end
    object btnConnetti: TButton
      Left = 423
      Top = 23
      Width = 75
      Height = 21
      Caption = 'Connetti'
      TabOrder = 2
      OnClick = btnConnettiClick
    end
    object edtPassword: TEdit
      Left = 296
      Top = 70
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object btnLogin: TButton
      Left = 423
      Top = 77
      Width = 75
      Height = 21
      Caption = 'Login'
      TabOrder = 5
      OnClick = btnLoginClick
    end
    object edtProtocollo: TEdit
      Left = 296
      Top = 23
      Width = 121
      Height = 21
      TabOrder = 6
      Text = 'AD / LDAP'
    end
    object edlTDAPDN: TEdit
      Left = 8
      Top = 113
      Width = 282
      Height = 21
      TabOrder = 7
    end
  end
  object lstUsr: TListBox
    Left = 0
    Top = 161
    Width = 305
    Height = 306
    Align = alLeft
    ItemHeight = 13
    PopupMenu = ppMnuDelete
    TabOrder = 1
    ExplicitTop = 105
    ExplicitHeight = 362
  end
  object lstGrp: TListBox
    Left = 307
    Top = 161
    Width = 311
    Height = 306
    Align = alClient
    ItemHeight = 13
    TabOrder = 2
    ExplicitTop = 105
    ExplicitHeight = 362
  end
  object ppMnuDelete: TPopupMenu
    Left = 80
    Top = 88
    object Cancella1: TMenuItem
      Caption = 'Cancella'
      OnClick = Cancella1Click
    end
  end
end
