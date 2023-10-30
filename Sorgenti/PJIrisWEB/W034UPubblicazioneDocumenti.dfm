inherited W034FPubblicazioneDocumenti: TW034FPubblicazioneDocumenti
  Tag = 444
  Width = 723
  Height = 664
  HelpType = htKeyword
  HelpKeyword = 'W034P0'
  ExplicitWidth = 723
  ExplicitHeight = 664
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 3
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 0
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 1
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 2
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
  end
  object lblTipologie: TmeIWLabel [8]
    Left = 16
    Top = 141
    Width = 126
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
    FriendlyName = 'lblTipologie'
    Caption = 'Tipologia documenti'
    Enabled = True
  end
  object lblDescTipologia: TmeIWLabel [9]
    Left = 145
    Top = 166
    Width = 121
    Height = 16
    Css = 'intestazione'
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
    AutoSize = False
    FriendlyName = 'lblDescTipologia'
    Caption = 'Descrizione tipologia'
    Enabled = True
  end
  object memDettaglio: TmeIWMemo [10]
    Left = 18
    Top = 333
    Width = 569
    Height = 82
    Css = 'width100pc height30 fontcourierImp'
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
    TabOrder = 4
    SubmitOnAsyncEvent = True
    FriendlyName = 'memDettaglio'
  end
  object grdDocumenti: TmedpIWDBGrid [11]
    Left = 18
    Top = 208
    Width = 569
    Height = 97
    Visible = False
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
    Caption = 'Documenti pubblicati'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdDocumentiRenderCell
    Summary = 'Elenco dei documenti pubblicati'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdDocumenti'
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
    OnAfterCaricaCDS = grdDocumentiAfterCaricaCDS
  end
  object lnkVisualizza: TmeIWLink [12]
    Left = 488
    Top = 13
    Width = 81
    Height = 17
    Css = 'link'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkVisualizza'
    OnClick = lnkVisualizzaClick
    TabOrder = 7
    RawText = False
    Caption = 'lnkVisualizza'
    medpDownloadButton = False
  end
  object chkDettaglio: TmeIWCheckBox [13]
    Left = 462
    Top = 163
    Width = 227
    Height = 21
    Css = 'intestazione noWrap'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Visualizza dettaglio ricerca'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 8
    OnAsyncClick = chkDettaglioAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object grdFiltroDocumenti: TmeIWGrid [14]
    Left = 295
    Top = 163
    Width = 153
    Height = 28
    Visible = False
    Css = 'gridTrasparente'
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
    Caption = 'grdFiltroDocumenti'
    CellPadding = 2
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    OnRenderCell = grdFiltroDocumentiRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdFiltroDocumenti'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblFiltroDocumenti: TmeIWLabel [15]
    Left = 295
    Top = 141
    Width = 101
    Height = 16
    Visible = False
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
    FriendlyName = 'lblFiltroDocumenti'
    Caption = 'Filtro documenti'
    Enabled = True
  end
  object cmbTipologie: TMedpIWMultiColumnComboBox [16]
    Left = 18
    Top = 163
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
    FriendlyName = 'cmbTipologie'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncChange = cmbTipologieAsyncChange
    PopUpHeight = 10
    PopUpWidth = 20
    Text = ''
    ColCount = 1
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblTempoRicerca: TmeIWLabel [17]
    Left = 22
    Top = 311
    Width = 104
    Height = 16
    Css = 'informazione'
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
    FriendlyName = 'lblTempoRicerca'
    Caption = 'lblTempoRicerca'
    Enabled = True
  end
  object cmbAnno: TmeIWComboBox [18]
    Left = 90
    Top = 442
    Width = 121
    Height = 21
    Visible = False
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 10
    ItemIndex = -1
    FriendlyName = 'cmbAnno'
    NoSelectionText = '-- No Selection --'
  end
  object cmbMese: TmeIWComboBox [19]
    Left = 90
    Top = 485
    Width = 121
    Height = 21
    Visible = False
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 11
    ItemIndex = -1
    FriendlyName = 'cmbAnno'
    NoSelectionText = '-- No Selection --'
  end
  object lblAnno: TmeIWLabel [20]
    Left = 22
    Top = 442
    Width = 31
    Height = 16
    Visible = False
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
    FriendlyName = 'lblAnno'
    Caption = 'Anno'
    Enabled = True
  end
  object lblMese: TmeIWLabel [21]
    Left = 22
    Top = 485
    Width = 33
    Height = 16
    Visible = False
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
    FriendlyName = 'lblMese'
    Caption = 'Mese'
    Enabled = True
  end
  object btnStampa: TmeIWButton [22]
    Left = 246
    Top = 464
    Width = 75
    Height = 25
    Visible = False
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Stampa'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampa'
    TabOrder = 12
    OnClick = btnStampaClick
    medpDownloadButton = False
  end
  object ajnPreparaDataset: TIWAJAXNotifier
    OnNotify = ajnPreparaDatasetNotify
    Left = 32
    Top = 551
  end
  object ajnPopolaDataset: TIWAJAXNotifier
    OnNotify = ajnPopolaDatasetNotify
    Left = 149
    Top = 551
  end
  object ajnVisualizza: TIWAJAXNotifier
    OnNotify = ajnVisualizzaNotify
    Left = 256
    Top = 551
  end
  object xmlDoc: TXMLDocument
    Left = 342
    Top = 464
    DOMVendorDesc = 'MSXML'
  end
end
