inherited WA093FOperazioni: TWA093FOperazioni
  Tag = 149
  Width = 626
  Height = 337
  Title = '(WA093) Monitoraggio tabella di log'
  ExplicitWidth = 626
  ExplicitHeight = 337
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    Left = 17
    ExplicitLeft = 17
  end
  object grdTabControl: TmedpIWTabControl [9]
    Left = 17
    Top = 224
    Width = 300
    Height = 33
    Cursor = crAuto
    Css = 'gridTabControl'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
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
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdTabControl'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 215
  end
end
