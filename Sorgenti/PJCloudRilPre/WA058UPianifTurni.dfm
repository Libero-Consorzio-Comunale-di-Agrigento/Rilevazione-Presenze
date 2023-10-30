inherited WA058FPianifTurni: TWA058FPianifTurni
  Tag = 24
  Width = 595
  Height = 380
  ExplicitWidth = 595
  ExplicitHeight = 380
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    Left = 32
    Top = 234
    ExplicitLeft = 32
    ExplicitTop = 234
  end
  inherited grdStatusBar: TmedpIWStatusBar
    Left = 32
    Top = 172
    ExplicitLeft = 32
    ExplicitTop = 172
  end
  inherited btnShowElabError: TmeIWButton
    Left = 32
    Top = 203
    ExplicitLeft = 32
    ExplicitTop = 203
  end
  inherited AJNInizioElaborazione: TIWAJAXNotifier
    Top = 8
  end
  inherited AJNElaboraElemento: TIWAJAXNotifier
    Top = 64
  end
  inherited AJNMessaggioElaborazione: TIWAJAXNotifier
    Top = 312
  end
  inherited AJNElementoSuccessivo: TIWAJAXNotifier
    Top = 128
  end
  inherited AJNFineCicloElaborazione: TIWAJAXNotifier
    Top = 192
  end
  inherited AJNElaborazioneTerminata: TIWAJAXNotifier
    Top = 256
  end
  inherited AJNMsgElaborazione: TIWAJAXNotifier
    Left = 336
    Top = 16
  end
  object actlstNavigatorBar: TActionList
    Left = 336
    Top = 88
    object actAggiorna: TAction
      Tag = 6
      Category = 'Funzioni'
      Caption = 'btnAggiorna'
      Hint = 'Aggiorna'
    end
    object actRicerca: TAction
      Tag = 1
      Category = 'Funzioni'
      Caption = 'btnCerca'
      Hint = 'Ricerca/Filtra'
    end
    object actEstrai: TAction
      Tag = 12
      Category = 'Funzioni'
      Caption = 'btnStampa'
      Hint = 'Estrai'
    end
    object actPrimo: TAction
      Tag = 2
      Category = 'Selezione'
      Caption = 'btnPrimo'
      Hint = 'Primo'
    end
    object actPrecedente: TAction
      Tag = 3
      Category = 'Selezione'
      Caption = 'btnPrecedente'
      Hint = 'Precedente'
    end
    object actSuccessivo: TAction
      Tag = 4
      Category = 'Selezione'
      Caption = 'btnSuccessivo'
      Hint = 'Successivo'
    end
    object actUltimo: TAction
      Tag = 5
      Category = 'Selezione'
      Caption = 'btnUltimo'
      Hint = 'Ultimo'
    end
    object actVisioneCorrente: TAction
      Tag = 16
      Category = 'Storico'
      Caption = 'btnVisioneCorrente'
      Hint = 'Visione corrente'
    end
    object actVisioneAnnuale: TAction
      Category = 'Storico'
      Caption = 'actVisioneAnnuale'
      Enabled = False
      Hint = 'Visione annuale'
      Visible = False
    end
    object actPrecedenteStorico: TAction
      Tag = 14
      Category = 'Storico'
      Caption = 'btnStoricoPrecedente'
      Hint = 'Storico precedente'
    end
    object actSelezioneStorico: TAction
      Tag = 1000
      Category = 'Storico'
      Caption = 'actSelezioneStorico'
    end
    object actSuccessivoStorico: TAction
      Tag = 15
      Category = 'Storico'
      Caption = 'btnStoricoSuccessivo'
      Hint = 'Storico successivo'
    end
    object actNuovo: TAction
      Tag = 7
      Category = 'Edit'
      Caption = 'btnInserisci'
      Hint = 'Nuovo'
    end
    object actCopiaSu: TAction
      Tag = 13
      Category = 'Edit'
      Caption = 'btnCopia'
      Hint = 'Copia su'
    end
    object actModifica: TAction
      Tag = 8
      Category = 'Edit'
      Caption = 'btnModifica'
      Hint = 'Modifica'
    end
    object actElimina: TAction
      Tag = 9
      Category = 'Edit'
      Caption = 'btnElimina'
      Hint = 'Elimina'
    end
    object actAnnulla: TAction
      Tag = 10
      Category = 'Validazione'
      Caption = 'btnAnnulla'
      Hint = 'Annulla'
    end
    object actConferma: TAction
      Tag = 11
      Category = 'Validazione'
      Caption = 'btnConferma'
      Hint = 'Conferma'
    end
  end
end
