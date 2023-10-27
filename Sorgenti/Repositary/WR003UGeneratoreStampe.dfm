inherited WR003FGeneratoreStampe: TWR003FGeneratoreStampe
  Width = 713
  Height = 632
  ExplicitWidth = 713
  ExplicitHeight = 632
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  object grdComandi: TmeIWGrid [15]
    Left = 25
    Top = 387
    Width = 300
    Height = 23
    Css = 'medpToolBar medpNoMarginLeft  medpToolBarActNoBorder '
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'grdComandi'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdComandi'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblDal: TmeIWLabel [16]
    Left = 432
    Top = 320
    Width = 155
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblDal'
    Caption = 'Periodo da elaborare dal'
    Enabled = True
  end
  object lblAl: TmeIWLabel [17]
    Left = 560
    Top = 342
    Width = 12
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblAl'
    Caption = 'Al'
    Enabled = True
  end
  object edtDal: TmeIWEdit [18]
    Left = 593
    Top = 315
    Width = 88
    Height = 21
    Css = 'input_data_dmy'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtDal'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    Text = ' '
  end
  object edtAl: TmeIWEdit [19]
    Left = 593
    Top = 342
    Width = 88
    Height = 21
    Css = 'input_data_dmy'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtAl'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncDoubleClick = edtAlAsyncDoubleClick
    Text = ' '
  end
  object btnGeneraPDF: TmedpIWImageButton [20]
    Left = 501
    Top = 407
    Width = 166
    Height = 35
    Hint = 'Stampa in PDF'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = actStampaPDFExecute
    Cacheable = True
    FriendlyName = 'btnGeneraPDF'
    ImageFile.Filename = 'img\btnPdf.png'
    medpDownloadButton = False
    Caption = 'Stampa in PDF'
  end
  object btnGeneraXLS: TmedpIWImageButton [21]
    Left = 501
    Top = 448
    Width = 166
    Height = 35
    Hint = 'Stampa in Excel'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = actSalvaSuFileExecute
    Cacheable = True
    FriendlyName = 'btnGeneraXLS'
    ImageFile.Filename = 'img\btnGeneraXLS.png'
    medpDownloadButton = False
    Caption = 'Stampa in Excel'
  end
  object btnGeneraTabella: TmedpIWImageButton [22]
    Left = 501
    Top = 530
    Width = 166
    Height = 35
    Hint = 'Genera tabella'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = actTabellaExecute
    Cacheable = True
    FriendlyName = 'btnGeneraTabella'
    ImageFile.Filename = 'img\btnTabella.png'
    medpDownloadButton = False
    Caption = 'Genera tabella'
  end
  object btnGeneraTabellaOnly: TmedpIWImageButton [23]
    Left = 501
    Top = 571
    Width = 166
    Height = 35
    Hint = 'Genera tabella da ultima elab.'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = actTabellaOnlyExecute
    Cacheable = True
    FriendlyName = 'btnGeneraTabellaOnly'
    ImageFile.Filename = 'img\btnTabella.png'
    medpDownloadButton = False
    Caption = 'Genera tabella da ultima elab.'
  end
  object btnSalvaTabella: TmedpIWImageButton [24]
    Left = 501
    Top = 489
    Width = 166
    Height = 35
    Hint = 'Tabella in XLSX'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = actSalvaSuFileExecute
    Cacheable = True
    FriendlyName = 'btnSalvaTabella'
    ImageFile.Filename = 'img\btnSalvaTabella.png'
    medpDownloadButton = False
    Caption = 'Tabella in XLSX'
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 608
    Top = 160
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 608
    Top = 24
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 608
    Top = 88
  end
  inherited actlstNavigatorBar: TActionList
    Left = 344
    object actImportaStampa: TAction
      Caption = 'btnImport'
      Hint = 'Importa stampa'
      OnExecute = actImportaStampaExecute
    end
    object actEsportaStampa: TAction
      Caption = 'btnExport'
      Hint = 'Esporta stampa'
      OnExecute = actEsportaStampaExecute
    end
    object actInterrogazioniServizio: TAction
      Caption = 'btnInterrogazioniServizio'
      Hint = 'Interrogazioni di servizio'
      OnExecute = actInterrogazioniServizioExecute
    end
  end
  object actlstComandi: TActionList
    Left = 362
    Top = 349
    object actLblDal: TAction
      Category = 'AzioniDal'
      Caption = 'actLblDal'
    end
    object actEdtDal: TAction
      Category = 'AzioniDal'
      Caption = 'actEdtDal'
    end
    object actLblAl: TAction
      Category = 'AzioniAl'
      Caption = 'actLblAl'
    end
    object actEdtAl: TAction
      Category = 'AzioniAl'
      Caption = 'actEdtAl'
    end
    object actStampaPDF: TAction
      Category = 'Azioni'
      Caption = 'Stampa in PDF'
      Hint = 'Stampa in PDF'
      OnExecute = actStampaPDFExecute
    end
    object actStampaXLS: TAction
      Category = 'Azioni'
      Caption = 'Stampa in Excel'
      Hint = 'Stampa in Excel'
      OnExecute = actSalvaSuFileExecute
    end
    object actStampaXLSX: TAction
      Category = 'Azioni'
      Caption = 'Tabella in XLSX'
      Hint = 'Tabella in XLSX'
      OnExecute = actSalvaSuFileExecute
    end
    object actTabella: TAction
      Category = 'Azioni'
      Caption = 'btnTabella'
      Hint = 'Crea tabella'
      OnExecute = actTabellaExecute
    end
    object actTabellaOnly: TAction
      Category = 'Azioni'
      Caption = 'actTabellaOnly'
      OnExecute = actTabellaOnlyExecute
    end
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 368
    Top = 224
  end
end
