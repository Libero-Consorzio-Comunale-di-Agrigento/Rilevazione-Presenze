inherited WA147FRepVincoliIndividuali: TWA147FRepVincoliIndividuali
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actDividiPeriodo: TAction
      Category = 'Azioni'
      Caption = 'btnTaglia'
      Hint = 'Dividi periodo alla data...'
      OnExecute = actDividiPeriodoExecute
    end
    object actInsTuttiDipSel: TAction
      Category = 'Azioni'
      Caption = 'btnInserisciLogin'
      Hint = 'Copia su tutti i dip.selezionati'
      OnExecute = actInsTuttiDipSelExecute
    end
    object actCancTuttiDipSel: TAction
      Category = 'Azioni'
      Caption = 'btnCancellaLogin'
      Hint = 'Cancella da tutti i dip.selezionati'
      OnExecute = actCancTuttiDipSelExecute
    end
    object actVisualizzaAnomalie: TAction
      Category = 'Azioni'
      Caption = 'btnAnomalie'
      Hint = 'Anomalie'
      OnExecute = actVisualizzaAnomalieExecute
    end
  end
end
