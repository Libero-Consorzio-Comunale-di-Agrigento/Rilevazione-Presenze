inherited W049FCaricamentoAspettativaFM: TW049FCaricamentoAspettativaFM
  Width = 450
  Height = 400
  ExplicitWidth = 450
  ExplicitHeight = 400
  inherited IWFrameRegion: TIWRegion
    Width = 450
    Height = 400
    Color = clWebALICEBLUE
    ExplicitWidth = 450
    ExplicitHeight = 400
    object lblDataI: TmeIWLabel
      Left = 15
      Top = 69
      Width = 70
      Height = 16
      Css = 'intestazione spazio_sx0'
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
      FriendlyName = 'lblDataI'
      Caption = 'Periodo dal'
      Enabled = True
    end
    object dedtDataI: TmeIWDBEdit
      Left = 15
      Top = 91
      Width = 121
      Height = 21
      Css = 'spazio_sx0 input_data_dmy'
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
      FriendlyName = 'dedtDal'
      SubmitOnAsyncEvent = True
      TabOrder = 0
      AutoEditable = True
      DataField = 'DAL'
      PasswordPrompt = False
      DataSource = DataSourceCar
    end
    object lblDataF: TmeIWLabel
      Left = 175
      Top = 69
      Width = 11
      Height = 16
      Css = 'intestazione spazio_sx0'
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
      FriendlyName = 'lblAl'
      Caption = 'al'
      Enabled = True
    end
    object dedtDataF: TmeIWDBEdit
      Left = 175
      Top = 91
      Width = 121
      Height = 21
      Css = 'spazio_sx0 input_data_dmy'
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
      FriendlyName = 'dedtDataF'
      SubmitOnAsyncEvent = True
      TabOrder = 1
      AutoEditable = True
      DataField = 'AL'
      PasswordPrompt = False
      DataSource = DataSourceCar
    end
    object lblCausale: TmeIWLabel
      Left = 175
      Top = 146
      Width = 49
      Height = 16
      Css = 'intestazione spazio_sx0'
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
      FriendlyName = 'lblCausale'
      Caption = 'Causale'
      Enabled = True
    end
    object dcmbCausale: TmeIWDBComboBox
      Left = 175
      Top = 168
      Width = 121
      Height = 21
      Css = 'spazio_sx0 width35chr'
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
      TabOrder = 2
      AutoEditable = True
      DataField = 'CAUSALE'
      DataSource = DataSourceCar
      FriendlyName = 'dcmbCausale'
      ItemIndex = -1
      NoSelectionText = ''
    end
    object btnConferma: TmedpIWImageButton
      Left = 184
      Top = 293
      Width = 122
      Height = 27
      Css = 'align_center'
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
      OnClick = btnConfermaClick
      Cacheable = True
      FriendlyName = 'btnConferma'
      ImageFile.URL = 'img/btnConferma.png'
      medpDownloadButton = False
      Caption = 'Conferma'
    end
    object btnAnnulla: TmedpIWImageButton
      Left = 312
      Top = 293
      Width = 122
      Height = 27
      Css = 'align_center'
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
      OnClick = btnAnnullaClick
      Cacheable = True
      FriendlyName = 'btnAnnulla'
      ImageFile.URL = 'img/btnAnnulla.png'
      medpDownloadButton = False
      Caption = 'Annulla'
    end
    object btnModifica: TmedpIWImageButton
      Left = 184
      Top = 333
      Width = 122
      Height = 27
      Visible = False
      Css = 'align_center'
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
      OnClick = btnModificaClick
      Cacheable = True
      FriendlyName = 'btnModifica'
      ImageFile.URL = 'img/btnModifica.png'
      medpDownloadButton = False
      Caption = 'Modifica'
    end
    object btnChiudi: TmedpIWImageButton
      Left = 312
      Top = 333
      Width = 122
      Height = 27
      Visible = False
      Css = 'align_center'
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
      OnClick = btnChiudiClick
      Cacheable = True
      FriendlyName = 'btnChiudi'
      ImageFile.URL = 'img/btnChiudiScheda.png'
      medpDownloadButton = False
      Caption = 'Chiudi'
    end
    object lblNote: TmeIWLabel
      Left = 19
      Top = 185
      Width = 28
      Height = 16
      Css = 'intestazione spazio_sx0'
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
      FriendlyName = 'lblNote'
      Caption = 'Note'
      Enabled = True
    end
    object dmemNote: TmeIWDBMemo
      Left = 15
      Top = 207
      Width = 281
      Height = 80
      Css = 'width50chr height5'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clNone
      Editable = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 3
      SubmitOnAsyncEvent = True
      AutoEditable = True
      DataField = 'NOTE'
      DataSource = DataSourceCar
      FriendlyName = 'dmemNote'
    end
  end
  object DataSourceCar: TDataSource
    Left = 312
    Top = 16
  end
end
