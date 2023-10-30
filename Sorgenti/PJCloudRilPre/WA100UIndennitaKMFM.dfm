inherited WA100FIndennitaKMFM: TWA100FIndennitaKMFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Elenco indennit'#224' chilometriche'
      OnDataSet2Componenti = grdTabellaDataSet2Componenti
      OnComponenti2DataSet = grdTabellaComponenti2DataSet
    end
    object lblTotaleB: TmeIWLabel
      Left = 273
      Top = 405
      Width = 62
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
      HasTabOrder = False
      FriendlyName = 'lblTotaleB'
      Caption = 'Totale (B)'
      RawText = False
      Enabled = True
    end
    object dedtKmTotaliIndennitaKm: TmeIWDBEdit
      Left = 401
      Top = 407
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width5chr medpCalcolati'
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
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'dedtKmTotaliIndennitaKm'
      MaxLength = 0
      ReadOnly = True
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 0
      AutoEditable = True
      DataField = 'TotaleKmIndennita'
      PasswordPrompt = False
    end
    object dedtImportiTotaliIndennitaKm: TmeIWDBEdit
      Left = 528
      Top = 407
      Width = 121
      Height = 21
      Cursor = crAuto
      Css = 'width5chr medpCalcolati'
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
      FocusColor = clNone
      Editable = True
      NonEditableAsLabel = False
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'dedtImportiTotaliIndennitaKm'
      MaxLength = 0
      ReadOnly = True
      Required = False
      ScriptEvents = <>
      SubmitOnAsyncEvent = True
      TabOrder = 1
      AutoEditable = True
      DataField = 'TotaleImportiKmIndennita'
      PasswordPrompt = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA100FIndennitaKMFM.html'
  end
  object pmnTipoIndennita: TPopupMenu
    Left = 264
    Top = 48
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      Hint = 'submit'
      OnClick = Accedi1Click
    end
  end
end
