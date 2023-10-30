inherited WA173FImportAssestamento: TWA173FImportAssestamento
  Tag = 208
  Height = 597
  Title = '(WA173) Importazione ore liquidate e di assestamento'
  ExplicitHeight = 597
  DesignLeft = 8
  DesignTop = 8
  inherited lnkIndietro: TmeIWLink
    TabOrder = 3
  end
  inherited lnkHelp: TmeIWLink
    TabOrder = 4
  end
  inherited lnkEsci: TmeIWLink
    TabOrder = 5
  end
  inherited lnkChiudiSchede: TmeIWLink
    TabOrder = 6
  end
  inherited btnSendFile: TmeIWButton
    TabOrder = 8
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 9
  end
  inherited btnShowElabError: TmeIWButton
    TabOrder = 7
  end
  object lblNomeFileInput: TmeIWLabel [9]
    Left = 40
    Top = 273
    Width = 328
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
    FriendlyName = 'lblNomeFileInput'
    Caption = 'File contenente le ore di assestamento da importare'
    Enabled = True
  end
  object btnEsegui: TmedpIWImageButton [10]
    Left = 40
    Top = 536
    Width = 122
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnAnomalie: TmedpIWImageButton [11]
    Left = 198
    Top = 536
    Width = 122
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
  object rgpTipoOperazione: TmeIWRadioGroup [12]
    Left = 40
    Top = 385
    Width = 280
    Height = 33
    Cursor = crDefault
    Css = 'intestazione medpRgpHAlign'
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
    FriendlyName = 'rgpTipoOperazione'
    ItemIndex = 0
    Items.Strings = (
      'Registrazione'
      'Cancellazione')
    Layout = glHorizontal
    TabOrder = 2
  end
  object lblTipoOperazione: TmeIWLabel [13]
    Left = 40
    Top = 366
    Width = 101
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
    FriendlyName = 'lblTipoOperazione'
    Caption = 'Tipo operazione'
    Enabled = True
  end
  object fileUpload: TmeIWFileUploader [14]
    Left = 40
    Top = 295
    Width = 297
    Height = 25
    TabOrder = 0
    TextStrings.DragText = 'Trascinare qui i file da caricare'
    TextStrings.UploadButtonText = 'Sfoglia...'
    TextStrings.CancelButtonText = 'Annulla'
    TextStrings.UploadErrorText = 'Upload fallito'
    TextStrings.MultipleFileDropNotAllowedText = #200' possibile trascinare un file solo'
    TextStrings.OfTotalText = 'di'
    TextStrings.RemoveButtonText = 'Rimuovi'
    TextStrings.TypeErrorText = 
      '{file} ha estensione non valida. Sono consentiti solo i file {ex' +
      'tensions}.'
    TextStrings.SizeErrorText = 
      '{file} '#232' troppo grande, la dimensione massima consentita '#232' {size' +
      'Limit}.'
    TextStrings.MinSizeErrorText = 
      '{file} '#232' troppo piccolo, la dimensione minima consentita '#232' {minS' +
      'izeLimit}.'
    TextStrings.EmptyErrorText = '{file} '#232' vuoto, ripetere la selezione escludendo questo file.'
    TextStrings.NoFilesErrorText = 'Nessun file da caricare.'
    TextStrings.OnLeaveWarningText = 
      #200' in corso il caricamento dei file, se si abbandona ora la proce' +
      'dura di upload sar'#224' annullata.'
    Style.ButtonOptions.Alignment = taCenter
    Style.ButtonOptions.Font.Color = clWebWHITE
    Style.ButtonOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.ButtonOptions.Font.Size = 10
    Style.ButtonOptions.Font.Style = []
    Style.ButtonOptions.FromColor = clWebMAROON
    Style.ButtonOptions.ToColor = clWebMAROON
    Style.ButtonOptions.Height = 30
    Style.ButtonOptions.Width = 200
    Style.ButtonHoverOptions.Alignment = taCenter
    Style.ButtonHoverOptions.Font.Color = clWebWHITE
    Style.ButtonHoverOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.ButtonHoverOptions.Font.Size = 10
    Style.ButtonHoverOptions.Font.Style = []
    Style.ButtonHoverOptions.FromColor = 214
    Style.ButtonHoverOptions.ToColor = 214
    Style.ListOptions.Alignment = taLeftJustify
    Style.ListOptions.Font.Color = clWebBLACK
    Style.ListOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.ListOptions.Font.Size = 10
    Style.ListOptions.Font.Style = []
    Style.ListOptions.FromColor = clWebGOLD
    Style.ListOptions.ToColor = clWebGOLD
    Style.ListOptions.Height = 30
    Style.ListOptions.Width = 0
    Style.ListSuccessOptions.Alignment = taLeftJustify
    Style.ListSuccessOptions.Font.Color = clWebWHITE
    Style.ListSuccessOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.ListSuccessOptions.Font.Size = 10
    Style.ListSuccessOptions.Font.Style = []
    Style.ListSuccessOptions.FromColor = clWebFORESTGREEN
    Style.ListSuccessOptions.ToColor = clWebFORESTGREEN
    Style.ListErrorOptions.Alignment = taLeftJustify
    Style.ListErrorOptions.Font.Color = clWebWHITE
    Style.ListErrorOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.ListErrorOptions.Font.Size = 10
    Style.ListErrorOptions.Font.Style = []
    Style.ListErrorOptions.FromColor = clWebRED
    Style.ListErrorOptions.ToColor = clWebRED
    Style.DropAreaOptions.Alignment = taCenter
    Style.DropAreaOptions.Font.Color = clWebWHITE
    Style.DropAreaOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.DropAreaOptions.Font.Size = 10
    Style.DropAreaOptions.Font.Style = []
    Style.DropAreaOptions.FromColor = clWebDARKORANGE
    Style.DropAreaOptions.ToColor = clWebDARKORANGE
    Style.DropAreaOptions.Height = 60
    Style.DropAreaOptions.Width = 0
    Style.DropAreaActiveOptions.Alignment = taCenter
    Style.DropAreaActiveOptions.Font.Color = clWebWHITE
    Style.DropAreaActiveOptions.Font.FontFamily = 'Arial, Sans-Serif, Verdana'
    Style.DropAreaActiveOptions.Font.Size = 10
    Style.DropAreaActiveOptions.Font.Style = []
    Style.DropAreaActiveOptions.FromColor = clWebLIMEGREEN
    Style.DropAreaActiveOptions.ToColor = clWebLIMEGREEN
    Style.DropAreaActiveOptions.Height = 60
    Style.DropAreaActiveOptions.Width = 0
    AutoUpload = True
    CssClasses.Strings = (
      'button=medpfileuploader-button'
      'button-hover=medpfileuploader-button-hover'
      'drop-area=medpfileuploader-drop-area'
      'drop-area-active=medpfileuploader-drop-area-active'
      'drop-area-disabled='
      'list=medpfileuploader-list'
      'upload-spinner=medpfileuploader-upload-spinner'
      'progress-bar='
      'upload-file=medpfileuploader-upload-file'
      'upload-size=medpfileuploader-upload-size'
      'upload-listItem=medpfileuploader-upload-listItem'
      'upload-cancel=medpfileuploader-upload-cancel'
      'upload-success=medpfileuploader-upload-success'
      'upload-fail=medpfileuploader-upload-fail'
      'success-icon=medpfileuploader-success-icon'
      'fail-icon=medpfileuploader-fail-icon')
    FriendlyName = 'fileUpload'
    Font.Color = clNone
    Font.Size = 10
    Font.Style = []
    MEdpCaptionPulsanteUpload = 'Upload'
    MEdpCssPulsanteUpload = 'pulsante'
    MEdpIncludiPulsanteUpload = False
    MEdpPulsanteEnabled = True
    MEdpPulsanteVisible = True
    MEdpMaxFileSize = -1
    MEdpRipristinaAlRender = True
  end
  object lblTipoImportazione: TmeIWLabel [15]
    Left = 40
    Top = 326
    Width = 110
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
    FriendlyName = 'lblTipoImportazione'
    Caption = 'Dati da importare'
    Enabled = True
  end
  object rgpTipoImportazione: TmeIWRadioGroup [16]
    Left = 40
    Top = 348
    Width = 305
    Height = 16
    Cursor = crDefault
    Css = 'intestazione medpRgpHAlign'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpTipoImportazioneClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpTipoImportazione'
    ItemIndex = 0
    Items.Strings = (
      'Ore assestamento'
      'Ore liquidate e di assestamento')
    Layout = glHorizontal
    TabOrder = 1
  end
  object lblIntervento: TmeIWLabel [17]
    Left = 40
    Top = 408
    Width = 276
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
    FriendlyName = 'lblIntervento'
    Caption = 'Intervento sui dati di assestamento esistenti'
    Enabled = True
  end
  object rgpIntervento: TmeIWRadioGroup [18]
    Left = 40
    Top = 430
    Width = 305
    Height = 27
    Cursor = crDefault
    Css = 'intestazione medpRgpHAlign'
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
    FriendlyName = 'rgpIntervento'
    ItemIndex = 0
    Items.Strings = (
      'Sovrascrittura'
      'Aggiunta')
    Layout = glHorizontal
    TabOrder = 10
  end
  object lblIdDipendente: TmeIWLabel [19]
    Left = 40
    Top = 458
    Width = 152
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
    FriendlyName = 'lblIdDipendente'
    Caption = 'Identificativo dipendente'
    Enabled = True
  end
  object rgpIdDipendente: TmeIWRadioGroup [20]
    Left = 40
    Top = 480
    Width = 305
    Height = 16
    Cursor = crDefault
    Css = 'intestazione medpRgpHAlign'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpIdDipendenteClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpIdDipendente'
    ItemIndex = 0
    Items.Strings = (
      'Matricola'
      'Codice fiscale')
    Layout = glHorizontal
    TabOrder = 11
  end
  object chkCercaCessati: TmeIWCheckBox [21]
    Left = 136
    Top = 509
    Width = 201
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
    Caption = 'Considera dipendenti cessati'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 12
    Checked = False
    FriendlyName = 'chkCercaCessati'
  end
end
