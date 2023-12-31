inherited W035FMessaggistica: TW035FMessaggistica
  Tag = 445
  Width = 1122
  Height = 682
  HelpType = htKeyword
  HelpKeyword = 'W035P0'
  ExplicitWidth = 1122
  ExplicitHeight = 682
  DesignLeft = 8
  DesignTop = 8
  object tabMessaggi: TmedpIWTabControl [8]
    Left = 16
    Top = 141
    Width = 201
    Height = 36
    Css = 'gridTabControl'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'tabMessaggi'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'tabMessaggi'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
    OnTabControlChanging = tabMessaggiTabControlChanging
    OnTabControlChange = tabMessaggiTabControlChange
  end
  object meIWLabel1: TmeIWLabel [9]
    Left = 504
    Top = 328
    Width = 78
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
    Caption = 'meIWLabel1'
    Enabled = True
  end
  object rgnDati: TmeIWRegion [10]
    Left = 16
    Top = 178
    Width = 748
    Height = 493
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpDati
    object lblDettaglio: TmeIWLabel
      Left = 8
      Top = 7
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
      FriendlyName = 'lblDettaglio'
      Caption = 'Dettaglio messaggio'
      Enabled = True
    end
    object lblDestinatari: TmeIWLabel
      Left = 14
      Top = 34
      Width = 67
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
      FriendlyName = 'lblDestinatari'
      Caption = 'Destinatari'
      Enabled = True
    end
    object lblOggetto: TmeIWLabel
      Left = 14
      Top = 95
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
      ForControl = edtOggetto
      HasTabOrder = False
      FriendlyName = 'lblOggetto'
      Caption = 'Oggetto'
      Enabled = True
    end
    object lblTesto: TmeIWLabel
      Left = 16
      Top = 123
      Width = 35
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
      ForControl = memTesto
      HasTabOrder = False
      FriendlyName = 'lblTesto'
      Caption = 'Testo'
      Enabled = True
    end
    object lblAllegati: TmeIWLabel
      Left = 13
      Top = 280
      Width = 46
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
      FriendlyName = 'lblAllegati'
      Caption = 'Allegati'
      Enabled = True
    end
    object grdAllegati: TmeIWGrid
      Left = 87
      Top = 365
      Width = 274
      Height = 29
      Css = 'gridTrasparente'
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
      BorderStyle = tfVoid
      Caption = 'grdAllegati'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlNone
      Summary = 'Elenco degli allegati del messaggio'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdAllegati'
      ColumnCount = 2
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object btnHdnUpload: TmeIWButton
      Left = 300
      Top = 302
      Width = 117
      Height = 25
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Nascosto - Upload'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnHdnUpload'
      TabOrder = 6
      OnClick = btnHdnUploadClick
      medpDownloadButton = False
    end
    object edtOggetto: TmeIWEdit
      Left = 87
      Top = 94
      Width = 274
      Height = 21
      Css = 'nomargin width98pc'
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
      FriendlyName = 'edtOggetto'
      SubmitOnAsyncEvent = True
      TabOrder = 7
    end
    object edtDestinatari: TmeIWEdit
      Left = 142
      Top = 33
      Width = 125
      Height = 21
      Css = 'nomargin width50chr'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtDestinatari'
      SubmitOnAsyncEvent = True
      TabOrder = 8
    end
    object btnDestinatari: TmeIWButton
      Left = 274
      Top = 29
      Width = 87
      Height = 25
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Destinatari...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnDestinatari'
      TabOrder = 9
      OnClick = btnDestinatariClick
      medpDownloadButton = False
    end
    object memTesto: TmeIWMemo
      Left = 87
      Top = 121
      Width = 274
      Height = 109
      Css = 'nomargin width98pc height12'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderStatus = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clNone
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = False
      Required = False
      TabOrder = 10
      SubmitOnAsyncEvent = True
      ResizeDirection = rdVertical
      FriendlyName = 'memTesto'
    end
    object lblFiltro: TmeIWLabel
      Left = 385
      Top = 7
      Width = 95
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
      FriendlyName = 'lblFiltro'
      Caption = 'Filtro messaggi'
      Enabled = True
    end
    object rgpFiltroDaLeggere: TmeIWRadioGroup
      Left = 391
      Top = 66
      Width = 341
      Height = 22
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
      OnClick = rgpFiltroDaLeggereClick
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpFiltroDaLeggere'
      ItemIndex = 0
      Items.Strings = (
        'da leggere'
        'gi'#224' letti'
        'tutti'
        'cancellati')
      Layout = glHorizontal
      TabOrder = 11
    end
    object chkStatoSospeso: TmeIWCheckBox
      Left = 391
      Top = 94
      Width = 86
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
      Caption = 'Sospesi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 12
      OnAsyncClick = chkStatoAsyncClick
      Checked = True
      FriendlyName = 'chkStatoSospeso'
    end
    object chkStatoCancellato: TmeIWCheckBox
      Left = 391
      Top = 121
      Width = 86
      Height = 21
      Css = 'intestazione spazio_sx1'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Cancellati'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 13
      OnAsyncClick = chkStatoAsyncClick
      Checked = False
      FriendlyName = 'chkStatoCancellato'
    end
    object chkStatoTutti: TmeIWCheckBox
      Left = 485
      Top = 121
      Width = 121
      Height = 21
      Css = 'intestazione spazio_sx1'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Tutti'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 14
      OnAsyncClick = chkStatoTuttiAsyncClick
      Checked = False
      FriendlyName = 'chkStatoTutti'
    end
    object chkStatoInviato: TmeIWCheckBox
      Left = 485
      Top = 94
      Width = 77
      Height = 21
      Css = 'intestazione spazio_sx1'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Inviati dal'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 15
      OnAsyncClick = chkStatoAsyncClick
      Checked = True
      FriendlyName = 'chkStatoInviato'
    end
    object edtPeriodoDal: TmeIWEdit
      Left = 568
      Top = 94
      Width = 73
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
      TabOrder = 16
    end
    object lblPeriodoAl: TmeIWLabel
      Left = 647
      Top = 94
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
    object edtPeriodoAl: TmeIWEdit
      Left = 664
      Top = 93
      Width = 73
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
      FriendlyName = 'edtPeriodoAl'
      SubmitOnAsyncEvent = True
      TabOrder = 17
    end
    object lblFiltroSelezione: TmeIWLabel
      Left = 391
      Top = 154
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
      ForControl = cmbFiltroSelezione
      HasTabOrder = False
      FriendlyName = 'lblFiltroSelezione'
      Caption = 'Selezione'
      Enabled = True
    end
    object cmbFiltroSelezione: TmeIWComboBox
      Left = 457
      Top = 153
      Width = 95
      Height = 21
      Css = 'input20'
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
      OnChange = cmbFiltroSelezioneChange
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 18
      ItemIndex = -1
      FriendlyName = 'meIWComboBox1'
      NoSelectionText = '-- No Selection --'
    end
    object btnFiltra: TmeIWButton
      Left = 391
      Top = 215
      Width = 75
      Height = 25
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Filtra'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnFiltra'
      TabOrder = 19
      OnClick = btnFiltraClick
      medpDownloadButton = False
    end
    object lblFiltroMittente: TmeIWLabel
      Left = 562
      Top = 154
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
      ForControl = cmbFiltroMittente
      HasTabOrder = False
      FriendlyName = 'lblFiltroMittente'
      Caption = 'Mittente'
      Enabled = True
    end
    object cmbFiltroMittente: TmeIWComboBox
      Left = 616
      Top = 153
      Width = 88
      Height = 21
      Css = 'input20'
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
      OnChange = cmbFiltroMittenteChange
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 20
      ItemIndex = -1
      FriendlyName = 'cmbFiltroMittente'
      NoSelectionText = '-- No Selection --'
    end
    object edtRicerca: TmeIWEdit
      Left = 391
      Top = 180
      Width = 313
      Height = 21
      Css = 'searchBox input40'
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
      FriendlyName = 'edtRicerca'
      SubmitOnAsyncEvent = True
      TabOrder = 21
      OnSubmit = edtRicercaSubmit
      medpWatermark = 'Ricerca nell'#39'oggetto o nel testo'
    end
    object grdMessaggi: TmedpIWDBGrid
      Left = 13
      Top = 400
      Width = 723
      Height = 90
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
      Caption = 'Messaggi'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdMessaggiRenderCell
      Summary = 'Elenco dei messaggi'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdMessaggi'
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
      medpContextMenu = pmnTabella
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
      OnAfterCaricaCDS = grdMessaggiAfterCaricaCDS
      OnmedpStatoChange = grdMessaggimedpStatoChange
      OnInserisci = grdMessaggiInserisci
      OnModifica = grdMessaggiModifica
      OnCancella = grdMessaggiCancella
      OnConferma = grdMessaggiConferma
      OnAnnulla = grdMessaggiAnnulla
    end
    object lblPeriodoDal: TmeIWLabel
      Left = 528
      Top = 81
      Width = 60
      Height = 16
      Css = 'intestazione spazio_sx1'
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
      Caption = 'Inviati dal'
      Enabled = True
    end
    object edtSelezione: TmeIWEdit
      Left = 87
      Top = 60
      Width = 49
      Height = 21
      Css = 'nomargin width50chr'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtSelezione'
      SubmitOnAsyncEvent = True
      TabOrder = 22
    end
    object lblNessunAllegato: TmeIWLabel
      Left = 87
      Top = 280
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
      Font.Size = 10
      Font.Style = []
      HasTabOrder = False
      FriendlyName = 'lblNessunAllegato'
      Caption = 'nessuno'
      Enabled = True
    end
    object edtIDOriginale: TmeIWEdit
      Left = 142
      Top = 60
      Width = 49
      Height = 21
      Visible = False
      Css = 'width10chr'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtSelezione'
      SubmitOnAsyncEvent = True
      TabOrder = 24
    end
    object btnRispondi: TmedpIWImageButton
      Left = 391
      Top = 256
      Width = 89
      Height = 33
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
      BorderOptions.Width = 0
      TabOrder = -1
      UseSize = False
      OnClick = btnRispondiClick
      Cacheable = True
      FriendlyName = 'btnRispondi'
      ImageFile.Filename = 'img\btnInviaMessaggio2.png'
      medpDownloadButton = False
      Caption = 'Rispondi'
    end
    object btnStorico: TmedpIWImageButton
      Left = 486
      Top = 256
      Width = 89
      Height = 33
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
      BorderOptions.Width = 0
      TabOrder = -1
      UseSize = False
      OnClick = btnStoricoClick
      Cacheable = True
      FriendlyName = 'btnStorico'
      ImageFile.Filename = 'img\btnElenco2.png'
      medpDownloadButton = False
      Caption = 'Storico del messaggio'
    end
    object imgScegliDestOperatori: TmeIWImageFile
      Left = 87
      Top = 29
      Width = 42
      Height = 25
      Hint = 'Selezione operatori'
      ExtraTagParams.Strings = (
        'style=vertical-align: top;')
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
      OnClick = imgScegliDestOperatoriClick
      Cacheable = True
      FriendlyName = 'imgScegliDestOperatori'
      medpDownloadButton = False
    end
    object chkLetturaObbligatoria: TmeIWCheckBox
      Left = 85
      Top = 236
      Width = 228
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
      Caption = 'Richiedi lettura obbligatoria'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 27
      Checked = False
      FriendlyName = 'chkLetturaObbligatoria'
    end
    object lblLimiteAllegatiRaggiunto: TmeIWLabel
      Left = 87
      Top = 335
      Width = 160
      Height = 16
      Css = 'esclamazione'
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
      FriendlyName = 'lblLimiteAllegatiRaggiunto'
      Caption = 'lblLimiteAllegatiRaggiunto'
      RawText = True
      Enabled = True
    end
    object lblQuotaAllegati: TmeIWLabel
      Left = 459
      Top = 312
      Width = 86
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
      FriendlyName = 'lblQuotaAllegati'
      Caption = 'Quota allegati'
      Enabled = True
    end
    object imgAllegatiInfo: TmeIWImageFile
      Left = 56
      Top = 280
      Width = 25
      Height = 27
      ExtraTagParams.Strings = (
        'style=height:1.2em;width:1.2em;vertical-align:top;')
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
      FriendlyName = 'imgAllegatiInfo'
      ImageFile.Filename = 'img\btnInfoCircle.png'
      medpDownloadButton = False
    end
    object IWFile: TmeIWFileUploader
      Left = 87
      Top = 302
      Width = 207
      Height = 22
      TabOrder = 29
      TextStrings.DragText = 'Trascinare qui i file da caricare'
      TextStrings.UploadButtonText = 'Sfoglia...'
      TextStrings.CancelButtonText = 'Annulla'
      TextStrings.UploadErrorText = 'Upload fallito'
      TextStrings.MultipleFileDropNotAllowedText = #200' possibile trascinare un file solo'
      TextStrings.OfTotalText = 'di'
      TextStrings.RemoveButtonText = 'Rimuovi'
      TextStrings.TypeErrorText = 
        '{file} ha estensione non valida. Sono consentiti solo i file {ex' +
        'tensions}.'
      TextStrings.SizeErrorText = 
        '{file} '#232' troppo grande, la dimensione massima consentita '#232' {size' +
        'Limit}.'
      TextStrings.MinSizeErrorText = 
        '{file} '#232' troppo piccolo, la dimensione minima consentita '#232' {minS' +
        'izeLimit}.'
      TextStrings.EmptyErrorText = '{file} '#232' vuoto, ripetere la selezione escludendo questo file.'
      TextStrings.NoFilesErrorText = 'Nessun file da caricare.'
      TextStrings.OnLeaveWarningText = 
        #200' in corso il caricamento dei file, se si abbandona ora la proce' +
        'dura di upload sar'#224' annullata.'
      Style.ButtonOptions.Alignment = taCenter
      Style.ButtonOptions.Font.Color = clWebWHITE
      Style.ButtonOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ButtonOptions.Font.Size = 10
      Style.ButtonOptions.Font.Style = []
      Style.ButtonOptions.FromColor = clWebMAROON
      Style.ButtonOptions.ToColor = clWebMAROON
      Style.ButtonOptions.Height = 30
      Style.ButtonOptions.Width = 200
      Style.ButtonHoverOptions.Alignment = taCenter
      Style.ButtonHoverOptions.Font.Color = clWebWHITE
      Style.ButtonHoverOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ButtonHoverOptions.Font.Size = 10
      Style.ButtonHoverOptions.Font.Style = []
      Style.ButtonHoverOptions.FromColor = 214
      Style.ButtonHoverOptions.ToColor = 214
      Style.ListOptions.Alignment = taLeftJustify
      Style.ListOptions.Font.Color = clWebBLACK
      Style.ListOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ListOptions.Font.Size = 10
      Style.ListOptions.Font.Style = []
      Style.ListOptions.FromColor = clWebGOLD
      Style.ListOptions.ToColor = clWebGOLD
      Style.ListOptions.Height = 30
      Style.ListOptions.Width = 0
      Style.ListSuccessOptions.Alignment = taLeftJustify
      Style.ListSuccessOptions.Font.Color = clWebWHITE
      Style.ListSuccessOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ListSuccessOptions.Font.Size = 10
      Style.ListSuccessOptions.Font.Style = []
      Style.ListSuccessOptions.FromColor = clWebFORESTGREEN
      Style.ListSuccessOptions.ToColor = clWebFORESTGREEN
      Style.ListErrorOptions.Alignment = taLeftJustify
      Style.ListErrorOptions.Font.Color = clWebWHITE
      Style.ListErrorOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.ListErrorOptions.Font.Size = 10
      Style.ListErrorOptions.Font.Style = []
      Style.ListErrorOptions.FromColor = clWebRED
      Style.ListErrorOptions.ToColor = clWebRED
      Style.DropAreaOptions.Alignment = taCenter
      Style.DropAreaOptions.Font.Color = clWebWHITE
      Style.DropAreaOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.DropAreaOptions.Font.Size = 10
      Style.DropAreaOptions.Font.Style = []
      Style.DropAreaOptions.FromColor = clWebDARKORANGE
      Style.DropAreaOptions.ToColor = clWebDARKORANGE
      Style.DropAreaOptions.Height = 60
      Style.DropAreaOptions.Width = 0
      Style.DropAreaActiveOptions.Alignment = taCenter
      Style.DropAreaActiveOptions.Font.Color = clWebWHITE
      Style.DropAreaActiveOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
      Style.DropAreaActiveOptions.Font.Size = 10
      Style.DropAreaActiveOptions.Font.Style = []
      Style.DropAreaActiveOptions.FromColor = clWebLIMEGREEN
      Style.DropAreaActiveOptions.ToColor = clWebLIMEGREEN
      Style.DropAreaActiveOptions.Height = 60
      Style.DropAreaActiveOptions.Width = 0
      CssClasses.Strings = (
        'button=medpfileuploader-button'
        'button-hover=medpfileuploader-button-hover'
        'drop-area=medpfileuploader-drop-area'
        'drop-area-active=medpfileuploader-drop-area-active'
        'drop-area-disabled='
        'list=medpfileuploader-list'
        'upload-spinner=medpfileuploader-upload-spinner'
        'progress-bar='
        'upload-file=medpfileuploader-upload-file'
        'upload-size=medpfileuploader-upload-size'
        'upload-listItem=medpfileuploader-upload-listItem'
        'upload-cancel=medpfileuploader-upload-cancel'
        'upload-success=medpfileuploader-upload-success'
        'upload-fail=medpfileuploader-upload-fail'
        'success-icon=medpfileuploader-success-icon'
        'fail-icon=medpfileuploader-fail-icon')
      FriendlyName = 'IWFile'
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      MEdpCaptionPulsanteUpload = 'Upload'
      MEdpCssPulsanteUpload = 'pulsante'
      MEdpIncludiPulsanteUpload = True
      MEdpPulsanteAzioneDopoUpload = btnHdnUpload
      MEdpPulsanteEnabled = True
      MEdpPulsanteVisible = True
      MEdpMaxFileSize = -1
      MEdpRipristinaAlRender = True
    end
  end
  object rgnDestinatari: TmeIWRegion [11]
    Left = 399
    Top = 13
    Width = 365
    Height = 167
    Visible = False
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpDestinatari
    object grdDestinatari: TmedpIWDBGrid
      Left = 16
      Top = 62
      Width = 329
      Height = 66
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
      Caption = 'Destinatari'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdDestinatariRenderCell
      Summary = 'Elenco dei destinatari del messaggio'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdDestinatari'
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
      medpContextMenu = pmnDestinatari
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
    object rgpFiltroDest: TmeIWRadioGroup
      Left = 14
      Top = 34
      Width = 179
      Height = 22
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
      OnClick = rgpFiltroDestClick
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpFiltroDest'
      ItemIndex = 0
      Items.Strings = (
        'tutti'
        'ricevuto'
        'non ricevuto')
      Layout = glHorizontal
      TabOrder = 28
    end
    object btnChiudiDest: TmeIWButton
      Left = 272
      Top = 134
      Width = 76
      Height = 25
      Visible = False
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudiDest'
      TabOrder = 23
      OnClick = btnChiudiDestClick
      medpDownloadButton = False
    end
    object lblFiltroDest: TmeIWLabel
      Left = 8
      Top = 7
      Width = 102
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
      FriendlyName = 'lblFiltroDest'
      Caption = 'Filtro destinatari'
      Enabled = True
    end
  end
  object rgnElenco: TmeIWRegion [12]
    Left = 770
    Top = 13
    Width = 349
    Height = 261
    Visible = False
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpElenco
    object grdElenco: TmedpIWDBGrid
      Left = 16
      Top = 58
      Width = 313
      Height = 71
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
      Caption = 'Elenco messaggi'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdElencoRenderCell
      Summary = 'Elenco dei messaggi'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdElenco'
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
    object btnChiudiElenco: TmeIWButton
      Left = 251
      Top = 226
      Width = 76
      Height = 25
      Visible = False
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudiDest'
      TabOrder = 25
      OnClick = btnChiudiElencoClick
      medpDownloadButton = False
    end
    object memElencoTesto: TmeIWDBMemo
      Left = 16
      Top = 139
      Width = 313
      Height = 81
      Css = 'nomargin width99pc height12'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clNone
      Editable = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 26
      SubmitOnAsyncEvent = True
      AutoEditable = False
      DataField = 'TESTO'
      FriendlyName = 'memElencoTesto'
    end
  end
  object tpDati: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W035FDatiRG.html'
    RenderStyles = False
    Left = 728
    Top = 192
  end
  object tpDestinatari: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W035FDestinatariRG.html'
    RenderStyles = False
    Left = 712
    Top = 24
  end
  object jqDestinatari: TIWJQueryWidget
    Enabled = True
    Left = 647
    Top = 24
  end
  object cdsDestinatari: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 693
    Top = 80
    object cdsDestinatariUTENTE: TStringField
      DisplayLabel = 'Utente'
      FieldName = 'UTENTE'
      Size = 30
    end
    object cdsDestinatariPROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object cdsDestinatariMATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object cdsDestinatariCOGNOME: TStringField
      DisplayLabel = 'Cognome'
      DisplayWidth = 30
      FieldName = 'COGNOME'
      Size = 50
    end
    object cdsDestinatariNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object cdsDestinatariDATA_LETTURA: TDateTimeField
      DisplayLabel = 'Letto'
      FieldName = 'DATA_LETTURA'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy hhhh.mm'
    end
    object cdsDestinatariDATA_RICEZIONE: TDateTimeField
      DisplayLabel = 'Ricevuto'
      FieldName = 'DATA_RICEZIONE'
      DisplayFormat = 'dd/mm/yyyy hhhh.mm'
    end
  end
  object pmnTabella: TPopupMenu
    Left = 552
    Top = 616
    object mnuEsportaExcel: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuEsportaExcelClick
    end
    object mnuEsportaCsv: TMenuItem
      Caption = 'Esporta in CSV'
      Hint = 'file_csv'
      OnClick = mnuEsportaCsvClick
    end
  end
  object jqDettaglio: TIWJQueryWidget
    Enabled = True
    Left = 680
    Top = 192
  end
  object pmnDestinatari: TPopupMenu
    Left = 616
    Top = 80
    object mnuDestExcel: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuDestExcelClick
    end
    object mnuDestCsv: TMenuItem
      Caption = 'Esporta in CSV'
      Hint = 'file_csv'
      OnClick = mnuDestCsvClick
    end
  end
  object jqElenco: TIWJQueryWidget
    Enabled = True
    Left = 968
    Top = 24
  end
  object tpElenco: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W035FElencoRG.html'
    RenderStyles = False
    Left = 1024
    Top = 24
  end
  object jqQuotaAllegati: TIWJQueryWidget
    Enabled = True
    Left = 624
    Top = 488
  end
end
