inherited WR100FBase: TWR100FBase
  Width = 688
  Height = 420
  ExplicitWidth = 688
  ExplicitHeight = 420
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 6
  end
  object grdStatusBar: TmedpIWStatusBar [7]
    Left = 16
    Top = 240
    Width = 300
    Height = 25
    Css = 'medpStatusBar'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfDefault
    CellPadding = 2
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdStatusBar'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
    SeparatorCss = 'medpStatusBarSep'
  end
  object btnShowElabError: TmeIWButton [8]
    Left = 40
    Top = 205
    Width = 289
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
    Caption = 'pulsante nascosto per gestione errori elab'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnShowElabError'
    TabOrder = 4
    OnClick = btnShowElabErrorClick
    medpDownloadButton = False
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    OnBeforeProcess = TemplateProcessorBeforeProcess
  end
  object AJNInizioElaborazione: TIWAJAXNotifier
    OnNotify = AJNInizioElaborazioneNotify
    Left = 496
    Top = 24
  end
  object AJNElaboraElemento: TIWAJAXNotifier
    OnNotify = AJNElaboraElementoNotify
    Left = 496
    Top = 80
  end
  object AJNMessaggioElaborazione: TIWAJAXNotifier
    OnNotify = AJNMessaggioElaborazioneNotify
    Left = 496
    Top = 336
  end
  object AJNElementoSuccessivo: TIWAJAXNotifier
    OnNotify = AJNElementoSuccessivoNotify
    Left = 496
    Top = 144
  end
  object AJNFineCicloElaborazione: TIWAJAXNotifier
    OnNotify = AJNFineCicloElaborazioneNotify
    Left = 496
    Top = 200
  end
  object AJNElaborazioneTerminata: TIWAJAXNotifier
    OnNotify = AJNElaborazioneTerminataNotify
    Left = 496
    Top = 264
  end
  object AJNMsgElaborazione: TIWAJAXNotifier
    OnNotify = AJNMsgElaborazioneNotify
    Left = 609
    Top = 24
  end
end
