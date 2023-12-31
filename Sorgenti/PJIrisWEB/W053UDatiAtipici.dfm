inherited W053FDatiAtipici: TW053FDatiAtipici
  Tag = 464
  Height = 448
  HelpType = htKeyword
  HelpKeyword = 'W053P0'
  ExplicitHeight = 448
  DesignLeft = 8
  DesignTop = 8
  object lblMese: TmeIWLabel [8]
    Left = 16
    Top = 139
    Width = 33
    Height = 16
    Css = 'intestazione spazio_sx'
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
    ForControl = edtMese
    HasTabOrder = False
    FriendlyName = 'lblMese'
    Caption = 'Mese'
    Enabled = True
  end
  object edtMese: TmeIWEdit [9]
    Left = 16
    Top = 166
    Width = 73
    Height = 21
    Css = 'input_data_my'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtMese'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnAsyncChange = edtMeseAsyncChange
  end
  object lblDato: TmeIWLabel [10]
    Left = 115
    Top = 139
    Width = 28
    Height = 16
    Css = 'intestazione spazio_sx'
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
    FriendlyName = 'lblDato'
    Caption = 'Dato'
    Enabled = True
  end
  object cmbCodDato: TMedpIWMultiColumnComboBox [11]
    Left = 117
    Top = 161
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
    FriendlyName = 'cmbCodDato'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = cmbCodDatoAsyncChange
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
  object lblDescDato: TmeIWLabel [12]
    Left = 244
    Top = 164
    Width = 121
    Height = 16
    Css = 'descrizione'
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
    FriendlyName = 'lblDescDato'
    Caption = 'Descrizione tipologia'
    Enabled = True
  end
  object btnVisualizza: TmeIWButton [13]
    Left = 247
    Top = 139
    Width = 173
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'pulsante nascosto per refresh'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisualizza'
    TabOrder = 8
    OnClick = btnVisualizzaClick
    medpDownloadButton = False
  end
  object btnApplica: TmeIWButton [14]
    Left = 507
    Top = 139
    Width = 121
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Applica modifiche'
    Confirmation = 'Applicare le modifiche?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnApplica'
    TabOrder = 9
    OnClick = btnApplicaClick
    medpDownloadButton = False
  end
  object btnGenera: TmeIWButton [15]
    Left = 426
    Top = 139
    Width = 75
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Genera dato'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnGenera'
    TabOrder = 10
    OnClick = btnGeneraClick
    medpDownloadButton = False
  end
  object dgrdDettaglio: TmedpIWDBGrid [16]
    Left = 123
    Top = 246
    Width = 326
    Height = 52
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
    Caption = 'Registrazione dati atipici'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = dgrdDettaglioRenderCell
    Summary = 'Elenco dati atipici'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrT077
    FooterRowCount = 0
    FriendlyName = 'dgrdDettaglio'
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
    OnAfterCaricaCDS = dgrdDettaglioAfterCaricaCDS
  end
  object dsrT077: TDataSource
    DataSet = cdsT077
    Left = 408
    Top = 252
  end
  object cdsT077: TClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    Left = 464
    Top = 252
  end
end
