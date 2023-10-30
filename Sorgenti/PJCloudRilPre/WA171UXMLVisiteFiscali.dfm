inherited WA171FXMLVisiteFiscali: TWA171FXMLVisiteFiscali
  Tag = 148
  Width = 797
  Height = 503
  Title = '(WA171) XML Visite fiscali'
  ExplicitWidth = 797
  ExplicitHeight = 503
  DesignLeft = 8
  DesignTop = 8
  object edtFiltroPeriodoA: TmeIWEdit [15]
    Left = 264
    Top = 303
    Width = 121
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
    FriendlyName = 'edtFiltroPeriodoA'
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtFiltroPeriodoAAsyncChange
    Text = 'edtFiltroPeriodoA'
  end
  object edtFiltroPeriodoDa: TmeIWEdit [16]
    Left = 117
    Top = 303
    Width = 121
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
    FriendlyName = 'edtFiltroPeriodoDa'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtFiltroPeriodoDaAsyncChange
    Text = 'edtFiltroPeriodoDa'
  end
  object rdgFiltroElaborato: TmeTIWAdvRadioGroup [17]
    Left = 96
    Top = 330
    Height = 41
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebTransparent
    BorderWidth = 0
    Caption = 'Filtro elaborato'
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Columns = 3
    Editable = True
    FriendlyName = 'rdgFiltroElaborato'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Tutto'
      'Elaborato'
      'Da elaborare')
    ItemIndex = 2
    Values.Strings = (
      ''
      'S'
      'N')
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnClick = rdgFiltroElaboratoClick
  end
  object btnAnomalie: TmedpIWImageButton [18]
    Left = 535
    Top = 446
    Width = 105
    Height = 26
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    Enabled = False
    TabOrder = -1
    UseSize = False
    OnClick = btnAnomalieClick
    Cacheable = True
    FriendlyName = 'btnAnomalie'
    ImageFile.URL = 'img/btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object lblFiltroPeriodoDa: TmeIWLabel [19]
    Left = 16
    Top = 305
    Width = 104
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
    FriendlyName = 'lblFiltroPeriodoDa'
    Caption = 'Filtro periodo Da'
    Enabled = True
  end
  object lblFiltroPeriodoA: TmeIWLabel [20]
    Left = 244
    Top = 303
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
    FriendlyName = 'lblFiltroPeriodoA'
    Caption = 'A'
    Enabled = True
  end
  object grpInfoRichiedente: TmeIWLabel [21]
    Left = 28
    Top = 385
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
    HasTabOrder = False
    FriendlyName = 'grpInfoRichiedente'
    Caption = 'Richiedente'
    Enabled = True
  end
  object lblRichiedenteCognome: TmeIWLabel [22]
    Left = 33
    Top = 407
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
    HasTabOrder = False
    FriendlyName = 'lblRichiedenteCognome'
    Caption = 'Cognome'
    Enabled = True
  end
  object lblRichiedenteNome: TmeIWLabel [23]
    Left = 247
    Top = 407
    Width = 36
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
    FriendlyName = 'lblRichiedenteNome'
    Caption = 'Nome'
    Enabled = True
  end
  object lblRichiedenteCodFiscale: TmeIWLabel [24]
    Left = 461
    Top = 407
    Width = 68
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
    FriendlyName = 'lblRichiedenteCodFiscale'
    Caption = 'Cod.fiscale'
    Enabled = True
  end
  object lblEMail: TmeIWLabel [25]
    Left = 33
    Top = 436
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
    FriendlyName = 'lblEMail'
    Caption = 'E-Mail'
    Enabled = True
  end
  object lblTelefono: TmeIWLabel [26]
    Left = 247
    Top = 436
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
    FriendlyName = 'lblTelefono'
    Caption = 'Telefono'
    Enabled = True
  end
  object edtRichiedenteCognome: TmeIWEdit [27]
    Left = 117
    Top = 407
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtRichiedenteCognome'
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object edtRichiedenteNome: TmeIWEdit [28]
    Left = 331
    Top = 407
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtRichiedenteNome'
    SubmitOnAsyncEvent = True
    TabOrder = 11
  end
  object edtRichiedenteCodFiscale: TmeIWEdit [29]
    Left = 545
    Top = 407
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtRichiedenteCodFiscale'
    SubmitOnAsyncEvent = True
    TabOrder = 12
  end
  object edtEMail: TmeIWEdit [30]
    Left = 117
    Top = 436
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtEMail'
    SubmitOnAsyncEvent = True
    TabOrder = 13
  end
  object edtTelefono: TmeIWEdit [31]
    Left = 331
    Top = 436
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
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtTelefono'
    SubmitOnAsyncEvent = True
    TabOrder = 14
  end
  object btnGeneraXML: TmedpIWImageButton [32]
    Left = 646
    Top = 447
    Width = 105
    Height = 26
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    Enabled = False
    TabOrder = -1
    UseSize = False
    OnClick = btnGeneraXMLClick
    Cacheable = True
    FriendlyName = 'btnGeneraXML'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Genera file'
  end
  object btnAggiorna: TmeIWButton [33]
    Left = 254
    Top = 330
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
    FriendlyName = 'btnAggiorna'
    TabOrder = 15
    OnClick = btnAggiornaClick
    medpDownloadButton = False
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actNuovo: TAction
      Visible = False
    end
    object actCaricaVisite: TAction
      Caption = 'btnImport'
      Hint = 'Carica richieste da '#39'Comunicazione visite fiscali'#39
      OnExecute = actCaricaVisiteExecute
    end
    object actCancellaVisite: TAction
      Caption = 'btnCestino'
      Hint = 'Cancella richieste visite fiscali'
      OnExecute = actCancellaVisiteExecute
    end
  end
end
