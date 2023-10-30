inherited WA155FRicercaDocumentale: TWA155FRicercaDocumentale
  Tag = 77
  Width = 789
  Height = 493
  ExplicitWidth = 789
  ExplicitHeight = 493
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 149
    Top = 121
    ExplicitLeft = 149
    ExplicitTop = 121
  end
  inherited btnShowElabError: TmeIWButton
    Left = 160
    Top = 90
    ExplicitLeft = 160
    ExplicitTop = 90
  end
  object lblNomeFile: TmeIWLabel [15]
    Left = 33
    Top = 208
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
    ForControl = edtNomeFile
    HasTabOrder = False
    FriendlyName = 'lblNomeFile'
    Caption = 'Nome file'
    Enabled = True
  end
  object edtNomeFile: TmeIWEdit [16]
    Left = 98
    Top = 208
    Width = 296
    Height = 21
    Css = 'width40chr'
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
    FriendlyName = 'edtNomeFile'
    SubmitOnAsyncEvent = True
    TabOrder = 6
  end
  object lblDimensioneDa: TmeIWLabel [17]
    Left = 33
    Top = 232
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
    ForControl = edtDimensioneDa
    HasTabOrder = False
    FriendlyName = 'lblDimensioneDa'
    Caption = 'Dimensione da'
    Enabled = True
  end
  object edtDimensioneDa: TmeIWEdit [18]
    Left = 190
    Top = 232
    Width = 68
    Height = 21
    Css = 'input_integer width10chr'
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
    FriendlyName = 'edtDimensioneDa'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    Text = '0'
  end
  object lblDimensioneA: TmeIWLabel [19]
    Left = 284
    Top = 232
    Width = 7
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
    ForControl = edtDimensioneA
    HasTabOrder = False
    FriendlyName = 'lblDimensioneA'
    Caption = 'a'
    Enabled = True
  end
  object edtDimensioneA: TmeIWEdit [20]
    Left = 297
    Top = 232
    Width = 97
    Height = 21
    Css = 'input_integer width10chr'
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
    FriendlyName = 'edtDimensioneA'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    Text = '0'
  end
  object lblPeriodoDal: TmeIWLabel [21]
    Left = 33
    Top = 258
    Width = 159
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
    ForControl = edtPeriodoDal
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Periodo di riferimento dal'
    Enabled = True
  end
  object edtPeriodoDal: TmeIWEdit [22]
    Left = 190
    Top = 258
    Width = 68
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
    FriendlyName = 'edtPeriodoDal'
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object lblPeriodoAl: TmeIWLabel [23]
    Left = 280
    Top = 258
    Width = 11
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
    ForControl = edtPeriodoAl
    HasTabOrder = False
    FriendlyName = 'lblPeriodoAl'
    Caption = 'al'
    Enabled = True
  end
  object edtPeriodoAl: TmeIWEdit [24]
    Left = 297
    Top = 258
    Width = 97
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
    FriendlyName = 'edtPeriodoAl'
    SubmitOnAsyncEvent = True
    TabOrder = 11
  end
  object lblDataCreazioneDal: TmeIWLabel [25]
    Left = 33
    Top = 291
    Width = 116
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
    ForControl = edtDataCreazioneDal
    HasTabOrder = False
    FriendlyName = 'lblDataCreazioneDal'
    Caption = 'Data creazione dal'
    Enabled = True
  end
  object edtDataCreazioneDal: TmeIWEdit [26]
    Left = 190
    Top = 286
    Width = 68
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
    FriendlyName = 'edtDataCreazioneDal'
    SubmitOnAsyncEvent = True
    TabOrder = 12
  end
  object lblDataCreazioneAl: TmeIWLabel [27]
    Left = 280
    Top = 286
    Width = 11
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
    ForControl = edtDataCreazioneAl
    HasTabOrder = False
    FriendlyName = 'lblDataCreazioneAl'
    Caption = 'al'
    Enabled = True
  end
  object edtDataCreazioneAl: TmeIWEdit [28]
    Left = 297
    Top = 286
    Width = 97
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
    FriendlyName = 'edtDataCreazioneAl'
    SubmitOnAsyncEvent = True
    TabOrder = 13
  end
  object lblEstensioni: TmeIWLabel [29]
    Left = 33
    Top = 368
    Width = 67
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
    FriendlyName = 'lblEstensioni'
    Caption = 'Estensione'
    Enabled = True
  end
  object lblUtente: TmeIWLabel [30]
    Left = 161
    Top = 370
    Width = 105
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
    FriendlyName = 'lblUtente'
    Caption = 'Utente creazione'
    Enabled = True
  end
  object lblTipologia: TmeIWLabel [31]
    Left = 323
    Top = 368
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
    FriendlyName = 'lblTipologia'
    Caption = 'Tipologia'
    Enabled = True
  end
  object lblUfficio: TmeIWLabel [32]
    Left = 473
    Top = 368
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
    HasTabOrder = False
    FriendlyName = 'lblUfficio'
    Caption = 'Ufficio'
    Enabled = True
  end
  object lstUtenti: TmeTIWCheckListBox [33]
    Left = 158
    Top = 392
    Width = 159
    Height = 89
    ExtraTagParams.Strings = (
      '')
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
    FriendlyName = 'lstUtenti'
    SubmitOnAsyncEvent = True
    TabOrder = 14
    BorderColor = clBlack
    BorderWidth = 1
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    medpContextMenu = pmnSelezione
  end
  object lstTipologie: TmeTIWCheckListBox [34]
    Left = 323
    Top = 390
    Width = 144
    Height = 91
    ExtraTagParams.Strings = (
      'style=white-space:nowrap;')
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
    FriendlyName = 'lstTipologie'
    SubmitOnAsyncEvent = True
    TabOrder = 15
    BorderColor = clBlack
    BorderWidth = 1
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    medpContextMenu = pmnSelezione
  end
  object lstEstensioni: TmeTIWCheckListBox [35]
    Left = 33
    Top = 390
    Width = 119
    Height = 91
    ExtraTagParams.Strings = (
      'style=margin-left:0.5em;')
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.FontName = 'Arial'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'lstEstensioni'
    SubmitOnAsyncEvent = True
    TabOrder = 16
    BorderColor = clBlack
    BorderWidth = 1
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    medpContextMenu = pmnSelezione
  end
  object lstUffici: TmeTIWCheckListBox [36]
    Left = 473
    Top = 390
    Width = 145
    Height = 91
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
    FriendlyName = 'lstUffici'
    SubmitOnAsyncEvent = True
    TabOrder = 17
    BorderColor = clBlack
    BorderWidth = 1
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    medpContextMenu = pmnSelezione
  end
  object lblNote: TmeIWLabel [37]
    Left = 33
    Top = 343
    Width = 28
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
    Caption = 'Note'
    Enabled = True
  end
  object edtNote: TmeIWEdit [38]
    Left = 98
    Top = 343
    Width = 296
    Height = 21
    Css = 'width40chr'
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
    FriendlyName = 'edtNote'
    SubmitOnAsyncEvent = True
    TabOrder = 18
  end
  object lblKBDa: TmeIWLabel [39]
    Left = 264
    Top = 232
    Width = 15
    Height = 16
    Css = 'intestazione spazio_sx'
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
    FriendlyName = 'lblKBDa'
    Caption = 'KB'
    Enabled = True
  end
  object lblKBA: TmeIWLabel [40]
    Left = 400
    Top = 232
    Width = 15
    Height = 16
    Css = 'intestazione spazio_sx'
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
    FriendlyName = 'lblKBA'
    Caption = 'KB'
    Enabled = True
  end
  object lblFamiliare: TmeIWLabel [41]
    Left = 33
    Top = 315
    Width = 165
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
    ForControl = edtFamiliare
    HasTabOrder = False
    FriendlyName = 'lblFamiliare'
    Caption = 'CF familiare di riferimento'
    Enabled = True
  end
  object edtFamiliare: TmeIWEdit [42]
    Left = 98
    Top = 315
    Width = 296
    Height = 21
    Css = 'width18chr'
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
    FriendlyName = 'edtFamiliare'
    SubmitOnAsyncEvent = True
    TabOrder = 19
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 696
    Top = 144
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 696
    Top = 24
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 696
    Top = 88
  end
  inherited actlstNavigatorBar: TActionList
    object actPulisci: TAction [7]
      Caption = 'btnGomma'
      Hint = 'Pulisci criteri di ricerca'
      OnExecute = actPulisciExecute
    end
  end
  object pmnSelezione: TPopupMenu
    Left = 655
    Top = 434
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Selezionatutto1Click
    end
  end
end
