inherited W044FAcquistoTicket: TW044FAcquistoTicket
  Tag = 466
  HelpType = htKeyword
  HelpKeyword = 'W044P0'
  DesignLeft = 8
  DesignTop = 8
  object grdAcquistoTicket: TmedpIWDBGrid [8]
    Left = 29
    Top = 161
    Width = 444
    Height = 88
    ExtraTagParams.Strings = (
      'summary=elenco delle pianificazioni giornaliere')
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
    Caption = 'Acquisti ticket / buoni pasto'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdAcquistoTicketRenderCell
    Summary = 'Elenco degli acquisti di ticket / buoni pasto'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdAcquistoTicket'
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
    medpContextMenu = pmnTabella
    medpTipoContatore = 'P'
    medpRighePagina = -1
    medpBrowse = True
    medpRowSelect = False
    medpEditMultiplo = False
    medpFixedColumns = 0
    medpComandiCustom = False
    medpComandiEdit = False
    medpComandiInsert = False
    medpComandoDelete = False
    OnAfterCaricaCDS = grdAcquistoTicketAfterCaricaCDS
    OnModifica = grdAcquistoTicketModifica
  end
  object pmnTabella: TPopupMenu
    Left = 327
    Top = 192
    object mnuEsportaExcel: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuEsportaExcelClick
    end
    object mnuEsportaCsv: TMenuItem
      Caption = 'Esporta in CSV'
      Hint = 'file_csv'
      OnClick = mnuEsportaCsvClick
    end
  end
end
