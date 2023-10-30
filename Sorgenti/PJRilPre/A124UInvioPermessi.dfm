object A124FInvioPermessi: TA124FInvioPermessi
  Left = 0
  Top = 0
  Caption = '<A124> Invio permessi sindacali tramite WebService'
  ClientHeight = 412
  ClientWidth = 684
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
  object Panel3: TPanel
    Left = 0
    Top = 368
    Width = 684
    Height = 44
    Align = alBottom
    TabOrder = 1
    object btnChiudi: TBitBtn
      Left = 476
      Top = 9
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnEsegui: TBitBtn
      Left = 108
      Top = 9
      Width = 100
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
    object btnAnomalie: TBitBtn
      Left = 292
      Top = 9
      Width = 100
      Height = 25
      Caption = '&Anomalie'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAnomalieClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 52
    Align = alTop
    TabOrder = 0
    object lblDataDa: TLabel
      Left = 16
      Top = 7
      Width = 48
      Height = 13
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataA: TLabel
      Left = 136
      Top = 7
      Width = 41
      Height = 13
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSindacato: TLabel
      Left = 376
      Top = 7
      Width = 48
      Height = 13
      Caption = 'Sindacato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOrganismo: TLabel
      Left = 256
      Top = 7
      Width = 50
      Height = 13
      Caption = 'Organismo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDataDa: TMaskEdit
      Left = 16
      Top = 21
      Width = 69
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnChange = edtDataDaChange
      OnExit = edtDataDaExit
    end
    object btnDataDa: TButton
      Left = 87
      Top = 21
      Width = 14
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnDataDaClick
    end
    object edtDataA: TMaskEdit
      Left = 136
      Top = 21
      Width = 69
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnChange = edtDataAChange
      OnExit = edtDataAExit
    end
    object btnDataA: TButton
      Left = 207
      Top = 21
      Width = 14
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = btnDataAClick
    end
    object cmbSindacato: TDBLookupComboBox
      Left = 376
      Top = 21
      Width = 90
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      TabOrder = 5
      OnCloseUp = cmbSindacatoCloseUp
      OnKeyDown = cmbSindacatoKeyDown
      OnKeyUp = cmbSindacatoKeyUp
    end
    object cmbOrganismo: TDBLookupComboBox
      Left = 256
      Top = 21
      Width = 90
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      TabOrder = 4
      OnCloseUp = cmbSindacatoCloseUp
      OnKeyDown = cmbSindacatoKeyDown
      OnKeyUp = cmbSindacatoKeyUp
    end
  end
  object dgrdNoGEDAP: TDBGrid
    Left = 0
    Top = 52
    Width = 684
    Height = 316
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    ParentFont = False
    PopupMenu = pmnNoGEDAP
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object pmnNoGEDAP: TPopupMenu
    OnPopup = pmnNoGEDAPPopup
    Left = 265
    Top = 276
    object pmiImpostaPermessoSelInviato: TMenuItem
      Caption = 'Imposta permesso selezionato come inviato'
      OnClick = pmiImpostaPermessoSelInviatoClick
    end
    object pmiImpostaPermessiVisInviati: TMenuItem
      Caption = 'Imposta permessi visualizzati come inviati'
      OnClick = pmiImpostaTuttiPermessiInviatiClick
    end
  end
end
