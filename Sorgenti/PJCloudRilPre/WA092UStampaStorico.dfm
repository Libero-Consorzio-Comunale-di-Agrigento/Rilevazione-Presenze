inherited WA092FStampaStorico: TWA092FStampaStorico
  Tag = 42
  Width = 710
  Height = 530
  Title = '(WA092) Elenco movimenti storici'
  ExplicitWidth = 710
  ExplicitHeight = 530
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 59
    Top = 122
    ExplicitLeft = 59
    ExplicitTop = 122
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 59
    Top = 60
    ExplicitLeft = 59
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 59
    Top = 91
    ExplicitLeft = 59
    ExplicitTop = 91
  end
  object lblLstAnagra: TmeIWLabel [9]
    Left = 33
    Top = 184
    Width = 218
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
    FriendlyName = 'lblLstAnagra'
    Caption = 'Dati anagrafici storicizzati richiesti:'
    Enabled = True
  end
  object cgpAnagra: TmeTIWAdvCheckGroup [10]
    Left = 33
    Top = 214
    Height = 24
    Css = 'noborder'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clWebBLACK
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'cgpAnagra'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 7
    medpContextMenu = pmnAzioni
  end
  object lblDaData: TmeIWLabel [11]
    Left = 222
    Top = 217
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
    FriendlyName = 'lblDaData'
    Caption = 'Dalla data'
    Enabled = True
  end
  object edtDaData: TmeIWEdit [12]
    Left = 304
    Top = 217
    Width = 121
    Height = 21
    Css = 'input_data_dmy width15chr'
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
    TabOrder = 8
  end
  object lblAData: TmeIWLabel [13]
    Left = 229
    Top = 259
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
    FriendlyName = 'lblAData'
    Caption = 'Alla data'
    Enabled = True
  end
  object edtAData: TmeIWEdit [14]
    Left = 304
    Top = 259
    Width = 121
    Height = 21
    Css = 'input_data_dmy width15chr'
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
    TabOrder = 9
  end
  object rgpOrdinamento: TmeTIWAdvRadioGroup [15]
    Left = 229
    Top = 311
    Width = 104
    Height = 49
    Css = 'groupbox fieldset_width10em'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clNone
    BorderWidth = 0
    Caption = 'Ordinamento'
    CaptionFont.Color = clNone
    CaptionFont.Enabled = False
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'rgpOrdinamento'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    Items.Strings = (
      'Cronologico'
      'Per dato')
    ItemIndex = 0
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object chkVariazioni: TmeIWCheckBox [16]
    Left = 229
    Top = 383
    Width = 228
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
    Caption = 'Stampa solo se ci sono variazioni'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'chkVariazioni'
  end
  object chkSaltoPagina: TmeIWCheckBox [17]
    Left = 229
    Top = 410
    Width = 188
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
    Caption = 'Salto pagina per dipendente'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = True
    FriendlyName = 'chkSaltoPagina'
  end
  object btnGeneraPDF: TmedpIWImageButton [18]
    Left = 33
    Top = 447
    Width = 166
    Height = 35
    Css = 'pulsanti width16chr align_center'
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
  object btnVisStampa: TmedpIWImageButton [19]
    Left = 33
    Top = 406
    Width = 166
    Height = 35
    Css = 'pulsanti width16chr align_center'
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
    OnClick = btnVisStampaClick
    Cacheable = True
    FriendlyName = 'btnVisStampa'
    ImageFile.Filename = 'img\btnVideo.png'
    medpDownloadButton = False
    Caption = 'Visualizza'
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Top = 16
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Top = 72
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 616
    Top = 128
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 616
    Top = 16
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 616
    Top = 72
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Top = 8
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 848
    Top = 16
  end
  object pmnAzioni: TPopupMenu
    Left = 136
    Top = 232
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      Hint = 'checkAll'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      Hint = 'checkNone'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      Hint = 'checkInvert'
      OnClick = Invertiselezione1Click
    end
  end
end
