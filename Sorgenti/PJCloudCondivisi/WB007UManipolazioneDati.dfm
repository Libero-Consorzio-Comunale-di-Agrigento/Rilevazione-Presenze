inherited WB007FManipolazioneDati: TWB007FManipolazioneDati
  Tag = 202
  Width = 740
  Height = 1535
  ExplicitWidth = 740
  ExplicitHeight = 1535
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 27
    Top = 163
    ExplicitLeft = 27
    ExplicitTop = 163
  end
  inherited btnShowElabError: TmeIWButton
    Left = 27
    Top = 117
    ExplicitLeft = 27
    ExplicitTop = 117
  end
  object edtDallaData: TmeIWEdit [9]
    Left = 88
    Top = 224
    Width = 121
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
    FriendlyName = 'edtDallaData'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnAsyncChange = edtDallaDataAsyncChange
    Text = 'edtDallaData'
  end
  object edtAllaData: TmeIWEdit [10]
    Left = 302
    Top = 224
    Width = 121
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
    FriendlyName = 'edtAllaData'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    Text = 'edtAllaData'
  end
  object lblDallaData: TmeIWLabel [11]
    Left = 20
    Top = 224
    Width = 62
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
    FriendlyName = 'lblDallaData'
    Caption = 'Dalla data'
    Enabled = True
  end
  object lblAllaData: TmeIWLabel [12]
    Left = 238
    Top = 229
    Width = 55
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
    FriendlyName = 'lblAllaData'
    Caption = 'Alla data'
    Enabled = True
  end
  object grdTabDetailold: TmedpIWTabControl [13]
    Left = 27
    Top = 272
    Width = 300
    Height = 25
    Css = 'gridTabControl'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'grdTabDetailold'
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
    CellRenderOptions = []
    FriendlyName = 'grdTabDetailold'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
  end
  object btnEsegui: TmedpIWImageButton [14]
    Left = 3
    Top = 1492
    Width = 154
    Height = 31
    Css = 'width15chr'
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnAnomalie: TmedpIWImageButton [15]
    Left = 343
    Top = 1492
    Width = 154
    Height = 31
    Css = 'width15chr'
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
    OnClick = btnAnomalieClick
    Cacheable = True
    FriendlyName = 'btnAnomalie'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object btnLog: TmedpIWImageButton [16]
    Left = 173
    Top = 1492
    Width = 154
    Height = 31
    Css = 'width15chr'
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
    OnClick = btnLogClick
    Cacheable = True
    FriendlyName = 'btnLog'
    ImageFile.Filename = 'img\btnVisualizzaFile.png'
    medpDownloadButton = False
    Caption = 'Log'
  end
  object lblAzione: TmeIWLabel [17]
    Left = 348
    Top = 280
    Width = 47
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
    FriendlyName = 'Azione:'
    Caption = 'Azione:'
    Enabled = True
  end
  object cmbAzione: TmeIWComboBox [18]
    Left = 401
    Top = 280
    Width = 121
    Height = 21
    Css = 'width30chr'
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
    OnChange = cmbAzioneChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 29
    ItemIndex = -1
    FriendlyName = 'cmbAzione'
    NoSelectionText = ' '
  end
  object WB007CancellazioneGiustRG: TmeIWRegion [19]
    Left = 3
    Top = 639
    Width = 718
    Height = 106
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateCancellazioneGiust
    object rgpCancGiust: TmeTIWAdvRadioGroup
      Left = 32
      Top = 3
      Width = 561
      Height = 38
      Css = 'tmsradiogroup'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpPeriodi'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Cancellazione periodica totale'
        'Cancellazione periodica per dipendente')
      ItemIndex = 0
      SubmitOnAsyncEvent = True
      TabOrder = 15
      OnClick = rgpCancGiustClick
    end
    object cgpCausGiust: TmeTIWAdvCheckGroup
      Left = 32
      Top = 64
      Width = 505
      Height = 33
      Css = 'intestazione prewrapcheckgroup fontcourier'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clNone
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'cgpCausGiust'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      TabOrder = 16
    end
    object lblElencoCausali: TmeIWLabel
      Left = 29
      Top = 42
      Width = 88
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
      FriendlyName = 'lblCaptionElencoMatricole'
      Caption = 'Elenco causali'
      Enabled = True
    end
  end
  object WB007RicodificaGiustRG: TmeIWRegion [20]
    Left = 3
    Top = 751
    Width = 718
    Height = 138
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateRicodificaGiustRG
    object rgpRicodificaGiust: TmeTIWAdvRadioGroup
      Left = 29
      Top = 3
      Width = 561
      Height = 38
      Css = 'tmsradiogroup'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpRicodificaGiust'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Ricodifica periodica totale'
        'Ricodifica periodica per dipendente')
      ItemIndex = 0
      SubmitOnAsyncEvent = True
      TabOrder = 18
      OnClick = rgpRicodificaGiustClick
    end
    object edtOldCausale: TmeIWEdit
      Left = 168
      Top = 84
      Width = 117
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'edtOldCausale'
      MaxLength = 5
      SubmitOnAsyncEvent = True
      TabOrder = 19
      Text = 'edtOldCausale'
    end
    object lblOldCausale: TmeIWLabel
      Left = 13
      Top = 79
      Width = 149
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
      FriendlyName = 'lblOldCausale'
      Caption = 'Vecchio codice causale:'
      Enabled = True
    end
    object cmbCausali: TMedpIWMultiColumnComboBox
      Left = 164
      Top = 111
      Width = 121
      Height = 21
      Css = 'medpMultiColumnCombo'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'cmbCausali'
      SubmitOnAsyncEvent = True
      TabOrder = 20
      OnAsyncChange = cmbCausaliAsyncChange
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblCausali: TmeIWLabel
      Left = 19
      Top = 112
      Width = 139
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
      FriendlyName = 'lblCausali'
      Caption = 'Nuovo codice causale:'
      Enabled = True
    end
    object lblDescCausale: TmeIWLabel
      Left = 299
      Top = 113
      Width = 93
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
      FriendlyName = 'lblDescCausale'
      Caption = 'lblDescCausale'
      Enabled = True
    end
    object rgpTipoCaus: TmeIWRadioGroup
      Left = 168
      Top = 52
      Width = 141
      Height = 26
      Cursor = crDefault
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoCaus'
      ItemIndex = 0
      Items.Strings = (
        'Assenza'
        'Presenza')
      Layout = glHorizontal
      TabOrder = -1
      OnAsyncClick = rgpTipoCausAsyncClick
    end
    object lblTipoCaus: TmeIWLabel
      Left = 29
      Top = 47
      Width = 110
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
      FriendlyName = 'lblTipoCaus'
      Caption = 'Tipologia causali:'
      Enabled = True
    end
  end
  object WB007RiallineamentoGiustRG: TmeIWRegion [21]
    Left = 3
    Top = 895
    Width = 718
    Height = 58
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateRiallineamentoGiustRG
    object lblCausaliAss: TmeIWLabel
      Left = 18
      Top = 16
      Width = 121
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
      FriendlyName = 'lblCausaliAss'
      Caption = 'Causali di assenza:'
      Enabled = True
    end
    object edtCausali: TmeIWEdit
      Left = 145
      Top = 16
      Width = 121
      Height = 21
      Css = 'width50chr'
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
      FriendlyName = 'edtCausali'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 21
      Text = 'edtCausali'
    end
    object btnElencoCausali: TmeIWButton
      Left = 272
      Top = 16
      Width = 37
      Height = 25
      Css = 'pulsante puntini'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = '...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnElencoCausali'
      TabOrder = 22
      OnClick = btnElencoCausaliClick
      medpDownloadButton = False
    end
  end
  object WB007UnificazioneMatrRG: TmeIWRegion [22]
    Left = 3
    Top = 959
    Width = 718
    Height = 135
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateUnificazioneMatrRG
    object lblDatiAnag: TmeIWLabel
      Left = 17
      Top = 11
      Width = 135
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
      FriendlyName = 'lblDatiAnag'
      Caption = 'Dati per cui unificare:'
      Enabled = True
    end
    object edtDatiAnag: TmeIWEdit
      Left = 158
      Top = 11
      Width = 121
      Height = 21
      Css = 'width50chr'
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
      FriendlyName = 'edtDatiAnag'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 23
      Text = 'edtDatiAnag'
    end
    object btnDatiAnag: TmeIWButton
      Left = 285
      Top = 16
      Width = 37
      Height = 25
      Css = 'pulsante puntini'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = '...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnElencoCausali'
      TabOrder = 24
      OnClick = btnDatiAnagClick
      medpDownloadButton = False
    end
    object btnAggiornaMatr: TmedpIWImageButton
      Left = 32
      Top = 49
      Width = 124
      Height = 25
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
      OnClick = btnAggiornaMatrClick
      Cacheable = True
      FriendlyName = 'btnAggiornaSchedeAnag'
      ImageFile.Filename = 'img\btnAggiorna.png'
      medpDownloadButton = False
      Caption = 'Aggiorna elenco matricole'
    end
    object grdMatricole: TmeIWGrid
      Left = 64
      Top = 80
      Width = 300
      Height = 47
      Css = 'grid'
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
      Caption = 'grdSchedeAnag'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlNone
      OnRenderCell = grdRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      FriendlyName = 'grdSchedeAnag'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
  end
  object WB007EsecuzioneScriptRG: TmeIWRegion [23]
    Left = 3
    Top = 1100
    Width = 718
    Height = 125
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateEsecuzioneScriptRG
    object btnVisualizzaFile: TmedpIWImageButton
      Left = 394
      Top = 35
      Width = 41
      Height = 26
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderOptions.Width = 0
      Enabled = False
      TabOrder = -1
      UseSize = False
      OnClick = btnVisualizzaFileClick
      Cacheable = True
      FriendlyName = 'btnVisualizzaFile'
      ImageFile.Filename = 'img\btnVisualizzaFile.png'
      medpDownloadButton = True
      Caption = 'Visualizza file'
    end
    object lbFileScelto: TmeIWLabel
      Left = 52
      Top = 93
      Width = 105
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
      FriendlyName = 'lbFileScelto'
      Caption = 'Nome file scelto:'
      Enabled = True
    end
    object lblFileSceltoDescr: TmeIWLabel
      Left = 163
      Top = 93
      Width = 110
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
      FriendlyName = 'lblFileSceltoDescr'
      Caption = 'lblFileSceltoDescr'
      Enabled = True
    end
    object memLog: TmeIWMemo
      Left = 106
      Top = 3
      Width = 121
      Height = 39
      Css = 'textarea width98pc height20'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clNone
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 25
      SubmitOnAsyncEvent = True
      FriendlyName = 'memLog'
    end
    object fileUpload: TmeIWFileUploader
      Left = 19
      Top = 48
      Width = 284
      Height = 31
      TabOrder = 26
      TextStrings.DragText = 'Trascinare qui i file da caricare'
      TextStrings.UploadButtonText = 'Sfoglia...'
      TextStrings.CancelButtonText = 'Annulla'
      TextStrings.UploadErrorText = 'Upload fallito'
      TextStrings.MultipleFileDropNotAllowedText = #200' possibile trascinare un file solo'
      TextStrings.OfTotalText = 'di'
      TextStrings.RemoveButtonText = 'Rimuovi'
      TextStrings.TypeErrorText = 
        '{file} ha estensione non valida. Sono consentiti solo i file {ex' +
        'tensions}.'
      TextStrings.SizeErrorText = 
        '{file} '#232' troppo grande, la dimensione massima consentita '#232' {size' +
        'Limit}.'
      TextStrings.MinSizeErrorText = 
        '{file} '#232' troppo piccolo, la dimensione minima consentita '#232' {minS' +
        'izeLimit}.'
      TextStrings.EmptyErrorText = '{file} '#232' vuoto, ripetere la selezione escludendo questo file.'
      TextStrings.NoFilesErrorText = 'Nessun file da caricare.'
      TextStrings.OnLeaveWarningText = 
        #200' in corso il caricamento dei file, se si abbandona ora la proce' +
        'dura di upload sar'#224' annullata.'
      Style.ButtonOptions.Alignment = taCenter
      Style.ButtonOptions.Font.Color = clWebWHITE
      Style.ButtonOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ButtonOptions.Font.Size = 10
      Style.ButtonOptions.Font.Style = []
      Style.ButtonOptions.FromColor = clWebMAROON
      Style.ButtonOptions.ToColor = clWebMAROON
      Style.ButtonOptions.Height = 30
      Style.ButtonOptions.Width = 200
      Style.ButtonHoverOptions.Alignment = taCenter
      Style.ButtonHoverOptions.Font.Color = clWebWHITE
      Style.ButtonHoverOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ButtonHoverOptions.Font.Size = 10
      Style.ButtonHoverOptions.Font.Style = []
      Style.ButtonHoverOptions.FromColor = 214
      Style.ButtonHoverOptions.ToColor = 214
      Style.ListOptions.Alignment = taLeftJustify
      Style.ListOptions.Font.Color = clWebBLACK
      Style.ListOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ListOptions.Font.Size = 10
      Style.ListOptions.Font.Style = []
      Style.ListOptions.FromColor = clWebGOLD
      Style.ListOptions.ToColor = clWebGOLD
      Style.ListOptions.Height = 30
      Style.ListOptions.Width = 0
      Style.ListSuccessOptions.Alignment = taLeftJustify
      Style.ListSuccessOptions.Font.Color = clWebWHITE
      Style.ListSuccessOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ListSuccessOptions.Font.Size = 10
      Style.ListSuccessOptions.Font.Style = []
      Style.ListSuccessOptions.FromColor = clWebFORESTGREEN
      Style.ListSuccessOptions.ToColor = clWebFORESTGREEN
      Style.ListErrorOptions.Alignment = taLeftJustify
      Style.ListErrorOptions.Font.Color = clWebWHITE
      Style.ListErrorOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ListErrorOptions.Font.Size = 10
      Style.ListErrorOptions.Font.Style = []
      Style.ListErrorOptions.FromColor = clWebRED
      Style.ListErrorOptions.ToColor = clWebRED
      Style.DropAreaOptions.Alignment = taCenter
      Style.DropAreaOptions.Font.Color = clWebWHITE
      Style.DropAreaOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.DropAreaOptions.Font.Size = 10
      Style.DropAreaOptions.Font.Style = []
      Style.DropAreaOptions.FromColor = clWebDARKORANGE
      Style.DropAreaOptions.ToColor = clWebDARKORANGE
      Style.DropAreaOptions.Height = 60
      Style.DropAreaOptions.Width = 0
      Style.DropAreaActiveOptions.Alignment = taCenter
      Style.DropAreaActiveOptions.Font.Color = clWebWHITE
      Style.DropAreaActiveOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.DropAreaActiveOptions.Font.Size = 10
      Style.DropAreaActiveOptions.Font.Style = []
      Style.DropAreaActiveOptions.FromColor = clWebLIMEGREEN
      Style.DropAreaActiveOptions.ToColor = clWebLIMEGREEN
      Style.DropAreaActiveOptions.Height = 60
      Style.DropAreaActiveOptions.Width = 0
      CssClasses.Strings = (
        'button=medpfileuploader-button'
        'button-hover=medpfileuploader-button-hover'
        'drop-area=medpfileuploader-drop-area'
        'drop-area-active=medpfileuploader-drop-area-active'
        'drop-area-disabled='
        'list=medpfileuploader-list'
        'upload-spinner=medpfileuploader-upload-spinner'
        'progress-bar='
        'upload-file=medpfileuploader-upload-file'
        'upload-size=medpfileuploader-upload-size'
        'upload-listItem=medpfileuploader-upload-listItem'
        'upload-cancel=medpfileuploader-upload-cancel'
        'upload-success=medpfileuploader-upload-success'
        'upload-fail=medpfileuploader-upload-fail'
        'success-icon=medpfileuploader-success-icon'
        'fail-icon=medpfileuploader-fail-icon')
      FriendlyName = 'fileUpload'
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      MEdpCaptionPulsanteUpload = 'Upload'
      MEdpCssPulsanteUpload = 'pulsante'
      MEdpIncludiPulsanteUpload = True
      MEdpPulsanteAzioneDopoUpload = btnAfterUpload
      MEdpPulsanteEnabled = True
      MEdpPulsanteVisible = True
      MEdpMaxFileSize = -1
    end
    object btnAfterUpload: TmeIWButton
      Left = 392
      Top = 80
      Width = 177
      Height = 25
      Css = 'pulsante invisibile'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Nascosto - Dopo upload'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAfterUpload'
      TabOrder = 27
      OnClick = btnAfterUploadClick
      medpDownloadButton = False
    end
  end
  object WB007CestinoRG: TmeIWRegion [24]
    Left = 3
    Top = 1231
    Width = 718
    Height = 63
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateCestinoRG
    object cmbFiltroTabelle: TMedpIWMultiColumnComboBox
      Left = 80
      Top = 3
      Width = 121
      Height = 21
      Css = 'medpMultiColumnCombo'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'cmbFiltroTabelle'
      SubmitOnAsyncEvent = True
      TabOrder = 28
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 1
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbFiltroTabelleChange
      medpAutoResetItems = True
      CssInputText = 'width20chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblFunzione: TmeIWLabel
      Left = 18
      Top = 3
      Width = 56
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
      FriendlyName = 'lblFunzione'
      Caption = 'Funzione'
      Enabled = True
    end
    object grdCestino: TmedpIWDBGrid
      Left = 207
      Top = 16
      Width = 300
      Height = 31
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'grdCestino'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      Summary = 'Elenco elementi presenti nel cestino'
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdCestino'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnAfterCaricaCDS = grdCestinoAfterCaricaCDS
    end
  end
  object WB007AllineaTimbRG: TmeIWRegion [25]
    Left = 3
    Top = 1300
    Width = 718
    Height = 149
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateAllineaTimb
    object btnRefreshAllTimb: TmedpIWImageButton
      Left = 16
      Top = 14
      Width = 154
      Height = 31
      Css = 'width15chr'
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
      OnClick = btnRefreshAllTimbClick
      Cacheable = True
      FriendlyName = 'btnEsegui'
      ImageFile.Filename = 'img\btnAggiorna.png'
      medpDownloadButton = False
      Caption = 'Aggiorna'
    end
    object grdTimbUguali: TmedpIWDBGrid
      Left = 17
      Top = 67
      Width = 490
      Height = 62
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'Timbrature da allineare'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      Summary = 'Elenco delle timbrature da allineare'
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdValori'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnDataSet2Componenti = grdValoriDataSet2Componenti
      OnmedpStatoChange = grdValorimedpStatoChange
    end
  end
  object WB007CancellazioneRG: TmeIWRegion [26]
    Left = 3
    Top = 455
    Width = 718
    Height = 178
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateCancellazioneRG
    object rgpCancDati: TmeTIWAdvRadioGroup
      Left = 32
      Top = 11
      Width = 561
      Height = 38
      Css = 'tmsradiogroup'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpCancDati'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Cancellazione dati del dipendente'
        'Cancellazione schede anagrafiche'
        'Cancellazione periodica totale'
        'Cancellazione periodica per dipendente')
      ItemIndex = 0
      SubmitOnAsyncEvent = True
      TabOrder = 12
      OnClick = rgpCancDatiClick
    end
    object btnAggiornaSchedeAnag: TmedpIWImageButton
      Left = 32
      Top = 89
      Width = 124
      Height = 25
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
      OnClick = btnAggiornaSchedeAnagClick
      Cacheable = True
      FriendlyName = 'btnAggiornaSchedeAnag'
      ImageFile.Filename = 'img\btnAggiorna.png'
      medpDownloadButton = False
      Caption = 'Aggiorna elenco matricole'
    end
    object chkLogSchedeAnag: TmeIWCheckBox
      Left = 235
      Top = 80
      Width = 278
      Height = 21
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Registra log di elenco tabelle con dati'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 13
      Checked = False
      FriendlyName = 'chkLogSchedeAnag'
    end
    object lblCaptionElencoMatricole: TmeIWLabel
      Left = 29
      Top = 59
      Width = 103
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
      FriendlyName = 'lblCaptionElencoMatricole'
      Caption = 'Elenco matricole'
      Enabled = True
    end
    object grdSchedeAnag: TmeIWGrid
      Left = 64
      Top = 120
      Width = 300
      Height = 49
      Css = 'grid'
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
      Caption = 'grdSchedeAnag'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlNone
      OnRenderCell = grdRenderCell
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      FriendlyName = 'grdSchedeAnag'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object lblCaptionElencoTabelle: TmeIWLabel
      Left = 138
      Top = 58
      Width = 86
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
      FriendlyName = 'lblCaptionElencoTabelle'
      Caption = 'Elenco tabelle'
      Enabled = True
    end
    object cgpTabelle: TmeTIWAdvCheckGroup
      Left = 507
      Top = 123
      Width = 142
      Height = 66
      Css = 'intestazione prewrapcheckgroup fontcourier'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clNone
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'cgpTabelle'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      TabOrder = 14
    end
  end
  object WB007StoricizzazioneRG: TmeIWRegion [27]
    Left = 3
    Top = 320
    Width = 718
    Height = 129
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateStoricizazioneRG
    object cmbDatoAgg: TmeIWComboBox
      Left = 29
      Top = 64
      Width = 121
      Height = 21
      Css = 'width20chr'
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
      ItemsHaveValues = True
      OnChange = cmbDatoAggChange
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 9
      ItemIndex = -1
      FriendlyName = 'cmbDatoAgg'
      NoSelectionText = ' '
    end
    object lblDatoAgg: TmeIWLabel
      Left = 29
      Top = 42
      Width = 121
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
      FriendlyName = 'lblDatoAgg'
      Caption = 'Dato da aggiornare'
      Enabled = True
    end
    object chkStorico: TmeIWCheckBox
      Left = 320
      Top = 40
      Width = 121
      Height = 21
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Storicizzazione'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 10
      Checked = False
      FriendlyName = 'chkStorico'
    end
    object chkStoriciSuccessivi: TmeIWCheckBox
      Left = 320
      Top = 56
      Width = 281
      Height = 21
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Non aggiornare storici successivi se diversi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 11
      Checked = False
      FriendlyName = 'chkStoriciSuccessivi'
    end
    object grdValori: TmedpIWDBGrid
      Left = 24
      Top = 91
      Width = 300
      Height = 34
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'grdValori'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      Summary = 'valori storicizzazione'
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdValori'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnDataSet2Componenti = grdValoriDataSet2Componenti
      OnmedpStatoChange = grdValorimedpStatoChange
    end
    object rgpPeriodi: TmeTIWAdvRadioGroup
      Left = 24
      Top = 3
      Width = 561
      Height = 38
      Css = 'tmsradiogroup'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpPeriodi'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Considera il periodo indicato'
        'Considera tutti i periodi dalla data indicata')
      ItemIndex = 0
      SubmitOnAsyncEvent = True
      TabOrder = 17
      OnAsyncClick = rgpPeriodiAsyncClick
    end
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 574
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 574
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 670
    Top = 160
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 574
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 574
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 574
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 687
  end
  object TemplateStoricizazioneRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007StoricizzazioneRG.html'
    Left = 672
    Top = 336
  end
  object TemplateCancellazioneRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007CancellazioneRG.html'
    Left = 680
    Top = 456
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 304
    Top = 8
  end
  object TemplateCancellazioneGiust: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007CancellazioneGiustRG.html'
    Left = 664
    Top = 648
  end
  object TemplateRicodificaGiustRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007RicodificaGiustRG.html'
    Left = 648
    Top = 784
  end
  object TemplateRiallineamentoGiustRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007RiallineamentoGiustRG.html'
    Left = 648
    Top = 912
  end
  object TemplateUnificazioneMatrRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007UnificazioneMatrRG.html'
    Left = 656
    Top = 992
  end
  object TemplateEsecuzioneScriptRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007EsecuzioneScriptRG.html'
    Left = 624
    Top = 1128
  end
  object TemplateCestinoRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007CestinoRG.html'
    Left = 616
    Top = 1240
  end
  object TemplateAllineaTimb: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WB007AllineaTimbRG.html'
    Left = 624
    Top = 1320
  end
end
