inherited A144FComuniMedLegali: TA144FComuniMedLegali
  HelpContext = 144000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A144> Associazione comuni - medicine legali'
  ClientHeight = 487
  ClientWidth = 596
  ExplicitWidth = 612
  ExplicitHeight = 545
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 469
    Width = 596
    ExplicitTop = 469
    ExplicitWidth = 596
  end
  inherited Panel1: TToolBar
    Width = 596
    TabOrder = 0
    ExplicitWidth = 596
  end
  object dgrdComuniMedLegali: TDBGrid [2]
    AlignWithMargins = True
    Left = 0
    Top = 112
    Width = 596
    Height = 357
    Margins.Left = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    DataSource = DButton
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MED_LEGALE'
        Title.Caption = 'Cod. med. legale'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_MED_LEGALE'
        Title.Caption = 'Medicina legale'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 191
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_COMUNE'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'D_COMUNE'
        Title.Caption = 'Comune'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 272
        Visible = True
      end>
  end
  object pnlDatiAssociazione: TPanel [3]
    Left = 0
    Top = 29
    Width = 596
    Height = 80
    Align = alTop
    TabOrder = 3
    object lblMedLegale: TLabel
      Left = 13
      Top = 14
      Width = 77
      Height = 13
      Caption = 'Medicina legale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblMedLegale: TDBText
      Left = 222
      Top = 14
      Width = 69
      Height = 13
      AutoSize = True
      DataField = 'D_MED_LEGALE'
      DataSource = DButton
    end
    object lblComune: TLabel
      Left = 13
      Top = 50
      Width = 42
      Height = 13
      Caption = 'Comune:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbMedLegale: TDBLookupComboBox
      Left = 102
      Top = 11
      Width = 110
      Height = 21
      DataField = 'MED_LEGALE'
      DataSource = DButton
      DropDownWidth = 350
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnKeyDown = dcmbMedLegaleKeyDown
    end
    object dcmbComune: TDBLookupComboBox
      Left = 102
      Top = 47
      Width = 240
      Height = 21
      DataField = 'D_COMUNE'
      DataSource = DButton
      DropDownWidth = 470
      ListField = 'CODICE;CITTA;PROVINCIA'
      PopupMenu = PopupMenu1
      TabOrder = 1
      OnKeyDown = dcmbMedLegaleKeyDown
    end
    object dedtComune: TDBEdit
      Left = 348
      Top = 47
      Width = 68
      Height = 21
      DataField = 'COD_COMUNE'
      DataSource = DButton
      TabOrder = 2
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 392
    Top = 65522
  end
  inherited DButton: TDataSource
    Left = 420
    Top = 65522
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
    Top = 65522
  end
  inherited ImageList1: TImageList
    Left = 476
    Top = 65522
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 65522
  end
  object PopupMenu1: TPopupMenu
    Left = 538
    Top = 34
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
