inherited P684FGrigliaDett: TP684FGrigliaDett
  HelpContext = 3684500
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<P684> Dettaglio importo speso'
  ClientHeight = 542
  ClientWidth = 784
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 106
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 524
    Width = 784
    ExplicitTop = 524
    ExplicitWidth = 784
  end
  inherited Panel1: TToolBar
    Width = 784
    ExplicitWidth = 784
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 474
    Width = 784
    Height = 50
    Align = alBottom
    TabOrder = 2
    object btnChiudi: TBitBtn
      Left = 678
      Top = 12
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object gpbTipoAccorpamento: TGroupBox
      Left = 5
      Top = 2
      Width = 366
      Height = 42
      Caption = 'Tipo accorpamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object chkMese: TCheckBox
        Left = 118
        Top = 18
        Width = 102
        Height = 17
        Caption = 'Mese retribuzione'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chkMeseClick
      end
      object chkVoce: TCheckBox
        Left = 257
        Top = 18
        Width = 83
        Height = 17
        Caption = 'Codice voce'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = chkVoceClick
      end
      object chkDipendente: TCheckBox
        Left = 9
        Top = 18
        Width = 79
        Height = 17
        Caption = 'Dipendente'
        TabOrder = 2
        OnClick = chkDipendenteClick
      end
    end
  end
  object dgrdDettaglio: TDBGrid [3]
    Left = 0
    Top = 170
    Width = 784
    Height = 304
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dgrdDettaglioEditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'MATRICOLA'
        ReadOnly = True
        Title.Caption = 'Matricola'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COGNOME'
        ReadOnly = True
        Title.Caption = 'Cognome'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        ReadOnly = True
        Title.Caption = 'Nome'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_POSIZIONE_ECONOMICA'
        ReadOnly = True
        Title.Caption = 'Posiz. economica'
        Width = 90
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'DATA_RETRIBUZIONE'
        Title.Caption = 'Mese retribuzione'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'COD_CONTRATTO'
        Title.Caption = 'Contratto voci'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'COD_VOCE'
        Title.Caption = 'Codice voce'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descrizione'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMPORTO'
        Title.Caption = 'Importo'
        Visible = True
      end>
  end
  object TPanel [4]
    Left = 0
    Top = 24
    Width = 784
    Height = 126
    Align = alTop
    TabOrder = 4
    object lblDecorrenza: TLabel
      Left = 106
      Top = 5
      Width = 61
      Height = 13
      Caption = 'Decorrenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblDescFondo: TLabel
      Left = 186
      Top = 15
      Width = 471
      Height = 26
      AutoSize = False
      Caption = 'lblDescFondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object lblCodFondo: TLabel
      Left = 5
      Top = 5
      Width = 69
      Height = 13
      Caption = 'Codice fondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblCodVoceGen: TLabel
      Left = 5
      Top = 44
      Width = 110
      Height = 13
      Caption = 'Codice voce generale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblCodVoceDet: TLabel
      Left = 5
      Top = 84
      Width = 153
      Height = 13
      Caption = 'Codice destinazione dettagliata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblDescVoceGen: TLabel
      Left = 106
      Top = 62
      Width = 551
      Height = 16
      AutoSize = False
      Caption = 'lblDescVoceGen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblDescVoceDet: TLabel
      Left = 106
      Top = 102
      Width = 551
      Height = 16
      AutoSize = False
      Caption = 'lblDescVoceDet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object edtCodFondo: TEdit
      Left = 5
      Top = 20
      Width = 92
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edtCodFondo'
    end
    object edtDecorrenza: TEdit
      Left = 106
      Top = 20
      Width = 73
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edtDecorrenza'
    end
    object edtCodVoceGen: TEdit
      Left = 5
      Top = 59
      Width = 92
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = 'edtCodVoceGen'
    end
    object edtCodVoceDet: TEdit
      Left = 5
      Top = 99
      Width = 92
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = 'edtCodVoceDet'
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 150
    Width = 784
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Spesa dettagliata'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  inherited MainMenu1: TMainMenu
    Left = 424
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 452
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 480
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 508
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 536
    Top = 2
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 185
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = Copia2Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copia2Click
    end
  end
end
