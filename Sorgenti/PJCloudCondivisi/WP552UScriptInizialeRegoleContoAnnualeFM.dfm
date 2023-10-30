inherited WP552FScriptInizialeRegoleContoAnnualeFM: TWP552FScriptInizialeRegoleContoAnnualeFM
  Width = 543
  Height = 399
  ExplicitWidth = 543
  ExplicitHeight = 399
  inherited IWFrameRegion: TIWRegion
    Width = 543
    Height = 399
    ExplicitWidth = 543
    ExplicitHeight = 399
    object dmemScriptIniziale: TmeIWDBMemo
      Left = 28
      Top = 148
      Width = 387
      Height = 37
      Cursor = crAuto
      Css = 'width100pc height30  bg_grigio'
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
      BGColor = clNone
      Editable = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      ScriptEvents = <>
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 0
      SubmitOnAsyncEvent = True
      AutoEditable = True
      DataField = 'SCRIPT_INIZIALE'
      FriendlyName = 'dmemScriptIniziale'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WP552FScriptInizialeRegoleContoAnnualeFM.html'
  end
end
