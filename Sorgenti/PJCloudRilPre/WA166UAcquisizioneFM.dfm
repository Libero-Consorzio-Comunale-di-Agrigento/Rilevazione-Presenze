inherited WA166FAcquisizioneFM: TWA166FAcquisizioneFM
  Width = 527
  Height = 272
  ExplicitWidth = 527
  ExplicitHeight = 272
  inherited IWFrameRegion: TIWRegion
    Width = 527
    Height = 272
    ExplicitWidth = 527
    ExplicitHeight = 272
    object btnAnomalie: TmedpIWImageButton
      Left = 16
      Top = 227
      Width = 122
      Height = 27
      Css = 'inline'
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
    object btnEsegui: TmedpIWImageButton
      Left = 144
      Top = 227
      Width = 122
      Height = 27
      Css = 'inline'
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
    object btnChiudi: TmeIWButton
      Left = 428
      Top = 229
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
      Caption = 'Chiudi'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      TabOrder = 0
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object btnUpload: TmedpIWImageButton
      Left = 315
      Top = 152
      Width = 41
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
      TabOrder = -1
      UseSize = False
      OnClick = btnUploadClick
      Cacheable = True
      FriendlyName = 'btnUpload'
      ImageFile.Filename = 'img\btnUpload2.png'
      medpDownloadButton = False
      Caption = 'Conferma'
    end
    object btnVisualizzaFile: TmedpIWImageButton
      Left = 386
      Top = 152
      Width = 41
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
      OnClick = btnVisualizzaFileClick
      Cacheable = True
      FriendlyName = 'btnVisualizzaFile'
      ImageFile.Filename = 'img\btnVisualizzaFile.png'
      medpDownloadButton = True
      Caption = 'Visualizza file'
    end
    object lbFileScelto: TmeIWLabel
      Left = 33
      Top = 184
      Width = 105
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
      FriendlyName = 'lbFileScelto'
      Caption = 'Nome file scelto:'
      Enabled = True
    end
    object lblFileSceltoDescr: TmeIWLabel
      Left = 144
      Top = 184
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
      FriendlyName = 'lblFileSceltoDescr'
      Caption = 'lblFileSceltoDescr'
      Enabled = True
    end
    object lblTipoQuota: TmeIWLabel
      Left = 32
      Top = 96
      Width = 67
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
      FriendlyName = 'lblTipoQuota'
      Caption = 'Tipo quota'
      Enabled = True
    end
    object cmbTipoQuota: TMedpIWMultiColumnComboBox
      Left = 105
      Top = 96
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
      FriendlyName = 'cmbTipoQuota'
      SubmitOnAsyncEvent = True
      TabOrder = 1
      OnAsyncChange = cmbTipoQuotaAsyncChange
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 3
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width10chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblDescTipoQuota: TmeIWLabel
      Left = 232
      Top = 101
      Width = 108
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
      FriendlyName = 'lblDescTipoQuota'
      Caption = 'lblDescTipoQuota'
      Enabled = True
    end
    object btnSendFile: TmeIWButton
      Left = 386
      Top = 101
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
      Caption = 'btnSendFile'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnSendFile'
      TabOrder = 2
      OnClick = btnSendFileClick
      medpDownloadButton = False
    end
    object fileUpload: TmeIWFileUploader
      Left = 32
      Top = 152
      Width = 265
      Height = 26
      TabOrder = 3
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
    end
  end
end
