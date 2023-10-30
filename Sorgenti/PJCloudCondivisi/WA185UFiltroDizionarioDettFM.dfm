inherited WA185FFiltroDizionarioDettFM: TWA185FFiltroDizionarioDettFM
  Width = 568
  Height = 395
  ExplicitWidth = 568
  ExplicitHeight = 395
  inherited IWFrameRegion: TIWRegion
    Width = 568
    Height = 395
    ExplicitWidth = 568
    ExplicitHeight = 395
    object lblPermesso: TmeIWLabel
      Left = 16
      Top = 64
      Width = 80
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
      FriendlyName = 'lblPermesso'
      Caption = 'Nome Profilo'
      Enabled = True
    end
    object dedtPermesso: TmeIWDBEdit
      Left = 102
      Top = 59
      Width = 121
      Height = 21
      Css = 'width20chr'
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
      FriendlyName = 'dedtPermesso'
      SubmitOnAsyncEvent = True
      TabOrder = 0
      AutoEditable = True
      DataField = 'PROFILO'
      PasswordPrompt = False
    end
    object lblAzienda: TmeIWLabel
      Left = 16
      Top = 86
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
      FriendlyName = 'lblPermesso'
      Caption = 'Azienda'
      Enabled = True
    end
    object dcmbAzienda: TmeIWDBLookupComboBox
      Left = 102
      Top = 86
      Width = 121
      Height = 21
      Css = 'input20'
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
      TabOrder = 1
      AutoEditable = True
      DataField = 'AZIENDA'
      FriendlyName = 'dcmbAzienda'
      KeyField = 'AZIENDA'
      ListField = 'AZIENDA'
      DisableWhenEmpty = True
      NoSelectionText = ' '
    end
    object lblTabella: TmeIWLabel
      Left = 16
      Top = 118
      Width = 46
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
      FriendlyName = 'lblPermesso'
      Caption = 'Tabella'
      Enabled = True
    end
    object cmbDizionario: TmeIWComboBox
      Left = 102
      Top = 113
      Width = 121
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
      OnChange = cmbDizionarioChange
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 2
      ItemIndex = -1
      Items.Strings = (
        'CAUSALI ASSENZA'
        'RAGGRUPPAMENTI ASSENZA'
        'PROFILI ASSENZA'
        'CAUSALI PRESENZA'
        'RAGGRUPPAMENTI PRESENZA'
        'MODELLI ORARIO'
        'PROFILI ORARIO'
        'ANOMALIE DEI CONTEGGI'
        'CALENDARI'
        'TURNI REPERIBILITA'
        'PROFILI INDENNITA'
        'PROFILI PIANIF. TURNI'
        'GENERATORE DI STAMPE'
        'PARAMETRIZZAZIONI CARTELLINO'
        'INTERROGAZIONI DI SERVIZIO'
        'SELEZIONI ANAGRAFICHE'
        'TIPOLOGIA TRASFERTA'
        'RIMBORSI MISSIONI'
        'GRUPPI PESATURE INDIVIDUALI'
        'GRUPPI SC.QUANTITATIVE IND.'
        'OROLOGI DI TIMBRATURA')
      FriendlyName = 'cmbDizionario'
      NoSelectionText = ' '
    end
    object cgpDizionario: TmeTIWAdvCheckGroup
      Left = 1
      Top = 167
      Width = 566
      Height = 227
      Align = alBottom
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clNone
      BorderWidth = 0
      Caption = ''
      CaptionFont.Color = clNone
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'cgpDizionario'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      TabOrder = 3
      medpContextMenu = pmnAzioni
    end
    object imgSelezionaTutto: TmeIWImageFile
      Left = 15
      Top = 140
      Width = 22
      Height = 21
      Hint = 'Seleziona tutto'
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
      OnAsyncClick = imgSelezionaTuttoAsyncClick
      Cacheable = True
      FriendlyName = 'imgSelezionaTutto'
      ImageFile.Filename = 'img\btnCheckAll.png'
      medpDownloadButton = False
    end
    object imgDeselezionaTutto: TmeIWImageFile
      Left = 43
      Top = 140
      Width = 22
      Height = 21
      Hint = 'Deseleziona tutto'
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
      OnAsyncClick = imgDeselezionaTuttoAsyncClick
      Cacheable = True
      FriendlyName = 'IWImageFile1'
      ImageFile.Filename = 'img\btnUncheckAll.png'
      medpDownloadButton = False
    end
    object imgInvertiSelezione: TmeIWImageFile
      Left = 71
      Top = 140
      Width = 22
      Height = 21
      Hint = 'Inverti selezione'
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
      OnAsyncClick = imgInvertiSelezioneAsyncClick
      Cacheable = True
      FriendlyName = 'IWImageFile1'
      ImageFile.Filename = 'img\btnInvertSelect.png'
      medpDownloadButton = False
    end
    object rgpModalitaFiltro: TmeTIWAdvRadioGroup
      Left = 304
      Top = 118
      Width = 177
      Height = 24
      Css = 'groupbox'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebBLACK
      BorderWidth = 0
      Caption = 'Modalit'#224' filtro'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpModalitaFiltro'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Abilitato'
        'Disabilitato')
      ItemIndex = 0
      Layout = glHorizontal
      SubmitOnAsyncEvent = True
      TabOrder = 4
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA185FFiltroDizionarioDettFM.html'
  end
  object pmnAzioni: TPopupMenu
    Left = 128
    Top = 192
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
end
