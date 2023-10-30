inherited WA005FDatiLiberi: TWA005FDatiLiberi
  Tag = 114
  Width = 742
  Height = 562
  Title = '(WA005) Tabelle dati liberi'
  ExplicitWidth = 742
  ExplicitHeight = 562
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 7
  end
  inherited btnShowElabError: TmeIWButton
    TabOrder = 5
  end
  object lblDatoAnagrafico: TmeIWLabel [15]
    Left = 17
    Top = 328
    Width = 99
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
    FriendlyName = 'lblDatoAnagrafico'
    Caption = 'Dato anagrafico'
    RawText = False
    Enabled = True
  end
  object cmbDatoLibero: TmeIWComboBox [16]
    Left = 122
    Top = 322
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
    OnChange = cmbDatoLiberoChange
    UseSize = False
    Style = stNormal
    ButtonColor = clBtnFace
    Editable = True
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = True
    TabOrder = 4
    ItemIndex = -1
    Sorted = False
    FriendlyName = 'cmbDatoLibero'
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
