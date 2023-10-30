inherited WA059FContSquadre: TWA059FContSquadre
  Tag = 25
  Width = 740
  Height = 533
  ExplicitWidth = 740
  ExplicitHeight = 533
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 88
    Top = 136
    ExplicitLeft = 88
    ExplicitTop = 136
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 88
    Top = 74
    ExplicitLeft = 88
    ExplicitTop = 74
  end
  inherited btnShowElabError: TmeIWButton
    Left = 88
    Top = 105
    ExplicitLeft = 88
    ExplicitTop = 105
  end
  object lblSquadraDa: TmeIWLabel [9]
    Left = 37
    Top = 266
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
    FriendlyName = 'lblSquadraDa'
    Caption = 'Da squadra'
    Enabled = True
  end
  object cmbCodSquadraDa: TMedpIWMultiColumnComboBox [10]
    Left = 31
    Top = 280
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
    FriendlyName = 'cmbCodSquadraDa'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = cmbCodSquadraDaAsyncChange
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
  object lblSquadraA: TmeIWLabel [11]
    Left = 37
    Top = 307
    Width = 63
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
    FriendlyName = 'lblSquadraA'
    Caption = 'A squadra'
    Enabled = True
  end
  object cmbCodSquadraA: TMedpIWMultiColumnComboBox [12]
    Left = 31
    Top = 321
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
    FriendlyName = 'cmbCodSquadraA'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = cmbCodSquadraDaAsyncChange
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
  object rgpModalita: TmeIWRadioGroup [13]
    Left = 24
    Top = 368
    Width = 209
    Height = 33
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
    FriendlyName = 'rgpModalita'
    ItemIndex = 0
    Items.Strings = (
      'Operativa'
      'Non operativa')
    Layout = glHorizontal
    TabOrder = 9
    OnAsyncClick = rgpModalitaAsyncClick
  end
  object lblModalita: TmeIWLabel [14]
    Left = 24
    Top = 346
    Width = 111
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
    FriendlyName = 'lblModalita'
    Caption = 'Modalit'#224' di lavoro'
    Enabled = True
  end
  object rgpTipo: TmeIWRadioGroup [15]
    Left = 24
    Top = 429
    Width = 209
    Height = 49
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
    FriendlyName = 'rgpTipo'
    ItemIndex = 0
    Items.Strings = (
      'Iniziale'
      'Corrente')
    Layout = glHorizontal
    TabOrder = 10
  end
  object lblTipo: TmeIWLabel [16]
    Left = 24
    Top = 407
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
    HasTabOrder = False
    FriendlyName = 'lblTipo'
    Caption = 'Tipo pianificazione'
    Enabled = True
  end
  object lblDataDa: TmeIWLabel [17]
    Left = 38
    Top = 200
    Width = 62
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
    FriendlyName = 'lblDataDa'
    Caption = 'Dalla data'
    Enabled = True
  end
  object edtDataDa: TmeIWEdit [18]
    Left = 120
    Top = 200
    Width = 70
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
    FriendlyName = 'edtDataDa'
    SubmitOnAsyncEvent = True
    TabOrder = 11
    OnAsyncChange = edtDataDaAsyncChange
  end
  object lblDataA: TmeIWLabel [19]
    Left = 59
    Top = 239
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
    FriendlyName = 'lblDataA'
    Caption = 'Alla data'
    Enabled = True
  end
  object edtDataA: TmeIWEdit [20]
    Left = 120
    Top = 240
    Width = 67
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
    FriendlyName = 'edtDataA'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    OnAsyncChange = edtDataDaAsyncChange
  end
  object btnGeneraPDF: TmedpIWImageButton [21]
    Left = 298
    Top = 471
    Width = 122
    Height = 28
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
    ImageFile.URL = 'img/btnPdf.png'
    medpDownloadButton = False
    Caption = 'Stampa in PDF'
  end
  object lblDescSquadraDa: TmeIWLabel [22]
    Left = 171
    Top = 285
    Width = 35
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
    FriendlyName = 'lblDescSquadraDa'
    Caption = 'Descr'
    Enabled = True
  end
  object lblDescSquadraA: TmeIWLabel [23]
    Left = 171
    Top = 326
    Width = 35
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
    FriendlyName = 'lblDescSquadraA'
    Caption = 'Descr'
    Enabled = True
  end
  object btnCambioData: TmeIWButton [24]
    Left = 216
    Top = 215
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
    Caption = 'pulsante nascosto per cambio data'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnShowElabError'
    TabOrder = 13
    OnClick = btnCambioDataClick
    medpDownloadButton = False
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 151
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Top = 16
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Top = 72
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 640
    Top = 136
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Top = 136
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 640
    Top = 16
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 640
    Top = 72
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 376
    Top = 16
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 256
    Top = 16
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 320
    Top = 168
  end
end
