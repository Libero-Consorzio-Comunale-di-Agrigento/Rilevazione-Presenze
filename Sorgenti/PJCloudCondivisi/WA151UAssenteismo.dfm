inherited WA151FAssenteismo: TWA151FAssenteismo
  Tag = 197
  Height = 464
  Title = '(WA151) Assenteismo e Forza Lavoro'
  ExplicitHeight = 464
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  object lblDaData: TmeIWLabel [15]
    Left = 296
    Top = 365
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
    FriendlyName = 'lblDaData'
    Caption = 'Da data'
    Enabled = True
  end
  object edtDaData: TmeIWEdit [16]
    Left = 296
    Top = 387
    Width = 78
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDaData'
    SubmitOnAsyncEvent = True
    TabOrder = 6
  end
  object lblAData: TmeIWLabel [17]
    Left = 380
    Top = 365
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
    FriendlyName = 'lblAData'
    Caption = 'A data'
    Enabled = True
  end
  object edtAData: TmeIWEdit [18]
    Left = 380
    Top = 387
    Width = 78
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtAData'
    SubmitOnAsyncEvent = True
    TabOrder = 8
  end
  object grdComandi: TmeIWGrid [19]
    Left = 16
    Top = 358
    Width = 300
    Height = 23
    Css = 'medpToolBar medpNoMarginLeft  medpToolBarActNoBorder '
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
    BorderStyle = tfVoid
    Caption = 'grdComandi'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdComandi'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
  end
  object actlstComandi: TActionList
    Left = 234
    Top = 357
    object actLblDal: TAction
      Category = 'AzioniDal'
      Caption = 'actLblDal'
    end
    object actEdtDal: TAction
      Category = 'AzioniDal'
      Caption = 'actEdtDal'
    end
    object actLblAl: TAction
      Category = 'AzioniAl'
      Caption = 'actLblAl'
    end
    object actEdtAl: TAction
      Category = 'AzioniAl'
      Caption = 'actEdtAl'
    end
    object actTabella: TAction
      Category = 'Azioni'
      Caption = 'btnTabella'
      Hint = 'Genera tabella'
      OnExecute = actTabellaExecute
    end
    object actEsegui: TAction
      Category = 'Azioni'
      Caption = 'btnEsegui'
      Hint = 'Esegui'
      OnExecute = actEseguiExecute
    end
    object actAnomalie: TAction
      Category = 'Azioni'
      Caption = 'btnAnomalie'
      Hint = 'Anomalie'
      OnExecute = actAnomalieExecute
    end
    object actInfo: TAction
      Category = 'Azioni'
      Caption = 'btnInfo'
      Hint = 'Informazioni'
      OnExecute = actAnomalieExecute
    end
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 368
    Top = 224
  end
end
