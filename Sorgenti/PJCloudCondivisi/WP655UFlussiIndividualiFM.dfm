inherited WP655FFlussiIndividualiFM: TWP655FFlussiIndividualiFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Top = 174
      Summary = 'Elenco dati individuali flusso'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      ExplicitTop = 174
    end
    inherited grdDetailNavBar: TmeIWGrid
      Top = 125
      ExplicitTop = 125
    end
    object rgpTipoDati: TmeIWRadioGroup
      Left = 160
      Top = 25
      Width = 177
      Height = 24
      Cursor = crDefault
      Css = 'intestazione'
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
      OnClick = rgpTipoDatiClick
      SubmitOnAsyncEvent = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoDati'
      ItemIndex = 0
      Items.Strings = (
        'Individuali'
        'Riepilogativi')
      Layout = glHorizontal
      ScriptEvents = <>
      TabOrder = 0
    end
    object lblTipoDati: TmeIWLabel
      Left = 160
      Top = 3
      Width = 55
      Height = 16
      Cursor = crAuto
      Css = 'intestazione'
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblTipoDati'
      Caption = 'Tipo dati'
      RawText = False
      Enabled = True
    end
    object rgpTipoRecord: TmeIWRadioGroup
      Left = 64
      Top = 71
      Width = 305
      Height = 33
      Cursor = crDefault
      Css = 'intestazione'
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
      OnClick = rgpTipoRecordClick
      SubmitOnAsyncEvent = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoRecord'
      ItemIndex = 0
      Items.Strings = (
        'Dati manuali'
        'Dati automatici'
        'Entrambi')
      Layout = glHorizontal
      ScriptEvents = <>
      TabOrder = 1
    end
    object btnFiltroParte: TmedpIWImageButton
      Left = 360
      Top = 71
      Width = 89
      Height = 30
      Cursor = crAuto
      Css = 'width15chr'
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = btnFiltroParteClick
      Cacheable = True
      FriendlyName = 'btnFiltroParte'
      ImageFile.URL = 'img/btnFiltroParti.png'
      medpDownloadButton = False
      Caption = 'Filtro parte'
    end
    object btnFiltroNumeri: TmedpIWImageButton
      Left = 455
      Top = 71
      Width = 89
      Height = 30
      Cursor = crAuto
      Css = 'width15chr'
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = btnFiltroNumeriClick
      Cacheable = True
      FriendlyName = 'btnFiltroParte'
      ImageFile.URL = 'img/btnFiltroNumeri.png'
      medpDownloadButton = False
      Caption = 'Filtro numeri'
    end
    object btnFiltroProg: TmedpIWImageButton
      Left = 550
      Top = 71
      Width = 89
      Height = 30
      Cursor = crAuto
      Css = 'width15chr'
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = btnFiltroProgClick
      Cacheable = True
      FriendlyName = 'btnFiltroParte'
      ImageFile.URL = 'img/btnFiltro.png'
      medpDownloadButton = False
      Caption = 'Filtro progr.'
    end
    object lblTipoRecord: TmeIWLabel
      Left = 64
      Top = 59
      Width = 72
      Height = 16
      Cursor = crAuto
      Css = 'intestazione'
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblTipoDati'
      Caption = 'Tipo record'
      RawText = False
      Enabled = True
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WP655FFLussiIndividualiFM.html'
  end
  inherited actlstDetailNavBar: TActionList
    Left = 41
    Top = 112
    inherited actCopiaSu: TAction
      Visible = True
      OnExecute = actCopiaSuExecute
    end
  end
end
