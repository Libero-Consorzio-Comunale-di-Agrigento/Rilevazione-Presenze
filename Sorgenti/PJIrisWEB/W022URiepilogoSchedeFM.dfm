object W022FRiepilogoSchedeFM: TW022FRiepilogoSchedeFM
  Left = 0
  Top = 0
  Width = 649
  Height = 310
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 649
    Height = 310
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwThin
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clWebALICEBLUE
    ClipRegion = False
    LayoutMgr = IWTemplateProcessorFrame
    OnCreate = IWFrameRegionCreate
    ExplicitWidth = 515
    object btnChiudi: TmeIWButton
      Left = 355
      Top = 6
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object grdRiepilogoSchede: TmeIWGrid
      Left = 1
      Top = 88
      Width = 450
      Height = 111
      Align = alCustom
      Css = 'comandi'
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
      BorderSize = 1
      BorderStyle = tfDefault
      CellPadding = 2
      CellSpacing = 1
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdRiepilogoSchedeRenderCell
      UseFrame = True
      UseSize = True
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdRiepilogoSchede'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object btnEsportaInExcel: TmeIWButton
      Left = 355
      Top = 33
      Width = 96
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
      Enabled = False
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnEsportaInExcel'
      TabOrder = 1
      OnClick = btnEsportaInExcelClick
      medpDownloadButton = True
    end
    object lblTipoRiepilogo: TmeIWLabel
      Left = 5
      Top = 223
      Width = 62
      Height = 16
      Align = alCustom
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
      ForControl = rgpTipoRiepilogo
      HasTabOrder = False
      FriendlyName = 'lblTipoRiepilogo'
      Caption = 'Riepilogo:'
      Enabled = True
    end
    object rgpTipoRiepilogo: TmeIWRadioGroup
      Left = 73
      Top = 223
      Width = 570
      Height = 16
      Cursor = crDefault
      Align = alCustom
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      OnClick = rgpTipoRiepilogoClick
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoRiepilogo'
      ItemIndex = 0
      Items.Strings = (
        'Completo stato attuale'
        'Sintetico stato attuale'
        'Sintetico tutti gli stati'
        'Solo senza scheda')
      Layout = glHorizontal
      TabOrder = 2
    end
    object btnEsportaInCSV: TmeIWButton
      Left = 355
      Top = 62
      Width = 96
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
      Enabled = False
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnEsportaiInCSV'
      TabOrder = 3
      OnClick = btnEsportaInCSVClick
      medpDownloadButton = True
    end
  end
  object jQRiepilogoSchede: TIWJQueryWidget
    Enabled = True
    Left = 184
    Top = 8
  end
  object IWTemplateProcessorFrame: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W022FRiepilogoSchedeFM.html'
    RenderStyles = False
    Left = 56
    Top = 8
  end
end