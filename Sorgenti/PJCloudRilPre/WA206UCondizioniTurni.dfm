inherited WA206FCondizioniTurni: TWA206FCondizioniTurni
  Tag = 184
  Height = 481
  ExplicitHeight = 481
  DesignLeft = 8
  DesignTop = 8
  object WA206AreaIntestazioneRG: TmeIWRegion [15]
    Left = 16
    Top = 400
    Width = 529
    Height = 65
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateAreaIntestazioneRG
    object rgpTipoCondizioni: TmeIWRadioGroup
      Left = 17
      Top = 32
      Width = 209
      Height = 23
      Cursor = crDefault
      Css = 'intestazione radiogroup'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      OnClick = rgpTipoCondizioniClick
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoCondizioni'
      ItemIndex = 0
      Items.Strings = (
        'Generali'
        'Individuali'
        'Entrambe')
      Layout = glHorizontal
      TabOrder = 7
    end
    object lblTipoCondizioni: TmeIWLabel
      Left = 17
      Top = 10
      Width = 93
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
      FriendlyName = 'lblTipoCondizioni'
      Caption = 'Tipo condizioni'
      Enabled = True
    end
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
  object TemplateAreaIntestazioneRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA206AreaIntestazioneRG.html'
    RenderStyles = False
    Left = 332
    Top = 408
  end
end
