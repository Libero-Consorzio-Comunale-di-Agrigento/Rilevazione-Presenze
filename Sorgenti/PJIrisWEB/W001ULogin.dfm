inherited W001FLogin: TW001FLogin
  Width = 694
  Height = 365
  HelpType = htKeyword
  Title = '(W001) Login'
  OnRefreshForm = IWAppFormRefreshForm
  LockUntilLoaded = False
  LockOnSubmit = False
  ExplicitWidth = 694
  ExplicitHeight = 365
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 6
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 0
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 1
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 2
  end
  object lblAzienda: TmeIWLabel [8]
    Left = 144
    Top = 127
    Width = 49
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
    ForControl = edtAzienda
    HasTabOrder = False
    FriendlyName = 'lblAzienda'
    Caption = 'Azienda'
    Enabled = True
  end
  object lblUtente: TmeIWLabel [9]
    Left = 144
    Top = 155
    Width = 40
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
    ForControl = edtUtente
    HasTabOrder = False
    FriendlyName = 'lblUtente'
    Caption = 'Utente'
    Enabled = True
  end
  object lblPassword: TmeIWLabel [10]
    Left = 144
    Top = 183
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
    Font.Size = 10
    Font.Style = []
    ForControl = edtPassword
    HasTabOrder = False
    FriendlyName = 'lblPassword'
    Caption = 'Password'
    Enabled = True
  end
  object lblNomeProfilo: TmeIWLabel [11]
    Left = 145
    Top = 211
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
  object lblDatabase: TmeIWLabel [12]
    Left = 144
    Top = 240
    Width = 58
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
    ForControl = edtDatabase
    HasTabOrder = False
    FriendlyName = 'lblDatabase'
    Caption = 'Database'
    Enabled = True
  end
  object edtAzienda: TmeIWEdit [13]
    Left = 222
    Top = 127
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Azienda'
    MaxLength = 30
    SubmitOnAsyncEvent = True
    TabOrder = 3
    OnSubmit = edtAziendaSubmit
  end
  object edtUtente: TmeIWEdit [14]
    Left = 222
    Top = 154
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Utente'
    MaxLength = 40
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnSubmit = edtAziendaSubmit
  end
  object edtPassword: TmeIWEdit [15]
    Left = 222
    Top = 181
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Password'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnSubmit = edtAziendaSubmit
    PasswordPrompt = True
  end
  object edtDatabase: TmeIWEdit [16]
    Left = 222
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Database'
    SubmitOnAsyncEvent = True
    TabOrder = 11
    OnSubmit = edtAziendaSubmit
  end
  object cmbNomeProfilo: TmeIWComboBox [17]
    Left = 355
    Top = 208
    Width = 121
    Height = 21
    Visible = False
    Css = 'width20chr'
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
    ScriptEvents = <
      item
        EventCode.Strings = (
          'if (event.keyCode == 13) {'
          '  SubmitClick("LNKACCEDI", "", true);'
          '  return true;'
          '}')
        Event = 'onKeyPress'
      end>
    UseSize = False
    TabOrder = 10
    ItemIndex = -1
    FriendlyName = 'Profilo'
    NoSelectionText = '-- No Selection --'
  end
  object edtNomeProfilo: TmeIWEdit [18]
    Left = 222
    Top = 208
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'Profilo'
    MaxLength = 30
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnSubmit = edtAziendaSubmit
  end
  object lnkAccedi: TmeIWLink [19]
    Left = 303
    Top = 300
    Width = 40
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
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'Accedi'
    OnClick = lnkAccediClick
    TabOrder = 12
    RawText = False
    Caption = 'Accedi'
    medpDownloadButton = False
  end
  object lnkRecuperaPassword: TmeIWLink [20]
    Left = 222
    Top = 323
    Width = 118
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
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkRecuperaPassword'
    OnClick = lnkRecuperaPasswordClick
    TabOrder = 13
    RawText = False
    Caption = 'Recupera password'
    medpDownloadButton = False
  end
  object btnAccedi: TmeIWButton [21]
    Left = 349
    Top = 292
    Width = 128
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
  object lblReCAPTCHA: TmeIWLabel [22]
    Left = 222
    Top = 270
    Width = 91
    Height = 16
    Visible = False
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
    HasTabOrder = False
    FriendlyName = 'lblReCAPTCHA'
    Caption = 'lblReCAPTCHA'
    RawText = True
    Enabled = True
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 539
    Top = 160
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 591
    Top = 160
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 544
    Top = 216
  end
end
