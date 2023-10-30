inherited WA104FStampaMissioni: TWA104FStampaMissioni
  Tag = 53
  Height = 574
  ExplicitHeight = 574
  DesignLeft = 8
  DesignTop = 8
  inherited btnShowElabError: TmeIWButton
    Top = 143
    ExplicitTop = 143
  end
  object lblMeseScaricoDa: TmeIWLabel [9]
    Left = 56
    Top = 205
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
    FriendlyName = 'lblMeseScaricoDa'
    Caption = 'Mese scarico da:'
    Enabled = True
  end
  object edtMeseScaricoDa: TmeIWEdit [10]
    Left = 184
    Top = 200
    Width = 121
    Height = 21
    Css = 'input_data_my'
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
    FriendlyName = 'edtMeseScaricoDa'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    Text = 'edtMeseScaricoDa'
  end
  object lblMeseScaricoA: TmeIWLabel [11]
    Left = 63
    Top = 227
    Width = 99
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
    FriendlyName = 'lblMeseScaricoA'
    Caption = 'Mese scarico a:'
    Enabled = True
  end
  object edtMeseScaricoA: TmeIWEdit [12]
    Left = 184
    Top = 227
    Width = 121
    Height = 21
    Css = 'input_data_my'
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
    FriendlyName = 'edtMeseScaricoA'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    Text = 'edtMeseScaricoA'
  end
  object lblStato: TmeIWLabel [13]
    Left = 65
    Top = 265
    Width = 97
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
    FriendlyName = 'lblStato'
    Caption = 'Stato missione:'
    Enabled = True
  end
  object edtStato: TmeIWEdit [14]
    Left = 184
    Top = 265
    Width = 121
    Height = 21
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
    FriendlyName = 'edtStato'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    Text = 'edtStato'
  end
  object btnStato: TmeIWButton [15]
    Left = 312
    Top = 265
    Width = 33
    Height = 21
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
    FriendlyName = 'btnStato'
    TabOrder = 10
    OnClick = btnStatoClick
    medpDownloadButton = False
  end
  object ChkSaltoPagina: TmeIWCheckBox [16]
    Left = 144
    Top = 306
    Width = 172
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
    Caption = 'Salto pagina individuale'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'ChkSaltoPagina'
  end
  object lblTitolo: TmeIWLabel [17]
    Left = 35
    Top = 440
    Width = 88
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
    FriendlyName = 'lblTitolo'
    Caption = 'Titolo Stampa'
    Enabled = True
  end
  object EdtTitolo: TmeIWEdit [18]
    Left = 35
    Top = 462
    Width = 310
    Height = 21
    Css = 'width30chr'
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
    FriendlyName = 'EdtTitolo'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    Text = 'EdtTitolo'
  end
  object btnGeneraPDF: TmedpIWImageButton [19]
    Left = 40
    Top = 499
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
  object lblOrdinamento: TmeIWLabel [20]
    Left = 60
    Top = 333
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
    FriendlyName = 'lblOrdinamento'
    Caption = 'Ordinamento'
    Enabled = True
  end
  object rgpOrdinamento: TmeIWRadioGroup [21]
    Left = 35
    Top = 355
    Width = 310
    Height = 38
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
    FriendlyName = 'rgpOrdinamento'
    ItemIndex = 0
    Items.Strings = (
      'Mese'
      'Anagrafica')
    Layout = glHorizontal
    TabOrder = 13
  end
  object btnGeneraTXT: TmedpIWImageButton [22]
    Left = 184
    Top = 499
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
    OnClick = btnGeneraTXTClick
    Cacheable = True
    FriendlyName = 'btnGeneraTXT'
    ImageFile.URL = 'img/btnTXT.png'
    medpDownloadButton = False
    Caption = 'Stampa in TXT'
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 288
    Top = 8
  end
end
