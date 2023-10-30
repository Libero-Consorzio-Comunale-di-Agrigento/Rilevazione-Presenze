inherited W006FListaReperibili: TW006FListaReperibili
  Tag = 404
  Width = 554
  Height = 412
  HelpType = htKeyword
  HelpKeyword = 'W006P0'
  Title = '(W006) Lista personale reperibile'
  ExplicitWidth = 554
  ExplicitHeight = 412
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 1
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 2
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 4
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 7
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
  end
  object btnEsegui: TmeIWButton [8]
    Left = 408
    Top = 162
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
    Caption = 'Visualizza'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsegui'
    TabOrder = 8
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object lblPeriodo: TmeIWLabel [9]
    Left = 93
    Top = 128
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
    NoWrap = True
    ForControl = edtPeriodoDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodo'
    Caption = 'Periodo'
    Enabled = True
  end
  object edtPeriodoDal: TmeIWEdit [10]
    Left = 128
    Top = 166
    Width = 73
    Height = 21
    Css = 'input_data_dmy '
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 0
  end
  object edtPeriodoAl: TmeIWEdit [11]
    Left = 227
    Top = 166
    Width = 73
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtPeriodoAl'
    SubmitOnAsyncEvent = True
    TabOrder = 3
  end
  object grdReperibili: TmeIWGrid [12]
    Left = 16
    Top = 281
    Width = 504
    Height = 112
    OnHTMLTag = grdReperibiliHTMLTag
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
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdReperibiliRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdReperibili'
    ColumnCount = 1
    OnCellClick = grdReperibiliCellClick
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object imgPeriodoPrec: TmeIWImageFile [13]
    Left = 93
    Top = 166
    Width = 20
    Height = 20
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
    Cacheable = True
    FriendlyName = 'imgPeriodoPrec'
    medpDownloadButton = False
  end
  object imgPeriodoSucc: TmeIWImageFile [14]
    Left = 327
    Top = 166
    Width = 20
    Height = 20
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
    Cacheable = True
    FriendlyName = 'imgPeriodoSucc'
    medpDownloadButton = False
  end
  object lblLegendaFiltri: TmeIWLabel [15]
    Left = 16
    Top = 203
    Width = 101
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
    FriendlyName = 'lblLegendaFiltri'
    Caption = 'Filtro dipendenti'
    Enabled = True
  end
  object lblFiltroDato1: TmeIWLabel [16]
    Left = 31
    Top = 225
    Width = 40
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
    ForControl = cmbFiltroDato1
    HasTabOrder = False
    FriendlyName = 'lblFiltroDato1'
    Caption = 'Dato 1'
    Enabled = True
  end
  object lblFiltroDato2: TmeIWLabel [17]
    Left = 31
    Top = 252
    Width = 40
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
    ForControl = cmbFiltroDato2
    HasTabOrder = False
    FriendlyName = 'lblFiltroDato2'
    Caption = 'Dato 2'
    Enabled = True
  end
  object cmbFiltroDato2: TMedpIWMultiColumnComboBox [18]
    Left = 77
    Top = 247
    Width = 108
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
    FriendlyName = 'cmbFiltroDato2'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    OnChange = cmbFiltroDato2Change
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput width10chr'
    LookupColumn = 0
    CodeColumn = 0
  end
  object cmbFiltroDato1: TMedpIWMultiColumnComboBox [19]
    Left = 77
    Top = 220
    Width = 108
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
    FriendlyName = 'cmbFiltroDato1'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    OnChange = cmbFiltroDato1Change
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput width10chr'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblFiltroDato1Desc: TmeIWLabel [20]
    Left = 191
    Top = 225
    Width = 112
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
    FriendlyName = 'lblFiltroDato1Desc'
    Caption = 'lblFiltroDato1Desc'
    Enabled = True
  end
  object lblFiltroDato2Desc: TmeIWLabel [21]
    Left = 191
    Top = 252
    Width = 112
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
    FriendlyName = 'lblFiltroDato2Desc'
    Caption = 'lblFiltroDato2Desc'
    Enabled = True
  end
  object edtOraDalle: TmeIWEdit [22]
    Left = 446
    Top = 225
    Width = 74
    Height = 21
    Css = 'input_hour_hhmm width4chr'
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
    FriendlyName = 'edtOraDalle'
    SubmitOnAsyncEvent = True
    TabOrder = 11
  end
  object lblOraDalle: TmeIWLabel [23]
    Left = 368
    Top = 226
    Width = 30
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
    FriendlyName = 'lblOraDalle'
    Caption = 'Dalle'
    Enabled = True
  end
  object edtOraAlle: TmeIWEdit [24]
    Left = 446
    Top = 254
    Width = 74
    Height = 21
    Css = 'input_hour_hhmm width4chr'
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
    FriendlyName = 'edtOraAlle'
    SubmitOnAsyncEvent = True
    TabOrder = 12
  end
  object lblOraAlle: TmeIWLabel [25]
    Left = 368
    Top = 248
    Width = 23
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
    FriendlyName = 'lblOraAlle'
    Caption = 'Alle'
    Enabled = True
  end
  object lblFiltroOre: TmeIWLabel [26]
    Left = 358
    Top = 204
    Width = 57
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
    FriendlyName = 'lblFiltroOre'
    Caption = 'Filtro ore'
    Enabled = True
  end
  object lblPeriodoDal: TmeIWLabel [27]
    Left = 128
    Top = 144
    Width = 19
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
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Dal'
    Enabled = True
  end
  object lblPeriodoAl: TmeIWLabel [28]
    Left = 227
    Top = 144
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
    FriendlyName = 'lblPeriodoAl'
    Caption = 'Al'
    Enabled = True
  end
end
