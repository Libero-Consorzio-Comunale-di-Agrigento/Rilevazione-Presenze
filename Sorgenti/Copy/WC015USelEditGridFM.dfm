inherited WC015FSelEditGridFM: TWC015FSelEditGridFM
  Width = 577
  Height = 467
  ExplicitWidth = 577
  ExplicitHeight = 467
  inherited IWFrameRegion: TIWRegion
    Width = 577
    Height = 467
    ExplicitWidth = 577
    ExplicitHeight = 467
    object btnChiudi: TmeIWButton
      Left = 478
      Top = 407
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnChiudi'
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object grdElenco: TmedpIWDBGrid
      Left = 24
      Top = 104
      Width = 529
      Height = 281
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
      OnRenderCell = grdElencoRenderCell
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
      medpContextMenu = ppMnu
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
      OnAfterCaricaCDS = grdElencoAfterCaricaCDS
      OnDataSet2Componenti = grdElencoDataSet2Componenti
      OnComponenti2DataSet = grdElencoComponenti2DataSet
    end
    object btnConferma: TmeIWButton
      Left = 373
      Top = 407
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
      Caption = 'OK'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      TabOrder = 1
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object lblRicerca1: TmeIWLabel
      Left = 24
      Top = 69
      Width = 75
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
      FriendlyName = 'lblRicerca1'
      Caption = 'Ricerca per '
      Enabled = True
    end
    object edtRicerca: TmeIWEdit
      Left = 295
      Top = 64
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
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtRicerca'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      OnSubmit = edtRicercaSubmit
    end
    object btnRicercaSu: TmeIWImageFile
      Left = 475
      Top = 62
      Width = 25
      Height = 22
      Hint = 'Cerca precedente'
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
      OnClick = btnRicercaSuClick
      Cacheable = True
      FriendlyName = 'btnRicercaSu'
      ImageFile.Filename = 'img\btnSu.png'
      medpDownloadButton = False
    end
    object btnRicercaGiu: TmeIWImageFile
      Left = 444
      Top = 62
      Width = 25
      Height = 22
      Hint = 'Cerca successivo'
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
      OnClick = btnRicercaGiuClick
      Cacheable = True
      FriendlyName = 'btnRicercaGiu'
      ImageFile.Filename = 'img\btnGiu.png'
      medpDownloadButton = False
    end
    object btnRimuoviFiltro: TmeIWImageFile
      Left = 512
      Top = 62
      Width = 25
      Height = 22
      Hint = 'Rimuovi filtro'
      Css = 'spazio_sx'
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
      OnClick = btnRimuoviFiltroClick
      Cacheable = True
      FriendlyName = 'btnRimuoviFiltro'
      ImageFile.Filename = 'img\btnImbuto_Annulla.png'
      medpDownloadButton = False
    end
    object lblRicerca2: TmeIWLabel
      Left = 97
      Top = 69
      Width = 113
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
      FriendlyName = 'lblRicerca2'
      Caption = 'Contenuto/Iniziale'
      Enabled = True
    end
    object lblRicerca3: TmeIWLabel
      Left = 201
      Top = 68
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
      FriendlyName = 'lblRicerca3'
      Caption = ' in dato'
      Enabled = True
    end
    object rgpTipoRicerca: TmeIWRadioGroup
      Left = 84
      Top = 86
      Width = 138
      Height = 19
      Cursor = crDefault
      Css = 'radiogroup'
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
      FriendlyName = 'rgpTipoRicerca'
      ItemIndex = 0
      Items.Strings = (
        'Contenuto'
        'Iniziale')
      Layout = glHorizontal
      TabOrder = 3
      OnAsyncClick = rgpTipoRicercaAsyncClick
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WC015FSelEditGridFM.html'
  end
  object ppMnu: TPopupMenu
    Left = 192
    Top = 16
    object actScaricaInExcelWC015: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelWC015Click
    end
    object actScaricaInCSVWC015: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVWC015Click
    end
  end
end
