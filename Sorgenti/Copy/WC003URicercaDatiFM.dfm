inherited WC003FRicercaDatiFM: TWC003FRicercaDatiFM
  Width = 352
  Height = 371
  ExplicitWidth = 352
  ExplicitHeight = 371
  inherited IWFrameRegion: TIWRegion
    Width = 352
    Height = 371
    BorderOptions.BorderWidth = cbwThin
    Color = clWebALICEBLUE
    ClipRegion = False
    ExplicitWidth = 352
    ExplicitHeight = 371
    object grdRicercaDati: TmeIWGrid
      Left = 1
      Top = 72
      Width = 350
      Height = 298
      Align = alBottom
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
      OnRenderCell = grdRicercaDatiRenderCell
      UseFrame = False
      UseSize = True
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdRicercaDati'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object btnOk: TmeIWButton
      Left = 253
      Top = 10
      Width = 84
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
      Caption = 'Ok'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnOk'
      TabOrder = 0
      OnClick = btnOkClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 253
      Top = 41
      Width = 84
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      TabOrder = 1
      OnClick = btnAnnullaClick
      medpDownloadButton = False
    end
    object rgpTipologia: TmeTIWAdvRadioGroup
      Left = 128
      Top = 10
      Width = 161
      Height = 29
      Css = 'groupbox'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderStatus = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      ColumnBorderColor = clWebTransparent
      Columns = 2
      Editable = True
      FriendlyName = 'rgpTipologia'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Ricerca'
        'Filtra')
      ItemIndex = 0
      Layout = glHorizontal
      SubmitOnAsyncEvent = True
      TabOrder = 2
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WC003FRicercaDatiFM.html'
  end
end
