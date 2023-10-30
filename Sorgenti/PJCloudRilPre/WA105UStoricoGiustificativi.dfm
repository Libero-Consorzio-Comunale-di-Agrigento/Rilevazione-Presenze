inherited WA105FStoricoGiustificativi: TWA105FStoricoGiustificativi
  Tag = 6
  Width = 656
  Height = 711
  Title = '(WA105) Storico giustificativi'
  ExplicitWidth = 656
  ExplicitHeight = 711
  DesignLeft = 8
  DesignTop = 8
  object lblDaData: TmeIWLabel [9]
    Left = 16
    Top = 330
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
    FriendlyName = 'lblDaData'
    Caption = 'Da data'
    Enabled = True
  end
  object edtDaData: TmeIWEdit [10]
    Left = 69
    Top = 330
    Width = 73
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
    FriendlyName = 'edtDaData'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    Text = 'edtDaData'
  end
  object lblAData: TmeIWLabel [11]
    Left = 17
    Top = 352
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
    FriendlyName = 'lblAData'
    Caption = 'A data'
    Enabled = True
  end
  object edtAData: TmeIWEdit [12]
    Left = 69
    Top = 352
    Width = 73
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
    FriendlyName = 'edtAData'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtADataAsyncChange
    Text = 'edtAData'
  end
  object cmbCampo: TmeIWComboBox [13]
    Left = 16
    Top = 401
    Width = 244
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
    ItemsHaveValues = True
    RequireSelection = False
    UseSize = False
    OnAsyncChange = cmbCampoAsyncChange
    NonEditableAsLabel = True
    TabOrder = 9
    ItemIndex = -1
    FriendlyName = 'cmbCampo'
    NoSelectionText = ' '
  end
  object lblCampo: TmeIWLabel [14]
    Left = 16
    Top = 379
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
    FriendlyName = 'lblCampo'
    Caption = 'Campo anagrafico di raggruppamento:'
    Enabled = True
  end
  object lblStatoElab: TmeIWLabel [15]
    Left = 42
    Top = 436
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
    FriendlyName = 'lblStatoElab'
    Caption = 'Stato elaborazione su cedolini'
    Enabled = True
  end
  object btnStatoElab: TmeIWButton [16]
    Left = 16
    Top = 428
    Width = 20
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
    FriendlyName = 'btnStatoElab'
    TabOrder = 10
    OnClick = btnStatoElabClick
    medpDownloadButton = False
  end
  object chkRecordFisici: TmeIWCheckBox [17]
    Left = 16
    Top = 458
    Width = 214
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
    Caption = 'Tutte le operazioni registrate'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'chkRecordFisici'
  end
  object chkAssenzeInserite: TmeIWCheckBox [18]
    Left = 16
    Top = 477
    Width = 214
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
    Caption = 'Assenze inserite'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = False
    FriendlyName = 'chkAssenzeInserite'
  end
  object chkAssenzeCancellate: TmeIWCheckBox [19]
    Left = 16
    Top = 496
    Width = 214
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
    Caption = 'Assenze cancellate'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    Checked = False
    FriendlyName = 'chkAssenzeCancellate'
  end
  object chkDettaglioGiornaliero: TmeIWCheckBox [20]
    Left = 16
    Top = 515
    Width = 214
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
    Caption = 'Dettaglio giornaliero'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 14
    OnAsyncChange = chkDettaglioGiornalieroAsyncChange
    Checked = False
    FriendlyName = 'chkDettaglioGiornaliero'
  end
  object chkDettaglioPeriodico: TmeIWCheckBox [21]
    Left = 16
    Top = 534
    Width = 214
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
    Caption = 'Dettaglio periodico'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 15
    OnAsyncClick = chkDettaglioPeriodicoAsyncClick
    Checked = False
    FriendlyName = 'chkDettaglioPeriodico'
  end
  object chkDatiIndividuali: TmeIWCheckBox [22]
    Left = 16
    Top = 553
    Width = 214
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
    TabOrder = 16
    OnAsyncClick = chkDatiIndividualiAsyncClick
    Checked = False
    FriendlyName = 'chkDatiIndividuali'
  end
  object chkSaltoPaginaIndividuale: TmeIWCheckBox [23]
    Left = 16
    Top = 572
    Width = 214
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
    Caption = 'Salto pagina individuale'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 17
    Checked = False
    FriendlyName = 'chkSaltoPaginaIndividuale'
  end
  object chkSaltoPaginaRaggr: TmeIWCheckBox [24]
    Left = 16
    Top = 591
    Width = 214
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
    Caption = 'Salto pagina per raggruppamento'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    Checked = False
    FriendlyName = 'chkSaltoPaginaRaggr'
  end
  object chkTotaliIndividuali: TmeIWCheckBox [25]
    Left = 16
    Top = 610
    Width = 214
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
    Caption = 'Totali individuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 19
    Checked = False
    FriendlyName = 'chkTotaliIndividuali'
  end
  object btnGeneraPDF: TmedpIWImageButton [26]
    Left = 16
    Top = 675
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
  object lblDefinizionePeriodo: TmeIWLabel [27]
    Left = 338
    Top = 474
    Width = 272
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
    FriendlyName = 'lblDefinizionePeriodo'
    Caption = 'Definizione periodo assenze da considerare'
    Enabled = True
  end
  object lblPeriodoDal: TmeIWLabel [28]
    Left = 368
    Top = 501
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
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Da data'
    Enabled = True
  end
  object edtPeriodoDal: TmeIWEdit [29]
    Left = 421
    Top = 501
    Width = 73
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 20
    Text = 'edtPeriodoDal'
  end
  object lblPeriodoAl: TmeIWLabel [30]
    Left = 368
    Top = 523
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
    FriendlyName = 'lblPeriodoAl'
    Caption = 'A data'
    Enabled = True
  end
  object edtPeriodoAl: TmeIWEdit [31]
    Left = 421
    Top = 523
    Width = 73
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
    FriendlyName = 'edtPeriodoAl'
    SubmitOnAsyncEvent = True
    TabOrder = 21
    OnAsyncChange = edtADataAsyncChange
    Text = 'edtPeriodoAl'
  end
  object chkDefinizioneDataRegistrazione: TmeIWCheckBox [32]
    Left = 338
    Top = 553
    Width = 303
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
    Caption = 'Data registrazione uguale a data assenza'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 22
    OnAsyncChange = chkDefinizioneDataRegistrazioneAsyncChange
    Checked = False
    FriendlyName = 'chkDefinizioneDataRegistrazione'
  end
  object chkImpostaAssElab: TmeIWCheckBox [33]
    Left = 338
    Top = 572
    Width = 303
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
    Caption = 'Imposta assenza gi'#224' elaborata su cedolino'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 23
    Checked = False
    FriendlyName = 'chkImpostaAssElab'
  end
  object chkRegistrazioneInserimenti: TmeIWCheckBox [34]
    Left = 338
    Top = 610
    Width = 303
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
    Caption = 'Registrazione inserimenti mancanti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 24
    Checked = False
    FriendlyName = 'chkRegistrazioneInserimenti'
  end
  object chkRegistrazioneCancellazioni: TmeIWCheckBox [35]
    Left = 338
    Top = 629
    Width = 303
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
    Caption = 'Registrazione cancellazioni mancanti'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 25
    Checked = False
    FriendlyName = 'chkRegistrazioneCancellazioni'
  end
  object chkEliminazioneAssenze: TmeIWCheckBox [36]
    Left = 338
    Top = 648
    Width = 303
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
    Caption = 'Eliminazione movimenti non pi'#249' da storicizzare'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 26
    Checked = False
    FriendlyName = 'chkEliminazioneAssenze'
  end
  object lblDataRegistrazione: TmeIWLabel [37]
    Left = 338
    Top = 591
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
    FriendlyName = 'lblDataRegistrazione'
    Caption = 'Data registrazione movimento'
    Enabled = True
  end
  object edtDataRegistrazione: TmeIWEdit [38]
    Left = 517
    Top = 591
    Width = 73
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
    FriendlyName = 'edtDataRegistrazione'
    SubmitOnAsyncEvent = True
    TabOrder = 27
    Text = 'edtDataRegistrazione'
  end
  object btnEsegui: TmedpIWImageButton [39]
    Left = 338
    Top = 675
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object clbCausali: TmeTIWCheckListBox [40]
    Left = 338
    Top = 409
    Width = 303
    Height = 51
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BGColor = clWebWHITE
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.FontName = 'Courier New'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'clbCausali'
    SubmitOnAsyncEvent = True
    TabOrder = 28
    BorderColor = clBlack
    BorderWidth = 1
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    medpContextMenu = pmnAzioni
  end
  object lblCausali: TmeIWLabel [41]
    Left = 338
    Top = 387
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
    FriendlyName = 'lblCausali'
    Caption = 'Causali elaborate:'
    Enabled = True
  end
  object chkTotaliRaggr: TmeIWCheckBox [42]
    Left = 16
    Top = 629
    Width = 214
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
    Caption = 'Totali per raggruppamento'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 29
    Checked = False
    FriendlyName = 'chkTotaliRaggr'
  end
  object chkTotaliGenerali: TmeIWCheckBox [43]
    Left = 16
    Top = 648
    Width = 214
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
    Caption = 'Totali generali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 30
    Checked = False
    FriendlyName = 'chkTotaliGenerali'
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 120
    Top = 16
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 376
    Top = 24
  end
  object pmnAzioni: TPopupMenu
    Left = 544
    Top = 416
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = Invertiselezione1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = Invertiselezione1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = Invertiselezione1Click
    end
  end
end