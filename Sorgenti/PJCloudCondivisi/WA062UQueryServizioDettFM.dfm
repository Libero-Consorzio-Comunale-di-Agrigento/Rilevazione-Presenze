inherited WA062FQueryServizioDettFM: TWA062FQueryServizioDettFM
  Width = 502
  Height = 467
  ExplicitWidth = 502
  ExplicitHeight = 467
  inherited IWFrameRegion: TIWRegion
    Width = 502
    Height = 467
    OnRender = IWFrameRegionRender
    ExplicitWidth = 502
    ExplicitHeight = 467
    object memoSql: TmeIWMemo
      Left = 19
      Top = 120
      Width = 414
      Height = 113
      Css = 'textarea_sql'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
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
      VertScrollBar = True
      Required = False
      SubmitOnAsyncEvent = True
      FriendlyName = 'memoSql'
    end
    object grdVariabili: TmedpIWDBGrid
      Left = 19
      Top = 270
      Width = 414
      Height = 113
      Css = 'grigliaDati grid'
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
      Caption = 'memoSql'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdVariabiliRenderCell
      Summary = 
        'Elenco delle variabili utilizzate dalla interrogazione con i ris' +
        'pettivi valori'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdVariabili'
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
      OnDataSet2Componenti = grdVariabiliDataSet2Componenti
      OnComponenti2DataSet = grdVariabiliComponenti2DataSet
      OnConferma = grdVariabiliConferma
    end
    object lblNome: TmeIWLabel
      Left = 27
      Top = 72
      Width = 36
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
      FriendlyName = 'lblSalvataggioRisultato'
      Caption = 'Nome'
      Enabled = True
    end
    object edtNome: TmeIWEdit
      Left = 69
      Top = 72
      Width = 121
      Height = 21
      Css = 'width40chr'
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
      FriendlyName = 'edtNomeTab'
      SubmitOnAsyncEvent = True
      TabOrder = 1
    end
    object btnRefreshVariabili: TmedpIWImageButton
      Left = 368
      Top = 79
      Width = 41
      Height = 26
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderOptions.Width = 0
      UseSize = False
      OnClick = btnRefreshVariabiliClick
      Cacheable = True
      FriendlyName = 'btnRefreshVariabili'
      ImageFile.Filename = 'img\btnRefresh.bmp'
      medpDownloadButton = False
      Caption = 'Refresh variabili'
    end
    object chkProtetta: TmeIWCheckBox
      Left = 224
      Top = 79
      Width = 121
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
      Caption = 'Protetta'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 2
      Checked = False
      FriendlyName = 'chkProtetta'
    end
    object lblInfo: TmeIWLabel
      Left = 19
      Top = 389
      Width = 0
      Height = 0
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
      FriendlyName = 'lblInfo'
      Enabled = True
    end
  end
end
