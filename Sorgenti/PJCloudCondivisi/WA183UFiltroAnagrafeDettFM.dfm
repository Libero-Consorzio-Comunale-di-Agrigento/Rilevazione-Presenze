inherited WA183FFiltroAnagrafeDettFM: TWA183FFiltroAnagrafeDettFM
  Width = 914
  Height = 522
  ExplicitWidth = 914
  ExplicitHeight = 522
  inherited IWFrameRegion: TIWRegion
    Width = 914
    Height = 522
    ExplicitWidth = 914
    ExplicitHeight = 522
    object lblPermesso: TmeIWLabel
      Left = 143
      Top = 64
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
      FriendlyName = 'lblPermesso'
      Caption = 'Profilo'
      Enabled = True
    end
    object dedtPermesso: TmeIWDBEdit
      Left = 143
      Top = 86
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
      Top = 64
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
      Left = 16
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
    object memFiltroAnagrafe: TmeIWMemo
      Left = 16
      Top = 152
      Width = 489
      Height = 281
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
      TabOrder = 2
      SubmitOnAsyncEvent = True
      FriendlyName = 'memFiltroAnagrafe'
    end
    object imgVerifica: TmeIWImageFile
      Left = 44
      Top = 125
      Width = 22
      Height = 21
      Hint = 'Verifica espressione sul database corrente'
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
      OnClick = btnAnteprimaClick
      Cacheable = True
      FriendlyName = 'IWImageFile1'
      ImageFile.Filename = 'img\btnCheck.png'
      medpDownloadButton = False
    end
    object grdFAnag: TmedpIWDBGrid
      Left = 536
      Top = 152
      Width = 300
      Height = 150
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
      Caption = 'grdFAnag'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdFAnagRenderCell
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdFAnag'
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
      medpContextMenu = pmnGrd
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
    end
    object btnAnteprima: TmeIWButton
      Left = 80
      Top = 121
      Width = 103
      Height = 25
      Css = 'pulsante width15chr'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Anteprima'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAnteprima'
      TabOrder = 3
      OnClick = btnAnteprimaClick
      medpDownloadButton = False
    end
    object imgC700SelezioneAnagrafe: TmeIWImageFile
      Left = 16
      Top = 125
      Width = 22
      Height = 21
      Hint = 'Selezione anagrafe'
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
      OnClick = imgC700SelezioneAnagrafeClick
      Cacheable = True
      FriendlyName = 'imgC700SelezioneAnagrafe'
      ImageFile.Filename = 'img\btnC700SelezioneAnagrafe.png'
      medpDownloadButton = False
    end
    object edtNomeUtente: TmeIWEdit
      Left = 189
      Top = 125
      Width = 140
      Height = 21
      Css = 'width20chr'
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
      FriendlyName = 'edtNomeUtente'
      SubmitOnAsyncEvent = True
      TabOrder = 4
      medpWatermark = ':nome_utente'
    end
    object edtUtenteAutenticato: TmeIWEdit
      Left = 335
      Top = 125
      Width = 140
      Height = 21
      Css = 'width20chr'
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
      FriendlyName = 'meIWEdit1'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      medpWatermark = ':utente_autenticato'
    end
    object chkSelezioneRichiestaPortale: TmeIWCheckBox
      Left = 270
      Top = 86
      Width = 362
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
      Caption = 'Selezione anagrafica necessaria per accedere al portale'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 6
      Checked = False
      FriendlyName = 'chkSelezioneRichiestaPortale'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA183FFiltroAnagrafeDettFM.html'
  end
  object pmnGrd: TPopupMenu
    Left = 578
    Top = 174
    object actScaricaInExcelDett: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelDettClick
    end
    object actScaricaInCSVDett: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVDettClick
    end
  end
end
