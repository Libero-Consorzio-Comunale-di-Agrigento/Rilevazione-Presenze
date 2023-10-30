inherited W051FBudgetStraordinario: TW051FBudgetStraordinario
  Tag = 460
  Height = 546
  HelpType = htKeyword
  HelpKeyword = 'W051P0'
  JavaScript.Strings = (
    '$(document).ready(function(){'
    '$("#rgpTipo").remove();'
    '$("#RGPPERIODO").hide();'
    '});')
  ExplicitHeight = 546
  DesignLeft = 8
  DesignTop = 8
  inherited grdRichieste: TmedpIWDBGrid
    Caption = 'Richieste budget'
    Summary = 'Richieste di variazione budget'
    DataSource = dsrT700
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
  end
  object tabBudget: TmedpIWTabControl [9]
    Left = 16
    Top = 296
    Width = 300
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
    Caption = 'tabBudget'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'tabBudget'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
  end
  object W051GestioneRG: TmeIWRegion [10]
    Left = 16
    Top = 327
    Width = 513
    Height = 207
    RenderInvisibleControls = True
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpGestione
    object lblAnno: TmeIWLabel
      Left = 16
      Top = 32
      Width = 31
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
      FriendlyName = 'lblAnno'
      Caption = 'Anno'
      Enabled = True
    end
    object cmbAnno: TmeIWComboBox
      Left = 69
      Top = 27
      Width = 121
      Height = 21
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
      OnChange = cmbAnnoChange
      UseSize = False
      TabOrder = 6
      ItemIndex = -1
      FriendlyName = 'cmbAnno'
      NoSelectionText = '-- No Selection --'
    end
    object grdBudget: TmedpIWDBGrid
      Left = 16
      Top = 65
      Width = 478
      Height = 57
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
      Caption = 'Budget disponibili'
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
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdBudget'
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
      medpContextMenu = pmnBudget
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
      OnAfterCaricaCDS = grdBudgetAfterCaricaCDS
    end
    object grdDettaglio: TmedpIWDBGrid
      Left = 16
      Top = 136
      Width = 478
      Height = 57
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
      Caption = 'Dettaglio mesi'
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
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdDettaglio'
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
      medpContextMenu = pmnDettaglio
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
  object W051RichiesteRG: TmeIWRegion [11]
    Left = 237
    Top = 92
    Width = 233
    Height = 79
    RenderInvisibleControls = True
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpRichieste
  end
  inherited pmnTabella: TPopupMenu
    Left = 488
    Top = 208
  end
  object tpGestione: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W051FGestioneRG.html'
    Left = 432
    Top = 338
  end
  object dsrT700: TDataSource
    DataSet = cdsT700
    Left = 232
    Top = 216
  end
  object cdsT700: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 216
  end
  object tpRichieste: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W051FRichiesteRG.html'
    Left = 421
    Top = 116
  end
  object pmnBudget: TPopupMenu
    Left = 464
    Top = 399
    object mnuEsportaBudgetExcel: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuEsportaBudgetExcelClick
    end
    object mnuEsportaBudgetCsv: TMenuItem
      Caption = 'Esporta in CSV'
      Hint = 'file_csv'
      OnClick = mnuEsportaBudgetCsvClick
    end
  end
  object pmnDettaglio: TPopupMenu
    Left = 448
    Top = 471
    object mnuEsportaDettaglioExcel: TMenuItem
      Caption = 'Esporta in Excel'
      Hint = 'file_xls'
      OnClick = mnuEsportaDettaglioExcelClick
    end
    object mnuEsportaDettaglioCSV: TMenuItem
      Caption = 'Esporta in CSV'
      Hint = 'file_csv'
      OnClick = mnuEsportaDettaglioCSVClick
    end
  end
end
