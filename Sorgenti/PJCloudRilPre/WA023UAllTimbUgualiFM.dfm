inherited WA023FAllTimbUgualiFM: TWA023FAllTimbUgualiFM
  Width = 433
  Height = 360
  ExplicitWidth = 433
  ExplicitHeight = 360
  inherited IWFrameRegion: TIWRegion
    Width = 433
    Height = 360
    ExplicitWidth = 433
    ExplicitHeight = 360
    object lblPeriodo: TmeIWLabel
      Left = 24
      Top = 93
      Width = 47
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
      FriendlyName = 'lblPeriodo'
      Caption = 'Periodo'
      Enabled = True
    end
    object lblDal: TmeIWLabel
      Left = 24
      Top = 120
      Width = 19
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
      ForControl = edtDal
      HasTabOrder = False
      FriendlyName = 'lblDal'
      Caption = 'Dal'
      Enabled = True
    end
    object edtDal: TmeIWEdit
      Left = 57
      Top = 115
      Width = 55
      Height = 21
      Css = 'input_num_nn width2chr'
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
      FriendlyName = 'edtDal'
      MaxLength = 2
      SubmitOnAsyncEvent = True
      TabOrder = 0
      OnAsyncExit = edtDalAsyncExit
      Text = 'edtDal'
    end
    object lblAl: TmeIWLabel
      Left = 136
      Top = 120
      Width = 11
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
      ForControl = edtAl
      HasTabOrder = False
      FriendlyName = 'lblAl'
      Caption = 'al'
      Enabled = True
    end
    object edtAl: TmeIWEdit
      Left = 169
      Top = 115
      Width = 55
      Height = 21
      Css = 'input_num_nn width2chr'
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
      FriendlyName = 'edtAl'
      MaxLength = 2
      SubmitOnAsyncEvent = True
      TabOrder = 1
      OnAsyncExit = edtAlAsyncExit
      Text = 'edtAl'
    end
    object imbOK: TmedpIWImageButton
      Left = 304
      Top = 24
      Width = 105
      Height = 25
      Css = 'width20chr'
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
      OnClick = imbOKClick
      Cacheable = True
      FriendlyName = 'imbOK'
      ImageFile.Filename = 'img\btnConferma.png'
      medpDownloadButton = False
      Caption = 'Scambio automatico'
    end
    object imbCancel: TmedpIWImageButton
      Left = 304
      Top = 55
      Width = 105
      Height = 25
      Css = 'width20chr'
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
      OnClick = imbOKClick
      Cacheable = True
      FriendlyName = 'imbCancel'
      ImageFile.Filename = 'img\btnAnnulla.png'
      medpDownloadButton = False
      Caption = 'Chiudi'
    end
    object lblMese: TmeIWLabel
      Left = 240
      Top = 120
      Width = 80
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
      FriendlyName = 'lblMese'
      Caption = 'Mese e anno'
      Enabled = True
    end
    object lblTimbrature: TmeIWLabel
      Left = 24
      Top = 168
      Width = 148
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
      FriendlyName = 'lblTimbrature'
      Caption = 'Timbrature da allineare'
      Enabled = True
    end
    object grdTimbUguali: TmedpIWDBGrid
      Left = 24
      Top = 190
      Width = 385
      Height = 150
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
      Caption = 'grdTimbUguali'
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      OnRenderCell = grdTimbUgualiRenderCell
      Summary = 
        'Tabella contenente l'#39'elenco delle timbrature effettuate nello st' +
        'esso minuto da allinear'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      ScrollToCurrentRow = False
      Columns = <
        item
          Alignment = taCenter
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          DataField = 'AUTOMATICO'
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.Text = 'Automatico'
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end
        item
          Alignment = taCenter
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          Text = 'Data'
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          DataField = 'DATA'
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.Text = 'DATA'
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end
        item
          Alignment = taLeftJustify
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          DataField = 'D_ORA1'
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.Text = 'Timbratura 1'
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end
        item
          Alignment = taLeftJustify
          BGColor = clNone
          DoSubmitValidation = True
          Font.Color = clNone
          Font.Size = 10
          Font.Style = []
          Header = False
          Height = '0'
          ShowHint = True
          VAlign = vaMiddle
          Visible = True
          Width = '0'
          Wrap = False
          RawText = False
          Css = ''
          BlobCharLimit = 0
          CompareHighlight = hcNone
          DataField = 'D_ORA2'
          Title.Alignment = taCenter
          Title.BGColor = clNone
          Title.DoSubmitValidation = True
          Title.Font.Color = clNone
          Title.Font.Size = 10
          Title.Font.Style = []
          Title.Header = False
          Title.Height = '0'
          Title.ShowHint = True
          Title.Text = 'Timbratura 2'
          Title.VAlign = vaMiddle
          Title.Visible = True
          Title.Width = '0'
          Title.Wrap = False
          Title.RawText = True
        end>
      FooterRowCount = 0
      FriendlyName = 'grdTimbUguali'
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
      medpContextMenu = pmnAzioniTabella
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
    object btnAggiornaTabella: TmeIWButton
      Left = 320
      Top = 159
      Width = 89
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
      Caption = 'btnAggiornaTabella'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnAggiornaTabella'
      TabOrder = 2
      OnClick = btnAggiornaTabellaClick
      medpDownloadButton = False
    end
  end
  object pmnAzioniTabella: TPopupMenu
    Left = 280
    Top = 240
    object mnuScambiaTimbrature: TMenuItem
      Caption = 'Scambia timbrature'
      Hint = 'submit'
      OnClick = mnuScambiaTimbratureClick
    end
  end
end