inherited W038FBollatriceVirtuale: TW038FBollatriceVirtuale
  Tag = 451
  Width = 780
  Height = 415
  HelpType = htKeyword
  HelpKeyword = 'W038P0'
  ExplicitWidth = 780
  ExplicitHeight = 415
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 6
  end
  object grdTimbrature: TmedpIWDBGrid [8]
    Left = 227
    Top = 332
    Width = 271
    Height = 62
    Visible = False
    Css = 'grid'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clWebWHITE
    BorderColors.Light = clWebWHITE
    BorderColors.Dark = clWebWHITE
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    Caption = 'Timbrature'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    Summary = 'Elenco timbrature del giorno corrente'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdTimbrature'
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
  object lblOraCorrente: TmeIWLabel [9]
    Left = 312
    Top = 160
    Width = 92
    Height = 16
    Css = 'invisibile'
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
    FriendlyName = 'lblOraCorrente'
    Caption = 'lblOraCorrente'
    Enabled = True
  end
  object btnEntrata: TmedpIWImageButton [10]
    Left = 227
    Top = 285
    Width = 70
    Height = 23
    Hint = 'Registra entrata'
    Css = 'width15chr'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    ScriptEvents = <
      item
        EventCode.Strings = (
          'ShowBusy(true);'
          'return true;')
        Event = 'onClick'
      end>
    TabOrder = -1
    UseSize = False
    OnAsyncClick = btnEntrataAsyncClick
    Cacheable = False
    FriendlyName = 'btnEntrata'
    ImageFile.Filename = 'img\btnDx.png'
    medpDownloadButton = False
    Caption = 'ENTRA'
  end
  object btnUscita: TmedpIWImageButton [11]
    Left = 424
    Top = 285
    Width = 74
    Height = 23
    Hint = 'Registra uscita'
    Css = 'width15chr'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    ScriptEvents = <
      item
        EventCode.Strings = (
          'ShowBusy(true);'
          'return true;')
        Event = 'onClick'
      end>
    TabOrder = -1
    UseSize = False
    OnAsyncClick = btnUscitaAsyncClick
    Cacheable = True
    FriendlyName = 'btnEntrata'
    ImageFile.Filename = 'img\btnSx.png'
    medpDownloadButton = False
    Caption = 'ESCI'
  end
  object btnRegistraEntrata: TmeIWButton [12]
    Left = 601
    Top = 263
    Width = 163
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
    Caption = 'nascosto btnRegistraEntrata'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnRegistraEntrata'
    TabOrder = 5
    OnClick = btnRegistraEntrataClick
    medpDownloadButton = False
  end
  object btnRegistraUscita: TmeIWButton [13]
    Left = 601
    Top = 287
    Width = 163
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
    Caption = 'nascosto btnRegistraUscita'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnRegistraUscita'
    TabOrder = 7
    OnClick = btnRegistraUscitaClick
    medpDownloadButton = False
  end
  object meIWMemo1: TmeIWMemo [14]
    Left = 200
    Top = 81
    Width = 537
    Height = 56
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BGColor = clNone
    Editable = True
    Font.Color = clWebRED
    Font.Enabled = False
    Font.Size = 12
    Font.Style = []
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 8
    SubmitOnAsyncEvent = True
    FriendlyName = 'meIWMemo1'
    Lines.Strings = (
      
        'ATTENZIONE i pulsanti btnEntrata e btnUscita contengono  scriptE' +
        'vent.'
      
        'Questo per inibire eventuali doppiClick in rapidissima successio' +
        'ne')
  end
  object btnCambiaProgressivo: TmeIWButton [15]
    Left = 601
    Top = 308
    Width = 163
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
    Caption = 'nascosto btnCambiaProgressivo'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnCambiaProgressivo'
    TabOrder = 9
    OnClick = btnCambiaProgressivoClick
    medpDownloadButton = False
  end
  object lblEntrata: TmeIWLabel [16]
    Left = 227
    Top = 241
    Width = 59
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
    FriendlyName = 'lblEntrata'
    Caption = 'lblEntrata'
    RawText = True
    OnAsyncClick = lblEntrataAsyncClick
    Enabled = True
  end
  object lblUscita: TmeIWLabel [17]
    Left = 424
    Top = 241
    Width = 51
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
    FriendlyName = 'lblUscita'
    Caption = 'lblUscita'
    RawText = True
    OnAsyncClick = lblUscitaAsyncClick
    Enabled = True
  end
  object lblOraEntrata: TmeIWLabel [18]
    Left = 227
    Top = 263
    Width = 82
    Height = 16
    Css = 'intestazione etichettaTimbratura'
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
    FriendlyName = 'lblOraEntrata'
    Caption = 'lblOraEntrata'
    RawText = True
    OnAsyncClick = lblEntrataAsyncClick
    Enabled = True
  end
  object lblOraUscita: TmeIWLabel [19]
    Left = 424
    Top = 263
    Width = 74
    Height = 16
    Css = 'intestazione etichettaTimbratura'
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
    FriendlyName = 'lblOraUscita'
    Caption = 'lblOraUscita'
    RawText = True
    OnAsyncClick = lblUscitaAsyncClick
    Enabled = True
  end
  object cmbCausale: TmeIWComboBox [20]
    Left = 312
    Top = 200
    Width = 186
    Height = 21
    Css = 'width100pc fontcourier'
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
    ItemsHaveValues = True
    UseSize = False
    TabOrder = 10
    ItemIndex = -1
    FriendlyName = 'cmbCausale'
    NoSelectionText = ' '
  end
  object lblCausale: TmeIWLabel [21]
    Left = 228
    Top = 200
    Width = 49
    Height = 16
    Css = 'intestazione font_grassetto'
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
    ForControl = cmbCausale
    HasTabOrder = False
    FriendlyName = 'lblCausale'
    Caption = 'Causale'
    Enabled = True
  end
  object lblClock: TmeIWLabel [22]
    Left = 335
    Top = 241
    Width = 47
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
    FriendlyName = 'lblClock'
    Caption = 'lblClock'
    RawText = True
    Enabled = True
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 520
    Top = 24
  end
end
