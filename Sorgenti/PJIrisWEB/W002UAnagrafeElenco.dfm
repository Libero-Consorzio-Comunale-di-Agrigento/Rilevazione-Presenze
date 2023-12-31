inherited W002FAnagrafeElenco: TW002FAnagrafeElenco
  Tag = -2
  Width = 610
  Height = 411
  HelpType = htKeyword
  HelpKeyword = 'W002P1'
  Title = '(W002) Elenco anagrafe'
  ExplicitWidth = 610
  ExplicitHeight = 411
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 6
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 0
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 1
    ExplicitTop = 32
  end
  object chkDipendentiCessati: TmeIWCheckBox [8]
    Left = 343
    Top = 148
    Width = 217
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
    Caption = 'Visualizza dipendenti cessati'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 3
    OnClick = chkDipendentiCessatiClick
    Checked = False
    FriendlyName = 'chkDipendentiCessati'
  end
  object lblDataLavoro: TmeIWLabel [9]
    Left = 56
    Top = 151
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
    ForControl = edtDataLavoro
    HasTabOrder = False
    FriendlyName = 'lblDataLavoro'
    Caption = 'Data di lavoro'
    Enabled = True
  end
  object edtDataLavoro: TmeIWEdit [10]
    Left = 148
    Top = 148
    Width = 90
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
    FriendlyName = 'edtDataLavoro'
    SubmitOnAsyncEvent = True
    TabOrder = 7
  end
  object btnApplicaData: TmeIWButton [11]
    Left = 254
    Top = 145
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
    Caption = 'Applica'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnApplicaData'
    TabOrder = 8
    OnClick = btnApplicaDataClick
    medpDownloadButton = False
  end
  object lblNomeRicerca: TmeIWLabel [12]
    Left = 56
    Top = 187
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
    FriendlyName = 'lblNomeRicerca'
    Caption = 'Selezione'
    Enabled = True
  end
  object edtNomeRicerca: TmeIWEdit [13]
    Left = 146
    Top = 187
    Width = 143
    Height = 21
    Css = 'input15'
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
    FriendlyName = 'edtNomeRicerca'
    MaxLength = 20
    SubmitOnAsyncEvent = True
    TabOrder = 9
  end
  object btnSalvaRicerca: TmeIWButton [14]
    Left = 295
    Top = 187
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
    Caption = 'Salva'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnApplicaData'
    TabOrder = 10
    OnClick = btnSalvaRicercaClick
    medpDownloadButton = False
  end
  object btnCancellaRicerca: TmeIWButton [15]
    Left = 376
    Top = 187
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
    Caption = 'Cancella'
    Confirmation = 'Cancellare definitivamente la selezione anagrafica?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnCancellaRicerca'
    TabOrder = 11
    OnClick = btnCancellaRicercaClick
    medpDownloadButton = False
  end
  object lblNumRecord: TmeIWLabel [16]
    Left = 73
    Top = 246
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
    FriendlyName = 'lblNumRecord'
    Caption = 'Num. record'
    Enabled = True
  end
  object imgPrimo: TmeIWImageFile [17]
    Tag = 408
    Left = 19
    Top = 249
    Width = 16
    Height = 16
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    AltText = 'Prima pagina'
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = imgPaginaPrimaClick
    Cacheable = True
    FriendlyName = 'imgPrimo'
    medpDownloadButton = False
  end
  object imgPrec: TmeIWImageFile [18]
    Tag = 408
    Left = 46
    Top = 249
    Width = 16
    Height = 16
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    AltText = 'Pagina precedente'
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = imgPaginaPrecClick
    Cacheable = True
    FriendlyName = 'imgPrec'
    medpDownloadButton = False
  end
  object imgSucc: TmeIWImageFile [19]
    Tag = 408
    Left = 163
    Top = 249
    Width = 16
    Height = 16
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    AltText = 'Pagina successiva'
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = imgPaginaSuccClick
    Cacheable = True
    FriendlyName = 'imgSucc'
    medpDownloadButton = False
  end
  object imgUltimo: TmeIWImageFile [20]
    Tag = 408
    Left = 185
    Top = 249
    Width = 16
    Height = 16
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    AltText = 'Ultima pagina'
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = imgPaginaUltimaClick
    Cacheable = True
    FriendlyName = 'imgUltimo'
    medpDownloadButton = False
  end
  object grdAnagrafe: TmeIWDBGrid [21]
    Left = 19
    Top = 271
    Width = 566
    Height = 122
    Cursor = crPointer
    ExtraTagParams.Strings = (
      'summary=Elenco dei dipendenti gestiti')
    Css = 'grid'
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
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    OnRenderCell = grdAnagrafeRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = W001FIrisWebDtM.dsrAnagrafe
    FooterRowCount = 0
    FriendlyName = 'grdAnagrafe'
    FromStart = False
    HighlightColor = clNone
    HighlightRows = False
    Options = [dgShowTitles]
    RefreshMode = rmAutomatic
    RowLimit = 18
    RollOver = False
    RowClick = True
    RollOverColor = clNone
    RowHeaderColor = clNone
    RowAlternateColor = clNone
    RowCurrentColor = clNone
    TabOrder = -1
    medpContextMenu = pmnTabella
    medpFixedColumns = 0
  end
  object lblContaRecord: TmeIWLabel [22]
    Left = 488
    Top = 249
    Width = 83
    Height = 16
    Css = 'contatore align_right'
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
    FriendlyName = 'lblContaRecord'
    Caption = 'Record 0 di 0'
    Enabled = True
  end
  object lblAnagrafeCaption: TmeIWLabel [23]
    Left = 286
    Top = 249
    Width = 106
    Height = 16
    Css = 'tblCaption'
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
    FriendlyName = 'lblAnagrafeCaption'
    Caption = 'Elenco personale'
    Enabled = True
  end
  object lnkNotifica: TmeIWLink [24]
    Left = 506
    Top = 216
    Width = 65
    Height = 17
    Visible = False
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
    FriendlyName = 'lnkNotifica'
    OnClick = lnkNotificaClick
    TabOrder = 12
    RawText = True
    Caption = 'lnkNotifica'
    medpDownloadButton = False
  end
  object pmnTabella: TPopupMenu
    Left = 432
    Top = 336
    object mnuEsportaExcel: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuEsportaExcelClick
    end
    object mnuEsportaCSV: TMenuItem
      Caption = 'Esporta in CSV'
      Hint = 'file_csv'
      OnClick = mnuEsportaCSVClick
    end
  end
end
