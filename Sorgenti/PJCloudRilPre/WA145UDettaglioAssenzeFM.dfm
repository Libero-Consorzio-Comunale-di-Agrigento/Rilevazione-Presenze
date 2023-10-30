inherited WA145FDettaglioAssenzeFM: TWA145FDettaglioAssenzeFM
  inherited IWFrameRegion: TIWRegion
    object btnChiudi: TmeIWButton
      Left = 252
      Top = 129
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object grdDettaglio: TmeIWGrid
      Left = 24
      Top = 24
      Width = 257
      Height = 89
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
      Caption = 'grdDettaglio'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlNone
      OnRenderCell = grdDettaglioRenderCell
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdDettaglio'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
      medpContextMenu = pmnGrdDettaglio
    end
  end
  object pmnGrdDettaglio: TPopupMenu
    Left = 226
    Top = 53
    object actScaricaInExcelDett: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelDettClick
    end
    object actScaricaInCSVDett: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVDettClick
    end
  end
end
