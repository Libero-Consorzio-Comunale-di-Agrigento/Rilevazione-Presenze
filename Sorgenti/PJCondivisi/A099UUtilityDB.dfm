object A099FUtilityDB: TA099FUtilityDB
  Left = 203
  Top = 177
  HelpContext = 99000
  Caption = '<A099> Utility del Database'
  ClientHeight = 566
  ClientWidth = 660
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
  object Splitter1: TSplitter
    Left = 0
    Top = 427
    Width = 660
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 321
    ExplicitWidth = 652
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 660
    Height = 427
    ActivePage = tabQuerySupporto
    Align = alClient
    TabOrder = 0
    object tabTabelle: TTabSheet
      Caption = 'Tabelle/Indici'
      object Panel1: TPanel
        Left = 510
        Top = 0
        Width = 142
        Height = 399
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btnDeleteStatistics: TBitBtn
          Left = 4
          Top = 286
          Width = 137
          Height = 25
          Caption = 'Delete Statistics'
          TabOrder = 7
          OnClick = btnDeleteStatisticsClick
        end
        object btnAnalyzeTable: TBitBtn
          Left = 4
          Top = 312
          Width = 137
          Height = 25
          Caption = 'Analyze Table'
          TabOrder = 8
          OnClick = btnDeleteStatisticsClick
        end
        object btnAnalyzeColumns: TBitBtn
          Left = 4
          Top = 339
          Width = 137
          Height = 25
          Caption = 'Analyze Columns'
          TabOrder = 9
          OnClick = btnDeleteStatisticsClick
        end
        object btnAnalyzeIndexes: TBitBtn
          Left = 4
          Top = 366
          Width = 137
          Height = 25
          Caption = 'Analyze Indexes'
          TabOrder = 10
          OnClick = btnDeleteStatisticsClick
        end
        object btnRebuildIndexes: TBitBtn
          Left = 4
          Top = 218
          Width = 137
          Height = 25
          Caption = 'Rebuild Indexes'
          TabOrder = 6
          OnClick = btnDeleteStatisticsClick
        end
        object btnTableNoParallel: TBitBtn
          Left = 4
          Top = 34
          Width = 137
          Height = 25
          Caption = 'Alter Table NoParallel'
          TabOrder = 0
          OnClick = btnDeleteStatisticsClick
        end
        object btnIndexNoParallel: TBitBtn
          Left = 4
          Top = 61
          Width = 137
          Height = 25
          Caption = 'Alter Index NoParallel'
          TabOrder = 1
          OnClick = btnDeleteStatisticsClick
        end
        object btnDeleteSchemaStats: TBitBtn
          Left = 4
          Top = 98
          Width = 137
          Height = 25
          Caption = 'Cancella statistiche schema'
          TabOrder = 2
          OnClick = btnDeleteSchemaStatsClick
        end
        object btnGatherSchemaStats: TBitBtn
          Left = 4
          Top = 125
          Width = 137
          Height = 25
          Caption = 'Genera statistiche schema'
          TabOrder = 3
          OnClick = btnDeleteSchemaStatsClick
        end
        object btnGatherTableStats: TBitBtn
          Left = 4
          Top = 152
          Width = 137
          Height = 25
          Caption = 'Genera statistiche tabelle'
          TabOrder = 4
          OnClick = btnDeleteStatisticsClick
        end
        object btnMoveTablespace: TBitBtn
          Left = 4
          Top = 191
          Width = 137
          Height = 25
          Caption = 'Move Tablespace'
          TabOrder = 5
          OnClick = btnDeleteStatisticsClick
        end
        object btnShrink: TBitBtn
          Left = 4
          Top = 259
          Width = 137
          Height = 25
          Caption = 'Shrink Table'
          TabOrder = 11
          OnClick = btnDeleteStatisticsClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 510
        Height = 399
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object lstTabelle: TCheckListBox
          Left = 0
          Top = 65
          Width = 510
          Height = 334
          Align = alClient
          Columns = 2
          ItemHeight = 13
          PopupMenu = PopupMenu1
          TabOrder = 1
        end
        object rgpSelezioneTabelle: TRadioGroup
          Left = 0
          Top = 0
          Width = 510
          Height = 65
          Align = alTop
          Caption = 'Selezione tabelle'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Tabelle di'
            'Tabelle senza indici'
            'Tabelle senza chiave primaria'
            'Tabelle esterne al tablespace'
            'Tabelle con indici esterni al tablespace')
          ParentFont = False
          TabOrder = 0
          OnClick = rgpSelezioneTabelleClick
        end
      end
    end
    object tabOggetti: TTabSheet
      Caption = 'Oggetti del DB'
      ImageIndex = 1
      object treeOggettiDB: TTreeView
        Left = 0
        Top = 0
        Width = 493
        Height = 399
        Align = alClient
        Indent = 19
        PopupMenu = mnuCompilaOggetti
        ReadOnly = True
        TabOrder = 0
        OnAdvancedCustomDrawItem = treeOggettiDBAdvancedCustomDrawItem
        OnChange = treeOggettiDBChange
        OnMouseDown = treeOggettiDBMouseDown
      end
      object Panel6: TPanel
        Left = 493
        Top = 0
        Width = 159
        Height = 399
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object btnRicompilaTutto: TBitBtn
          Left = 12
          Top = 64
          Width = 139
          Height = 25
          Caption = 'Ricompila tutti gli oggetti'
          TabOrder = 0
          OnClick = btnRicompilaTuttoClick
        end
        object btnRicompilaInvalidi: TBitBtn
          Left = 12
          Top = 95
          Width = 139
          Height = 25
          Caption = 'Ricompila oggetti invalidi'
          TabOrder = 1
          OnClick = btnRicompilaTuttoClick
        end
        object GroupBox1: TGroupBox
          Left = 4
          Top = 126
          Width = 153
          Height = 105
          Caption = 'Parametri di compilazione'
          TabOrder = 2
          object chkCompileDebug: TCheckBox
            Left = 11
            Top = 17
            Width = 124
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Debug'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = chkCompileParametersClick
          end
          object chkCompileNative: TCheckBox
            Left = 11
            Top = 57
            Width = 124
            Height = 17
            HelpType = htKeyword
            Alignment = taLeftJustify
            Caption = 'Code type Native'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = chkCompileParametersClick
          end
          object chkCompileInterpreted: TCheckBox
            Left = 11
            Top = 40
            Width = 124
            Height = 17
            HelpType = htKeyword
            Alignment = taLeftJustify
            Caption = 'Code type Interpreted'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = chkCompileParametersClick
          end
          object chkCompileReuse: TCheckBox
            Left = 11
            Top = 80
            Width = 124
            Height = 17
            HelpType = htKeyword
            Alignment = taLeftJustify
            Caption = 'Reuse settings'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = chkCompileParametersClick
          end
        end
        object btnV430Storico: TBitBtn
          Left = 12
          Top = 16
          Width = 139
          Height = 25
          Caption = 'Creazione V430_STORICO'
          TabOrder = 3
          OnClick = btnV430StoricoClick
        end
      end
    end
    object tabQuerySupporto: TTabSheet
      Caption = 'Query di supporto'
      ImageIndex = 2
      object Panel7: TPanel
        Left = 510
        Top = 0
        Width = 142
        Height = 399
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btnEsegui: TBitBtn
          Left = 4
          Top = 64
          Width = 137
          Height = 25
          Caption = 'Esegui'
          TabOrder = 0
          OnClick = btnEseguiClick
        end
        object btnCopiaTestoQuery: TBitBtn
          Left = 4
          Top = 95
          Width = 137
          Height = 25
          Hint = 'Copia il testo della query selezionata negli appunti'
          Caption = 'Copia testo query'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnCopiaTestoQueryClick
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 510
        Height = 399
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object rgpQuerySupporto: TRadioGroup
          Left = 0
          Top = 0
          Width = 510
          Height = 65
          Align = alTop
          Caption = 'Query di supporto'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Situazione tablespace dati'
            'Situazione tablespace temporaneo'
            'Situazione data files'
            'Situazione tabelle di log')
          ParentFont = False
          TabOrder = 0
        end
        object dgrdQuerySupporto: TDBGrid
          Left = 0
          Top = 65
          Width = 510
          Height = 334
          Align = alClient
          DataSource = dsrQuerySupporto
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
    object TabExport: TTabSheet
      Caption = 'Export DB'
      ImageIndex = 3
      object pnlExport: TPanel
        Left = 0
        Top = 0
        Width = 652
        Height = 399
        Align = alClient
        TabOrder = 0
        object lblPath: TLabel
          Left = 313
          Top = -1
          Width = 42
          Height = 13
          Caption = 'Percorso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblFiltro: TLabel
          Left = 313
          Top = 161
          Width = 78
          Height = 13
          Caption = 'Filtro anagrafico:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 313
          Top = 311
          Width = 63
          Height = 13
          Caption = 'Filtro periodo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object edtPath: TEdit
          Left = 313
          Top = 12
          Width = 310
          Height = 21
          TabOrder = 0
          OnExit = edtPathExit
        end
        object btnPath: TButton
          Left = 628
          Top = 12
          Width = 15
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = btnPathClick
        end
        object edtFiltro: TEdit
          Left = 313
          Top = 180
          Width = 305
          Height = 21
          ReadOnly = True
          TabOrder = 2
        end
        object btnFiltro: TBitBtn
          Left = 621
          Top = 180
          Width = 22
          Height = 22
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000
            00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84828400000000000000
            0000848284FFFFFF00FFFF848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF00000084828484828484828484828484828400000000000000FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000848284FFFFFFC6C3C6FFFFFFC6
            C3C6FFFFFF848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848284
            848284FFFFFFC6C3C6FFFFFFFF0000FFFFFFC6C3C6FFFFFF848284848284FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF000000848284C6C3C6FFFFFFC6C3C6FF0000C6
            C3C6FFFFFFC6C3C6848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
            848284FFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFF848284000000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF000000848284C6C3C6FFFFFFC6C3C6FF0000C6
            C3C6FFFFFFC6C3C6848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848284
            848284FFFFFFC6C3C6FFFFFFFF0000FFFFFFC6C3C6FFFFFF848284848284FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000848284FFFFFFC6C3C6FFFFFFC6
            C3C6FFFFFF848284000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000848284848284848284848284848284000000FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF84828400000000000000
            0000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 3
          OnClick = btnFiltroClick
        end
        object btnEsporta: TBitBtn
          Left = 313
          Top = 360
          Width = 75
          Height = 25
          Caption = 'Esporta'
          TabOrder = 4
          OnClick = btnEsportaClick
        end
        object GRPOpzioniOggetti: TGroupBox
          Left = 313
          Top = 47
          Width = 330
          Height = 105
          TabOrder = 5
          object chkExpCreateTable: TCheckBox
            Left = 10
            Top = 13
            Width = 300
            Height = 17
            Caption = 'Create table'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
          end
          object chkExpDati: TCheckBox
            Left = 10
            Top = 36
            Width = 300
            Height = 17
            Caption = 'Dati'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 1
          end
          object chkExpConstraint: TCheckBox
            Left = 10
            Top = 59
            Width = 300
            Height = 17
            Caption = 'Constraint'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 2
          end
          object chkExpPLSQL: TCheckBox
            Left = 10
            Top = 82
            Width = 300
            Height = 17
            Caption = 'PL\SQL'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 3
          end
        end
        object btnCountRecords: TBitBtn
          Left = 490
          Top = 360
          Width = 128
          Height = 25
          Caption = 'Visualizza num.records'
          TabOrder = 6
          Visible = False
          OnClick = btnCountRecordsClick
        end
        object edtDal: TMaskEdit
          Left = 313
          Top = 330
          Width = 65
          Height = 21
          EditMask = '!00/00/0000;1;_'
          MaxLength = 10
          TabOrder = 7
          Text = '  /  /    '
          Visible = False
          OnExit = edtDalExit
        end
        object edtAl: TMaskEdit
          Left = 490
          Top = 330
          Width = 65
          Height = 21
          EditMask = '!00/00/0000;1;_'
          MaxLength = 10
          TabOrder = 8
          Text = '  /  /    '
          Visible = False
          OnExit = edtDalExit
        end
        object pnlLeftTabelle: TPanel
          Left = 1
          Top = 1
          Width = 306
          Height = 397
          Align = alLeft
          TabOrder = 9
          object lblListaTabelle: TLabel
            Left = 1
            Top = 5
            Width = 70
            Height = 13
            Caption = 'Tabelle del DB'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object chkLstBoxExpTabelle: TCheckListBox
            Left = 1
            Top = 24
            Width = 304
            Height = 372
            Align = alBottom
            ItemHeight = 13
            PopupMenu = ppMnu
            TabOrder = 0
          end
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 429
    Width = 660
    Height = 116
    Align = alBottom
    BevelOuter = bvNone
    BevelWidth = 2
    TabOrder = 1
    object memoResult: TMemo
      Left = 0
      Top = 0
      Width = 536
      Height = 116
      Align = alClient
      Color = clInactiveBorder
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 536
      Top = 0
      Width = 124
      Height = 116
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object BitBtn7: TBitBtn
        Left = 5
        Top = 88
        Width = 115
        Height = 25
        Caption = '&Chiudi'
        Kind = bkClose
        NumGlyphs = 2
        TabOrder = 0
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 545
    Width = 660
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 0
      Width = 381
      Height = 21
      Align = alLeft
      TabOrder = 0
    end
    object StatusBar: TStatusBar
      Left = 381
      Top = 0
      Width = 279
      Height = 21
      Align = alClient
      Panels = <>
      SimplePanel = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 444
    Top = 8
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
  object mnuCompilaOggetti: TPopupMenu
    Left = 480
    Top = 8
    object Ricompila1: TMenuItem
      Caption = 'Ricompila'
      OnClick = Ricompila1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
  end
  object dsrQuerySupporto: TDataSource
    DataSet = A099FUtilityDBMW.selTablespace
    Left = 560
    Top = 8
  end
  object ppMnu: TPopupMenu
    Left = 208
    Top = 40
    object Selezionatutto2: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto2Click
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
end
