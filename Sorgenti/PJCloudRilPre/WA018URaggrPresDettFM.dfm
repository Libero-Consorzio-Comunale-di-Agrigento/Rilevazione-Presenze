inherited WA018FRaggrPresDettFM: TWA018FRaggrPresDettFM
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
    object lblIndennitaNotturna: TmeIWLabel
      Left = 64
      Top = 128
      Width = 115
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
      FriendlyName = 'lblIndennitaNotturna'
      Caption = 'Indennit'#224' notturna'
      RawText = False
    end
    object drgpIndennitaNotturna: TmeIWDBRadioGroup
      Left = 64
      Top = 150
      Width = 121
      Height = 59
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
      Layout = glVertical
      DataField = 'IndNotturna'
      FriendlyName = 'drgpIndennitaNotturna'
      Values.Strings = (
        'S'
        'N'
        'M')
      Items.Strings = (
        'Si'
        'No'
        'Modello d'#39'orario')
      TabOrder = 2
    end
    object lblIndennitaFestiva: TmeIWLabel
      Left = 64
      Top = 216
      Width = 103
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
      FriendlyName = 'lblIndennitaNotturna'
      Caption = 'Indennit'#224' festiva'
      RawText = False
    end
    object drgpIndennitaFestiva: TmeIWDBRadioGroup
      Left = 64
      Top = 238
      Width = 121
      Height = 59
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
      Layout = glVertical
      DataField = 'IndFestiva'
      FriendlyName = 'meIWDBRadioGroup1'
      Values.Strings = (
        'S'
        'N'
        'M')
      Items.Strings = (
        'Si'
        'No'
        'Modello d'#39'orario')
      TabOrder = 3
    end
    object drgpIndennitaPresenza: TmeIWDBRadioGroup
      Left = 64
      Top = 326
      Width = 121
      Height = 59
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
      Layout = glVertical
      DataField = 'INDPRESENZA'
      FriendlyName = 'drgpIndennitaPresenza'
      Values.Strings = (
        'S'
        'N')
      Items.Strings = (
        'Si'
        'No')
      TabOrder = 4
    end
    object lblIndennitaPresenza: TmeIWLabel
      Left = 64
      Top = 304
      Width = 135
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
      FriendlyName = 'lblIndennitaNotturna'
      Caption = 'Indennit'#224' di presenza'
      RawText = False
    end
    object lblInquadramento: TmeIWLabel
      Left = 232
      Top = 128
      Width = 95
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
      FriendlyName = 'lblIndennitaNotturna'
      Caption = 'Inquadramento'
      RawText = False
    end
    object drgpInquadramento: TmeIWDBRadioGroup
      Left = 232
      Top = 150
      Width = 145
      Height = 235
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
      Layout = glVertical
      DataField = 'CodInterno'
      FriendlyName = 'drgpInquadramento'
      Values.Strings = (
        'Z'
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G')
      Items.Strings = (
        'Nessuno'
        'Straordinario'
        'Plus-Orario'
        'Reperibilit'#224
        'Guardia pronto soccorso'
        'Comando professionale breve'
        'Recupero ore'
        'Prestazioni Aggiuntive')
      TabOrder = 5
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA018FRaggrPresDettFM.html'
  end
end
