inherited W048FCertificazioni: TW048FCertificazioni
  Tag = 455
  Width = 706
  Height = 397
  HelpType = htKeyword
  HelpKeyword = 'W048P0'
  JavaScript.Strings = (
    '$(document).ready(function(){'
    
      '$("#TBLGRDDATI").find("tr:nth-child(2)").find("td:first").attr("' +
      'colspan", "2");'
    
      '$("#TBLGRDDATI").find("tr:nth-child(2)").find("td:nth-child(2)")' +
      '.remove();'
    
      '$("#TBLGRDDATI").find("tr:nth-child(3)").find("td:first").attr("' +
      'colspan", "2");'
    
      '$("#TBLGRDDATI").find("tr:nth-child(3)").find("td:nth-child(2)")' +
      '.remove();'
    '});')
  ExplicitWidth = 706
  ExplicitHeight = 397
  DesignLeft = 8
  DesignTop = 8
  inherited lnkChiudiSchede: TmeIWLink
    Left = 19
    ExplicitLeft = 19
  end
  inherited grdRichieste: TmedpIWDBGrid
    Top = 168
    Width = 666
    Height = 65
    ExtraTagParams.Strings = (
      
        'summary=griglia per la visualizzazione e cancellazione delle ric' +
        'hieste di modifica timbrature')
    StyleRenderOptions.RenderPosition = True
    StyleRenderOptions.RenderFont = True
    StyleRenderOptions.RenderZIndex = True
    StyleRenderOptions.RenderAbsolute = True
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Scheda informativa'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrSG230
    RowClick = False
    medpBrowse = False
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitTop = 168
    ExplicitWidth = 666
    ExplicitHeight = 65
  end
  object lblFiltroModello: TmeIWLabel [9]
    Left = 512
    Top = 18
    Width = 85
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
    HasTabOrder = False
    FriendlyName = 'lblFiltroModello'
    Caption = 'Filtro modello'
    Enabled = True
  end
  object cmbFiltroModello: TmeIWComboBox [10]
    Left = 512
    Top = 40
    Width = 121
    Height = 21
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
    UseSize = False
    TabOrder = 6
    ItemIndex = -1
    FriendlyName = 'cmbFiltroModello'
    NoSelectionText = '-- No Selection --'
  end
  object rgDettaglio: TmeIWRegion [11]
    Left = 16
    Top = 249
    Width = 666
    Height = 136
    RenderInvisibleControls = False
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = tpDettaglio
    object grdDati: TmeIWGrid
      Left = 3
      Top = 20
      Width = 660
      Height = 61
      Css = 'grid gridTrasparente'
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
      CellPadding = 0
      CellSpacing = 0
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FrameBuffer = 40
      Lines = tlAll
      Summary = 'Dati personalizzati associati alla certificazione'
      UseFrame = False
      UseSize = False
      HeaderRowCount = 0
      CellRenderOptions = []
      FriendlyName = 'grdDati'
      ColumnCount = 2
      RowCount = 1
      ShowEmptyCells = True
      ShowInvisibleRows = True
      ScrollToCurrentRow = False
    end
    object lblDescCert: TmeIWLabel
      Left = 311
      Top = 3
      Width = 70
      Height = 16
      Css = 'tblCaption'
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
      FriendlyName = 'lblDescCert'
      Caption = 'lblDescCert'
      RawText = True
      Enabled = True
    end
  end
  inherited pmnTabella: TPopupMenu
    Left = 397
    Top = 176
  end
  object dsrSG230: TDataSource
    DataSet = cdsSG230
    Left = 523
    Top = 177
  end
  object cdsSG230: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 587
    Top = 177
  end
  object tpDettaglio: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W048FDettaglioRG.html'
    RenderStyles = False
    Left = 616
    Top = 273
  end
end
