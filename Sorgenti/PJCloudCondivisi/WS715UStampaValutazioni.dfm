inherited WS715FStampaValutazioni: TWS715FStampaValutazioni
  Tag = 347
  Height = 627
  ExplicitHeight = 627
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
  object lblDataA: TmeIWLabel [9]
    Left = 200
    Top = 152
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
    FriendlyName = 'lblDataA'
    Caption = 'Alla data'
    Enabled = True
  end
  object edtDataA: TmeIWEdit [10]
    Left = 200
    Top = 174
    Width = 84
    Height = 21
    Css = 'input_data_dmy width5chr'
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
    FriendlyName = 'edtDataA'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtDataDaAsyncChange
    Text = 'edtDataA'
  end
  object rgpTipoValutazione: TmeTIWAdvRadioGroup [11]
    Left = 35
    Top = 223
    Height = 80
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'rgpTipoValutazione'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Valutazione'
      'Autovalutazione'
      'Tutto')
    ItemIndex = 0
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncClick = rgpAsyncClick
  end
  object rgpTipoChiusura: TmeTIWAdvRadioGroup [12]
    Left = 193
    Top = 217
    Width = 256
    Height = 72
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 2
    Editable = True
    FriendlyName = 'rgpTipoValutazione'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Scheda provvisoria'
      'Scheda bloccata'
      'Scheda definitiva'
      'Tutto')
    ItemIndex = 3
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncClick = rgpAsyncClick
  end
  object rgpStatoAvanzamento: TmeTIWAdvRadioGroup [13]
    Left = 35
    Top = 309
    Width = 155
    Height = 44
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 2
    Editable = True
    FriendlyName = 'rgpStatoAvanzamento'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Attuale'
      'Elenco')
    ItemIndex = 0
    Layout = glHorizontal
    SubmitOnAsyncEvent = True
    TabOrder = 10
    OnAsyncClick = rgpStatoAvanzamentoAsyncClick
  end
  object edtDataDa: TmeIWEdit [14]
    Left = 45
    Top = 174
    Width = 84
    Height = 21
    Css = 'input_data_dmy width5chr'
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
    FriendlyName = 'edtDataDa'
    SubmitOnAsyncEvent = True
    TabOrder = 11
    OnAsyncChange = edtDataDaAsyncChange
    Text = 'edtDataDa'
  end
  object lblDataDa: TmeIWLabel [15]
    Left = 45
    Top = 152
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
    FriendlyName = 'lblDataDa'
    Caption = 'Dalla data'
    Enabled = True
  end
  object edtStatoAvanzamento: TmeIWEdit [16]
    Left = 196
    Top = 295
    Width = 121
    Height = 21
    Css = 'width30chr'
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
    FriendlyName = 'edtStatoAvanzamento'
    ReadOnly = True
    SubmitOnAsyncEvent = True
    TabOrder = 12
    Text = 'edtStatoAvanzamento'
  end
  object btnStatoAvanzamento: TmeIWButton [17]
    Left = 323
    Top = 295
    Width = 30
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
    FriendlyName = 'btnStatoAvanzamento'
    TabOrder = 13
    OnClick = btnStatoAvanzamentoClick
    medpDownloadButton = False
  end
  object lblTipoValutazione: TmeIWLabel [18]
    Left = 35
    Top = 201
    Width = 102
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
    FriendlyName = 'lblTipoValutazione'
    Caption = 'Tipo valutazione'
    Enabled = True
  end
  object lblTipoChiusura: TmeIWLabel [19]
    Left = 196
    Top = 201
    Width = 84
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
    FriendlyName = 'lblTipoChiusura'
    Caption = 'Tipo chiusura'
    Enabled = True
  end
  object lblStatoAvanzamento: TmeIWLabel [20]
    Left = 35
    Top = 287
    Width = 121
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
    FriendlyName = 'lblStatoAvanzamento'
    Caption = 'Stato avanzamento'
    Enabled = True
  end
  object rgpDipValutabile: TmeTIWAdvRadioGroup [21]
    Left = 45
    Top = 349
    Width = 111
    Height = 68
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'rgpStatoAvanzamento'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Si'
      'No'
      'Tutto')
    ItemIndex = 2
    SubmitOnAsyncEvent = True
    TabOrder = 14
    OnAsyncClick = rgpAsyncClick
  end
  object lblDipValutabile: TmeIWLabel [22]
    Left = 35
    Top = 337
    Width = 134
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
    FriendlyName = 'lblDipValutabile'
    Caption = 'Dipendente valutabile'
    Enabled = True
  end
  object rgpPresaVisione: TmeTIWAdvRadioGroup [23]
    Left = 196
    Top = 349
    Width = 141
    Height = 60
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 2
    Editable = True
    FriendlyName = 'rgpStatoAvanzamento'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Si'
      'No'
      'Manca'
      'Tutto')
    ItemIndex = 3
    SubmitOnAsyncEvent = True
    TabOrder = 15
    OnAsyncClick = rgpAsyncClick
  end
  object lblPresaVisione: TmeIWLabel [24]
    Left = 196
    Top = 337
    Width = 136
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
    FriendlyName = 'lblDipValutabile'
    Caption = 'Presa visione valutato'
    Enabled = True
  end
  object rgpSchedeProtocollo: TmeTIWAdvRadioGroup [25]
    Left = 343
    Top = 337
    Width = 111
    Height = 68
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'rgpStatoAvanzamento'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Si'
      'No'
      'Tutto')
    ItemIndex = 2
    SubmitOnAsyncEvent = True
    TabOrder = 16
    OnAsyncClick = rgpAsyncClick
  end
  object lblSchedeProtocollo: TmeIWLabel [26]
    Left = 343
    Top = 327
    Width = 124
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
    FriendlyName = 'lblSchedeProtocollo'
    Caption = 'Schede protocollate'
    Enabled = True
  end
  object chkControllaRegola: TmeIWCheckBox [27]
    Left = 48
    Top = 416
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
    Caption = 'Controlla regola'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 17
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'chkControllaRegola'
  end
  object chkAggiornaPunteggi: TmeIWCheckBox [28]
    Left = 48
    Top = 430
    Width = 145
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
    Caption = 'Aggiorna punteggi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'Aggiorna punteggi'
  end
  object chkAvanzaStato: TmeIWCheckBox [29]
    Left = 48
    Top = 444
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
    Caption = 'Avanza stato'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 19
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'chkAvanzaStato'
  end
  object chkChiudiScheda: TmeIWCheckBox [30]
    Left = 48
    Top = 458
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
    Caption = 'Chiudi scheda'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 20
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkRiapriScheda: TmeIWCheckBox [31]
    Left = 48
    Top = 472
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
    Caption = 'Riapri scheda'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 21
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkRetrocediStato: TmeIWCheckBox [32]
    Left = 48
    Top = 485
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
    Caption = 'Retrocedi stato'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 22
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkAggiornaIncentivi: TmeIWCheckBox [33]
    Left = 48
    Top = 499
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
    Caption = 'Aggiorna incentivi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 23
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkStampa: TmeIWCheckBox [34]
    Left = 48
    Top = 512
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
    Caption = 'Stampa'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 24
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkFilePDF: TmeIWCheckBox [35]
    Left = 48
    Top = 526
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
    Caption = 'Archivio PDF'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 25
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkProtocolla: TmeIWCheckBox [36]
    Left = 48
    Top = 539
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
    Caption = 'Protocolla'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 26
    OnAsyncClick = chkAsyncClick
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkSostituisciRegola: TmeIWCheckBox [37]
    Left = 248
    Top = 416
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
    Caption = 'Sostituisci regola'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 27
    Checked = False
    FriendlyName = 'meIWCheckBox1'
  end
  object chkAssegnaValutatore: TmeIWCheckBox [38]
    Left = 248
    Top = 430
    Width = 185
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
    Caption = 'Assegna vecchio valutatore'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 28
    Checked = False
    FriendlyName = 'chkAssegnaValutatore'
  end
  object btnTipologieQuote: TmeIWButton [39]
    Left = 248
    Top = 481
    Width = 96
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
    Caption = 'Tipologie quote'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnTipologieQuote'
    TabOrder = 29
    OnClick = btnTipologieQuoteClick
    medpDownloadButton = False
  end
  object chkLegendaPunteggi: TmeIWCheckBox [40]
    Left = 248
    Top = 512
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
    Caption = 'Includi legenda punteggi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 30
    Checked = False
    FriendlyName = 'chkLegendaPunteggi'
  end
  object chkPresaVisione: TmeIWCheckBox [41]
    Left = 248
    Top = 526
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
    Caption = 'Elenca prese visione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 31
    Checked = False
    FriendlyName = 'chkPresaVisione'
  end
  object btnAnomalie: TmedpIWImageButton [42]
    Left = 30
    Top = 566
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
  object btnEsegui: TmedpIWImageButton [43]
    Left = 158
    Top = 566
    Width = 122
    Height = 27
    Css = 'inline'
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnCambioData: TmeIWButton [44]
    Left = 130
    Top = 152
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
    TabOrder = 32
    OnClick = btnCambioDataClick
    medpDownloadButton = False
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 352
    Top = 160
  end
end
