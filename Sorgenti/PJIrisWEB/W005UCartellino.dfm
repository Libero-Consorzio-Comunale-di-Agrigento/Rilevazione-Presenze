inherited W005FCartellino: TW005FCartellino
  Tag = 400
  Width = 692
  Height = 532
  HelpType = htKeyword
  HelpKeyword = 'W005P0'
  Title = '(W005) Cartellino interattivo'
  ExplicitWidth = 692
  ExplicitHeight = 532
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 1
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 2
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 3
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 5
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 6
  end
  inherited lblCommentoCorrente: TmeIWLabel
    Width = 599
    Css = 'intestazione'
    Caption = 
      'Formato timbratura: Vhh.mm/causale(rilevatore) - V = E/U; causal' +
      'e e rilevatore sono opzionali'
    ExplicitWidth = 599
  end
  object btnEsegui: TmeIWButton [8]
    Left = 562
    Top = 247
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
    Caption = 'Visualizza'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEsegui'
    TabOrder = 11
    OnClick = btnEseguiClick
    medpDownloadButton = False
  end
  object edtPeriodoDal: TmeIWEdit [9]
    Left = 312
    Top = 251
    Width = 73
    Height = 21
    Hint = 
      'Periodo di inizio della visualizzazione del cartellino Formato d' +
      'dmmyyyy'
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 9
  end
  object edtPeriodoAl: TmeIWEdit [10]
    Left = 409
    Top = 251
    Width = 73
    Height = 21
    Hint = 
      'Periodo di fine della visualizzazione del cartellino Formato ddm' +
      'myyyy'
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
    FriendlyName = 'edtPeriodoAl'
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object lblCausPresDisponibili: TmeIWLabel [11]
    Left = 61
    Top = 156
    Width = 132
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
    ForControl = cmbCausPresDisponibili
    HasTabOrder = False
    FriendlyName = 'lblCausPresDisponibili'
    Caption = 'Causali di presenza: '
    Enabled = True
  end
  object cmbCausPresDisponibili: TmeIWComboBox [12]
    Left = 201
    Top = 153
    Width = 217
    Height = 21
    Css = 'select_perc70'
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 0
    ItemIndex = 0
    FriendlyName = 'cmbCausPresDisponibili'
    NoSelectionText = '-- No Selection --'
  end
  object btnApplica: TmeIWButton [13]
    Left = 536
    Top = 292
    Width = 121
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
    Caption = 'Applica modifiche'
    Confirmation = 'Applicare le modifiche?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnApplica'
    TabOrder = 13
    OnClick = btnApplicaClick
    medpDownloadButton = False
  end
  object chkConteggi: TmeIWCheckBox [14]
    Left = 420
    Top = 294
    Width = 110
    Height = 21
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Conteggia ore'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    OnClick = chkConteggiClick
    Checked = False
    FriendlyName = 'chkConteggi'
  end
  object lblCausAssDisponibili: TmeIWLabel [15]
    Left = 61
    Top = 181
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
    ForControl = cmbCausAssDisponibili
    HasTabOrder = False
    FriendlyName = 'lblCausAssDisponibili'
    Caption = 'Causali di assenza: '
    Enabled = True
  end
  object cmbCausAssDisponibili: TmeIWComboBox [16]
    Left = 201
    Top = 180
    Width = 217
    Height = 21
    Css = 'select_perc70'
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 7
    ItemIndex = 0
    FriendlyName = 'cmbCausAssDisponibili'
    NoSelectionText = '-- No Selection --'
  end
  object lblPeriodo: TmeIWLabel [17]
    Left = 275
    Top = 229
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
    NoWrap = True
    ForControl = edtPeriodoDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodo'
    Caption = 'Periodo'
    Enabled = True
  end
  object lnkLegendaColoriGiorni: TmeIWLink [18]
    Left = 61
    Top = 211
    Width = 105
    Height = 17
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkLegendaColoriGiorni'
    OnClick = lnkLegendaColoriGiorniClick
    TabOrder = 8
    RawText = False
    Caption = 'Tipologia giorni'
    medpDownloadButton = False
  end
  object grdCartellino: TmeIWGrid [19]
    Left = 61
    Top = 358
    Width = 455
    Height = 150
    ExtraTagParams.Strings = (
      
        'summary=griglia di visualizzazione del cartellino in base al fil' +
        'tro indicato')
    Css = 'grid'
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
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    OnRenderCell = grdCartellinoRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdCartellino'
    ColumnCount = 1
    OnCellClick = grdCartellinoCellClick
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblCartellinoCaption: TmeIWLabel [20]
    Left = 213
    Top = 336
    Width = 154
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
    FriendlyName = 'lblCartellinoCaption'
    Caption = 'Cartellino del mese di ...'
    Enabled = True
  end
  object btnValidaAssenze: TmeIWButton [21]
    Left = 280
    Top = 286
    Width = 121
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
    Caption = 'Valida assenze'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnValidaAssenze'
    TabOrder = 14
    OnClick = btnValidaAssenzeClick
    medpDownloadButton = False
  end
  object imgPeriodoPrec: TmeIWImageFile [22]
    Left = 273
    Top = 251
    Width = 20
    Height = 20
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    Cacheable = True
    FriendlyName = 'imgPeriodoPrec'
    medpDownloadButton = False
  end
  object imgPeriodoSucc: TmeIWImageFile [23]
    Left = 496
    Top = 251
    Width = 20
    Height = 20
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    Cacheable = True
    FriendlyName = 'imgPeriodoSucc'
    medpDownloadButton = False
  end
  object grdRiepilogoSaldi: TmeIWGrid [24]
    Left = 58
    Top = 251
    Width = 108
    Height = 83
    ExtraTagParams.Strings = (
      
        'summary=griglia di riepilogo dei saldi conteggiati nel periodo i' +
        'ndicato')
    Css = 'grid width30chr'
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
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    OnRenderCell = grdRiepilogoSaldiRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdRiepilogoSaldi'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblRiepilogoSaldiCaption: TmeIWLabel [25]
    Left = 58
    Top = 234
    Width = 90
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
    FriendlyName = 'lblRiepilogoSaldiCaption'
    Caption = 'Riepilogo saldi'
    Enabled = True
  end
  object lblUscitaNominaleGGCorr: TmeIWLabel [26]
    Left = 281
    Top = 317
    Width = 117
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
    NoWrap = True
    ForControl = edtPeriodoDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodo'
    Caption = 'Uscita prevista alle'
    Enabled = True
  end
  object lnkMostraLegende: TmeIWLink [27]
    Left = 201
    Top = 130
    Width = 112
    Height = 17
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkMostraLegende'
    OnClick = lnkMostraLegendeClick
    TabOrder = 15
    RawText = False
    Caption = 'Mostra legende'
    medpDownloadButton = False
  end
  object lnkLegende: TmeIWLink [28]
    Left = 61
    Top = 130
    Width = 105
    Height = 16
    Css = 'link'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkLegende'
    OnClick = lnkLegendeClick
    TabOrder = 16
    RawText = False
    Caption = 'Nascondi legende'
    medpDownloadButton = False
  end
  object lnkAggiorna: TmeIWLink [29]
    Left = 568
    Top = 168
    Width = 65
    Height = 17
    Css = 'link'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkAggiorna'
    TabOrder = 17
    RawText = False
    Caption = 'Aggiorna'
    medpDownloadButton = False
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 624
    Top = 24
  end
end
