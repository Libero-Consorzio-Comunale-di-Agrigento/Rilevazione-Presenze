inherited WA023FTimbrature: TWA023FTimbrature
  Tag = 7
  Width = 786
  Height = 484
  ExplicitWidth = 786
  ExplicitHeight = 484
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 104
    Top = 105
    ExplicitLeft = 104
    ExplicitTop = 105
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 3
    Top = 136
    ExplicitLeft = 3
    ExplicitTop = 136
  end
  inherited btnShowElabError: TmeIWButton
    Left = 104
    Top = 74
    ExplicitLeft = 104
    ExplicitTop = 74
  end
  object lblDataControllo: TmeIWLabel [19]
    Left = 499
    Top = 316
    Width = 99
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
    FriendlyName = 'lblDataControllo'
    Caption = 'lblDataControllo'
    Enabled = True
  end
  object grdCorrezione: TmeIWGrid [20]
    Left = 330
    Top = 235
    Width = 300
    Height = 26
    Css = 'medpToolBar'
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
    Caption = 'grdCorrezione'
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlNone
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdCorrezione'
    ColumnCount = 1
    RowCount = 1
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object imgAnomaliaPrecedente: TmeIWImageFile [21]
    Left = 358
    Top = 267
    Width = 26
    Height = 26
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnAsyncClick = imgAnomaliaPrecedenteAsyncClick
    Cacheable = True
    FriendlyName = 'imgAnomaliaPrecedente'
    ImageFile.Filename = 'img\btnStoricoPrecedente.png'
    medpDownloadButton = False
  end
  object imgAvvioCorrezione: TmeIWImageFile [22]
    Left = 330
    Top = 267
    Width = 26
    Height = 26
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnAsyncClick = imgAvvioCorrezioneAsyncClick
    Cacheable = True
    FriendlyName = 'imgAvvioCorrezione'
    ImageFile.Filename = 'img\btnSuccessivo.png'
    medpDownloadButton = False
  end
  object lblAnomalia: TmeIWLabel [23]
    Left = 499
    Top = 277
    Width = 72
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
    FriendlyName = 'lblAnomalia'
    Caption = 'lblAnomalia'
    RawText = True
    Enabled = True
  end
  object imgAnomaliaSuccessiva: TmeIWImageFile [24]
    Left = 390
    Top = 267
    Width = 27
    Height = 26
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnAsyncClick = imgAnomaliaSuccessivaAsyncClick
    Cacheable = True
    FriendlyName = 'imgAnomaliaPrecedente'
    ImageFile.Filename = 'img\btnStoricoSuccessivo.png'
    medpDownloadButton = False
  end
  object imgCorreggiAnomalia: TmeIWImageFile [25]
    Left = 423
    Top = 267
    Width = 27
    Height = 26
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderOptions.Width = 0
    TabOrder = -1
    UseSize = False
    OnClick = imgCorreggiAnomaliaClick
    Cacheable = True
    FriendlyName = 'imgAnomaliaPrecedente'
    ImageFile.Filename = 'img\btnAmbulanza2.png'
    medpDownloadButton = False
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Left = 672
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Left = 672
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Left = 672
    Top = 344
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Left = 672
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Left = 672
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Left = 672
  end
  inherited actLstComandi: TActionList
    Left = 432
    Top = 184
    object actReset: TAction [4]
      Category = 'conteggi'
      Caption = 'btnRefresh2'
      Hint = 'Reset conteggi'
      OnExecute = actResetExecute
    end
    inherited actAnomalie: TAction
      Category = 'conteggi'
    end
    object actCorrezione: TAction
      Category = 'conteggi'
      Caption = 'btnCheck'
      Hint = 'Correzione anomalie'
      OnExecute = actCorrezioneExecute
    end
    object actStampaCartellino: TAction
      Category = 'comandi'
      Caption = 'btnCartellinoMensile'
      Hint = 'Stampa cartellino'
      OnExecute = actStampaCartellinoExecute
    end
    object actArchiviazioneCartellini: TAction
      Category = 'comandi'
      Caption = 'btnArchiviazioneCartellini'
      Hint = 'Archiviazione cartellini'
      OnExecute = actArchiviazioneCartelliniExecute
    end
    object actElaboraOmesseTimbrature: TAction
      Category = 'comandi'
      Caption = 'btnOmesseTimbrature'
      Hint = 'Elabora omesse timbrature'
      OnExecute = actElaboraOmesseTimbratureExecute
    end
  end
  inherited pmnNuovaTimbratura: TPopupMenu
    Left = 336
    Top = 184
    object mnuInserisciTimb2: TMenuItem
      Caption = 'Inserisci'
      Hint = 'submit'
      OnClick = mnuInserisciTimbClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuAggiornadatacontrollo2: TMenuItem
      Caption = 'Aggiorna data controllo'
      OnClick = mnuAggiornaDataControlloAsyncClick
    end
    object actConteggiServizio1: TMenuItem
      Caption = 'Conteggi di servizio'
      Hint = 'submit'
      OnClick = actConteggiServizioClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object mnuRipristino2: TMenuItem
      Caption = 'Ripristino timbrature originali'
      Hint = 'submit'
      OnClick = mnuRipristinoClick
    end
    object mnuAllineamentoTimbratureUguali2: TMenuItem
      Caption = 'Allineamento timbrature uguali'
      Hint = 'submit'
      OnClick = mnuAllineamentoTimbratureUgualiClick
    end
    object mnuEliminazionetimbratureriscaricate2: TMenuItem
      Caption = 'Eliminazione timbrature riscaricate'
      Hint = 'submit'
      OnClick = mnuEliminazionetimbratureriscaricateClick
    end
  end
  inherited pmnTimbratura: TPopupMenu
    Top = 184
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
    object mnuAggiornaDataControllo: TMenuItem
      Caption = 'Aggiorna data controllo'
      OnClick = mnuAggiornaDataControlloAsyncClick
    end
    object actConteggiServizio: TMenuItem
      Caption = 'Conteggi di servizio'
      Hint = 'submit'
      OnClick = actConteggiServizioClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object mnuRipristino: TMenuItem
      Caption = 'Ripristino timbrature originali'
      Hint = 'submit'
      OnClick = mnuRipristinoClick
    end
    object mnuAllineamentoTimbratureUguali: TMenuItem
      Caption = 'Allineamento timbrature uguali'
      Hint = 'submit'
      OnClick = mnuAllineamentoTimbratureUgualiClick
    end
    object mnuEliminazionetimbratureriscaricate: TMenuItem
      Caption = 'Eliminazione timbrature riscaricate'
      Hint = 'submit'
      OnClick = mnuEliminazionetimbratureriscaricateClick
    end
    object Inforichiesta1: TMenuItem
      Caption = 'Info timbratura'
      Hint = 'submit'
      OnClick = Inforichiesta1Click
    end
  end
  inherited pmnNuovoGiustificativo: TPopupMenu
    Left = 40
    Top = 184
    object mnuInserisciGiustif2: TMenuItem
      Caption = 'Inserisci/cancella'
      Hint = 'submit'
      OnClick = mnuInserisciGiustClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnuAggiornaDataControllo4: TMenuItem
      Caption = 'Aggiorna data controllo'
      OnClick = mnuAggiornaDataControlloAsyncClick
    end
    object actConteggiServizio3: TMenuItem
      Caption = 'Conteggi di servizio'
      Hint = 'submit'
      OnClick = actConteggiServizioClick
    end
  end
  inherited pmnGiustificativo: TPopupMenu
    Left = 144
    Top = 184
    object mnuInserisciGiust: TMenuItem
      Caption = 'Inserisci/cancella'
      Hint = 'submit'
      OnClick = mnuInserisciGiustClick
    end
    object mnuModificaGiust: TMenuItem
      Caption = 'Modifica'
      Hint = 'submit'
      OnClick = mnuModificaGiustClick
    end
    object mnuAccediGiust: TMenuItem
      Caption = 'Accedi'
      Hint = 'submit'
      OnClick = mnuAccediGiustClick
    end
    object actCompetenzeResidui: TMenuItem
      Caption = 'Competenze/Residui'
      Hint = 'submit'
      OnClick = actCompetenzeResiduiClick
    end
    object mnuValidaAssenze: TMenuItem
      Caption = 'Valida assenze'
      Hint = 'submit'
      OnClick = mnuValidaAssenzeClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object mnuAggiornaDataControllo3: TMenuItem
      Caption = 'Aggiorna data controllo'
      OnClick = mnuAggiornaDataControlloAsyncClick
    end
    object actConteggiServizio2: TMenuItem
      Caption = 'Conteggi di servizio'
      Hint = 'submit'
      OnClick = actConteggiServizioClick
    end
    object Inforichiesta2: TMenuItem
      Caption = 'Info giustificativo'
      Hint = 'submit'
      OnClick = Inforichiesta2Click
    end
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 384
    Top = 16
  end
end
