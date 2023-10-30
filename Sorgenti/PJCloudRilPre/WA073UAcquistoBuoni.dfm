inherited WA073FAcquistoBuoni: TWA073FAcquistoBuoni
  Tag = 35
  Height = 422
  Title = '(WA073) Riepilogo acquisto buoni pasto/ticket'
  JavaScript.Strings = (
    '')
  ExplicitHeight = 422
  DesignLeft = 8
  DesignTop = 8
  object imbInterrogazioniServizio: TmedpIWImageButton [15]
    Tag = 31
    Left = 16
    Top = 352
    Width = 89
    Height = 25
    HelpType = htKeyword
    Css = 'width20chr'
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
    OnClick = imbMagazzinoBuoniClick
    Cacheable = True
    FriendlyName = 'imbInterrogazioniServizio'
    ImageFile.Filename = 'img\btnInterrogazioniServizio.png'
    medpDownloadButton = False
    Caption = 'Interrogazioni di servizio'
  end
  object imbMagazzinoBuoni: TmedpIWImageButton [16]
    Tag = 179
    Left = 144
    Top = 352
    Width = 89
    Height = 25
    HelpType = htKeyword
    Css = 'width20chr'
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
    OnClick = imbMagazzinoBuoniClick
    Cacheable = True
    FriendlyName = 'medpIWImageButton1'
    medpDownloadButton = False
    Caption = 'Magazzino buoni pasto'
  end
  inherited actlstNavigatorBar: TActionList
    Left = 384
    Top = 24
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
end
