inherited WA021FAssestamentoAnnuoFM: TWA021FAssestamentoAnnuoFM
  Width = 268
  Height = 286
  ExplicitWidth = 268
  ExplicitHeight = 286
  inherited IWFrameRegion: TIWRegion
    Width = 268
    Height = 286
    ExplicitWidth = 268
    ExplicitHeight = 286
    object lblOrdineAbbattimento: TmeIWLabel
      Left = 16
      Top = 91
      Width = 222
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
      FriendlyName = 'lblOrdineAbbattimento'
      Caption = 'Ordine di abbattimento dei serbatoi'
      RawText = False
      Enabled = True
    end
    object lstOrdine: TmeIWListbox
      Left = 16
      Top = 113
      Width = 201
      Height = 121
      Cursor = crAuto
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FocusColor = clNone
      AutoHideOnMenuActivation = False
      ItemsHaveValues = True
      NoSelectionText = ' '
      Required = False
      RequireSelection = False
      ScriptEvents = <>
      UseSize = False
      Editable = True
      TabOrder = 0
      SubmitOnAsyncEvent = True
      NonEditableAsLabel = True
      MaxItems = 0
      FriendlyName = 'lstOrdine'
      ItemIndex = -1
      MultiSelect = True
      Sorted = False
    end
    object btnOk: TmeIWButton
      Left = 16
      Top = 248
      Width = 75
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
      Caption = 'Ok'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnOk'
      ScriptEvents = <>
      TabOrder = 1
      OnClick = btnClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 142
      Top = 248
      Width = 75
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'meIWButton1'
      ScriptEvents = <>
      TabOrder = 2
      OnClick = btnClick
      medpDownloadButton = False
    end
    object imgSpostaSu: TmeIWImageFile
      Left = 223
      Top = 113
      Width = 22
      Height = 21
      Cursor = crAuto
      Hint = 'Sposta su'
      HelpType = htKeyword
      HelpKeyword = '1615'
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
      OnAsyncClick = imgSpostaSuAsyncClick
      Cacheable = True
      FriendlyName = 'imgSpostaSu'
      ImageFile.Filename = 'img\btnSu.png'
      medpDownloadButton = False
    end
    object imgSpostaGiu: TmeIWImageFile
      Left = 223
      Top = 140
      Width = 22
      Height = 21
      Cursor = crAuto
      Hint = 'Sposta gi'#249
      HelpType = htKeyword
      HelpKeyword = '1615'
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
      OnAsyncClick = imgSpostaGiuAsyncClick
      Cacheable = True
      FriendlyName = 'imgAccedi'
      ImageFile.Filename = 'img\btnGiu.png'
      medpDownloadButton = False
    end
    object chkAssestamentoAnnuo: TmeIWCheckBox
      Left = 16
      Top = 64
      Width = 153
      Height = 21
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
      Caption = 'Assestamento annuo'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 3
      OnAsyncClick = chkAssestamentoAnnuoAsyncClick
      Checked = False
      FriendlyName = 'chkAssestamentoAnnuo'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA021FAssestamentoAnnuoFM.html'
  end
end