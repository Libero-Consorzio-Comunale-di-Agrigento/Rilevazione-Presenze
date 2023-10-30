inherited WA188FCampiAnagrafe: TWA188FCampiAnagrafe
  Tag = 115
  Height = 423
  Title = '(WA188) Ridefinizione campi anagrafici'
  ExplicitHeight = 423
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  object btnValoriDefault: TmeIWButton [15]
    Left = 25
    Top = 352
    Width = 152
    Height = 25
    Cursor = crAuto
    Css = 'pulsante'
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
    Caption = 'Assegna valori di default'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnValoriDefault'
    ScriptEvents = <>
    TabOrder = 6
    OnClick = btnValoriDefaultClick
    medpDownloadButton = False
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Top = 320
  end
  inherited actlstNavigatorBar: TActionList
    Left = 384
    Top = 184
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actNuovo: TAction
      Visible = False
    end
    inherited actElimina: TAction
      Visible = False
    end
  end
end
