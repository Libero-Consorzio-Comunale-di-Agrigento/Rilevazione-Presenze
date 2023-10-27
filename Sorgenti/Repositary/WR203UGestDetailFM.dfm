inherited WR203FGestDetailFM: TWR203FGestDetailFM
  Height = 442
  ExplicitHeight = 442
  inherited IWFrameRegion: TIWRegion
    Height = 442
    ExplicitHeight = 442
    inherited grdTabella: TmedpIWDBGrid
      Top = 136
      medpContextMenu = pmnGrdTabellaDett
      ExplicitTop = 136
    end
    object grdDetailNavBar: TmeIWGrid
      Left = 30
      Top = 77
      Width = 544
      Height = 31
      Css = 'medpToolBar'
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
    Templates.Default = 'WR203FGestDetailFM.html'
    OnBeforeProcess = TemplateProcessorBeforeProcess
  end
  object actlstDetailNavBar: TActionList
    Left = 49
    Top = 64
    object actEstrai: TAction
      Tag = 12
      Category = 'Funzioni'
      Caption = 'btnStampa'
      Hint = 'Estrai'
      OnExecute = actEstraiExecute
    end
    object actAggiorna: TAction
      Tag = 6
      Category = 'Funzioni'
      Caption = 'btnAggiorna'
      Hint = 'Aggiorna'
      OnExecute = actAggiornaExecute
    end
    object actRicerca: TAction
      Tag = 1
      Category = 'Cerca'
      Caption = 'btnCerca'
      Hint = 'Ricerca/Filtra'
      OnExecute = actRicercaExecute
    end
    object actPrimo: TAction
      Tag = 2
      Category = 'Selezione'
      Caption = 'btnPrimo'
      Hint = 'Primo'
      OnExecute = actPrimoExecute
    end
    object actPrecedente: TAction
      Tag = 3
      Category = 'Selezione'
      Caption = 'btnPrecedente'
      Hint = 'Precedente'
      OnExecute = actPrecedenteExecute
    end
    object actSuccessivo: TAction
      Tag = 4
      Category = 'Selezione'
      Caption = 'btnSuccessivo'
      Hint = 'Successivo'
      OnExecute = actSuccessivoExecute
    end
    object actUltimo: TAction
      Tag = 5
      Category = 'Selezione'
      Caption = 'btnUltimo'
      Hint = 'Ultimo'
      OnExecute = actUltimoExecute
    end
    object actCopiaSu: TAction
      Tag = 13
      Category = 'Edit'
      Caption = 'btnCopia'
      Hint = 'Copia su'
      Visible = False
    end
    object actNuovo: TAction
      Tag = 7
      Category = 'Edit'
      Caption = 'btnInserisci'
      Hint = 'Nuovo'
      OnExecute = actNuovoExecute
    end
    object actModifica: TAction
      Tag = 8
      Category = 'Edit'
      Caption = 'btnModifica'
      Hint = 'Modifica'
      OnExecute = actModificaExecute
    end
    object actElimina: TAction
      Tag = 9
      Category = 'Edit'
      Caption = 'btnElimina'
      Hint = 'Elimina'
      OnExecute = actEliminaExecute
    end
    object actAnnulla: TAction
      Tag = 10
      Category = 'Validazione'
      Caption = 'btnAnnulla'
      Hint = 'Annulla'
      OnExecute = actAnnullaExecute
    end
    object actConferma: TAction
      Tag = 11
      Category = 'Validazione'
      Caption = 'btnConferma'
      Hint = 'Conferma'
      OnExecute = actConfermaExecute
    end
  end
  object pmnGrdTabellaDett: TPopupMenu
    Left = 546
    Top = 142
    object actScaricaInExcelDett: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelClick
    end
    object actScaricaInCSVDett: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVClick
    end
  end
end
