inherited WP554FElaborazioneContoAnnuale: TWP554FElaborazioneContoAnnuale
  Tag = 583
  Width = 723
  Height = 811
  ExplicitWidth = 723
  ExplicitHeight = 811
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  object lblAnno: TmeIWLabel [9]
    Left = 24
    Top = 419
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
    Left = 61
    Top = 419
    Width = 66
    Height = 21
    Css = 'input_num_nnnn width4chr'
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
    TabOrder = 6
    OnAsyncChange = edtAnnoAsyncChange
  end
  object lblMeseDa: TmeIWLabel [11]
    Left = 235
    Top = 463
    Width = 52
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
    ForControl = edtMeseDa
    HasTabOrder = False
    FriendlyName = 'Mese da'
    Caption = 'Mese da'
    Enabled = True
  end
  object edtMeseDa: TmeIWEdit [12]
    Left = 304
    Top = 458
    Width = 73
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
    FriendlyName = 'edtMeseDa'
    SubmitOnAsyncEvent = True
    TabOrder = 8
  end
  object lblMeseA: TmeIWLabel [13]
    Left = 235
    Top = 485
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
    ForControl = edtMeseA
    HasTabOrder = False
    FriendlyName = 'Mese a'
    Caption = 'Mese a'
    Enabled = True
  end
  object edtMeseA: TmeIWEdit [14]
    Left = 304
    Top = 480
    Width = 73
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
    FriendlyName = 'edtMeseA'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncDoubleClick = edtMeseAAsyncDoubleClick
  end
  object chkElaboraDatiCONTANN: TmeIWCheckBox [15]
    Left = 24
    Top = 485
    Width = 201
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
    Caption = 'Calcola dati conto annuale'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    OnClick = chkElaboraDatiCONTANNClick
    Checked = False
    FriendlyName = 'chkElaboraDatiCONTANN'
  end
  object chkElaboraRiepiloghi: TmeIWCheckBox [16]
    Left = 24
    Top = 520
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
    Caption = 'Calcola dati riepilogativi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    OnClick = chkElaboraDatiCONTANNClick
    Checked = False
    FriendlyName = 'chkElaboraRiepiloghi'
  end
  object chkElabRisorseResidue: TmeIWCheckBox [17]
    Left = 24
    Top = 560
    Width = 201
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
    Caption = 'Distribuzione risorse residue'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    OnClick = chkElaboraDatiCONTANNClick
    Checked = False
    FriendlyName = 'chkElabRisorseResidue'
  end
  object chkEsportazione: TmeIWCheckBox [18]
    Left = 24
    Top = 600
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
    Caption = 'Esportazione su file'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    OnClick = chkElaboraDatiCONTANNClick
    Checked = False
    FriendlyName = 'chkEsportazione'
  end
  object rgpStatoCedolini: TmeIWRadioGroup [19]
    Left = 443
    Top = 485
    Width = 292
    Height = 29
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
    FriendlyName = 'rgpStatoCedolini'
    ItemIndex = 0
    Items.Strings = (
      'Solo chiusi'
      'Chiusi e aperti'
      'Solo aperti')
    Layout = glHorizontal
    TabOrder = 14
  end
  object chkAnnulla: TmeIWCheckBox [20]
    Left = 231
    Top = 560
    Width = 228
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
    Caption = 'Annulla dati conto annuale'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 15
    OnClick = chkElaboraDatiCONTANNClick
    Checked = False
    FriendlyName = 'chkAnnulla'
  end
  object chkChiusura: TmeIWCheckBox [21]
    Left = 431
    Top = 560
    Width = 140
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
    Caption = 'Chiusura'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 16
    OnClick = chkElaboraDatiCONTANNClick
    Checked = False
    FriendlyName = 'chkChiusura'
  end
  object lblDataChiusura: TmeIWLabel [22]
    Left = 522
    Top = 560
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
    ForControl = edtDataChiusura
    HasTabOrder = False
    FriendlyName = 'lblDataChiusura'
    Caption = 'Data di chiusura'
    Enabled = True
  end
  object edtDataChiusura: TmeIWEdit [23]
    Left = 618
    Top = 560
    Width = 81
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
    FriendlyName = 'edtDataChiusura'
    SubmitOnAsyncEvent = True
    TabOrder = 17
  end
  object btnImpostazioni: TmeIWButton [24]
    Left = 229
    Top = 600
    Width = 97
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
    Caption = 'Impostazioni...'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnImpostazioni'
    TabOrder = 18
    OnClick = btnImpostazioniClick
    medpDownloadButton = False
  end
  object lblTabelle: TmeIWLabel [25]
    Left = 24
    Top = 639
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
    ForControl = clbTabElab
    HasTabOrder = False
    FriendlyName = 'lblTabelle'
    Caption = 'Tabelle da elaborare:'
    Enabled = True
  end
  object clbTabElab: TmeTIWCheckListBox [26]
    Left = 24
    Top = 656
    Width = 318
    Height = 89
    Css = 'nowrapchecklistbox'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'Arial'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'clbTabElab'
    SubmitOnAsyncEvent = True
    TabOrder = 19
    BorderColor = clNone
    BorderWidth = 0
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    OnAsyncCheckClick = clbTabElabAsyncCheckClick
    medpContextMenu = pmnAzioni
  end
  object btnAnno: TmeIWButton [27]
    Left = 133
    Top = 415
    Width = 41
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
    Caption = 'btnAnno'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnAnno'
    TabOrder = 20
    OnClick = btnAnnoClick
    medpDownloadButton = False
  end
  object lblStatoCedolini: TmeIWLabel [28]
    Left = 431
    Top = 463
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
    FriendlyName = 'lblStatoCedolini'
    Caption = 'Stato cedolini da considerare'
    Enabled = True
  end
  object btnEsegui: TmedpIWImageButton [29]
    Left = 57
    Top = 766
    Width = 105
    Height = 31
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.Filename = 'img\btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnVisualizzaFile: TmedpIWImageButton [30]
    Left = 168
    Top = 766
    Width = 105
    Height = 31
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
    OnClick = btnVisualizzaFileClick
    Cacheable = True
    FriendlyName = 'btnVisualizzaFile'
    ImageFile.Filename = 'img\btnVisualizzaFile.png'
    medpDownloadButton = False
    Caption = 'Visualizza file'
  end
  object btnAnomalie: TmedpIWImageButton [31]
    Left = 279
    Top = 766
    Width = 98
    Height = 31
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
    OnClick = btnAnomalieClick
    Cacheable = True
    FriendlyName = 'btnAnomalie'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object lblCodAziendaBase: TmeIWLabel [32]
    Left = 229
    Top = 419
    Width = 49
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
    FriendlyName = 'lblCodAziendaBase'
    Caption = 'Azienda'
    Enabled = True
  end
  object cmbCodAziendaBase: TMedpIWMultiColumnComboBox [33]
    Left = 284
    Top = 419
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
    FriendlyName = 'cmbCodAziendaBase'
    SubmitOnAsyncEvent = True
    TabOrder = 21
    OnAsyncChange = cmbCodAziendaBaseAsyncChange
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'width5chr'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblDAziendaBase: TmeIWLabel [34]
    Left = 411
    Top = 419
    Width = 158
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
    FriendlyName = 'lblDAziendaBase'
    Caption = 'Descrizione azienda base'
    Enabled = True
  end
  object chkEseguiScriptIniziali: TmeIWCheckBox [35]
    Left = 431
    Top = 520
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
    Caption = 'Esegui script iniziali'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 22
    Checked = False
    FriendlyName = 'chkEseguiScriptIniziali'
  end
  object chkSvuotaTabella: TmeIWCheckBox [36]
    Left = 231
    Top = 520
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
    Caption = 'Svuota tabella'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 23
    Checked = True
    FriendlyName = 'chkSvuotaTabella'
  end
  object pmnAzioni: TPopupMenu
    Left = 104
    Top = 688
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll submit'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone submit'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert submit'
      OnClick = Invertiselezione1Click
    end
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 128
    Top = 24
  end
end