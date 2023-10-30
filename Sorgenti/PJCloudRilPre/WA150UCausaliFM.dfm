inherited WA150FCausaliFM: TWA150FCausaliFM
  Height = 518
  ExplicitHeight = 518
  inherited IWFrameRegion: TIWRegion
    Height = 518
    ExplicitHeight = 518
    inherited grdTabella: TmedpIWDBGrid
      Top = 114
      Height = 177
      Caption = 'Codici di accorpamento'
      Summary = 'Codici Accorpamento Causali'
      ExplicitTop = 114
      ExplicitHeight = 177
    end
    object grdAccorpCausali: TmedpIWDBGrid
      Left = 30
      Top = 352
      Width = 619
      Height = 153
      Cursor = crAuto
      Css = 'grid'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'Causali accorpate'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdAccorpCausaliRenderCell
      Summary = 'Causali Assenze'
      UseFrame = False
      UseSize = False
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdAccorpCausali'
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
    object grdAccorpCausaliNavBar: TmeIWGrid
      Left = 30
      Top = 315
      Width = 544
      Height = 31
      Cursor = crAuto
      Css = 'medpToolBar'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = True
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
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
      CellRenderOptions = []
      FriendlyName = 'grdAccorpCausaliNavBar'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = False
      ScrollToCurrentRow = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA150FCausaliFM.html'
  end
  inherited actlstDetailNavBar: TActionList
    Left = 57
  end
  object actlstAccorpCausaliNavBar: TActionList
    Left = 57
    Top = 304
    object actAccorpAggiorna: TAction
      Caption = 'btnAggiorna'
      Hint = 'Aggiorna'
      OnExecute = actAccorpAggiornaExecute
    end
    object actAccorpRicerca: TAction
      Caption = 'btnCerca'
      Hint = 'Ricerca/Filtra'
      OnExecute = actAccorpRicercaExecute
    end
    object actAccorpPrimo: TAction
      Tag = 1
      Caption = 'btnPrimo'
      Hint = 'Primo'
      OnExecute = actAccorpPrimoExecute
    end
    object actAccorpPrecedente: TAction
      Tag = 2
      Caption = 'btnPrecedente'
      Hint = 'Precedente'
      OnExecute = actAccorpPrecedenteExecute
    end
    object actAccorpSuccessivo: TAction
      Tag = 3
      Caption = 'btnSuccessivo'
      Hint = 'Successivo'
      OnExecute = actAccorpSuccessivoExecute
    end
    object actAccorpUltimo: TAction
      Tag = 4
      Caption = 'btnUltimo'
      Hint = 'Ultimo'
      OnExecute = actAccorpUltimoExecute
    end
  end
end
