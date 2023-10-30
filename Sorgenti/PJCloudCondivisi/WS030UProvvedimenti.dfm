inherited WS030FProvvedimenti: TWS030FProvvedimenti
  Tag = 304
  Height = 433
  ExplicitHeight = 433
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  object lblVisualizza: TmeIWLabel [15]
    Left = 16
    Top = 340
    Width = 124
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
    FriendlyName = 'lblVisualizza'
    Caption = 'Filtro provvedimenti'
    Enabled = True
  end
  object rgpVisualizza: TmeIWRadioGroup [16]
    Left = 16
    Top = 362
    Width = 169
    Height = 23
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpVisualizzaClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpVisualizza'
    ItemIndex = 0
    Items.Strings = (
      'Storici'
      'Assenze'
      'Tutti')
    Layout = glHorizontal
    TabOrder = 6
  end
  object lblModalita: TmeIWLabel [17]
    Left = 220
    Top = 340
    Width = 52
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
    FriendlyName = 'lblModalita'
    Caption = 'Modalit'#224
    Enabled = True
  end
  object rgpModalita: TmeIWRadioGroup [18]
    Left = 220
    Top = 362
    Width = 133
    Height = 30
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpModalitaClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpModalita'
    ItemIndex = 0
    Items.Strings = (
      'Singola'
      'Collettiva')
    Layout = glHorizontal
    TabOrder = 8
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actVisualizzaAnomalie: TAction
      Category = 'Azioni Speciali'
      Caption = 'btnAnomalie'
      Enabled = False
      Hint = 'Anomalie'
      OnExecute = actVisualizzaAnomalieExecute
    end
  end
end
