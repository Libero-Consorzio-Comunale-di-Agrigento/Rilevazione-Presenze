inherited WA184FFiltroFunzioniBrowseFM: TWA184FFiltroFunzioniBrowseFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Filtro funzioni'
    end
    object btnAggiornaFiltroFunzioni: TmedpIWImageButton
      Left = 30
      Top = 45
      Width = 156
      Height = 21
      Css = 'width25chr'
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
      OnClick = btnAggiornaFiltroFunzioniClick
      Cacheable = True
      FriendlyName = 'btnAggiornaFiltroFunzioni'
      ImageFile.Filename = 'img\btnRefresh2.png'
      medpDownloadButton = False
      Caption = 'Aggiorna funzioni disponibili'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA184FFiltroFunzioniBrowseFM.html'
    Left = 440
    Top = 16
  end
  inherited JQuery: TIWJQueryWidget
    Left = 368
    Top = 16
  end
end
