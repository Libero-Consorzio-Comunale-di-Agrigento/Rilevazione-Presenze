inherited X001FCentriCosto: TX001FCentriCosto
  Width = 652
  Height = 449
  HelpType = htKeyword
  HelpKeyword = 'X001P0'
  Title = '(X001) Gestione Web delle relazioni anagrafiche'
  ExplicitWidth = 652
  ExplicitHeight = 449
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 4
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 8
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 7
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 6
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  object btnEsegui: TmeIWButton [5]
    Left = 318
    Top = 220
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
    Caption = 'Esegui'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsegui'
    ScriptEvents = <>
    TabOrder = 3
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object lblDataStampa: TmeIWLabel [6]
    Left = 35
    Top = 143
    Width = 128
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
    FriendlyName = 'lblDataStampa'
    Caption = 'Periodo visualizzato:'
    RawText = False
    Enabled = True
  end
  object medtDataStampaDa: TmeIWEdit [7]
    Left = 194
    Top = 141
    Width = 84
    Height = 21
    Cursor = crAuto
    Css = 'input_data_dmy'
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'medtDataStampaDa'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 0
    OnAsyncExit = medtDataStampaDaAsyncExit
    PasswordPrompt = False
  end
  object grdStampa: TmeIWGrid [8]
    Left = 35
    Top = 272
    Width = 509
    Height = 145
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
    Caption = 'Struttura centri di costo'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdStampaRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    FriendlyName = 'grdStampa'
    ColumnCount = 1
    RowCount = 2
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object btnCopiaExcel: TmeIWButton [9]
    Left = 200
    Top = 220
    Width = 104
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
    Caption = 'Copia in Excel'
    Enabled = False
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnCopiaExcel'
    ScriptEvents = <
      item
        EventCode.Strings = (
          'ReleaseLock();'
          'GActivateLock = false;'
          'return true;                ')
        Event = 'onClick'
      end>
    TabOrder = 2
    OnClick = btnCopiaExcelClick
    medpDownloadButton = False
  end
  object medtDataStampaA: TmeIWEdit [10]
    Left = 318
    Top = 141
    Width = 84
    Height = 21
    Cursor = crAuto
    Css = 'input_data_dmy'
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'medtDataStampaA'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 1
    OnAsyncExit = medtDataStampaAAsyncExit
    PasswordPrompt = False
  end
  object chkSoloVariazioni: TmeIWCheckBox [11]
    Left = 431
    Top = 141
    Width = 113
    Height = 21
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
    Caption = 'Solo variazioni'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    ScriptEvents = <>
    Style = stNormal
    TabOrder = 9
    Checked = False
    Enabled = False
    FriendlyName = 'chkSoloVariazioni'
  end
  object lblDal: TmeIWLabel [12]
    Left = 169
    Top = 143
    Width = 18
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
    FriendlyName = 'lblDal'
    Caption = 'dal'
    RawText = False
    Enabled = True
  end
  object lblAl: TmeIWLabel [13]
    Left = 293
    Top = 143
    Width = 11
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
    FriendlyName = 'lblAl'
    Caption = 'al'
    RawText = False
    Enabled = True
  end
  object lblOrdinamento: TmeIWLabel [14]
    Left = 35
    Top = 175
    Width = 86
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
    FriendlyName = 'lblOrdinamento'
    Caption = 'Ordinamento:'
    RawText = False
    Enabled = True
  end
  object rgpOrdinamento: TmeIWRadioGroup [15]
    Left = 169
    Top = 175
    Width = 255
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
    SubmitOnAsyncEvent = True
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpOrdinamento'
    ItemIndex = 0
    Items.Strings = (
      'per Codici/Descrizioni'
      'per Decorrenza')
    Layout = glHorizontal
    ScriptEvents = <>
    TabOrder = 10
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'X001FCentriCosto.html'
  end
end
