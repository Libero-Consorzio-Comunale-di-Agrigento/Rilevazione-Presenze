inherited WA011FEntiLocali: TWA011FEntiLocali
  Tag = 530
  Width = 742
  Height = 432
  Title = '(WA011) Enti locali'
  ExplicitWidth = 742
  ExplicitHeight = 432
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 8
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited btnShowElabError: TmeIWButton
    TabOrder = 5
  end
  object lblElenco: TmeIWLabel [15]
    Left = 17
    Top = 328
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
    FriendlyName = 'lblElenco'
    Caption = 'Elenco'
    RawText = False
    Enabled = True
  end
  object cmbElenco: TmeIWComboBox [16]
    Left = 91
    Top = 323
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
    StyleRenderOptions.RenderPadding = False
    BGColor = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FocusColor = clNone
    AutoHideOnMenuActivation = False
    ItemsHaveValues = False
    NoSelectionText = ' '
    Required = False
    RequireSelection = True
    ScriptEvents = <>
    OnChange = cmbElencoChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 4
    ItemIndex = -1
    Items.Strings = (
      'COMUNI'
      'PROVINCE'
      'REGIONI'
      'NAZIONI')
    Sorted = False
    FriendlyName = 'cmbElenco'
  end
  object rgpTipoSelezione: TmeTIWAdvRadioGroup [17]
    Left = 274
    Top = 323
    Width = 265
    Height = 30
    Cursor = crAuto
    Css = 'groupbox'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = 'Tipo selezione'
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 2
    Editable = True
    FriendlyName = 'rgpTipoSelezione'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Solo comuni nascita / residenza'
      'Tutti i comuni')
    ItemIndex = 0
    ScriptEvents = <>
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnClick = rgpTipoSelezioneClick
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 215
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
end
