inherited WR101FLogin: TWR101FLogin
  Width = 702
  Height = 434
  HelpType = htKeyword
  Title = '(WR101) Login'
  ActiveControl = edtAzienda
  LockUntilLoaded = False
  LockOnSubmit = False
  ExplicitWidth = 702
  ExplicitHeight = 434
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 12
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 13
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 11
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 96
    ExplicitTop = 96
  end
  object edtAzienda: TmeIWEdit [9]
    Left = 297
    Top = 236
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Azienda'
    SubmitOnAsyncEvent = True
    TabOrder = 0
    OnSubmit = edtAziendaSubmit
  end
  object edtUtente: TmeIWEdit [10]
    Left = 297
    Top = 264
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Utente'
    SubmitOnAsyncEvent = True
    TabOrder = 1
    OnSubmit = edtAziendaSubmit
  end
  object edtPassword: TmeIWEdit [11]
    Left = 297
    Top = 291
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Password'
    SubmitOnAsyncEvent = True
    TabOrder = 2
    OnSubmit = edtAziendaSubmit
    PasswordPrompt = True
  end
  object edtDatabase: TmeIWEdit [12]
    Left = 297
    Top = 344
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Database'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnSubmit = edtAziendaSubmit
  end
  object lblAzienda: TmeIWLabel [13]
    Left = 229
    Top = 239
    Width = 51
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    ForControl = edtAzienda
    HasTabOrder = False
    FriendlyName = 'lblAzienda'
    Caption = 'Azienda'
    Enabled = True
  end
  object lblUtente: TmeIWLabel [14]
    Left = 229
    Top = 268
    Width = 41
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    ForControl = edtUtente
    HasTabOrder = False
    FriendlyName = 'lblUtente'
    Caption = 'Utente'
    Enabled = True
  end
  object lblPassword: TmeIWLabel [15]
    Left = 229
    Top = 292
    Width = 62
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    ForControl = edtPassword
    HasTabOrder = False
    FriendlyName = 'lblPassword'
    Caption = 'Password'
    Enabled = True
  end
  object lblDatabase: TmeIWLabel [16]
    Left = 229
    Top = 348
    Width = 60
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'TimesNewRoman'
    Font.Size = 10
    Font.Style = []
    ForControl = edtDatabase
    HasTabOrder = False
    FriendlyName = 'lblDatabase'
    Caption = 'Database'
    Enabled = True
  end
  object lnkAccedi: TmeIWLink [17]
    Left = 353
    Top = 375
    Width = 65
    Height = 17
    Css = 'link'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkAccedi'
    OnClick = lnkAccediClick
    TabOrder = 10
    RawText = False
    Caption = 'Accedi'
    medpDownloadButton = False
  end
  object cmbNomeProfilo: TmeIWComboBox [18]
    Left = 424
    Top = 317
    Width = 121
    Height = 21
    Visible = False
    Css = 'select15'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    UseSize = False
    TabOrder = 8
    ItemIndex = -1
    Sorted = True
    FriendlyName = 'cmbNomeProfilo'
    NoSelectionText = '-- No Selection --'
  end
  object lblNomeProfilo: TmeIWLabel [19]
    Left = 229
    Top = 322
    Width = 39
    Height = 16
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    ForControl = edtNomeProfilo
    HasTabOrder = False
    FriendlyName = 'lblNomeProfilo'
    Caption = 'Profilo'
    Enabled = True
  end
  object edtNomeProfilo: TmeIWEdit [20]
    Left = 297
    Top = 318
    Width = 121
    Height = 21
    Css = 'width20chr spazio_sx'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtNomeProfilo'
    SubmitOnAsyncEvent = True
    TabOrder = 5
    OnSubmit = edtAziendaSubmit
  end
  object btnAccedi: TmeIWButton [21]
    Left = 353
    Top = 398
    Width = 75
    Height = 25
    ExtraTagParams.Strings = (
      'style=width:98%')
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Accedi'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnAccedi'
    TabOrder = 14
    OnClick = lnkAccediClick
    medpDownloadButton = False
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WR101FLogin.html'
  end
  object xmlDoc: TXMLDocument
    Left = 448
    Top = 120
    DOMVendorDesc = 'MSXML'
  end
end
