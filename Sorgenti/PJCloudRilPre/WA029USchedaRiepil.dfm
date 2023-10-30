inherited WA029FSchedaRiepil: TWA029FSchedaRiepil
  Tag = 10
  DesignLeft = 8
  DesignTop = 8
  inherited actlstNavigatorBar: TActionList
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actSituazioneBudgetStraordinario: TAction
      Caption = 'btnSituazioneBudgetStraordinario'
      Hint = 'Situazione budget straordinario'
      OnExecute = actSituazioneBudgetStraordinarioExecute
    end
    object actParametriConteggio: TAction
      Caption = 'btnParametriConteggio'
      Hint = 'Parametri di conteggio'
      OnExecute = actParametriConteggioExecute
    end
    object actResidui: TAction
      Caption = 'btnResidui'
      Hint = 'Residui anno precedente'
      OnExecute = actResiduiExecute
    end
  end
end
