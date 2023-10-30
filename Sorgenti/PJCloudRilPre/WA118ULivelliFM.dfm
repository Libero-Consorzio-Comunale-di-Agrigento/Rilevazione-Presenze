inherited WA118FLivelliFM: TWA118FLivelliFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Height = 121
      Caption = 'Elenco livelli'
      Summary = 'Elenco dei livelli '
      ExplicitHeight = 121
    end
    object grdCampi: TmedpIWDBGrid
      Left = 30
      Top = 333
      Width = 619
      Height = 84
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
      Caption = 'Elenco livelli'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      Summary = 'Elenco dei livelli '
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
      medpContextMenu = pmnGrdTabellaDett
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
    object lblCampi: TmeIWLabel
      Left = 30
      Top = 274
      Width = 53
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
      FriendlyName = 'lblCampi'
      Caption = 'lblCampi'
      Enabled = True
    end
    object grdCampiNavBar: TmeIWGrid
      Left = 30
      Top = 296
      Width = 544
      Height = 31
      Css = 'medpToolBar'
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
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdDetailNavBar'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = False
      ScrollToCurrentRow = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA118FLivelliFM.html'
  end
  object actlstCampiNavBar: TActionList
    Left = 73
    Top = 304
    object actEstraiCampo: TAction
      Tag = 12
      Category = 'Funzioni'
      Caption = 'btnStampa'
      Hint = 'Estrai'
      OnExecute = actEstraiCampoExecute
    end
    object actAggiornaCampo: TAction
      Tag = 6
      Category = 'Funzioni'
      Caption = 'btnAggiorna'
      Hint = 'Aggiorna'
      OnExecute = actAggiornaCampoExecute
    end
    object actRicercaCampo: TAction
      Tag = 1
      Category = 'Cerca'
      Caption = 'btnCerca'
      Hint = 'Ricerca/Filtra'
      OnExecute = actRicercaExecute
    end
    object actPrimoCampo: TAction
      Tag = 2
      Category = 'Selezione'
      Caption = 'btnPrimo'
      Hint = 'Primo'
      OnExecute = actPrimoCampoExecute
    end
    object actPrecedenteCampo: TAction
      Tag = 3
      Category = 'Selezione'
      Caption = 'btnPrecedente'
      Hint = 'Precedente'
      OnExecute = actPrecedenteCampoExecute
    end
    object actSuccessivoCampo: TAction
      Tag = 4
      Category = 'Selezione'
      Caption = 'btnSuccessivo'
      Hint = 'Successivo'
      OnExecute = actSuccessivoCampoExecute
    end
    object actUltimoCampo: TAction
      Tag = 5
      Category = 'Selezione'
      Caption = 'btnUltimo'
      Hint = 'Ultimo'
      OnExecute = actUltimoCampoExecute
    end
    object actCopiaSuCampo: TAction
      Tag = 13
      Category = 'Edit'
      Caption = 'btnCopia'
      Hint = 'Copia su'
      Visible = False
      OnExecute = actCopiaSuCampoExecute
    end
    object actNuovoCampo: TAction
      Tag = 7
      Category = 'Edit'
      Caption = 'btnInserisci'
      Hint = 'Nuovo'
      OnExecute = actNuovoCampoExecute
    end
    object actModificaCampo: TAction
      Tag = 8
      Category = 'Edit'
      Caption = 'btnModifica'
      Hint = 'Modifica'
      OnExecute = actModificaCampoExecute
    end
    object actEliminaCampo: TAction
      Tag = 9
      Category = 'Edit'
      Caption = 'btnElimina'
      Hint = 'Elimina'
      OnExecute = actEliminaCampoExecute
    end
    object actAnnullaCampo: TAction
      Tag = 10
      Category = 'Validazione'
      Caption = 'btnAnnulla'
      Hint = 'Annulla'
      OnExecute = actAnnullaCampoExecute
    end
    object actConfermaCampo: TAction
      Tag = 11
      Category = 'Validazione'
      Caption = 'btnConferma'
      Hint = 'Conferma'
      OnExecute = actConfermaCampoExecute
    end
  end
end
