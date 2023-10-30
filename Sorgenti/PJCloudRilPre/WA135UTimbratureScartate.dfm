inherited WA135FTimbratureScartate: TWA135FTimbratureScartate
  Tag = 189
  Title = '(WA135) Timbrature scartate'
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 83
    Top = 191
    ExplicitLeft = 83
    ExplicitTop = 191
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 59
    Top = 222
    ExplicitLeft = 59
    ExplicitTop = 222
  end
  inherited btnShowElabError: TmeIWButton
    Left = 83
    Top = 160
    ExplicitLeft = 83
    ExplicitTop = 160
  end
  inherited grdNavigatorBar: TmeIWGrid
    Left = 59
    Top = 131
    ExplicitLeft = 59
    ExplicitTop = 131
  end
  inherited grdTabControl: TmedpIWTabControl
    Left = 59
    Top = 60
    ExplicitLeft = 59
    ExplicitTop = 60
  end
  inherited grdToolBarStorico: TmeIWGrid
    Left = 59
    Top = 99
    ExplicitLeft = 59
    ExplicitTop = 99
  end
  inherited grdDetailTabControl: TmedpIWTabControl
    Left = 59
    Top = 253
    Width = 329
    Height = 28
    ExplicitLeft = 59
    ExplicitTop = 253
    ExplicitWidth = 329
    ExplicitHeight = 28
  end
  object lblMese: TmeIWLabel [15]
    Left = 33
    Top = 320
    Width = 33
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
    FriendlyName = 'lblMese'
    Caption = 'Mese'
    RawText = False
    Enabled = True
  end
  object lblAnno: TmeIWLabel [16]
    Left = 161
    Top = 320
    Width = 31
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
    FriendlyName = 'lblAnno'
    Caption = 'Anno'
    RawText = False
    Enabled = True
  end
  object edtMese: TmeIWEdit [17]
    Left = 72
    Top = 320
    Width = 41
    Height = 21
    Cursor = crAuto
    Css = 'input_num_nn width2chr'
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
  end
  object edtAnno: TmeIWEdit [18]
    Left = 198
    Top = 320
    Width = 41
    Height = 21
    Cursor = crAuto
    Css = 'input_num_nnnn width3chr'
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
    FriendlyName = 'edtAnno'
    MaxLength = 0
    ReadOnly = False
    Required = False
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtMeseAsyncChange
    PasswordPrompt = False
  end
  inherited actlstNavigatorBar: TActionList
    Left = 416
    Top = 192
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actNuovo: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
  end
end
