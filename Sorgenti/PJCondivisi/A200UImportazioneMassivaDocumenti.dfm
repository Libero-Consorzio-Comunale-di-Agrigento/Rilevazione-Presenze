object A200FImportazioneMassivaDocumenti: TA200FImportazioneMassivaDocumenti
  Left = 0
  Top = 0
  HelpContext = 200000
  Caption = '<A200> Importazione massiva documenti'
  ClientHeight = 658
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 643
    Height = 23
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 643
    ExplicitHeight = 23
    inherited pnlSelAnagrafe: TPanel
      Width = 643
      Height = 23
      ExplicitWidth = 643
      ExplicitHeight = 23
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 639
    Width = 643
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 400
      end>
  end
  object pnlImpImposta: TPanel
    Left = 0
    Top = 23
    Width = 643
    Height = 473
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblmpPath: TLabel
      Left = 8
      Top = 8
      Width = 135
      Height = 13
      Alignment = taRightJustify
      Caption = 'Path documenti da importare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImpFiltro: TLabel
      Left = 8
      Top = 32
      Width = 22
      Height = 13
      Caption = 'Filtro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImpFormato: TLabel
      Left = 8
      Top = 56
      Width = 136
      Height = 13
      Caption = 'Formato nome file in ingresso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImpTipologia: TLabel
      Left = 8
      Top = 199
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
    object lblImpNote: TLabel
      Left = 8
      Top = 333
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
    object lblImpUfficio: TLabel
      Left = 8
      Top = 282
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
    object lblImpSeparatore: TLabel
      Left = 184
      Top = 56
      Width = 83
      Height = 13
      Caption = 'Separatore campi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImpNomeFile: TLabel
      Left = 184
      Top = 79
      Width = 61
      Height = 13
      Caption = 'Nome dei file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblInfoHelp: TLabel
      Left = 184
      Top = 103
      Width = 246
      Height = 13
      Caption = 'Per informazioni sul formato consultare l'#39'help in linea.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImpNomeFileOut: TLabel
      Left = 8
      Top = 125
      Width = 139
      Height = 13
      Caption = 'Nome dei file su documentale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtImpPath: TEdit
      Left = 184
      Top = 5
      Width = 415
      Height = 21
      TabOrder = 0
      Text = 'C:\Users\sviluppo01\Desktop\Test\Out'
      OnChange = edtImpPathChange
    end
    object btnImpPathBrowse: TButton
      Left = 605
      Top = 5
      Width = 20
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnImpPathBrowseClick
    end
    object edtImpFiltro: TEdit
      Left = 184
      Top = 29
      Width = 76
      Height = 21
      TabOrder = 2
      Text = '*.*'
      OnChange = edtImpFiltroChange
    end
    object memNote: TMemo
      Left = 184
      Top = 330
      Width = 441
      Height = 76
      MaxLength = 2000
      ScrollBars = ssBoth
      TabOrder = 9
    end
    object chkImpVisualIrisWeb: TCheckBox
      Left = 8
      Top = 410
      Width = 188
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Visualizzabile dal portale IrisWeb'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object btnImpAnalizza: TButton
      Left = 8
      Top = 435
      Width = 135
      Height = 25
      Caption = 'Analizza documenti'
      TabOrder = 11
      OnClick = btnImpAnalizzaClick
    end
    object dcmbImpTipologia: TDBLookupComboBox
      Left = 184
      Top = 194
      Width = 233
      Height = 21
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      TabOrder = 6
    end
    object dcmbImpUfficio: TDBLookupComboBox
      Left = 184
      Top = 278
      Width = 233
      Height = 21
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      TabOrder = 8
    end
    object edtImpSeparatore: TEdit
      Left = 273
      Top = 53
      Width = 32
      Height = 21
      MaxLength = 1
      TabOrder = 3
      Text = '_'
      OnChange = edtImpFormatiOnChange
    end
    object edtImpNomeFile: TEdit
      Left = 273
      Top = 76
      Width = 352
      Height = 21
      TabOrder = 4
      Text = '<MATRICOLA>_<NOME_DEL_FILE>'
      OnChange = edtImpFormatiOnChange
    end
    object pnlImpNomeFileOut: TPanel
      Left = 178
      Top = 122
      Width = 463
      Height = 71
      BevelOuter = bvNone
      TabOrder = 5
      object lblImpNomeFileExt: TLabel
        Left = 430
        Top = 28
        Width = 17
        Height = 13
        Caption = '.ext'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object rgpImpNomeFileOutOrig: TRadioButton
        Left = 6
        Top = 1
        Width = 241
        Height = 17
        Caption = 'Stesso nome del file originale su file system'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = rgpImpNomeFileOutOnClick
      end
      object rgpImpNomeFileOutPred: TRadioButton
        Left = 6
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Predefinito:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = rgpImpNomeFileOutOnClick
      end
      object rgpImpNomeFileOutTag: TRadioButton
        Left = 6
        Top = 47
        Width = 241
        Height = 17
        Caption = '<NOME_DEL_FILE> da file originale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = rgpImpNomeFileOutOnClick
      end
      object edtImpNomeFileOutPred: TEdit
        Left = 82
        Top = 23
        Width = 346
        Height = 21
        TabOrder = 2
        OnChange = edtImpNomeFileOutPredChange
      end
    end
    object rgpImpAzioneDocTip: TRadioGroup
      Left = 184
      Top = 221
      Width = 441
      Height = 52
      Caption = 'Se esiste gi'#224' un documento di questa tipologia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Aggiungi il nuovo documento mantenendo quello esistente'
        'Sovrascrivi il documento esistente')
      ParentFont = False
      TabOrder = 7
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 0
      Top = 302
      Width = 537
      Height = 26
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 12
      ExplicitTop = 302
      ExplicitWidth = 537
      ExplicitHeight = 26
      inherited lblInizio: TLabel
        Top = 6
        Width = 95
        Caption = 'Riferiti al periodo dal'
        ExplicitTop = 6
        ExplicitWidth = 95
      end
      inherited lblFine: TLabel
        Left = 308
        Top = 6
        Width = 8
        Caption = 'al'
        ExplicitLeft = 308
        ExplicitTop = 6
        ExplicitWidth = 8
      end
      inherited edtInizio: TMaskEdit
        Left = 184
        Top = 3
        OnExit = frmInputPeriodoedtInizioExit
        ExplicitLeft = 184
        ExplicitTop = 3
      end
      inherited edtFine: TMaskEdit
        Left = 323
        Top = 3
        OnExit = frmInputPeriodoedtFineExit
        ExplicitLeft = 323
        ExplicitTop = 3
      end
      inherited btnIndietro: TBitBtn
        Left = 442
        Top = 2
        ExplicitLeft = 442
        ExplicitTop = 2
      end
      inherited btnAvanti: TBitBtn
        Left = 464
        Top = 2
        ExplicitLeft = 464
        ExplicitTop = 2
      end
      inherited btnDataInizio: TBitBtn
        Left = 255
        Top = 2
        ExplicitLeft = 255
        ExplicitTop = 2
      end
      inherited btnDataFine: TBitBtn
        Left = 394
        Top = 2
        ExplicitLeft = 394
        ExplicitTop = 2
      end
    end
  end
  object pnlImpComandi: TPanel
    Left = 0
    Top = 585
    Width = 643
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lblImpFilesSelezionati: TLabel
      Left = 335
      Top = 12
      Width = 82
      Height = 13
      Caption = 'Files selezionati: -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImpDimensTotale: TLabel
      Left = 472
      Top = 12
      Width = 93
      Height = 13
      Caption = 'Dimensione totale: -'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnAnomalie: TBitBtn
      Left = 116
      Top = 6
      Width = 154
      Height = 25
      Caption = 'Messaggi elaborazione'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F00
        00FF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF00FFFFFFFFFF00FFFF0000FF0000FF0000FF00FFFFFFFFFF00FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF7F7F7F00
        00FF7F7F7FFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00
        00FF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF7F7F7F00FFFFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00
        00FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF0000FF0000FFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF7F7F7F7F7F7F00FFFFFF
        FFFF7F7F7F0000FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFF0000FF0000FFFFFFFF00FFFF7F7F7F0000FF0000FF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF0000FF0000FF7F7F7FFF
        FFFF7F7F7F0000FF0000FFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFF00FFFFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFF00FFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF00
        00FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF
        FFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = btnAnomalieClick
    end
    object btnEsegui: TBitBtn
      Left = 8
      Top = 6
      Width = 106
      Height = 25
      Caption = 'Esegui'
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 1
      OnClick = btnEseguiClick
    end
  end
  object prgImp: TProgressBar
    Left = 0
    Top = 622
    Width = 643
    Height = 17
    Align = alBottom
    Step = 1
    TabOrder = 4
  end
  object pnlImpDocDaImportare: TPanel
    Left = 0
    Top = 496
    Width = 643
    Height = 89
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 322
      Top = 0
      Height = 89
      Align = alRight
      ExplicitLeft = 328
      ExplicitTop = 64
      ExplicitHeight = 100
    end
    object grpImpDocDaImportare: TGroupBox
      Left = 0
      Top = 0
      Width = 322
      Height = 89
      Align = alClient
      Caption = 'Documenti da importare'
      TabOrder = 0
      object lstImpDocDaImportare: TCheckListBox
        Left = 2
        Top = 15
        Width = 318
        Height = 72
        OnClickCheck = lstImpDocDaImportareClickCheck
        Align = alClient
        ItemHeight = 13
        PopupMenu = pmnImpDocDaImportare
        TabOrder = 0
      end
    end
    object grpImpDocIgnorati: TGroupBox
      Left = 325
      Top = 0
      Width = 318
      Height = 89
      Align = alRight
      Caption = 'File ignorati'
      TabOrder = 1
      object lstImpDocIgnorati: TListBox
        Left = 2
        Top = 15
        Width = 314
        Height = 72
        Align = alClient
        ItemHeight = 13
        PopupMenu = pmnImpFileIgnorati
        TabOrder = 0
      end
    end
  end
  object pmnImpDocDaImportare: TPopupMenu
    Left = 532
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
  end
  object pmnImpFileIgnorati: TPopupMenu
    Left = 576
    object Copianegliappunti1: TMenuItem
      Caption = 'Copia contenuto negli appunti'
      OnClick = Copianegliappunti1Click
    end
  end
end
