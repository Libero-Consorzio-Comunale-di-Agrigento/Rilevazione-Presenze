inherited WA109FImmagini: TWA109FImmagini
  Tag = 164
  Width = 742
  Height = 562
  ExplicitWidth = 742
  ExplicitHeight = 562
  DesignLeft = 8
  DesignTop = 8
  inherited grdNavigatorBar: TmeIWGrid
    RenderSize = False
    StyleRenderOptions.RenderSize = False
  end
  inherited grdToolBarStorico: TmeIWGrid
    RenderSize = False
    StyleRenderOptions.RenderSize = False
  end
  object dimgImmagine: TmeIWDBImage [15]
    Left = 18
    Top = 405
    Width = 307
    Height = 112
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPadding = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    FriendlyName = 'dimgImmagine'
    DataField = 'IMMAGINE'
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 215
  end
end
