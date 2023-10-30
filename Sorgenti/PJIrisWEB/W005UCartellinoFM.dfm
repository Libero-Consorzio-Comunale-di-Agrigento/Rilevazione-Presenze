object W005FCartellinoFM: TW005FCartellinoFM
  Left = 0
  Top = 0
  Width = 533
  Height = 175
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 533
    Height = 175
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwThin
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clWebHOTPINK
    Color = clWebALICEBLUE
    ClipRegion = False
    LayoutMgr = IWTemplateProcessorFrame
    OnCreate = IWFrameRegionCreate
    object btnChiudi: TmeIWButton
      Left = 398
      Top = 125
      Width = 75
      Height = 25
      Visible = False
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
  end
  object IWTemplateProcessorFrame: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    RenderStyles = False
    Left = 128
    Top = 112
  end
  object jQVisFrame: TIWJQueryWidget
    Enabled = True
    Left = 240
    Top = 108
  end
  object dsrRiep: TDataSource
    DataSet = cdsRiep
    Left = 464
    Top = 304
  end
  object cdsRiep: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 304
  end
end
