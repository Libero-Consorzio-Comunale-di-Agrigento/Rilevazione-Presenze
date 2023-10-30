inherited WA112FInvioMessaggi: TWA112FInvioMessaggi
  Tag = 166
  Width = 772
  Height = 679
  Title = '(WA112) Generazione messaggi'
  ExplicitWidth = 772
  ExplicitHeight = 679
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 83
    Top = 91
    ExplicitLeft = 83
    ExplicitTop = 91
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 122
    ExplicitTop = 122
  end
  inherited btnShowElabError: TmeIWButton
    Left = 83
    Top = 60
    ExplicitLeft = 83
    ExplicitTop = 60
  end
  object grdTabDetail: TmedpIWTabControl [9]
    Left = 16
    Top = 153
    Width = 313
    Height = 25
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
    Lines = tlNone
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdTabDetail'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    CssTabHeaders = 'medpTabControl'
    OnTabControlChange = grdTabDetailTabControlChange
  end
  object imgAnomalie: TmedpIWImageButton [10]
    Left = 298
    Top = 643
    Width = 90
    Height = 24
    Css = 'width_20chr'
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
    OnClick = imgAnomalieClick
    Cacheable = True
    FriendlyName = 'imgAnomalie'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object imgVisualizzaFile: TmedpIWImageButton [11]
    Left = 190
    Top = 643
    Width = 90
    Height = 24
    Css = 'width_20chr'
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
    OnClick = imgVisualizzaFileClick
    Cacheable = True
    FriendlyName = 'imgVisualizzaFile'
    ImageFile.Filename = 'img\btnVisualizzaFile.png'
    medpDownloadButton = True
    Caption = 'Visualizza File'
  end
  object imgEsegui: TmedpIWImageButton [12]
    Left = 83
    Top = 643
    Width = 90
    Height = 24
    Css = 'width_20chr'
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
    OnClick = imgEseguiClick
    Cacheable = True
    FriendlyName = 'imgEsegui'
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object WA112ParametriRG: TIWRegion [13]
    Left = 16
    Top = 184
    Width = 614
    Height = 321
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateParametriRG
    object lblDataMessaggio: TmeIWLabel
      Left = 19
      Top = 24
      Width = 99
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
      FriendlyName = 'lblDataMessaggio'
      Caption = 'Data Messaggio'
      Enabled = True
    end
    object lblDataConsuntivo: TmeIWLabel
      Left = 19
      Top = 51
      Width = 101
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
      FriendlyName = 'lblDataConsuntivo'
      Caption = 'Data Consuntivo'
      Enabled = True
    end
    object lblDataScadenza: TmeIWLabel
      Left = 19
      Top = 78
      Width = 108
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
      FriendlyName = 'lblDataScadenza'
      Caption = 'Data Scad. Mess.'
      Enabled = True
    end
    object edtDataMessaggio: TmeIWEdit
      Left = 123
      Top = 24
      Width = 89
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
      FriendlyName = 'edtDataMessaggio'
      SubmitOnAsyncEvent = True
      TabOrder = 6
      Text = 'edtDataMessaggio'
    end
    object edtDataConsuntivo: TmeIWEdit
      Left = 123
      Top = 51
      Width = 89
      Height = 21
      Css = 'input_data_my'
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
      FriendlyName = 'edtDataConsuntivo'
      SubmitOnAsyncEvent = True
      TabOrder = 8
      Text = 'edtDataConsuntivo'
    end
    object edtDataScadenza: TmeIWEdit
      Left = 123
      Top = 78
      Width = 89
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
      FriendlyName = 'edtDataScadenza'
      SubmitOnAsyncEvent = True
      TabOrder = 9
      Text = 'edtDataScadenza'
    end
    object lblNumeroRipetizioni: TmeIWLabel
      Left = 242
      Top = 78
      Width = 96
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
      FriendlyName = 'lblNumeroRipetizioni'
      Caption = 'Num.Ripetizioni'
      Enabled = True
    end
    object edtNumeroRipetizioni: TmeIWEdit
      Left = 336
      Top = 78
      Width = 89
      Height = 21
      Css = 'input_num_nnn'
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
      FriendlyName = 'edtNumeroRipetizioni'
      SubmitOnAsyncEvent = True
      TabOrder = 10
      Text = 'edtNumeroRipetizioni'
    end
    object lblOraMessaggio: TmeIWLabel
      Left = 242
      Top = 24
      Width = 93
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
      FriendlyName = 'lblOraMessaggio'
      Caption = 'Ora Messaggio'
      Enabled = True
    end
    object edtOraMessaggio: TmeIWEdit
      Left = 336
      Top = 24
      Width = 89
      Height = 21
      Css = 'input_hour_hhmm width3chr'
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
      FriendlyName = 'edtOraMessaggio'
      SubmitOnAsyncEvent = True
      TabOrder = 11
      Text = 'edtOraMessaggio'
    end
    object lblNomeFile: TmeIWLabel
      Left = 19
      Top = 139
      Width = 62
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
      FriendlyName = 'lblNomeFile'
      Caption = 'Nome File'
      Enabled = True
    end
    object edtNomeFile: TmeIWEdit
      Left = 104
      Top = 139
      Width = 321
      Height = 21
      Css = 'width40chr'
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
      FriendlyName = 'edtNomeFile'
      SubmitOnAsyncEvent = True
      TabOrder = 12
      Text = 'edtNomeFile'
    end
    object rgpFileEsistente: TmeIWRadioGroup
      Left = 19
      Top = 188
      Width = 158
      Height = 17
      Cursor = crDefault
      Css = 'intestazione medpRgpHAlign'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpFileEsistente'
      ItemIndex = 0
      Items.Strings = (
        'Aggiungi'
        'Ricrea')
      Layout = glHorizontal
      TabOrder = 13
    end
    object lblFileEsistente: TmeIWLabel
      Left = 19
      Top = 166
      Width = 82
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
      FriendlyName = 'lblFileEsistente'
      Caption = 'File esistente'
      Enabled = True
    end
    object lblMsgEsistente: TmeIWLabel
      Left = 267
      Top = 166
      Width = 114
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
      FriendlyName = 'lblMsgEsistente'
      Caption = 'Messaggi esistenti'
      Enabled = True
    end
    object rgpMsgEsistente: TmeIWRadioGroup
      Left = 267
      Top = 188
      Width = 158
      Height = 17
      Cursor = crDefault
      Css = 'intestazione medpRgpHAlign'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      SubmitOnAsyncEvent = True
      RawText = False
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'rgpMsgEsistente'
      ItemIndex = 0
      Items.Strings = (
        'Mantieni'
        'Sovrascrivi')
      Layout = glHorizontal
      TabOrder = 14
    end
    object dGrdParametri: TmedpIWDBGrid
      Left = 19
      Top = 232
      Width = 406
      Height = 71
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
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = dGrdParametriRenderCell
      Summary = 'Griglia valori di default'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'dGrdParametri'
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
      OnDataSet2Componenti = dGrdParametriDataSet2Componenti
      OnComponenti2DataSet = dGrdParametriComponenti2DataSet
    end
    object cmbParametri: TmeIWComboBox
      Left = 104
      Top = 112
      Width = 321
      Height = 21
      Css = 'select_cour40'
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
      OnChange = cmbParametriChange
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 15
      ItemIndex = -1
      FriendlyName = 'cmbParametri'
      NoSelectionText = '-- No Selection --'
    end
    object chkVisualizzaBatch: TmeIWCheckBox
      Left = 440
      Top = 112
      Width = 161
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
      Caption = 'Visualizza Parametrizzazioni Batch'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 16
      OnClick = chkVisualizzaBatchClick
      Checked = False
      FriendlyName = 'chkVisualizzaBatch'
    end
    object lnkParametri: TmeIWLink
      Left = 19
      Top = 112
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
      FriendlyName = 'lnkParametri'
      OnClick = lnkParametriClick
      TabOrder = 17
      RawText = False
      Caption = 'Parametri'
      medpDownloadButton = False
    end
  end
  object WA112RisultatiRG: TIWRegion [14]
    Left = 16
    Top = 511
    Width = 614
    Height = 119
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateRisultatiRG
    object dGrdRisultati: TmedpIWDBGrid
      Left = 13
      Top = 19
      Width = 508
      Height = 86
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
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = dGrdRisultatiRenderCell
      Summary = 'Risultati elaborazione'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'dGrdRisultati'
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
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 688
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 688
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 688
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 688
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 688
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 688
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 592
  end
  object TemplateParametriRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA112ParametriRG.html'
    Left = 560
    Top = 240
  end
  object TemplateRisultatiRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA112RisultatiRG.html'
    Left = 560
    Top = 544
  end
end