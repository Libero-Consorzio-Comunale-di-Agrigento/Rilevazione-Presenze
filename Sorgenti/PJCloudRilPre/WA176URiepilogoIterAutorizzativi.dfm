inherited WA176FRiepilogoIterAutorizzativi: TWA176FRiepilogoIterAutorizzativi
  Tag = 214
  Height = 597
  ExplicitHeight = 597
  DesignLeft = 8
  DesignTop = 8
  inherited btnShowElabError: TmeIWButton
    Left = 42
    Top = 209
    ExplicitLeft = 42
    ExplicitTop = 209
  end
  object lblTipoIter: TmeIWLabel [15]
    Left = 20
    Top = 288
    Width = 111
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
    FriendlyName = 'lblTipoIter'
    Caption = 'Iter autorizzativo:'
    Enabled = True
  end
  object lblDataDa: TmeIWLabel [16]
    Left = 16
    Top = 383
    Width = 19
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
    FriendlyName = 'lblDataDa'
    Caption = 'Dal'
    Enabled = True
  end
  object lblDataA: TmeIWLabel [17]
    Left = 182
    Top = 383
    Width = 11
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
    FriendlyName = 'lblDataA'
    Caption = 'al'
    Enabled = True
  end
  object cmbTipoIter: TmeIWComboBox [18]
    Left = 89
    Top = 288
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
    OnChange = cmbTipoIterChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 7
    ItemIndex = -1
    FriendlyName = 'cmbTipoIter'
    NoSelectionText = '-- No Selection --'
  end
  object edtDataDa: TmeIWEdit [19]
    Left = 58
    Top = 383
    Width = 73
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDataDa'
    SubmitOnAsyncEvent = True
    TabOrder = 8
    OnAsyncChange = edtDataAsyncChange
    Text = 'edtDataDa'
  end
  object edtDataA: TmeIWEdit [20]
    Left = 199
    Top = 383
    Width = 90
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtDataA'
    SubmitOnAsyncEvent = True
    TabOrder = 9
    OnAsyncChange = edtDataAsyncChange
    Text = 'edtDataA'
  end
  object rgpAllegato: TmeIWRadioGroup [21]
    Left = 22
    Top = 512
    Width = 236
    Height = 32
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
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpAllegato'
    ItemIndex = 0
    Items.Strings = (
      'Tutti '
      'Con allegato '
      'Senza allegato ')
    Layout = glHorizontal
    TabOrder = 10
    OnAsyncChange = rgpAllegatoAsyncChange
  end
  object rgpCondizAllegato: TmeIWRadioGroup [22]
    Left = 264
    Top = 518
    Width = 500
    Height = 26
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
    SubmitOnAsyncEvent = True
    RawText = False
    Editable = True
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'rgpCondizAllegato'
    ItemIndex = 0
    Items.Strings = (
      'Tutti '
      'Allegati non previsti '
      'Allegati facoltativi '
      'Allegati obbligatori ')
    Layout = glHorizontal
    TabOrder = 11
    OnAsyncChange = rgpAllegatoAsyncChange
  end
  object lblAllegato: TmeIWLabel [23]
    Left = 25
    Top = 490
    Width = 50
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
    FriendlyName = 'lblAllegato'
    Caption = 'Allegato'
    Enabled = True
  end
  object lblCondizAllegato: TmeIWLabel [24]
    Left = 232
    Top = 496
    Width = 122
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
    FriendlyName = 'meIWLabel1'
    Caption = 'Condizione allegato'
    Enabled = True
  end
  object lblCausale: TmeIWLabel [25]
    Left = 20
    Top = 315
    Width = 55
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
    FriendlyName = 'lblCausale'
    Caption = 'Causale:'
    Enabled = True
  end
  object cmbCausale: TMedpIWMultiColumnComboBox [26]
    Left = 89
    Top = 315
    Width = 121
    Height = 21
    Css = 'medpMultiColumnCombo'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'cmbCausale'
    SubmitOnAsyncEvent = True
    TabOrder = 12
    OnAsyncChange = cmbCausaleAsyncChange
    PopUpHeight = 15
    PopUpWidth = 0
    Text = ''
    ColCount = 2
    Items = <>
    ColumnTitles.Visible = False
    medpAutoResetItems = True
    CssInputText = 'medpMultiColumnComboBoxInput'
    LookupColumn = 0
    CodeColumn = 0
  end
  object lblDescCausale: TmeIWLabel [27]
    Left = 216
    Top = 320
    Width = 35
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
    FriendlyName = 'lblDescCausale'
    Caption = '        '
    Enabled = True
  end
  object lblDataInserimento: TmeIWLabel [28]
    Left = 25
    Top = 361
    Width = 213
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
    FriendlyName = 'lblDataInserimento'
    Caption = 'Data di inserimento della richiesta'
    Enabled = True
  end
  object lblPeriodoRichiesto: TmeIWLabel [29]
    Left = 25
    Top = 423
    Width = 173
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
    FriendlyName = 'lblPeriodoRichiesto'
    Caption = 'Data dell'#39'elemento richiesto'
    Enabled = True
  end
  object lblPeriodoDa: TmeIWLabel [30]
    Left = 16
    Top = 445
    Width = 19
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
    FriendlyName = 'lblPeriodoDa'
    Caption = 'Dal'
    Enabled = True
  end
  object lblPeriodoA: TmeIWLabel [31]
    Left = 182
    Top = 445
    Width = 11
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
    FriendlyName = 'lblPeriodoA'
    Caption = 'al'
    Enabled = True
  end
  object edtPeriodoDa: TmeIWEdit [32]
    Left = 58
    Top = 442
    Width = 73
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtPeriodoDa'
    SubmitOnAsyncEvent = True
    TabOrder = 13
    OnAsyncChange = edtDataAsyncChange
    Text = 'edtDataDa'
  end
  object edtPeriodoA: TmeIWEdit [33]
    Left = 199
    Top = 442
    Width = 90
    Height = 21
    Css = 'input_data_dmy'
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
    FriendlyName = 'edtPeriodoA'
    SubmitOnAsyncEvent = True
    TabOrder = 14
    OnAsyncChange = edtDataAsyncChange
    Text = 'edtDataA'
  end
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actNuovo: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actElimina: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
  end
end
