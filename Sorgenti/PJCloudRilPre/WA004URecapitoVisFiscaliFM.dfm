inherited WA004FRecapitoVisFiscaliFM: TWA004FRecapitoVisFiscaliFM
  Width = 555
  Height = 635
  ExplicitWidth = 555
  ExplicitHeight = 635
  inherited IWFrameRegion: TIWRegion
    Width = 555
    Height = 635
    ExplicitWidth = 555
    ExplicitHeight = 635
    object lblDomicilio: TmeIWLabel
      Left = 11
      Top = 72
      Width = 157
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
      FriendlyName = 'lblDomicilio'
      Caption = 'Domicilio per visite fiscali'
      Enabled = True
    end
    object lblCap: TmeIWLabel
      Left = 32
      Top = 166
      Width = 30
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
      ForControl = edtCap
      HasTabOrder = False
      FriendlyName = 'lblCap'
      Caption = 'CAP:'
      Enabled = True
    end
    object edtCap: TmeIWEdit
      Left = 110
      Top = 166
      Width = 63
      Height = 21
      Css = 'input_num_nnnnn width4chr'
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
      FriendlyName = 'edtCap'
      MaxLength = 5
      SubmitOnAsyncEvent = True
      TabOrder = 0
    end
    object lblTelefono: TmeIWLabel
      Left = 32
      Top = 245
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
      ForControl = edtTelefono
      HasTabOrder = False
      FriendlyName = 'lblTelefono'
      Caption = 'Telefono:'
      Enabled = True
    end
    object edtTelefono: TmeIWEdit
      Left = 110
      Top = 245
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
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtTelefono'
      MaxLength = 15
      SubmitOnAsyncEvent = True
      TabOrder = 1
    end
    object lblIndirizzo: TmeIWLabel
      Left = 32
      Top = 193
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
      ForControl = edtIndirizzo
      HasTabOrder = False
      FriendlyName = 'lblIndirizzo'
      Caption = 'Indirizzo:'
      Enabled = True
    end
    object edtIndirizzo: TmeIWEdit
      Left = 110
      Top = 193
      Width = 263
      Height = 21
      Css = 'width45chr'
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
      FriendlyName = 'edtIndirizzo'
      MaxLength = 80
      SubmitOnAsyncEvent = True
      TabOrder = 2
    end
    object lblNote: TmeIWLabel
      Left = 32
      Top = 272
      Width = 34
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
      ForControl = memNote
      HasTabOrder = False
      FriendlyName = 'lblNote'
      Caption = 'Note:'
      Enabled = True
    end
    object memNote: TmeIWMemo
      Left = 110
      Top = 272
      Width = 263
      Height = 81
      ExtraTagParams.Strings = (
        'maxlength="2000"')
      Css = 'WA004_memNote'
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
      TabOrder = 3
      SubmitOnAsyncEvent = True
      FriendlyName = 'memNote'
    end
    object lblGrpMedLegale: TmeIWLabel
      Left = 11
      Top = 372
      Width = 192
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
      FriendlyName = 'lblGrpMedLegale'
      Caption = 'Medicina legale di competenza'
      Enabled = True
    end
    object lblMedLegale: TmeIWLabel
      Left = 32
      Top = 398
      Width = 78
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
      ForControl = cmbMedLegale
      HasTabOrder = False
      FriendlyName = 'lblMedLegale'
      Caption = 'Med. legale:'
      Enabled = True
    end
    object lblDescrizione: TmeIWLabel
      Left = 11
      Top = 561
      Width = 822
      Height = 16
      Css = 'font_rosso width100pc'
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
      FriendlyName = 'lblDescrizione'
      Caption = 
        'Compilare questa scheda per specificare un domicilio alternativo' +
        ' da comunicare alla medicina legale ove effettuare la visita fis' +
        'cale.'
      Enabled = True
    end
    object btnOK: TmeIWButton
      Left = 188
      Top = 592
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
      Caption = 'OK'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnOK'
      TabOrder = 4
      OnClick = btnOKClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 280
      Top = 592
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAnnulla'
      TabOrder = 5
      OnClick = btnAnnullaClick
      medpDownloadButton = False
    end
    object cmbMedLegale: TMedpIWMultiColumnComboBox
      Left = 110
      Top = 395
      Width = 121
      Height = 21
      Css = 'medpMultiColumnCombo width5chr'
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
      FriendlyName = 'cmbMedLegale'
      SubmitOnAsyncEvent = True
      TabOrder = 6
      OnAsyncChange = cmbMedLegaleAsyncChange
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
    object lblDescMedLegale: TmeIWLabel
      Left = 248
      Top = 398
      Width = 173
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
      FriendlyName = 'lblDescMedLegale'
      Caption = 'Descrizione medicina legale'
      Enabled = True
    end
    object lnkComune: TmeIWLink
      Left = 32
      Top = 140
      Width = 65
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
      FriendlyName = 'lnkComune'
      TabOrder = 7
      RawText = False
      Caption = 'Comune:'
      medpDownloadButton = False
    end
    object edtComune: TmeIWEdit
      Left = 110
      Top = 139
      Width = 174
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
      FriendlyName = 'edtComune'
      SubmitOnAsyncEvent = True
      TabOrder = 8
    end
    object btnSelComune: TmeIWButton
      Left = 290
      Top = 138
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
      FriendlyName = 'btnSelComune'
      TabOrder = 9
      medpDownloadButton = False
    end
    object imgGomma: TmeIWImageFile
      Left = 332
      Top = 138
      Width = 23
      Height = 25
      Hint = 'Pulisce i dati del domicilio alternativo'
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
      OnAsyncClick = imgGommaAsyncClick
      Cacheable = True
      FriendlyName = 'imgGomma'
      ImageFile.Filename = 'img\btnClear.png'
      medpDownloadButton = False
    end
    object lblDataEsenzione: TmeIWLabel
      Left = 39
      Top = 489
      Width = 34
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
      FriendlyName = 'lblDataEsenzione'
      Caption = 'Data:'
      Enabled = True
    end
    object edtDataEsenzione: TmeIWEdit
      Left = 115
      Top = 484
      Width = 88
      Height = 21
      Css = 'input10'
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
      FriendlyName = 'edtDataEsenzione'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 10
      Enabled = False
    end
    object lblOperatoreEsenzione: TmeIWLabel
      Left = 39
      Top = 516
      Width = 69
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
      FriendlyName = 'lblOperatoreEsenzione'
      Caption = 'Operatore:'
      Enabled = True
    end
    object edtOperatoreEsenzione: TmeIWEdit
      Left = 115
      Top = 511
      Width = 121
      Height = 21
      Css = 'input20'
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
      FriendlyName = 'edtOperatoreEsenzione'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 11
      Enabled = False
    end
    object lblTipoEsenzione: TmeIWLabel
      Left = 39
      Top = 462
      Width = 33
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
      FriendlyName = 'lblTipoEsenzione'
      Caption = 'Tipo:'
      Enabled = True
    end
    object lblEsenzione: TmeIWLabel
      Left = 11
      Top = 440
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
      FriendlyName = 'lblEsenzione'
      Caption = 'Esenzione'
      Enabled = True
    end
    object cmbTipoEsenzione: TMedpIWMultiColumnComboBox
      Left = 115
      Top = 457
      Width = 88
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
      FriendlyName = 'cmbTipoEsenzione'
      MaxLength = 50
      SubmitOnAsyncEvent = True
      TabOrder = 12
      OnAsyncChange = cmbTipoEsenzioneAsyncChange
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 1
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'select_cour15'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblNominativo: TmeIWLabel
      Left = 32
      Top = 105
      Width = 74
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
      ForControl = edtIndirizzo
      HasTabOrder = False
      FriendlyName = 'lblIndirizzo'
      Caption = 'Nominativo:'
      Enabled = True
    end
    object edtNominativo: TmeIWEdit
      Left = 110
      Top = 100
      Width = 263
      Height = 21
      Css = 'width45chr'
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
      FriendlyName = 'edtIndirizzo'
      MaxLength = 80
      SubmitOnAsyncEvent = True
      TabOrder = 13
    end
    object lblDettagliIndirizzo: TmeIWLabel
      Left = 32
      Top = 219
      Width = 108
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
      ForControl = edtDettagliIndirizzo
      HasTabOrder = False
      FriendlyName = 'lblDettagliIndirizzo'
      Caption = 'Dettagli indirizzo:'
      Enabled = True
    end
    object edtDettagliIndirizzo: TmeIWEdit
      Left = 110
      Top = 219
      Width = 263
      Height = 21
      Css = 'width45chr'
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
      FriendlyName = 'edtDettagliIndirizzo'
      MaxLength = 50
      SubmitOnAsyncEvent = True
      TabOrder = 14
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA004RecapitoVisFiscaliFM.html'
  end
end
