inherited WR104FGestCartellino: TWR104FGestCartellino
  Width = 595
  Height = 573
  ExplicitWidth = 595
  ExplicitHeight = 573
  DesignLeft = 8
  DesignTop = 8
  object grdComandi: TmeIWGrid [7]
    Left = 24
    Top = 238
    Width = 300
    Height = 23
    Cursor = crAuto
    Css = 'medpToolBar medpNoMarginLeft'
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
    Caption = 'grdComandi'
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
    FriendlyName = 'grdComandi'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object edtMese: TmeIWEdit [8]
    Left = 82
    Top = 283
    Width = 81
    Height = 21
    Cursor = crAuto
    Hint = 'Mese del cartellino'
    Css = 'input_data_my width5chr '
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
    FriendlyName = 'edtMese'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnAsyncChange = edtMeseAsyncChange
    PasswordPrompt = False
    Text = 'edtMese'
  end
  object lblCartellinoCaption: TmeIWLabel [9]
    Left = 40
    Top = 310
    Width = 154
    Height = 16
    Cursor = crAuto
    Css = 'tblCaption'
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
    FriendlyName = 'lblCartellinoCaption'
    Caption = 'Cartellino del mese di ...'
    RawText = False
    Enabled = True
  end
  object lnkLegenda: TmeIWLink [10]
    Left = 24
    Top = 267
    Width = 65
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
    FriendlyName = 'lnkLegenda'
    OnClick = lnkLegendaClick
    TabOrder = 7
    RawText = False
    Caption = 'Legenda'
    medpDownloadButton = False
  end
  object grdCartellino: TmeIWGrid [11]
    Left = 16
    Top = 332
    Width = 300
    Height = 88
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
    Caption = 'grdCartellino'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    OnRenderCell = grdCartellinoRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdCartellino'
    ColumnCount = 1
    RowCount = 0
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object btnModificaTimb: TmeIWButton [12]
    Left = 344
    Top = 347
    Width = 75
    Height = 25
    Cursor = crAuto
    HelpType = htKeyword
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
    Caption = 'Modifica timbratura'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnModificaTimb'
    ScriptEvents = <>
    TabOrder = 8
    OnClick = btnModificaTimbClick
    medpDownloadButton = False
  end
  object btnNuovaTimb: TmeIWButton [13]
    Left = 344
    Top = 378
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
    Caption = 'Nuova timbratura'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnNuovaTimb'
    ScriptEvents = <>
    TabOrder = 9
    OnClick = btnNuovaTimbClick
    medpDownloadButton = False
  end
  object btnModificaGiust: TmeIWButton [14]
    Left = 344
    Top = 409
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
    Caption = 'Modifica Giust'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnModificaGiust'
    ScriptEvents = <>
    TabOrder = 10
    OnClick = btnModificaGiustClick
    medpDownloadButton = False
  end
  object btnNuovoGiust: TmeIWButton [15]
    Left = 344
    Top = 440
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
    Caption = 'Nuovo giust'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnNuovoGiust'
    ScriptEvents = <>
    TabOrder = 11
    OnClick = btnNuovoGiustClick
    medpDownloadButton = False
  end
  object btnVisualizza: TmeIWButton [16]
    Left = 344
    Top = 316
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
    Caption = 'Visualizza'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisualizza'
    ScriptEvents = <>
    TabOrder = 12
    OnClick = btnVisualizzaClick
    medpDownloadButton = False
  end
  object actLstComandi: TActionList
    Left = 352
    Top = 192
    object actMesePrec: TAction
      Category = 'selMese'
      Caption = 'btnPrecedente'
      Hint = 'Mese precedente'
      OnExecute = actMesePrecExecute
    end
    object actMese: TAction
      Category = 'selMese'
      Caption = 'actMese'
    end
    object actMeseSucc: TAction
      Category = 'selMese'
      Caption = 'btnSuccessivo'
      Hint = 'Mese successivo'
      OnExecute = actMeseSuccExecute
    end
    object actConteggi: TAction
      Category = 'conteggi'
      Caption = 'btnCalcolatrice'
      Hint = 'Conteggi off'
      OnExecute = actConteggiExecute
    end
    object actAnomalie: TAction
      Category = 'comandi'
      Caption = 'btnSveglia'
      Hint = 'Visualizzazione anomalie'
      OnExecute = actAnomalieExecute
    end
  end
  object pmnNuovaTimbratura: TPopupMenu
    Left = 344
    Top = 152
  end
  object pmnTimbratura: TPopupMenu
    Left = 256
    Top = 160
  end
  object pmnNuovoGiustificativo: TPopupMenu
    Left = 56
    Top = 160
  end
  object pmnGiustificativo: TPopupMenu
    Left = 160
    Top = 160
  end
end
