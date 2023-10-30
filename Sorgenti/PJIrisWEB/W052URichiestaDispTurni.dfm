inherited W052FRichiestaDispTurni: TW052FRichiestaDispTurni
  Tag = 462
  Width = 769
  Height = 298
  HelpType = htKeyword
  HelpKeyword = 'W052P0'
  ExplicitWidth = 769
  ExplicitHeight = 298
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 4
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 14
    Top = 202
    Width = 697
    Height = 75
    ExtraTagParams.Strings = (
      'summary=tabella contenente le richieste di cambio orario')
    StyleRenderOptions.RenderPosition = True
    StyleRenderOptions.RenderFont = True
    StyleRenderOptions.RenderZIndex = True
    StyleRenderOptions.RenderAbsolute = True
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Richieste di cambio orario'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT600
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 14
    ExplicitTop = 202
    ExplicitWidth = 697
    ExplicitHeight = 75
  end
  object dsrT600: TDataSource
    DataSet = cdsT600
    Left = 664
    Top = 220
  end
  object cdsT600: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 608
    Top = 220
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 624
    Top = 24
  end
end
