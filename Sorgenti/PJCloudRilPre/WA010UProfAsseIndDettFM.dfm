inherited WA010FProfAsseIndDettFM: TWA010FProfAsseIndDettFM
  Width = 1027
  Height = 482
  ExplicitWidth = 1027
  ExplicitHeight = 482
  inherited IWFrameRegion: TIWRegion
    Width = 1027
    Height = 482
    ExplicitWidth = 1027
    ExplicitHeight = 482
    object lblUnitaDiMisura: TmeIWLabel
      Left = 24
      Top = 121
      Width = 94
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
      FriendlyName = 'lblAnno'
      Caption = 'Unit'#224' di misura'
      Enabled = True
    end
    object lblRapportiDiLavoroUnificati: TmeIWLabel
      Left = 124
      Top = 121
      Width = 163
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
      FriendlyName = 'lblAnno'
      Caption = 'Rapporti di lavoro unificati'
      Enabled = True
    end
    object lblResiduoFruibile: TmeIWLabel
      Left = 293
      Top = 143
      Width = 136
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
      FriendlyName = 'lblAnno'
      Caption = 'Residuo fruibile fino a'
      Enabled = True
    end
    object dedtResiduoFruibile: TmeIWDBEdit
      Left = 490
      Top = 138
      Width = 121
      Height = 21
      Css = 'input_data_dmy'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 0
      AutoEditable = True
      DataField = 'DATARES'
      PasswordPrompt = False
    end
    object lblVariazioneManuale: TmeIWLabel
      Left = 293
      Top = 165
      Width = 124
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
      FriendlyName = 'lblAnno'
      Caption = 'Variazione manuale'
      Enabled = True
    end
    object dedtVariazioneManuale: TmeIWDBEdit
      Left = 490
      Top = 165
      Width = 121
      Height = 21
      Css = 'input15'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 1
      AutoEditable = True
      DataField = 'Decurtazione'
      PasswordPrompt = False
    end
    object lblPercentualeRetribuzione: TmeIWLabel
      Left = 24
      Top = 287
      Width = 168
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
      FriendlyName = 'lblAnno'
      Caption = 'Percentuale di retribuzione'
      Enabled = True
    end
    object lblCompetenze: TmeIWLabel
      Left = 24
      Top = 259
      Width = 78
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
      FriendlyName = 'lblAnno'
      Caption = 'Competenze'
      Enabled = True
    end
    object dedtCompetenza1: TmeIWDBEdit
      Left = 198
      Top = 256
      Width = 67
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 2
      AutoEditable = True
      DataField = 'Competenza1'
      PasswordPrompt = False
    end
    object dedtRetribuzione1: TmeIWDBEdit
      Left = 198
      Top = 284
      Width = 67
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 3
      AutoEditable = True
      DataField = 'Retribuzione1'
      PasswordPrompt = False
    end
    object dedtRetribuzione2: TmeIWDBEdit
      Left = 271
      Top = 284
      Width = 67
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 4
      AutoEditable = True
      DataField = 'Retribuzione2'
      PasswordPrompt = False
    end
    object dedtCompetenza2: TmeIWDBEdit
      Left = 271
      Top = 256
      Width = 67
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 5
      AutoEditable = True
      DataField = 'Competenza2'
      PasswordPrompt = False
    end
    object dedtRetribuzione3: TmeIWDBEdit
      Left = 344
      Top = 284
      Width = 67
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 6
      AutoEditable = True
      DataField = 'Retribuzione3'
      PasswordPrompt = False
    end
    object dedtCompetenza3: TmeIWDBEdit
      Left = 344
      Top = 256
      Width = 67
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 7
      AutoEditable = True
      DataField = 'Competenza3'
      PasswordPrompt = False
    end
    object dedtRetribuzione4: TmeIWDBEdit
      Left = 417
      Top = 284
      Width = 67
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 8
      AutoEditable = True
      DataField = 'Retribuzione4'
      PasswordPrompt = False
    end
    object dedtCompetenza4: TmeIWDBEdit
      Left = 417
      Top = 256
      Width = 67
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 9
      AutoEditable = True
      DataField = 'Competenza4'
      PasswordPrompt = False
    end
    object dedtCompetenza5: TmeIWDBEdit
      Left = 490
      Top = 256
      Width = 67
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 10
      AutoEditable = True
      DataField = 'Competenza5'
      PasswordPrompt = False
    end
    object dedtRetribuzione5: TmeIWDBEdit
      Left = 490
      Top = 284
      Width = 67
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 11
      AutoEditable = True
      DataField = 'Retribuzione5'
      PasswordPrompt = False
    end
    object dedtCompetenza6: TmeIWDBEdit
      Left = 563
      Top = 256
      Width = 67
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 12
      AutoEditable = True
      DataField = 'Competenza6'
      PasswordPrompt = False
    end
    object dedtRetribuzione6: TmeIWDBEdit
      Left = 563
      Top = 284
      Width = 67
      Height = 21
      Css = 'width5chr'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 13
      AutoEditable = True
      DataField = 'Retribuzione6'
      PasswordPrompt = False
    end
    object lblFascia1: TmeIWLabel
      Left = 198
      Top = 234
      Width = 51
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
      FriendlyName = 'lblAnno'
      Caption = 'Fascia 1'
      Enabled = True
    end
    object lblFascia2: TmeIWLabel
      Left = 271
      Top = 234
      Width = 51
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
      FriendlyName = 'lblAnno'
      Caption = 'Fascia 2'
      Enabled = True
    end
    object lblFascia3: TmeIWLabel
      Left = 344
      Top = 234
      Width = 51
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
      FriendlyName = 'lblAnno'
      Caption = 'Fascia 3'
      Enabled = True
    end
    object lblFascia4: TmeIWLabel
      Left = 417
      Top = 234
      Width = 51
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
      FriendlyName = 'lblAnno'
      Caption = 'Fascia 4'
      Enabled = True
    end
    object lblFascia5: TmeIWLabel
      Left = 490
      Top = 234
      Width = 51
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
      FriendlyName = 'lblAnno'
      Caption = 'Fascia 5'
      Enabled = True
    end
    object lblFascia6: TmeIWLabel
      Left = 563
      Top = 234
      Width = 51
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
      FriendlyName = 'lblAnno'
      Caption = 'Fascia 6'
      Enabled = True
    end
    object lblDescRaggruppamento: TmeIWLabel
      Left = 551
      Top = 99
      Width = 151
      Height = 16
      Css = 'descrizione'
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
      FriendlyName = 'lblRaggruppamento'
      Caption = 'lblDescRaggruppamento'
      Enabled = True
    end
    object dlblRaggruppamento: TmeIWDBLabel
      Left = 421
      Top = 99
      Width = 124
      Height = 16
      Css = 'descrizione'
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
      DataField = 'D_Raggruppamento'
      FriendlyName = 'dlblRaggruppamento'
    end
    object lblDal: TmeIWLabel
      Left = 24
      Top = 72
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
      FriendlyName = 'lblAnno'
      Caption = 'Dal'
      Enabled = True
    end
    object lblAl: TmeIWLabel
      Left = 124
      Top = 72
      Width = 12
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
      FriendlyName = 'lblAnno'
      Caption = 'Al'
      Enabled = True
    end
    object dedtDal: TmeIWDBEdit
      Left = 24
      Top = 94
      Width = 89
      Height = 21
      Css = 'input_data_dmy'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 14
      AutoEditable = True
      DataField = 'DAL'
      PasswordPrompt = False
    end
    object dedtAl: TmeIWDBEdit
      Left = 124
      Top = 94
      Width = 89
      Height = 21
      Css = 'input_data_dmy'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 15
      AutoEditable = True
      DataField = 'AL'
      PasswordPrompt = False
    end
    object drgpUnitaDiMisura: TmeIWDBRadioGroup
      Left = 24
      Top = 143
      Width = 89
      Height = 50
      Css = 'intestazione'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      OnClick = drgpUnitaDiMisuraClick
      SubmitOnAsyncEvent = True
      RawText = False
      TrimValues = True
      AutoEditable = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Layout = glVertical
      DataField = 'UMISURA'
      FriendlyName = 'drgpUnitaDiMisura'
      Values.Strings = (
        'G'
        'O')
      Items.Strings = (
        'Giorni'
        'Ore')
      TabOrder = 16
    end
    object drgpRapportiDiLavoroUnificati: TmeIWDBRadioGroup
      Left = 124
      Top = 143
      Width = 141
      Height = 50
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
      TrimValues = True
      AutoEditable = True
      Editable = True
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      Layout = glVertical
      DataField = 'RAPPORTI_UNITI'
      FriendlyName = 'drdgUnitaDiMisura'
      Values.Strings = (
        'P'
        'A'
        'S'
        'N')
      Items.Strings = (
        'da Profilo'
        'da Anagrafico'
        'Si'
        'No')
      TabOrder = 17
    end
    object lnkRaggruppamento: TmeIWLink
      Left = 293
      Top = 71
      Width = 121
      Height = 17
      Css = 'intestazione'
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
      FriendlyName = 'lnkRaggruppamento'
      OnClick = imgAccediClick
      TabOrder = 18
      RawText = False
      Caption = 'Raggruppamento'
      medpDownloadButton = False
    end
    object lblNote: TmeIWLabel
      Left = 24
      Top = 315
      Width = 28
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
      FriendlyName = 'lblNote'
      Caption = 'Note'
      Enabled = True
    end
    object DBMemo1: TmeIWDBMemo
      Left = 24
      Top = 337
      Width = 606
      Height = 89
      Css = 'width60chr height5'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPadding = False
      StyleRenderOptions.RenderBorder = False
      BGColor = clNone
      Editable = False
      Font.Color = clNone
      Font.Size = 10
      Font.Style = []
      InvisibleBorder = False
      HorizScrollBar = False
      VertScrollBar = True
      Required = False
      TabOrder = 19
      SubmitOnAsyncEvent = True
      AutoEditable = True
      DataField = 'Note'
      FriendlyName = 'DBMemo1'
    end
    object dcmbRaggruppamento: TMedpIWMultiColumnComboBox
      Left = 294
      Top = 94
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
      FriendlyName = 'dcmbRaggruppamento'
      SubmitOnAsyncEvent = True
      TabOrder = 20
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      OnChange = dcmbRaggruppamentoChange
      medpAutoResetItems = True
      CssInputText = 'width10chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object dcmbFamiliari: TMedpIWMultiColumnComboBox
      Left = 487
      Top = 190
      Width = 124
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
      FriendlyName = 'dcmbFamiliari'
      SubmitOnAsyncEvent = True
      TabOrder = 21
      PopUpHeight = 15
      PopUpWidth = 0
      Text = ''
      ColCount = 2
      Items = <>
      ColumnTitles.Visible = False
      medpAutoResetItems = True
      CssInputText = 'width15chr'
      LookupColumn = 0
      CodeColumn = 0
    end
    object lblFamiliari: TmeIWLabel
      Left = 294
      Top = 192
      Width = 200
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
      FriendlyName = 'lblAnno'
      Caption = 'Significativa solo per il familiare'
      Enabled = True
    end
    object dedtVariazFerieSol: TmeIWDBEdit
      Left = 770
      Top = 165
      Width = 121
      Height = 21
      Css = 'input15'
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
      FriendlyName = 'dedtAnno'
      SubmitOnAsyncEvent = True
      TabOrder = 22
      AutoEditable = True
      DataField = 'VARIAZ_FERIESOL'
      PasswordPrompt = False
    end
    object lblVariazFerieSol: TmeIWLabel
      Left = 629
      Top = 170
      Width = 146
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
      FriendlyName = 'lblAnno'
      Caption = 'Variazione ferie solidali'
      Enabled = False
    end
  end
  inherited TemplateProcessor: TIWTemplateProcessorHTML
    Templates.Default = 'WA010FProfAsseIndDettFM.html'
  end
end
