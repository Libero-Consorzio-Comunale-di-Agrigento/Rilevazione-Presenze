inherited W042FDatiConiuge: TW042FDatiConiuge
  Tag = 450
  Height = 255
  HelpType = htKeyword
  HelpKeyword = 'W042P0'
  ExplicitHeight = 255
  DesignLeft = 8
  DesignTop = 8
  object grdConiugi: TmedpIWDBGrid [6]
    Left = 22
    Top = 145
    Width = 606
    Height = 57
    Cursor = crAuto
    ExtraTagParams.Strings = (
      'summary=elenco delle pianificazioni giornaliere')
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
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'Coniuge'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdConiugiRenderCell
    UseFrame = False
    UseSize = False
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdConiugi'
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
    OnAfterCaricaCDS = grdConiugiAfterCaricaCDS
  end
end
