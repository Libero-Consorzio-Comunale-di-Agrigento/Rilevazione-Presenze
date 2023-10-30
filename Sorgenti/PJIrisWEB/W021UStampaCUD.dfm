inherited W021FStampaCUD: TW021FStampaCUD
  Tag = 422
  Width = 534
  Height = 272
  HelpType = htKeyword
  HelpKeyword = 'W021P0'
  Title = '(W021) Stampa CUD/CU'
  ExplicitWidth = 534
  ExplicitHeight = 272
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
  end
  object cmbCUD: TmeIWComboBox [8]
    Left = 107
    Top = 201
    Width = 104
    Height = 21
    Css = 'input10'
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
    OnChange = cmbCUDChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 4
    ItemIndex = -1
    FriendlyName = 'cmbCUD'
    NoSelectionText = '-- No Selection --'
  end
  object lblAnnoCUD: TmeIWLabel [9]
    Left = 48
    Top = 202
    Width = 77
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
    ForControl = cmbCUD
    HasTabOrder = False
    FriendlyName = 'lblAnnoCUD'
    Caption = 'CUD/CU del '
    Enabled = True
  end
  object btnStampa: TmeIWButton [10]
    Left = 236
    Top = 199
    Width = 85
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
    Caption = 'Stampa'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnStampa'
    TabOrder = 7
    OnClick = btnAggiornamentoClick
    medpDownloadButton = False
  end
  object lnkIstrCUD: TmeIWLink [11]
    Left = 381
    Top = 201
    Width = 65
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
    FriendlyName = 'lnkIstrCUD'
    OnClick = lnkIstrCUDClick
    TabOrder = 8
    RawText = False
    Caption = 'Istruzioni'
    medpDownloadButton = False
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 336
    Top = 120
  end
end
