inherited WA074FGemeazFM: TWA074FGemeazFM
  Width = 453
  Height = 412
  ExplicitWidth = 453
  ExplicitHeight = 412
  inherited IWFrameRegion: TIWRegion
    Width = 453
    Height = 412
    ExplicitWidth = 453
    ExplicitHeight = 412
    object lblCodCliente: TmeIWLabel
      Left = 24
      Top = 72
      Width = 73
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      ForControl = edtCodCliente
      HasTabOrder = False
      FriendlyName = 'lblCodCliente'
      Caption = 'Cod. cliente'
      RawText = False
    end
    object edtCodCliente: TmeIWEdit
      Left = 151
      Top = 72
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width15chr'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
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
      FriendlyName = 'edtCodCliente'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 0
      PasswordPrompt = False
    end
    object lblValoreBuono: TmeIWLabel
      Left = 24
      Top = 112
      Width = 122
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      ForControl = edtValoreBuono
      HasTabOrder = False
      FriendlyName = 'lblCodCliente'
      Caption = 'Valore buono pasto'
      RawText = False
    end
    object edtValoreBuono: TmeIWEdit
      Left = 152
      Top = 112
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width15chr'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
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
      FriendlyName = 'edtValoreBuono'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 1
      PasswordPrompt = False
    end
    object lblFormatoMatricola: TmeIWLabel
      Left = 24
      Top = 160
      Width = 115
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      ForControl = cmbFormatoMatricola
      HasTabOrder = False
      FriendlyName = 'lblCodCliente'
      Caption = 'Formato matricola'
      RawText = False
    end
    object cmbFormatoMatricola: TmeIWComboBox
      Left = 152
      Top = 155
      Width = 121
      Height = 21
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
      UseSize = False
      Style = stNormal
      ButtonColor = clBtnFace
      Editable = True
      NonEditableAsLabel = True
      SubmitOnAsyncEvent = True
      TabOrder = 2
      ItemIndex = 0
      Items.Strings = (
        ''
        'LA=5,PS=1,LF=5'
        'LA=7,PS=1,LF=5')
      Sorted = False
      FriendlyName = 'cmbFormatoMatricola'
    end
    object btnChiudi: TmeIWButton
      Left = 304
      Top = 360
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      ScriptEvents = <>
      TabOrder = 3
      OnClick = btnChiudiClick
    end
    object lblSiglaTestata: TmeIWLabel
      Left = 24
      Top = 192
      Width = 78
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      ForControl = edtSiglaTestata
      HasTabOrder = False
      FriendlyName = 'lblCodCliente'
      Caption = 'Sigla testata'
      RawText = False
    end
    object edtSiglaTestata: TmeIWEdit
      Left = 152
      Top = 192
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width15chr'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
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
      FriendlyName = 'edtSiglaTestata'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 4
      PasswordPrompt = False
    end
    object chkTicket: TmeIWCheckBox
      Left = 25
      Top = 246
      Width = 77
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
      Caption = 'Ticket'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 5
      Checked = False
      FriendlyName = 'chkTicket'
    end
    object chkBuoniPasto: TmeIWCheckBox
      Left = 108
      Top = 246
      Width = 101
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
      Caption = 'Buoni pasto'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 6
      Checked = False
      FriendlyName = 'chkBuoniPasto'
    end
    object lblDati: TmeIWLabel
      Left = 23
      Top = 224
      Width = 122
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblDati'
      Caption = 'Dati da considerare'
      RawText = False
    end
    object rgpTipoFile: TmeIWRadioGroup
      Left = 25
      Top = 295
      Width = 184
      Height = 33
      Cursor = crDefault
      Css = 'RadioGroup'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      SubmitOnAsyncEvent = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoFile'
      ItemIndex = 0
      Items.Strings = (
        'Completo'
        'Solo corpo')
      Layout = glHorizontal
      ScriptEvents = <>
      TabOrder = 7
    end
    object lblTipoFile: TmeIWLabel
      Left = 25
      Top = 273
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      HasTabOrder = False
      FriendlyName = 'lblDati'
      Caption = 'Tipo file sequenziale'
      RawText = False
    end
    object lblNomeFile: TmeIWLabel
      Left = 25
      Top = 328
      Width = 59
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
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      ForControl = edtNomeFile
      HasTabOrder = False
      FriendlyName = 'lblNomeFile'
      Caption = 'Nome file'
      RawText = False
    end
    object edtNomeFile: TmeIWEdit
      Left = 24
      Top = 350
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
      Alignment = taLeftJustify
      BGColor = clNone
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtNomeFile'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 8
      PasswordPrompt = False
    end
    object btnConferma: TmeIWButton
      Left = 223
      Top = 360
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
      Caption = 'Conferma'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      ScriptEvents = <>
      TabOrder = 9
      OnClick = btnConfermaClick
    end
  end
end
