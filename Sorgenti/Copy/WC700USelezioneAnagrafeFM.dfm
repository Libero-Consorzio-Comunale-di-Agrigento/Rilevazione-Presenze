inherited WC700FSelezioneAnagrafeFM: TWC700FSelezioneAnagrafeFM
  Width = 728
  Height = 641
  ExplicitWidth = 728
  ExplicitHeight = 641
  inherited IWFrameRegion: TIWRegion
    Width = 728
    Height = 641
    OnRender = IWFrameRegionRender
    BorderOptions.BorderWidth = cbwThin
    Color = clWebALICEBLUE
    ClipRegion = False
    ExplicitWidth = 728
    ExplicitHeight = 641
    object grdToolBar: TmeIWGrid
      Left = 16
      Top = 77
      Width = 544
      Height = 31
      Css = 'gridTrasparente'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clNone
      BorderColors.Light = clNone
      BorderColors.Dark = clNone
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfDefault
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdToolBar'
      ColumnCount = 1
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = False
      ScrollToCurrentRow = False
    end
    object lblPeriodoConsiderato: TmeIWLabel
      Left = 176
      Top = 176
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
      FriendlyName = 'lblPeriodoConsiderato'
      Caption = 'Periodo considerato'
      Enabled = True
    end
    object rdgPeriodoConsiderato: TmeIWRadioGroup
      Left = 176
      Top = 198
      Width = 193
      Height = 35
      Cursor = crDefault
      Css = 'intestazione width30chr'
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
      FriendlyName = 'rdgPeriodoConsiderato'
      ItemIndex = 0
      Items.Strings = (
        'al'
        'dal')
      Layout = glVertical
      TabOrder = 0
    end
    object lstAzienda: TmeIWListbox
      Left = 24
      Top = 176
      Width = 137
      Height = 435
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
      ScriptEvents = <
        item
          EventCode.Strings = (
            'ShowBusy(true);'
            'return true;')
          Event = 'onDblClick'
        end>
      UseSize = False
      OnAsyncDoubleClick = lstAziendaAsyncDoubleClick
      OnAsyncChange = lstAziendaAsyncChange
      OnAsyncKeyUp = lstAziendaAsyncKeyUp
      TabOrder = 1
      FriendlyName = 'lstAzienda'
      medpContextMenu = pmnRicerca
      NoSelectionText = '-- No Selection --'
    end
    object chkDipendentiCessati: TmeIWCheckBox
      Left = 176
      Top = 239
      Width = 169
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
      Caption = 'Anche dipendenti cessati'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 2
      OnAsyncClick = chkDipendentiCessatiAsyncClick
      Checked = False
      FriendlyName = 'chkDipendentiCessati'
    end
    object chkPersonaleEsterno: TmeIWCheckBox
      Left = 176
      Top = 258
      Width = 169
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
      Caption = 'Anche personale esterno'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 3
      Checked = False
      FriendlyName = 'ckDipendentiCessati'
    end
    object lblUguale: TmeIWLabel
      Left = 176
      Top = 317
      Width = 42
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
      FriendlyName = 'lblUguale'
      Caption = 'Uguale'
      Enabled = True
    end
    object lblDa: TmeIWLabel
      Left = 176
      Top = 339
      Width = 16
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
      FriendlyName = 'meIWLabel1'
      Caption = 'Da'
      Enabled = True
    end
    object lblA: TmeIWLabel
      Left = 176
      Top = 369
      Width = 8
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
      FriendlyName = 'meIWLabel1'
      Caption = 'A'
      Enabled = True
    end
    object lblOppure: TmeIWLabel
      Left = 167
      Top = 423
      Width = 44
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
      FriendlyName = 'lblOppure'
      Caption = 'oppure'
      Enabled = True
    end
    object edtUguale: TmeIWEdit
      Left = 224
      Top = 312
      Width = 121
      Height = 21
      Css = 'width20chr'
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
      FriendlyName = 'edtUguale'
      SubmitOnAsyncEvent = True
      TabOrder = 4
      OnAsyncChange = edtUgualeAsyncChange
      OnAsyncKeyUp = edtUgualeAsyncKeyUp
    end
    object edtDa: TmeIWEdit
      Left = 224
      Top = 339
      Width = 121
      Height = 21
      Css = 'width20chr'
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
      FriendlyName = 'meIWEdit1'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      OnSubmit = actEseguiSelezioneExecute
    end
    object edtA: TmeIWEdit
      Left = 224
      Top = 366
      Width = 121
      Height = 21
      Css = 'width20chr'
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
      FriendlyName = 'meIWEdit1'
      SubmitOnAsyncEvent = True
      TabOrder = 6
      OnSubmit = actEseguiSelezioneExecute
    end
    object lblOrdinamento: TmeIWLabel
      Left = 422
      Top = 184
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
      FriendlyName = 'lblOppure'
      Caption = 'Ordinamento'
      Enabled = True
    end
    object lstOrdinamento: TmeIWListbox
      Left = 422
      Top = 215
      Width = 250
      Height = 59
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
      OnAsyncDoubleClick = lstOrdinamentoAsyncDoubleClick
      TabOrder = 7
      FriendlyName = 'lstOrdinamento'
      NoSelectionText = '-- No Selection --'
    end
    object chkgrpValori: TmeTIWCheckListBox
      Left = 167
      Top = 445
      Width = 244
      Height = 121
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
      BGColor = clWebWHITE
      Font.Color = clNone
      Font.FontName = 'Arial'
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'chkgrpValori'
      SubmitOnAsyncEvent = True
      TabOrder = 8
      BorderColor = clNone
      BorderWidth = 0
      BGColorTo = clNone
      BGColorGradientDirection = gdHorizontal
      CheckAllBox = False
      CheckAllHelp = htNone
      CheckAllText = 'Check All'
      UnCheckAllText = 'UnCheck All'
      medpContextMenu = pmnSelectionCheck
    end
    object btnAggiungiOrdinamento: TmeIWButton
      Left = 422
      Top = 280
      Width = 153
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
      Caption = 'aggiungi a ordinamento'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAggiungiOrdinamento'
      TabOrder = 9
      OnAsyncClick = btnAggiungiOrdinamentoAsyncClick
      medpDownloadButton = False
    end
    object memModificaSelezione: TmeIWMemo
      Left = 24
      Top = 116
      Width = 557
      Height = 54
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clWebAQUA
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 10
      SubmitOnAsyncEvent = True
      FriendlyName = 'memModificaSelezione'
    end
    object grdAnteprima: TmedpIWDBGrid
      Left = 456
      Top = 435
      Width = 241
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
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdAnteprimaRenderCell
      Summary = 'Elenco del personale corrispondente ai filtri indicati'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'grdAnteprima'
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
      OnAfterCaricaCDS = grdAnteprimaAfterCaricaCDS
    end
    object meIWMemo1: TmeIWMemo
      Left = 230
      Top = 15
      Width = 495
      Height = 56
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
      Font.Color = clWebRED
      Font.Enabled = False
      Font.Size = 12
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 11
      SubmitOnAsyncEvent = True
      FriendlyName = 'meIWMemo1'
      Lines.Strings = (
        'ATTENZIONE lstAzienda contiene scriptEvent in dblClick'
        'Questo per visualizzare clessidra durante evento')
    end
    object edtRicercaTesto: TmeIWEdit
      Left = 24
      Top = 149
      Width = 137
      Height = 21
      Hint = 'testo da ricercare'
      Css = 'width18chr'
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
      FriendlyName = 'edtUguale'
      SubmitOnAsyncEvent = True
      TabOrder = 12
      OnAsyncKeyUp = edtRicercaTestoAsyncKeyUp
      medpWatermark = 'testo da ricercare'
    end
    object btnSu: TmeIWImageFile
      Left = 167
      Top = 148
      Width = 25
      Height = 22
      Hint = 'Cerca precedente'
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
      OnAsyncClick = btnSuAsyncClick
      Cacheable = True
      FriendlyName = 'btnSu'
      ImageFile.Filename = 'img\btnSu.png'
      medpDownloadButton = False
    end
    object btnGiu: TmeIWImageFile
      Left = 193
      Top = 148
      Width = 25
      Height = 22
      Hint = 'Cerca successivo'
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
      OnAsyncClick = btnGiuAsyncClick
      Cacheable = True
      FriendlyName = 'btnGiu'
      ImageFile.Filename = 'img\btnGiu.png'
      medpDownloadButton = False
    end
    object chkCaseInsensitive: TmeIWCheckBox
      Left = 177
      Top = 290
      Width = 216
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
      Caption = 'maiuscolo/minuscolo indifferente '
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 13
      Checked = False
      FriendlyName = 'chkCaseInsensitive'
    end
    object chkEscludiValori: TmeIWCheckBox
      Left = 284
      Top = 423
      Width = 127
      Height = 21
      Cursor = crAuto
      Css = 'intestazione margineSx'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Escludi elementi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 14
      Checked = False
      FriendlyName = 'chkEscludiValori'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WC700FSelezioneAnagraficheFM.html'
    Left = 80
  end
  inherited JQuery: TIWJQueryWidget
    Left = 8
  end
  object ActionList: TActionList
    Left = 48
    Top = 64
    object actConferma: TAction
      Tag = 11
      Category = 'Validazione'
      Caption = 'btnConferma'
      Hint = 'Esci e conferma'
      ImageIndex = 0
      OnExecute = actConfermaExecute
    end
    object actAnnulla: TAction
      Tag = 10
      Category = 'Validazione'
      Caption = 'btnAnnulla'
      Hint = 'Esci e annulla'
      OnExecute = actAnnullaExecute
    end
    object actlblSelezione: TAction
      Tag = 1000
      Category = 'Selezione'
      Caption = 'actlblSelezione'
    end
    object actcmbSelezione: TAction
      Tag = 1001
      Category = 'Selezione'
      Caption = 'actcmbSelezione'
    end
    object actApriSelezione: TAction
      Tag = 17
      Category = 'Selezione'
      Caption = 'btnApri'
      Hint = 'Apri selezione'
      OnExecute = actApriSelezioneExecute
    end
    object actSalvaSelezione: TAction
      Tag = 18
      Category = 'Selezione'
      Caption = 'btnSalva'
      Hint = 'Salva selezione'
      OnExecute = actSalvaSelezioneExecute
    end
    object actEliminaSelezione: TAction
      Tag = 9
      Category = 'Selezione'
      Caption = 'btnElimina'
      GroupIndex = 1
      Hint = 'Elimina selezione'
      OnExecute = actEliminaSelezioneExecute
    end
    object actEseguiSelezione: TAction
      Tag = 19
      Category = 'Selezione 2'
      Caption = 'btnEseguiSelezione'
      Hint = 'Esegui selezione'
      OnExecute = actEseguiSelezioneExecute
    end
    object actModificaSelezione: TAction
      Tag = 20
      Category = 'Selezione 2'
      Caption = 'btnAnnota'
      Hint = 'Modifica selezione'
      OnExecute = actModificaSelezioneExecute
    end
    object actAnnullaSelezione: TAction
      Tag = 21
      Category = 'Selezione 3'
      Caption = 'btnAnnullaSelezione'
      Hint = 'Annulla selezione'
      OnExecute = actAnnullaSelezioneExecute
    end
    object actConfermaSelezioneManuale: TAction
      Category = 'ConfermaSelezione'
      Caption = 'btnConferma'
      Hint = 'Conferma selezione manuale'
      OnExecute = actConfermaSelezioneManualeExecute
    end
    object actAnnullaSelezioneManuale: TAction
      Category = 'ConfermaSelezione'
      Caption = 'btnAnnulla'
      Hint = 'Annulla selezione manuale'
      OnExecute = actAnnullaSelezioneManualeExecute
    end
  end
  object jqAutoComplete: TIWJQueryWidget
    Enabled = True
    Left = 176
    Top = 8
  end
  object pmnSelectionCheck: TPopupMenu
    Left = 360
    Top = 456
    object mnuSelezionaTutto: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = mnuSelezionaTuttoClick
    end
    object mnuDeselezionaTutto: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = mnuDeselezionaTuttoClick
    end
    object mnuInvertiSelezione: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = mnuInvertiSelezioneClick
    end
  end
  object pmnRicerca: TPopupMenu
    Left = 104
    Top = 248
    object mnuRicercaCompleta: TMenuItem
      Caption = 'Ricerca completa'
      OnClick = mnuRicercaCompletaClick
    end
  end
  object jqAutoCompleteDaA: TIWJQueryWidget
    Enabled = False
    Left = 344
    Top = 344
  end
end
