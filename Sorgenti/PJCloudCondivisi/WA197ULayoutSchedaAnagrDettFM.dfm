inherited WA197FLayoutSchedaAnagrDettFM: TWA197FLayoutSchedaAnagrDettFM
  inherited IWFrameRegion: TIWRegion
    object grdTabDetail: TmedpIWTabControl
      Left = 24
      Top = 96
      Width = 313
      Height = 25
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
      Lines = tlNone
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      FriendlyName = 'grdTabDetail'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
      CssTabHeaders = 'medpTabControl medpTabControlCompact'
      OnTabControlChange = grdTabDetailTabControlChange
    end
    object lblNomeLayout: TmeIWLabel
      Left = 16
      Top = 141
      Width = 41
      Height = 16
      Cursor = crAuto
      Css = 'intestazione'
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblNomeLayout'
      Caption = 'Nome:'
      RawText = False
      Enabled = True
    end
    object lblStatoPagina: TmeIWLabel
      Left = 24
      Top = 200
      Width = 79
      Height = 16
      Cursor = crAuto
      Css = 'intestazione'
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblStatoPagina'
      Caption = 'Stato pagina'
      RawText = False
      Enabled = True
    end
    object btnPaginaModificabile: TmeIWButton
      Left = 16
      Top = 216
      Width = 75
      Height = 25
      Cursor = crAuto
      Css = 'pulsante'
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
      Caption = 'Modificabile'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnPaginaModificabile'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = btnPaginaModificabileClick
      medpDownloadButton = False
    end
    object btnPaginaNascosta: TmeIWButton
      Left = 178
      Top = 216
      Width = 75
      Height = 25
      Cursor = crAuto
      Css = 'pulsante'
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
      Caption = 'Nascosta'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnPaginaNascosta'
      ScriptEvents = <>
      TabOrder = 1
      OnClick = btnPaginaNascostaClick
      medpDownloadButton = False
    end
    object btnPaginaSolaLettura: TmeIWButton
      Left = 97
      Top = 216
      Width = 75
      Height = 25
      Cursor = crAuto
      Css = 'pulsante'
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
      Caption = 'Sola lettura'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnPaginaSolaLettura'
      ScriptEvents = <>
      TabOrder = 2
      OnClick = btnPaginaSolaLetturaClick
      medpDownloadButton = False
    end
    object btnPreview: TmeIWButton
      Left = 344
      Top = 176
      Width = 75
      Height = 25
      Cursor = crAuto
      Css = 'pulsante'
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
      Caption = 'Preview...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnPreview'
      ScriptEvents = <>
      TabOrder = 3
      OnClick = btnPreviewClick
      medpDownloadButton = False
    end
    object cmbNomeLayout: TMedpIWMultiColumnComboBox
      Left = 112
      Top = 144
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'medpMultiColumnCombo'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      Alignment = taLeftJustify
      BGColor = clNone
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'cmbNomeLayout'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 4
      PopUpHeight = 15
      Text = ''
      ColCount = 1
      Items = <>
      CustomElement = True
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width20chr'
      LookupColumn = 0
      CodeColumn = 0
    end
  end
  object TemplatePagina: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA197PaginaRG.html'
    OnBeforeProcess = TemplatePaginaBeforeProcess
    RenderStyles = True
    Left = 224
    Top = 8
  end
end