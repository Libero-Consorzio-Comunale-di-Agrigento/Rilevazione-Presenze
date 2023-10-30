inherited WA126FBloccoRiepiloghiBrowseFM: TWA126FBloccoRiepiloghiBrowseFM
  inherited IWFrameRegion: TIWRegion
    object chkDipendentiSelezionati: TmeIWCheckBox
      Left = 30
      Top = 45
      Width = 177
      Height = 21
      Cursor = crDefault
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
      Caption = 'Solo dipendenti selezionati'
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      SubmitOnAsyncEvent = True
      ScriptEvents = <>
      Style = stNormal
      TabOrder = 0
      OnClick = chkDipendentiSelezionatiClick
      Checked = False
      FriendlyName = 'chkDipendentiSelezionati'
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA126FBloccoRiepiloghiBrowseFM.html'
    Left = 576
    Top = 16
  end
  inherited JQuery: TIWJQueryWidget
    Left = 496
    Top = 16
  end
end
