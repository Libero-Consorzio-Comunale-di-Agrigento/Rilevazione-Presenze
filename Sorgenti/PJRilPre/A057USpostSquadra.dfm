inherited A057FSpostSquadra: TA057FSpostSquadra
  HelpContext = 57000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A057> Spostamenti di squadra'
  ClientHeight = 486
  ClientWidth = 571
  ExplicitWidth = 587
  ExplicitHeight = 545
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 468
    Width = 571
    ExplicitTop = 468
    ExplicitWidth = 571
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 571
    TabOrder = 3
    ExplicitTop = 24
    ExplicitWidth = 571
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 571
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 571
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 571
      Height = 24
      ExplicitWidth = 571
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 53
    Width = 571
    Height = 219
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblCodSquadra: TLabel
      Left = 23
      Top = 43
      Width = 40
      Height = 13
      Caption = 'Squadra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblCodSquadra: TDBText
      Left = 130
      Top = 61
      Width = 266
      Height = 13
      DataField = 'DESC_SQUADRA'
      DataSource = DButton
    end
    object lblCodOrario: TLabel
      Left = 23
      Top = 129
      Width = 28
      Height = 13
      Caption = 'Orario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dlblCodOrario: TDBText
      Left = 100
      Top = 147
      Width = 266
      Height = 13
      DataField = 'DESC_ORARIO'
      DataSource = DButton
    end
    object lblSiglaTurno1: TLabel
      Left = 23
      Top = 172
      Width = 59
      Height = 13
      Caption = 'Sigla turno 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSiglaTurno2: TLabel
      Left = 100
      Top = 172
      Width = 59
      Height = 13
      Caption = 'Sigla turno 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblData: TLabel
      Left = 23
      Top = 0
      Width = 23
      Height = 13
      Caption = 'Data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodTipoOpe: TLabel
      Left = 23
      Top = 86
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tipo operatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbCodSquadra: TDBLookupComboBox
      Left = 23
      Top = 57
      Width = 100
      Height = 21
      DataField = 'SQUADRA'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      PopupMenu = PopupMenu1
      TabOrder = 2
      OnKeyDown = KeyDown
    end
    object dcmbCodOrario: TDBLookupComboBox
      Left = 23
      Top = 143
      Width = 70
      Height = 21
      DataField = 'ORARIO'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      PopupMenu = PopupMenu1
      TabOrder = 4
      OnKeyDown = KeyDown
    end
    object dcmbSiglaTurno1: TDBLookupComboBox
      Left = 23
      Top = 186
      Width = 59
      Height = 21
      DataField = 'TURNO1'
      DataSource = DButton
      KeyField = 'SIGLATURNI'
      ListField = 'SIGLATURNI'
      TabOrder = 5
      OnKeyDown = KeyDown
    end
    object dcmbSiglaTurno2: TDBLookupComboBox
      Left = 100
      Top = 186
      Width = 59
      Height = 21
      DataField = 'TURNO2'
      DataSource = DButton
      KeyField = 'SIGLATURNI'
      ListField = 'SIGLATURNI'
      TabOrder = 6
      OnKeyDown = KeyDown
    end
    object dedtData: TDBEdit
      Left = 23
      Top = 14
      Width = 68
      Height = 21
      DataField = 'DATA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnData: TButton
      Left = 91
      Top = 14
      Width = 14
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnDataClick
    end
    object dcmbCodTipoOpe: TDBLookupComboBox
      Left = 23
      Top = 100
      Width = 69
      Height = 21
      DataField = 'COD_TIPOOPE'
      DataSource = DButton
      KeyField = 'TIPOOPE'
      ListField = 'TIPOOPE'
      TabOrder = 3
    end
  end
  object dgrdSpostamenti: TDBGrid [4]
    Left = 0
    Top = 272
    Width = 571
    Height = 196
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Caption = 'Data'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SQUADRA'
        Title.Caption = 'Squadra'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_SQUADRA'
        Title.Caption = 'Desc. squadra'
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_TIPOOPE'
        Title.Caption = 'Tipo ope.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORARIO'
        Title.Caption = 'Orario'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_ORARIO'
        Title.Caption = 'Desc. orario'
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURNO1'
        Title.Caption = 'Sigla 1'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURNO2'
        Title.Caption = 'Sigla 2'
        Width = 40
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu [5]
    Left = 392
    Top = 10
  end
  inherited DButton: TDataSource [6]
    Left = 420
    Top = 10
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [7]
    Left = 448
    Top = 10
  end
  inherited ImageList1: TImageList [8]
    Left = 476
    Top = 10
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 10
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 192
    Top = 58
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
