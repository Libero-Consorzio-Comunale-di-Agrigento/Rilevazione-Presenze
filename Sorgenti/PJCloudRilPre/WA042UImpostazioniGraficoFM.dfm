inherited WA042FImpostazioniGraficoFM: TWA042FImpostazioniGraficoFM
  Width = 458
  Height = 380
  ExplicitWidth = 458
  ExplicitHeight = 380
  inherited IWFrameRegion: TIWRegion
    Width = 458
    Height = 380
    ExplicitWidth = 458
    ExplicitHeight = 380
    object lblCausPresenza: TmeIWLabel
      Left = 45
      Top = 102
      Width = 49
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
      FriendlyName = 'lblCausPresenza'
      Caption = 'Causale'
      RawText = False
      Enabled = True
    end
    object cmbPresenza: TMedpIWMultiColumnComboBox
      Left = 97
      Top = 97
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
      FriendlyName = 'cmbPresenza'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 0
      PopUpHeight = 15
      Text = ''
      ColCount = 1
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbPresenzaChange
      medpAutoResetItems = True
      CssInputText = 'width10chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescrPresenza: TmeIWLabel
      Left = 100
      Top = 124
      Width = 0
      Height = 0
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
      FriendlyName = 'lblDescrPresenza'
      RawText = False
      Enabled = True
    end
    object lblGrpPresenza: TmeIWLabel
      Left = 45
      Top = 75
      Width = 122
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
      FriendlyName = 'lblGrpPresenza'
      Caption = 'Causali di presenza'
      RawText = False
      Enabled = True
    end
    object lblCausAssenza: TmeIWLabel
      Left = 45
      Top = 206
      Width = 49
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
      FriendlyName = 'lblCausAssenza'
      Caption = 'Causale'
      RawText = False
      Enabled = True
    end
    object cmbAssenza: TMedpIWMultiColumnComboBox
      Left = 97
      Top = 201
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
      FriendlyName = 'cmbAssenza'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 1
      PopUpHeight = 15
      Text = ''
      ColCount = 1
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbAssenzaChange
      medpAutoResetItems = True
      CssInputText = 'width10chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescrAssenza: TmeIWLabel
      Left = 100
      Top = 228
      Width = 0
      Height = 0
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
      FriendlyName = 'lblDescrAssenza'
      RawText = False
      Enabled = True
    end
    object lblGrpAssenza: TmeIWLabel
      Left = 45
      Top = 179
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
      FriendlyName = 'lblGrpAssenza'
      Caption = 'Causali di assenza'
      RawText = False
      Enabled = True
    end
    object ChkCausaliNonAbbinate: TmeIWCheckBox
      Left = 45
      Top = 272
      Width = 404
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
      Caption = 
        'Visualizza nel grafico anche le causali non abbinate ad un color' +
        'e'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 2
      OnAsyncClick = ChkCausaliNonAbbinateAsyncClick
      Checked = False
      FriendlyName = 'ChkCausaliNonAbbinate'
    end
    object BtnSalvaPresenze: TmedpIWImageButton
      Left = 265
      Top = 56
      Width = 96
      Height = 25
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnAsyncClick = BtnSalvaPresenzeAsyncClick
      Cacheable = True
      FriendlyName = 'BtnSalvaPresenze'
      ImageFile.Filename = 'img\btnSalva.png'
      medpDownloadButton = False
      Caption = 'Salva colori'
    end
    object BtnCancellaPresenze: TmedpIWImageButton
      Left = 265
      Top = 87
      Width = 96
      Height = 25
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = BtnCancellaPresenzeClick
      Cacheable = True
      FriendlyName = 'BtnCancellaPresenze'
      ImageFile.Filename = 'img\btnGomma.png'
      medpDownloadButton = False
      Caption = 'Ripulisci colori'
    end
    object BtnImportaPresenze: TmedpIWImageButton
      Left = 265
      Top = 118
      Width = 96
      Height = 25
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = BtnImportaPresenzeClick
      Cacheable = True
      FriendlyName = 'BtnImportaPresenze'
      ImageFile.Filename = 'img\btnImportaColori.png'
      medpDownloadButton = False
      Caption = 'Importa colori'
    end
    object BtnImportaAssenze: TmedpIWImageButton
      Left = 265
      Top = 219
      Width = 96
      Height = 25
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = BtnImportaAssenzeClick
      Cacheable = True
      FriendlyName = 'BtnImportaAssenze'
      ImageFile.Filename = 'img\btnImportaColori.png'
      medpDownloadButton = False
      Caption = 'Importa colori'
    end
    object BtnCancellaAssenze: TmedpIWImageButton
      Left = 265
      Top = 188
      Width = 96
      Height = 25
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = BtnCancellaAssenzeClick
      Cacheable = True
      FriendlyName = 'BtnCancellaAssenze'
      ImageFile.Filename = 'img\btnGomma.png'
      medpDownloadButton = False
      Caption = 'Ripulisci colori'
    end
    object BtnSalvaAssenze: TmedpIWImageButton
      Left = 265
      Top = 157
      Width = 96
      Height = 25
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
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnAsyncClick = BtnSalvaAssenzeAsyncClick
      Cacheable = True
      FriendlyName = 'BtnSalvaAssenze'
      ImageFile.Filename = 'img\btnSalva.png'
      medpDownloadButton = False
      Caption = 'Salva colori'
    end
    object btnChiudi: TmeIWButton
      Left = 354
      Top = 333
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      ScriptEvents = <>
      TabOrder = 3
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object lblColorePresenza: TmeIWLabel
      Left = 45
      Top = 124
      Width = 40
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
      FriendlyName = 'lblColorePresenza'
      Caption = 'Colore'
      RawText = False
      Enabled = True
    end
    object edtColorePresenza: TmeIWEdit
      Left = 100
      Top = 124
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width10chr colorPicker'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
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
      FriendlyName = 'edtColorePresenza'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 4
      OnAsyncChange = edtColorePresenzaAsyncChange
      PasswordPrompt = False
    end
    object edtColoreAssenza: TmeIWEdit
      Left = 100
      Top = 228
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width10chr  colorPicker'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
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
      FriendlyName = 'edtColoreAssenza'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 5
      OnAsyncChange = edtColoreAssenzaAsyncChange
      PasswordPrompt = False
    end
    object lblColoreAssenza: TmeIWLabel
      Left = 45
      Top = 228
      Width = 40
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
      FriendlyName = 'lblColoreAssenza'
      Caption = 'Colore'
      RawText = False
      Enabled = True
    end
  end
end
