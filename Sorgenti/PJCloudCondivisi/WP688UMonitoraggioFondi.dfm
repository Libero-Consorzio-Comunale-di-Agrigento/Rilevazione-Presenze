inherited WP688FMonitoraggioFondi: TWP688FMonitoraggioFondi
  Tag = 611
  Width = 745
  Height = 461
  ExplicitWidth = 745
  ExplicitHeight = 461
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 121
    ExplicitTop = 121
  end
  inherited btnShowElabError: TmeIWButton
    Left = 160
    Top = 90
    ExplicitLeft = 160
    ExplicitTop = 90
  end
  object lblDecorrenzaDa: TmeIWLabel [9]
    Left = 25
    Top = 160
    Width = 145
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
    FriendlyName = 'lblDecorrenzaDa'
    Caption = 'Dalla decorrenza fondo'
    Enabled = True
  end
  object edtDecorrenzaDa: TmeIWEdit [10]
    Left = 168
    Top = 160
    Width = 90
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDecorrenzaDa'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtDecorrenzaDaAsyncChange
  end
  object lblDecorrenzaA: TmeIWLabel [11]
    Left = 274
    Top = 160
    Width = 125
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
    FriendlyName = 'lblDecorrenzaA'
    Caption = 'Alla scadenza fondo'
    Enabled = True
  end
  object edtDecorrenzaA: TmeIWEdit [12]
    Left = 399
    Top = 160
    Width = 90
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDecorrenzaA'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtDecorrenzaAAsyncChange
  end
  object grdFondi: TmedpIWDBGrid [13]
    Tag = 558
    Left = 25
    Top = 230
    Width = 464
    Height = 70
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
    Caption = 'grdFondi'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    Summary = 'MonitoraggioFondi'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdFondi'
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
    medpContextMenu = pmnGrdTabella
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
  object lblVisualizzazione: TmeIWLabel [14]
    Left = 229
    Top = 208
    Width = 75
    Height = 16
    Css = 'tblCaption'
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
    FriendlyName = 'lblVisualizzazione'
    Caption = 'Elenco fondi'
    Enabled = True
  end
  object lblTipoTotalizzazione: TmeIWLabel [15]
    Left = 25
    Top = 355
    Width = 116
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
    FriendlyName = 'lblTipoTotalizzazione'
    Caption = 'Tipo totalizzazione'
    Enabled = True
  end
  object rgpTipoTotalizzazione: TmeIWRadioGroup [16]
    Left = 25
    Top = 377
    Width = 233
    Height = 27
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpTipoTotalizzazioneClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpTipoTotalizzazione'
    ItemIndex = 0
    Items.Strings = (
      'Fondo'
      'Raggruppamento'
      'Macrocategoria')
    Layout = glHorizontal
    TabOrder = 9
  end
  object btnDate: TmeIWButton [17]
    Left = 507
    Top = 159
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
    Caption = 'nascosto'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnDate'
    TabOrder = 10
    OnClick = btnDateClick
    medpDownloadButton = False
  end
  object btnInviaFile: TmeIWButton [18]
    Left = 20
    Top = 309
    Width = 186
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
    Caption = 'pulsante nascosto per invio file'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnInviaFile'
    TabOrder = 11
    OnClick = CopiaInExcelClick
    medpDownloadButton = False
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 644
    Top = 82
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 644
    Top = 138
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 644
    Top = 394
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 644
    Top = 202
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 644
    Top = 258
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 644
    Top = 322
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 645
  end
  object pmnGrdTabella: TPopupMenu
    Left = 210
    Top = 305
    object CopiaInExcel: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = CopiaInExcelClick
    end
    object CopiaInCSV: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = CopiaInCSVClick
    end
  end
end
