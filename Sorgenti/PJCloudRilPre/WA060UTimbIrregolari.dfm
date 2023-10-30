inherited WA060FTimbIrregolari: TWA060FTimbIrregolari
  Tag = 130
  Width = 859
  Height = 509
  Title = '(WA060) Timbrature irregolari'
  ExplicitWidth = 859
  ExplicitHeight = 509
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 16
    Top = 174
    ExplicitLeft = 16
    ExplicitTop = 174
  end
  inherited btnShowElabError: TmeIWButton
    Left = 16
    Top = 143
    ExplicitLeft = 16
    ExplicitTop = 143
  end
  object lblDaData: TmeIWLabel [9]
    Left = 30
    Top = 232
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
    Left = 119
    Top = 232
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
    OnAsyncChange = edtDaDataAsyncChange
  end
  object lblAData: TmeIWLabel [11]
    Left = 30
    Top = 259
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
    Left = 119
    Top = 259
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
    OnAsyncChange = edtDaDataAsyncChange
  end
  object lblDalBadge: TmeIWLabel [13]
    Left = 286
    Top = 232
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
    FriendlyName = 'lblDalBadge'
    Caption = 'Dal Badge'
    Enabled = True
  end
  object lblAlBadge: TmeIWLabel [14]
    Left = 286
    Top = 264
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
    FriendlyName = 'lblAlBadge'
    Caption = 'Al Badge'
    Enabled = True
  end
  object lblAzienda: TmeIWLabel [15]
    Left = 30
    Top = 296
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
    FriendlyName = 'lblAzienda'
    Caption = 'Azienda:'
    Enabled = True
  end
  object lblBadge: TmeIWLabel [16]
    Left = 30
    Top = 318
    Width = 44
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
    FriendlyName = 'lblBadge'
    Caption = 'Badge:'
    Enabled = True
  end
  object lblAziendaDescr: TmeIWLabel [17]
    Left = 100
    Top = 296
    Width = 0
    Height = 0
    Css = 'fontGreen'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clWebGREEN
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblAziendaDescr'
    Enabled = True
  end
  object lblBadgeDescr: TmeIWLabel [18]
    Left = 100
    Top = 318
    Width = 0
    Height = 0
    Css = 'fontRed'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clWebGREEN
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblBadgeDescr'
    Enabled = True
  end
  object btnIniziaRecupero: TmedpIWImageButton [19]
    Left = 160
    Top = 348
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
    OnClick = btnIniziaRecuperoClick
    Cacheable = True
    FriendlyName = 'btnIniziaRecupero'
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Inizia recupero'
  end
  object btnCancella: TmedpIWImageButton [20]
    Left = 297
    Top = 348
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
    OnClick = btnCancellaClick
    Cacheable = True
    FriendlyName = 'btnCancella'
    ImageFile.Filename = 'img\btnCestino.png'
    medpDownloadButton = False
    Caption = 'Cancella'
  end
  object grdRisultati: TmedpIWDBGrid [21]
    Left = 160
    Top = 405
    Width = 317
    Height = 76
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
    Summary = 'Timbrature irregolari'
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
  object btnRefresh: TmedpIWImageButton [22]
    Left = 30
    Top = 348
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
    OnClick = btnRefreshClick
    Cacheable = True
    FriendlyName = 'btnRefresh'
    ImageFile.Filename = 'img\btnRefresh.bmp'
    medpDownloadButton = False
    Caption = 'Carica Timbrature'
  end
  object lblDaChiave: TmeIWLabel [23]
    Left = 478
    Top = 232
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
    HasTabOrder = False
    FriendlyName = 'lblDaChiave'
    Caption = 'Da chiave'
    Enabled = True
  end
  object lblAChiave: TmeIWLabel [24]
    Left = 478
    Top = 264
    Width = 52
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
    FriendlyName = 'lblAChiave'
    Caption = 'A chiave'
    Enabled = True
  end
  object lblDaScarico: TmeIWLabel [25]
    Left = 670
    Top = 228
    Width = 64
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
    FriendlyName = 'lblDaScarico'
    Caption = 'Da scarico'
    Enabled = True
  end
  object lblAScarico: TmeIWLabel [26]
    Left = 670
    Top = 260
    Width = 57
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
    FriendlyName = 'lblAScarico'
    Caption = 'A scarico'
    Enabled = True
  end
  object cmbDaBadge: TmeIWComboBox [27]
    Left = 351
    Top = 231
    Width = 121
    Height = 21
    Css = 'width10chr'
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
    RequireSelection = False
    OnChange = cmbChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 9
    ItemIndex = -1
    FriendlyName = 'cmbDaBadge'
    NoSelectionText = ' '
  end
  object cmbABadge: TmeIWComboBox [28]
    Left = 351
    Top = 264
    Width = 121
    Height = 21
    Css = 'width10chr'
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
    RequireSelection = False
    OnChange = cmbChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 10
    ItemIndex = -1
    FriendlyName = 'cmbABadge'
    NoSelectionText = ' '
  end
  object cmbDaChiave: TmeIWComboBox [29]
    Left = 543
    Top = 231
    Width = 121
    Height = 21
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
    RequireSelection = False
    OnChange = cmbChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 11
    ItemIndex = -1
    FriendlyName = 'cmbDaChiave'
    NoSelectionText = ' '
  end
  object cmbAChiave: TmeIWComboBox [30]
    Left = 543
    Top = 264
    Width = 121
    Height = 21
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
    RequireSelection = False
    OnChange = cmbChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 12
    ItemIndex = -1
    FriendlyName = 'cmbAChiave'
    NoSelectionText = ' '
  end
  object cmbDaScarico: TmeIWComboBox [31]
    Left = 735
    Top = 228
    Width = 121
    Height = 21
    Css = 'width10chr'
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
    RequireSelection = False
    OnChange = cmbChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 13
    ItemIndex = -1
    FriendlyName = 'cmbDaScarico'
    NoSelectionText = ' '
  end
  object cmbAScarico: TmeIWComboBox [32]
    Left = 735
    Top = 255
    Width = 121
    Height = 21
    Css = 'width10chr'
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
    RequireSelection = False
    OnChange = cmbChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 14
    ItemIndex = -1
    FriendlyName = 'cmbAScarico'
    NoSelectionText = ' '
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 400
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 400
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 544
    Top = 152
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 400
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 544
    Top = 32
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 544
    Top = 96
  end
  object pmnAzioni: TPopupMenu
    Left = 280
    Top = 16
    object actScaricaInExcel: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelClick
    end
    object actScaricaInCSV: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVClick
    end
  end
end
