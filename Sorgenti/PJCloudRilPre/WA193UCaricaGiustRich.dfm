inherited WA193FCaricaGiustRich: TWA193FCaricaGiustRich
  Tag = 96
  Width = 862
  Height = 564
  ExplicitWidth = 862
  ExplicitHeight = 564
  DesignLeft = 8
  DesignTop = 8
  object rgpModalita: TmeIWRadioGroup [15]
    Left = 24
    Top = 416
    Width = 233
    Height = 57
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
    OnClick = rgpModalitaClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpModalita'
    ItemIndex = 0
    Items.Strings = (
      'nuove richieste'
      'richieste elaborate con anomalie')
    Layout = glVertical
    TabOrder = 7
  end
  object chkAnomalie: TmeIWCheckBox [16]
    Left = 24
    Top = 479
    Width = 225
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
    Caption = 'Gestione interattiva anomalie'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 8
    Checked = False
    FriendlyName = 'chkAnomalie'
  end
  object lblPeriodoDal: TmeIWLabel [17]
    Left = 263
    Top = 416
    Width = 100
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
    ForControl = edtPeriodoDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Intersezione dal'
    Enabled = True
  end
  object edtPeriodoDal: TmeIWEdit [18]
    Left = 369
    Top = 416
    Width = 74
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 9
  end
  object lblPeriodoAl: TmeIWLabel [19]
    Left = 449
    Top = 416
    Width = 11
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
    ForControl = edtPeriodoAl
    HasTabOrder = False
    FriendlyName = 'lblPeriodoAl'
    Caption = 'al'
    Enabled = True
  end
  object edtPeriodoAl: TmeIWEdit [20]
    Left = 466
    Top = 416
    Width = 74
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object lblInizioDal: TmeIWLabel [21]
    Left = 263
    Top = 443
    Width = 56
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
    ForControl = edtInizioDal
    HasTabOrder = False
    FriendlyName = 'lblInizioDal'
    Caption = 'Inizio dal'
    Enabled = True
  end
  object edtInizioDal: TmeIWEdit [22]
    Left = 369
    Top = 443
    Width = 74
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
    FriendlyName = 'edtInizioDal'
    SubmitOnAsyncEvent = True
    TabOrder = 11
  end
  object lblInizioAl: TmeIWLabel [23]
    Left = 449
    Top = 443
    Width = 11
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
    ForControl = edtInizioAl
    HasTabOrder = False
    FriendlyName = 'lblInizioAl'
    Caption = 'al'
    Enabled = True
  end
  object edtInizioAl: TmeIWEdit [24]
    Left = 466
    Top = 443
    Width = 74
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
    FriendlyName = 'edtInizioAl'
    SubmitOnAsyncEvent = True
    TabOrder = 12
  end
  object lblFineDal: TmeIWLabel [25]
    Left = 263
    Top = 470
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
    ForControl = edtFineDal
    HasTabOrder = False
    FriendlyName = 'lblFineDal'
    Caption = 'Fine dal'
    Enabled = True
  end
  object edtFineDal: TmeIWEdit [26]
    Left = 369
    Top = 470
    Width = 74
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
    FriendlyName = 'edtFineDal'
    SubmitOnAsyncEvent = True
    TabOrder = 13
  end
  object lblFineAl: TmeIWLabel [27]
    Left = 449
    Top = 470
    Width = 11
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
    ForControl = edtFineAl
    HasTabOrder = False
    FriendlyName = 'lblFineAl'
    Caption = 'al'
    Enabled = True
  end
  object edtFineAl: TmeIWEdit [28]
    Left = 466
    Top = 470
    Width = 74
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
    FriendlyName = 'edtFineAl'
    SubmitOnAsyncEvent = True
    TabOrder = 14
  end
  object btnVisualizzaLog: TmedpIWImageButton [29]
    Left = 600
    Top = 416
    Width = 193
    Height = 33
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
    OnClick = btnVisualizzaLogClick
    Cacheable = True
    FriendlyName = 'btnVisualizzaLog'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Visualizza log'
  end
  object btnImporta: TmedpIWImageButton [30]
    Left = 600
    Top = 455
    Width = 193
    Height = 31
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
    OnClick = btnImportaClick
    Cacheable = True
    FriendlyName = 'btnImporta'
    ImageFile.Filename = 'img\btnOmesseTimbrature.png'
    medpDownloadButton = False
    Caption = 'Importa tutti i giustificativi'
  end
  object lblPeriodo: TmeIWLabel [31]
    Left = 251
    Top = 394
    Width = 104
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
    Caption = 'Periodo richieste'
    Enabled = True
  end
  object lblModalita: TmeIWLabel [32]
    Left = 16
    Top = 394
    Width = 134
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
    FriendlyName = 'lblModalita'
    Caption = 'Modalit'#224' caricamento'
    Enabled = True
  end
  object rgpAllegato: TmeIWRadioGroup [33]
    Left = 24
    Top = 522
    Width = 331
    Height = 31
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
    OnClick = rgpAllegatoClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpAllegato'
    ItemIndex = 0
    Items.Strings = (
      'Tutti '
      'Con allegato '
      'Senza allegato ')
    Layout = glHorizontal
    TabOrder = 15
  end
  object rgpCondizAllegato: TmeIWRadioGroup [34]
    Left = 369
    Top = 522
    Width = 303
    Height = 31
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
    OnClick = rgpCondizAllegatoClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'meIWRadioGroup1'
    ItemIndex = 0
    Items.Strings = (
      'Tutti '
      'Allegati non previsti '
      'Allegati facoltativi '
      'Allegati obbligatori ')
    Layout = glHorizontal
    TabOrder = 16
  end
  object lblAllegato: TmeIWLabel [35]
    Left = 24
    Top = 500
    Width = 50
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
    FriendlyName = 'lblAllegato'
    Caption = 'Allegato'
    Enabled = True
  end
  object lblCondizAllegato: TmeIWLabel [36]
    Left = 369
    Top = 500
    Width = 122
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
    Caption = 'Condizione allegato'
    Enabled = True
  end
end
