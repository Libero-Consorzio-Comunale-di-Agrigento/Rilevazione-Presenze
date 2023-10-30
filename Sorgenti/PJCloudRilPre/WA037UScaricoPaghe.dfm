inherited WA037FScaricoPaghe: TWA037FScaricoPaghe
  Tag = 13
  Width = 801
  Height = 560
  ExplicitWidth = 801
  ExplicitHeight = 560
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 59
    Top = 153
    ExplicitLeft = 59
    ExplicitTop = 153
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 59
    Top = 60
    ExplicitLeft = 59
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 59
    Top = 122
    ExplicitLeft = 59
    ExplicitTop = 122
  end
  object lblMeseDaScaricare: TmeIWLabel [9]
    Left = 57
    Top = 224
    Width = 114
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
    FriendlyName = 'lblMeseDaScaricare'
    Caption = 'Mese da scaricare'
    Enabled = True
  end
  object edtData: TmeIWEdit [10]
    Left = 59
    Top = 246
    Width = 121
    Height = 21
    Css = 'input_data_my'
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
    FriendlyName = 'edtData'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtDataAsyncChange
  end
  object lblIndietro: TmeIWLabel [11]
    Left = 217
    Top = 224
    Width = 129
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
    FriendlyName = 'lblIndietro'
    Caption = 'Indietro fino al mese'
    Enabled = True
  end
  object edtDataInd: TmeIWEdit [12]
    Left = 217
    Top = 246
    Width = 121
    Height = 21
    Css = 'input_data_my'
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
    FriendlyName = 'edtDataInd'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtDataIndAsyncChange
  end
  object lblDataCassa: TmeIWLabel [13]
    Left = 57
    Top = 272
    Width = 83
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
    FriendlyName = 'lblDataCassa'
    Caption = 'Data di cassa'
    Enabled = True
  end
  object edtDataFile: TmeIWEdit [14]
    Left = 59
    Top = 294
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
    FriendlyName = 'edtDataFile'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncChange = edtDataFileAsyncChange
  end
  object lblUltimaDataCassa: TmeIWLabel [15]
    Left = 217
    Top = 272
    Width = 126
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
    FriendlyName = 'lblUltimaDataCassa'
    Caption = 'Ultima data di cassa'
    Enabled = True
  end
  object edtUltimaDataCassa: TmeIWEdit [16]
    Left = 217
    Top = 294
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
    FriendlyName = 'edtUltimaDataCassa'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    Enabled = False
  end
  object lblParametri: TmeIWLabel [17]
    Left = 56
    Top = 330
    Width = 61
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
    FriendlyName = 'lblParametri'
    Caption = 'Parametri'
    Enabled = True
  end
  object lblNomeFile: TmeIWLabel [18]
    Left = 59
    Top = 376
    Width = 59
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
    FriendlyName = 'lblNomeFile'
    Caption = 'Nome file'
    Enabled = True
  end
  object edtNomeFile: TmeIWEdit [19]
    Left = 57
    Top = 398
    Width = 121
    Height = 21
    Css = 'width20chr'
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
    FriendlyName = 'edtNomeFile'
    SubmitOnAsyncEvent = True
    TabOrder = 11
  end
  object chkConguagli: TmeIWCheckBox [20]
    Left = 57
    Top = 483
    Width = 265
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Gestione conguagli'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = True
    FriendlyName = 'chkConguagli'
  end
  object rgpTipoScrittura: TmeIWRadioGroup [21]
    Left = 57
    Top = 441
    Width = 265
    Height = 24
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
    FriendlyName = 'rgpTipoScrittura'
    ItemIndex = 0
    Items.Strings = (
      'Ricrea'
      'Aggiungi')
    Layout = glHorizontal
    TabOrder = 13
  end
  object imbScarica: TmedpIWImageButton [22]
    Left = 57
    Top = 510
    Width = 113
    Height = 27
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
    OnClick = imbScaricaClick
    Cacheable = True
    FriendlyName = 'imbScarica'
    ImageFile.Filename = 'img\btnScarico.png'
    medpDownloadButton = False
    Caption = 'Esegui scarico'
  end
  object imbBtnChiudi: TmedpIWImageButton [23]
    Left = 361
    Top = 510
    Width = 113
    Height = 27
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
    Cacheable = True
    FriendlyName = 'imbBtnChiudi'
    ImageFile.Filename = 'img\btnChiudiScheda.png'
    medpDownloadButton = False
    Caption = 'Chiudi'
  end
  object grdWA037NavigatorBar: TmeIWGrid [24]
    Left = 47
    Top = 193
    Width = 299
    Height = 25
    Css = 'medpToolBar'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfDefault
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdWA037NavigatorBar'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object imbAnomalie: TmedpIWImageButton [25]
    Left = 209
    Top = 510
    Width = 113
    Height = 27
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
    OnClick = imbAnomalieClick
    Cacheable = True
    FriendlyName = 'imbBtnChiudi'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object imgEliminaUltimaDataCassa: TmeIWImageFile [26]
    Left = 349
    Top = 294
    Width = 28
    Height = 21
    Hint = 'Elimina ultima data cassa'
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
    OnClick = imgEliminaUltimaDataCassaClick
    Cacheable = True
    FriendlyName = 'imgEliminaUltimaDataCassa'
    ImageFile.Filename = 'img\btnElimina.png'
    medpDownloadButton = False
  end
  object cmbParametri: TMedpIWMultiColumnComboBox [27]
    Left = 59
    Top = 349
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
    FriendlyName = 'cmbParametri'
    SubmitOnAsyncEvent = True
    TabOrder = 14
    OnAsyncChange = cmbParametriAsyncChange
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'width15chr'
    LookupColumn = 0
    CodeColumn = 0
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 632
    Top = 144
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 624
    Top = 24
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 624
    Top = 88
  end
  object actlstWA037NavigatorBar: TActionList
    Left = 371
    Top = 187
    object actSalvataggio: TAction
      Caption = 'btnSalvataggio'
      Hint = 'Salvataggio'
      ImageIndex = 7
      OnExecute = actSalvataggioExecute
    end
    object actRipristino: TAction
      Caption = 'btnRipristinaDati'
      Hint = 'Ripristino'
      ImageIndex = 8
      OnExecute = actRipristinoExecute
    end
    object actFiltroCodInterni: TAction
      Caption = 'btnFiltro'
      Hint = 'Filtro codici interni'
      ImageIndex = 2
      OnExecute = actFiltroCodInterniExecute
    end
    object actFiltroVoci: TAction
      Caption = 'btnFiltroGiallo'
      Hint = 'Filtro voci paghe'
      ImageIndex = 2
      OnExecute = actFiltroVociExecute
    end
    object actCmbSelezione: TAction
      Caption = 'actCmbSelezione'
    end
    object actEsci: TAction
      Caption = 'btnChiudiScheda'
      Hint = 'Esci'
      ImageIndex = 6
      Visible = False
    end
    object actFiltro: TAction
      Caption = 'btnSalva'
      Hint = 'Salva filtro'
      ImageIndex = 10
      OnExecute = actFiltroExecute
    end
    object actEliminaFiltro: TAction
      Caption = 'btnElimina'
      Hint = 'Elimina filtro'
      ImageIndex = 11
      OnExecute = actEliminaFiltroExecute
    end
    object actEseguiScarico: TAction
      Caption = 'btnScarico'
      Hint = 'Esegui scarico'
      ImageIndex = 4
      OnExecute = actEseguiScaricoExecute
    end
    object actVisualizzaScarico: TAction
      Caption = 'btnVisualizzaFile'
      Hint = 'Visualizza scarico'
      ImageIndex = 0
      OnExecute = actVisualizzaScaricoExecute
    end
    object actVisualizzaAnomalie: TAction
      Caption = 'btnCheck'
      Hint = 'Visualizza anomalie'
      ImageIndex = 3
    end
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 488
    Top = 232
  end
end
