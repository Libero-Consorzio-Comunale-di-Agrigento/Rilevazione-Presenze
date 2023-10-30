inherited WA087FImpAttestatiMal: TWA087FImpAttestatiMal
  Tag = 70
  Width = 933
  Height = 924
  Title = '(WA087) Importazione certificati di malattia'
  ExplicitWidth = 933
  ExplicitHeight = 924
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 96
    Top = 116
    ExplicitLeft = 96
    ExplicitTop = 116
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 96
    Top = 60
    ExplicitLeft = 96
    ExplicitTop = 60
  end
  inherited btnShowElabError: TmeIWButton
    Left = 96
    Top = 91
    ExplicitLeft = 96
    ExplicitTop = 91
  end
  object chkEsenzione: TmeIWCheckBox [9]
    Left = 16
    Top = 311
    Width = 145
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
    Caption = 'Mantieni esenzione'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 6
    Checked = False
    FriendlyName = 'chkEsenzione'
  end
  object lblPercorsoFile: TmeIWLabel [10]
    Left = 16
    Top = 338
    Width = 160
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
    FriendlyName = 'lblPercorsoFile'
    Caption = 'Nome file di importazione'
    Enabled = True
  end
  object chkAnomalie: TmeIWCheckBox [11]
    Left = 16
    Top = 440
    Width = 145
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
    Caption = 'Controllo anomalie'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 8
    OnAsyncClick = chkAnomalieAsyncClick
    Checked = False
    FriendlyName = 'chkAnomalie'
  end
  object chkInserimento: TmeIWCheckBox [12]
    Left = 287
    Top = 440
    Width = 145
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
    Caption = 'Importazione  dati'
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    SubmitOnAsyncEvent = True
    Style = stNormal
    TabOrder = 9
    OnAsyncClick = chkAnomalieAsyncClick
    Checked = False
    FriendlyName = 'chkInserimento'
  end
  object grdPreview: TmedpIWDBGrid [13]
    Left = 40
    Top = 584
    Width = 793
    Height = 81
    Css = 'grid'
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
    Caption = 'prova'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdPreviewRenderCell
    Summary = 'Certificati malattia'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdPreview'
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
  object lblCertificati: TmeIWLabel [14]
    Left = 417
    Top = 546
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
    FriendlyName = 'lblCertificati'
    Caption = 'Certificati'
    Enabled = True
  end
  object btnEsegui: TmedpIWImageButton [15]
    Left = 16
    Top = 495
    Width = 89
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
    OnClick = btnEseguiClick
    Cacheable = True
    FriendlyName = 'btnEsegui'
    ImageFile.URL = 'img/btnEsegui.png'
    medpDownloadButton = False
    Caption = 'Esegui'
  end
  object btnAnomalie: TmedpIWImageButton [16]
    Left = 111
    Top = 495
    Width = 100
    Height = 27
    Hint = 'Anomalie'
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
    ImageFile.Filename = 'img\btnAnomalie.png'
    medpDownloadButton = False
    Caption = 'Anomalie'
  end
  object edtPathFileDeleted: TmeIWEdit [17]
    Left = 16
    Top = 413
    Width = 393
    Height = 21
    Visible = False
    Css = 'width60chr'
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
    FriendlyName = 'edtPathFileDeleted'
    SubmitOnAsyncEvent = True
    TabOrder = 10
  end
  object btnVisualizzaFile: TmedpIWImageButton [18]
    Left = 490
    Top = 359
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
  object lbFileScelto: TmeIWLabel [19]
    Left = 16
    Top = 391
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
  object lblFileSceltoDescr: TmeIWLabel [20]
    Left = 127
    Top = 391
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
  object btnUpload: TmedpIWImageButton [21]
    Left = 436
    Top = 360
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
    ImageFile.Filename = 'img\btnUpload.png'
    medpDownloadButton = False
    Caption = 'Carica certificati'
  end
  object grdProfili: TmedpIWDBGrid [22]
    Left = 16
    Top = 201
    Width = 793
    Height = 81
    Css = 'grid'
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
    Caption = 'prova'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdProfiliRenderCell
    Summary = 'Certificati malattia'
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    ScrollToCurrentRow = False
    Columns = <>
    FooterRowCount = 0
    FriendlyName = 'grdProfili'
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
    OnAfterCaricaCDS = grdProfiliAfterCaricaCDS
  end
  object lblProfili: TmeIWLabel [23]
    Left = 373
    Top = 179
    Width = 136
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
    FriendlyName = 'lblProfili'
    Caption = 'Profili di importazione'
    Enabled = True
  end
  object btnDipEsclusi: TmeIWButton [24]
    Left = 217
    Top = 495
    Width = 120
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
    Caption = 'Dipendenti Esclusi'
    Enabled = False
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnDipEsclusi'
    TabOrder = 11
    OnClick = btnDipEsclusiClick
    medpDownloadButton = False
  end
  object fileUpload: TmeIWFileUploader [25]
    Left = 16
    Top = 360
    Width = 361
    Height = 25
    TabOrder = 12
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
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 512
    Top = 8
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 512
    Top = 56
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 656
    Top = 104
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 512
    Top = 104
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 656
    Top = 8
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 656
    Top = 56
  end
  object pmnAzioni: TPopupMenu
    Left = 728
    Top = 536
    object actScaricaInExcelPreview: TMenuItem
      Caption = 'Scarica in Excel'
      Hint = 'file_xls'
      OnClick = actScaricaInExcelPreviewClick
    end
    object actScaricaInCSVPreview: TMenuItem
      Caption = 'Scarica in CSV'
      Hint = 'file_csv'
      OnClick = actScaricaInCSVPreviewClick
    end
  end
end
