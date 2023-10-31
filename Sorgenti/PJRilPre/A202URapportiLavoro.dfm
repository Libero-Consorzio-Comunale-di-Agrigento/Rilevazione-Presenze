inherited A202FRapportiLavoro: TA202FRapportiLavoro
  Tag = 161
  HelpContext = 202000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A202> Riepilogo rapporti di lavoro'
  ClientHeight = 566
  ClientWidth = 937
  ExplicitWidth = 953
  ExplicitHeight = 625
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 548
    Width = 937
    ExplicitTop = 548
    ExplicitWidth = 937
  end
  inherited Panel1: TToolBar
    Top = 23
    Width = 937
    ExplicitTop = 23
    ExplicitWidth = 937
    object edtDataIReport: TEdit
      Left = 371
      Top = 0
      Width = 75
      Height = 22
      TabOrder = 0
      Text = '01/01/1900'
      Visible = False
    end
    object edtDataFReport: TEdit
      Left = 446
      Top = 0
      Width = 75
      Height = 22
      TabOrder = 1
      Text = '31/12/3999'
      Visible = False
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 937
    Height = 23
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 937
    ExplicitHeight = 23
    inherited pnlSelAnagrafe: TPanel
      Width = 937
      Height = 553
      Align = alTop
      ExplicitWidth = 937
      ExplicitHeight = 553
      inherited btnSuccessivo: TSpeedButton
        OnClick = frmSelAnagrafebtnSuccessivoClick
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object pgValidazione: TPageControl [3]
    Left = 0
    Top = 47
    Width = 937
    Height = 501
    ActivePage = TabSheet0
    Align = alClient
    TabOrder = 3
    OnChange = pgValidazioneChange
    OnChanging = pgValidazioneChanging
    object TabSheet0: TTabSheet
      Caption = 'Rapporti di lavoro'
      ImageIndex = 2
      object Splitter1: TSplitter
        Left = 0
        Top = 112
        Width = 929
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = 3
        ExplicitTop = 116
      end
      object Splitter2: TSplitter
        Left = 0
        Top = 257
        Width = 929
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = -3
        ExplicitTop = 261
      end
      object grpAltriEnti: TGroupBox
        Left = 0
        Top = 0
        Width = 929
        Height = 112
        Align = alClient
        Caption = 'Rapporti di lavoro presso altri Enti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object dgrdRapportiLavoro: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 95
          Align = alClient
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = mnuCopia
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnEditButtonClick = dgrdRapportiLavoroEditButtonClick
        end
      end
      object grpEnteCorrente: TGroupBox
        Left = 0
        Top = 261
        Width = 929
        Height = 149
        Align = alBottom
        Caption = 'Rapporti di lavoro presso Ente corrente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dgrdRapportiEnte: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 132
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = mnuCopia
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
      object grpPAssenze: TGroupBox
        Left = 0
        Top = 116
        Width = 929
        Height = 141
        Align = alBottom
        Caption = 'Profili assenze assegnati (Ferie)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object grdPAssenze: TStringGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 124
          Align = alClient
          ColCount = 4
          DefaultColWidth = 110
          DefaultRowHeight = 16
          FixedCols = 0
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goThumbTracking]
          ParentFont = False
          TabOrder = 0
          OnDrawCell = grdPAssenzeDrawCell
        end
      end
      object pnlBottoni: TPanel
        Left = 0
        Top = 410
        Width = 929
        Height = 63
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 3
        object lblPAssenze: TLabel
          Left = 493
          Top = 5
          Width = 71
          Height = 13
          Caption = 'Profilo assenze'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblDescrizione: TLabel
          Left = 493
          Top = 45
          Width = 55
          Height = 13
          Caption = 'Descrizione'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object lblDecorrenza: TLabel
          Left = 233
          Top = 5
          Width = 120
          Height = 13
          Caption = 'Esegui storicizzazione dal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblFine: TLabel
          Left = 415
          Top = 5
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
        object lblScadenza: TLabel
          Left = 151
          Top = 5
          Width = 48
          Height = 13
          Caption = 'Scadenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblGG: TLabel
          Left = 5
          Top = 5
          Width = 140
          Height = 13
          Caption = 'Calcolo del triennio: gg (1095)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnApplica: TButton
          Left = 645
          Top = 17
          Width = 121
          Height = 25
          Caption = 'Applica Storicizzazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = btnApplicaClick
        end
        object cmbPAssenze: TDBLookupComboBox
          Left = 493
          Top = 21
          Width = 145
          Height = 21
          DropDownWidth = 300
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyField = 'Codice'
          ListField = 'Codice;Descrizione'
          ParentFont = False
          TabOrder = 4
          OnCloseUp = cmbPAssenzeCloseUp
          OnExit = cmbPAssenzeExit
        end
        object edtDecorrenza: TMaskEdit
          Left = 339
          Top = 21
          Width = 70
          Height = 21
          EditMask = '!00/00/0000;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
          Text = '  /  /    '
        end
        object edtFine: TMaskEdit
          Left = 415
          Top = 21
          Width = 71
          Height = 21
          EditMask = '!00/00/0000;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 3
          Text = '  /  /    '
        end
        object edtScadenza: TMaskEdit
          Left = 151
          Top = 21
          Width = 70
          Height = 21
          Color = clSilver
          EditMask = '!00/00/0000;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '  /  /    '
        end
        object edtGG: TEdit
          Left = 99
          Top = 21
          Width = 46
          Height = 21
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = 'edtGG'
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Periodi giuridici'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Splitter3: TSplitter
        Left = 0
        Top = 286
        Width = 929
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 314
      end
      object gbT425: TGroupBox
        Left = 0
        Top = 93
        Width = 929
        Height = 193
        Align = alClient
        Caption = 'Periodi giuridici autocertificati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object dgrdT425: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 176
          Align = alClient
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
      object gbT430: TGroupBox
        Left = 0
        Top = 290
        Width = 929
        Height = 183
        Align = alBottom
        Caption = 'Periodi giuridici presenti in anagrafico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dgrdT430: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 166
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 929
        Height = 93
        Align = alTop
        Caption = 'Riepilogo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object grdRiepilogo: TStringGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 76
          Align = alClient
          ColCount = 7
          DefaultColWidth = 100
          DefaultRowHeight = 17
          RowCount = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Periodi aspettativa'
      ImageIndex = 1
      object gbT055: TGroupBox
        Left = 0
        Top = 225
        Width = 929
        Height = 248
        Align = alClient
        Caption = 'Periodi di aspettativa presenti in archivio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object dgrdT040: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 231
          Align = alClient
          DataSource = A202FRapportiLavoroMW.dsrT040
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 929
        Height = 225
        Align = alTop
        Caption = 'Periodi di aspettativa autocertificati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dgrdT055: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 208
          Align = alClient
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Periodi da validare'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 929
        Height = 473
        Align = alClient
        Caption = 'Periodi giuridici e di aspettativa da validare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object dgrdT425_T050_NA: TDBGrid
          Left = 2
          Top = 15
          Width = 925
          Height = 456
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
  end
  inherited MainMenu1: TMainMenu [4]
    Left = 592
    Top = 2
  end
  inherited DButton: TDataSource [5]
    Left = 620
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
    Left = 648
    Top = 2
  end
  inherited ImageList1: TImageList [7]
    Left = 676
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 704
    Top = 2
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
  object mnuCopia: TPopupMenu
    Left = 536
    Top = 2
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
end
