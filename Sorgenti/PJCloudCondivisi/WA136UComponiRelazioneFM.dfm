inherited WA136FComponiRelazioneFM: TWA136FComponiRelazioneFM
  Width = 756
  Height = 593
  ExplicitWidth = 756
  ExplicitHeight = 593
  inherited IWFrameRegion: TIWRegion
    Width = 756
    Height = 593
    Color = clWebALICEBLUE
    ExplicitWidth = 756
    ExplicitHeight = 593
    object lblTabellaPilotata: TmeIWLabel
      Left = 16
      Top = 120
      Width = 96
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
      FriendlyName = 'lblTabellaPilotata'
      Caption = 'Tabella pilotata'
      Enabled = True
    end
    object lblTabellaPilota: TmeIWLabel
      Left = 200
      Top = 120
      Width = 84
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
      FriendlyName = 'lblTabellaPilotata'
      Caption = 'Tabella pilota'
      Enabled = True
    end
    object lblColonnaPilotata: TmeIWLabel
      Left = 16
      Top = 184
      Width = 101
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
      FriendlyName = 'lblTabellaPilotata'
      Caption = 'Colonna pilotata'
      Enabled = True
    end
    object grdRelazioniCampi: TmedpIWDBGrid
      Left = 16
      Top = 256
      Width = 705
      Height = 249
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
      Caption = 'Abbinamenti'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdRelazioniCampiRenderCell
      Summary = 'composizione relazione'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdRelazioniCampi'
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
      medpContextMenu = pmnGrdRelazioniCampi
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = False
      medpEditMultiplo = True
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnDataSet2Componenti = grdRelazioniCampiDataSet2Componenti
      OnComponenti2DataSet = grdRelazioniCampiComponenti2DataSet
    end
    object lblColonnaPilota: TmeIWLabel
      Left = 200
      Top = 184
      Width = 89
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
      FriendlyName = 'lblTabellaPilotata'
      Caption = 'Colonna pilota'
      Enabled = True
    end
    object edtTabellaPilotata: TmeIWEdit
      Left = 16
      Top = 142
      Width = 121
      Height = 21
      Css = 'medpCalcolati width30chr'
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
      FriendlyName = 'edtTabellaPilotata'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 0
      Text = 'edtTabellaPilotata'
    end
    object edtColonnaPilotata: TmeIWEdit
      Left = 16
      Top = 206
      Width = 121
      Height = 21
      Css = 'medpCalcolati width30chr'
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
      FriendlyName = 'edtColonnaPilotata'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 1
      Text = 'edtColonnaPilotata'
    end
    object edtTabellaPilota: TmeIWEdit
      Left = 200
      Top = 142
      Width = 121
      Height = 21
      Css = 'medpCalcolati width30chr'
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
      FriendlyName = 'edtTabellaPilota'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 2
      Text = 'edtTabellaPilota'
    end
    object cmbColonnaPilota: TMedpIWMultiColumnComboBox
      Left = 200
      Top = 206
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
      FriendlyName = 'cmbColonnaPilota'
      SubmitOnAsyncEvent = True
      TabOrder = 3
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 1
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbColonnaPilotaChange
      medpAutoResetItems = True
      CssInputText = 'medpMultiColumnComboBoxInput width30chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblTipo: TmeIWLabel
      Left = 200
      Top = 63
      Width = 27
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
      FriendlyName = 'lblTipo'
      Caption = 'Tipo'
      Enabled = True
    end
    object edtTipo: TmeIWEdit
      Left = 200
      Top = 85
      Width = 41
      Height = 21
      Css = 'width1chr medpCalcolati'
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
      FriendlyName = 'edtTipo'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 4
      Text = 'edtTipo'
    end
    object lblDTipo: TmeIWLabel
      Left = 256
      Top = 85
      Width = 44
      Height = 16
      Css = 'descrizione'
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
      FriendlyName = 'lblDTipo'
      Caption = 'D_Tipo'
      Enabled = True
    end
    object lblDecorrenza: TmeIWLabel
      Left = 16
      Top = 63
      Width = 71
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
      FriendlyName = 'lblDecorrenza'
      Caption = 'Decorrenza'
      Enabled = True
    end
    object edtDecorrenza: TmeIWEdit
      Left = 16
      Top = 85
      Width = 96
      Height = 21
      Css = 'input10 medpCalcolati'
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
      FriendlyName = 'edtDecorrenza'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 5
      Text = 'edtDecorrenza'
    end
    object btnConferma: TmedpIWImageButton
      Left = 171
      Top = 528
      Width = 113
      Height = 24
      Css = 'width12chr align_left'
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
      OnClick = btnConfermaClick
      Cacheable = True
      FriendlyName = 'btnConferma'
      ImageFile.Filename = 'img\btnConferma.png'
      medpDownloadButton = False
      Caption = 'Conferma'
    end
    object btnAnnulla: TmedpIWImageButton
      Left = 312
      Top = 528
      Width = 113
      Height = 24
      Css = 'width12chr align_left'
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
      OnClick = btnAnnullaClick
      Cacheable = True
      FriendlyName = 'btnAnnulla'
      ImageFile.Filename = 'img\btnAnnulla.png'
      medpDownloadButton = False
      Caption = 'Annulla'
    end
    object btnModifica: TmedpIWImageButton
      Left = 16
      Top = 528
      Width = 113
      Height = 24
      Css = 'width12chr align_left'
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
      OnClick = btnModificaClick
      Cacheable = True
      FriendlyName = 'btnModifica'
      ImageFile.Filename = 'img\btnModifica.png'
      medpDownloadButton = False
      Caption = 'Modifica'
    end
    object btnChiudi: TmedpIWImageButton
      Left = 448
      Top = 528
      Width = 113
      Height = 24
      Css = 'width12chr align_left'
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
      OnClick = btnChiudiClick
      Cacheable = True
      FriendlyName = 'btnChiudi'
      ImageFile.Filename = 'img\btnChiudiScheda.png'
      medpDownloadButton = False
      Caption = 'Chiudi'
    end
  end
  object pmnGrdRelazioniCampi: TPopupMenu
    Left = 546
    Top = 14
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
