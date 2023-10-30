inherited W003FAnomalie: TW003FAnomalie
  Tag = 402
  Width = 567
  Height = 358
  HelpType = htKeyword
  HelpKeyword = 'W003P0'
  Title = '(W003) Elenco anomalie'
  ExplicitWidth = 567
  ExplicitHeight = 358
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 9
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 2
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 7
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 1
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
  end
  object chkLivello1: TmeIWCheckBox [8]
    Left = 21
    Top = 224
    Width = 81
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = ' Livello 1'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stCool
    TabOrder = 4
    Checked = True
    FriendlyName = 'chkLivello1'
  end
  object chkLivello2: TmeIWCheckBox [9]
    Left = 108
    Top = 224
    Width = 88
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = ' Livello 2'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stCool
    TabOrder = 8
    Checked = False
    FriendlyName = 'chkLivello2'
  end
  object chkLivello3: TmeIWCheckBox [10]
    Left = 185
    Top = 224
    Width = 86
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = ' Livello 3'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stCool
    TabOrder = 10
    Checked = False
    FriendlyName = 'chkLivello3'
  end
  object btnEsegui: TmeIWButton [11]
    Left = 262
    Top = 220
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
    Caption = 'Esegui'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsegui'
    TabOrder = 11
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object edtPeriodoDal: TmeIWEdit [12]
    Left = 180
    Top = 171
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 0
  end
  object edtPeriodoAl: TmeIWEdit [13]
    Left = 272
    Top = 171
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
  object grdAnomalie: TmeIWGrid [14]
    Left = 16
    Top = 251
    Width = 511
    Height = 94
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
    OnRenderCell = grdAnomalieRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdAnomalie'
    ColumnCount = 1
    OnCellClick = grdAnomalieCellClick
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblPeriodo: TmeIWLabel [15]
    Left = 16
    Top = 173
    Width = 132
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
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Periodo da elaborare'
    Enabled = True
  end
  object lblAnomalie: TmeIWLabel [16]
    Left = 16
    Top = 138
    Width = 58
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
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Anomalie'
    Enabled = True
  end
  object btnEsportaInExcel: TmeIWButton [17]
    Left = 343
    Top = 220
    Width = 108
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
    Caption = 'Esporta in Excel'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsportaInExcel'
    TabOrder = 12
    OnClick = btnEsportaInExcelClick
    medpDownloadButton = False
  end
  object imgPeriodoPrec: TmeIWImageFile [18]
    Left = 154
    Top = 171
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
  object imgPeriodoSucc: TmeIWImageFile [19]
    Left = 351
    Top = 172
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
  object chkConsideraRichiesteIter: TmeIWCheckBox [20]
    Left = 21
    Top = 197
    Width = 264
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
    Caption = 'Considera richieste degli iter autorizzativi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    Checked = True
    FriendlyName = 'chkConsideraRichiesteIter'
  end
  object btnEsportaInCSV: TmeIWButton [21]
    Left = 457
    Top = 220
    Width = 108
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
    Caption = 'Esporta in CSV'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsportaInCSV'
    TabOrder = 14
    OnClick = btnEsportaInCSVClick
    medpDownloadButton = False
  end
end
