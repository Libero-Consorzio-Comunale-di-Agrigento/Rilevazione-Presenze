inherited A206FCodiciCondizioniTurni: TA206FCodiciCondizioniTurni
  HelpContext = 206000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A206> Codici condizioni'
  ClientHeight = 541
  ClientWidth = 784
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 523
    Width = 784
    ExplicitTop = 523
    ExplicitWidth = 784
  end
  inherited Panel1: TToolBar
    Width = 784
    ExplicitWidth = 784
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 784
    Height = 148
    Align = alTop
    TabOrder = 2
    object lblTipo: TLabel
      Left = 15
      Top = 123
      Width = 43
      Height = 13
      Caption = 'Tipologia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodice: TLabel
      Left = 15
      Top = 6
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
    object lblDescrizione: TLabel
      Left = 80
      Top = 6
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
    object lblSquadra: TLabel
      Left = 80
      Top = 54
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
    object lblAbilita: TLabel
      Left = 15
      Top = 77
      Width = 37
      Height = 13
      Caption = 'Abilitato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblObbliga: TLabel
      Left = 15
      Top = 100
      Width = 56
      Height = 13
      Caption = 'Obbligatorio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipoOperatore: TLabel
      Left = 145
      Top = 54
      Width = 47
      Height = 13
      Caption = 'Operatore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOrario: TLabel
      Left = 210
      Top = 54
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
    object lblSiglaTurno: TLabel
      Left = 275
      Top = 54
      Width = 50
      Height = 13
      Caption = 'Sigla turno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblGiorno: TLabel
      Left = 340
      Top = 54
      Width = 31
      Height = 13
      Caption = 'Giorno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMinimo: TLabel
      Left = 405
      Top = 54
      Width = 33
      Height = 13
      Caption = 'Minimo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOttimale: TLabel
      Left = 470
      Top = 54
      Width = 38
      Height = 13
      Caption = 'Ottimale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMassimo: TLabel
      Left = 535
      Top = 54
      Width = 41
      Height = 13
      Caption = 'Massimo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblValore: TLabel
      Left = 600
      Top = 54
      Width = 30
      Height = 13
      Caption = 'Valore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbValoreTipo: TDBLookupComboBox
      Left = 600
      Top = 119
      Width = 60
      Height = 21
      DataField = 'VALORE_TIPO'
      DataSource = DButton
      KeyField = 'TIPOVAL'
      ListField = 'TIPOVAL'
      TabOrder = 17
    end
    object dedtCodice: TDBEdit
      Left = 15
      Top = 20
      Width = 48
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtDescrizione: TDBEdit
      Left = 80
      Top = 20
      Width = 207
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object dchkGenerale: TDBCheckBox
      Left = 302
      Top = 22
      Width = 70
      Height = 17
      Caption = 'Generale'
      DataField = 'GENERALE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkIndividuale: TDBCheckBox
      Left = 379
      Top = 22
      Width = 70
      Height = 17
      Caption = 'Individuale'
      DataField = 'INDIVIDUALE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkSqA: TDBCheckBox
      Left = 80
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Sq A'
      DataField = 'SQUADRA_ABILITA'
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
    object dchkOpA: TDBCheckBox
      Left = 145
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Op A'
      DataField = 'TIPOOPE_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkOrA: TDBCheckBox
      Left = 210
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Or A'
      DataField = 'ORARIO_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkSgA: TDBCheckBox
      Left = 275
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Sg A'
      DataField = 'TURNO_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkGgA: TDBCheckBox
      Left = 340
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Gg A'
      DataField = 'GIORNO_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMnA: TDBCheckBox
      Left = 405
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Mn A'
      DataField = 'MINIMO_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMnO: TDBCheckBox
      Left = 405
      Top = 99
      Width = 60
      Height = 17
      Caption = 'Mn O'
      DataField = 'MINIMO_OBBLIGA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkOtA: TDBCheckBox
      Left = 470
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Ot A'
      DataField = 'OTTIMALE_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkOtO: TDBCheckBox
      Left = 470
      Top = 99
      Width = 60
      Height = 17
      Caption = 'Ot O'
      DataField = 'OTTIMALE_OBBLIGA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMxA: TDBCheckBox
      Left = 535
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Mx A'
      DataField = 'MASSIMO_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkMxO: TDBCheckBox
      Left = 535
      Top = 99
      Width = 60
      Height = 17
      Caption = 'Mx O'
      DataField = 'MASSIMO_OBBLIGA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkVrA: TDBCheckBox
      Left = 600
      Top = 76
      Width = 60
      Height = 17
      Caption = 'Vr A'
      DataField = 'VALORE_ABILITA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dchkVrO: TDBCheckBox
      Left = 600
      Top = 99
      Width = 60
      Height = 17
      Caption = 'Vr O'
      DataField = 'VALORE_OBBLIGA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object dgrdCodiciCondizioni: TDBGrid [3]
    Left = 0
    Top = 177
    Width = 784
    Height = 346
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
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODICE'
        Title.Caption = 'Codice'
        Width = 43
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Title.Caption = 'Descrizione'
        Width = 195
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GENERALE'
        Title.Caption = 'Gen.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INDIVIDUALE'
        Title.Caption = 'Ind.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SQUADRA_ABILITA'
        Title.Caption = 'Sq A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOOPE_ABILITA'
        Title.Caption = 'Op A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORARIO_ABILITA'
        Title.Caption = 'Or A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TURNO_ABILITA'
        Title.Caption = 'Sg A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GIORNO_ABILITA'
        Title.Caption = 'Gg A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MINIMO_ABILITA'
        Title.Caption = 'Mn A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MINIMO_OBBLIGA'
        Title.Caption = 'Mn O'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OTTIMALE_ABILITA'
        Title.Caption = 'Ot A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OTTIMALE_OBBLIGA'
        Title.Caption = 'Ot O'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MASSIMO_ABILITA'
        Title.Caption = 'Mx A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MASSIMO_OBBLIGA'
        Title.Caption = 'Mx O'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORE_ABILITA'
        Title.Caption = 'Vr A'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORE_OBBLIGA'
        Title.Caption = 'Vr O'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORE_TIPO'
        Title.Caption = 'Vr Tipo'
        Width = 43
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 384
    Top = 10
  end
  inherited DButton: TDataSource
    Left = 412
    Top = 10
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 440
    Top = 10
  end
  inherited ImageList1: TImageList
    Left = 468
    Top = 10
  end
  inherited ActionList1: TActionList
    Left = 496
    Top = 10
    inherited actInserisci: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actCancella: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actStoricizza: TAction
      Visible = False
    end
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actGomma: TAction
      Visible = False
    end
  end
end
