inherited WA128FPianPrestazioniAggiuntive: TWA128FPianPrestazioniAggiuntive
  Tag = 61
  Height = 519
  Title = '(WA128) Pianificazione prestazioni aggiuntive'
  ExplicitHeight = 519
  DesignLeft = 8
  DesignTop = 8
  object lblContratto: TmeIWLabel [15]
    Left = 22
    Top = 356
    Width = 68
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
    FriendlyName = 'lblContratto'
    Caption = 'Contratto: '
    Enabled = True
  end
  object btnCambioData: TmeIWButton [16]
    Left = 96
    Top = 395
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
    Caption = 'pulsante nascosto per cambio data'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnShowElabError'
    TabOrder = 7
    OnClick = btnCambioDataClick
    medpDownloadButton = False
  end
  object lblAnno: TmeIWLabel [17]
    Left = 22
    Top = 431
    Width = 31
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
    ForControl = edtAnno
    HasTabOrder = False
    FriendlyName = 'lblAnno'
    Caption = 'Anno'
    Enabled = True
  end
  object edtAnno: TmeIWEdit [18]
    Left = 59
    Top = 426
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtAnno'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtAnnoAsyncChange
    Text = '0'
  end
  object lblMese: TmeIWLabel [19]
    Left = 134
    Top = 431
    Width = 33
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
    ForControl = edtMese
    HasTabOrder = False
    FriendlyName = 'lblMese'
    Caption = 'Mese'
    Enabled = True
  end
  object edtMese: TmeIWEdit [20]
    Left = 171
    Top = 426
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtMese'
    MaxLength = 2
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncChange = edtAnnoAsyncChange
    Text = '0'
  end
  object grdTabDetail: TmedpIWTabControl [21]
    Left = 22
    Top = 467
    Width = 300
    Height = 29
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
    Caption = 'grdTabDetail'
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
    FriendlyName = 'grdTabDetail'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
    OnTabControlChange = grdTabDetailTabControlChange
  end
  object lblPartTime: TmeIWLabel [22]
    Left = 22
    Top = 378
    Width = 63
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
    FriendlyName = 'lblPartTime'
    Caption = 'Part-time:'
    Enabled = True
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
end
