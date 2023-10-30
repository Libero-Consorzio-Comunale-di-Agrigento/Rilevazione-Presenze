object B025FPubblDoc2GestDoc: TB025FPubblDoc2GestDoc
  Left = 0
  Top = 0
  Caption = '<B025> Utility spostamento file su documentale'
  ClientHeight = 561
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpStruttura: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 63
    Width = 529
    Height = 107
    Align = alTop
    Caption = '2. Selezionare la struttura documenti'
    TabOrder = 1
    Visible = False
    DesignSize = (
      529
      107)
    object Label1: TLabel
      Left = 8
      Top = 27
      Width = 108
      Height = 13
      Caption = 'Struttura pubblicazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRoot: TLabel
      Left = 8
      Top = 58
      Width = 74
      Height = 13
      Caption = 'Directory radice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblStruttura: TLabel
      Left = 288
      Top = 27
      Width = 100
      Height = 13
      Caption = 'Descrizione struttura'
    end
    object lblInfoRootDir: TLabel
      Left = 120
      Top = 85
      Width = 240
      Height = 13
      Caption = 'La directory radice '#232' inesistente o non accessibile.'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object cmbStrutture: TComboBox
      Left = 120
      Top = 24
      Width = 161
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbStruttureChange
    end
    object edtRootDir: TEdit
      Left = 120
      Top = 55
      Width = 338
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 1
      Text = 'edtRootDir'
    end
    object btnMostraRootDir: TButton
      Left = 464
      Top = 54
      Width = 62
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Apri'
      TabOrder = 2
      OnClick = btnMostraRootDirClick
    end
  end
  object grpTipologia: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 176
    Width = 529
    Height = 72
    Align = alTop
    Caption = '3. Selezionare la tipologia di documenti da assegnare'
    TabOrder = 2
    Visible = False
    object Label2: TLabel
      Left = 8
      Top = 25
      Width = 95
      Height = 13
      Caption = 'Tipologia documenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipologia: TLabel
      Left = 288
      Top = 25
      Width = 97
      Height = 13
      Caption = 'Descrizione tipologia'
    end
    object lblContaDocumenti: TLabel
      Left = 120
      Top = 49
      Width = 150
      Height = 13
      Caption = 'numero documenti per tipologia'
    end
    object cmbTipologie: TComboBox
      Left = 120
      Top = 22
      Width = 162
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbTipologieChange
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 513
    Width = 535
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      535
      48)
    object btnEsegui: TButton
      Left = 442
      Top = 12
      Width = 90
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Esegui'
      Default = True
      Enabled = False
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnResetUI: TButton
      Left = 338
      Top = 12
      Width = 90
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Reset'
      TabOrder = 1
      OnClick = btnResetUIClick
    end
  end
  object rgpOperazione: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 529
    Height = 54
    Align = alTop
    Caption = '1. Selezionare l'#39'operazione da eseguire'
    Columns = 2
    Items.Strings = (
      'Indicizzazione documenti'
      'Annullamento indicizzazione')
    TabOrder = 0
    OnClick = rgpOperazioneClick
  end
  object pnlLog: TPanel
    Left = 0
    Top = 251
    Width = 535
    Height = 262
    Align = alClient
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 1
      Top = 167
      Width = 533
      Height = 5
      Cursor = crVSplit
      Align = alTop
    end
    object memLogOperazione: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 527
      Height = 160
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'memLogOperazione')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object memFileNonIndicizzati: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 175
      Width = 527
      Height = 83
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'memFileNonIndicizzati')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
end
