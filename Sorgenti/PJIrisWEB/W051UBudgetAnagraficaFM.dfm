inherited W051FBudgetAnagraficaFM: TW051FBudgetAnagraficaFM
  Width = 462
  Height = 371
  ExplicitWidth = 462
  ExplicitHeight = 371
  inherited IWFrameRegion: TIWRegion
    Width = 462
    Height = 371
    Color = clWebALICEBLUE
    ExplicitWidth = 462
    ExplicitHeight = 371
    object btnChiudi: TmedpIWImageButton
      Left = 315
      Top = 324
      Width = 122
      Height = 27
      Css = 'align_center'
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
      ImageFile.URL = 'img/btnChiudiScheda.png'
      medpDownloadButton = False
      Caption = 'Chiudi'
    end
    object grdAnagrafica: TmedpIWDBGrid
      Left = 25
      Top = 129
      Width = 424
      Height = 152
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
      Caption = 'Dipendenti selezionati'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      Summary = 'Dipendenti selezionati'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      DataSource = dsrAnagr
      FooterRowCount = 0
      FriendlyName = 'grdAnagrafica'
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
  end
  object cdsAnagr: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 250
    Top = 208
  end
  object dsrAnagr: TDataSource
    DataSet = cdsAnagr
    Left = 314
    Top = 209
  end
end