inherited WA035FParScaricoPagheDettFM: TWA035FParScaricoPagheDettFM
  Width = 736
  Height = 730
  ExplicitWidth = 736
  ExplicitHeight = 730
  inherited IWFrameRegion: TIWRegion
    Width = 736
    Height = 730
    ExplicitWidth = 736
    ExplicitHeight = 730
    object lblCodice: TmeIWLabel
      Left = 16
      Top = 72
      Width = 41
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
      FriendlyName = 'lblCodice'
      Caption = 'Codice'
      Enabled = True
    end
    object lblDescrizione: TmeIWLabel
      Left = 160
      Top = 72
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
      FriendlyName = 'IWLabel1'
      Caption = 'Descrizione'
      Enabled = True
    end
    object dchkSalvataggioAutomatico: TmeIWDBCheckBox
      Left = 16
      Top = 200
      Width = 177
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
      Caption = 'Salvataggio automatico'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 0
      AutoEditable = True
      DataField = 'SALVATAGGIO_AUTOMATICO'
      FriendlyName = 'dchkSalvataggioAutomatico'
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object lblNomeFile: TmeIWLabel
      Left = 16
      Top = 151
      Width = 106
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Nome file/tabella'
      Enabled = True
    end
    object dedtCodice: TmeIWDBEdit
      Left = 16
      Top = 94
      Width = 128
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
      FriendlyName = 'dedtOffsetAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 1
      AutoEditable = True
      DataField = 'CODICE'
      PasswordPrompt = False
    end
    object lblMappatura: TmeIWLabel
      Left = 16
      Top = 530
      Width = 348
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Mappatura dei dati sul file di input o nella tabella oracle'
      Enabled = True
    end
    object dedtNomeFile: TmeIWDBEdit
      Left = 16
      Top = 173
      Width = 505
      Height = 21
      Css = 'width40chr'
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
      FriendlyName = 'dedtAziendeAbilitate'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      AutoEditable = True
      DataField = 'NOMEFILE'
      PasswordPrompt = False
    end
    object lblFormatoData: TmeIWLabel
      Left = 16
      Top = 445
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Formato data'
      Enabled = True
    end
    object dcmbFormatoData: TmeIWDBComboBox
      Left = 106
      Top = 445
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
      UseSize = False
      TabOrder = 3
      AutoEditable = True
      DataField = 'DATAFILE'
      FriendlyName = 'dcmbFormatoData'
      ItemIndex = 0
      Items.Strings = (
        ''
        'mmyy'
        'mmmyy'
        'mmmmyy'
        'mmyyyy'
        'mmmyyyy'
        'mmmmyyyy'
        'yymm'
        'yymmm'
        'yymmmm'
        'yyyymm'
        'yyyymmm'
        'yyyymmmm')
      NoSelectionText = ' '
    end
    object rgpTipoSupporto: TmeTIWAdvRadioGroup
      Left = 16
      Top = 121
      Width = 377
      Height = 32
      Css = 'groupbox'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = 'Tipo di supporto'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpTipoSupporto'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'File ASCII'
        'Tabella ORACLE')
      ItemIndex = 0
      Layout = glHorizontal
      Values.Strings = (
        'F'
        'T')
      SubmitOnAsyncEvent = True
      TabOrder = 4
      OnClick = rgpTipoSupportoClick
    end
    object dedtDescrizione: TmeIWDBEdit
      Left = 160
      Top = 94
      Width = 233
      Height = 21
      Css = 'width40chr'
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
      FriendlyName = 'dedtOffsetAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      AutoEditable = True
      DataField = 'DESCRIZIONE'
      PasswordPrompt = False
    end
    object dchkRicreazioneAutomatica: TmeIWDBCheckBox
      Left = 216
      Top = 200
      Width = 177
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
      Caption = 'Ricreazione automatica'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 6
      AutoEditable = True
      DataField = 'RICREAZIONE_AUTOMATICA'
      FriendlyName = 'dchkSalvataggioAutomatico'
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object lblUtentePaghe: TmeIWLabel
      Left = 16
      Top = 227
      Width = 185
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Utente della procedura Paghe'
      Enabled = True
    end
    object dedtUtentePaghe: TmeIWDBEdit
      Left = 16
      Top = 249
      Width = 177
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
      FriendlyName = 'dedtOffsetAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 7
      AutoEditable = True
      DataField = 'USERPAGHE'
      PasswordPrompt = False
    end
    object lblNomeEnte: TmeIWLabel
      Left = 213
      Top = 227
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Nome ente'
      Enabled = True
    end
    object dedtNomeEnte: TmeIWDBEdit
      Left = 216
      Top = 249
      Width = 177
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
      FriendlyName = 'dedtOffsetAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 8
      AutoEditable = True
      DataField = 'DEFAULTENTE'
      PasswordPrompt = False
    end
    object lblDatiOrari: TmeIWLabel
      Left = 16
      Top = 276
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Dati orai espressi in'
      Enabled = True
    end
    object drgpDatiOrari: TmeIWDBRadioGroup
      Left = 16
      Top = 298
      Width = 377
      Height = 31
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
      TrimValues = True
      AutoEditable = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Layout = glHorizontal
      DataField = 'FORMATOORE'
      FriendlyName = 'drgpDatiOrari'
      Values.Strings = (
        '0'
        '1'
        '2')
      Items.Strings = (
        'OreCentesimi'
        'OreMinuti'
        'Minuti')
      TabOrder = 9
    end
    object rgpPrecisione: TmeTIWAdvRadioGroup
      Left = 16
      Top = 335
      Width = 124
      Height = 82
      Css = 'groupbox'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = 'Precisione'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Editable = True
      FriendlyName = 'rgpTipoSupporto'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Centesimi'
        'Millesimi'
        'Separazione decimali')
      ItemIndex = 0
      Values.Strings = (
        '0'
        '1'
        '2')
      SubmitOnAsyncEvent = True
      TabOrder = 10
      OnClick = rgpPrecisioneClick
    end
    object lblSeparatore: TmeIWLabel
      Left = 216
      Top = 335
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Separatore dei decimali'
      Enabled = True
    end
    object drgpSeparatore: TmeIWDBRadioGroup
      Left = 216
      Top = 357
      Width = 149
      Height = 60
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
      TrimValues = True
      AutoEditable = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Layout = glVertical
      DataField = 'SEPARATOREDECIMALI'
      FriendlyName = 'drgpDatiOrari'
      Values.Strings = (
        ','
        '.')
      Items.Strings = (
        'Virgola'
        'Punto')
      TabOrder = 11
    end
    object lblData: TmeIWLabel
      Left = 16
      Top = 423
      Width = 137
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Data nel nome del file'
      Enabled = True
    end
    object lblTipoData: TmeIWLabel
      Left = 16
      Top = 472
      Width = 59
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
      FriendlyName = 'lblNomeScarico'
      Caption = 'Tipo data'
      Enabled = True
    end
    object drgpTipoData: TmeIWDBRadioGroup
      Left = 16
      Top = 493
      Width = 377
      Height = 31
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
      TrimValues = True
      AutoEditable = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Layout = glHorizontal
      DataField = 'TIPODATA_FILE'
      FriendlyName = 'drgpDatiOrari'
      Values.Strings = (
        'C'
        'S')
      Items.Strings = (
        'Data di cassa'
        'Data di scarico')
      TabOrder = 12
    end
    object grdMappatura: TmedpIWDBGrid
      Left = 16
      Top = 552
      Width = 697
      Height = 94
      Css = 'grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdMappaturaRenderCell
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdMappatura'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
      OnDataSet2Componenti = grdMappaturaDataSet2Componenti
      OnComponenti2DataSet = grdMappaturaComponenti2DataSet
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA035FParScaricoPagheDettFM.html'
  end
end
