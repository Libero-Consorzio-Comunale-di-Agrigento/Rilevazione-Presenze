inherited WA061FDettAssenze: TWA061FDettAssenze
  Tag = 30
  Width = 870
  Height = 787
  Title = '(WA061) Elenco assenze individuali'
  ExplicitWidth = 870
  ExplicitHeight = 787
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 73
    Top = 122
    ExplicitLeft = 73
    ExplicitTop = 122
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 85
    Top = 60
    ExplicitLeft = 85
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 73
    Top = 91
    ExplicitLeft = 73
    ExplicitTop = 91
  end
  object lblDaData: TmeIWLabel [9]
    Left = 297
    Top = 160
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
    FriendlyName = 'lblDaData'
    Caption = 'Dalla data'
    Enabled = True
  end
  object edtDaData: TmeIWEdit [10]
    Left = 379
    Top = 160
    Width = 70
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
    FriendlyName = 'edtDaData'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnAsyncChange = edtDaDataAsyncChange
  end
  object lblAData: TmeIWLabel [11]
    Left = 513
    Top = 159
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
    FriendlyName = 'lblAData'
    Caption = 'Alla data'
    Enabled = True
  end
  object edtAData: TmeIWEdit [12]
    Left = 574
    Top = 160
    Width = 67
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
    FriendlyName = 'edtAData'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncDoubleClick = edtADataAsyncDoubleClick
    OnAsyncChange = edtADataAsyncChange
  end
  object chkSoloAssRegSucc: TmeIWCheckBox [13]
    Left = 319
    Top = 241
    Width = 265
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
    Caption = 'Solo assenze con registrazione nel periodo'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    OnClick = chkSoloAssRegSuccClick
    Checked = False
    FriendlyName = 'chkSoloAssRegSucc'
  end
  object lblRegStamp: TmeIWLabel [14]
    Left = 297
    Top = 208
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
    FriendlyName = 'lblRegStamp'
    Caption = 'Data di registrazione'
    Enabled = True
  end
  object lblDaRegStamp: TmeIWLabel [15]
    Left = 319
    Top = 276
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
    FriendlyName = 'lblDaRegStamp'
    Caption = 'Dalla data'
    Enabled = True
  end
  object edtDaRegStamp: TmeIWEdit [16]
    Left = 401
    Top = 276
    Width = 70
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
    FriendlyName = 'edtDaRegStamp'
    SubmitOnAsyncEvent = True
    TabOrder = 10
    OnAsyncChange = edtDaRegStampAsyncChange
  end
  object lblARegStamp: TmeIWLabel [17]
    Left = 495
    Top = 276
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
    FriendlyName = 'lblARegStamp'
    Caption = 'Alla data'
    Enabled = True
  end
  object edtARegStamp: TmeIWEdit [18]
    Left = 556
    Top = 276
    Width = 67
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
    FriendlyName = 'edtARegStamp'
    SubmitOnAsyncEvent = True
    TabOrder = 11
    OnAsyncChange = edtARegStampAsyncChange
  end
  object chkSalvaUltRegStamp: TmeIWCheckBox [19]
    Left = 661
    Top = 276
    Width = 108
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
    Caption = 'Memorizza'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = False
    FriendlyName = 'chkSalvaUltRegStamp'
  end
  object lblAssenzeConsiderate: TmeIWLabel [20]
    Left = 320
    Top = 312
    Width = 149
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
    FriendlyName = 'lblAssenzeConsiderate'
    Caption = 'Assenze da considerare'
    Enabled = True
  end
  object rgpAssenzeConsiderate: TmeIWRadioGroup [21]
    Left = 320
    Top = 334
    Width = 385
    Height = 35
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
    FriendlyName = 'rgpAssenzeConsiderate'
    ItemIndex = 0
    Items.Strings = (
      'Tutte'
      'Assenze inserite'
      'Assenze cancellate')
    Layout = glHorizontal
    TabOrder = 13
  end
  object lblDati: TmeIWLabel [22]
    Left = 297
    Top = 358
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
    FriendlyName = 'lblDati'
    Caption = 'Parametri di stampa'
    Enabled = True
  end
  object chkDatiIndividuali: TmeIWCheckBox [23]
    Left = 303
    Top = 376
    Width = 168
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
    Caption = 'Stampa dati individuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 14
    OnAsyncClick = chkDatiIndividualiAsyncClick
    Checked = True
    FriendlyName = 'chkDatiIndividuali'
  end
  object chkStampaNominativo: TmeIWCheckBox [24]
    Left = 319
    Top = 419
    Width = 168
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
    Caption = 'Nominativo'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 15
    OnAsyncClick = chkStampaNominativoAsyncClick
    Checked = True
    FriendlyName = 'chkStampaNominativo'
  end
  object chkStampaMatricola: TmeIWCheckBox [25]
    Left = 320
    Top = 439
    Width = 168
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
    Caption = 'Matricola'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 16
    OnAsyncClick = chkStampaMatricolaAsyncClick
    Checked = True
    FriendlyName = 'chkStampaMatricola'
  end
  object chkStampaBadge: TmeIWCheckBox [26]
    Left = 320
    Top = 459
    Width = 168
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
    Caption = 'Badge'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 17
    OnAsyncClick = chkStampaBadgeAsyncClick
    Checked = True
    FriendlyName = 'chkStampaBadge'
  end
  object chkDettGiorn: TmeIWCheckBox [27]
    Left = 303
    Top = 486
    Width = 168
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
    Caption = 'Dettaglio giornaliero'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 18
    OnAsyncClick = chkDettGiornAsyncClick
    Checked = False
    FriendlyName = 'chkDettGiorn'
  end
  object chkDettPer: TmeIWCheckBox [28]
    Left = 303
    Top = 510
    Width = 168
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
    Caption = 'Dettaglio periodico'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 19
    OnAsyncClick = chkDettPerAsyncClick
    Checked = True
    FriendlyName = 'chkDettPer'
  end
  object rgpOrdinamento: TmeIWRadioGroup [29]
    Left = 303
    Top = 558
    Width = 168
    Height = 19
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
    FriendlyName = 'rgpOrdinamento'
    ItemIndex = 0
    Items.Strings = (
      'Per data'
      'Per causale')
    Layout = glHorizontal
    TabOrder = 20
  end
  object lblOrdinamento: TmeIWLabel [30]
    Left = 303
    Top = 536
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
    FriendlyName = 'lblOrdinamento'
    Caption = 'Ordinamento'
    Enabled = True
  end
  object lblCampo: TmeIWLabel [31]
    Left = 601
    Top = 375
    Width = 213
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
    Caption = 'Campo anagr. di raggruppamento'
    Enabled = True
  end
  object chkSaltoPagRaggrup: TmeIWCheckBox [32]
    Left = 601
    Top = 424
    Width = 168
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
    Caption = 'Salto pagina per raggruppamento'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 21
    Checked = False
    FriendlyName = 'chkSaltoPagRaggrup'
  end
  object chkSaltoPagIndividuale: TmeIWCheckBox [33]
    Left = 601
    Top = 451
    Width = 168
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
    Caption = 'Salto pagina individuale'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 22
    Checked = False
    FriendlyName = 'chkSaltoPagIndividuale'
  end
  object lblValidate: TmeIWLabel [34]
    Left = 601
    Top = 486
    Width = 126
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
    FriendlyName = 'lblValidate'
    Caption = 'Validazione assenze'
    Enabled = True
  end
  object rgpValidate: TmeIWRadioGroup [35]
    Left = 601
    Top = 517
    Width = 256
    Height = 35
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
    FriendlyName = 'rgpValidate'
    ItemIndex = 0
    Items.Strings = (
      'Da validare'
      'Validate'
      'Tutte')
    Layout = glHorizontal
    TabOrder = 23
  end
  object lblConteggi: TmeIWLabel [36]
    Left = 297
    Top = 583
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
    FriendlyName = 'lblConteggi'
    Caption = 'Parametri di calcolo'
    Enabled = True
  end
  object chkConiuge: TmeIWCheckBox [37]
    Left = 319
    Top = 605
    Width = 168
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
    Caption = 'Conteggi con coniuge'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 24
    Checked = False
    FriendlyName = 'chkConiuge'
  end
  object chkRiduzioni: TmeIWCheckBox [38]
    Left = 320
    Top = 627
    Width = 168
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
    Caption = 'Calcola riduzioni'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 25
    OnAsyncClick = chkDatiIndividualiAsyncClick
    Checked = False
    FriendlyName = 'chkRiduzioni'
  end
  object chkSoloRiduzioni: TmeIWCheckBox [39]
    Left = 319
    Top = 645
    Width = 194
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
    Caption = 'Stampa solo assenze ridotte'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 26
    Checked = False
    FriendlyName = 'chkSoloRiduzioni'
  end
  object chkConteggiGG: TmeIWCheckBox [40]
    Left = 320
    Top = 667
    Width = 168
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
    Caption = 'Conteggi giornalieri'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 27
    Checked = False
    FriendlyName = 'chkConteggiGG'
  end
  object chkGiorniSignificativi: TmeIWCheckBox [41]
    Left = 574
    Top = 605
    Width = 219
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
    Caption = 'Considera giorni di significativit'#224
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 28
    OnAsyncClick = chkDatiIndividualiAsyncClick
    Checked = False
    FriendlyName = 'chkGiorniSignificativi'
  end
  object lblGGMinCont: TmeIWLabel [42]
    Left = 575
    Top = 632
    Width = 161
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
    FriendlyName = 'lblGGMinCont'
    Caption = 'Giorni minimi continuativi '
    Enabled = True
  end
  object edtGGMinCont: TmeIWEdit [43]
    Left = 742
    Top = 632
    Width = 51
    Height = 21
    Css = 'width5chr input_integer'
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
    FriendlyName = 'edtGGMinCont'
    SubmitOnAsyncEvent = True
    TabOrder = 29
  end
  object chkCausaliCumulate: TmeIWCheckBox [44]
    Left = 575
    Top = 652
    Width = 219
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
    Caption = 'Causali cumulate insieme'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 30
    Checked = False
    FriendlyName = 'chkCausaliCumulate'
  end
  object chkPeriodoServizio: TmeIWCheckBox [45]
    Left = 575
    Top = 672
    Width = 250
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
    Caption = 'Considera periodo servizio ass./cess.'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 31
    Checked = False
    FriendlyName = 'chkPeriodoServizio'
  end
  object lblTotali: TmeIWLabel [46]
    Left = 297
    Top = 703
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
    HasTabOrder = False
    FriendlyName = 'lblTotali'
    Caption = 'Totali'
    Enabled = True
  end
  object chkTotIndividuali: TmeIWCheckBox [47]
    Left = 320
    Top = 725
    Width = 168
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
    Caption = 'Individuali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 32
    OnAsyncClick = chkTotIndividualiAsyncClick
    Checked = True
    FriendlyName = 'chkTotIndividuali'
  end
  object chkTotFam: TmeIWCheckBox [48]
    Left = 320
    Top = 752
    Width = 168
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
    Caption = 'Distinti per familiare'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 33
    Checked = False
    FriendlyName = 'chkTotFam'
  end
  object chkTotRaggrup: TmeIWCheckBox [49]
    Left = 520
    Top = 725
    Width = 168
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
    Caption = 'Per raggruppamento'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 34
    Checked = False
    FriendlyName = 'chkTotRaggrup'
  end
  object chkTotGenerali: TmeIWCheckBox [50]
    Left = 520
    Top = 752
    Width = 168
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
    Caption = 'Generali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 35
    Checked = True
    FriendlyName = 'chkTotGenerali'
  end
  object cmbTipoAcc: TMedpIWMultiColumnComboBox [51]
    Left = 25
    Top = 181
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
    FriendlyName = 'cmbTipoAcc'
    SubmitOnAsyncEvent = True
    TabOrder = 36
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    OnChange = cmbTipoAccChange
    medpAutoResetItems = True
    CssInputText = 'width10chr'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblCodAcc: TmeIWLabel [52]
    Left = 19
    Top = 336
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
    FriendlyName = 'lblCodAcc'
    Caption = 'Codici accorpamento'
    Enabled = True
  end
  object lblCodCau: TmeIWLabel [53]
    Left = 19
    Top = 425
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
    FriendlyName = 'lblCodCau'
    Caption = 'Codici causali'
    Enabled = True
  end
  object btnGeneraPDF: TmedpIWImageButton [54]
    Left = 38
    Top = 725
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
  object lstCodAcc: TmeTIWAdvCheckGroup [55]
    Left = 32
    Top = 358
    Height = 24
    Css = 'intestazione nowrapcheckgroup noborder'
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
    FriendlyName = 'lstCodAcc'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 37
    OnAsyncItemClick = lstCodAccAsyncItemClick
    medpContextMenu = pmnAzioniCodAccorp
  end
  object LstCausali: TmeTIWAdvCheckGroup [56]
    Left = 32
    Top = 447
    Height = 24
    Css = 'intestazione nowrapcheckgroup noborder'
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
    FriendlyName = 'LstCausali'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 38
    OnAsyncItemClick = LstCausaliAsyncItemClick
    medpContextMenu = pmnAzioniCodCausali
  end
  object lnkTipoAcc: TmeIWLink [57]
    Left = 25
    Top = 158
    Width = 121
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
    FriendlyName = 'lnkTipoAcc'
    OnClick = lnkTipoAccClick
    TabOrder = 39
    RawText = False
    Caption = 'Tipo accorpamento'
    medpDownloadButton = False
  end
  object cmbCampo: TMedpIWMultiColumnComboBox [58]
    Left = 601
    Top = 397
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
    FriendlyName = 'cmbCampo'
    SubmitOnAsyncEvent = True
    TabOrder = 40
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
  object lblTipoAcc: TmeIWLabel [59]
    Left = 152
    Top = 186
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
    FriendlyName = 'lblTipoAcc'
    Enabled = True
  end
  object btnVisStampa: TmedpIWImageButton [60]
    Left = 38
    Top = 686
    Width = 166
    Height = 33
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
    OnClick = btnVisStampaClick
    Cacheable = True
    FriendlyName = 'btnVisStampa'
    ImageFile.Filename = 'img\btnVideo.png'
    medpDownloadButton = False
    Caption = 'Visualizza'
  end
  object chkStampaDatiAnagrafici: TmeIWCheckBox [61]
    Left = 320
    Top = 399
    Width = 209
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
    Caption = 'Dati anagrafici della selezione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 41
    OnAsyncClick = chkStampaDatiAnagraficiAsyncClick
    Checked = False
    FriendlyName = 'chkStampaDatiAnagrafici'
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 440
    Top = 16
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 440
    Top = 72
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 704
    Top = 24
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 704
    Top = 88
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 568
    Top = 16
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 568
    Top = 80
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 760
    Top = 16
  end
  object pmnAzioniCodAccorp: TPopupMenu
    Left = 154
    Top = 361
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = pmnAzioniCodAccorpClick
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = pmnAzioniCodAccorpClick
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = pmnAzioniCodAccorpClick
    end
  end
  object pmnAzioniCodCausali: TPopupMenu
    Left = 154
    Top = 441
    object SelezionaTutto2: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = InvertiSelezione2Click
    end
    object DeselezionaTutto2: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = InvertiSelezione2Click
    end
    object InvertiSelezione2: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = InvertiSelezione2Click
    end
  end
end
