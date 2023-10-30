inherited WA167FRegistraIncentivi: TWA167FRegistraIncentivi
  Tag = 39
  Width = 742
  Height = 549
  ExplicitWidth = 742
  ExplicitHeight = 549
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 134
    ExplicitTop = 134
  end
  inherited btnShowElabError: TmeIWButton
    Top = 103
    ExplicitTop = 103
  end
  object edtDaData: TmeIWEdit [9]
    Left = 16
    Top = 200
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtDaData'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    Text = 'edtDaData'
  end
  object edtAData: TmeIWEdit [10]
    Left = 168
    Top = 200
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtAData'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtADataAsyncChange
    Text = 'edtAData'
  end
  object lblDaData: TmeIWLabel [11]
    Left = 16
    Top = 178
    Width = 58
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
    FriendlyName = 'lblDaData'
    Caption = 'Dal mese'
    Enabled = True
  end
  object lblAData: TmeIWLabel [12]
    Left = 168
    Top = 178
    Width = 50
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
    FriendlyName = 'lblAData'
    Caption = 'Al mese'
    Enabled = True
  end
  object cmbTipoCalcolo: TmeIWComboBox [13]
    Left = 16
    Top = 256
    Width = 121
    Height = 21
    Css = 'width70chr'
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
    OnAsyncChange = cmbTipoCalcoloAsyncChange
    NonEditableAsLabel = True
    TabOrder = 9
    ItemIndex = -1
    FriendlyName = 'cmbTipoCalcolo'
    NoSelectionText = ' '
  end
  object lblTipoCalcolo: TmeIWLabel [14]
    Left = 16
    Top = 234
    Width = 90
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
    FriendlyName = 'lblTipoCalcolo'
    Caption = 'Tipo di calcolo'
    Enabled = True
  end
  object lblQuote: TmeIWLabel [15]
    Left = 16
    Top = 283
    Width = 122
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
    FriendlyName = 'Quote da elaborare'
    Caption = 'Quote da elaborare'
    Enabled = True
  end
  object edtQuote: TmeIWEdit [16]
    Left = 17
    Top = 305
    Width = 121
    Height = 21
    Css = 'width70chr'
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
    FriendlyName = 'edtQuote'
    ReadOnly = True
    SubmitOnAsyncEvent = True
    TabOrder = 10
    Text = 'edtQuote'
  end
  object btnQuote: TmeIWButton [17]
    Left = 144
    Top = 305
    Width = 33
    Height = 25
    Css = 'pulsante puntini'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = '...'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnQuote'
    TabOrder = 11
    OnClick = btnQuoteClick
    medpDownloadButton = False
  end
  object cmbCampoAnag: TMedpIWMultiColumnComboBox [18]
    Left = 13
    Top = 412
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
    FriendlyName = 'cmbCampoAnag'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    OnAsyncChange = cmbCampoAnagAsyncChange
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblImpostazioni: TmeIWLabel [19]
    Left = 29
    Top = 368
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
    FriendlyName = 'lblImpostazioni'
    Caption = 'Impostazioni di stampa'
    Enabled = True
  end
  object lblCampoAnag: TmeIWLabel [20]
    Left = 17
    Top = 390
    Width = 238
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
    FriendlyName = 'lblCampoAnag'
    Caption = 'Campo anagrafico di raggruppamento'
    Enabled = True
  end
  object chkSaltoPagina: TmeIWCheckBox [21]
    Left = 205
    Top = 428
    Width = 121
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
    TabOrder = 13
    Checked = False
    FriendlyName = 'chkSaltoPagina'
  end
  object chkDettaglio: TmeIWCheckBox [22]
    Left = 332
    Top = 424
    Width = 121
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
    Caption = 'Dettaglio mensile'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 14
    Checked = False
    FriendlyName = 'chkDettaglio'
  end
  object rgpTipoDati: TmeIWRadioGroup [23]
    Left = 21
    Top = 470
    Width = 153
    Height = 42
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
    FriendlyName = 'rgpTipoDati'
    ItemIndex = 0
    Items.Strings = (
      'Quote in valuta'
      'Giorni di competenza')
    Layout = glVertical
    TabOrder = 15
  end
  object lblTipoDati: TmeIWLabel [24]
    Left = 37
    Top = 433
    Width = 55
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
    FriendlyName = 'lblTipoDati'
    Caption = 'Tipo dati'
    Enabled = True
  end
  object cgpColonne: TmeTIWAdvCheckGroup [25]
    Left = 205
    Top = 470
    Width = 393
    Height = 69
    Css = 'intestazione prewrapcheckgroup_multicol'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clNone
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 3
    Editable = True
    FriendlyName = 'cgpColonne'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Quota intera [1]'
      'Quota proporzionata [2]'
      'Quota netta [3]'
      'Quota netta + Risp. [4]'
      'Abbattimento con risp.'
      'Abbattimento senza risp.'
      'Quota quantitativa [5]')
    TabOrder = 16
  end
  object lblColonne: TmeIWLabel [26]
    Left = 205
    Top = 455
    Width = 50
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
    FriendlyName = 'lblColonne'
    Caption = 'Colonne'
    Enabled = True
  end
  object chkAggiorna: TmeIWCheckBox [27]
    Left = 272
    Top = 264
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
    Caption = 'Aggiornamento riepilogo'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 17
    OnAsyncClick = chkAggiornaAsyncClick
    Checked = False
    FriendlyName = 'chkAggiorna'
  end
  object chkAnnulla: TmeIWCheckBox [28]
    Left = 272
    Top = 291
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
    Caption = 'Annullamento riepilogo'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    OnAsyncClick = chkAnnullaAsyncClick
    Checked = False
    FriendlyName = 'chkAnnulla'
  end
  object btnAnomalie: TmedpIWImageButton [29]
    Left = 588
    Top = 451
    Width = 122
    Height = 27
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
    Caption = 'Anomalie'
  end
  object btnGeneraPDF: TmedpIWImageButton [30]
    Left = 588
    Top = 384
    Width = 122
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
    ImageFile.URL = 'img/btnPdf.png'
    medpDownloadButton = False
    Caption = 'Stampa in PDF'
  end
  object btnAggiornamento: TmedpIWImageButton [31]
    Left = 588
    Top = 418
    Width = 122
    Height = 27
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
    FriendlyName = 'btnAggiornamento'
    ImageFile.URL = 'img/btnSalvataggio.png'
    medpDownloadButton = False
    Caption = 'Solo aggiornamento'
  end
  object lblMeseCompMax: TmeIWLabel [32]
    Left = 321
    Top = 178
    Width = 106
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
    FriendlyName = 'lblMeseCompMax'
    Caption = 'Mese comp. max'
    Enabled = True
  end
  object edtMeseCompMax: TmeIWEdit [33]
    Left = 321
    Top = 200
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtMeseCompMax'
    SubmitOnAsyncEvent = True
    TabOrder = 19
    Text = 'edtMeseCompMax'
  end
  object chkCalcolaImportiSaldoAnnoCorr: TmeIWCheckBox [34]
    Left = 16
    Top = 341
    Width = 497
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
    Caption = 
      'Calcola anche gli importi per le quote con Riferimento a saldo o' +
      're anno corrente'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 20
    Checked = False
    FriendlyName = 'chkCalcolaImportiSaldoAnnoCorr'
  end
  object btnCambioData: TmeIWButton [35]
    Left = 335
    Top = 103
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
    Caption = 'btnCambioData'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnCambioData'
    TabOrder = 21
    medpDownloadButton = False
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 632
    Top = 120
  end
end
