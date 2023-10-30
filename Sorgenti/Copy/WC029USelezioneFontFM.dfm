inherited WC029FSelezioneFontFM: TWC029FSelezioneFontFM
  Width = 446
  Height = 274
  ExplicitWidth = 446
  ExplicitHeight = 274
  inherited IWFrameRegion: TIWRegion
    Width = 446
    Height = 274
    ExplicitWidth = 446
    ExplicitHeight = 274
    object cmbFonts: TmeIWComboBox
      Left = 24
      Top = 94
      Width = 121
      Height = 21
      ExtraTagParams.Strings = (
        'height:2em')
      Css = 'width20chr height2em medpNoMarginLeft'
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
      Required = True
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 0
      ItemIndex = -1
      FriendlyName = 'cmbFonts'
      NoSelectionText = ' '
    end
    object btnChiudi: TmeIWButton
      Left = 237
      Top = 237
      Width = 75
      Height = 25
      Visible = False
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
      TabOrder = 1
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object btnConferma: TmeIWButton
      Left = 318
      Top = 237
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
      TabOrder = 2
      OnClick = btnChiudiClick
      medpDownloadButton = False
    end
    object lblFonts: TmeIWLabel
      Left = 24
      Top = 72
      Width = 41
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
      FriendlyName = 'lblFonts'
      Caption = 'Nome:'
      Enabled = True
    end
    object lblDimensione: TmeIWLabel
      Left = 151
      Top = 72
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
      FriendlyName = 'lblDimensione'
      Caption = 'Punti:'
      Enabled = True
    end
    object chkGrassetto: TmeIWCheckBox
      Left = 40
      Top = 136
      Width = 121
      Height = 21
      Css = 'intestazione fontbold'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Grassetto'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 3
      Checked = False
      FriendlyName = 'chkGrassetto'
    end
    object chkCorsivo: TmeIWCheckBox
      Left = 40
      Top = 163
      Width = 81
      Height = 21
      Css = 'intestazione fontitalic'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Corsivo'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 4
      Checked = False
      FriendlyName = 'chkCorsivo'
    end
    object chkSottolineato: TmeIWCheckBox
      Left = 127
      Top = 136
      Width = 96
      Height = 21
      Css = 'intestazione fontunderline'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Sottolineato'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 5
      Checked = False
      FriendlyName = 'chkSottolineato'
    end
    object chkBarrato: TmeIWCheckBox
      Left = 127
      Top = 162
      Width = 96
      Height = 21
      Css = 'intestazione fontlinethrough'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      Caption = 'Barrato'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      Style = stNormal
      TabOrder = 6
      Checked = False
      FriendlyName = 'chkBarrato'
    end
    object lblColore: TmeIWLabel
      Left = 240
      Top = 72
      Width = 46
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
      FriendlyName = 'lblColore:'
      Caption = 'Colore:'
      Enabled = True
    end
    object cmbColore: TmeIWComboBox
      Left = 240
      Top = 94
      Width = 97
      Height = 21
      Css = 'width18chr height2em'
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
      NonEditableAsLabel = True
      TabOrder = 7
      ItemIndex = -1
      FriendlyName = 'cmbColore'
      NoSelectionText = '-- No Selection --'
    end
    object lblErrore: TmeIWLabel
      Left = 24
      Top = 206
      Width = 53
      Height = 16
      Css = 'segnalazione'
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
      FriendlyName = 'lblErrore'
      Caption = 'lblErrore'
      Enabled = True
    end
    object cmbDimensione: TmeIWComboBox
      Left = 151
      Top = 94
      Width = 65
      Height = 21
      Css = 'width6chr height2em'
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
      UseSize = False
      NonEditableAsLabel = True
      TabOrder = 8
      ItemIndex = -1
      FriendlyName = 'cmbDimensione'
      NoSelectionText = '-- No Selection --'
    end
  end
end
