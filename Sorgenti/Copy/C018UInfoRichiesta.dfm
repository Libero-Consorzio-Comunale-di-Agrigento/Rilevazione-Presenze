object C018FInfoRichiesta: TC018FInfoRichiesta
  Left = 0
  Top = 0
  Caption = '<C018> Informazioni Richiesta'
  ClientHeight = 549
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dgrdDocumenti: TDBGrid
    Left = 0
    Top = 450
    Width = 643
    Height = 99
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = pMnuDocumenti
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object grpInfoRichiedente: TGroupBox
    Left = 0
    Top = 0
    Width = 643
    Height = 150
    Align = alTop
    Caption = 'Informazioni della richiesta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblIDRichiesta: TLabel
      Left = 16
      Top = 16
      Width = 58
      Height = 13
      Caption = 'ID richiesta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDataRichiesta: TLabel
      Left = 16
      Top = 35
      Width = 70
      Height = 13
      Caption = 'Data richiesta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCodiceIter: TLabel
      Left = 16
      Top = 54
      Width = 55
      Height = 13
      Caption = 'Codice iter:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRichiedente: TLabel
      Left = 16
      Top = 73
      Width = 60
      Height = 13
      Caption = 'Richiedente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblNoteRichiedente: TLabel
      Left = 16
      Top = 92
      Width = 27
      Height = 13
      Caption = 'Note:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblIDRichiestaValue: TLabel
      Left = 160
      Top = 16
      Width = 90
      Height = 13
      Caption = 'lblIDRichiestaValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDataRichiestaValue: TLabel
      Left = 160
      Top = 35
      Width = 102
      Height = 13
      Caption = 'lblDataRichiestaValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCodiceIterValue: TLabel
      Left = 160
      Top = 54
      Width = 86
      Height = 13
      Caption = 'lblCodiceIterValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRichiedenteValue: TLabel
      Left = 160
      Top = 73
      Width = 92
      Height = 13
      Caption = 'lblRichiedenteValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblNoteRichiedenteValue: TLabel
      Left = 160
      Top = 92
      Width = 480
      Height = 52
      AutoSize = False
      Caption = 'lblNoteRichiedenteValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object grpInfoAutorizzatore: TGroupBox
    Left = 0
    Top = 150
    Width = 643
    Height = 150
    Align = alTop
    Caption = 'Informazioni dell'#39'autorizzazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object lblDataAutorizzazione: TLabel
      Left = 16
      Top = 20
      Width = 99
      Height = 13
      Caption = 'Data autorizzazione:'
    end
    object lblAutorizzatore: TLabel
      Left = 16
      Top = 39
      Width = 69
      Height = 13
      Caption = 'Autorizzatore:'
    end
    object lblNoteAutorizzatore: TLabel
      Left = 16
      Top = 58
      Width = 27
      Height = 13
      Caption = 'Note:'
    end
    object lblDataAutorizzazioneValue: TLabel
      Left = 160
      Top = 20
      Width = 129
      Height = 13
      Caption = 'lblDataAutorizzazioneValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblAutorizzatoreValue: TLabel
      Left = 160
      Top = 39
      Width = 101
      Height = 13
      Caption = 'lblAutorizzatoreValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblNoteAutorizzatoreValue: TLabel
      Left = 160
      Top = 58
      Width = 480
      Height = 79
      AutoSize = False
      Caption = 'lblNoteAutorizzatoreValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object grpInfoRevoca: TGroupBox
    Left = 0
    Top = 300
    Width = 643
    Height = 150
    Align = alTop
    Caption = 'Informazioni della revoca'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object lblIDRevoca: TLabel
      Left = 16
      Top = 20
      Width = 51
      Height = 13
      Caption = 'ID revoca:'
    end
    object lblDataRevoca: TLabel
      Left = 16
      Top = 39
      Width = 63
      Height = 13
      Caption = 'Data revoca:'
    end
    object lblNoteRevoca: TLabel
      Left = 16
      Top = 58
      Width = 27
      Height = 13
      Caption = 'Note:'
    end
    object lblIDRevocaValue: TLabel
      Left = 160
      Top = 20
      Width = 83
      Height = 13
      Caption = 'lblIDRevocaValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDataRevocaValue: TLabel
      Left = 160
      Top = 39
      Width = 69
      Height = 13
      Caption = 'lblDataRevoca'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblNoteRevocaValue: TLabel
      Left = 160
      Top = 58
      Width = 480
      Height = 86
      AutoSize = False
      Caption = 'lblNoteRevocaValue'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object pMnuDocumenti: TPopupMenu
    Left = 576
    Top = 472
    object Apri1: TMenuItem
      Caption = 'Apri'
      OnClick = Apri1Click
    end
    object Salva1: TMenuItem
      Caption = 'Salva'
      OnClick = Salva1Click
    end
  end
  object dlgFileSave: TSaveDialog
    Left = 591
    Top = 8
  end
  object dsrDocumentiInfo: TDataSource
    Left = 592
    Top = 56
  end
end
