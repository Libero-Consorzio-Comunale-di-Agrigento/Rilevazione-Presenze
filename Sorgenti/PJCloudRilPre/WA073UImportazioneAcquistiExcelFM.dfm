inherited WA073FImportazioneAcquistiExcelFM: TWA073FImportazioneAcquistiExcelFM
  Width = 422
  Height = 477
  ExplicitWidth = 422
  ExplicitHeight = 477
  inherited IWFrameRegion: TIWRegion
    Width = 422
    Height = 477
    ExplicitWidth = 422
    ExplicitHeight = 477
    object dgrdMappaturaExcel: TmedpIWDBGrid
      Left = 15
      Top = 300
      Width = 228
      Height = 70
      Css = 'grigliaDati grid'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColors.Color = clWebWHITE
      BorderColors.Light = clWebWHITE
      BorderColors.Dark = clWebWHITE
      BGColor = clNone
      BorderSize = 0
      BorderStyle = tfVoid
      Caption = 'dgrdMappaturaExcel'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = dgrdMappaturaExcelRenderCell
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <>
      FooterRowCount = 0
      FriendlyName = 'dgrdMappaturaExcel'
      FromStart = True
      HighlightColor = clNone
      HighlightRows = False
      Options = [dgShowTitles]
      RefreshMode = rmAutomatic
      RowLimit = 0
      RollOver = False
      RowClick = True
      RollOverColor = clNone
      RowHeaderColor = clNone
      RowAlternateColor = clNone
      RowCurrentColor = clNone
      TabOrder = -1
      medpContextMenu = pmnAzioni
      medpTipoContatore = 'P'
      medpRighePagina = -1
      medpBrowse = True
      medpRowSelect = True
      medpEditMultiplo = False
      medpFixedColumns = 0
      medpComandiCustom = False
      medpComandiEdit = False
      medpComandiInsert = False
      medpComandoDelete = False
    end
    object rgpTipoImportazione: TmeTIWAdvRadioGroup
      Left = 23
      Top = 28
      Width = 301
      Height = 36
      Cursor = crDefault
      Css = 'intestazione fieldset_width21em'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = 'Tipo importazione'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpTipoImportazione'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'Buoni pasto'
        'Ticket restaurant')
      ItemIndex = 0
      Layout = glHorizontal
      SubmitOnAsyncEvent = True
      TabOrder = 0
    end
    object chkRigaIntestazione: TmeIWCheckBox
      Left = 15
      Top = 241
      Width = 237
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
      Caption = 'Riga di intestazione'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 1
      Checked = False
      FriendlyName = 'chkRigaIntestazione'
    end
    object btnEsegui: TmedpIWImageButton
      Left = 15
      Top = 400
      Width = 97
      Height = 33
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
      OnClick = btnEseguiClick
      Cacheable = True
      FriendlyName = 'btnEsegui'
      ImageFile.Filename = 'img\btnEsegui.png'
      medpDownloadButton = False
      Caption = 'Esegui'
    end
    object btnAnomalie: TmedpIWImageButton
      Left = 155
      Top = 400
      Width = 97
      Height = 33
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
      OnClick = btnAnomalieClick
      Cacheable = True
      FriendlyName = 'btnAnomalie'
      ImageFile.Filename = 'img\btnAnomalie.png'
      medpDownloadButton = False
      Caption = 'Anomalie'
    end
    object IWFile: TmeIWFileUploader
      Left = 170
      Top = 205
      Width = 105
      Height = 21
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
      Style.ListSuccessOptions.Alignment = taRightJustify
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
      FriendlyName = 'IWFile'
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
    object lblFileExcel: TmeIWLabel
      Left = 15
      Top = 205
      Width = 113
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
      FriendlyName = 'lblFileExcel'
      Caption = 'File da importare:'
      Enabled = True
    end
    object rgpTipoFile: TmeTIWAdvRadioGroup
      Left = 23
      Top = 92
      Width = 301
      Height = 36
      Cursor = crDefault
      Css = 'intestazione fieldset_width21em'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderBorder = False
      BorderColor = clWebTransparent
      BorderWidth = 0
      Caption = 'Tipo file da importare'
      CaptionFont.Color = clNone
      CaptionFont.Enabled = False
      CaptionFont.Size = 10
      CaptionFont.Style = []
      Columns = 2
      Editable = True
      FriendlyName = 'rgpTipoFile'
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Items.Strings = (
        'File excel'
        'File csv         ')
      ItemIndex = 0
      Layout = glHorizontal
      Values.Strings = (
        'file excel'
        'file csv')
      SubmitOnAsyncEvent = True
      TabOrder = 3
    end
  end
  object pmnAzioni: TPopupMenu
    Left = 280
    Top = 400
    object Selezionatutto1: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
    end
  end
  object dsrMappaturaExcel: TDataSource
    Left = 336
    Top = 200
  end
end
