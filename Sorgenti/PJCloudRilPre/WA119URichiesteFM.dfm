inherited WA119FRichiesteFM: TWA119FRichiesteFM
  Height = 412
  ExplicitHeight = 412
  inherited IWFrameRegion: TIWRegion
    Height = 412
    ExplicitHeight = 469
    inherited grdTabella: TmedpIWDBGrid
      Left = 22
      Top = 224
      Height = 169
      Caption = 'Elenco notifiche'
      Summary = 'Elenco schede di notifica adesione allo sciopero'
      ExplicitLeft = 22
      ExplicitTop = 224
      ExplicitHeight = 169
    end
    object rgpAutorizzate: TmeTIWAdvRadioGroup
      Left = 30
      Top = 160
      Width = 193
      Height = 33
      Cursor = crAuto
      Css = 'groupbox fs100 width20chr'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = 'Notifiche autorizzate'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 3
      Editable = True
      FriendlyName = 'rgpAutorizzate'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'S'#236
        'No'
        'Tutti')
      ItemIndex = 2
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 0
      OnClick = rgpAutorizzateClick
    end
    object rgpBloccate: TmeTIWAdvRadioGroup
      Left = 254
      Top = 160
      Width = 193
      Height = 33
      Cursor = crAuto
      Css = 'groupbox fs100 width20chr'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = 'Notifiche bloccate'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 3
      Editable = True
      FriendlyName = 'rgpNotifiche'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'S'#236
        'No'
        'Tutti')
      ItemIndex = 2
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 1
      OnClick = rgpBloccateClick
    end
    object btnImporta: TmedpIWImageButton
      Left = 496
      Top = 160
      Width = 145
      Height = 33
      Cursor = crAuto
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
      BorderOptions.Color = clNone
      BorderOptions.Width = 0
      Confirmation = 
        'Confermi l'#39'importazione dei giustificativi per tutte le richiest' +
        'e autorizzate?'
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = btnImportaClick
      Cacheable = True
      FriendlyName = 'btnImporta'
      ImageFile.Filename = 'img\btnOmesseTimbrature.png'
      medpDownloadButton = False
      Caption = 'Importa tutti i giustificativi'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA119FRichiesteFM.html'
  end
  inherited pmnGrdTabellaDett: TPopupMenu
    Left = 562
    Top = 302
  end
end
