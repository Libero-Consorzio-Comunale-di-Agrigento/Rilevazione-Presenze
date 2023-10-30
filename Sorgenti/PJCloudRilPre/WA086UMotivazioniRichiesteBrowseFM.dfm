inherited WA086FMotivazioniRichiesteBrowseFM: TWA086FMotivazioniRichiesteBrowseFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Elenco delle motivazioni relative alla tipologia selezionata'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
      OnmedpStatoChange = grdTabellamedpStatoChange
    end
    object cmbTipo: TmeIWComboBox
      Left = 304
      Top = 32
      Width = 121
      Height = 21
      Cursor = crAuto
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FocusColor = clNone
      AutoHideOnMenuActivation = False
      ItemsHaveValues = True
      NoSelectionText = '-- No Selection --'
      Required = False
      RequireSelection = True
      ScriptEvents = <>
      OnChange = cmbTipoChange
      UseSize = False
      Style = stNormal
      ButtonColor = clBtnFace
      Editable = True
      NonEditableAsLabel = True
      SubmitOnAsyncEvent = True
      TabOrder = 0
      ItemIndex = -1
      Sorted = False
      FriendlyName = 'cmbTipo'
    end
    object lblTipo: TmeIWLabel
      Left = 208
      Top = 32
      Width = 59
      Height = 16
      Cursor = crAuto
      Css = 'intestazione'
      ParentShowHint = False
      ShowHint = True
      ZIndex = 0
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      Alignment = taLeftJustify
      BGColor = clNone
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      NoWrap = False
      ConvertSpaces = False
      ForControl = cmbTipo
      HasTabOrder = False
      FriendlyName = 'lblTipo'
      Caption = 'Elementi:'
      RawText = False
      Enabled = True
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA086FMotivazioniRichiesteBrowseFM.html'
  end
end
