inherited WA206FCondizioniTurniDettFM: TWA206FCondizioniTurniDettFM
  object meIWLabel9: TmeIWLabel [0]
    Left = 36
    Top = 84
    Width = 231
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
    FriendlyName = 'lblAbilitaModifica'
    Caption = 'Stato disponibile per la presa visione'
    Enabled = True
  end
  object MedpIWMultiColumnComboBox5: TMedpIWMultiColumnComboBox [1]
    Left = 36
    Top = 102
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
    FriendlyName = 'dcmbCodStampa'
    SubmitOnAsyncEvent = True
    TabOrder = 0
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
  object meIWLabel10: TmeIWLabel [2]
    Left = 177
    Top = 107
    Width = 96
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
    FriendlyName = 'lblDescCodStampa'
    Caption = 'DescCodRegola'
    Enabled = True
  end
  inherited IWFrameRegion: TIWRegion
    object memValore: TmeIWMemo
      Left = 431
      Top = 190
      Width = 274
      Height = 121
      Css = 'width25chr'
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
      TabOrder = 14
      SubmitOnAsyncEvent = True
      FriendlyName = 'memValore'
    end
    object cmbCodSquadra: TMedpIWMultiColumnComboBox
      Left = 28
      Top = 94
      Width = 121
      Height = 21
      Css = 'medpMultiColumnComboBoxInput'
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
      FriendlyName = 'cmbCodSquadra'
      SubmitOnAsyncEvent = True
      TabOrder = 0
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbCodDatoChange
      medpAutoResetItems = True
      CssInputText = 'width10chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescSquadra: TmeIWLabel
      Left = 155
      Top = 99
      Width = 96
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
      FriendlyName = 'lblDescSquadra'
      Caption = 'lblDescSquadra'
      Enabled = True
    end
    object lblCodTipoOpe: TmeIWLabel
      Left = 28
      Top = 124
      Width = 93
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
      FriendlyName = 'lblCodTipoOpe'
      Caption = 'Tipo operatore'
      Enabled = True
    end
    object cmbCodTipoOpe: TMedpIWMultiColumnComboBox
      Left = 28
      Top = 142
      Width = 75
      Height = 21
      Css = 'medpMultiColumnComboBoxInput'
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
      FriendlyName = 'cmbCodTipoOpe'
      SubmitOnAsyncEvent = True
      TabOrder = 1
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbCodDatoChange
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescTipoOpe: TmeIWLabel
      Left = 109
      Top = 146
      Width = 96
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
      FriendlyName = 'lblDescTipoOpe'
      Caption = 'lblDescTipoOpe'
      Enabled = True
    end
    object lblCodOrario: TmeIWLabel
      Left = 28
      Top = 172
      Width = 39
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
      FriendlyName = 'lblCodOrario'
      Caption = 'Orario'
      Enabled = True
    end
    object cmbCodOrario: TMedpIWMultiColumnComboBox
      Left = 28
      Top = 190
      Width = 75
      Height = 21
      Css = 'medpMultiColumnComboBoxInput'
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
      FriendlyName = 'cmbCodOrario'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbCodDatoChange
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescOrario: TmeIWLabel
      Left = 109
      Top = 194
      Width = 83
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
      FriendlyName = 'lblDescOrario'
      Caption = 'lblDescOrario'
      Enabled = True
    end
    object lblSiglaTurno: TmeIWLabel
      Left = 28
      Top = 220
      Width = 68
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
      FriendlyName = 'lblSiglaTurno'
      Caption = 'Sigla turno'
      Enabled = True
    end
    object cmbSiglaTurno: TMedpIWMultiColumnComboBox
      Left = 28
      Top = 238
      Width = 50
      Height = 21
      Css = 'medpMultiColumnComboBoxInput'
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
      FriendlyName = 'cmbSiglaTurno'
      SubmitOnAsyncEvent = True
      TabOrder = 3
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbCodDatoChange
      medpAutoResetItems = True
      CssInputText = 'width2chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescSiglaTurno: TmeIWLabel
      Left = 84
      Top = 242
      Width = 112
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
      FriendlyName = 'lblDescSiglaTurno'
      Caption = 'lblDescSiglaTurno'
      Enabled = True
    end
    object lblCodGiorno: TmeIWLabel
      Left = 233
      Top = 220
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
      FriendlyName = 'lblCodGiorno'
      Caption = 'Giorno'
      Enabled = True
    end
    object cmbCodGiorno: TMedpIWMultiColumnComboBox
      Left = 233
      Top = 238
      Width = 40
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
      FriendlyName = 'cmbCodGiorno'
      SubmitOnAsyncEvent = True
      TabOrder = 4
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbCodDatoChange
      medpAutoResetItems = True
      CssInputText = 'width1chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescGiorno: TmeIWLabel
      Left = 286
      Top = 243
      Width = 84
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
      FriendlyName = 'lblDescGiorno'
      Caption = 'lblDescGiorno'
      Enabled = True
    end
    object cmbCodCondizione: TMedpIWMultiColumnComboBox
      Left = 28
      Top = 286
      Width = 75
      Height = 21
      Css = 'medpMultiColumnComboBoxInput'
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
      FriendlyName = 'cmbCodCondizione'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = cmbCodDatoChange
      medpAutoResetItems = True
      CssInputText = 'width5chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescCondizione: TmeIWLabel
      Left = 109
      Top = 290
      Width = 112
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
      FriendlyName = 'lblDescCondizione'
      Caption = 'lblDescCondizione'
      Enabled = True
    end
    object lnkCodSquadra: TmeIWLink
      Left = 28
      Top = 75
      Width = 92
      Height = 17
      Css = 'link'
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
      FriendlyName = 'lnkCodSquadra'
      OnClick = lnkCodSquadraClick
      TabOrder = 6
      RawText = False
      Caption = 'Squadra'
      medpDownloadButton = False
    end
    object lnkCodCondizione: TmeIWLink
      Left = 28
      Top = 265
      Width = 92
      Height = 17
      Css = 'link'
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
      FriendlyName = 'lnkCodCondizione'
      OnClick = lnkCodCondizioneClick
      TabOrder = 7
      RawText = False
      Caption = 'Condizione'
      medpDownloadButton = False
    end
    object lblPriorita: TmeIWLabel
      Left = 431
      Top = 76
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
      HasTabOrder = False
      FriendlyName = 'lblPriorita'
      Caption = 'Priorit'#224
      Enabled = True
    end
    object dedtPriorita: TmeIWDBEdit
      Left = 431
      Top = 94
      Width = 50
      Height = 21
      Css = 'width3chr input_num_nnn'
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
      FriendlyName = 'dedtPriorita'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 8
      AutoEditable = True
      DataField = 'PRIORITA'
      PasswordPrompt = False
    end
    object lblMinimo: TmeIWLabel
      Left = 431
      Top = 124
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
      HasTabOrder = False
      FriendlyName = 'lblMinimo'
      Caption = 'Minimo'
      Enabled = True
    end
    object dedtMinimo: TmeIWDBEdit
      Left = 431
      Top = 142
      Width = 50
      Height = 21
      Css = 'width3chr input_num_nnn'
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
      FriendlyName = 'dedtMinimo'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 9
      AutoEditable = True
      DataField = 'MINIMO'
      PasswordPrompt = False
    end
    object lblOttimale: TmeIWLabel
      Left = 511
      Top = 124
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
      HasTabOrder = False
      FriendlyName = 'lblOttimale'
      Caption = 'Ottimale'
      Enabled = True
    end
    object dedtOttimale: TmeIWDBEdit
      Left = 511
      Top = 142
      Width = 50
      Height = 21
      Css = 'width3chr input_num_nnn'
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
      FriendlyName = 'dedtOttimale'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 10
      AutoEditable = True
      DataField = 'OTTIMALE'
      PasswordPrompt = False
    end
    object lblMassimo: TmeIWLabel
      Left = 591
      Top = 124
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
      FriendlyName = 'lblMassimo'
      Caption = 'Massimo'
      Enabled = True
    end
    object dedtMassimo: TmeIWDBEdit
      Left = 591
      Top = 142
      Width = 50
      Height = 21
      Css = 'width3chr input_num_nnn'
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
      FriendlyName = 'dedtMassimo'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 11
      AutoEditable = True
      DataField = 'MASSIMO'
      PasswordPrompt = False
    end
    object lblLivelloAnomalia: TmeIWLabel
      Left = 591
      Top = 76
      Width = 100
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
      FriendlyName = 'lblLivelloAnomalia'
      Caption = 'Livello anomalia'
      Enabled = True
    end
    object dedtLivelloAnomalia: TmeIWDBEdit
      Left = 591
      Top = 94
      Width = 50
      Height = 21
      Css = 'width3chr input_num_nnn'
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
      FriendlyName = 'dedtLivelloAnomalia'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 12
      AutoEditable = True
      DataField = 'LIVELLO_ANOMALIA'
      PasswordPrompt = False
    end
    object lblValore: TmeIWLabel
      Left = 431
      Top = 172
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
      FriendlyName = 'lblValore'
      Caption = 'Valore'
      Enabled = True
    end
    object dedtValore: TmeIWDBEdit
      Left = 431
      Top = 190
      Width = 274
      Height = 21
      Css = 'width22chr'
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
      FriendlyName = 'dedtValore'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 13
      AutoEditable = True
      DataField = 'VALORE'
      PasswordPrompt = False
    end
    object btnValore: TmeIWButton
      Left = 711
      Top = 186
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
      FriendlyName = 'btnValore'
      TabOrder = 15
      OnClick = btnValoreClick
      medpDownloadButton = False
    end
  end
end
