inherited WA159FArchiviazioneCartellini: TWA159FArchiviazioneCartellini
  Tag = 75
  Height = 461
  ExplicitHeight = 461
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 134
    ExplicitTop = 134
  end
  inherited btnShowElabError: TmeIWButton
    Left = 16
    Top = 103
    ExplicitLeft = 16
    ExplicitTop = 103
  end
  object lblPathPDF: TmeIWLabel [9]
    Left = 16
    Top = 165
    Width = 106
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
    HasTabOrder = False
    FriendlyName = 'lblPathPDF'
    Caption = 'Cartella dei files:'
    Enabled = True
  end
  object lblFilePDF: TmeIWLabel [10]
    Left = 16
    Top = 187
    Width = 121
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
    HasTabOrder = False
    FriendlyName = 'meIWLabel1'
    Caption = 'Formato nome file:'
    Enabled = True
  end
  object edtFilePDF: TmeIWEdit [11]
    Left = 174
    Top = 192
    Width = 121
    Height = 21
    Css = 'width70chr'
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
    FriendlyName = 'meIWEdit1'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    Text = 'meIWEdit1'
  end
  object chkSovrascrivi: TmeIWCheckBox [12]
    Left = 174
    Top = 218
    Width = 177
    Height = 21
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Sovrascrivi files esistenti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    Checked = False
    FriendlyName = 'chkSovrascrivi'
  end
  object cmbParametrizzazione: TMedpIWMultiColumnComboBox [13]
    Left = 16
    Top = 314
    Width = 121
    Height = 21
    Css = 'medpMultiColumnCombo'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'cmbParametrizzazione'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblPeriodoAl: TmeIWLabel [14]
    Left = 225
    Top = 304
    Width = 17
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
    HasTabOrder = False
    FriendlyName = 'meIWLabel1'
    Caption = 'Al:'
    Enabled = True
  end
  object lblPeriodoDal: TmeIWLabel [15]
    Left = 225
    Top = 277
    Width = 25
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
    HasTabOrder = False
    FriendlyName = 'meIWLabel1'
    Caption = 'Dal:'
    Enabled = True
  end
  object edtPeriodoDal: TmeIWEdit [16]
    Left = 256
    Top = 277
    Width = 121
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'meIWEdit1'
    SubmitOnAsyncEvent = True
    TabOrder = 11
    Text = 'meIWEdit1'
  end
  object edtPeriodoAl: TmeIWEdit [17]
    Left = 256
    Top = 304
    Width = 121
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'meIWEdit1'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    Text = 'meIWEdit1'
  end
  object rgpGenerazionePDF: TmeIWRadioGroup [18]
    Left = 383
    Top = 277
    Width = 121
    Height = 67
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpGenerazionePDF'
    ItemIndex = 0
    Items.Strings = (
      'Unico file'
      'File mensile')
    Layout = glVertical
    TabOrder = 13
  end
  object lblAnomalie: TmeIWLabel [19]
    Left = 16
    Top = 341
    Width = 117
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
    HasTabOrder = False
    FriendlyName = 'lblAnomalie'
    Caption = 'Anomalie bloccanti'
    Enabled = True
  end
  object lstAnomalie: TmeTIWAdvCheckGroup [20]
    Left = 16
    Top = 363
    Width = 448
    Height = 52
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebBLACK
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'lstAnomalie'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 14
    medpContextMenu = pmnAnomalie
  end
  object lblParametrizzazione: TmeIWLabel [21]
    Left = 16
    Top = 295
    Width = 115
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
    HasTabOrder = False
    FriendlyName = 'lblParametrizzazione'
    Caption = 'Parametrizzazione'
    Enabled = True
  end
  object edtPathPDF: TmeIWEdit [22]
    Left = 174
    Top = 165
    Width = 121
    Height = 21
    Css = 'width70chr'
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
    FriendlyName = 'edtPathPDF'
    SubmitOnAsyncEvent = True
    TabOrder = 15
    Text = 'wwwroot'
  end
  object btnStart: TmedpIWImageButton [23]
    Left = 16
    Top = 426
    Width = 22
    Height = 21
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = btnStartClick
    Cacheable = True
    FriendlyName = 'btnStart'
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = ''
  end
  object btnLeggiLog: TmedpIWImageButton [24]
    Left = 44
    Top = 426
    Width = 22
    Height = 21
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = btnLeggiLogClick
    Cacheable = True
    FriendlyName = 'btnStart'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = ''
  end
  object lblGenerazionePDF: TmeIWLabel [25]
    Left = 383
    Top = 257
    Width = 106
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
    HasTabOrder = False
    FriendlyName = 'lblGenerazionePDF'
    Caption = 'Generazione PDF'
    Enabled = True
  end
  object lblPeriodo: TmeIWLabel [26]
    Left = 256
    Top = 257
    Width = 47
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
    HasTabOrder = False
    FriendlyName = 'lblPeriodo'
    Caption = 'Periodo'
    Enabled = True
  end
  object chkAggSchedaRiep: TmeIWCheckBox [27]
    Left = 192
    Top = 326
    Width = 241
    Height = 21
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Aggiornamento scheda riepilogativa'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 16
    Checked = False
    FriendlyName = 'chkAggSchedaRiep'
  end
  object chkParametrizzazioniTipoCartellino: TmeIWCheckBox [28]
    Left = 192
    Top = 353
    Width = 241
    Height = 21
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Utilizza parametrizzazioni del tipo cartellino'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 17
    Checked = False
    FriendlyName = 'chkParametrizzazioniTipoCartellino'
  end
  object btnImpostazioniAziendali: TmeIWButton [29]
    Left = 16
    Top = 218
    Width = 137
    Height = 21
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Impostazioni aziendali'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnImpostazioniAziendali'
    TabOrder = 8
    OnClick = btnImpostazioniAziendaliClick
    medpDownloadButton = False
  end
  object chkInviaRegistro: TmeIWCheckBox [30]
    Left = 192
    Top = 380
    Width = 241
    Height = 21
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Invia registro di archiviazione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    OnAsyncClick = chkInviaRegistroAsyncClick
    Checked = False
    FriendlyName = 'chkInviaRegistro'
  end
  object cmbElencoRegistri: TMedpIWMultiColumnComboBox [31]
    Left = 184
    Top = 421
    Width = 249
    Height = 21
    Css = 'medpMultiColumnCombo'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'cmbElencoRegistri'
    SubmitOnAsyncEvent = True
    TabOrder = 19
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblElencoRegistri: TmeIWLabel [32]
    Left = 188
    Top = 407
    Width = 234
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
    HasTabOrder = False
    FriendlyName = 'lblElencoRegistri'
    Caption = 'Elenco registri di archiviazione salvati'
    Enabled = True
  end
  object pmnAnomalie: TPopupMenu
    Left = 480
    Top = 414
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
end
