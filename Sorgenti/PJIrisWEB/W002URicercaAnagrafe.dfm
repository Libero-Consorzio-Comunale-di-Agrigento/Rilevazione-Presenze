inherited W002FRicercaAnagrafe: TW002FRicercaAnagrafe
  Tag = -1
  Width = 535
  Height = 436
  HelpType = htKeyword
  HelpKeyword = 'W002P0'
  Title = '(W002) Ricerca anagrafe'
  ExplicitWidth = 535
  ExplicitHeight = 436
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 6
  end
  object rgpTipoRicerca: TmeIWRadioGroup [8]
    Left = 31
    Top = 230
    Width = 270
    Height = 25
    Cursor = crDefault
    Css = 'intestazione'
    ParentShowHint = False
    ShowHint = False
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    OnClick = rgpTipoRicercaClick
    SubmitOnAsyncEvent = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpTipoRicerca'
    ItemIndex = 0
    Items.Strings = (
      'Ricerca semplice'
      'Ricerca avanzata'
      'SQL')
    Layout = glHorizontal
    ScriptEvents = <>
    TabOrder = 4
  end
  object lnkRicercaSalvata: TmeIWLink [9]
    Left = 164
    Top = 156
    Width = 121
    Height = 17
    Cursor = crAuto
    Css = 'link'
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
    FriendlyName = 'lnkRicercaSalvata'
    OnClick = btnRicercaTopClick
    TabOrder = 7
    RawText = False
    Caption = 'Selezione salvata:'
    medpDownloadButton = False
  end
  object cmbSelezioni: TmeIWComboBox [10]
    Left = 283
    Top = 156
    Width = 121
    Height = 21
    Cursor = crAuto
    Css = 'input20'
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
    BGColor = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = '-- No Selection --'
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 8
    ItemIndex = -1
    Sorted = False
    FriendlyName = 'cmbSelezioni'
  end
  object lnkSQLSalvato: TmeIWLink [11]
    Left = 410
    Top = 157
    Width = 103
    Height = 18
    Cursor = crAuto
    Css = 'link'
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
    FriendlyName = 'lnkSQLSalvato'
    OnClick = rgpTipoRicercaClick
    TabOrder = 9
    RawText = False
    Caption = 'Visualizza SQL'
    medpDownloadButton = False
  end
  object lnkRicerca1: TmeIWLink [12]
    Left = 32
    Top = 261
    Width = 121
    Height = 17
    Cursor = crAuto
    Css = 'link'
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
    FriendlyName = 'lnkRicerca1'
    OnClick = btnRicercaTopClick
    TabOrder = 10
    RawText = False
    Caption = 'Avvia ricerca'
    medpDownloadButton = False
  end
  object lnkRicerca2: TmeIWLink [13]
    Left = 410
    Top = 262
    Width = 93
    Height = 17
    Cursor = crAuto
    Css = 'link'
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
    FriendlyName = 'lnkRicerca2'
    OnClick = btnRicercaTopClick
    TabOrder = 11
    RawText = False
    Caption = 'Avvia ricerca'
    medpDownloadButton = False
  end
  object lnkRicerca3: TmeIWLink [14]
    Left = 32
    Top = 397
    Width = 91
    Height = 17
    Cursor = crAuto
    Css = 'link'
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
    FriendlyName = 'lnkRicerca3'
    OnClick = btnRicercaTopClick
    TabOrder = 12
    RawText = False
    Caption = 'Avvia ricerca'
    medpDownloadButton = False
  end
  object lnkRicerca4: TmeIWLink [15]
    Left = 410
    Top = 398
    Width = 81
    Height = 17
    Cursor = crAuto
    Css = 'link'
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
    FriendlyName = 'lnkRicerca4'
    OnClick = btnRicercaTopClick
    TabOrder = 13
    RawText = False
    Caption = 'Avvia ricerca'
    medpDownloadButton = False
  end
  object grdRicerca: TmeIWGrid [16]
    Left = 31
    Top = 284
    Width = 223
    Height = 107
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
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    OnRenderCell = grdRicercaRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdRicerca'
    ColumnCount = 5
    OnCellClick = grdRicercaCellClick
    RowCount = 0
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object memoSQL: TmeIWMemo [17]
    Left = 283
    Top = 285
    Width = 208
    Height = 107
    Cursor = crAuto
    Visible = False
    Css = 'textarea_sql'
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
    BGColor = clNone
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    ScriptEvents = <>
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 14
    SubmitOnAsyncEvent = True
    FriendlyName = 'memoSQL'
  end
end