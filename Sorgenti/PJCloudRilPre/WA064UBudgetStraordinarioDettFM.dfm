inherited WA064FBudgetStraordinarioDettFM: TWA064FBudgetStraordinarioDettFM
  Height = 374
  ExplicitHeight = 374
  inherited IWFrameRegion: TIWRegion
    Height = 374
    ExplicitLeft = 3
    ExplicitHeight = 374
    object lblAnno: TmeIWLabel
      Left = 30
      Top = 74
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
      HasTabOrder = False
      FriendlyName = 'lblAnno'
      Caption = 'Anno'
      Enabled = True
    end
    object dedtAnno: TmeIWDBEdit
      Left = 30
      Top = 91
      Width = 60
      Height = 21
      Css = 'input_num_nnnn width4chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 0
      OnAsyncExit = dedtAnnoAsyncExit
      AutoEditable = True
      DataField = 'ANNO'
      PasswordPrompt = False
    end
    object dedtCodGruppo: TmeIWDBEdit
      Left = 270
      Top = 91
      Width = 121
      Height = 21
      Css = 'width10chr'
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
      FriendlyName = 'dedtCodGruppo'
      SubmitOnAsyncEvent = True
      TabOrder = 1
      AutoEditable = True
      DataField = 'CODGRUPPO'
      PasswordPrompt = False
    end
    object lblCodGruppo: TmeIWLabel
      Left = 270
      Top = 74
      Width = 77
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
      FriendlyName = 'lblCodGruppo'
      Caption = 'Cod. gruppo'
      Enabled = True
    end
    object lblDescrizione: TmeIWLabel
      Left = 397
      Top = 74
      Width = 71
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
      FriendlyName = 'lblDescrizione'
      Caption = 'Descrizione'
      Enabled = True
    end
    object dedtDescrizione: TmeIWDBEdit
      Left = 397
      Top = 91
      Width = 121
      Height = 21
      Css = 'width30chr'
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
      FriendlyName = 'dedtDescrizione'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      AutoEditable = True
      DataField = 'DESCRIZIONE'
      PasswordPrompt = False
    end
    object lblOre: TmeIWLabel
      Left = 30
      Top = 138
      Width = 23
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
      FriendlyName = 'lblOre'
      Caption = 'Ore'
      Enabled = True
    end
    object dedtOre: TmeIWDBEdit
      Left = 30
      Top = 155
      Width = 60
      Height = 21
      Css = 'input_hour_hhhhmm width7chr'
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
      FriendlyName = 'dedtOre'
      SubmitOnAsyncEvent = True
      TabOrder = 3
      AutoEditable = True
      DataField = 'ORE'
      PasswordPrompt = False
    end
    object lblImporto: TmeIWLabel
      Left = 109
      Top = 138
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
      FriendlyName = 'lblImporto'
      Caption = 'Importo'
      Enabled = True
    end
    object dedtImporto: TmeIWDBEdit
      Left = 109
      Top = 155
      Width = 89
      Height = 21
      Css = 'input_num_nnnnndd width7chr'
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
      FriendlyName = 'dedtImporto'
      SubmitOnAsyncEvent = True
      TabOrder = 4
      AutoEditable = True
      DataField = 'IMPORTO'
      PasswordPrompt = False
    end
    object lblFiltroAnagrafe: TmeIWLabel
      Left = 30
      Top = 203
      Width = 92
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
      FriendlyName = 'lblFiltroAnagrafe'
      Caption = 'Filtro anagrafe'
      Enabled = True
    end
    object dedtFiltroAnagrafe: TmeIWDBEdit
      Left = 30
      Top = 220
      Width = 425
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
      FriendlyName = 'dedtFiltroAnagrafe'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      AutoEditable = True
      DataField = 'FILTRO_ANAGRAFE'
      PasswordPrompt = False
    end
    object lblTipo: TmeIWLabel
      Left = 270
      Top = 134
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
      HasTabOrder = False
      FriendlyName = 'lblTipo'
      Caption = 'Tipo'
      Enabled = True
    end
    object imgFiltroAnagrafe: TmeIWImageFile
      Left = 461
      Top = 220
      Width = 22
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
      OnClick = imgSelAnagrafeClick
      Cacheable = True
      FriendlyName = 'imgFiltroAnagrafe'
      ImageFile.Filename = 'img\btnC700SelezioneAnagrafe.png'
      medpDownloadButton = False
    end
    object cmbDalMese: TmeIWComboBox
      Left = 109
      Top = 91
      Width = 49
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
      OnAsyncExit = cmbDalMeseAsyncExit
      NonEditableAsLabel = True
      TabOrder = 6
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
      FriendlyName = 'cmbDalMese'
      NoSelectionText = '-- No Selection --'
    end
    object cmbAlMese: TmeIWComboBox
      Left = 181
      Top = 91
      Width = 49
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
      OnAsyncExit = cmbAlMeseAsyncExit
      NonEditableAsLabel = True
      TabOrder = 7
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
      FriendlyName = 'cmbAlMese'
      NoSelectionText = '-- No Selection --'
    end
    object lblDalMese: TmeIWLabel
      Left = 109
      Top = 74
      Width = 57
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
      FriendlyName = 'lblDalMese'
      Caption = 'dal mese'
      Enabled = True
    end
    object lblAlMese: TmeIWLabel
      Left = 181
      Top = 74
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
      FriendlyName = 'lblAlMese'
      Caption = 'al mese'
      Enabled = True
    end
    object btnDipendenti: TmedpIWImageButton
      Left = 515
      Top = 214
      Width = 137
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
      OnClick = btnDipendentiClick
      Cacheable = True
      FriendlyName = 'btnDipendenti'
      ImageFile.Filename = 'img\btnDipendenti.png'
      medpDownloadButton = False
      Caption = 'Visualizza dipendenti'
    end
    object lblOperatori: TmeIWLabel
      Left = 30
      Top = 274
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
      FriendlyName = 'lblOperatori'
      Caption = 'Responsabili del gruppo'
      Enabled = True
    end
    object btnOperatori: TmedpIWImageButton
      Left = 515
      Top = 294
      Width = 137
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
      OnClick = btnOperatoriClick
      Cacheable = True
      FriendlyName = 'btnOperatori'
      medpDownloadButton = False
      Caption = 'Seleziona responsabili'
    end
    object edtOperatori: TmeIWEdit
      Left = 30
      Top = 296
      Width = 425
      Height = 21
      Css = 'width70chr medpCalcolati'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtOperatori'
      ReadOnly = True
      SubmitOnAsyncEvent = True
      TabOrder = 8
      Text = 'edtOperatori'
    end
    object dcmbTipo: TMedpIWMultiColumnComboBox
      Left = 270
      Top = 156
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
      FriendlyName = 'dcmbTipo'
      SubmitOnAsyncEvent = True
      TabOrder = 9
      OnAsyncChange = dcmbTipoAsyncChange
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width10chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescTipo: TmeIWLabel
      Left = 416
      Top = 161
      Width = 71
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
      Caption = 'lblDescTipo'
      Enabled = True
    end
    object edtAutorizzatori: TmeIWEdit
      Left = 30
      Top = 345
      Width = 425
      Height = 21
      Css = 'width70chr medpCalcolati'
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Editable = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'edtAutorizzatori'
      SubmitOnAsyncEvent = True
      TabOrder = 10
      Text = 'edtAutorizzatori'
    end
    object lblAutorizzatori: TmeIWLabel
      Left = 30
      Top = 323
      Width = 242
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
      FriendlyName = 'lblAutorizzatori'
      Caption = 'Autorizzatori delle modifiche al gruppo'
      Enabled = True
    end
    object btnAutorizzatori: TmedpIWImageButton
      Left = 515
      Top = 350
      Width = 137
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
      OnClick = btnOperatoriClick
      Cacheable = True
      FriendlyName = 'btnAutorizzatori'
      medpDownloadButton = False
      Caption = 'Seleziona autorizzatori'
    end
  end
end
