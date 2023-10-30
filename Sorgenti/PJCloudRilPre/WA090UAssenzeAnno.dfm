inherited WA090FAssenzeAnno: TWA090FAssenzeAnno
  Tag = 41
  Width = 736
  Height = 745
  Title = '(WA090) Scheda annuale assenze'
  ExplicitWidth = 736
  ExplicitHeight = 745
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 88
    Top = 122
    ExplicitLeft = 88
    ExplicitTop = 122
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 88
    Top = 60
    ExplicitLeft = 88
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 88
    Top = 91
    ExplicitLeft = 88
    ExplicitTop = 91
  end
  object btnGeneraPDF: TmedpIWImageButton [9]
    Left = 43
    Top = 695
    Width = 166
    Height = 35
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
  object lblSelPeriodo: TmeIWLabel [10]
    Left = 38
    Top = 185
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
    FriendlyName = 'lblSelPeriodo'
    Caption = 'Selezione periodo'
    Enabled = True
  end
  object lblDaAnno: TmeIWLabel [11]
    Left = 43
    Top = 213
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
    ForControl = edtDaAnno
    HasTabOrder = False
    FriendlyName = 'lblDaAnno'
    Caption = 'Anno'
    Enabled = True
  end
  object edtDaAnno: TmeIWEdit [12]
    Left = 80
    Top = 209
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
    FriendlyName = 'edtDaAnno'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 7
    Text = '0'
  end
  object lblDaMese: TmeIWLabel [13]
    Left = 130
    Top = 213
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
    ForControl = edtDaMese
    HasTabOrder = False
    FriendlyName = 'lblDaMese'
    Caption = 'Da mese'
    Enabled = True
  end
  object edtDaMese: TmeIWEdit [14]
    Left = 192
    Top = 209
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
    FriendlyName = 'edtDaMese'
    MaxLength = 2
    SubmitOnAsyncEvent = True
    TabOrder = 8
    Text = '0'
  end
  object edtAMese: TmeIWEdit [15]
    Left = 299
    Top = 209
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
    FriendlyName = 'edtAMese'
    MaxLength = 2
    SubmitOnAsyncEvent = True
    TabOrder = 9
    Text = '0'
  end
  object lblAMese: TmeIWLabel [16]
    Left = 246
    Top = 213
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
    ForControl = edtAMese
    HasTabOrder = False
    FriendlyName = 'lblAMese'
    Caption = 'A mese'
    Enabled = True
  end
  object lblOpzioniStampa: TmeIWLabel [17]
    Left = 43
    Top = 254
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
    FriendlyName = 'lblOpzioniStampa'
    Caption = 'Opzioni di stampa'
    Enabled = True
  end
  object chkSegnalazPresenza: TmeIWCheckBox [18]
    Left = 43
    Top = 279
    Width = 182
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
    Caption = 'Segnalazione presenze'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    OnAsyncClick = chkSegnalazPresenzaAsyncClick
    Checked = True
    FriendlyName = 'chkSegnalazPresenza'
  end
  object edtCaratteri: TmeIWEdit [19]
    Left = 183
    Top = 305
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
    FriendlyName = 'edtCaratteri'
    MaxLength = 80
    SubmitOnAsyncEvent = True
    TabOrder = 11
    Text = '*****'
  end
  object lblCaratteri: TmeIWLabel [20]
    Left = 44
    Top = 308
    Width = 141
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
    ForControl = edtCaratteri
    HasTabOrder = False
    FriendlyName = 'lblCaratteri'
    Caption = 'Caratteri per presenza'
    Enabled = True
  end
  object chkSecCausaleAss: TmeIWCheckBox [21]
    Left = 43
    Top = 332
    Width = 230
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
    Caption = 'Stampa seconda causale assenza'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = True
    FriendlyName = 'chkSecCausaleAss'
  end
  object chkRigaValoriz: TmeIWCheckBox [22]
    Left = 43
    Top = 352
    Width = 190
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
    Caption = 'Stampa riga valorizzazione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    Checked = True
    FriendlyName = 'chkRigaValoriz'
  end
  object chkTotIndiv: TmeIWCheckBox [23]
    Left = 43
    Top = 372
    Width = 182
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
    Caption = 'Totali individuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 14
    Checked = True
    FriendlyName = 'chkTotIndiv'
  end
  object chkSaltoPag: TmeIWCheckBox [24]
    Left = 43
    Top = 412
    Width = 190
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
    Caption = 'Salto pagina per dipendente'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 15
    Checked = True
    FriendlyName = 'chkSaltoPag'
  end
  object chkStampaAllDip: TmeIWCheckBox [25]
    Left = 43
    Top = 432
    Width = 230
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
    Caption = 'Stampa dipendenti senza assenze'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 16
    Checked = False
    FriendlyName = 'chkStampaAllDip'
  end
  object chkGGSett: TmeIWCheckBox [26]
    Left = 43
    Top = 452
    Width = 182
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
    Caption = 'Stampa GG settimana'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 17
    Checked = False
    FriendlyName = 'chkGGSett'
  end
  object chkIntestazione: TmeIWCheckBox [27]
    Left = 43
    Top = 503
    Width = 182
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
    Caption = 'Stampa intestazione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    OnAsyncClick = chkIntestazioneAsyncClick
    Checked = True
    FriendlyName = 'chkIntestazione'
  end
  object chkData: TmeIWCheckBox [28]
    Left = 59
    Top = 524
    Width = 182
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
    Caption = 'Data di stampa'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 19
    Checked = True
    FriendlyName = 'chkData'
  end
  object chkNumPagina: TmeIWCheckBox [29]
    Left = 59
    Top = 540
    Width = 182
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
    Caption = 'Numero pagina'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 20
    Checked = True
    FriendlyName = 'chkNumPagina'
  end
  object chkAzienda: TmeIWCheckBox [30]
    Left = 59
    Top = 560
    Width = 182
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
    Caption = 'Azienda'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 21
    Checked = True
    FriendlyName = 'chkAzienda'
  end
  object lblTitolo: TmeIWLabel [31]
    Left = 67
    Top = 582
    Width = 35
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
    ForControl = edtTitolo
    HasTabOrder = False
    FriendlyName = 'lblTitolo'
    Caption = 'Titolo'
    Enabled = True
  end
  object edtTitolo: TmeIWEdit [32]
    Left = 108
    Top = 577
    Width = 165
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
    FriendlyName = 'edtTitolo'
    MaxLength = 80
    SubmitOnAsyncEvent = True
    TabOrder = 22
    Text = ' '
  end
  object CgpListaAnagr: TmeTIWAdvCheckGroup [33]
    Left = 393
    Top = 254
    Height = 24
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebBLACK
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'CgpListaAnagr'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 23
    medpContextMenu = pmnAzioni
  end
  object lblListaAnagr: TmeIWLabel [34]
    Left = 393
    Top = 224
    Width = 154
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
    FriendlyName = 'lblListaAnagr'
    Caption = 'Selezione dati anagrafici'
    Enabled = True
  end
  object lblListaCausali: TmeIWLabel [35]
    Left = 401
    Top = 344
    Width = 178
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
    FriendlyName = 'lblListaCausali'
    Caption = 'Selezione causali di assenza'
    Enabled = True
  end
  object CgpListaCausali: TmeTIWAdvCheckGroup [36]
    Left = 401
    Top = 374
    Height = 24
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebBLACK
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'CgpListaCausali'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 24
    medpContextMenu = PopupMenu1
  end
  object lblLogo: TmeIWLabel [37]
    Left = 59
    Top = 604
    Width = 234
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
    FriendlyName = 'lblOpzioniStampa'
    Caption = 'Dimensioni logo per la stampa (pixel)'
    Enabled = True
  end
  object lblLarghezza: TmeIWLabel [38]
    Left = 67
    Top = 627
    Width = 63
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
    ForControl = edtLogoLarghezza
    HasTabOrder = False
    FriendlyName = 'lblLarghezza'
    Caption = 'Larghezza'
    Enabled = True
  end
  object edtLogoLarghezza: TmeIWEdit [39]
    Left = 108
    Top = 623
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
    FriendlyName = 'edtLogoLarghezza'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 25
    OnAsyncExit = edtLogoLarghezzaAsyncExit
    Text = '0'
  end
  object lblAltezza: TmeIWLabel [40]
    Left = 193
    Top = 627
    Width = 45
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
    ForControl = edtLogoAltezza
    HasTabOrder = False
    FriendlyName = 'lblAltezza'
    Caption = 'Altezza'
    Enabled = True
  end
  object edtLogoAltezza: TmeIWEdit [41]
    Left = 235
    Top = 623
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
    FriendlyName = 'edtLogoAltezza'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 26
    OnAsyncExit = edtLogoAltezzaAsyncExit
    Text = '0'
  end
  object chkRiepilogoCompetenze: TmeIWCheckBox [42]
    Left = 43
    Top = 392
    Width = 182
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
    Caption = 'Riepilogo delle competenze'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 27
    Checked = True
    FriendlyName = 'chkRiepilogoCompetenze'
  end
  object lblFirma: TmeIWLabel [43]
    Left = 44
    Top = 670
    Width = 36
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
    ForControl = edtFirma
    HasTabOrder = False
    FriendlyName = 'lblFirma'
    Caption = 'Firma'
    Enabled = True
  end
  object edtFirma: TmeIWEdit [44]
    Left = 85
    Top = 665
    Width = 188
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
    FriendlyName = 'edtFirma'
    MaxLength = 80
    SubmitOnAsyncEvent = True
    TabOrder = 28
    Text = ' '
  end
  object rgpRichiesteIrisWEB: TmeTIWAdvRadioGroup [45]
    Left = 40
    Top = 475
    Width = 289
    Height = 30
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = 'Richieste IrisWEB'
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 3
    Editable = True
    FriendlyName = 'rgpRichiesteIrisWEB'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'No'
      'Richieste'
      'Autorizzate')
    ItemIndex = 0
    Layout = glHorizontal
    SubmitOnAsyncEvent = True
    TabOrder = 29
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 512
    Top = 8
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 512
    Top = 64
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 640
    Top = 128
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 512
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 640
    Top = 8
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 640
    Top = 64
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 392
    Top = 8
  end
  object pmnAzioni: TPopupMenu
    Left = 496
    Top = 272
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = Invertiselezione1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 496
    Top = 384
    object MenuItem1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = Selezionatutto2Click
    end
    object MenuItem2: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = Deselezionatutto2Click
    end
    object MenuItem3: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = Invertiselezione2Click
    end
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 288
    Top = 8
  end
end
