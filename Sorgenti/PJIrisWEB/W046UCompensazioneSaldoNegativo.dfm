inherited W046FCompensazioneSaldoNegativo: TW046FCompensazioneSaldoNegativo
  Tag = 454
  Width = 680
  Height = 290
  HelpType = htKeyword
  HelpKeyword = 'W046P0'
  ExplicitWidth = 680
  ExplicitHeight = 290
  DesignLeft = 8
  DesignTop = 8
  object lblTitoloMese: TmeIWLabel [8]
    Left = 211
    Top = 141
    Width = 154
    Height = 16
    Css = 'tblCaption spazio_sx0'
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
    FriendlyName = 'lblTitoloMese'
    Caption = 'Mese di ...'
    Enabled = True
  end
  object grdMesiCSN: TmedpIWDBGrid [9]
    Left = 30
    Top = 170
    Width = 523
    Height = 75
    ExtraTagParams.Strings = (
      'summary=tabella contenente le richieste di straordinario mensile')
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
    BorderStyle = tfDefault
    Caption = 'Richieste di straordinario mensile'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdMesiCSNRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    DataSource = dsrMesiCSN
    FooterRowCount = 0
    FriendlyName = 'grdMesiCSN'
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
    OnAfterCaricaCDS = grdMesiCSNAfterCaricaCDS
  end
  object selT070: TOracleDataSet
    SQL.Strings = (
      'select T070.*, T070.ROWID'
      'from T070_SCHEDARIEPIL T070'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and DATA = :DATA')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    CommitOnPost = False
    Left = 502
    Top = 126
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 607
    Top = 24
  end
  object cdsMesiCSN: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 190
  end
  object dsrMesiCSN: TDataSource
    DataSet = cdsMesiCSN
    Left = 501
    Top = 190
  end
  object selMesiCSN: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'MESE'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'SALDOCOMPL_ORIG'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'ORERECDISP_ORIG'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'COMPEFF_ORIG'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'COMPMAX_ATT'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'SALDOCOMPL_ATT'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'ORERECDISP_ATT'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'MESSAGGI'
        DataType = ftString
        Size = 2000
      end
      item
        Name = 'MODIFICABILE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 190
  end
end
