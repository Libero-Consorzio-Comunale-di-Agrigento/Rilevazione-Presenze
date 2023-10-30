inherited WA064FBudgetStraordinario: TWA064FBudgetStraordinario
  Tag = 132
  Height = 479
  ExplicitHeight = 479
  DesignLeft = 8
  DesignTop = 8
  object lblFiltroAnno: TmeIWLabel [16]
    Left = 16
    Top = 435
    Width = 67
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
    FriendlyName = 'lblFiltroAnno'
    Caption = 'Filtro anno'
    Enabled = True
  end
  object cmbFiltroAnno: TmeIWComboBox [17]
    Left = 89
    Top = 435
    Width = 49
    Height = 21
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
    OnChange = cmbFiltroAnnoChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 7
    ItemIndex = -1
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    FriendlyName = 'cmbFiltroAnno'
    NoSelectionText = '-- No Selection --'
  end
  object rgpTipoResiduo: TmeTIWAdvRadioGroup [18]
    Left = 183
    Top = 422
    Width = 321
    Height = 34
    Css = 'groupbox'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = 'Residuo'
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 2
    Editable = True
    FriendlyName = 'rgpTipoResiduo'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Automatico'
      'Manuale')
    ItemIndex = 0
    Layout = glHorizontal
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnClick = rgpTipoResiduoClick
  end
  object grdWA064ToolBar: TmeIWGrid [19]
    Left = 17
    Top = 275
    Width = 544
    Height = 31
    Css = 'medpToolBar'
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
    BorderStyle = tfDefault
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
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdNavigatorBar'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = False
    ScrollToCurrentRow = False
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
  object actlstWA064ToolBar: TActionList
    Left = 297
    Top = 302
    object actStampa: TAction
      Caption = 'btnStampa'
      HelpKeyword = '133'
      Hint = 'Stampa'
      OnExecute = actWA064ToolBarExecute
    end
    object actAllineamentoBudget: TAction
      Tag = 1
      Caption = 'btnVociVariabili'
      HelpKeyword = '131'
      Hint = 'Allineamento del budget'
      OnExecute = actWA064ToolBarExecute
    end
  end
end
