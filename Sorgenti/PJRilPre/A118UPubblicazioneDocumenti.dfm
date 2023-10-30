inherited A118FPubblicazioneDocumenti: TA118FPubblicazioneDocumenti
  Tag = 210
  Left = 350
  Top = 173
  HelpContext = 118000
  Caption = '<A118> Pubblicazione documenti'
  ClientHeight = 520
  ClientWidth = 684
  ExplicitWidth = 700
  ExplicitHeight = 579
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 502
    Width = 684
    ExplicitTop = 502
    ExplicitWidth = 684
  end
  inherited Panel1: TToolBar
    Width = 684
    TabOrder = 0
    ExplicitWidth = 684
  end
  object pnlI200: TPanel [2]
    Left = 0
    Top = 29
    Width = 684
    Height = 78
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pnlInfoComuni: TPanel
      Left = 0
      Top = 0
      Width = 684
      Height = 98
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        684
        98)
      object lblCodice: TLabel
        Left = 5
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
        Left = 209
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
      object lblFiltro: TLabel
        Left = 5
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
      object btnCheckFiltro: TSpeedButton
        Left = 653
        Top = 28
        Width = 23
        Height = 23
        Hint = 'Verifica espressione filtro'
        Anchors = [akTop, akRight]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF90FFFFFFFFFFFFF9990FFFFFFFFFFFF9990FFFF
          FFFFFFF999990FFFFFFFFF9999990FFFFFFFF7990F9990FFFFFF790FFFF990FF
          FFFFFFFFFFF9990FFFFFFFFFFFFF990FFFFFFFFFFFFFF990FFFFFFFFFFFFFF79
          0FFFFFFFFFFFFFF790FFFFFFFFFFFFFFF990FFFFFFFFFFFFFFFF}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnCheckFiltroClick
      end
      object lblSorgenteDocumenti: TLabel
        Left = 5
        Top = 58
        Width = 95
        Height = 13
        Caption = 'Sorgente documenti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtCodice: TDBEdit
        Left = 106
        Top = 3
        Width = 96
        Height = 21
        DataField = 'CODICE'
        DataSource = DButton
        MaxLength = 10
        TabOrder = 0
      end
      object dedtDescrizione: TDBEdit
        Left = 270
        Top = 3
        Width = 406
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'DESCRIZIONE'
        DataSource = DButton
        MaxLength = 100
        TabOrder = 1
      end
      object dedtFiltro: TDBEdit
        Left = 106
        Top = 29
        Width = 546
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'FILTRO'
        DataSource = DButton
        MaxLength = 2000
        TabOrder = 2
        OnChange = dedtFiltroChange
      end
    end
  end
  object pnlInfoSorgente: TPanel [3]
    Left = 0
    Top = 107
    Width = 684
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 0
      Top = 238
      Width = 684
      Height = 6
      Cursor = crVSplit
      Align = alTop
      ExplicitLeft = 1
      ExplicitTop = 211
      ExplicitWidth = 966
    end
    object pnlDocumentale: TPanel
      Left = 0
      Top = 28
      Width = 684
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        684
        28)
      object lblTipologiaDocumenti: TLabel
        Left = 5
        Top = 7
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
      object dcmbTipologiaDocumenti: TDBLookupComboBox
        Left = 106
        Top = 4
        Width = 570
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'TIPOLOGIA_DOCUMENTI'
        DataSource = DButton
        KeyField = 'CODICE'
        ListField = 'DESCRIZIONE'
        ListSource = A118FPubblicazioneDocumentiDtM.dsrT962Lookup
        TabOrder = 0
      end
    end
    object pnlCartella: TPanel
      Left = 0
      Top = 56
      Width = 684
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        684
        28)
      object lblRoot: TLabel
        Left = 5
        Top = 7
        Width = 68
        Height = 13
        Caption = 'Directory base'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtRoot: TDBEdit
        Left = 106
        Top = 4
        Width = 547
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'ROOT'
        DataSource = DButton
        MaxLength = 2000
        TabOrder = 0
        OnChange = dedtFiltroChange
      end
      object btnScegliRoot: TBitBtn
        Left = 655
        Top = 3
        Width = 23
        Height = 23
        Anchors = [akTop, akRight]
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnScegliRootClick
      end
    end
    object grpLivelli: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 87
      Width = 678
      Height = 148
      Align = alTop
      Caption = 'Livelli'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object dgrdLivelli: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 668
        Height = 125
        Align = alClient
        DataSource = A118FPubblicazioneDocumentiDtM.dsrI201
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnExit = dgrdLivelliExit
        Columns = <
          item
            Expanded = False
            FieldName = 'LIVELLO'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Livello'
            Width = 39
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Alignment = taCenter
            Title.Caption = 'Nome'
            Width = 176
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EXT'
            Title.Alignment = taCenter
            Title.Caption = 'Estensione'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SEPARATORE'
            Title.Alignment = taCenter
            Title.Caption = 'Separatore'
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FILTRO'
            Title.Alignment = taCenter
            Title.Caption = 'Filtro'
            Width = 186
            Visible = True
          end>
      end
    end
    object grpCampi: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 247
      Width = 678
      Height = 145
      Align = alClient
      Caption = 'Dettaglio campi - livello 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object dgrdCampi: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 668
        Height = 97
        Align = alClient
        DataSource = A118FPubblicazioneDocumentiDtM.dsrI202
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
        OnExit = dgrdCampiExit
        Columns = <
          item
            Expanded = False
            FieldName = 'CAMPO'
            Title.Caption = 'Campo'
            Width = 230
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DAL'
            Title.Alignment = taCenter
            Title.Caption = 'Posizione'
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LUNG'
            Title.Alignment = taCenter
            Title.Caption = 'Lunghezza'
            Width = 65
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'VISIBILE'
            PickList.Strings = (
              'S'
              'N')
            Title.Alignment = taCenter
            Title.Caption = 'Visibile'
            Width = 49
            Visible = True
          end>
      end
      object pnlTest: TPanel
        Left = 2
        Top = 118
        Width = 674
        Height = 25
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          674
          25)
        object btnTest: TSpeedButton
          Left = 649
          Top = 2
          Width = 23
          Height = 22
          Hint = 'Verifica impostazioni'
          Anchors = [akTop, akRight]
          Enabled = False
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFF90FFFFFFFFFFFFF9990FFFFFFFFFFFF9990FFFF
            FFFFFFF999990FFFFFFFFF9999990FFFFFFFF7990F9990FFFFFF790FFFF990FF
            FFFFFFFFFFF9990FFFFFFFFFFFFF990FFFFFFFFFFFFFF990FFFFFFFFFFFFFF79
            0FFFFFFFFFFFFFF790FFFFFFFFFFFFFFF990FFFFFFFFFFFFFFFF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnTestClick
          ExplicitLeft = 647
        end
        object lblTest: TLabel
          Left = 3
          Top = 6
          Width = 119
          Height = 13
          Caption = 'Test impostazioni livello 0'
        end
        object edtTest: TEdit
          Left = 132
          Top = 3
          Width = 516
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtTestChange
        end
      end
    end
    object pnlUrlWS: TPanel
      Left = 0
      Top = 0
      Width = 684
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      DesignSize = (
        684
        28)
      object lblUrlWS: TLabel
        Left = 5
        Top = 7
        Width = 82
        Height = 13
        Caption = 'URL web service'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dedtUrlWS: TDBEdit
        Left = 106
        Top = 4
        Width = 570
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'URL_WS'
        DataSource = DButton
        MaxLength = 2000
        TabOrder = 0
        OnChange = dedtFiltroChange
      end
    end
  end
  object dcmbSorgenteDocumenti: TDBLookupComboBox [4]
    Left = 106
    Top = 84
    Width = 570
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'SORGENTE_DOCUMENTI'
    DataSource = DButton
    KeyField = 'CODICE'
    ListField = 'DESCRIZIONE'
    TabOrder = 4
  end
  inherited MainMenu1: TMainMenu
    Left = 408
    Top = 18
  end
  inherited DButton: TDataSource
    OnDataChange = DButtonDataChange
    Left = 436
    Top = 18
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 464
    Top = 18
  end
  inherited ImageList1: TImageList
    Left = 492
    Top = 18
  end
  inherited ActionList1: TActionList
    Left = 520
    Top = 18
  end
end
