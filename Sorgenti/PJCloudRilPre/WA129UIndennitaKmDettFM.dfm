inherited WA129FIndennitaKmDettFM: TWA129FIndennitaKmDettFM
  Height = 308
  ExplicitHeight = 308
  inherited IWFrameRegion: TIWRegion
    Height = 308
    ExplicitHeight = 308
    object lblCodice: TmeIWLabel
      Left = 136
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
      FriendlyName = 'lblCodice'
      Caption = 'Codice'
      RawText = False
      Enabled = True
    end
    object dedtCodice: TmeIWDBEdit
      Left = 183
      Top = 67
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width5chr'
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
    object lblDescrizione: TmeIWLabel
      Left = 106
      Top = 97
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
      FriendlyName = 'lblDescrizione'
      Caption = 'Descrizione'
      RawText = False
      Enabled = True
    end
    object dedtDescrizione: TmeIWDBEdit
      Left = 183
      Top = 92
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width50chr'
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
    object LblIndennitaKmNelComune: TmeIWLabel
      Left = 44
      Top = 124
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
      FriendlyName = 'LblIndennitaKmNelComune'
      Caption = 'Importo indennita Km'
      RawText = False
      Enabled = True
    end
    object dedtImporto: TmeIWDBEdit
      Left = 183
      Top = 119
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'input_num_generic_3_dec  width5chr'
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
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'dedtImporto'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 2
      AutoEditable = True
      DataField = 'IMPORTO'
      PasswordPrompt = False
    end
    object dLblValuta: TmeIWDBLabel
      Left = 315
      Top = 124
      Width = 66
      Height = 16
      Cursor = crAuto
      Css = 'intestazione spazio_sx '
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
      DataField = 'descvaluta'
      FriendlyName = 'dLblValuta'
    end
    object cmbArrotondamento: TMedpIWMultiColumnComboBox
      Left = 183
      Top = 146
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'medpMultiColumnCombo inline'
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
      FriendlyName = 'cmbArrotondamento'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 3
      OnAsyncChange = cmbArrotondamentoAsyncChange
      PopUpHeight = 15
      Text = ''
      ColCount = 3
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object dLblArrImportiKmNelComune: TmeIWDBLabel
      Left = 315
      Top = 148
      Width = 129
      Height = 16
      Cursor = crAuto
      Css = 'descrizione spazio_sx '
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
      DataField = 'descarrotondamento'
      FriendlyName = 'dLblArrImportiKmNelComune'
    end
    object lblCodiceVocePaghe: TmeIWLabel
      Left = 56
      Top = 177
      Width = 123
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
      FriendlyName = 'lblCodiceVocePaghe'
      Caption = 'Codice voce paghe:'
      RawText = False
      Enabled = True
    end
    object dEdtCodicePaghe: TmeIWDBEdit
      Left = 183
      Top = 172
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width5chr'
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
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'dEdtCodicePaghe'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 4
      AutoEditable = True
      DataField = 'CODVOCEPAGHE'
      PasswordPrompt = False
    end
    object lnkArrImportiKmNelComune: TmeIWLink
      Left = 32
      Top = 154
      Width = 145
      Height = 17
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
      Color = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = [fsUnderline]
      ScriptEvents = <>
      DoSubmitValidation = False
      FriendlyName = 'lnkArrImportiKmNelComune'
      OnClick = lnkArrImportiKmNelComuneClick
      TabOrder = 5
      RawText = False
      Caption = 'Arrot. importo indennit'#224' Km'
      medpDownloadButton = False
    end
    object CmbCategRimborso: TMedpIWMultiColumnComboBox
      Left = 183
      Top = 208
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'medpMultiColumnCombo'
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
      FriendlyName = 'CmbCategRimborso'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 6
      PopUpHeight = 15
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblCategRimborso: TmeIWLabel
      Left = 67
      Top = 213
      Width = 121
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
      FriendlyName = 'Categoria rimborso'
      Caption = 'Categoria rimborso'
      RawText = False
      Enabled = True
    end
  end
end