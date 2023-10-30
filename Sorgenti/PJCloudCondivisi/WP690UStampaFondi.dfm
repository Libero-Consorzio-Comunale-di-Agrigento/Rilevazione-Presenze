inherited WP690FStampaFondi: TWP690FStampaFondi
  Tag = 612
  Height = 603
  ExplicitHeight = 603
  DesignLeft = 8
  DesignTop = 8
  object lblDecorrenzaDa: TmeIWLabel [9]
    Left = 17
    Top = 312
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
    Left = 266
    Top = 312
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
    Left = 160
    Top = 312
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
    Left = 391
    Top = 312
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
  object btnDate: TmeIWButton [13]
    Left = 307
    Top = 281
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
    TabOrder = 9
    OnClick = btnDateClick
    medpDownloadButton = False
  end
  object chkRaggruppa: TmeIWCheckBox [14]
    Left = 17
    Top = 339
    Width = 137
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
    Caption = 'Raggruppa fondi'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    Checked = False
    FriendlyName = 'chkRaggruppa'
  end
  object lblFondi: TmeIWLabel [15]
    Left = 16
    Top = 366
    Width = 123
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
    Caption = 'Fondi da stampare:'
    Enabled = True
  end
  object clbFondi: TmeTIWCheckListBox [16]
    Left = 16
    Top = 388
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
    TabOrder = 11
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
  object btnGeneraPDF: TmedpIWImageButton [17]
    Left = 16
    Top = 483
    Width = 166
    Height = 35
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
    OnClick = btnGeneraPDFClick
    Cacheable = True
    FriendlyName = 'btnGeneraPDF'
    ImageFile.Filename = 'img\btnPdf.png'
    medpDownloadButton = False
    Caption = 'Stampa in PDF'
  end
  object chkDettRisorse: TmeIWCheckBox [18]
    Left = 160
    Top = 339
    Width = 137
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
    Caption = 'Dettaglio risorse'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = False
    FriendlyName = 'chkDettRisorse'
  end
  object chkDettDestinazioni: TmeIWCheckBox [19]
    Left = 303
    Top = 339
    Width = 137
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
    Caption = 'Dettaglio destinazioni'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 13
    Checked = False
    FriendlyName = 'chkDettDestinazioni'
  end
  object pmnAzioni: TPopupMenu
    Left = 120
    Top = 407
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
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 608
    Top = 88
  end
end
