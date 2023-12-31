inherited W020FCambioProfilo: TW020FCambioProfilo
  Tag = 421
  Width = 658
  Height = 332
  HelpType = htKeyword
  HelpKeyword = 'W020P0'
  Title = '(W020) Cambio profilo'
  ExplicitWidth = 658
  ExplicitHeight = 332
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 9
  end
  object edtProfiloAttuale: TmeIWEdit [8]
    Left = 239
    Top = 149
    Width = 210
    Height = 21
    Css = 'input30'
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Editable = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtProfiloAttuale'
    SubmitOnAsyncEvent = True
    TabOrder = 4
    Enabled = False
  end
  object lblProfiloAttuale: TmeIWLabel [9]
    Left = 91
    Top = 149
    Width = 92
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
    ForControl = edtProfiloAttuale
    HasTabOrder = False
    FriendlyName = 'lblProfiloAttuale'
    Caption = 'Profilo attuale:'
    Enabled = True
  end
  object lblProfiloNuovo: TmeIWLabel [10]
    Left = 91
    Top = 195
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
    ForControl = cmbProfiloNuovo
    HasTabOrder = False
    FriendlyName = 'lblProfiloAttuale'
    Caption = 'Nuovo profilo:'
    Enabled = True
  end
  object cmbProfiloNuovo: TmeIWComboBox [11]
    Left = 239
    Top = 194
    Width = 210
    Height = 21
    Css = 'select30'
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
    OnAsyncChange = cmbProfiloNuovoAsyncChange
    OnAsyncKeyPress = cmbProfiloNuovoAsyncChange
    NonEditableAsLabel = True
    SubmitOnAsyncEvent = False
    TabOrder = 6
    ItemIndex = 0
    Items.Strings = (
      '')
    FriendlyName = 'cmbProfiloNuovo'
    NoSelectionText = '-- No Selection --'
  end
  object lblInfoDelega: TmeIWLabel [12]
    Left = 184
    Top = 235
    Width = 137
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
    HasTabOrder = False
    FriendlyName = 'lblProfiloAttuale'
    Caption = '[informazioni_delega]'
    Enabled = True
  end
  object btnConferma: TmeIWButton [13]
    Left = 138
    Top = 283
    Width = 87
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Conferma'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnConferma'
    TabOrder = 7
    OnAsyncClick = btnConfermaAsyncClick
    medpDownloadButton = False
  end
  object btnAnnulla: TmeIWButton [14]
    Left = 256
    Top = 283
    Width = 87
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Annulla'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnConferma'
    TabOrder = 8
    OnClick = btnAnnullaClick
    medpDownloadButton = False
  end
end
