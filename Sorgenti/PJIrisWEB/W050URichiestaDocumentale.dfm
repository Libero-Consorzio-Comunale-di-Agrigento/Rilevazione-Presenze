inherited W050FRichiestaDocumentale: TW050FRichiestaDocumentale
  DesignLeft = 8
  DesignTop = 8
  inherited grdRichieste: TmedpIWDBGrid
    Top = 201
    Caption = 'Richieste di inserimento nel documentale'
    OnRenderCell = grdRichiesteRenderCell
    Summary = 'Elenco delle richieste'
    DataSource = dsrT960
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitTop = 201
  end
  object lblInfo: TmeIWLabel [9]
    Left = 16
    Top = 316
    Width = 38
    Height = 16
    Css = 'informazione'
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
    FriendlyName = 'lblInfo'
    Caption = 'lblInfo'
    Enabled = True
  end
  inherited pmnTabella: TPopupMenu
    Left = 432
    Top = 232
  end
  object cdsT960: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 503
    Top = 232
  end
  object dsrT960: TDataSource
    DataSet = cdsT960
    Left = 567
    Top = 233
  end
end
