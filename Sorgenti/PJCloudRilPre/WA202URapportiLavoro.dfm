inherited WA202FRapportiLavoro: TWA202FRapportiLavoro
  Tag = 161
  Width = 997
  Height = 589
  ExplicitWidth = 997
  ExplicitHeight = 589
  DesignLeft = 8
  DesignTop = 8
  inherited grdTabControl: TmedpIWTabControl
    OnTabControlChanging = grdTabControlTabControlChanging
  end
  object grdRiepilogo: TmeIWGrid [16]
    Left = 16
    Top = 440
    Width = 300
    Height = 43
    Css = 'grid'
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
    Caption = 'Riepilogo'
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
    FriendlyName = 'grdRiepilogo'
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
  object DSRestMetaDataProvider1: TDSRestMetaDataProvider
    Left = 184
    Top = 496
  end
end
