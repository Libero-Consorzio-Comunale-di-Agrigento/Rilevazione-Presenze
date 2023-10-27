inherited WR204FBrowseTabellaFM: TWR204FBrowseTabellaFM
  Width = 679
  Height = 362
  ExplicitWidth = 679
  ExplicitHeight = 362
  inherited IWFrameRegion: TIWRegion
    Width = 679
    Height = 362
    ExplicitWidth = 679
    ExplicitHeight = 362
    object grdTabella: TmedpIWDBGrid
      Left = 30
      Top = 72
      Width = 619
      Height = 265
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
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
      Lines = tlAll
      OnRenderCell = grdTabellaRenderCell
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdTabella'
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
      medpContextMenu = pmnGrdTabella
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
      OnAfterCaricaCDS = grdTabellaAfterCaricaCDS
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WR204FBrowseTabellaFM.html'
    Left = 88
  end
  object pmnGrdTabella: TPopupMenu
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
