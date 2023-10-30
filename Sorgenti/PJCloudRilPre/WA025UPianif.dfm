inherited WA025FPianif: TWA025FPianif
  Tag = 8
  Title = '(WA025) Pianificazioni giornaliere'
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    object actVisualizzaAnomalie: TAction
      Category = 'Azioni Speciali'
      Caption = 'btnAnomalie'
      Hint = 'Anomalie'
      OnExecute = actVisualizzaAnomalieExecute
    end
    object actAcquisizioneTurni: TAction
      Category = 'Azioni Speciali'
      Caption = 'btnAcquisizioneTimbrature'
      Hint = 'Acquisizione turni'
      OnExecute = actAcquisizioneTurniExecute
    end
    object actRegistra: TAction
      Category = 'Azioni'
      Caption = 'btnSalva'
      Hint = 'Registra pianificazione nel periodo'
      OnExecute = actRegistraExecute
    end
    object actCancPianificazione: TAction
      Category = 'Azioni'
      Caption = 'btnCestinoCassa'
      Hint = 'Cancella pianificazione del periodo'
      OnExecute = actCancPianificazioneExecute
    end
  end
end
