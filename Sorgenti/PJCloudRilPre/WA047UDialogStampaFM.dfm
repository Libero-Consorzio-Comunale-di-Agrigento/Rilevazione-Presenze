inherited WA047FDialogStampaFM: TWA047FDialogStampaFM
  Width = 457
  Height = 409
  ExplicitWidth = 457
  ExplicitHeight = 409
  inherited IWFrameRegion: TIWRegion
    Width = 457
    Height = 409
    ExplicitWidth = 457
    ExplicitHeight = 409
    object btnChiudi: TmeIWButton
      Left = 366
      Top = 363
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      ScriptEvents = <>
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object lblDaData: TmeIWLabel
      Left = 40
      Top = 56
      Width = 68
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
      FriendlyName = 'lblDaData'
      Caption = 'Dalla data:'
      RawText = False
      Enabled = True
    end
    object lblAData: TmeIWLabel
      Left = 130
      Top = 56
      Width = 60
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
      FriendlyName = 'lblAData'
      Caption = 'Alla data:'
      RawText = False
      Enabled = True
    end
    object eDaData: TmeIWEdit
      Left = 27
      Top = 78
      Width = 81
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
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'eDaData'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 1
      PasswordPrompt = False
      Text = 'eDaData'
    end
    object eAData: TmeIWEdit
      Left = 130
      Top = 78
      Width = 81
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
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'eAData'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 2
      PasswordPrompt = False
      Text = 'eAData'
    end
    object chkDatiIndividuali: TmeIWCheckBox
      Left = 27
      Top = 105
      Width = 121
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Dati Individuali'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 3
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkDatiIndividuali'
    end
    object chkDettaglioGiornaliero: TmeIWCheckBox
      Left = 27
      Top = 121
      Width = 145
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Dettaglio giornaliero'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 4
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkDettaglioGiornaliero'
    end
    object chkTotaliIndividuali: TmeIWCheckBox
      Left = 27
      Top = 137
      Width = 121
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Totali individuali'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 5
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkTotaliIndividuali'
    end
    object chkSaltoPaginaIndividuale: TmeIWCheckBox
      Left = 27
      Top = 152
      Width = 161
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Salto pagina individuale'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 6
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkSaltoPaginaIndividuale'
    end
    object chkTimbraturePresenza: TmeIWCheckBox
      Left = 27
      Top = 168
      Width = 161
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Timbrature di presenza'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 7
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkTimbraturePresenza'
    end
    object chkTimbraturePresenzaCausalizzate: TmeIWCheckBox
      Left = 27
      Top = 184
      Width = 184
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Timbrature con causale'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 8
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkTimbraturePresenzaCausalizzate'
    end
    object chkGiustificativiAssenza: TmeIWCheckBox
      Left = 27
      Top = 201
      Width = 167
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Giustificativi di assenza'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 9
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkGiustificativiAssenza'
    end
    object chkAnomalie: TmeIWCheckBox
      Left = 27
      Top = 217
      Width = 121
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Solo anomalie'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 10
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkAnomalie'
    end
    object chkNominativi: TmeIWCheckBox
      Left = 27
      Top = 234
      Width = 230
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Raggruppamento per nominativo'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 11
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkNominativi'
    end
    object chkRilevatori: TmeIWCheckBox
      Left = 27
      Top = 250
      Width = 224
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Raggruppamento per rilevatori'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 12
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkRilevatori'
    end
    object chkCausale: TmeIWCheckBox
      Left = 27
      Top = 266
      Width = 208
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Raggruppamento per causale'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 13
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkCausale'
    end
    object chkSaltoPagina: TmeIWCheckBox
      Left = 27
      Top = 282
      Width = 224
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Salto pagina nomin./rilev./caus.'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 14
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkSaltoPagina'
    end
    object rgpTipoStampa: TmeIWRadioGroup
      Left = 256
      Top = 40
      Width = 169
      Height = 49
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
      StyleRenderOptions.RenderPadding = False
      SubmitOnAsyncEvent = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpTipoStampa'
      ItemIndex = 0
      Items.Strings = (
        'Dipendente'
        'Giornaliera')
      Layout = glHorizontal
      ScriptEvents = <>
      TabOrder = 15
      OnAsyncClick = rgpTipoStampaAsyncClick
    end
    object lblTipoStampa: TmeIWLabel
      Left = 304
      Top = 16
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
      FriendlyName = 'lblTipoStampa'
      Caption = 'Tipo stampa'
      RawText = False
      Enabled = True
    end
    object chkDistinzioneCausale: TmeIWCheckBox
      Left = 261
      Top = 105
      Width = 180
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Distinzione per causale'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 16
      Checked = False
      FriendlyName = 'chkDistinzioneCausale'
    end
    object chkPranzoCena: TmeIWCheckBox
      Left = 261
      Top = 122
      Width = 164
      Height = 18
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Distinzione pranzo/cena'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 17
      Checked = False
      FriendlyName = 'chkPranzoCena'
    end
    object edtRaggr: TmeIWEdit
      Left = 27
      Top = 309
      Width = 161
      Height = 21
      Cursor = crAuto
      Css = 'width25chr'
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
      FriendlyName = 'edtRaggr'
      MaxLength = 0
      ReadOnly = False
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 18
      PasswordPrompt = False
      Text = 'edtRaggr'
    end
    object btnRaggr: TmeIWButton
      Left = 194
      Top = 309
      Width = 34
      Height = 21
      Cursor = crAuto
      Css = 'pulsante puntini'
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
      Caption = '...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnRaggr'
      ScriptEvents = <>
      TabOrder = 19
      OnClick = btnRaggrClick
      medpDownloadButton = False
    end
    object chkSaltoPaginaRaggr: TmeIWCheckBox
      Left = 27
      Top = 336
      Width = 121
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
      StyleRenderOptions.RenderPadding = False
      Caption = 'Salto pagina'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 20
      OnAsyncClick = chkDatiAsyncClick
      Checked = False
      FriendlyName = 'chkSaltoPaginaRaggr'
    end
    object btnGeneraPDF: TmedpIWImageButton
      Left = 261
      Top = 329
      Width = 122
      Height = 28
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
      BorderOptions.Color = clNone
      BorderOptions.Width = 0
      ScriptEvents = <>
      TabOrder = -1
      UseSize = False
      OnClick = btnGeneraPDFClick
      Cacheable = True
      FriendlyName = 'btnGeneraPDF'
      ImageFile.URL = 'img/btnPdf.png'
      medpDownloadButton = False
      Caption = 'Stampa in PDF'
    end
    object cgpOrologi: TmeTIWAdvCheckGroup
      Left = 263
      Top = 165
      Height = 24
      Cursor = crAuto
      Css = 'intestazione nowrapcheckgroup noborder'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      BorderColor = clWebBLACK
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'cgpOrologi'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      ScriptEvents = <>
      TabOrder = 21
      medpContextMenu = pmnAzioni
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA047FDialogStampaFM.html'
  end
  object pmnAzioni: TPopupMenu
    Left = 224
    Top = 264
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = Invertiselezione1Click
    end
  end
end
