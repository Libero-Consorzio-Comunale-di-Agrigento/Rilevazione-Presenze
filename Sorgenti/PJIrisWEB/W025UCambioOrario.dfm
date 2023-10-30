inherited W025FCambioOrario: TW025FCambioOrario
  Tag = 430
  Width = 769
  Height = 298
  HelpType = htKeyword
  HelpKeyword = 'W025P0'
  ExplicitWidth = 769
  ExplicitHeight = 298
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
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
    DataSource = dsrT085
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 14
    ExplicitTop = 202
    ExplicitWidth = 697
    ExplicitHeight = 75
  end
  object lnkLegendaColoriGiorni: TmeIWLink [9]
    Left = 327
    Top = 160
    Width = 186
    Height = 17
    Css = 'link'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    HasTabOrder = True
    DoSubmitValidation = False
    FriendlyName = 'lnkLegendaColoriGiorni'
    OnClick = lnkLegendaColoriGiorniClick
    TabOrder = 4
    RawText = False
    Caption = 'Legenda tipologia giorni'
    medpDownloadButton = False
  end
  object lblModalitaRichiesta: TmeIWLabel [10]
    Left = 488
    Top = 114
    Width = 110
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
    NoWrap = True
    ForControl = rgpModalitaRichiesta
    HasTabOrder = False
    FriendlyName = 'lblModalitaRichiesta'
    Caption = 'Modalit'#224' richiesta'
    Enabled = True
  end
  object rgpModalitaRichiesta: TmeIWRadioGroup [11]
    Left = 488
    Top = 136
    Width = 301
    Height = 41
    Cursor = crDefault
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    OnClick = rgpModalitaRichiestaClick
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpModalitaRichiesta'
    ItemIndex = 0
    Items.Strings = (
      'Cambio orario nel giorno stesso'
      'Scambio orario con altro giorno')
    Layout = glVertical
    TabOrder = 7
    OnAsyncChange = rgpModalitaRichiestaAsyncChange
  end
  object dsrT085: TDataSource
    DataSet = cdsT085
    Left = 664
    Top = 220
  end
  object cdsT085: TClientDataSet
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
