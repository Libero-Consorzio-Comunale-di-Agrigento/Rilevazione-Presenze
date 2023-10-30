inherited WA103FScaricoGiust: TWA103FScaricoGiust
  Tag = 160
  Width = 599
  Height = 424
  Title = '(WA103) Acquisizione giustificativi'
  ExplicitWidth = 599
  ExplicitHeight = 424
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 88
    Top = 60
    ExplicitLeft = 88
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 88
    Top = 91
    ExplicitLeft = 88
    ExplicitTop = 91
  end
  inherited btnSendFile: TmeIWButton
    Left = 88
    Top = 122
    ExplicitLeft = 88
    ExplicitTop = 122
  end
  object cmbScarico: TmeIWComboBox [7]
    Left = 28
    Top = 193
    Width = 121
    Height = 21
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
    BGColor = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = '  '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 6
    ItemIndex = -1
    Sorted = False
    FriendlyName = 'cmbScarico'
  end
  object chkScarichiAuto: TmeIWCheckBox [8]
    Left = 28
    Top = 233
    Width = 189
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
    Caption = 'Tutti gli scarichi automatici'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    ScriptEvents = <>
    Style = stNormal
    TabOrder = 7
    Checked = False
    FriendlyName = 'chkScarichiAuto'
  end
  object btnScarico: TmedpIWImageButton [9]
    Left = 28
    Top = 280
    Width = 85
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
    BorderOptions.Color = clNone
    BorderOptions.Width = 0
    ScriptEvents = <>
    TabOrder = -1
    UseSize = False
    OnClick = btnScaricoClick
    Cacheable = True
    FriendlyName = 'btnScarico'
    ImageFile.Filename = 'img/btnScarico.png'
    medpDownloadButton = False
    Caption = 'Inizia Acquisizione'
  end
  object btnLogAcquisizione: TmedpIWImageButton [10]
    Left = 132
    Top = 280
    Width = 85
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
    BorderOptions.Color = clNone
    BorderOptions.Width = 0
    ScriptEvents = <>
    TabOrder = -1
    UseSize = False
    OnClick = btnLogAcquisizioneClick
    Cacheable = True
    FriendlyName = 'btnLogAcquisizione'
    ImageFile.Filename = 'img/btnVisualizzaFile.png'
    medpDownloadButton = False
    Caption = 'Log Acquisizione'
  end
  object lnkScarico: TmeIWLink [11]
    Left = 35
    Top = 170
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
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    ScriptEvents = <>
    DoSubmitValidation = False
    FriendlyName = 'lnkScarico'
    OnClick = lnkScaricoClick
    TabOrder = 8
    RawText = False
    Caption = 'Scarico:'
    medpDownloadButton = False
  end
end
