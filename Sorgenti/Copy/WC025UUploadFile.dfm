inherited WC025FUploadFileFM: TWC025FUploadFileFM
  inherited IWFrameRegion: TIWRegion
    object btnChiudi: TmeIWButton
      Left = 252
      Top = 129
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
    object btnConferma: TmeIWButton
      Left = 252
      Top = 98
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
      Caption = 'Conferma'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      TabOrder = 1
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object lblFile: TmeIWLabel
      Left = 3
      Top = 64
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
      FriendlyName = 'lblFile'
      Caption = 'lblFile'
      Enabled = True
    end
    object fileUpload: TmeIWFileUploader
      Left = 16
      Top = 86
      Width = 230
      Height = 60
      TabOrder = 2
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
