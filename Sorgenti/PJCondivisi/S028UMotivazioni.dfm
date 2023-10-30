inherited S028FMotivazioni: TS028FMotivazioni
  HelpContext = 2028000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<S028> Motivazioni provvedimento'
  ClientHeight = 554
  ClientWidth = 617
  ExplicitWidth = 633
  ExplicitHeight = 613
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 536
    Width = 617
    ExplicitTop = 536
    ExplicitWidth = 617
  end
  inherited Panel1: TToolBar
    Width = 617
    Height = 26
    EdgeBorders = [ebBottom]
    ExplicitWidth = 617
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 26
    Width = 617
    Height = 96
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 13
      Width = 33
      Height = 13
      Caption = 'Codice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 55
      Width = 107
      Height = 13
      Caption = 'Descrizione aggiuntiva'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 129
      Top = 13
      Width = 55
      Height = 13
      Caption = 'Descrizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtCodice: TDBEdit
      Left = 24
      Top = 27
      Width = 84
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtDescrizione: TDBEdit
      Left = 129
      Top = 27
      Width = 434
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object dedtDescrAgg: TDBEdit
      Left = 24
      Top = 69
      Width = 539
      Height = 21
      DataField = 'DESCRIZIONE_AGG'
      DataSource = DButton
      TabOrder = 2
    end
  end
  object dGrdMotivazioni: TDBGrid [3]
    Left = 0
    Top = 242
    Width = 617
    Height = 294
    TabStop = False
    Align = alClient
    DataSource = DButton
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object pnlGestioneNPA: TPanel [4]
    Left = 0
    Top = 122
    Width = 617
    Height = 120
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label5: TLabel
      Left = 24
      Top = 49
      Width = 283
      Height = 13
      Caption = 'Elenco numeri della colonna '#39'successivo'#39' del provvedimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Top = 6
      Width = 284
      Height = 13
      Caption = 'Elenco numeri della colonna '#39'precedente'#39' del provvedimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtNumeriSucc: TDBEdit
      Left = 24
      Top = 64
      Width = 539
      Height = 21
      DataField = 'ELENCO_NUMERI_SUCC'
      DataSource = DButton
      TabOrder = 2
    end
    object dedtNumeriPrec: TDBEdit
      Left = 24
      Top = 20
      Width = 539
      Height = 21
      DataField = 'ELENCO_NUMERI_PREC'
      DataSource = DButton
      TabOrder = 0
    end
    object DBCheckBox1: TDBCheckBox
      Left = 24
      Top = 94
      Width = 97
      Height = 17
      Caption = 'Stampa familiari'
      DataField = 'STAMPA_FAMILIARI'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object btnSucc: TBitBtn
      Left = 564
      Top = 62
      Width = 16
      Height = 25
      Caption = '...'
      TabOrder = 3
      OnClick = btnPrecClick
    end
    object btnPrec: TBitBtn
      Left = 564
      Top = 18
      Width = 16
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnPrecClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 392
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 420
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 476
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 2
  end
end
