inherited A154FGestioneDocumentale: TA154FGestioneDocumentale
  Tag = 76
  HelpContext = 154000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A154> Gestione documentale'
  ClientHeight = 598
  ClientWidth = 699
  ExplicitWidth = 709
  ExplicitHeight = 648
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 580
    Width = 699
    ExplicitTop = 580
    ExplicitWidth = 699
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 699
    ExplicitTop = 24
    ExplicitWidth = 699
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 699
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 699
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 699
      Height = 24
      ExplicitWidth = 699
      ExplicitHeight = 24
    end
  end
  object dgrdDocumenti: TDBGrid [3]
    Left = 0
    Top = 418
    Width = 699
    Height = 162
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = pmnDocumenti
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'D_NOME_FILE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VERSIONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_DIMENSIONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERIODO_DAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERIODO_AL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CF_FAMILIARE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_RILASCIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_TIPOLOGIA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_UFFICIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AUTOCERTIFICAZIONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_ACCESSO_RESPONSABILE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_ACCESSO_PORTALE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_LETTURA_PROGRESSIVO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_DATI_ACCESSO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_PROPRIETARIO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CREAZIONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_NOTIFICA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HASH'
        Visible = False
      end>
  end
  object pnlDettaglio: TPanel [4]
    Left = 0
    Top = 48
    Width = 699
    Height = 370
    Align = alTop
    TabOrder = 2
    object lblID: TLabel
      Left = 9
      Top = 12
      Width = 67
      Height = 13
      Caption = 'ID documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataCreazione: TLabel
      Left = 391
      Top = 37
      Width = 72
      Height = 13
      Caption = 'Data creazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNote: TLabel
      Left = 9
      Top = 318
      Width = 23
      Height = 13
      Caption = 'Note'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblProprietario: TLabel
      Left = 9
      Top = 37
      Width = 81
      Height = 13
      Caption = 'Utente creazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPeriodoDal: TLabel
      Left = 9
      Top = 138
      Width = 102
      Height = 13
      Caption = 'Riferito al periodo dal '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPeriodoAl: TLabel
      Left = 201
      Top = 139
      Width = 8
      Height = 13
      Caption = 'al'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNomeFile: TLabel
      Left = 9
      Top = 112
      Width = 44
      Height = 13
      Caption = 'Nome file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipologia: TLabel
      Left = 9
      Top = 192
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
    object lblUfficio: TLabel
      Left = 9
      Top = 217
      Width = 30
      Height = 13
      Caption = 'Ufficio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDimensione: TLabel
      Left = 391
      Top = 112
      Width = 55
      Height = 13
      Caption = 'Dimensione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatiAccesso: TLabel
      Left = 9
      Top = 87
      Width = 107
      Height = 13
      Caption = 'Accesso amministratori'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataLetturaProgressivo: TLabel
      Left = 9
      Top = 62
      Width = 55
      Height = 13
      Caption = 'Data lettura'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataRilascio: TLabel
      Left = 67
      Top = 166
      Width = 48
      Height = 13
      Caption = 'rilasciato il'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFamiliare: TLabel
      Left = 9
      Top = 290
      Width = 103
      Height = 13
      Caption = 'Familiare di riferimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbld_Familiare: TLabel
      Left = 391
      Top = 287
      Width = 3
      Height = 13
      Caption = ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtID: TDBEdit
      Left = 124
      Top = 9
      Width = 83
      Height = 21
      Color = clSilver
      DataField = 'ID'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dedtDataCreazione: TDBEdit
      Left = 473
      Top = 34
      Width = 115
      Height = 21
      Color = clSilver
      DataField = 'DATA_CREAZIONE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object dedtPeriodoDal: TDBEdit
      Left = 124
      Top = 136
      Width = 74
      Height = 21
      DataField = 'PERIODO_DAL'
      DataSource = DButton
      TabOrder = 8
    end
    object dedtPeriodoAl: TDBEdit
      Left = 214
      Top = 136
      Width = 74
      Height = 21
      DataField = 'PERIODO_AL'
      DataSource = DButton
      TabOrder = 9
    end
    object dedtDProprietario: TDBEdit
      Left = 124
      Top = 34
      Width = 248
      Height = 21
      Color = clSilver
      DataField = 'D_PROPRIETARIO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object dedtDDimensione: TDBEdit
      Left = 473
      Top = 109
      Width = 115
      Height = 21
      Color = clSilver
      DataField = 'D_DIMENSIONE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object dedtDNomeFile: TDBEdit
      Left = 124
      Top = 109
      Width = 227
      Height = 21
      Color = clSilver
      DataField = 'D_NOME_FILE'
      DataSource = DButton
      TabOrder = 5
    end
    object btnSelezionaFile: TButton
      Left = 354
      Top = 109
      Width = 18
      Height = 21
      Hint = 'Seleziona il documento da caricare'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnSelezionaFileClick
    end
    object dcmbTipologia: TDBLookupComboBox
      Left = 124
      Top = 189
      Width = 248
      Height = 21
      DataField = 'TIPOLOGIA'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      NullValueKey = 46
      PopupMenu = pmnTabelle
      TabOrder = 11
    end
    object dcmbUfficio: TDBLookupComboBox
      Left = 124
      Top = 215
      Width = 248
      Height = 21
      DataField = 'UFFICIO'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      NullValueKey = 46
      PopupMenu = pmnTabelle
      TabOrder = 12
    end
    object dmemNote: TDBMemo
      Left = 124
      Top = 315
      Width = 470
      Height = 49
      DataField = 'NOTE'
      DataSource = DButton
      TabOrder = 16
    end
    object dchkAccessoResponsabile: TDBCheckBox
      Left = 8
      Top = 263
      Width = 363
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Visualizzabile dai responsabili'
      DataField = 'ACCESSO_RESPONSABILE'
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
    object dedtDDatiAccesso: TDBEdit
      Left = 124
      Top = 84
      Width = 248
      Height = 21
      Color = clSilver
      DataField = 'D_DATI_ACCESSO'
      DataSource = DButton
      TabOrder = 4
    end
    object dedtDataLetturaProgressivo: TDBEdit
      Left = 124
      Top = 59
      Width = 248
      Height = 21
      Color = clSilver
      DataField = 'DATA_LETTURA_PROGRESSIVO'
      DataSource = DButton
      TabOrder = 3
    end
    object grpBoxAutoCertificazioni: TGroupBox
      Left = 391
      Top = 142
      Width = 197
      Height = 113
      Caption = 'Autocertificazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      object lblDataRichiestaEnte: TLabel
        Left = 12
        Top = 57
        Width = 89
        Height = 13
        Caption = 'Data richiesta ente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataRicezioneEnte: TLabel
        Left = 12
        Top = 84
        Width = 92
        Height = 13
        Caption = 'Data ricezione ente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dChkAutocertificazione: TDBCheckBox
        Left = 12
        Top = 16
        Width = 106
        Height = 17
        Caption = 'Autocertificazione'
        DataField = 'AUTOCERTIFICAZIONE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dChkAutocertificazioneClick
      end
      object dchkRichiedereEnte: TDBCheckBox
        Left = 12
        Top = 34
        Width = 97
        Height = 17
        Caption = 'Richiedere ente'
        DataField = 'RICHIEDERE_ENTE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dEdtDataRichiestaEnte: TDBEdit
        Left = 110
        Top = 54
        Width = 77
        Height = 21
        DataField = 'DATA_RICHIESTA_ENTE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object dEdtDataRicezioneEnte: TDBEdit
        Left = 110
        Top = 81
        Width = 77
        Height = 21
        DataField = 'DATA_RICEZIONE_ENTE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object dEdtDataRilascio: TDBEdit
      Left = 124
      Top = 163
      Width = 74
      Height = 21
      DataField = 'DATA_RILASCIO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object drgpPathStorage: TDBRadioGroup
      Left = 209
      Top = 2
      Width = 162
      Height = 30
      Caption = 'Registrato su'
      Columns = 2
      DataField = 'D_PATH_STORAGE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Database'
        'File system')
      ParentFont = False
      ReadOnly = True
      TabOrder = 18
      Values.Strings = (
        'D'
        'F')
    end
    object btnEMailAllegato: TBitBtn
      Left = 594
      Top = 109
      Width = 90
      Height = 54
      BiDiMode = bdLeftToRight
      Caption = 'Invio mail al dipendente'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000000000000000000000000000000000
        0000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7FFF7FFF7FFF7FEF3DEF3DEF3DFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7FFF7FFF7FFF7FEF3DEF3DEF3DEF3DEF3DEF3DFF7FFF7F
        FF7FFF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F007C
        007C007C00000000FF7FEF3DEF3DEF3DFF7FFF7FFF7FFF7FFF7FFF7FFF7F007C
        1F00E00300000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F007C
        E003007C00000000000000000000000000000000000000000000000000000000
        0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      Layout = blGlyphBottom
      ParentBiDiMode = False
      TabOrder = 19
      WordWrap = True
      OnClick = btnEMailAllegatoClick
    end
    object dchkAccessoPortale: TDBCheckBox
      Left = 8
      Top = 243
      Width = 363
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Visualizzabile dal portale IrisWeb'
      Color = clBtnFace
      DataField = 'ACCESSO_PORTALE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 13
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dcmbFamiliare: TDBComboBox
      Left = 124
      Top = 284
      Width = 247
      Height = 21
      DataField = 'CF_FAMILIARE'
      DataSource = DButton
      TabOrder = 15
      OnExit = dcmbFamiliareExit
    end
  end
  inherited MainMenu1: TMainMenu [5]
    Left = 560
    Top = 2
  end
  inherited DButton: TDataSource [6]
    Left = 588
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [7]
    Left = 616
    Top = 2
  end
  inherited ImageList1: TImageList [8]
    Left = 644
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 672
    Top = 2
  end
  object ActionList2: TActionList
    Left = 512
    object actFileVisualizza: TAction
      Caption = 'Apri'
      Hint = 'Il documento verr'#224' scaricato nella cartella TEMP di sistema'
      OnExecute = actFileVisualizzaExecute
    end
    object actFileDownload: TAction
      Caption = 'Salva...'
      Hint = 'Salva...'
      OnExecute = actFileDownloadExecute
    end
    object actAccediTabella: TAction
      Caption = 'Accedi'
      Hint = 'Accedi'
      OnExecute = actAccediTabellaExecute
    end
    object actResetLettura: TAction
      Caption = 'Sblocca documento'
      OnExecute = actResetLetturaExecute
    end
  end
  object pmnTabelle: TPopupMenu
    OnPopup = pmnTabellePopup
    Left = 640
    Top = 56
    object mnuAccediTabella: TMenuItem
      Action = actAccediTabella
    end
  end
  object pmnDocumenti: TPopupMenu
    OnPopup = pmnDocumentiPopup
    Left = 312
    Top = 400
    object Apri1: TMenuItem
      Action = actFileVisualizza
    end
    object Salva1: TMenuItem
      Action = actFileDownload
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Resetlettura1: TMenuItem
      Action = actResetLettura
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnuCopiaExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = mnuCopiaExcelClick
    end
  end
  object dlgFileOpen: TOpenDialog
    Left = 400
  end
  object dlgFileSave: TSaveDialog
    Left = 456
  end
end
