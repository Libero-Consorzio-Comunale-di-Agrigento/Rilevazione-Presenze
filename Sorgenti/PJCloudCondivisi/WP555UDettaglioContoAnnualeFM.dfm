inherited WP555FDettaglioContoAnnualeFM: TWP555FDettaglioContoAnnualeFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Dettaglio conto annuale'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
    end
    object rgpTipoDati: TmeIWRadioGroup
      Left = 208
      Top = 38
      Width = 297
      Height = 33
      Cursor = crDefault
      Css = 'intestazione rgbhoriz'
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
        'Individuali '
        'Riepilogativi'
        'Riepilogativi tabellari')
      Layout = glHorizontal
      ScriptEvents = <>
      TabOrder = 0
    end
    object lblTipoDati: TmeIWLabel
      Left = 192
      Top = 16
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
    object btnFiltroRiga: TmedpIWImageButton
      Left = 336
      Top = 407
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
      OnClick = btnFiltroRigaClick
      Cacheable = True
      FriendlyName = 'btnFiltroRiga'
      ImageFile.URL = 'img/btnFiltroParti.png'
      medpDownloadButton = False
      Caption = 'Filtro riga'
    end
    object btnFiltroColonna: TmedpIWImageButton
      Left = 431
      Top = 407
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
      OnClick = btnFiltroColonnaClick
      Cacheable = True
      FriendlyName = 'btnFiltroColonna'
      ImageFile.URL = 'img/btnFiltroNumeri.png'
      medpDownloadButton = False
      Caption = 'Filtro colonna'
    end
    object btnSalva: TmedpIWImageButton
      Left = 167
      Top = 407
      Width = 90
      Height = 31
      Cursor = crAuto
      Visible = False
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
      OnClick = btnSalvaClick
      Cacheable = True
      FriendlyName = 'btnSalva'
      ImageFile.Filename = 'img\btnSalva.png'
      medpDownloadButton = False
      Caption = 'Salva'
    end
    object btnSendFile: TmeIWButton
      Left = 304
      Top = 208
      Width = 177
      Height = 25
      Cursor = crAuto
      Css = 'pulsante'
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
      Caption = 'Pusante nascosto per sendFile'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnSendFile'
      ScriptEvents = <>
      TabOrder = 1
      OnClick = btnSendFileClick
      medpDownloadButton = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WP555FDettaglioContoAnnualeFM.html'
  end
  inherited actlstDetailNavBar: TActionList
    inherited actCopiaSu: TAction
      OnExecute = actCopiaSuExecute
    end
  end
end
