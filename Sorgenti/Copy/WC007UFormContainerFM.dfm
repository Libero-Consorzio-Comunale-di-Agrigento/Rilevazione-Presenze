inherited WC007FFormContainerFM: TWC007FFormContainerFM
  inherited IWFrameRegion: TIWRegion
    object btnChiudi: TmeIWButton
      Left = 25
      Top = 97
      Width = 84
      Height = 25
      Css = 'pulsante'
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
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA080FTabLayoutFM.html'
  end
end
