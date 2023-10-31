inherited A155FRicercaDocumentale: TA155FRicercaDocumentale
  Tag = 77
  HelpContext = 155000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A155> Ricerca documentale'
  ClientHeight = 570
  ClientWidth = 825
  ExplicitWidth = 841
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 552
    Width = 825
    ExplicitTop = 552
    ExplicitWidth = 825
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 825
    Height = 25
    ButtonHeight = 23
    ExplicitTop = 24
    ExplicitWidth = 825
    ExplicitHeight = 25
    inherited ToolButton3: TToolButton
      Visible = False
    end
    inherited TInser: TToolButton
      Visible = False
    end
    inherited TModif: TToolButton
      Visible = False
    end
    inherited TCanc: TToolButton
      Visible = False
    end
    inherited ToolButton10: TToolButton
      Visible = False
    end
    inherited TAnnulla: TToolButton
      Visible = False
    end
    inherited TRegis: TToolButton
      Visible = False
    end
    inherited ToolButton14: TToolButton
      Visible = False
    end
    inherited TGomma: TToolButton
      Visible = False
    end
    inherited ToolButton16: TToolButton
      Visible = False
    end
    inherited TStampa: TToolButton
      Visible = False
    end
    object btnPulisciFiltri: TBitBtn
      Left = 371
      Top = 0
      Width = 124
      Height = 23
      Caption = 'Pulisci criteri di ricerca'
      TabOrder = 0
      OnClick = btnPulisciFiltriClick
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 825
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 825
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 825
      Height = 24
      ExplicitWidth = 825
      ExplicitHeight = 24
    end
  end
  object dgrdDocumenti: TDBGrid [3]
    Left = 0
    Top = 343
    Width = 825
    Height = 209
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = pmnAzioniDocumento
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dgrdDocumentiDblClick
  end
  object pnlDettaglio: TPanel [4]
    Left = 0
    Top = 49
    Width = 825
    Height = 294
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblUtente: TLabel
      Left = 600
      Top = 177
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
    object lblTipologia: TLabel
      Left = 140
      Top = 177
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
      Left = 412
      Top = 177
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
    object lblNomeFile: TLabel
      Left = 15
      Top = 14
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
    object lblEstensioni: TLabel
      Left = 15
      Top = 177
      Width = 52
      Height = 13
      Caption = 'Estensione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDimensioneDa: TLabel
      Left = 15
      Top = 42
      Width = 70
      Height = 13
      Caption = 'Dimensione da'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDimensioneA: TLabel
      Left = 244
      Top = 42
      Width = 7
      Height = 13
      Caption = 'A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblKBDa: TLabel
      Left = 212
      Top = 42
      Width = 14
      Height = 13
      Caption = 'KB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblKBA: TLabel
      Left = 332
      Top = 42
      Width = 14
      Height = 13
      Caption = 'KB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNote: TLabel
      Left = 15
      Top = 152
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
    object lblFamiliare: TLabel
      Left = 15
      Top = 127
      Width = 116
      Height = 13
      Caption = 'CF familiare di riferimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sedtDimensioneDa: TSpinEdit
      Left = 140
      Top = 39
      Width = 68
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = sedtDimensioneDaChange
    end
    object sedtDimensioneA: TSpinEdit
      Left = 260
      Top = 39
      Width = 68
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = sedtDimensioneAChange
    end
    object edtNomeFile: TEdit
      Left = 140
      Top = 11
      Width = 267
      Height = 21
      Hint = 'Ricerca per testo contenuto nel nome file'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object lstEstensioni: TCheckListBox
      Left = 15
      Top = 195
      Width = 120
      Height = 92
      ItemHeight = 13
      PopupMenu = pmnSelezione
      TabOrder = 8
    end
    object lstUtenti: TCheckListBox
      Left = 600
      Top = 195
      Width = 210
      Height = 92
      ItemHeight = 13
      PopupMenu = pmnSelezione
      TabOrder = 11
    end
    object lstTipologie: TCheckListBox
      Left = 140
      Top = 195
      Width = 267
      Height = 92
      ItemHeight = 13
      PopupMenu = pmnSelezione
      TabOrder = 9
    end
    object lstUffici: TCheckListBox
      Left = 412
      Top = 195
      Width = 183
      Height = 92
      ItemHeight = 13
      PopupMenu = pmnSelezione
      TabOrder = 10
    end
    object edtNote: TEdit
      Left = 140
      Top = 149
      Width = 267
      Height = 21
      Hint = 'Ricerca per testo contenuto nelle note'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object rgDocAutocertificazione: TRadioGroup
      Left = 447
      Top = 11
      Width = 250
      Height = 62
      Caption = 'Doc.autocertificazione'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Tutti'
        'Doc.da richiedere'
        'Doc.richiesti'
        'Doc.ricevuti')
      ParentFont = False
      TabOrder = 7
    end
    object edtFamiliare: TEdit
      Left = 140
      Top = 124
      Width = 267
      Height = 21
      Hint = 'Ricerca per testo contenuto nelle note'
      MaxLength = 16
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    inline frmInputPeriodoCreaz: TfrmInputPeriodo
      Left = 0
      Top = 87
      Width = 417
      Height = 35
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 4
      ExplicitTop = 87
      ExplicitWidth = 417
      ExplicitHeight = 35
      inherited lblInizio: TLabel
        Left = 15
        Width = 89
        Caption = 'Data creazione dal'
        ExplicitLeft = 15
        ExplicitWidth = 89
      end
      inherited lblFine: TLabel
        Left = 244
        ExplicitLeft = 244
      end
      inherited edtInizio: TMaskEdit
        Left = 140
        ExplicitLeft = 140
      end
      inherited edtFine: TMaskEdit
        Left = 260
        ExplicitLeft = 260
      end
      inherited btnIndietro: TBitBtn
        Left = 362
        ExplicitLeft = 362
      end
      inherited btnAvanti: TBitBtn
        Left = 384
        ExplicitLeft = 384
      end
      inherited btnDataInizio: TBitBtn
        Left = 211
        ExplicitLeft = 211
      end
      inherited btnDataFine: TBitBtn
        Left = 330
        ExplicitLeft = 330
      end
    end
    inline frmInputPeriodoRif: TfrmInputPeriodo
      Left = 0
      Top = 58
      Width = 417
      Height = 35
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      ExplicitTop = 58
      ExplicitWidth = 417
      ExplicitHeight = 35
      inherited lblInizio: TLabel
        Left = 15
        Width = 115
        Caption = 'Periodo di riferimento dal'
        ExplicitLeft = 15
        ExplicitWidth = 115
      end
      inherited lblFine: TLabel
        Left = 244
        ExplicitLeft = 244
      end
      inherited edtInizio: TMaskEdit
        Left = 140
        ExplicitLeft = 140
      end
      inherited edtFine: TMaskEdit
        Left = 260
        ExplicitLeft = 260
      end
      inherited btnIndietro: TBitBtn
        Left = 362
        ExplicitLeft = 362
      end
      inherited btnAvanti: TBitBtn
        Left = 384
        ExplicitLeft = 384
      end
      inherited btnDataInizio: TBitBtn
        Left = 211
        ExplicitLeft = 211
      end
      inherited btnDataFine: TBitBtn
        Left = 330
        ExplicitLeft = 330
      end
    end
  end
  inherited MainMenu1: TMainMenu [5]
    Left = 488
    Top = 2
  end
  inherited DButton: TDataSource [6]
    AutoEdit = True
    Left = 516
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [7]
    Left = 544
    Top = 2
  end
  inherited ImageList1: TImageList [8]
    Left = 572
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 600
    Top = 2
  end
  object ActionList2: TActionList
    Left = 632
    object actFileDownload: TAction
      Caption = 'Salva...'
      OnExecute = actFileDownloadExecute
    end
    object actFileVisualizza: TAction
      Caption = 'Apri'
      OnExecute = actFileVisualizzaExecute
    end
    object actAccediDocumento: TAction
      Caption = 'Accedi...'
      Hint = 'Accedi...'
      OnExecute = actAccediDocumentoExecute
    end
  end
  object pmnSelezione: TPopupMenu
    Left = 654
    Top = 74
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Selezionatutto1Click
    end
  end
  object pmnAzioniDocumento: TPopupMenu
    OnPopup = pmnAzioniDocumentoPopup
    Left = 336
    Top = 376
    object Apri1: TMenuItem
      Action = actFileVisualizza
    end
    object Salva1: TMenuItem
      Action = actFileDownload
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Accedi1: TMenuItem
      Action = actAccediDocumento
      Caption = 'Accedi'
      Hint = 'Accedi'
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object mnuCopiaExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = mnuCopiaExcelClick
    end
  end
  object dlgFileSave: TSaveDialog
    Left = 456
  end
end
