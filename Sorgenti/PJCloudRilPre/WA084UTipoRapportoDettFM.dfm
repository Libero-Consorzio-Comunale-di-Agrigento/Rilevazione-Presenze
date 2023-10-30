inherited WA084FTipoRapportoDettFM: TWA084FTipoRapportoDettFM
  Width = 630
  Height = 459
  ExplicitWidth = 630
  ExplicitHeight = 459
  inherited IWFrameRegion: TIWRegion
    Width = 630
    Height = 459
    ExplicitWidth = 630
    ExplicitHeight = 459
    object lblCodice: TmeIWLabel
      Left = 64
      Top = 72
      Width = 41
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblCodice'
      Caption = 'Codice'
      RawText = False
    end
    object dedtCodice: TmeIWDBEdit
      Left = 64
      Top = 94
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'input10'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      Alignment = taLeftJustify
      BGColor = clNone
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'dedtCodice'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 0
      AutoEditable = True
      DataField = 'CODICE'
      PasswordPrompt = False
    end
    object dedtDescrizione: TmeIWDBEdit
      Left = 232
      Top = 94
      Width = 369
      Height = 21
      Cursor = crAuto
      Css = 'width40chr'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      Alignment = taLeftJustify
      BGColor = clNone
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'dedtDescrizione'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 1
      AutoEditable = True
      DataField = 'DESCRIZIONE'
      PasswordPrompt = False
    end
    object lblDescrizione: TmeIWLabel
      Left = 232
      Top = 72
      Width = 71
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'IWLabel1'
      Caption = 'Descrizione'
      RawText = False
    end
    object lblTipoRapporto: TmeIWLabel
      Left = 64
      Top = 121
      Width = 85
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblTipoRapporto'
      Caption = 'Tipo rapporto'
      RawText = False
    end
    object drgpTipoRapporto: TmeIWDBRadioGroup
      Left = 64
      Top = 143
      Width = 537
      Height = 50
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
      SubmitOnAsyncEvent = True
      TrimValues = True
      AutoEditable = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Layout = glHorizontal
      DataField = 'TIPO'
      FriendlyName = 'drgpTipoRapporto'
      Values.Strings = (
        'R'
        'S'
        'I'
        'P'
        'A')
      Items.Strings = (
        'Ruolo'
        'Supplente'
        'Incaricato'
        'Prova'
        'Altro')
      TabOrder = 2
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA084FTipoRapportoDettFM.html'
  end
end
