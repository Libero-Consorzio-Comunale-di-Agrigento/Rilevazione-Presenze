inherited WA180FOperatori: TWA180FOperatori
  Tag = 83
  Width = 742
  Height = 562
  Title = '(WA180) Operatori'
  ExplicitWidth = 742
  ExplicitHeight = 562
  DesignLeft = 8
  DesignTop = 8
  inherited grdTabControl: TmedpIWTabControl
    Top = 328
    ExplicitTop = 328
  end
  object grdWA180ToolBar: TmeIWGrid [15]
    Left = 17
    Top = 275
    Width = 544
    Height = 31
    Css = 'medpToolBar'
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
    CellPadding = 0
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
    FriendlyName = 'grdNavigatorBar'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = False
    ScrollToCurrentRow = False
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Left = 215
  end
  object actlstWA180ToolBar: TActionList
    Left = 57
    Top = 254
    object actAziende: TAction
      Caption = 'btnAziende'
      HelpKeyword = '84'
      Hint = 'Aziende'
      OnExecute = actWA180ToolBarExecute
    end
    object actPermessi: TAction
      Tag = 1
      Caption = 'btnPermessi'
      HelpKeyword = '85'
      Hint = 'Permessi'
      OnExecute = actWA180ToolBarExecute
    end
    object actFiltroAnagrafe: TAction
      Tag = 2
      Caption = 'btnFiltroAnagrafe'
      HelpKeyword = '86'
      Hint = 'Filtro anagrafe'
      OnExecute = actWA180ToolBarExecute
    end
    object actFiltroFunzioni: TAction
      Tag = 3
      Caption = 'btnFiltroFunzioni'
      HelpKeyword = '87'
      Hint = 'Filtro funzioni'
      OnExecute = actWA180ToolBarExecute
    end
    object actFiltroDizionario: TAction
      Tag = 4
      Caption = 'btnFiltroDizionario'
      HelpKeyword = '88'
      Hint = 'Filtro dizionario'
      OnExecute = actWA180ToolBarExecute
    end
    object actLoginDipendenti: TAction
      Tag = 5
      Caption = 'btnLoginDipendenti'
      HelpKeyword = '209'
      Hint = 'Login dipendenti'
      OnExecute = actWA180ToolBarExecute
    end
    object actAccessi: TAction
      Tag = 6
      Caption = 'btnAccessi'
      HelpKeyword = '90'
      Hint = 'Accessi'
      OnExecute = actWA180ToolBarExecute
    end
  end
end
