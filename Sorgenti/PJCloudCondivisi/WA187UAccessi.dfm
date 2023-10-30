inherited WA187FAccessi: TWA187FAccessi
  Tag = 90
  Width = 742
  Height = 562
  Title = '(WA187) Accessi'
  ExplicitWidth = 742
  ExplicitHeight = 562
  DesignLeft = 8
  DesignTop = 8
  inherited grdDetailTabControl: TmedpIWTabControl
    Left = 17
    Top = 369
    ExplicitLeft = 17
    ExplicitTop = 369
  end
  object lblAccessoUtenti: TmeIWLabel [16]
    Left = 384
    Top = 289
    Width = 90
    Height = 16
    Cursor = crAuto
    Css = 'intestazione font_grassetto'
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
    FriendlyName = 'lblAccessoUtenti'
    Caption = 'Accesso utenti'
    RawText = False
    Enabled = True
  end
  object lblSessioniAttive: TmeIWLabel [17]
    Left = 384
    Top = 311
    Width = 90
    Height = 16
    Cursor = crAuto
    Css = 'intestazione font_grassetto'
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
    FriendlyName = 'lblAccessoUtenti'
    Caption = 'Sessioni attive'
    RawText = False
    Enabled = True
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 215
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actNuovo: TAction
      Visible = False
    end
    inherited actElimina: TAction
      Visible = False
    end
    object actBloccaAccessi: TAction
      Tag = 17
      Category = 'Accessi'
      Caption = 'btnBloccaAccessi'
      Hint = 'Blocca accessi'
      OnExecute = actBloccaAccessiExecute
    end
    object actSbloccaAccessi: TAction
      Tag = 18
      Category = 'Accessi'
      Caption = 'btnSbloccaAccessi'
      Hint = 'Sblocca accessi'
      OnExecute = actSbloccaAccessiExecute
    end
  end
end
