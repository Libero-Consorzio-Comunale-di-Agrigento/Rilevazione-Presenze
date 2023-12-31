inherited WA170FGestioneGruppi: TWA170FGestioneGruppi
  Tag = 204
  Height = 632
  ExplicitHeight = 632
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 134
    ExplicitTop = 134
  end
  inherited btnShowElabError: TmeIWButton
    Top = 103
    ExplicitTop = 103
  end
  object grdTabDetail: TmedpIWTabControl [7]
    Left = 16
    Top = 165
    Width = 313
    Height = 25
    Cursor = crAuto
    Css = 'gridTabControl'
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
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdTabDetail'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
    OnTabControlChange = grdTabDetailTabControlChange
  end
  object btnEsegui: TmedpIWImageButton [8]
    Left = 18
    Top = 600
    Width = 183
    Height = 29
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.Filename = 'img\btnSalva.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnAnomalie: TmedpIWImageButton [9]
    Left = 241
    Top = 599
    Width = 183
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
    OnClick = btnAnomalieClick
    Cacheable = True
    FriendlyName = 'btnAnomalie'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object WA170PesatureRG: TmeIWRegion [10]
    Left = 16
    Top = 196
    Width = 537
    Height = 176
    Cursor = crAuto
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clNone
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = TemplatePesatureRG
    ZIndex = 1000
    Splitter = False
    object chkChiusuraPesature: TmeIWCheckBox
      Left = 24
      Top = 24
      Width = 121
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
      Caption = 'Chiusura gruppi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 6
      OnAsyncClick = chkChiusuraPesatureAsyncClick
      Checked = False
      FriendlyName = 'chkChiusuraPesature'
    end
    object chkAperturaPesature: TmeIWCheckBox
      Left = 24
      Top = 51
      Width = 201
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
      Caption = 'Ri-apertura gruppi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 7
      OnAsyncClick = chkAperturaPesatureAsyncClick
      Checked = False
      FriendlyName = 'chkAperturaPesature'
    end
    object chkAggiornaPesature: TmeIWCheckBox
      Left = 24
      Top = 78
      Width = 161
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
      Caption = 'Aggiornamento gruppi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 8
      OnAsyncClick = chkAggiornaPesatureAsyncClick
      Checked = False
      FriendlyName = 'chkAggiornaPesature'
    end
    object lblAnnoPesature: TmeIWLabel
      Left = 200
      Top = 29
      Width = 116
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
      FriendlyName = 'lblAnnoPesature'
      Caption = 'Anno elaborazione'
      RawText = False
      Enabled = True
    end
    object edtAnnoPesature: TmeIWEdit
      Left = 310
      Top = 24
      Width = 73
      Height = 21
      Cursor = crAuto
      Css = 'input_num_nnnn width5chr'
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
      FriendlyName = 'edtAnnoPesature'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 9
      OnAsyncChange = edtAnnoPesatureAsyncChange
      PasswordPrompt = False
      Text = 'edtAnnoPesature'
    end
    object lblQuotaPesature: TmeIWLabel
      Left = 200
      Top = 51
      Width = 96
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
      FriendlyName = 'lblQuotaPesature'
      Caption = 'Tipologia quota'
      RawText = False
      Enabled = True
    end
    object lblGruppiPesature: TmeIWLabel
      Left = 200
      Top = 80
      Width = 100
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
      FriendlyName = 'lblGruppiPesature'
      Caption = 'Gruppi pesature'
      RawText = False
      Enabled = True
    end
    object cmbQuotaPesature: TMedpIWMultiColumnComboBox
      Left = 302
      Top = 51
      Width = 91
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
      FriendlyName = 'cmbQuotaPesature'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 10
      OnAsyncChange = cmbQuotaPesatureAsyncChange
      PopUpHeight = 15
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescQuotaPesature: TmeIWLabel
      Left = 399
      Top = 56
      Width = 136
      Height = 16
      Cursor = crAuto
      Css = 'descrizione'
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
      FriendlyName = 'lblDescQuotaPesature'
      Caption = 'lblDescQuotaPesature'
      RawText = False
      Enabled = True
    end
    object edtGruppiPesature: TmeIWEdit
      Left = 306
      Top = 78
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width30chr'
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
      FriendlyName = 'edtGruppiPesature'
      MaxLength = 0
      ReadOnly = True
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 11
      PasswordPrompt = False
      Text = 'edtGruppiPesature'
    end
    object btnGruppiPesature: TmeIWButton
      Left = 433
      Top = 78
      Width = 40
      Height = 25
      Cursor = crAuto
      Css = 'pulsante puntini'
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
      Caption = '...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnGruppiPesature'
      ScriptEvents = <>
      TabOrder = 12
      OnClick = btnGruppiPesatureClick
      medpDownloadButton = False
    end
  end
  object WA170SchedeRG: TmeIWRegion [11]
    Left = 14
    Top = 378
    Width = 537
    Height = 199
    Cursor = crAuto
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clNone
    ParentShowHint = False
    ShowHint = True
    LayoutMgr = TemplateSchedeRG
    ZIndex = 1000
    Splitter = False
    object chkChiusuraSchede: TmeIWCheckBox
      Left = 24
      Top = 24
      Width = 121
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
      Caption = 'Chiusura gruppi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 13
      OnAsyncClick = chkChiusuraSchedeAsyncClick
      Checked = False
      FriendlyName = 'chkChiusuraPesature'
    end
    object chkAperturaSchede: TmeIWCheckBox
      Left = 24
      Top = 51
      Width = 201
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
      Caption = 'Ri-apertura gruppi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 14
      OnAsyncClick = chkAperturaSchedeAsyncClick
      Checked = False
      FriendlyName = 'chkAperturaPesature'
    end
    object chkAggiornaSchede: TmeIWCheckBox
      Left = 24
      Top = 78
      Width = 161
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
      Caption = 'Aggiornamento gruppi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 15
      OnAsyncClick = chkAggiornaSchedeAsyncClick
      Checked = False
      FriendlyName = 'chkAggiornaPesature'
    end
    object lblAnnoSchede: TmeIWLabel
      Left = 200
      Top = 24
      Width = 116
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
      FriendlyName = 'lblAnnoPesature'
      Caption = 'Anno elaborazione'
      RawText = False
      Enabled = True
    end
    object edtAnnoSchede: TmeIWEdit
      Left = 322
      Top = 24
      Width = 73
      Height = 21
      Cursor = crAuto
      Css = 'input_num_nnnn width5chr'
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
      FriendlyName = 'edtAnnoSchede'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 16
      OnAsyncChange = edtAnnoSchedeAsyncChange
      PasswordPrompt = False
      Text = 'edtAnnoSchede'
    end
    object lblQuotaSchede: TmeIWLabel
      Left = 200
      Top = 51
      Width = 96
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
      FriendlyName = 'lblQuotaPesature'
      Caption = 'Tipologia quota'
      RawText = False
      Enabled = True
    end
    object cmbQuotaSchede: TMedpIWMultiColumnComboBox
      Left = 319
      Top = 51
      Width = 91
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
      FriendlyName = 'cmbQuotaPesature'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 17
      OnAsyncChange = cmbQuotaSchedeAsyncChange
      PopUpHeight = 15
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescQuotaSchede: TmeIWLabel
      Left = 419
      Top = 56
      Width = 127
      Height = 16
      Cursor = crAuto
      Css = 'descrizione'
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
      FriendlyName = 'lblDescQuotaSchede'
      Caption = 'lblDescQuotaSchede'
      RawText = False
      Enabled = True
    end
    object lblGruppiSchede: TmeIWLabel
      Left = 200
      Top = 78
      Width = 89
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
      FriendlyName = 'lblGruppiPesature'
      Caption = 'Gruppi schede'
      RawText = False
      Enabled = True
    end
    object edtGruppiSchede: TmeIWEdit
      Left = 322
      Top = 78
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width30chr'
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
      FriendlyName = 'edtGruppiPesature'
      MaxLength = 0
      ReadOnly = True
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 18
      PasswordPrompt = False
      Text = 'edtGruppiSchede'
    end
    object btnGruppiSchede: TmeIWButton
      Left = 449
      Top = 78
      Width = 40
      Height = 25
      Cursor = crAuto
      Css = 'pulsante puntini'
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
      Caption = '...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnGruppiPesature'
      ScriptEvents = <>
      TabOrder = 19
      OnClick = btnGruppiSchedeClick
      medpDownloadButton = False
    end
    object chkPassaggioAnnoSchede: TmeIWCheckBox
      Left = 24
      Top = 105
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
      Caption = 'Ribaltamento su nuovo anno'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 20
      OnAsyncClick = chkPassaggioAnnoSchedeAsyncClick
      Checked = False
      FriendlyName = 'chkPassaggioAnnoSchede'
    end
    object lblDataRifSchede: TmeIWLabel
      Left = 200
      Top = 105
      Width = 117
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
      FriendlyName = 'lblDataRifSchede'
      Caption = 'Data di riferimento'
      RawText = False
      Enabled = True
    end
    object edtDataRifSchede: TmeIWEdit
      Left = 322
      Top = 105
      Width = 88
      Height = 21
      Cursor = crAuto
      Css = 'input_data_dmy width5chr'
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
      FriendlyName = 'edtDataRifSchede'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 21
      PasswordPrompt = False
      Text = 'edtDataRifSchede'
    end
    object grdPagamenti: TmeIWGrid
      Left = 26
      Top = 161
      Width = 300
      Height = 35
      Cursor = crAuto
      Css = 'grid'
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
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'grdPagamenti'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlNone
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      FriendlyName = 'grdPagamenti'
      ColumnCount = 1
      RowCount = 0
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object lblPagamenti: TmeIWLabel
      Left = 26
      Top = 132
      Width = 308
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
      FriendlyName = 'lblPagamenti'
      Caption = 'Pagamenti da effettuare sul mese di competenza'
      RawText = False
      Enabled = True
    end
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 600
    Top = 8
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 600
    Top = 64
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 600
    Top = 320
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 600
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 600
    Top = 184
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 600
    Top = 248
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 433
    Top = 8
  end
  object TemplatePesatureRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA170PesatureRG.html'
    RenderStyles = True
    Left = 480
    Top = 200
  end
  object TemplateSchedeRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA170SchedeRG.html'
    RenderStyles = True
    Left = 496
    Top = 392
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 424
    Top = 104
  end
end
