inherited WA063FBudgetGenerazione: TWA063FBudgetGenerazione
  Tag = 131
  Height = 565
  ExplicitHeight = 565
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 27
    Top = 134
    ExplicitLeft = 27
    ExplicitTop = 134
  end
  inherited btnShowElabError: TmeIWButton
    Left = 27
    Top = 103
    ExplicitLeft = 27
    ExplicitTop = 103
  end
  object lblAnno: TmeIWLabel [9]
    Left = 27
    Top = 176
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
    ForControl = edtAnno
    HasTabOrder = False
    FriendlyName = 'lblAnno'
    Caption = 'Anno'
    Enabled = True
  end
  object edtAnno: TmeIWEdit [10]
    Left = 27
    Top = 197
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtAnno'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnAsyncChange = edtAnnoAsyncChange
    Text = '0'
  end
  object dcmbTipo: TMedpIWMultiColumnComboBox [11]
    Left = 223
    Top = 197
    Width = 61
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
    FriendlyName = 'dcmbTipo'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    OnChange = dcmbTipoChange
    medpAutoResetItems = True
    CssInputText = 'width5chr'
    LookupColumn = 0
    CodeColumn = 0
  end
  object chkAssegnaBudget: TmeIWCheckBox [12]
    Left = 27
    Top = 384
    Width = 22
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
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    OnClick = chkAssegnaBudgetClick
    Checked = False
    FriendlyName = 'chkAssegnaBudget'
  end
  object chkCalcolaFruito: TmeIWCheckBox [13]
    Left = 27
    Top = 411
    Width = 22
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
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    OnClick = chkAssegnaBudgetClick
    Checked = False
    FriendlyName = 'chkCalcolaFruito'
  end
  object chkRiportaResiduo: TmeIWCheckBox [14]
    Left = 27
    Top = 438
    Width = 22
    Height = 21
    HelpType = htKeyword
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    OnClick = chkAssegnaBudgetClick
    Checked = False
    FriendlyName = 'chkRiportaResiduo'
  end
  object chkControlloFiltriAnagrafe: TmeIWCheckBox [15]
    Left = 27
    Top = 465
    Width = 22
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
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    OnClick = chkAssegnaBudgetClick
    Checked = False
    FriendlyName = 'chkControlloFiltriAnagrafe'
  end
  object chkDuplicaGruppi: TmeIWCheckBox [16]
    Left = 27
    Top = 492
    Width = 22
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
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    OnClick = chkAssegnaBudgetClick
    Checked = False
    FriendlyName = 'chkDuplicaGruppi'
  end
  object cmbAMeseBudget: TmeIWComboBox [17]
    Left = 306
    Top = 384
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 14
    ItemIndex = -1
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    FriendlyName = 'cmbAMeseBudget'
    NoSelectionText = '-- No Selection --'
  end
  object lblAlMeseBudget: TmeIWLabel [18]
    Left = 223
    Top = 389
    Width = 81
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
    FriendlyName = 'lblAlMeseBudget'
    Caption = ' fino al mese'
    Enabled = True
  end
  object lblDalMeseFruito: TmeIWLabel [19]
    Left = 154
    Top = 416
    Width = 61
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
    FriendlyName = 'lblDalMeseFruito'
    Caption = ' dal mese'
    Enabled = True
  end
  object cmbDaMeseFruito: TmeIWComboBox [20]
    Left = 217
    Top = 411
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 15
    ItemIndex = -1
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    FriendlyName = 'cmbDaMeseFruito'
    NoSelectionText = '-- No Selection --'
  end
  object lblAlMeseFruito: TmeIWLabel [21]
    Left = 344
    Top = 416
    Width = 53
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
    FriendlyName = 'lblAlMeseFruito'
    Caption = ' al mese'
    Enabled = True
  end
  object cmbAMeseFruito: TmeIWComboBox [22]
    Left = 399
    Top = 411
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 16
    ItemIndex = -1
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    FriendlyName = 'cmbAMeseFruito'
    NoSelectionText = '-- No Selection --'
  end
  object lblDalMeseResiduo: TmeIWLabel [23]
    Left = 167
    Top = 443
    Width = 61
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
    FriendlyName = 'lblDalMeseResiduo'
    Caption = ' dal mese'
    Enabled = True
  end
  object cmbDaMeseResiduo: TmeIWComboBox [24]
    Left = 230
    Top = 438
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 17
    ItemIndex = -1
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    FriendlyName = 'cmbDaMeseResiduo'
    NoSelectionText = '-- No Selection --'
  end
  object lblAlMeseResiduo: TmeIWLabel [25]
    Left = 357
    Top = 443
    Width = 53
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
    FriendlyName = 'lblAlMeseResiduo'
    Caption = ' al mese'
    Enabled = True
  end
  object cmbAMeseResiduo: TmeIWComboBox [26]
    Left = 412
    Top = 438
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
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 18
    ItemIndex = -1
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
    FriendlyName = 'cmbAMeseResiduo'
    NoSelectionText = '-- No Selection --'
  end
  object lblMesiSuccResiduo: TmeIWLabel [27]
    Left = 539
    Top = 443
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
    FriendlyName = 'lblMesiSuccResiduo'
    Caption = ' sul mese successivo'
    Enabled = True
  end
  object lblDuplicaSuAnno: TmeIWLabel [28]
    Left = 147
    Top = 497
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
    FriendlyName = 'lblDuplicaSuAnno'
    Caption = ' sull'#39'anno'
    Enabled = True
  end
  object edtDuplicaSuAnno: TmeIWEdit [29]
    Left = 208
    Top = 492
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtDuplicaSuAnno'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 19
    Text = '0'
  end
  object rgpOreImporti: TmeIWRadioGroup [30]
    Left = 71
    Top = 198
    Width = 153
    Height = 21
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
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpOreImporti'
    ItemIndex = 0
    Items.Strings = (
      'Ore'
      'Importi'
      'Entrambi')
    Layout = glHorizontal
    TabOrder = 20
  end
  object lblOreImporti: TmeIWLabel [31]
    Left = 71
    Top = 176
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
    ForControl = rgpOreImporti
    HasTabOrder = False
    FriendlyName = 'lblOreImporti'
    Caption = 'Intervento su'
    Enabled = True
  end
  object lblTipo: TmeIWLabel [32]
    Left = 223
    Top = 176
    Width = 27
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
    ForControl = edtAnno
    HasTabOrder = False
    FriendlyName = 'lblTipo'
    Caption = 'Tipo'
    Enabled = True
  end
  object imgEsegui: TmedpIWImageButton [33]
    Left = 27
    Top = 526
    Width = 137
    Height = 27
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
    TabOrder = -1
    UseSize = False
    OnClick = imgEseguiClick
    Cacheable = True
    FriendlyName = 'imgEsegui'
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object imgAnomalie: TmedpIWImageButton [34]
    Left = 205
    Top = 526
    Width = 137
    Height = 27
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
    TabOrder = -1
    UseSize = False
    OnClick = imgAnomalieClick
    Cacheable = True
    FriendlyName = 'imgAnomalie'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object lblAssegnaBudget: TmeIWLabel [35]
    Left = 47
    Top = 389
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
    FriendlyName = 'lblAssegnaBudget'
    Caption = 'Assegnazione budget mensile'
    Enabled = True
  end
  object lblCalcolaFruito: TmeIWLabel [36]
    Left = 47
    Top = 416
    Width = 105
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
    FriendlyName = 'lblCalcolaFruito'
    Caption = 'Calcolo del fruito'
    Enabled = True
  end
  object lblRiportaResiduo: TmeIWLabel [37]
    Left = 47
    Top = 443
    Width = 118
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
    FriendlyName = 'lblRiportaResiduo'
    Caption = 'Riporto del residuo'
    Enabled = True
  end
  object lblControlloFiltriAnagrafe: TmeIWLabel [38]
    Left = 47
    Top = 470
    Width = 249
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
    FriendlyName = 'lblControlloFiltriAnagrafe'
    Caption = 'Controllo sovrapposizione filtri anagrafe'
    Enabled = True
  end
  object lblDuplicaGruppi: TmeIWLabel [39]
    Left = 47
    Top = 497
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
    FriendlyName = 'lblDuplicaGruppi'
    Caption = 'Duplica i gruppi'
    Enabled = True
  end
  object lblDescTipo: TmeIWLabel [40]
    Left = 290
    Top = 202
    Width = 4
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
    FriendlyName = 'lblDescTipo'
    Caption = ' '
    Enabled = True
  end
  object btnCambioData: TmeIWButton [41]
    Left = 16
    Top = 155
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
    Caption = 'pulsante nascosto per cambio data'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnShowElabError'
    TabOrder = 21
    OnClick = btnCambioDataClick
    medpDownloadButton = False
  end
  object clbGruppi: TmeTIWAdvCheckGroup [42]
    Left = 27
    Top = 225
    Width = 383
    Height = 144
    Css = 'prewrapcheckgroup fontcourier'
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
    FriendlyName = 'clbGruppi'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 22
    medpContextMenu = pmnAzioni
  end
  object pmnAzioni: TPopupMenu
    Left = 352
    Top = 240
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = MenuItem1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = MenuItem2Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = MenuItem3Click
    end
  end
end
