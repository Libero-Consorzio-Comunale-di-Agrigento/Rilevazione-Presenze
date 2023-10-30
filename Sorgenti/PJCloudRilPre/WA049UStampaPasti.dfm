inherited WA049FStampaPasti: TWA049FStampaPasti
  Tag = 28
  Width = 651
  Height = 482
  Title = '(WA049) Cartolina accessi mensa'
  ExplicitWidth = 651
  ExplicitHeight = 482
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 8
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited btnShowElabError: TmeIWButton
    TabOrder = 5
  end
  object edtDa: TmeIWEdit [9]
    Left = 35
    Top = 246
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtDa'
    SubmitOnAsyncEvent = True
    TabOrder = 4
    OnAsyncChange = edtDaAsyncChange
  end
  object lblDa: TmeIWLabel [10]
    Left = 35
    Top = 224
    Width = 48
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
    FriendlyName = 'lblDa'
    Caption = 'Da data'
    Enabled = True
  end
  object lblA: TmeIWLabel [11]
    Left = 195
    Top = 224
    Width = 40
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
    FriendlyName = 'lblDa'
    Caption = 'A data'
    Enabled = True
  end
  object edtA: TmeIWEdit [12]
    Left = 195
    Top = 246
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
    NonEditableAsLabel = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'meIWEdit1'
    SubmitOnAsyncEvent = True
    TabOrder = 6
    OnAsyncChange = edtAAsyncChange
  end
  object lblOrologi: TmeIWLabel [13]
    Left = 35
    Top = 296
    Width = 45
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
    FriendlyName = 'lblOrologi'
    Caption = 'Orologi'
    Enabled = True
  end
  object chkAggiorna: TmeIWCheckBox [14]
    Left = 195
    Top = 296
    Width = 198
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
    Caption = 'Aggiornamento del riepilogo'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    OnAsyncClick = chkAggiornaAsyncClick
    Checked = False
    FriendlyName = 'chkAggiorna'
  end
  object lblRaggruppamento: TmeIWLabel [15]
    Left = 195
    Top = 323
    Width = 107
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
    FriendlyName = 'lblRaggruppamento'
    Caption = 'Raggruppamento'
    Enabled = True
  end
  object chkSaltoPagina: TmeIWCheckBox [16]
    Left = 195
    Top = 372
    Width = 142
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
    Caption = 'Salto pagina'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 10
    Checked = False
    FriendlyName = 'chkSaltoPagina'
  end
  object chkDettaglio: TmeIWCheckBox [17]
    Left = 195
    Top = 399
    Width = 142
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
    Caption = 'Dettaglio individuale'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 11
    Checked = False
    FriendlyName = 'chkDettaglio'
  end
  object cgpTerm: TmeTIWAdvCheckGroup [18]
    Left = 35
    Top = 323
    Height = 24
    Css = 'intestazione nowrapcheckgroup'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    BorderColor = clNone
    BorderWidth = 0
    Caption = ''
    CaptionFont.Color = clNone
    CaptionFont.Size = 10
    CaptionFont.Style = []
    Editable = True
    FriendlyName = 'cgpTerm'
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    TabOrder = 12
    medpContextMenu = pmnAzioni
  end
  object imgSelezionaTutto: TmeIWImageFile [19]
    Left = 40
    Top = 439
    Width = 20
    Height = 20
    Hint = 'Seleziona tutto'
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
    OnAsyncClick = imgSelezionaTuttoAsyncClick
    Cacheable = True
    FriendlyName = 'imgSelezionaTutto'
    ImageFile.Filename = 'img\btnCheckAll.png'
    medpDownloadButton = False
  end
  object imgDeselezionaTutto: TmeIWImageFile [20]
    Left = 66
    Top = 438
    Width = 22
    Height = 21
    Hint = 'Deseleziona tutto'
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
    OnAsyncClick = imgDeselezionaTuttoAsyncClick
    Cacheable = True
    FriendlyName = 'IWImageFile1'
    ImageFile.Filename = 'img\btnUncheckAll.png'
    medpDownloadButton = False
  end
  object cmbRaggruppamento: TmeIWComboBox [21]
    Left = 195
    Top = 345
    Width = 121
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
    UseSize = False
    OnAsyncClick = cmbRaggruppamentoAsyncClick
    TabOrder = 13
    ItemIndex = -1
    FriendlyName = 'cmbRaggruppamento'
    NoSelectionText = ' '
  end
  object imbGeneraPDF: TmedpIWImageButton [22]
    Left = 395
    Top = 339
    Width = 137
    Height = 27
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
    OnClick = imbSoloAggiornamentoClick
    Cacheable = True
    FriendlyName = 'imbGeneraPDF'
    ImageFile.Filename = 'img\btnPdf.png'
    medpDownloadButton = False
    Caption = 'Stampa in PDF'
  end
  object imbAnomalie: TmedpIWImageButton [23]
    Left = 395
    Top = 407
    Width = 137
    Height = 27
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
    OnClick = imbAnomalieClick
    Cacheable = True
    FriendlyName = 'imbSoloAggiornamento'
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object imbSoloAggiornamento: TmedpIWImageButton [24]
    Left = 395
    Top = 372
    Width = 137
    Height = 27
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
    OnClick = imbSoloAggiornamentoClick
    Cacheable = True
    FriendlyName = 'imbSoloAggiornamento'
    ImageFile.Filename = 'img\btnSalva.png'
    medpDownloadButton = False
    Caption = 'Solo aggiornamento'
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 448
    Top = 16
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 448
    Top = 72
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 560
    Top = 136
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 448
    Top = 136
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 448
    Top = 192
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 560
    Top = 80
  end
  object pmnAzioni: TPopupMenu
    Left = 96
    Top = 344
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
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 288
    Top = 96
  end
end
