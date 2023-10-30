inherited WA082FCdcPercent: TWA082FCdcPercent
  Tag = 162
  Height = 495
  Title = '(WA082) Centri di costo percentualizzati'
  ExplicitHeight = 495
  DesignLeft = 8
  DesignTop = 8
  inherited btnShowElabError: TmeIWButton
    TabOrder = 5
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
  end
  object memoAnomalie: TmeIWMemo [13]
    Left = 17
    Top = 344
    Width = 593
    Height = 113
    Cursor = crAuto
    Css = 'textarea_anomalie'
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
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 4
    SubmitOnAsyncEvent = True
    FriendlyName = 'memoAnomalie'
  end
  inherited actlstNavigatorBar: TActionList
    Left = 456
    Top = 256
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actRipristina: TAction
      Category = 'Validazione'
      Caption = 'btnRipristina'
      Hint = 'Ripristina situazione precedente'
      OnExecute = actRipristinaExecute
    end
    object actCopia: TAction
      Caption = 'btnCopia'
      Hint = 'Copia su altri dipendenti'
      OnExecute = actCopiaExecute
    end
  end
end
