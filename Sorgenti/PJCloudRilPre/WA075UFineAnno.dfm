inherited WA075FFineAnno: TWA075FFineAnno
  Tag = 37
  Width = 716
  Height = 718
  Title = '(WA075)  Passaggio di anno'
  ExplicitWidth = 716
  ExplicitHeight = 718
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 59
    Top = 136
    ExplicitLeft = 59
    ExplicitTop = 136
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 59
    Top = 74
    ExplicitLeft = 59
    ExplicitTop = 74
  end
  inherited btnShowElabError: TmeIWButton
    Left = 59
    Top = 105
    ExplicitLeft = 59
    ExplicitTop = 105
  end
  object lblDaData: TmeIWLabel [9]
    Left = 49
    Top = 192
    Width = 140
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
    Caption = 'Nuovo anno da gestire'
    Enabled = True
  end
  object edtAnno: TmeIWEdit [10]
    Left = 183
    Top = 187
    Width = 50
    Height = 21
    Css = 'input_num_nnnn width3chr'
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
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtAnnoAsyncChange
  end
  object chkTriggerBefore: TmeIWCheckBox [11]
    Left = 49
    Top = 225
    Width = 272
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Procedura Oracle prima dell'#39'elaborazione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 8
    Checked = False
    FriendlyName = 'chkTriggerBefore'
  end
  object chkTriggerAfter: TmeIWCheckBox [12]
    Left = 49
    Top = 252
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Procedura Oracle dopo l'#39'elaborazione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    Checked = False
    FriendlyName = 'chkTriggerAfter'
  end
  object chkCalendari: TmeIWCheckBox [13]
    Left = 49
    Top = 289
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione calendari'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    Checked = False
    FriendlyName = 'chkCalendari'
  end
  object chkProfiliAsse: TmeIWCheckBox [14]
    Left = 49
    Top = 310
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione profili assenza'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'chkProfiliAsse'
  end
  object chkProfiliIndividuali: TmeIWCheckBox [15]
    Left = 49
    Top = 329
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione profili assenza individuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = False
    FriendlyName = 'chkProfiliIndividuali'
  end
  object chkDebitiAggiuntivi: TmeIWCheckBox [16]
    Left = 49
    Top = 354
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione debiti aggiuntivi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    Checked = False
    FriendlyName = 'chkDebitiAggiuntivi'
  end
  object chkDebitiAggiuntiviIndiv: TmeIWCheckBox [17]
    Left = 49
    Top = 375
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione debiti aggiuntivi individuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 14
    Checked = False
    FriendlyName = 'chkDebitiAggiuntiviIndiv'
  end
  object lblLimitiEccedenze: TmeIWLabel [18]
    Left = 49
    Top = 409
    Width = 129
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
    FriendlyName = 'lblLimitiEccedenze'
    Caption = 'Limiti alle eccedenze'
    Enabled = True
  end
  object chkLimitiIndividualiAnnuali: TmeIWCheckBox [19]
    Left = 49
    Top = 431
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione limiti ecc. indiv. annuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 15
    OnAsyncClick = chkLimitiIndividualiAnnualiAsyncClick
    Checked = False
    FriendlyName = 'chkLimitiIndividualiAnnuali'
  end
  object chkLimitiMensili: TmeIWCheckBox [20]
    Left = 49
    Top = 537
    Width = 248
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione limiti eccedenze mensili'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 16
    OnAsyncClick = chkLimitiMensiliAsyncClick
    Checked = False
    FriendlyName = 'chkLimitiMensili'
  end
  object rgpLimiti: TmeIWRadioGroup [21]
    Left = 49
    Top = 565
    Width = 224
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
    FriendlyName = 'rgpLimiti'
    ItemIndex = 0
    Items.Strings = (
      'Mese per mese'
      'Solo dicembre')
    Layout = glHorizontal
    TabOrder = 17
  end
  object chkResiduiBuoniTicket: TmeIWCheckBox [22]
    Left = 345
    Top = 289
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Residui buoni pasto/ticket'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    OnAsyncClick = chkResiduiBuoniTicketAsyncClick
    Checked = False
    FriendlyName = 'chkResiduiBuoniTicket'
  end
  object chkResiduiCrediti: TmeIWCheckBox [23]
    Left = 345
    Top = 329
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Residui crediti formativi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 19
    Checked = False
    FriendlyName = 'chkResiduiCrediti'
  end
  object chkResiduiOre: TmeIWCheckBox [24]
    Left = 345
    Top = 356
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Residui saldo ore annuo'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 20
    OnAsyncClick = chkResiduiOreAsyncClick
    Checked = False
    FriendlyName = 'chkResiduiOre'
  end
  object chkResiduiAsse: TmeIWCheckBox [25]
    Left = 345
    Top = 409
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Residui assenze'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 21
    OnAsyncClick = chkResiduiAsseAsyncClick
    Checked = False
    FriendlyName = 'chkResiduiAsse'
  end
  object memResiduiAssenza: TmeIWMemo [26]
    Left = 345
    Top = 463
    Width = 223
    Height = 121
    Css = 'width35chr height10 fontcourier'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BGColor = clNone
    Editable = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    InvisibleBorder = False
    HorizScrollBar = False
    VertScrollBar = True
    Required = False
    TabOrder = 22
    SubmitOnAsyncEvent = True
    FriendlyName = 'memResiduiAssenza'
  end
  object btnAnomalie: TmedpIWImageButton [27]
    Left = 216
    Top = 632
    Width = 154
    Height = 31
    Hint = 'Anomalie'
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
  object btnEsegui: TmedpIWImageButton [28]
    Left = 49
    Top = 632
    Width = 154
    Height = 31
    Hint = 'Esegui'
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
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnSrcResiduiTriggerBefore: TmeIWImageButton [29]
    Left = 311
    Top = 221
    Width = 36
    Height = 25
    Hint = 'Sorgente pl/sql'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    AltText = 'Sorgente pl/sql'
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = btnSrcResiduiTriggerBeforeClick
    Cacheable = True
    FriendlyName = 'btnSrcResiduiTriggerBefore'
    ImageFile.Filename = 'img\btnAnteprimaStampa.png'
  end
  object btnSrcResiduiTriggerAfter: TmeIWImageButton [30]
    Left = 311
    Top = 252
    Width = 36
    Height = 25
    Hint = 'Sorgente pl/sql'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    AltText = 'Sorgente pl/sql'
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = btnSrcResiduiTriggerBeforeClick
    Cacheable = True
    FriendlyName = 'btnSrcResiduiTriggerAfter'
    ImageFile.Filename = 'img\btnAnteprimaStampa.png'
  end
  object chkResiduiBuoniTicketOvr: TmeIWCheckBox [31]
    Left = 367
    Top = 311
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Sovrascrivi dati esistenti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 23
    Checked = False
    Enabled = False
    FriendlyName = 'chkResiduiBuoniTicketOvr'
  end
  object chkResiduiOreOvr: TmeIWCheckBox [32]
    Left = 367
    Top = 382
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Sovrascrivi dati esistenti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 24
    Checked = False
    Enabled = False
    FriendlyName = 'chkResiduiOreOvr'
  end
  object chkResiduiAsseOvr: TmeIWCheckBox [33]
    Left = 367
    Top = 436
    Width = 201
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Sovrascrivi dati esistenti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 25
    Checked = False
    Enabled = False
    FriendlyName = 'chkResiduiAsseOvr'
  end
  object chkLimitiIndividualiAnnualiOvr: TmeIWCheckBox [34]
    Left = 59
    Top = 458
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Sovrascrivi dati esistenti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 26
    Checked = False
    Enabled = False
    FriendlyName = 'chkLimitiIndividualiAnnualiOvr'
  end
  object chkLimitiIndividualiMensili: TmeIWCheckBox [35]
    Left = 49
    Top = 485
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Generazione limiti ecc. indiv. mensili'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 27
    OnAsyncClick = chkLimitiIndividualiMensiliAsyncClick
    Checked = False
    FriendlyName = 'chkLimitiIndividualiMensili'
  end
  object chkLimitiIndividualiMensiliOvr: TmeIWCheckBox [36]
    Left = 65
    Top = 510
    Width = 256
    Height = 21
    Cursor = crAuto
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Sovrascrivi dati esistenti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 28
    Checked = False
    Enabled = False
    FriendlyName = 'chkLimitiIndividualiMensiliOvr'
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Top = 16
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Top = 72
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 608
    Top = 128
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 608
    Top = 16
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 608
    Top = 72
  end
  object JQVisual: TIWJQueryWidget
    Enabled = True
    Left = 488
    Top = 208
  end
end
