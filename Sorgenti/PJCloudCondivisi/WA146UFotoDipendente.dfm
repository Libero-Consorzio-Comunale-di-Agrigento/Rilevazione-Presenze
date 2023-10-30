inherited WA146FFotoDipendente: TWA146FFotoDipendente
  Tag = 67
  Title = '(WA146) Foto dipendente'
  DesignLeft = 8
  DesignTop = 8
  object meIWButton1: TmeIWButton [15]
    Left = 224
    Top = 288
    Width = 75
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
    Caption = 'meIWButton1'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'meIWButton1'
    TabOrder = 7
    medpDownloadButton = False
  end
  inherited actlstNavigatorBar: TActionList
    object actApri: TAction
      Category = 'Edit'
      Caption = 'btnApri'
      Enabled = False
      Hint = 'Apri'
      OnExecute = actApriExecute
    end
    object actScaricaDaDB: TAction
      Category = 'Funzioni'
      Caption = 'btnSalvataggio'
      Enabled = False
      Hint = 'Download Immagine'
      OnExecute = actScaricaDaDBExecute
    end
  end
end
