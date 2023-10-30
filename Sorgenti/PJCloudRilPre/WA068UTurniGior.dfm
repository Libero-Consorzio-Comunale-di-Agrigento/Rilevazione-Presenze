inherited WA068FTurniGior: TWA068FTurniGior
  Tag = 33
  Width = 658
  Height = 459
  ExplicitWidth = 658
  ExplicitHeight = 459
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 59
    Top = 136
    ExplicitLeft = 59
    ExplicitTop = 136
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 59
    Top = 74
    ExplicitLeft = 59
    ExplicitTop = 74
  end
  inherited btnShowElabError: TmeIWButton
    Left = 59
    Top = 105
    ExplicitLeft = 59
    ExplicitTop = 105
  end
  object btnGeneraPDF: TmedpIWImageButton [9]
    Left = 194
    Top = 351
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
  object lblData: TmeIWLabel [10]
    Left = 33
    Top = 192
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
    HasTabOrder = False
    FriendlyName = 'lblData'
    Caption = 'Data'
    Enabled = True
  end
  object edtData: TmeIWEdit [11]
    Left = 115
    Top = 192
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
    FriendlyName = 'edtData'
    SubmitOnAsyncEvent = True
    TabOrder = 7
  end
  object lblIntestazione: TmeIWLabel [12]
    Left = 33
    Top = 240
    Width = 75
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
    FriendlyName = 'lblIntestazione'
    Caption = 'Intestazione'
    Enabled = True
  end
  object edtIntestazione: TmeIWEdit [13]
    Left = 115
    Top = 240
    Width = 174
    Height = 21
    Css = 'width45chr'
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
    FriendlyName = 'edtIntestazione'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    Text = 'Settore XXX'
  end
  object rgpTPianif: TmeIWRadioGroup [14]
    Left = 33
    Top = 304
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
    FriendlyName = 'rgpTPianif'
    ItemIndex = 0
    Items.Strings = (
      'Operativa'
      'Non Operativa')
    Layout = glHorizontal
    TabOrder = 9
  end
  object lblTPianif: TmeIWLabel [15]
    Left = 33
    Top = 282
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
    FriendlyName = 'lblTPianif'
    Caption = 'Modalit'#224' di lavoro'
    Enabled = True
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Top = 16
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 376
    Top = 104
  end
end
