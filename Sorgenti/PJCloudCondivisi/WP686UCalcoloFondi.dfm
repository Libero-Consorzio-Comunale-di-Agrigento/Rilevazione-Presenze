inherited WP686FCalcoloFondi: TWP686FCalcoloFondi
  Tag = 610
  Width = 942
  Height = 509
  ExplicitWidth = 942
  ExplicitHeight = 509
  DesignLeft = 8
  DesignTop = 8
  inherited grdStatusBar: TmedpIWStatusBar
    Top = 121
    ExplicitTop = 121
  end
  inherited btnShowElabError: TmeIWButton
    Left = 160
    Top = 90
    ExplicitLeft = 160
    ExplicitTop = 90
  end
  object lblDecorrenzaDa: TmeIWLabel [9]
    Left = 25
    Top = 160
    Width = 145
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
    FriendlyName = 'lblDecorrenzaDa'
    Caption = 'Dalla decorrenza fondo'
    Enabled = True
  end
  object lblDecorrenzaA: TmeIWLabel [10]
    Left = 274
    Top = 160
    Width = 125
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
    FriendlyName = 'lblDecorrenzaA'
    Caption = 'Alla scadenza fondo'
    Enabled = True
  end
  object edtDecorrenzaDa: TmeIWEdit [11]
    Left = 168
    Top = 160
    Width = 90
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
    FriendlyName = 'edtDecorrenzaDa'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtDecorrenzaDaAsyncChange
  end
  object edtDecorrenzaA: TmeIWEdit [12]
    Left = 399
    Top = 160
    Width = 90
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
    FriendlyName = 'edtDecorrenzaA'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtDecorrenzaAAsyncChange
  end
  object lblFondi: TmeIWLabel [13]
    Left = 25
    Top = 246
    Width = 119
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
    FriendlyName = 'lblFondi'
    Caption = 'Fondi da calcolare:'
    Enabled = True
  end
  object lblDataMonit: TmeIWLabel [14]
    Left = 25
    Top = 194
    Width = 115
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
    FriendlyName = 'lblDataMonit'
    Caption = 'Data monitoraggio'
    Enabled = True
  end
  object edtDataMonit: TmeIWEdit [15]
    Left = 168
    Top = 194
    Width = 90
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
    FriendlyName = 'edtDataMonit'
    SubmitOnAsyncEvent = True
    TabOrder = 9
  end
  object lblStatoCedolini: TmeIWLabel [16]
    Left = 507
    Top = 194
    Width = 182
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
    FriendlyName = 'lblStatoCedolini'
    Caption = 'Stato cedolini da considerare'
    Enabled = True
  end
  object rgpStatoCedolini: TmeIWRadioGroup [17]
    Left = 507
    Top = 216
    Width = 282
    Height = 27
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
    FriendlyName = 'rgpStatoCedolini'
    ItemIndex = 0
    Items.Strings = (
      'Solo chiusi'
      'Chiusi e aperti'
      'Solo aperti')
    Layout = glHorizontal
    TabOrder = 10
  end
  object lblModalitaCalcolo: TmeIWLabel [18]
    Left = 274
    Top = 194
    Width = 115
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
    FriendlyName = 'lblModalitaCalcolo'
    Caption = 'Modalit'#224' di calcolo'
    Enabled = True
  end
  object rgpModalitaCalcolo: TmeIWRadioGroup [19]
    Left = 274
    Top = 216
    Width = 231
    Height = 27
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
    FriendlyName = 'rgpModalitaCalcolo'
    ItemIndex = 0
    Items.Strings = (
      'Data competenza'
      'Data cedolino')
    Layout = glHorizontal
    TabOrder = 11
  end
  object btnEsegui: TmedpIWImageButton [20]
    Left = 25
    Top = 371
    Width = 122
    Height = 27
    Css = 'width15chr align_center'
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object clbFondi: TmeTIWCheckListBox [21]
    Left = 25
    Top = 268
    Width = 318
    Height = 89
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
    Font.Color = clNone
    Font.Enabled = False
    Font.FontName = 'Arial'
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'clbFondi'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    BorderColor = clNone
    BorderWidth = 0
    BGColorTo = clNone
    BGColorGradientDirection = gdHorizontal
    CheckAllBox = False
    CheckAllHelp = htNone
    CheckAllText = 'Check All'
    UnCheckAllText = 'UnCheck All'
    medpContextMenu = pmnAzioni
  end
  object btnDate: TmeIWButton [22]
    Left = 507
    Top = 159
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
    Caption = 'nascosto'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnDate'
    TabOrder = 13
    OnClick = btnDateClick
    medpDownloadButton = False
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 844
    Top = 80
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 844
    Top = 136
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 844
    Top = 392
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 844
    Top = 200
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 844
    Top = 256
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 844
    Top = 320
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 845
  end
  object pmnAzioni: TPopupMenu
    Left = 120
    Top = 295
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll submit'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone submit'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert submit'
      OnClick = Invertiselezione1Click
    end
  end
end
