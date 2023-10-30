inherited WC013FCheckListFM: TWC013FCheckListFM
  Width = 394
  Height = 371
  ExplicitWidth = 394
  ExplicitHeight = 371
  inherited IWFrameRegion: TIWRegion
    Width = 394
    Height = 371
    BorderOptions.BorderWidth = cbwThin
    Color = clWebALICEBLUE
    ClipRegion = False
    ExplicitWidth = 394
    ExplicitHeight = 371
    object btnOk: TmeIWButton
      Left = 265
      Top = 10
      Width = 84
      Height = 25
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Ok'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnOk'
      TabOrder = 0
      OnClick = btnClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 265
      Top = 41
      Width = 84
      Height = 25
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      TabOrder = 1
      OnClick = btnClick
      medpDownloadButton = False
    end
    object ckList: TmeTIWAdvCheckGroup
      Left = 1
      Top = 128
      Width = 392
      Height = 242
      Align = alBottom
      Css = 'intestazione prewrapcheckgroup fontcourier'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clNone
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'ckList'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      TabOrder = 2
      medpContextMenu = pmnWC013Azioni
      ExplicitWidth = 350
    end
    object imgDeselezionaTutto: TmeIWImageFile
      Left = 156
      Top = 14
      Width = 22
      Height = 21
      Hint = 'Deseleziona tutto'
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
      OnAsyncClick = imgDeselezionaTuttoAsyncClick
      Cacheable = True
      FriendlyName = 'IWImageFile1'
      ImageFile.Filename = 'img\btnUncheckAll.png'
      medpDownloadButton = False
    end
    object imgInvertiSelezione: TmeIWImageFile
      Left = 184
      Top = 14
      Width = 22
      Height = 21
      Hint = 'Inverti selezione'
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
      OnAsyncClick = imgInvertiSelezioneAsyncClick
      Cacheable = True
      FriendlyName = 'IWImageFile1'
      ImageFile.Filename = 'img\btnInvertSelect.png'
      medpDownloadButton = False
    end
    object imgSelezionaTutto: TmeIWImageFile
      Left = 128
      Top = 14
      Width = 22
      Height = 21
      Hint = 'Seleziona tutto'
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
      OnAsyncClick = imgSelezionaTuttoAsyncClick
      Cacheable = True
      FriendlyName = 'imgSelezionaTutto'
      ImageFile.Filename = 'img\btnCheckAll.png'
      medpDownloadButton = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WC013FCheckListFM.html'
    Left = 48
    Top = 40
  end
  inherited JQuery: TIWJQueryWidget
    Left = 8
  end
  object pmnWC013Azioni: TPopupMenu
    Left = 160
    Top = 72
    object SelezionatuttoWC013: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = SelezionatuttoWC013Click
    end
    object DeselezionatuttoWC013: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = DeselezionatuttoWC013Click
    end
    object InvertiselezioneWC013: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = InvertiselezioneWC013Click
    end
  end
end
