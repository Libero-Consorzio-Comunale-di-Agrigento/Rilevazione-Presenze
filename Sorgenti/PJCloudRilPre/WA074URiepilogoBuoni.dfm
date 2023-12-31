inherited WA074FRiepilogoBuoni: TWA074FRiepilogoBuoni
  Tag = 36
  Width = 750
  Height = 829
  Title = '(WA074) Cartolina buoni pasto/ticket'
  ExplicitWidth = 750
  ExplicitHeight = 829
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 59
    Top = 153
    ExplicitLeft = 59
    ExplicitTop = 153
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 59
    Top = 60
    ExplicitLeft = 59
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 59
    Top = 122
    ExplicitLeft = 59
    ExplicitTop = 122
  end
  object lblRaggrAnagrafico: TmeIWLabel [9]
    Left = 24
    Top = 658
    Width = 244
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
    FriendlyName = 'lblDa'
    Caption = 'Campo anagrafico di raggruppamento:'
    Enabled = True
  end
  object grdTabDetail: TmedpIWTabControl [10]
    Left = 25
    Top = 184
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
  end
  object cmbRaggrAnagrafico: TmeIWComboBox [11]
    Left = 24
    Top = 680
    Width = 121
    Height = 21
    Css = 'width25chr'
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
    RequireSelection = False
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 24
    ItemIndex = -1
    FriendlyName = 'cmbRaggrAnagrafico'
    NoSelectionText = ' '
  end
  object btnAnomalie: TmedpIWImageButton [12]
    Left = 26
    Top = 787
    Width = 183
    Height = 30
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
    OnClick = btnAnomalieClick
    Cacheable = True
    FriendlyName = 'btnAnomalie'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object btnSoloAggiornamento: TmedpIWImageButton [13]
    Left = 26
    Top = 752
    Width = 183
    Height = 29
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
    OnClick = btnSoloAggiornamentoClick
    Cacheable = True
    FriendlyName = 'btnSoloAggiornamento'
    ImageFile.Filename = 'img\btnSalva.png'
    medpDownloadButton = False
    Caption = 'Solo aggiornamento'
  end
  object btnGeneraPDF: TmedpIWImageButton [14]
    Left = 26
    Top = 718
    Width = 183
    Height = 28
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
    OnClick = btnGeneraPDFClick
    Cacheable = True
    FriendlyName = 'btnGeneraPDF'
    ImageFile.Filename = 'img\btnPdf.png'
    medpDownloadButton = False
    Caption = 'Stampa in PDF'
  end
  object WA074MaturazioneRG: TmeIWRegion [15]
    Left = 24
    Top = 215
    Width = 609
    Height = 193
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateMaturazioneRG
    object lblDa: TmeIWLabel
      Left = 19
      Top = 8
      Width = 48
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
      FriendlyName = 'lblDa'
      Caption = 'Da data'
      Enabled = True
    end
    object edtDa: TmeIWEdit
      Left = 19
      Top = 28
      Width = 121
      Height = 21
      Css = 'input_data_dmy'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      NonEditableAsLabel = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtDa'
      SubmitOnAsyncEvent = True
      TabOrder = 7
      OnAsyncChange = edtDaAsyncChange
    end
    object lblA: TmeIWLabel
      Left = 179
      Top = 8
      Width = 40
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
      FriendlyName = 'lblDa'
      Caption = 'A data'
      Enabled = True
    end
    object edtA: TmeIWEdit
      Left = 179
      Top = 28
      Width = 121
      Height = 21
      Css = 'input_data_dmy'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      NonEditableAsLabel = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'meIWEdit1'
      SubmitOnAsyncEvent = True
      TabOrder = 8
      OnAsyncChange = edtAAsyncChange
    end
    object ChkDettaglio: TmeIWCheckBox
      Left = 21
      Top = 55
      Width = 198
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
      Caption = 'Stampa dettaglio giornaliero '
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 9
      Checked = False
      FriendlyName = 'ChkDettaglio'
    end
    object ChkAcquisto: TmeIWCheckBox
      Left = 21
      Top = 73
      Width = 198
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
      Caption = 'Acquisto buoni/ticket'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 10
      Checked = False
      FriendlyName = 'ChkAcquisto'
    end
    object ChkAggiorna: TmeIWCheckBox
      Left = 21
      Top = 131
      Width = 198
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
      Caption = 'Aggiornamento del riepilogo'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 11
      OnAsyncClick = ChkAggiornaAsyncClick
      Checked = False
      FriendlyName = 'ChkAggiorna'
    end
    object ChkIgnoraAnomalie: TmeIWCheckBox
      Left = 21
      Top = 152
      Width = 198
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
      Caption = 'Ignora le anomalie'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 12
      Checked = False
      FriendlyName = 'ChkIgnoraAnomalie'
    end
    object ChkInizioAnno: TmeIWCheckBox
      Left = 21
      Top = 93
      Width = 198
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
      Caption = 'Calcolo da inizio anno'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 13
      OnAsyncClick = ChkInizioAnnoAsyncClick
      Checked = False
      FriendlyName = 'ChkInizioAnno'
    end
    object ChkSaltoPagina: TmeIWCheckBox
      Left = 21
      Top = 111
      Width = 198
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
      Caption = 'Salto pagina'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 14
      Checked = False
      FriendlyName = 'ChkSaltoPagina'
    end
  end
  object WA074AcquistoRG: TmeIWRegion [16]
    Left = 24
    Top = 414
    Width = 609
    Height = 226
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateAcquistoRG
    object lblMeseAcquisto: TmeIWLabel
      Left = 19
      Top = 8
      Width = 89
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
      FriendlyName = 'lblMeseAcquisto'
      Caption = 'Mese acquisto'
      Enabled = True
    end
    object edtDataAcquisto: TmeIWEdit
      Left = 19
      Top = 28
      Width = 121
      Height = 21
      Css = 'input_data_my'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      NonEditableAsLabel = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtDa'
      SubmitOnAsyncEvent = True
      TabOrder = 15
    end
    object lblUltimoAcquisto: TmeIWLabel
      Left = 179
      Top = 8
      Width = 95
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
      FriendlyName = 'lblUltimoAcquisto'
      Caption = 'Ultimo acquisto'
      Enabled = True
    end
    object edtUltimoAcquisto: TmeIWEdit
      Left = 179
      Top = 28
      Width = 121
      Height = 21
      Css = 'width15chr'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      NonEditableAsLabel = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'meIWEdit1'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 16
    end
    object chkAcqDatiIndividuali: TmeIWCheckBox
      Left = 21
      Top = 55
      Width = 198
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
      Caption = 'Stampa dati individuali'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 17
      Checked = False
      FriendlyName = 'CkBDettaglio'
    end
    object btnEliminaAcquisto: TmeIWButton
      Left = 336
      Top = 24
      Width = 49
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
      Caption = 'Elimina'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnEliminaAcquisto'
      TabOrder = 18
      OnClick = btnEliminaAcquistoClick
      medpDownloadButton = False
    end
    object chkAcqSaltoPagina: TmeIWCheckBox
      Left = 21
      Top = 73
      Width = 198
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
      Caption = 'Salto pagina'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 19
      Checked = False
      FriendlyName = 'CkBDettaglio'
    end
    object chkFileSequenziale: TmeIWCheckBox
      Left = 21
      Top = 110
      Width = 198
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
      Caption = 'Genera file sequenziale'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 20
      OnClick = chkFileSequenzialeClick
      Checked = False
      FriendlyName = 'CkBDettaglio'
    end
    object chkAcqAggiornamento: TmeIWCheckBox
      Left = 21
      Top = 92
      Width = 198
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
      Caption = 'Aggiornamento del riepilogo'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 21
      OnAsyncClick = chkAcqAggiornamentoAsyncClick
      Checked = False
      FriendlyName = 'CkBDettaglio'
    end
    object btnParametriGemeaz: TmeIWButton
      Left = 21
      Top = 137
      Width = 76
      Height = 21
      Css = 'pulsante'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Parametri...'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'meIWButton1'
      TabOrder = 22
      OnClick = btnParametriGemeazClick
      medpDownloadButton = False
    end
    object chkScaricoPaghe: TmeIWCheckBox
      Left = 21
      Top = 164
      Width = 198
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
      Caption = 'Genera file per acquisto ticket'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 23
      OnClick = chkScaricoPagheClick
      Checked = False
      FriendlyName = 'CkBDettaglio'
    end
    object lblParametrizzazione: TmeIWLabel
      Left = 51
      Top = 184
      Width = 115
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
      FriendlyName = 'lblDa'
      Caption = 'Parametrizzazione'
      Enabled = True
    end
    object edtPwdFileSequenziale: TmeIWEdit
      Left = 304
      Top = 96
      Width = 81
      Height = 21
      Css = 'width10chr'
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
      FriendlyName = 'edtPwdFileSequenziale'
      SubmitOnAsyncEvent = True
      TabOrder = 25
      PasswordPrompt = True
    end
    object lblPwdFileSequenziale: TmeIWLabel
      Left = 235
      Top = 96
      Width = 60
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
      FriendlyName = 'lblPwdFileSequenziale'#249
      Caption = 'Password'
      Enabled = True
    end
    object lblDescParametrizzazione: TmeIWLabel
      Left = 320
      Top = 184
      Width = 149
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
      FriendlyName = 'lblDescParametrizzazione'
      Caption = 'Desc parametrizzazione'
      Enabled = True
    end
    object edtFileSequenziale: TmeIWEdit
      Left = 304
      Top = 69
      Width = 121
      Height = 21
      Css = 'width35chr'
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
      FriendlyName = 'edtFileSequenziale'
      SubmitOnAsyncEvent = True
      TabOrder = 26
    end
    object btnScaricaFile: TmedpIWImageButton
      Left = 208
      Top = 137
      Width = 217
      Height = 21
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
      OnClick = btnScaricaFileClick
      Cacheable = True
      FriendlyName = 'btnScaricaFile'
      ImageFile.Filename = 'img\btnSalva.png'
      medpDownloadButton = False
      Caption = 'scarica file sequenziale'
    end
    object cmbParametrizzazione: TMedpIWMultiColumnComboBox
      Left = 193
      Top = 184
      Width = 121
      Height = 21
      Css = 'medpMultiColumnCombo'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'cmbParametrizzazione'
      SubmitOnAsyncEvent = True
      TabOrder = 27
      OnAsyncChange = cmbParametrizzazioneAsyncChange
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width15chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblNomeFile: TmeIWLabel
      Left = 275
      Top = 206
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
      FriendlyName = 'lblNomeFile'
      Enabled = True
    end
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 488
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 504
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 632
    Top = 80
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 504
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 632
    Top = 24
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 632
    Top = 144
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 392
  end
  object TemplateMaturazioneRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA074MaturazioneRG.html'
    OnUnknownTag = TemplateProcessorUnknownTag
    OnBeforeProcess = TemplateProcessorBeforeProcess
    RenderStyles = False
    Left = 527
    Top = 228
  end
  object TemplateAcquistoRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA074AcquistoRG.html'
    OnUnknownTag = TemplateProcessorUnknownTag
    OnBeforeProcess = TemplateProcessorBeforeProcess
    RenderStyles = False
    Left = 527
    Top = 444
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 384
    Top = 104
  end
end
