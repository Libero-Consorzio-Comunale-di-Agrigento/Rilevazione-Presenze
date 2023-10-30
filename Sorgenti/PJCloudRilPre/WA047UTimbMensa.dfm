inherited WA047FTimbMensa: TWA047FTimbMensa
  Tag = 27
  DesignLeft = 8
  DesignTop = 8
  inherited btnShowElabError: TmeIWButton
    Left = 27
    Top = 143
    ExplicitLeft = 27
    ExplicitTop = 143
  end
  object btnNuovoAccesso: TmeIWButton [17]
    Left = 344
    Top = 285
    Width = 75
    Height = 25
    Cursor = crAuto
    Css = 'pulsante'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    Caption = 'nuovoAccesso'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnNuovoAccesso'
    ScriptEvents = <>
    TabOrder = 13
    OnClick = btnNuovoAccessoClick
    medpDownloadButton = False
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 392
    Top = 16
  end
  inherited actLstComandi: TActionList
    object actStampa: TAction
      Category = 'comandi'
      Caption = 'btnStampa'
      Hint = 'Stampa'
      OnExecute = actStampaExecute
    end
  end
  inherited pmnNuovaTimbratura: TPopupMenu
    object mnuInserisciTimb1: TMenuItem
      Caption = 'Inserisci'
      Hint = 'submit'
      OnClick = mnuInserisciTimbClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuRipristino1: TMenuItem
      Caption = 'Ripristino timbrature originali'
      Hint = 'submit'
      OnClick = mnuRipristinoClick
    end
    object mnuRegoleConteggio2: TMenuItem
      Caption = 'Regole di conteggio'
      Hint = 'submit'
      OnClick = mnuRegoleConteggioClick
    end
  end
  inherited pmnTimbratura: TPopupMenu
    object mnuInserisciTimb: TMenuItem
      Caption = 'Inserisci'
      Hint = 'submit'
      OnClick = mnuInserisciTimbClick
    end
    object mnuModificaTimb: TMenuItem
      Caption = 'Modifica'
      Hint = 'submit'
      OnClick = mnuModificaTimbClick
    end
    object mnuCancellaTimb: TMenuItem
      Caption = 'Cancella'
      Hint = 'submit'
      OnClick = mnuCancellaTimbClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuRipristino: TMenuItem
      Caption = 'Ripristino timbrature originali'
      Hint = 'submit'
      OnClick = mnuRipristinoClick
    end
    object mnuRegoleConteggio: TMenuItem
      Caption = 'Regole di conteggio'
      Hint = 'submit'
      OnClick = mnuRegoleConteggioClick
    end
  end
  object pmnAccesso: TPopupMenu
    Left = 56
    Top = 208
    object mnuAggiungiAccessi: TMenuItem
      Caption = 'Aggiungi'
      Hint = 'submit'
      OnClick = mnuAggiungiAccessiClick
    end
    object mnuEliminaAccesso: TMenuItem
      Caption = 'Elimina'
      Hint = 'submit'
      OnClick = mnuEliminaAccessoClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mnuRegoleConteggio3: TMenuItem
      Caption = 'Regole di conteggio'
      Hint = 'submit'
      OnClick = mnuRegoleConteggioClick
    end
  end
  object pmnNuovoAccesso: TPopupMenu
    Left = 160
    Top = 208
    object mnuInserisciAccesso: TMenuItem
      Caption = 'Aggiungi'
      Hint = 'submit'
      OnClick = mnuInserisciAccessoClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnuRegoleConteggio4: TMenuItem
      Caption = 'Regole di conteggio'
      Hint = 'submit'
      OnClick = mnuRegoleConteggioClick
    end
  end
  object DCOMConnection: TDCOMConnection
    ServerGUID = '{ABA07A35-402E-4181-9C3A-9B6ECE4C791E}'
    ServerName = 'B028PPrintServer_COM.B028PrintServer'
    ComputerName = 'localhost'
    Left = 288
    Top = 16
  end
end
