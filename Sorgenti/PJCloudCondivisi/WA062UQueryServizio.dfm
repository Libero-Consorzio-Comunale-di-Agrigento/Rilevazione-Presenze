inherited WA062FQueryServizio: TWA062FQueryServizio
  Tag = 31
  Title = '(WA062) Interrogazioni di servizio'
  DesignLeft = 8
  DesignTop = 8
  inherited edtAJAXFormID: TmeIWEdit
    TabOrder = 7
  end
  object cmbRaggruppamenti: TmeIWComboBox [15]
    Left = 144
    Top = 248
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
    Required = True
    OnChange = cmbRaggruppamentiChange
    UseSize = False
    NonEditableAsLabel = True
    TabOrder = 6
    ItemIndex = -1
    FriendlyName = 'cmbRaggruppamenti'
    NoSelectionText = '-- No Selection --'
  end
  object lblRaggruppamento: TmeIWLabel [16]
    Left = 16
    Top = 249
    Width = 117
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
    FriendlyName = 'lblRaggruppamento'
    Caption = 'Raggruppamento: '
    Enabled = True
  end
  inherited actlstNavigatorBar: TActionList
    Left = 400
    Top = 168
    object actEsegui: TAction
      Caption = 'btnEsegui'
      Hint = 'Esegui'
      OnExecute = actEseguiExecute
    end
    object actPulisci: TAction
      Caption = 'btnClear'
      Hint = 'Pulisci'
      Visible = False
      OnExecute = actPulisciExecute
    end
  end
  object AJW062AvviaElab: TIWAJAXNotifier
    OnNotify = AJW062AvviaElabNotify
    Left = 608
    Top = 80
  end
end
