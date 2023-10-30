inherited W008FGiustificativi: TW008FGiustificativi
  Tag = 401
  Width = 703
  Height = 467
  HelpType = htKeyword
  HelpKeyword = 'W008P0'
  Title = '(W008) Giustificativi assenza/presenza'
  ExplicitWidth = 703
  ExplicitHeight = 467
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 1
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 3
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 6
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 8
  end
  object btnVisualizza: TmeIWButton [8]
    Left = 367
    Top = 233
    Width = 111
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
    Caption = 'Visualizza fruizioni'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisualizza'
    TabOrder = 2
    OnClick = btnVisualizzaClick
    medpDownloadButton = False
  end
  object lblDaData: TmeIWLabel [9]
    Left = 422
    Top = 171
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
    ForControl = edtDaData
    HasTabOrder = False
    FriendlyName = 'lblDaData'
    Caption = 'dal '
    Enabled = True
  end
  object edtDaData: TmeIWEdit [10]
    Left = 451
    Top = 166
    Width = 73
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDaData'
    SubmitOnAsyncEvent = True
    TabOrder = 14
    OnAsyncChange = edtDataAsyncChange
  end
  object lblAData: TmeIWLabel [11]
    Left = 526
    Top = 171
    Width = 15
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
    ForControl = edtAData
    HasTabOrder = False
    FriendlyName = 'lblAData'
    Caption = 'al '
    Enabled = True
  end
  object edtAData: TmeIWEdit [12]
    Left = 542
    Top = 167
    Width = 73
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtAData'
    SubmitOnAsyncEvent = True
    TabOrder = 15
    OnAsyncChange = edtDataAsyncChange
  end
  object cmbCausale: TmeIWComboBox [13]
    Left = 264
    Top = 104
    Width = 196
    Height = 21
    Css = 'select_perc50'
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
          '// abilita tipologie di fruizione (per causali di assenza)'
          '//if (FindElem("RGPCAUSALI_INPUT_1").checked) {'
          '  var Caus = this.options[this.selectedIndex].text.substr(0,5);'
          '  CausaleCambiata(Caus);'
          '//}'
          ''
          ''
          '')
        Event = 'onChange'
      end
      item
        EventCode.Strings = (
          '// abilita tipologie di fruizione (per causali di assenza)'
          '//if (FindElem("RGPCAUSALI_INPUT_1").checked) {'
          '  var Caus = this.options[this.selectedIndex].text.substr(0,5);'
          '  CausaleCambiata(Caus);'
          '//}')
        Event = 'onKeyPress'
      end>
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 10
    ItemIndex = 0
    FriendlyName = 'cmbCausale'
    NoSelectionText = '-- No Selection --'
  end
  object btnInserisci: TmeIWButton [14]
    Left = 292
    Top = 202
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
    Caption = 'Inserisci'
    Confirmation = 'Inserire i giustificativi nel periodo specificato?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnInserisci'
    TabOrder = 16
    OnClick = btnInserisciClick
    medpDownloadButton = False
  end
  object btnCancella: TmeIWButton [15]
    Left = 373
    Top = 202
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
    Caption = 'Cancella'
    Confirmation = 'Eliminare i giustificativi nel periodo specificato?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnCancella'
    TabOrder = 17
    OnClick = btnCancellaClick
    medpDownloadButton = False
  end
  object chkFiltro: TmeIWCheckBox [16]
    Left = 489
    Top = 237
    Width = 181
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
    Caption = 'Solo causale selezionata'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 7
    OnClick = chkFiltroClick
    Checked = False
    FriendlyName = 'chkFiltro'
  end
  object rgpTipoGiust: TmeIWRadioGroup [17]
    Left = 15
    Top = 172
    Width = 254
    Height = 25
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
    FriendlyName = 'rgpTipoGiust'
    ItemIndex = 0
    Items.Strings = (
      'Giorn.'
      'Mezza giorn.'
      'Num.ore'
      'Da ore - A ore')
    Layout = glHorizontal
    ScriptEvents = <
      item
        EventCode.Strings = (
          
            '// visualizza / nasconde campi relativi al periodo da ore-a ore ' +
            'in base al tipo di fruizione'
          'try {'
          '  var btnRecAlt = FindElem("BTNRECAPITOALTERNATIVO");'
          ''
          '  if (FindElem("RGPCAUSALI_INPUT_1").checked) {'
          '    // causali di assenza'
          '    if (FindElem("RGPTIPOGIUST_INPUT_1").checked) {'
          '      // giornata intera'
          '      EDTDAOREIWCL.style.visibility = "hidden";'
          '      EDTDAOREIWCL.value = "";'
          '      EDTAOREIWCL.style.visibility = "hidden";'
          '      EDTAOREIWCL.value = "";'
          '      LBLNOTEIWCL.style.visibility = "hidden";'
          '      EDTNOTEIWCL.style.visibility = "hidden";'
          '      EDTNOTEIWCL.value = "";'
          '      if (btnRecAlt != null) {'
          
            '        btnRecAlt.style.visibility = (GestVisFisc == "1") ? "vis' +
            'ible" : "hidden"; '
          '      } '
          '    }'
          
            '    else if ((FindElem("RGPTIPOGIUST_INPUT_2").checked) || (Find' +
            'Elem("RGPTIPOGIUST_INPUT_3").checked)) {'
          '      // 1/2 giornata / numero ore           '
          '      EDTDAOREIWCL.style.visibility = "visible";'
          '      EDTAOREIWCL.style.visibility = "hidden";'
          '      EDTAOREIWCL.value = "";'
          
            '      if ((FindElem("RGPTIPOGIUST_INPUT_2").checked) && (NoteGiu' +
            'stificativi == true)) {'
          '        LBLNOTEIWCL.style.visibility = "visible";'
          '        EDTNOTEIWCL.style.visibility = "visible";'
          '      }'
          '      else {'
          '        LBLNOTEIWCL.style.visibility = "hidden";'
          '        EDTNOTEIWCL.style.visibility = "hidden";'
          '        EDTNOTEIWCL.value = "";   '
          '      }'
          '      if (btnRecAlt != null) {'
          '        btnRecAlt.style.visibility = "hidden"; '
          '      } '
          '    }       '
          '    else {'
          '      // da ore - a ore'
          '      EDTDAOREIWCL.style.visibility = "visible"; '
          '      EDTAOREIWCL.style.visibility = "visible";'
          '      LBLNOTEIWCL.style.visibility = "hidden";'
          '      EDTNOTEIWCL.style.visibility = "hidden";'
          '      EDTNOTEIWCL.value = "";'
          '      if (btnRecAlt != null) {'
          '        btnRecAlt.style.visibility = "hidden"; '
          '      } '
          '    }'
          '  }'
          '  else {'
          '    // causali di presenza'
          '    if (FindElem("RGPTIPOGIUST_INPUT_1").checked) {  '
          '      // numero ore                               '
          '      EDTDAOREIWCL.style.visibility = "visible";'
          '      EDTAOREIWCL.style.visibility = "hidden";'
          '      EDTAOREIWCL.value = "";'
          '    }'
          '    else {'
          '      // da ore - a ore'
          '      EDTDAOREIWCL.style.visibility = "visible";'
          '      EDTAOREIWCL.style.visibility = "visible";'
          '    }'
          '    LBLNOTEIWCL.style.visibility = "hidden";'
          '    EDTNOTEIWCL.style.visibility = "hidden";'
          '    EDTNOTEIWCL.value = "";'
          '    if (btnRecAlt != null) {'
          '      btnRecAlt.style.visibility = "hidden"; '
          '    } '
          '  }'
          '}'
          'catch (err) {'
          '  alert(err.message);'
          '}'
          'return true;')
        Event = 'onClick'
      end>
    TabOrder = 11
  end
  object edtDaOre: TmeIWEdit [18]
    Left = 295
    Top = 171
    Width = 45
    Height = 21
    Css = 'input_hour_hhmm width3chr'
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
    FriendlyName = 'edtDaOre'
    SubmitOnAsyncEvent = True
    TabOrder = 12
  end
  object btnVisualizzaRiepilogo: TmeIWButton [19]
    Left = 202
    Top = 305
    Width = 114
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
    Caption = 'Visualizza riepilogo'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnVisualizzaRiepilogo'
    TabOrder = 18
    OnClick = btnVisualizzaRiepilogoClick
    medpDownloadButton = False
  end
  object grdRiepilogo: TmeIWGrid [20]
    Left = 218
    Top = 336
    Width = 330
    Height = 37
    Css = 'grid'
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
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdRiepilogoRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdRiepilogo'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblCausale: TmeIWLabel [21]
    Left = 20
    Top = 337
    Width = 63
    Height = 16
    Css = 'font_rosso'
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
    Caption = 'lblCausale'
    Enabled = True
  end
  object grdAnomalie: TmeIWGrid [22]
    Left = 15
    Top = 272
    Width = 234
    Height = 26
    Css = 'comandi'
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
    CellSpacing = 2
    Font.Color = clWebGREEN
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdAnomalie'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object lblFamiliari: TmeIWLabel [23]
    Left = 95
    Top = 139
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
    ForControl = cmbFamiliari
    HasTabOrder = False
    FriendlyName = 'lblFamiliari'
    Caption = 'Familiare di riferimento: '
    Enabled = True
  end
  object cmbFamiliari: TmeIWComboBox [24]
    Left = 258
    Top = 139
    Width = 220
    Height = 21
    Css = 'select_perc50'
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
    NonEditableAsLabel = True
    TabOrder = 0
    ItemIndex = 0
    FriendlyName = 'cmbFamiliari'
    NoSelectionText = ' '
  end
  object lblCausali: TmeIWLabel [25]
    Left = 13
    Top = 104
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
    NoWrap = True
    ForControl = rgpCausali
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Causali di'
    Enabled = True
  end
  object edtAOre: TmeIWEdit [26]
    Left = 358
    Top = 172
    Width = 45
    Height = 21
    Css = 'input_hour_hhmm width3chr'
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
    FriendlyName = 'edtOre'
    SubmitOnAsyncEvent = True
    TabOrder = 13
  end
  object edtRiepAl: TmeIWEdit [27]
    Left = 103
    Top = 313
    Width = 73
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtRiepAl'
    SubmitOnAsyncEvent = True
    TabOrder = 19
  end
  object lblRiepAl: TmeIWLabel [28]
    Left = 20
    Top = 315
    Width = 72
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
    ForControl = edtRiepAl
    HasTabOrder = False
    FriendlyName = 'lblRiepAl'
    Caption = 'Riepilogo al'
    Enabled = True
  end
  object grdGiustificativi: TmeIWDBGrid [29]
    Left = 218
    Top = 379
    Width = 330
    Height = 75
    Css = 'grid'
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
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdGiustificativiRenderCell
    Summary = 'Elenco dei giustificativi'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdGiustificativi'
    FromStart = True
    HighlightColor = clNone
    HighlightRows = False
    Options = [dgShowTitles]
    RefreshMode = rmAutomatic
    RowLimit = 0
    RollOver = False
    RowClick = False
    RollOverColor = clNone
    RowHeaderColor = clNone
    RowAlternateColor = clNone
    RowCurrentColor = clNone
    TabOrder = -1
    medpFixedColumns = 0
  end
  object rgpCausali: TmeIWRadioGroup [30]
    Left = 98
    Top = 107
    Width = 160
    Height = 17
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
    OnClick = rgpCausaliClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpTipo'
    ItemIndex = 0
    Items.Strings = (
      'Assenza'
      'Presenza')
    Layout = glHorizontal
    TabOrder = 9
  end
  object chkStampaRicevuta: TmeIWCheckBox [31]
    Left = 454
    Top = 206
    Width = 121
    Height = 21
    Hint = 'Stampa ricevuta per periodo in inserimento'
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Stampa ricevuta'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 20
    OnClick = chkStampaRicevutaClick
    Checked = False
    FriendlyName = 'chkStampaRicevuta'
  end
  object btnNascondiRiepilogo: TmeIWButton [32]
    Left = 322
    Top = 305
    Width = 121
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
    Caption = 'Nascondi riepilogo'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnNascondiRiepilogo'
    TabOrder = 21
    OnAsyncClick = btnNascondiRiepilogoAsyncClick
    medpDownloadButton = False
  end
  object edtNote: TmeIWEdit [33]
    Left = 57
    Top = 203
    Width = 73
    Height = 21
    Css = 'input15'
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
    FriendlyName = 'edtNote'
    MaxLength = 10
    SubmitOnAsyncEvent = True
    TabOrder = 22
  end
  object lblNote: TmeIWLabel [34]
    Left = 16
    Top = 207
    Width = 38
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
    ForControl = edtNote
    HasTabOrder = False
    FriendlyName = 'lblNote'
    Caption = 'Note: '
    Enabled = True
  end
  object btnStampaRicevuta: TmeIWButton [35]
    Left = 578
    Top = 202
    Width = 103
    Height = 25
    Hint = 'Stampa ricevuta per periodo gi'#224' inserito'
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Stampa ricevuta'
    Confirmation = 'Stampare i giustificativi nel periodo specificato?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampaRicevuta'
    TabOrder = 23
    OnClick = btnStampaRicevutaClick
    medpDownloadButton = False
  end
  object btnRecapitoAlternativo: TmeIWButton [36]
    Left = 160
    Top = 203
    Width = 126
    Height = 25
    Hint = 
      'Permette di specificare un domicilio alternativo per le visite f' +
      'iscali'
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Recapito visite fiscali'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnRecapitoAlternativo'
    TabOrder = 24
    OnClick = btnRecapitoAlternativoClick
    medpDownloadButton = False
  end
  object chkAutorizzazioneCompleta: TmeIWCheckBox [37]
    Left = 16
    Top = 230
    Width = 168
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
    Caption = 'Autorizzazione completa'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 25
    OnAsyncChange = chkAutorizzazioneCompletaAsyncChange
    Checked = False
    FriendlyName = 'chkNoteIns'
  end
  object cdsAutorizzazione: TClientDataSet
    PersistDataPacket.Data = {
      D60200009619E0BD010000001800000019000000000003000000D6020B50524F
      475245535349564F04000100000000000A4E4F4D494E415449564F0100490000
      000100055749445448020002003C00094D41545249434F4C4101004900000001
      0005574944544802000200080005534553534F01004900000001000557494454
      480200020001000743415553414C450100490000000100055749445448020002
      00050009445F43415553414C4501004900000001000557494454480200020028
      00095449504F4749555354010049000000010005574944544802000200010003
      44414C040006000000000002414C0400060000000000094E554D45524F4F5245
      010049000000010005574944544802000200050004414F524501004900000001
      000557494454480200020005000C524553504F4E534142494C45010049000000
      01000557494454480200020014000E445F524553504F4E534142494C45010049
      0000000100055749445448020002003C000644414C5F4D470100490000000100
      05574944544802000200010005414C5F4D470100490000000100055749445448
      0200020001000947475F494E5445524501004900000001000557494454480200
      020001000844414C5F4E4F54450100490000000100055749445448020002000A
      0007414C5F4E4F54450100490000000100055749445448020002000A0009435F
      4F47474554544F01004900000001000557494454480200020064000C435F5445
      53544F5F5249434801004900000001000557494454480200020064000E435F50
      4552494F444F5F52494348020049000000010005574944544802000200D0070B
      435F544553544F5F41555401004900000001000557494454480200020064000D
      435F504552494F444F5F415554020049000000010005574944544802000200D0
      0706435F44415441010049000000010005574944544802000200640007435F46
      49524D4101004900000001000557494454480200020064000000}
    Active = True
    Aggregates = <>
    AutoCalcFields = False
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'NOMINATIVO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'MATRICOLA'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'SESSO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CAUSALE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'D_CAUSALE'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'TIPOGIUST'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DAL'
        DataType = ftDate
      end
      item
        Name = 'AL'
        DataType = ftDate
      end
      item
        Name = 'NUMEROORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'AORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'RESPONSABILE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'D_RESPONSABILE'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'DAL_MG'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'AL_MG'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'GG_INTERE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DAL_NOTE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'AL_NOTE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'C_OGGETTO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'C_TESTO_RICH'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'C_PERIODO_RICH'
        DataType = ftString
        Size = 2000
      end
      item
        Name = 'C_TESTO_AUT'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'C_PERIODO_AUT'
        DataType = ftString
        Size = 2000
      end
      item
        Name = 'C_DATA'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'C_FIRMA'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 43
    Top = 400
    object cdsAutorizzazionePROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object cdsAutorizzazioneNOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 60
    end
    object cdsAutorizzazioneMATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object cdsAutorizzazioneSESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object cdsAutorizzazioneCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object cdsAutorizzazioneD_CAUSALE: TStringField
      FieldName = 'D_CAUSALE'
      Size = 40
    end
    object cdsAutorizzazioneTIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Size = 1
    end
    object cdsAutorizzazioneDAL: TDateField
      FieldName = 'DAL'
    end
    object cdsAutorizzazioneAL: TDateField
      FieldName = 'AL'
    end
    object cdsAutorizzazioneNUMEROORE: TStringField
      FieldName = 'NUMEROORE'
      Size = 5
    end
    object cdsAutorizzazioneAORE: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object cdsAutorizzazioneRESPONSABILE: TStringField
      FieldName = 'RESPONSABILE'
    end
    object cdsAutorizzazioneD_RESPONSABILE: TStringField
      FieldName = 'D_RESPONSABILE'
      Size = 60
    end
    object cdsAutorizzazioneC_OGGETTO: TStringField
      FieldName = 'C_OGGETTO'
      Size = 100
    end
    object cdsAutorizzazioneC_TESTO_RICH: TStringField
      FieldName = 'C_TESTO_RICH'
      Size = 100
    end
    object cdsAutorizzazioneC_PERIODO_RICH: TStringField
      FieldName = 'C_PERIODO_RICH'
      Size = 2000
    end
    object cdsAutorizzazioneC_TESTO_AUT: TStringField
      FieldName = 'C_TESTO_AUT'
      Size = 100
    end
    object cdsAutorizzazioneC_PERIODO_AUT: TStringField
      FieldName = 'C_PERIODO_AUT'
      Size = 2000
    end
    object cdsAutorizzazioneC_DATA: TStringField
      FieldName = 'C_DATA'
      Size = 100
    end
    object cdsAutorizzazioneC_FIRMA: TStringField
      FieldName = 'C_FIRMA'
      Size = 100
    end
    object cdsAutorizzazioneDAL_MG: TStringField
      FieldName = 'DAL_MG'
      Size = 1
    end
    object cdsAutorizzazioneDAL_NOTE: TStringField
      FieldName = 'DAL_NOTE'
      Size = 10
    end
    object cdsAutorizzazioneAL_MG: TStringField
      FieldName = 'AL_MG'
      Size = 1
    end
    object cdsAutorizzazioneAL_NOTE: TStringField
      FieldName = 'AL_NOTE'
      Size = 10
    end
    object cdsAutorizzazioneGG_INTERE: TStringField
      FieldName = 'GG_INTERE'
      Size = 1
    end
  end
end
