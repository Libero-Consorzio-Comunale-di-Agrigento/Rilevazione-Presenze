inherited WA130FOraLegaleSolare: TWA130FOraLegaleSolare
  Tag = 178
  Width = 786
  Height = 565
  Title = '(WA130)  Cambio ora legale/solare'
  ExplicitWidth = 786
  ExplicitHeight = 565
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 80
    Top = 122
    ExplicitLeft = 80
    ExplicitTop = 122
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 80
    Top = 60
    ExplicitLeft = 80
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 80
    Top = 91
    ExplicitLeft = 80
    ExplicitTop = 91
  end
  object lblDaData: TmeIWLabel [9]
    Left = 33
    Top = 184
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
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblDaData'
    Caption = 'Dalla data'
    Enabled = True
  end
  object edtDaData: TmeIWEdit [10]
    Left = 33
    Top = 206
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtDaData'
    SubmitOnAsyncEvent = True
    TabOrder = 7
  end
  object lblAData: TmeIWLabel [11]
    Left = 33
    Top = 232
    Width = 55
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
    FriendlyName = 'lblAData'
    Caption = 'Alla data'
    Enabled = True
  end
  object edtAData: TmeIWEdit [12]
    Left = 33
    Top = 254
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtAData'
    SubmitOnAsyncEvent = True
    TabOrder = 8
  end
  object lblDaOre: TmeIWLabel [13]
    Left = 177
    Top = 184
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
    HasTabOrder = False
    FriendlyName = 'lblDaOre'
    Caption = 'Dalle ore'
    Enabled = True
  end
  object edtDaOre: TmeIWEdit [14]
    Left = 177
    Top = 206
    Width = 56
    Height = 21
    Css = 'input_hour_hhmm width3chr'
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
    FriendlyName = 'edtDaOre'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    Text = '00.00'
  end
  object lblAOre: TmeIWLabel [15]
    Left = 177
    Top = 232
    Width = 48
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
    FriendlyName = 'lblAOre'
    Caption = 'Alle ore'
    Enabled = True
  end
  object edtAOre: TmeIWEdit [16]
    Left = 177
    Top = 254
    Width = 56
    Height = 21
    Css = 'input_hour_hhmm width3chr'
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
    FriendlyName = 'edtAOre'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    Text = '23.59'
  end
  object edtOrologi: TmeIWEdit [17]
    Left = 259
    Top = 206
    Width = 121
    Height = 21
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
    FriendlyName = 'edtOrologi'
    SubmitOnAsyncEvent = True
    TabOrder = 11
  end
  object lblOrologi: TmeIWLabel [18]
    Left = 259
    Top = 184
    Width = 45
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
    FriendlyName = 'lblOrologi'
    Caption = 'Orologi'
    Enabled = True
  end
  object rgpPresMens: TmeIWRadioGroup [19]
    Left = 259
    Top = 242
    Width = 166
    Height = 33
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
    OnClick = btnVisualizzaClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpPresMens'
    ItemIndex = 0
    Items.Strings = (
      'Timbrature di presenza'
      'Timbrature di mensa')
    Layout = glVertical
    TabOrder = 12
  end
  object rgpLegsol: TmeIWRadioGroup [20]
    Left = 431
    Top = 206
    Width = 232
    Height = 69
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
    FriendlyName = 'rgpLegsol'
    ItemIndex = 0
    Items.Strings = (
      'Legale -> Solare (un'#39'ora indietro)'
      'Solare -> Legale (un'#39'ora in avanti)')
    Layout = glVertical
    TabOrder = 13
  end
  object grdRisultati: TmedpIWDBGrid [21]
    Left = 33
    Top = 368
    Width = 449
    Height = 145
    Css = 'grid'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdRisultatiRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdRisultati'
    FromStart = True
    HighlightColor = clNone
    HighlightRows = False
    Options = [dgShowTitles]
    RefreshMode = rmAutomatic
    RowLimit = 0
    RollOver = False
    RowClick = True
    RollOverColor = clNone
    RowHeaderColor = clNone
    RowAlternateColor = clNone
    RowCurrentColor = clNone
    TabOrder = -1
    medpContextMenu = pmnAzioni
    medpTipoContatore = 'P'
    medpRighePagina = -1
    medpBrowse = True
    medpRowSelect = True
    medpEditMultiplo = False
    medpFixedColumns = 0
    medpComandiCustom = False
    medpComandiEdit = False
    medpComandiInsert = False
    medpComandoDelete = False
  end
  object btnVisualizza: TmedpIWImageButton [22]
    Left = 33
    Top = 312
    Width = 80
    Height = 25
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
    OnClick = btnVisualizzaClick
    Cacheable = True
    FriendlyName = 'btnVisualizza'
    medpDownloadButton = False
    Caption = 'Visualizza'
  end
  object btnModifica: TmedpIWImageButton [23]
    Left = 145
    Top = 312
    Width = 80
    Height = 25
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    Enabled = False
    TabOrder = -1
    UseSize = False
    OnClick = btnModificaClick
    Cacheable = True
    FriendlyName = 'btnModifica'
    ImageFile.Filename = 'img\btnesegui.png'
    medpDownloadButton = False
    Caption = 'Modifica'
  end
  object btnOrologi: TmeIWButton [24]
    Left = 386
    Top = 210
    Width = 25
    Height = 17
    Css = 'pulsante puntini'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = '...'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnOrologi'
    TabOrder = 14
    OnClick = btnOrologiClick
    medpDownloadButton = False
  end
  object btnSalvaSuFile: TmedpIWImageButton [25]
    Left = 259
    Top = 312
    Width = 80
    Height = 25
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    Enabled = False
    TabOrder = -1
    UseSize = False
    OnClick = btnSalvaSuFileClick
    Cacheable = True
    FriendlyName = 'btnSalvaSuFile'
    ImageFile.Filename = 'img\btnSalva.png'
    medpDownloadButton = False
    Caption = 'Salva su file'
  end
  object lblModificaRichiesta: TmeIWLabel [26]
    Left = 431
    Top = 184
    Width = 112
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
    FriendlyName = 'lblOrologi'
    Caption = 'Modifica Richiesta'
    Enabled = True
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Top = 8
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Top = 64
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 632
    Top = 128
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 632
    Top = 8
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 632
    Top = 72
  end
  object pmnAzioni: TPopupMenu
    Left = 272
    Top = 8
    object actScaricaInExcelRisultati: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelRisultatiClick
    end
    object actScaricaInCSVRisultati: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVRisultatiClick
    end
  end
end
