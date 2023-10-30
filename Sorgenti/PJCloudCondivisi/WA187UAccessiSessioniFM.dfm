inherited WA187FAccessiSessioniFM: TWA187FAccessiSessioniFM
  inherited IWFrameRegion: TIWRegion
    inherited grdTabella: TmedpIWDBGrid
      Summary = 'Sessioni attive'
    end
  end
  inherited actlstDetailNavBar: TActionList
    object actKillSingola: TAction [0]
      Tag = 17
      Category = 'Sessioni'
      Caption = 'btnKillSingola'
      Hint = 'Termina sessione selezionata'
      OnExecute = actKillSingolaExecute
    end
    object actKillMultipla: TAction [1]
      Tag = 18
      Category = 'Sessioni'
      Caption = 'btnKillMultipla'
      Hint = 'Termina tutte le sessioni'
      OnExecute = actKillMultiplaExecute
    end
    inherited actRicerca: TAction
      Visible = False
    end
    inherited actPrimo: TAction
      Visible = False
    end
    inherited actPrecedente: TAction
      Visible = False
    end
    inherited actSuccessivo: TAction
      Visible = False
    end
    inherited actUltimo: TAction
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
