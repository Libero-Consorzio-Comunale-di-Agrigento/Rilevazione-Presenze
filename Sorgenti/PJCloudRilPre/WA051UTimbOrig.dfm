inherited WA051FTimbOrig: TWA051FTimbOrig
  Tag = 26
  Width = 740
  Height = 483
  Title = '(WA051) Stampa timbrature originali'
  ExplicitWidth = 740
  ExplicitHeight = 483
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 83
    Top = 122
    ExplicitLeft = 83
    ExplicitTop = 122
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 83
    Top = 60
    ExplicitLeft = 83
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 83
    Top = 91
    ExplicitLeft = 83
    ExplicitTop = 91
  end
  object lblAnno: TmeIWLabel [9]
    Left = 46
    Top = 191
    Width = 31
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
    ForControl = edtAnno
    HasTabOrder = False
    FriendlyName = 'lblAnno'
    Caption = 'Anno'
    Enabled = True
  end
  object edtAnno: TmeIWEdit [10]
    Left = 83
    Top = 186
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtAnno'
    MaxLength = 4
    SubmitOnAsyncEvent = True
    TabOrder = 7
    OnAsyncChange = edtAnnoAsyncChange
    Text = '0'
  end
  object lblMese: TmeIWLabel [11]
    Left = 142
    Top = 191
    Width = 33
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
    ForControl = cmbMese
    HasTabOrder = False
    FriendlyName = 'lblMese'
    Caption = 'Mese'
    Enabled = True
  end
  object cmbMese: TmeIWComboBox [12]
    Left = 181
    Top = 186
    Width = 121
    Height = 21
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
    ItemsHaveValues = True
    UseSize = False
    OnAsyncChange = edtAnnoAsyncChange
    NonEditableAsLabel = True
    TabOrder = 8
    ItemIndex = -1
    Items.Strings = (
      'Gennaio=0'
      'Febbraio=1'
      'Marzo=2'
      'Aprile=3'
      'Maggio=4'
      'Giugno=5'
      'Luglio=6'
      'Agosto=7'
      'Settembre=8'
      'Ottobre=9'
      'Novembre=10'
      'Dicembre=11')
    FriendlyName = 'cmbMese'
    NoSelectionText = '-- No Selection --'
  end
  object edtDa: TmeIWEdit [13]
    Left = 119
    Top = 226
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtDa'
    MaxLength = 2
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncChange = edtAnnoAsyncChange
    Text = '0'
  end
  object lblDa: TmeIWLabel [14]
    Left = 46
    Top = 231
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
    ForControl = edtDa
    HasTabOrder = False
    FriendlyName = 'lblDa'
    Caption = 'Dal giorno'
    Enabled = True
  end
  object edtA: TmeIWEdit [15]
    Left = 115
    Top = 253
    Width = 38
    Height = 21
    Css = 'input5'
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
    FriendlyName = 'edtA'
    MaxLength = 2
    SubmitOnAsyncEvent = True
    TabOrder = 10
    OnAsyncChange = edtAnnoAsyncChange
    Text = '0'
  end
  object lblA: TmeIWLabel [16]
    Left = 46
    Top = 258
    Width = 56
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
    ForControl = edtA
    HasTabOrder = False
    FriendlyName = 'lblA'
    Caption = 'Al giorno'
    Enabled = True
  end
  object chkSaltoPagina: TmeIWCheckBox [17]
    Left = 46
    Top = 287
    Width = 299
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
    Caption = 'Salto pagina per dipendente/raggruppamento'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'chkSaltoPagina'
  end
  object cmbCampoRaggr: TmeIWComboBox [18]
    Left = 32
    Top = 340
    Width = 217
    Height = 21
    Css = 'width30chr'
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
    ItemsHaveValues = True
    RequireSelection = False
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 12
    ItemIndex = -1
    FriendlyName = 'cmbCampoRaggr'
    NoSelectionText = ' '
  end
  object lblCampo: TmeIWLabel [19]
    Left = 32
    Top = 318
    Width = 244
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
    FriendlyName = 'lblCampo'
    Caption = 'Campo anagrafico di raggruppamento:'
    Enabled = True
  end
  object rgpTimbrature: TmeIWRadioGroup [20]
    Left = 38
    Top = 398
    Width = 307
    Height = 21
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
    FriendlyName = 'rgpTimbrature'
    ItemIndex = 0
    Items.Strings = (
      'Originali'
      'Cancellate'
      'Non originali'
      'Tutte')
    Layout = glHorizontal
    TabOrder = 13
  end
  object lblTimbrature: TmeIWLabel [21]
    Left = 37
    Top = 372
    Width = 127
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
    ForControl = rgpTimbrature
    HasTabOrder = False
    FriendlyName = 'lblTimbrature'
    Caption = 'Timbrature richieste'
    Enabled = True
  end
  object btnGeneraPDF: TmedpIWImageButton [22]
    Left = 46
    Top = 445
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
  object btnCambioData: TmeIWButton [23]
    Left = 347
    Top = 186
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
    TabOrder = 14
    OnClick = btnCambioDataClick
    medpDownloadButton = False
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Top = 8
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Top = 56
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 640
    Top = 104
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Top = 104
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 632
    Top = 8
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 632
    Top = 56
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 384
    Top = 8
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 288
    Top = 8
  end
end
