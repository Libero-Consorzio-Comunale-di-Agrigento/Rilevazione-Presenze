inherited WR102FGestTabella: TWR102FGestTabella
  Height = 331
  ExplicitHeight = 331
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Width = 329
    ExplicitWidth = 329
  end
  object lblNumRecord: TmeIWLabel [9]
    Left = 33
    Top = 416
    Width = 0
    Height = 0
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
    Enabled = True
  end
  object lblAnag: TmeIWLabel [10]
    Left = 177
    Top = 416
    Width = 0
    Height = 0
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
    FriendlyName = 'lblAnag'
    Enabled = True
  end
  object lblMessaggio: TmeIWLabel [11]
    Left = 331
    Top = 416
    Width = 0
    Height = 0
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
    FriendlyName = 'lblMessaggio'
    Enabled = True
  end
  object grdNavigatorBar: TmeIWGrid [12]
    Left = 16
    Top = 176
    Width = 329
    Height = 28
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
    FriendlyName = 'grdNavigatorBar'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = False
    ScrollToCurrentRow = False
  end
  object grdTabControl: TmedpIWTabControl [13]
    Left = 16
    Top = 105
    Width = 329
    Height = 33
    Css = 'gridTabControl'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
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
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdTabControl'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
    OnTabControlChange = grdTabControlTabControlChange
  end
  object grdToolBarStorico: TmeIWGrid [14]
    Left = 16
    Top = 144
    Width = 329
    Height = 26
    Visible = False
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
    FriendlyName = 'grdToolBarStorico'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = False
    ScrollToCurrentRow = False
  end
  object actlstNavigatorBar: TActionList
    Left = 294
    Top = 12
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
    object actVisioneCorrente: TAction
      Tag = 16
      Category = 'Storico'
      Caption = 'btnVisioneCorrente'
      Hint = 'Attiva / disattiva visione corrente'
      OnExecute = actVisioneCorrenteExecute
    end
    object actVisioneAnnuale: TAction
      Category = 'Storico'
      Enabled = False
      Hint = 'Visione annuale'
      Visible = False
      OnExecute = actVisioneAnnualeExecute
    end
    object actPrecedenteStorico: TAction
      Tag = 14
      Category = 'Storico'
      Caption = 'btnStoricoPrecedente'
      Hint = 'Storico precedente'
      OnExecute = actPrecedenteStoricoExecute
    end
    object actSelezioneStorico: TAction
      Tag = 1000
      Category = 'Storico'
      Caption = 'actSelezioneStorico'
    end
    object actSuccessivoStorico: TAction
      Tag = 15
      Category = 'Storico'
      Caption = 'btnStoricoSuccessivo'
      Hint = 'Storico successivo'
      OnExecute = actSuccessivoStoricoExecute
    end
    object actCopiaSu: TAction
      Tag = 13
      Category = 'Edit'
      Caption = 'btnCopia'
      Hint = 'Copia su'
      OnExecute = actCopiaSuExecute
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
  object CheckRelazioni: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  :result := MEDP_CHECK_RELAZIONI_ESISTENTI ('
      '  :MASCHERA, '
      '  :TABELLA, '
      '  :CHIAVE, '
      '  :DECORRENZA, '
      '  :SCADENZA);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000060000000E0000003A0052004500530055004C005400050000000000
      000000000000120000003A004D00410053004300480045005200410005000000
      0000000000000000100000003A0054004100420045004C004C00410005000000
      00000000000000000E0000003A00430048004900410056004500050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C0000000000000000000000120000003A00530043004100440045004E005A00
      41000C0000000000000000000000}
    Left = 612
    Top = 82
  end
end
