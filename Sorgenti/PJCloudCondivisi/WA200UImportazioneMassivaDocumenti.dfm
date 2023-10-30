inherited WA200FImportazioneMassivaDocumenti: TWA200FImportazioneMassivaDocumenti
  Tag = 154
  Height = 888
  ExplicitHeight = 888
  DesignLeft = 8
  DesignTop = 8
  object lblmpPath: TmeIWLabel [9]
    Left = 33
    Top = 306
    Width = 182
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
    FriendlyName = 'lblmpPath'
    Caption = 'Path documenti da importare'
    Enabled = True
  end
  object edtImpPath: TmeIWEdit [10]
    Left = 245
    Top = 301
    Width = 392
    Height = 21
    Css = 'width60chr spazio_sx0'
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
    FriendlyName = 'edtImpPath'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtImpPathAsyncChange
  end
  object lblImpFiltro: TmeIWLabel [11]
    Left = 33
    Top = 333
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
    FriendlyName = 'lblImpFiltro'
    Caption = 'Filtro'
    Enabled = True
  end
  object edtImpFiltro: TmeIWEdit [12]
    Left = 245
    Top = 328
    Width = 92
    Height = 21
    Css = 'width10chr spazio_sx0'
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
    FriendlyName = 'edtImpFiltro'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtImpFiltroAsyncChange
    Text = '*.*'
  end
  object edtImpSeparatore: TmeIWEdit [13]
    Left = 363
    Top = 355
    Width = 19
    Height = 21
    Css = 'width1chr spazio_sx0'
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
    FriendlyName = 'edtImpSeparatore'
    MaxLength = 1
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncChange = edtImpFormatiAsyncChange
    Text = '_'
  end
  object lblImpSeparatore: TmeIWLabel [14]
    Left = 245
    Top = 355
    Width = 112
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
    FriendlyName = 'lblImpSeparatore'
    Caption = 'Separatore campi'
    Enabled = True
  end
  object lblImpFormato: TmeIWLabel [15]
    Left = 33
    Top = 355
    Width = 188
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
    FriendlyName = 'lblImpFormato'
    Caption = 'Formato nome file in ingresso'
    Enabled = True
  end
  object lblImpNomeFile: TmeIWLabel [16]
    Left = 245
    Top = 382
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
    FriendlyName = 'lblImpNomeFile'
    Caption = 'Nome dei file'
    Enabled = True
  end
  object edtImpNomeFile: TmeIWEdit [17]
    Left = 363
    Top = 382
    Width = 317
    Height = 21
    Css = 'width50chr spazio_sx0'
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
    FriendlyName = 'edtImpNomeFile'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    OnAsyncChange = edtImpFormatiAsyncChange
    Text = '<MATRICOLA>_<NOME_DEL_FILE>'
  end
  object lblInfoHelp: TmeIWLabel [18]
    Left = 245
    Top = 404
    Width = 338
    Height = 16
    Css = 'descrizione'
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
    FriendlyName = 'lblInfoHelp'
    Caption = 'Per informazioni sul formato consultare l'#39'help in linea.'
    Enabled = True
  end
  object rgpImpNomeFileOut: TmeIWRadioGroup [19]
    Left = 245
    Top = 426
    Width = 275
    Height = 60
    Cursor = crDefault
    Css = 'intestazione WA200RadioGroup'
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
    FriendlyName = 'rgpImpNomeFileOut'
    ItemIndex = 0
    Items.Strings = (
      'Stesso nome del file originale su file system'
      'Predefinito:'
      '<NOME_DEL_FILE> da file originale')
    Layout = glVertical
    TabOrder = 11
    OnAsyncClick = rgpImpNomeFileOutAsyncClick
  end
  object lblImpNomeFileOut: TmeIWLabel [20]
    Left = 33
    Top = 426
    Width = 185
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
    FriendlyName = 'lblImpNomeFileOut'
    Caption = 'Nome dei file su documentale'
    Enabled = True
  end
  object edtImpNomeFileOutPred: TmeIWEdit [21]
    Left = 343
    Top = 442
    Width = 308
    Height = 21
    Css = 'width47chr spazio_sx0'
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
    FriendlyName = 'edtImpNomeFileOutPred'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    OnAsyncChange = edtImpNomeFileOutPredAsyncChange
  end
  object lblImpNomeFileExt: TmeIWLabel [22]
    Left = 654
    Top = 442
    Width = 23
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
    FriendlyName = 'lblImpNomeFileExt'
    Caption = '.ext'
    Enabled = True
  end
  object lblImpTipologia: TmeIWLabel [23]
    Left = 33
    Top = 482
    Width = 57
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
    FriendlyName = 'lblImpTipologia'
    Caption = 'Tipologia'
    Enabled = True
  end
  object dcmbImpTipologia: TmeIWDBLookupComboBox [24]
    Left = 245
    Top = 482
    Width = 187
    Height = 21
    Css = 'width40chr spazio_sx0'
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
    Required = True
    UseSize = False
    TabOrder = 13
    AutoEditable = True
    DataField = 'CODICE'
    DataSource = WA200FImportazioneMassivaDocumentiDM.dsrAppTipologia
    FriendlyName = 'dcmbImpTipologia'
    KeyField = 'CODICE'
    ListField = 'DESCRIZIONE'
    DisableWhenEmpty = True
    NoSelectionText = ''
  end
  object rgpImpAzioneDocTip: TmeIWRadioGroup [25]
    Left = 245
    Top = 527
    Width = 355
    Height = 34
    Cursor = crDefault
    Css = 'intestazione WA200RadioGroup'
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
    FriendlyName = 'rgpImpAzioneDocTip'
    ItemIndex = 0
    Items.Strings = (
      'Aggiungi il nuovo documento mantenendo quello esistente'
      'Sovrascrivi il documento esistente')
    Layout = glVertical
    TabOrder = 14
  end
  object lblImpAzioneDocTip: TmeIWLabel [26]
    Left = 242
    Top = 505
    Width = 292
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
    FriendlyName = 'lblImpAzioneDocTip'
    Caption = 'Se esiste gi'#224' un documento di questa tipologia'
    Enabled = True
  end
  object lblImpUfficio: TmeIWLabel [27]
    Left = 33
    Top = 567
    Width = 38
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
    FriendlyName = 'lblImpUfficio'
    Caption = 'Ufficio'
    Enabled = True
  end
  object dcmbImpUfficio: TmeIWDBLookupComboBox [28]
    Left = 245
    Top = 567
    Width = 187
    Height = 21
    Css = 'width40chr spazio_sx0'
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
    Required = True
    UseSize = False
    TabOrder = 15
    AutoEditable = True
    DataField = 'CODICE'
    DataSource = WA200FImportazioneMassivaDocumentiDM.dsrAppUfficio
    FriendlyName = 'dcmbImpUfficio'
    KeyField = 'CODICE'
    ListField = 'DESCRIZIONE'
    DisableWhenEmpty = True
    NoSelectionText = ''
  end
  object lblImpRiferitiDal: TmeIWLabel [29]
    Left = 33
    Top = 594
    Width = 130
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
    FriendlyName = 'lblImpRiferitiDal'
    Caption = 'Riferiti al periodo dal'
    Enabled = True
  end
  object edtImpPeriodoDal: TmeIWEdit [30]
    Left = 245
    Top = 594
    Width = 122
    Height = 21
    Css = 'input_data_dmy spazio_sx0'
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
    FriendlyName = 'edtImpPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 16
  end
  object lblImpRiferitiAl: TmeIWLabel [31]
    Left = 381
    Top = 594
    Width = 11
    Height = 16
    Css = 'intestazione spazio_sx03'
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
    FriendlyName = 'lblImpRiferitiAl'
    Caption = 'al'
    Enabled = True
  end
  object edtImpPeriodoAl: TmeIWEdit [32]
    Left = 398
    Top = 594
    Width = 122
    Height = 21
    Css = 'input_data_dmy spazio_sx03'
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
    FriendlyName = 'edtImpPeriodoAl'
    SubmitOnAsyncEvent = True
    TabOrder = 17
  end
  object lblImpNote: TmeIWLabel [33]
    Left = 33
    Top = 621
    Width = 28
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
    FriendlyName = 'lblImpNote'
    Caption = 'Note'
    Enabled = True
  end
  object memNote: TmeIWMemo [34]
    Left = 245
    Top = 621
    Width = 391
    Height = 49
    Css = 'width63chr textarea_note'
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 18
    SubmitOnAsyncEvent = True
    FriendlyName = 'memNote'
  end
  object lblImpVisualIrisWeb: TmeIWLabel [35]
    Left = 33
    Top = 676
    Width = 207
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
    FriendlyName = 'lblImpVisualIrisWeb'
    Caption = 'Visualizzabile dal portale IrisWeb'
    Enabled = True
  end
  object chkImpVisualIrisWeb: TmeIWCheckBox [36]
    Left = 245
    Top = 676
    Width = 35
    Height = 21
    Align = alCustom
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = ' '
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 19
    Checked = False
    FriendlyName = 'chkImpVisualIrisWeb'
  end
  object btnEsegui: TmedpIWImageButton [37]
    Left = 33
    Top = 824
    Width = 122
    Height = 27
    Css = 'width12chr align_center'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    Enabled = False
    TabOrder = -1
    UseSize = False
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnAnomalie: TmedpIWImageButton [38]
    Left = 187
    Top = 824
    Width = 122
    Height = 27
    Css = 'width20chr align_center'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    Enabled = False
    TabOrder = -1
    UseSize = False
    OnClick = btnAnomalieClick
    Cacheable = True
    FriendlyName = 'btnAnomalie'
    ImageFile.URL = 'img/btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Messaggi elaborazione'
  end
  object lblImpFilesSelezionati: TmeIWLabel [39]
    Left = 333
    Top = 835
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
    FriendlyName = 'lblImpFilesSelezionati'
    Caption = 'Files selezionati: -'
    Enabled = True
  end
  object lblImpDimensTotale: TmeIWLabel [40]
    Left = 506
    Top = 835
    Width = 127
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
    FriendlyName = 'lblImpDimensTotale'
    Caption = 'Dimensione totale: -'
    Enabled = True
  end
  object lblImpDocDaImportare: TmeIWLabel [41]
    Left = 33
    Top = 731
    Width = 151
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
    FriendlyName = 'lblImpDocDaImportare'
    Caption = 'Documenti da importare'
    Enabled = True
  end
  object lblImpDocIgnorati: TmeIWLabel [42]
    Left = 333
    Top = 731
    Width = 73
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
    FriendlyName = 'lblImpDocIgnorati'
    Caption = 'File ignorati'
    Enabled = True
  end
  object lstImpDocIgnorati: TmeIWListbox [43]
    Left = 333
    Top = 753
    Width = 283
    Height = 65
    Css = 'descrizione noborder spazio_sx0 width100pc height100pc'
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
    TabOrder = 20
    FriendlyName = 'lstImpDocIgnorati'
    medpContextMenu = pmnImpFileIgnorati
    NoSelectionText = ''
  end
  object btnImpAnalizza: TmeIWButton [44]
    Left = 33
    Top = 698
    Width = 151
    Height = 25
    Css = 'pulsante spazio_sx0'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Analizza documenti'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnImpAnalizza'
    TabOrder = 21
    OnClick = btnImpAnalizzaClick
    medpDownloadButton = False
  end
  object lstImpDocDaImportare: TmeTIWAdvCheckGroup [45]
    Left = 32
    Top = 753
    Width = 295
    Height = 56
    Css = 'descrizione prewrapcheckgroup fontcourier'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clNone
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'lstImpDocDaImportare'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 22
    OnAsyncItemClick = lstImpDocDaImportareAsyncItemClick
    medpContextMenu = pmnImpDocDaImportare
  end
  object pmnImpDocDaImportare: TPopupMenu
    Left = 256
    Top = 765
    object Selezionatutto1Giorni: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = Invertiselezione1GiorniClick
    end
    object Deselezionatutto1Giorni: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = Invertiselezione1GiorniClick
    end
    object Invertiselezione1Giorni: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = Invertiselezione1GiorniClick
    end
  end
  object pmnImpFileIgnorati: TPopupMenu
    Left = 560
    Top = 765
    object actScaricaInExcel: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelClick
    end
    object actScaricaInCSV: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVClick
    end
  end
end
