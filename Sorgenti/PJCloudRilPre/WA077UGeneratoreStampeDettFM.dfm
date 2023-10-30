inherited WA077FGeneratoreStampeDettFM: TWA077FGeneratoreStampeDettFM
  Width = 826
  Height = 1165
  ExplicitWidth = 826
  ExplicitHeight = 1165
  inherited IWFrameRegion: TIWRegion
    Width = 826
    Height = 1165
    ExplicitWidth = 826
    ExplicitHeight = 1165
    inherited cmbSerbatoi: TmeIWComboBox
      NoSelectionText = '-- No Selection --'
    end
    inherited lstDatiSerbatoio: TmeIWListbox
      Css = ''
      NoSelectionText = '-- No Selection --'
    end
    inherited edtRicercaTesto: TmeIWEdit
      TabOrder = 47
    end
    inherited WR003GeneraleRG: TmeIWRegion
      inherited dcmbQueryIntestazione: TmeIWDBLookupComboBox
        NoSelectionText = ' '
      end
      inherited dcmbQueryFineStampa: TmeIWDBLookupComboBox
        NoSelectionText = ' '
      end
      inherited lblGeneraTabella: TmeIWLabel
        Left = 31
        Top = 267
        ExplicitLeft = 31
        ExplicitTop = 267
      end
    end
    inherited WR003CodiciSerbatoioRG: TmeIWRegion
      object chklstIndPresenza: TmeTIWCheckListBox
        Left = 274
        Top = 14
        Width = 15
        Height = 99
        Css = 'prewrapchecklistbox'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chklstIndPresenza'
        SubmitOnAsyncEvent = True
        TabOrder = 39
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstPresenza: TmeTIWCheckListBox
        Left = 295
        Top = 14
        Width = 15
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 41
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstAssenze: TmeTIWCheckListBox
        Left = 316
        Top = 14
        Width = 15
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 44
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstRimborsi: TmeTIWCheckListBox
        Left = 337
        Top = 14
        Width = 16
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 45
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstVociPaghe: TmeTIWCheckListBox
        Left = 359
        Top = 14
        Width = 16
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 51
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstCorsiFormazione: TmeTIWCheckListBox
        Left = 381
        Top = 14
        Width = 16
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 53
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstIscrizioniSindacali: TmeTIWCheckListBox
        Left = 403
        Top = 14
        Width = 16
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 55
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstPartecipazioniSindacali: TmeTIWCheckListBox
        Left = 425
        Top = 14
        Width = 16
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 56
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object chklstPermessiSindacali: TmeTIWCheckListBox
        Left = 447
        Top = 14
        Width = 16
        Height = 99
        Css = 'prewrapchecklistbox fontcourier'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderStatus = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        BGColor = clWebWHITE
        Font.Color = clNone
        Font.FontName = 'Courier'
        Font.Size = 10
        Font.Style = []
        FriendlyName = 'chkgrpValori'
        SubmitOnAsyncEvent = True
        TabOrder = 57
        BorderColor = clNone
        BorderWidth = 0
        BGColorTo = clNone
        BGColorGradientDirection = gdHorizontal
        CheckAllBox = False
        CheckAllHelp = htNone
        CheckAllText = 'Check All'
        UnCheckAllText = 'UnCheck All'
      end
      object lblRecapitoSindacato: TmeIWLabel
        Left = 55
        Top = 16
        Width = 88
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
        FriendlyName = 'lblRecapitoSindacato'
        Caption = 'Tipo recapito:'
        Enabled = True
      end
      object cmbRecapitoSindacato11: TMedpIWMultiColumnComboBox
        Left = 33
        Top = 38
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
        FriendlyName = 'cmbRecapitoSindacato_11'
        SubmitOnAsyncEvent = True
        TabOrder = 58
        PopUpHeight = 15
        PopUpWidth = 0
        Text = ''
        ColCount = 1
        Items = <>
        ColumnTitles.Visible = False
        medpAutoResetItems = False
        CssInputText = 'width10chr'
        LookupColumn = 0
        CodeColumn = 0
      end
      object cmbRecapitoSindacato12: TMedpIWMultiColumnComboBox
        Left = 33
        Top = 65
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
        FriendlyName = 'cmbRecapitoSindacato12'
        SubmitOnAsyncEvent = True
        TabOrder = 59
        PopUpHeight = 15
        PopUpWidth = 0
        Text = ''
        ColCount = 1
        Items = <>
        ColumnTitles.Visible = False
        medpAutoResetItems = False
        CssInputText = 'width10chr'
        LookupColumn = 0
        CodeColumn = 0
      end
      object cmbRecapitoSindacato13: TMedpIWMultiColumnComboBox
        Left = 33
        Top = 92
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
        FriendlyName = 'cmbRecapitoSindacato13'
        SubmitOnAsyncEvent = True
        TabOrder = 60
        PopUpHeight = 15
        PopUpWidth = 0
        Text = ''
        ColCount = 1
        Items = <>
        ColumnTitles.Visible = False
        medpAutoResetItems = False
        CssInputText = 'width10chr'
        LookupColumn = 0
        CodeColumn = 0
      end
    end
    inherited WR003FiltroSerbatoioRG: TmeIWRegion
      inherited chkFiltroEsclusivo: TmeIWCheckBox
        TabOrder = 40
      end
      inherited cmbDatoDalAl: TMedpIWMultiColumnComboBox
        TabOrder = 42
      end
      inherited memFiltro: TmeIWMemo
        Top = 68
        TabOrder = 43
        ExplicitTop = 68
      end
      inherited memRiepilogoFiltri: TmeIWMemo
        Top = 112
        TabOrder = 49
        ExplicitTop = 112
      end
      inherited edtFiltroCaretPosition: TmeIWEdit
        Top = 136
        TabOrder = 52
        ExplicitTop = 136
      end
      inherited edtAlleOre: TmeIWEdit
        Left = 256
        ExplicitLeft = 256
      end
      inherited lblAlleOre: TmeIWLabel
        Left = 228
        Width = 30
        Caption = ' alle '
        ExplicitLeft = 228
        ExplicitWidth = 30
      end
      inherited edtDalleOre: TmeIWEdit
        Left = 153
        TabOrder = 50
        ExplicitLeft = 153
      end
      inherited lblDalleOre: TmeIWLabel
        Left = 30
        Width = 127
        Caption = 'Conteggi orari dalle '
        ExplicitLeft = 30
        ExplicitWidth = 127
      end
      object chkConteggiGGIter: TmeIWCheckBox
        Left = 320
        Top = 40
        Width = 193
        Height = 21
        Css = 'intestazione'
        RenderSize = False
        StyleRenderOptions.RenderSize = False
        StyleRenderOptions.RenderPosition = False
        StyleRenderOptions.RenderFont = False
        StyleRenderOptions.RenderZIndex = False
        StyleRenderOptions.RenderAbsolute = False
        StyleRenderOptions.RenderPadding = False
        StyleRenderOptions.RenderBorder = False
        Caption = 'Considera richieste degli iter'
        Editable = True
        Font.Color = clNone
        Font.Enabled = False
        Font.Size = 10
        Font.Style = []
        SubmitOnAsyncEvent = True
        Style = stNormal
        TabOrder = 61
        Checked = False
        FriendlyName = 'chkFiltroEsclusivo'
      end
    end
    inherited WR003DettaglioSerbatoioRG: TmeIWRegion
      inherited memRiepilogoKeyCumulo: TmeIWMemo
        TabOrder = 54
      end
    end
  end
  inherited TemplateCodiciSerbatoioRG: TIWTemplateProcessorHTML
    Templates.Default = 'WA077CodiciSerbatoioRG.html'
  end
  object pmnCorsiFormazione: TPopupMenu
    Left = 376
    Top = 688
    object mnuElementiSelezionatiInAlto1: TMenuItem
      Caption = 'Elementi selezionati in alto'
      Hint = 'submit'
      OnClick = mnuElementiSelezionatiInAlto1Click
    end
    object mnuVisualizzaCorsiAnno: TMenuItem
      Caption = 'Visualizza solo i corsi dell'#39'anno'
      Hint = 'submit'
      OnClick = mnuVisualizzaCorsiAnnoClick
    end
  end
end
