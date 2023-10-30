inherited W015FServerStampe: TW015FServerStampe
  Tag = 414
  Width = 685
  Height = 235
  HelpType = htKeyword
  HelpKeyword = 'W015P0'
  Title = '(W015) Generatore di stampe'
  ExplicitWidth = 685
  ExplicitHeight = 235
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 5
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 0
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 1
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 2
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 6
  end
  object lblPeriodo: TmeIWLabel [8]
    Left = 17
    Top = 150
    Width = 140
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
    FriendlyName = 'lblPeriodo'
    Caption = 'Periodo da elaborare  '
    Enabled = True
  end
  object edtPeriodoDal: TmeIWEdit [9]
    Left = 175
    Top = 148
    Width = 69
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
    TabOrder = 3
  end
  object edtPeriodoAl: TmeIWEdit [10]
    Left = 250
    Top = 149
    Width = 69
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
    FriendlyName = 'edtDal'
    SubmitOnAsyncEvent = True
    TabOrder = 7
  end
  object btnStampa: TmeIWButton [11]
    Left = 554
    Top = 150
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
    Caption = 'Stampa'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampa'
    TabOrder = 8
    OnClick = btnAggiornamentoClick
    medpDownloadButton = False
  end
  object lblParametrizzazione: TmeIWLabel [12]
    Left = 17
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
    ForControl = cmbParametrizzazione
    HasTabOrder = False
    FriendlyName = 'lblPeriodoDal'
    Caption = 'Parametrizzazione'
    Enabled = True
  end
  object cmbParametrizzazione: TmeIWComboBox [13]
    Left = 175
    Top = 194
    Width = 294
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
    TabOrder = 9
    ItemIndex = -1
    FriendlyName = 'cmbParametrizzazione'
    NoSelectionText = '-- No Selection --'
  end
  object rgpFormatoStampa: TmeIWRadioGroup [14]
    Left = 464
    Top = 151
    Width = 74
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
    FriendlyName = 'rgpFormatoStampa'
    ItemIndex = 0
    Items.Strings = (
      'pdf'
      'xls')
    Layout = glHorizontal
    TabOrder = 10
  end
  object lblFormatoStampa: TmeIWLabel [15]
    Left = 361
    Top = 149
    Width = 108
    Height = 16
    Css = 'intestazione spazio_sx1'
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
    FriendlyName = 'lblFormatoStampa'
    Caption = 'Formato stampa:'
    Enabled = True
  end
  object imgPeriodoPrec: TmeIWImageFile [16]
    Left = 149
    Top = 149
    Width = 20
    Height = 20
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
    Cacheable = True
    FriendlyName = 'imgPeriodoPrec'
    medpDownloadButton = False
  end
  object imgPeriodoSucc: TmeIWImageFile [17]
    Left = 325
    Top = 149
    Width = 20
    Height = 20
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
    Cacheable = True
    FriendlyName = 'imgPeriodoSucc'
    medpDownloadButton = False
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{D1FA98B6-6C13-4F6F-B862-E55B7A6FD1EA}'
    ServerName = 'A077PCOMServer.A077COMServer'
    ComputerName = 'localhost'
    Left = 368
    Top = 8
  end
  object DCOMConnection2: TDCOMConnection
    ServerGUID = '{F257D48B-2FDF-40BF-A701-EC19EBC7DBBE}'
    ServerName = 'P077PCOMServer.P077ComServer'
    ComputerName = 'localhost'
    Left = 424
    Top = 8
  end
end
