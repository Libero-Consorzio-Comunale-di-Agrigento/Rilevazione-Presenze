inherited WA197FPreviewFM: TWA197FPreviewFM
  Width = 449
  Height = 274
  ExplicitWidth = 449
  ExplicitHeight = 274
  inherited IWFrameRegion: TIWRegion
    Width = 449
    Height = 274
    ExplicitWidth = 449
    ExplicitHeight = 274
    object btnChiudi: TmeIWButton
      Left = 333
      Top = 200
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object previewRG: TmeIWRegion
      Left = 24
      Top = 65
      Width = 361
      Height = 129
      Cursor = crAuto
      RenderInvisibleControls = False
      BorderOptions.NumericWidth = 1
      BorderOptions.BorderWidth = cbwNumeric
      BorderOptions.Style = cbsSolid
      BorderOptions.Color = clNone
      Color = clWebRED
      ParentShowHint = False
      ShowHint = True
      ZIndex = 1000
      Splitter = False
    end
  end
end