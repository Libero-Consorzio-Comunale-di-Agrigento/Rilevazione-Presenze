inherited WA056FTurnazInd: TWA056FTurnazInd
  Tag = 22
  Width = 800
  Height = 549
  ExplicitWidth = 800
  ExplicitHeight = 549
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 130
    Top = 144
    ExplicitLeft = 130
    ExplicitTop = 144
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 106
    Top = 175
    ExplicitLeft = 106
    ExplicitTop = 175
  end
  inherited btnShowElabError: TmeIWButton
    Left = 130
    Top = 113
    ExplicitLeft = 130
    ExplicitTop = 113
  end
  inherited grdNavigatorBar: TmeIWGrid
    Left = 106
    Top = 84
    ExplicitLeft = 106
    ExplicitTop = 84
  end
  inherited grdTabControl: TmedpIWTabControl
    Left = 106
    Top = 13
    ExplicitLeft = 106
    ExplicitTop = 13
  end
  inherited grdToolBarStorico: TmeIWGrid
    Left = 106
    Top = 52
    ExplicitLeft = 106
    ExplicitTop = 52
  end
  object WA056AssegnaTurniRG: TmeIWRegion [15]
    Left = 33
    Top = 216
    Width = 744
    Height = 305
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateAssegnaTurniRG
    object chkDipendenteCorrente: TmeIWCheckBox
      Left = 15
      Top = 4
      Width = 186
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
      Caption = 'Esegui per tutti i dipendenti'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 6
      OnAsyncClick = chkDipendenteCorrenteAsyncClick
      Checked = False
      FriendlyName = 'chkDipendenteCorrente'
    end
    object cmbTurnazione: TMedpIWMultiColumnComboBox
      Left = 100
      Top = 27
      Width = 121
      Height = 21
      Css = 'medpMultiColumnCombo '
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
      FriendlyName = 'cmbTurnazione'
      SubmitOnAsyncEvent = True
      TabOrder = 8
      OnAsyncChange = cmbTurnazioneAsyncChange
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
    object lblDescrTurnazione: TmeIWLabel
      Left = 248
      Top = 32
      Width = 78
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
      FriendlyName = 'lblDescrTurnazione'
      Caption = 'meIWLabel1'
      Enabled = True
    end
    object lblDataPartenza: TmeIWLabel
      Left = 16
      Top = 72
      Width = 103
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
      FriendlyName = 'lblDataPartenza'
      Caption = 'Data di partenza'
      Enabled = True
    end
    object edtDataPartenza: TmeIWEdit
      Left = 125
      Top = 72
      Width = 93
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
      FriendlyName = 'edtDataPartenza'
      SubmitOnAsyncEvent = True
      TabOrder = 9
      OnAsyncChange = edtDataPartenzaAsyncChange
    end
    object lblPuntoPartenza: TmeIWLabel
      Left = 16
      Top = 112
      Width = 110
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
      FriendlyName = 'lblPuntoPartenza'
      Caption = 'Punto di partenza'
      Enabled = True
    end
    object EdtPuntoPartenza: TmeIWEdit
      Left = 125
      Top = 112
      Width = 92
      Height = 21
      Css = 'width4chr'
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
      FriendlyName = 'edtPuntoPartenza'
      SubmitOnAsyncEvent = True
      TabOrder = 10
      Text = '0'
    end
    object btnPuntoPartenza: TmeIWButton
      Left = 223
      Top = 112
      Width = 22
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
      FriendlyName = 'btnPuntoPartenza'
      TabOrder = 11
      OnClick = btnPuntoPartenzaClick
      medpDownloadButton = False
    end
    object lblParInserimento: TmeIWLabel
      Left = 23
      Top = 160
      Width = 139
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
      FriendlyName = 'lblParInserimento'
      Caption = 'Parametri inserimento'
      Enabled = True
    end
    object ChkPianifDaCalendario: TmeIWCheckBox
      Left = 31
      Top = 182
      Width = 190
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
      Caption = 'Pianificazione da calendario'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 12
      Checked = False
      FriendlyName = 'ChkPianifDaCalendario'
    end
    object chkGGLav: TmeIWCheckBox
      Left = 31
      Top = 206
      Width = 162
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
      Caption = 'Verifica turni sui gg lav.'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 13
      Checked = False
      FriendlyName = 'chkGGLav'
    end
    object chkRiposi: TmeIWCheckBox
      Left = 31
      Top = 233
      Width = 162
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
      Caption = 'Verifica turni sui riposi'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 14
      Checked = False
      FriendlyName = 'chkRiposi'
    end
    object chkInsAutomatico: TmeIWCheckBox
      Left = 319
      Top = 182
      Width = 234
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
      Caption = 'Inserimento con controllo Max/Min'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 15
      OnAsyncClick = chkInsAutomaticoAsyncClick
      Checked = False
      FriendlyName = 'chkInsAutomatico'
    end
    object chkPregresso: TmeIWCheckBox
      Left = 319
      Top = 246
      Width = 234
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
      Caption = 'Considera turnazione pregressa'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 16
      Checked = False
      FriendlyName = 'chkPregresso'
    end
    object lnkTurnazione: TmeIWLink
      Left = 21
      Top = 31
      Width = 73
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
      FriendlyName = 'lnkTurnazione'
      OnClick = lnkTurnazioneClick
      TabOrder = 17
      RawText = False
      Caption = 'Turnazione'
      medpDownloadButton = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 479
    Top = 132
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 592
    Top = 16
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 592
    Top = 72
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 720
    Top = 128
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 592
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 720
    Top = 16
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 720
    Top = 72
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 480
    Top = 72
  end
  inherited actlstNavigatorBar: TActionList
    Left = 488
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    object actAssegnaTurno: TAction
      Caption = 'btnElenco'
      Hint = 'Imposta turnazione alla data di partenza indicata'
      OnExecute = actAssegnaTurnoExecute
    end
  end
  inherited CheckRelazioni: TOracleQuery
    Left = 636
    Top = 66
  end
  object TemplateAssegnaTurniRG: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WA056AssegnaTurniRG.HTML'
    OnUnknownTag = TemplateProcessorUnknownTag
    OnBeforeProcess = TemplateProcessorBeforeProcess
    RenderStyles = False
    Left = 727
    Top = 220
  end
end
