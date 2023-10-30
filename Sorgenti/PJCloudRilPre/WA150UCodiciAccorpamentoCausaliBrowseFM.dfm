inherited WA150FCodiciAccorpamentoCausaliBrowseFm: TWA150FCodiciAccorpamentoCausaliBrowseFm
  Height = 413
  ExplicitHeight = 413
  inherited IWFrameRegion: TIWRegion
    Height = 413
    OnRender = IWFrameRegionRender
    ExplicitHeight = 413
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Causali assenza'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
    object btnFiltroVoci: TmedpIWImageButton
      Left = 30
      Top = 360
      Width = 105
      Height = 33
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
      OnClick = btnFiltroVociClick
      Cacheable = True
      FriendlyName = 'btnFiltroVoci'
      ImageFile.URL = 'img/btnFiltro.png'
      medpDownloadButton = False
      Caption = 'Inserisci causali'
    end
    object btnElimina: TmedpIWImageButton
      Left = 150
      Top = 360
      Width = 105
      Height = 33
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
      OnClick = btnEliminaClick
      Cacheable = True
      FriendlyName = 'btnElimina'
      ImageFile.URL = 'img/btnCestinoCassa.png'
      medpDownloadButton = False
      Caption = 'Elimina causali'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA150FCodiciAccorpamentoCausaliBrowseFm.html'
  end
end
